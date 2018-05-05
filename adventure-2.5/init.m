#include "misc.h"
#include "main.h"
#include "share.h"
#include "funcs.h"
#include <stdio.h>



static int raw_init(void);
static int finish_init(void);
static void report(void);
static int quick_save(void);
static int quick_init(void);
static int quick_io(void);


/*
 * INITIALISATION
 */

/*  CURRENT LIMITS:
 *     12500 WORDS OF MESSAGE TEXT (LINES_ADV, LINSIZ).
 *	885 TRAVEL OPTIONS (TRAVEL, TRVSIZ).
 *	330 VOCABULARY WORDS (KTAB, ATAB, TABSIZ).
 *	185 LOCATIONS (LTEXT, STEXT, KEY, COND, ABB, ATLOC, LOCSND, LOCSIZ).
 *	100 OBJECTS (PLAC, PLACE, FIXD, FIXED, LINK (TWICE), PTEXT, PROP,
 *                    OBJSND, OBJTXT).
 *	 35 "ACTION" VERBS (ACTSPK, VRBSIZ).
 *	277 RANDOM MESSAGES (RTEXT, RTXSIZ).
 *	 12 DIFFERENT PLAYER CLASSIFICATIONS (CTEXT, CVAL, CLSMAX).
 *	 20 HINTS (HINTLC, HINTED, HINTS, HNTSIZ).
 *         5 "# OF TURNS" THRESHHOLDS (TTEXT, TRNVAL, TRNSIZ).
 *  THERE ARE ALSO LIMITS WHICH CANNOT BE EXCEEDED DUE TO THE STRUCTURE OF
 *  THE DATABASE.  (E.G., THE VOCABULARY USES N/1000 TO DETERMINE WORD TYPE,
 *  SO THERE CAN'T BE MORE THAN 1000 WORDS.)  THESE UPPER LIMITS ARE:
 *	1000 NON-SYNONYMOUS VOCABULARY WORDS
 *	300 LOCATIONS
 *	100 OBJECTS */


/*  DESCRIPTION OF THE DATABASE FORMAT
 *
 *
 *  THE DATA FILE CONTAINS SEVERAL SECTIONS.  EACH BEGINS WITH A LINE CONTAINING
 *  A NUMBER IDENTIFYING THE SECTION, AND ENDS WITH A LINE CONTAINING "-1".
 *
 *  SECTION 1: LONG FORM DESCRIPTIONS.  EACH LINE CONTAINS A LOCATION NUMBER,
 *	A TAB, AND A LINE OF TEXT.  THE SET OF (NECESSARILY ADJACENT) LINES_ADV
 *	WHOSE NUMBERS ARE X FORM THE LONG DESCRIPTION OF LOCATION X.
 *  SECTION 2: SHORT FORM DESCRIPTIONS.  SAME FORMAT AS LONG FORM.  NOT ALL
 *	PLACES HAVE SHORT DESCRIPTIONS.
 *  SECTION 3: TRAVEL TABLE.  EACH LINE CONTAINS A LOCATION NUMBER (X), A SECOND
 *	LOCATION NUMBER (Y), AND A LIST OF MOTION NUMBERS (SEE SECTION 4).
 *	EACH MOTION REPRESENTS A VERB WHICH WILL GO TO Y IF CURRENTLY AT X.
 *	Y, IN TURN, IS INTERPRETED AS FOLLOWS.  LET M=Y/1000, N=Y MOD 1000.
 *		IF N<=300	IT IS THE LOCATION TO GO TO.
 *		IF 300<N<=500	N-300 IS USED IN A COMPUTED GOTO TO
 *					A SECTION OF SPECIAL CODE.
 *		IF N>500	MESSAGE N-500 FROM SECTION 6 IS PRINTED,
 *					AND HE STAYS WHEREVER HE IS.
 *	MEANWHILE, M SPECIFIES THE CONDITIONS ON THE MOTION.
 *		IF M=0		IT'S UNCONDITIONAL.
 *		IF 0<M<100	IT IS DONE WITH M% PROBABILITY.
 *		IF M=100	UNCONDITIONAL, BUT FORBIDDEN TO DWARVES.
 *		IF 100<M<=200	HE MUST BE CARRYING OBJECT M-100.
 *		IF 200<M<=300	MUST BE CARRYING OR IN SAME ROOM AS M-200.
 *		IF 300<M<=400	PROP(M MOD 100) MUST *NOT* BE 0.
 *		IF 400<M<=500	PROP(M MOD 100) MUST *NOT* BE 1.
 *		IF 500<M<=600	PROP(M MOD 100) MUST *NOT* BE 2, ETC.
 *	IF THE CONDITION (IF ANY) IS NOT MET, THEN THE NEXT *DIFFERENT*
 *	"DESTINATION" VALUE IS USED (UNLESS IT FAILS TO MEET *ITS* CONDITIONS,
 *	IN WHICH CASE THE NEXT IS FOUND, ETC.).  TYPICALLY, THE NEXT DEST WILL
 *	BE FOR ONE OF THE SAME VERBS, SO THAT ITS ONLY USE IS AS THE ALTERNATE
 *	DESTINATION FOR THOSE VERBS.  FOR INSTANCE:
 *		15	110022	29	31	34	35	23	43
 *		15	14	29
 *	THIS SAYS THAT, FROM LOC 15, ANY OF THE VERBS 29, 31, ETC., WILL TAKE
 *	HIM TO 22 IF HE'S CARRYING OBJECT 10, AND OTHERWISE WILL GO TO 14.
 *		11	303008	49
 *		11	9	50
 *	THIS SAYS THAT, FROM 11, 49 TAKES HIM TO 8 UNLESS PROP(3)=0, IN WHICH
 *	CASE HE GOES TO 9.  VERB 50 TAKES HIM TO 9 REGARDLESS OF PROP(3).
 *
 *  SECTION 4: VOCABULARY.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND A
 *	FIVE-LETTER WORD.  CALL M=N/1000.  IF M=0, THEN THE WORD IS A MOTION
 *	VERB FOR USE IN TRAVELLING (SEE SECTION 3).  ELSE, IF M=1, THE WORD IS
 *	AN OBJECT.  ELSE, IF M=2, THE WORD IS AN ACTION VERB (SUCH AS "CARRY"
 *	OR "ATTACK").  ELSE, IF M=3, THE WORD IS A SPECIAL CASE VERB (SUCH AS
 *	"DIG") AND N MOD 1000 IS AN INDEX INTO SECTION 6.  OBJECTS FROM 50 TO
 *	(CURRENTLY, ANYWAY) 79 ARE CONSIDERED TREASURES (FOR PIRATE, CLOSEOUT).
 *
 *  SECTION 5: OBJECT DESCRIPTIONS.  EACH LINE CONTAINS A NUMBER (N), A TAB,
 *	AND A MESSAGE.  IF N IS FROM 1 TO 100, THE MESSAGE IS THE "INVENTORY"
 *	MESSAGE FOR OBJECT N.  OTHERWISE, N SHOULD BE 000, 100, 200, ETC., AND
 *	THE MESSAGE SHOULD BE THE DESCRIPTION OF THE PRECEDING OBJECT WHEN ITS
 *	PROP VALUE IS N/100.  THE N/100 IS USED ONLY TO DISTINGUISH MULTIPLE
 *	MESSAGES FROM MULTI-LINE MESSAGES; THE PROP INFO ACTUALLY REQUIRES ALL
 *	MESSAGES FOR AN OBJECT TO BE PRESENT AND CONSECUTIVE.  PROPERTIES WHICH
 *	PRODUCE NO MESSAGE SHOULD BE GIVEN THE MESSAGE ">$<".
 *
 *  SECTION 6: ARBITRARY MESSAGES.  SAME FORMAT AS SECTIONS 1, 2, AND 5, EXCEPT
 *	THE NUMBERS BEAR NO RELATION TO ANYTHING (EXCEPT FOR SPECIAL VERBS
 *	IN SECTION 4).
 *
 *  SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
 *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
 *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
 *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
 *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
 *  SECTION 8: ACTION DEFAULTS.  EACH LINE CONTAINS AN "ACTION-VERB" NUMBER AND
 *	THE INDEX (IN SECTION 6) OF THE DEFAULT MESSAGE FOR THE VERB.
 *  SECTION 9: LOCATION ATTRIBUTES.  EACH LINE CONTAINS A NUMBER (N) AND UP TO
 *	20 LOCATION NUMBERS.  BIT N (WHERE 0 IS THE UNITS BIT) IS SET IN
 *	COND(LOC) FOR EACH LOC GIVEN.  THE COND BITS CURRENTLY ASSIGNED ARE:
 *		0	LIGHT
 *		1	IF BIT 2 IS ON: ON FOR OIL, OFF FOR WATER
 *		2	LIQUID ASSET, SEE BIT 1
 *		3	PIRATE DOESN'T GO HERE UNLESS FOLLOWING PLAYER
 *		4	CANNOT USE "BACK" TO MOVE AWAY
 *	BITS PAST 10 INDICATE AREAS OF INTEREST TO "HINT" ROUTINES:
 *		11	TRYING TO GET INTO CAVE
 *		12	TRYING TO CATCH BIRD
 *		13	TRYING TO DEAL WITH SNAKE
 *		14	LOST IN MAZE
 *		15	PONDERING DARK ROOM
 *		16	AT WITT'S END
 *		17	CLIFF WITH URN
 *		18	LOST IN FOREST
 *		19	TRYING TO DEAL WITH OGRE
 *		20	FOUND ALL TREASURES EXCEPT JADE
 *	COND(LOC) IS SET TO 2, OVERRIDING ALL OTHER BITS, IF LOC HAS FORCED
 *	MOTION.
 *  SECTION 10: CLASS MESSAGES.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND A
 *	MESSAGE DESCRIBING A CLASSIFICATION OF PLAYER.  THE SCORING SECTION
 *	SELECTS THE APPROPRIATE MESSAGE, WHERE EACH MESSAGE IS CONSIDERED TO
 *	APPLY TO PLAYERS WHOSE SCORES ARE HIGHER THAN THE PREVIOUS N BUT NOT
 *	HIGHER THAN THIS N.  NOTE THAT THESE SCORES PROBABLY CHANGE WITH EVERY
 *	MODIFICATION (AND PARTICULARLY EXPANSION) OF THE PROGRAM.
 *  SECTION 11: HINTS.  EACH LINE CONTAINS A HINT NUMBER (ADD 10 TO GET COND
 *	BIT; SEE SECTION 9), THE NUMBER OF TURNS HE MUST BE AT THE RIGHT LOC(S)
 *	BEFORE TRIGGERING THE HINT, THE POINTS DEDUCTED FOR TAKING THE HINT,
 *	THE MESSAGE NUMBER (SECTION 6) OF THE QUESTION, AND THE MESSAGE NUMBER
 *	OF THE HINT.  THESE VALUES ARE STASHED IN THE "HINTS" ARRAY.  HNTMAX IS
 *	SET TO THE MAX HINT NUMBER (<= HNTSIZ).
 *  SECTION 12: UNUSED IN THIS VERSION.
 *  SECTION 13: SOUNDS AND TEXT.  EACH LINE CONTAINS EITHER 2 OR 3 NUMBERS.  IF
 *	2 (CALL THEM N AND S), N IS A LOCATION AND MESSAGE ABS(S) FROM SECTION
 *	6 IS THE SOUND HEARD THERE.  IF S<0, THE SOUND THERE DROWNS OUT ALL
 *	OTHER NOISES.  IF 3 NUMBERS (CALL THEM N, S, AND T), N IS AN OBJECT
 *	NUMBER AND S+PROP(N) IS THE PROPERTY MESSAGE (FROM SECTION 5) IF HE
 *	LISTENS TO THE OBJECT, AND T+PROP(N) IS THE TEXT IF HE READS IT.  IF
 *	S OR T IS -1, THE OBJECT HAS NO SOUND OR TEXT, RESPECTIVELY.  NEITHER
 *	S NOR T IS ALLOWED TO BE 0.
 *  SECTION 14: TURN THRESHHOLDS.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND
 *	A MESSAGE BERATING THE PLAYER FOR TAKING SO MANY TURNS.  THE MESSAGES
 *	MUST BE IN THE PROPER (ASCENDING) ORDER.  THE MESSAGE GETS PRINTED IF
 *	THE PLAYER EXCEEDS N MOD 100000 TURNS, AT WHICH TIME N/100000 POINTS
 *	GET DEDUCTED FROM HIS SCORE.
 *  SECTION 0: END OF DATABASE. */

/*  THE VARIOUS MESSAGES (SECTIONS 1, 2, 5, 6, ETC.) MAY INCLUDE CERTAIN
 *  SPECIAL CHARACTER SEQUENCES TO DENOTE THAT THE PROGRAM MUST PROVIDE
 *  PARAMETERS TO INSERT INTO A MESSAGE WHEN THE MESSAGE IS PRINTED.  THESE
 *  SEQUENCES ARE:
 *	%S = THE LETTER 'S' OR NOTHING (IF A GIVEN VALUE IS EXACTLY 1)
 *	%W = A WORD (UP TO 10 CHARACTERS)
 *	%L = A WORD MAPPED TO LOWER-CASE LETTERS
 *	%U = A WORD MAPPED TO UPPER-CASE LETTERS
 *	%C = A WORD MAPPED TO LOWER-CASE, FIRST LETTER CAPITALISED
 *	%T = SEVERAL WORDS OF TEXT, ENDING WITH A WORD OF -1
 *	%1 = A 1-DIGIT NUMBER
 *	%2 = A 2-DIGIT NUMBER
 *	...
 *	%9 = A 9-DIGIT NUMBER
 *	%B = VARIABLE NUMBER OF BLANKS
 *	%! = THE ENTIRE MESSAGE SHOULD BE SUPPRESSED */

void initialise(void) {
	printf("Initialising...\n");
	if(!quick_init())
    {
        raw_init();
        report();
        quick_save();
        
    }
	finish_init();
}

static int raw_init(void ) {
    printf("Couldn't find adventure.data, using adventure.text...\n");

/*  CLEAR OUT THE VARIOUS TEXT-POINTER ARRAYS.  ALL TEXT IS STORED IN ARRAY
 *  LINES_ADV; EACH LINE IS PRECEDED BY A WORD POINTING TO THE NEXT POINTER (I.E.
 *  THE WORD FOLLOWING THE END OF THE LINE).  THE POINTER IS NEGATIVE IF THIS IS
 *  FIRST LINE OF A MESSAGE.  THE TEXT-POINTER ARRAYS CONTAIN INDICES OF
 *  POINTER-WORDS IN LINES_ADV.  STEXT(N) IS SHORT DESCRIPTION OF LOCATION N.
 *  LTEXT(N) IS LONG DESCRIPTION.  PTEXT(N) POINTS TO MESSAGE FOR PROP(N)=0.
 *  SUCCESSIVE PROP MESSAGES ARE FOUND BY CHASING POINTERS.  RTEXT CONTAINS
 *  SECTION 6'S STUFF.  CTEXT(N) POINTS TO A PLAYER-CLASS MESSAGE.  TTEXT IS FOR
 *  SECTION 14.  WE ALSO CLEAR COND (SEE DESCRIPTION OF SECTION 9 FOR DETAILS). */

	
    for (I=1; I<=300; I++)
    {
        if(I <= 100)PTEXT[I]=0;
        if(I <= RTXSIZ)RandomSection6Texts[I]=0;
        if(I <= CLSMAX)CTEXT[I]=0;
        if(I <= 100)OBJSND[I]=0;
        if(I <= 100)OBJTXT[I]=0;
        if(I > LOCSIZ) break;
        STEXT[I]=0;
        LTEXT[I]=0;
        COND[I]=0;
        KEY[I]=0;
        LOCSND[I]=0;
    
    } /* end loop */

	LINUSE=1;
	TRVS=1;
	CLSSES=0;
	TRNVLS=0;

    
    
    
    
    
/*  START NEW DATA SECTION.  SECT IS THE SECTION NUMBER. */

	
//    char a;
//    char *tab_line=malloc(200);
//    char *line = malloc(200);
//    int file_position=0;
//    uint8_t *tab_file=malloc(sizeof(uint8_t)*100);
    //NSInputStream *stream_file = [[NSInputStream alloc] initWithFileAtPath:@"adventure.text"];
    
    //[stream_file initWithFileAtPath:@"adventure.text"];
    
    //[stream_file read:tab_file maxLength:10U];
    
//    NSLog(@"%s",tab_file);
    

L1002: SECT=GETNUM(1);
    OLDLOC= -1;
    //NSLog(@" section -> %ld ",SECT);
    
//    NSString *whole_file = [NSString stringWithContentsOfFile:@"adventure.text" encoding:NSASCIIStringEncoding error:nil];
//
//    printf("%s",[whole_file cStringUsingEncoding:NSASCIIStringEncoding]);
    
    
	switch (SECT)
    { case 0: return(0);
        case 1: goto L1004;
        case 2: goto L1004;
        case 3: goto L1030;
        case 4: goto L1040;
        case 5: goto L1004;
        case 6: goto L1004;
        case 7:
            /*  READ IN THE INITIAL LOCATIONS FOR EACH OBJECT.  ALSO THE IMMOVABILITY INFO.
             *  PLAC CONTAINS INITIAL LOCATIONS OF OBJECTS.  FIXD IS -1 FOR IMMOVABLE
             *  OBJECTS (INCLUDING THE SNAKE), OR = SECOND LOC FOR TWO-PLACED OBJECTS. */
            
            OBJ = 0;
            while (OBJ != -1)
            {
                
                PLAC[OBJ]=GETNUM(0);
                FIXD[OBJ]=GETNUM(0);
                OBJ=GETNUM(1);
            }
            goto L1002;
            
        case 8:
            /*  READ DEFAULT MESSAGE NUMBERS FOR ACTION VERBS, STORE IN ACTSPK. */
            VERB=GETNUM(1);
            if(VERB == -1) goto L1002;
            ACTSPK[VERB]=GETNUM(0);
            
        case 9: goto L1070;
        case 10: goto L1004;
        case 11: goto L1080;
        case 12: break;
        case 13: goto L1090;
        case 14: goto L1004;
            
    }
/*	      (0)  (1)  (2)  (3)  (4)  (5)  (6)  (7)  (8)  (9)
 *	     (10) (11) (12) (13) (14) */
	BUG(9);

/*  SECTIONS 1, 2, 5, 6, 10, 14.  READ MESSAGES AND SET UP POINTERS. */

    
    
L1004:	KK=LINUSE;
L1005:	LINUSE=KK;
	LOC=GETNUM(1);
	if(LineLength >= LinePosition+70)BUG(0);
	if(LOC == -1) goto L1002;
	if(LineLength < LinePosition)BUG(1);
L1006:	KK=KK+1;
	if(KK >= LINSIZ)BUG(2);
	LINES_ADV[KK]=GETTXT(FALSE,FALSE,FALSE,KK);
    //printf("%ld \n",LINES_ADV[KK]);
	if(LINES_ADV[KK] != -1) goto L1006;
	LINES_ADV[LINUSE]=KK;
	if(LOC == OLDLOC) goto L1005;
	OLDLOC=LOC;
	LINES_ADV[LINUSE]= -KK;
	if(SECT == 14) goto L1014;
	if(SECT == 10) goto L1012;
    if(SECT == 6)
    {
        if(LOC > RTXSIZ)BUG(6);
        RandomSection6Texts[LOC]=LINUSE;
        goto L1005;
    }
    //section for objects messages
    if(SECT == 5)
    {
        if(LOC > 0 && LOC <= 100)PTEXT[LOC]=LINUSE;
        goto L1005;
    }
	if(LOC > LOCSIZ) BUG(10);
    if(SECT == 1)
    {
        LTEXT[LOC]=LINUSE;
        goto L1005;
    }

	STEXT[LOC]=LINUSE;
	 goto L1005;

    
  
L1012:	CLSSES=CLSSES+1;
	if(CLSSES > CLSMAX)BUG(11);
	CTEXT[CLSSES]=LINUSE;
	CVAL[CLSSES]=LOC;
	 goto L1005;

L1014:	TRNVLS=TRNVLS+1;
	if(TRNVLS > TRNSIZ)BUG(11);
	TTEXT[TRNVLS]=LINUSE;
	TRNVAL[TRNVLS]=LOC;
	 goto L1005;

/*  THE STUFF FOR SECTION 3 IS ENCODED HERE.  EACH "FROM-LOCATION" GETS A
 *  CONTIGUOUS SECTION OF THE "TRAVEL" ARRAY.  EACH ENTRY IN TRAVEL IS
 *  NEWLOC*1000 + KEYWORD (FROM SECTION 4, MOTION VERBS), AND IS NEGATED IF
 *  THIS IS THE LAST ENTRY FOR THIS LOCATION.  KEY(N) IS THE INDEX IN TRAVEL
 *  OF THE FIRST OPTION AT LOCATION N. */

L1030:	LOC=GETNUM(1);
	if(LOC == -1) goto L1002;
	NEWLOC=GETNUM(0);
	if(KEY[LOC] != 0) goto L1033;
	KEY[LOC]=TRVS;
	 goto L1035;
L1033:	TRVS--; TRAVEL[TRVS]= -TRAVEL[TRVS]; TRVS++;
L1035:	L=GETNUM(0);
	if(L == 0) goto L1039;
	TRAVEL[TRVS]=NEWLOC*1000+L;
	TRVS=TRVS+1;
	if(TRVS == TRVSIZ)BUG(3);
	 goto L1035;
L1039:	TRVS--; TRAVEL[TRVS]= -TRAVEL[TRVS]; TRVS++;
	 goto L1030;

/*  HERE WE READ IN THE VOCABULARY.  KTAB(N) IS THE WORD NUMBER, ATAB(N) IS
 *  THE CORRESPONDING WORD.  THE -1 AT THE END OF SECTION 4 IS LEFT IN KTAB
 *  AS AN END-MARKER.  THE WORDS ARE GIVEN A MINIMAL HASH TO MAKE DECIPHERING
 *  THE CORE-IMAGE HARDER.  (WE DON'T USE GETTXT'S HASH SINCE THAT WOULD FORCE
 *  US TO HASH EACH INPUT LINE TO MAKE COMPARISONS WORK, AND THAT IN TURN
 *  WOULD MAKE IT HARDER TO DETECT PARTICULAR INPUT WORDS.) */

L1040:	J=10000;
	/* 1042 */
    for (TABNDX=1; TABNDX<=TABSIZ; TABNDX++)
    {
        KTAB[TABNDX]=GETNUM(1);
        if(KTAB[TABNDX] == -1)
        {
            
            goto L1002;
        }
        J=J+7;
        ATAB[TABNDX]=GETTXT(TRUE,TRUE,TRUE,0)+J*J;
        //printf("%ld -> %ld ",TABNDX,ATAB[TABNDX]);
    } /* end loop */
	BUG(4);






/*  READ INFO ABOUT AVAILABLE LIQUIDS AND OTHER CONDITIONS, STORE IN COND. */

L1070:	K=GETNUM(1);
	if(K == -1) goto L1002;
L1071:	LOC=GETNUM(0);
	if(LOC == 0) goto L1070;
	if(CNDBIT(LOC,K)) BUG(8);
	COND[LOC]=COND[LOC]+SETBIT(K);
	 goto L1071;

/*  READ DATA FOR HINTS. */

L1080:	HNTMAX=0;
L1081:	K=GETNUM(1);
	if(K == -1) goto L1002;
	if(K <= 0 || K > HNTSIZ)BUG(7);
	/* 1083 */ for (I=1; I<=4; I++) {
L1083:	HINTS[K][I] =GETNUM(0);
	} /* end loop */
	HNTMAX=(HNTMAX>K ? HNTMAX : K);
	 goto L1081;

/*  READ THE SOUND/TEXT INFO, STORE IN OBJSND, OBJTXT, LOCSND. */

L1090:	K=GETNUM(1);
	if(K == -1) goto L1002;
	KK=GETNUM(0);
	I=GETNUM(0);
	if(I == 0) goto L1092;
	OBJSND[K]=(KK>0 ? KK : 0);
	OBJTXT[K]=(I>0 ? I : 0);
	 goto L1090;

L1092:	LOCSND[K]=KK;
	 goto L1090;
    
    return 0;
}

/*  FINISH CONSTRUCTING INTERNAL DATA FORMAT */

/*  HAVING READ IN THE DATABASE, CERTAIN THINGS ARE NOW CONSTRUCTED.  PROPS ARE
 *  SET TO ZERO.  WE FINISH SETTING UP COND BY CHECKING FOR FORCED-MOTION TRAVEL
 *  ENTRIES.  THE PLAC AND FIXD ARRAYS ARE USED TO SET UP ATLOC(N) AS THE FIRST
 *  OBJECT AT LOCATION N, AND LINK(OBJ) AS THE NEXT OBJECT AT THE SAME LOCATION
 *  AS OBJ.  (OBJ>100 INDICATES THAT FIXED(OBJ-100)=LOC; LINK(OBJ) IS STILL THE
 *  CORRECT LINK TO USE.)  ABB IS ZEROED; IT CONTROLS WHETHER THE ABBREVIATED
 *  DESCRIPTION IS PRINTED.  COUNTS MOD 5 UNLESS "LOOK" IS USED. */

static int finish_init()
{
    
    for (I=1; I<=100; I++)
    {
        PLACE[I]=0;
        PROP[I]=0;
        LINK[I]=0;
        long x = I+100;
        LINK[x]=0;
    }
    
    for (I=1; I<=LOCSIZ; I++)
    {
        ABB[I]=0;
        if(LTEXT[I] == 0 || KEY[I] == 0) goto L1102;
        K=KEY[I];
        if(fmod(labs(TRAVEL[K]),1000) == 1)COND[I]=2;
    L1102:	ATLOC[I]=0;
    } /* end loop */
    
    /*  SET UP THE ATLOC AND LINK ARRAYS AS DESCRIBED ABOVE.  WE'LL USE THE DROP
     *  SUBROUTINE, WHICH PREFACES NEW OBJECTS ON THE LISTS.  SINCE WE WANT THINGS
     *  IN THE OTHER ORDER, WE'LL RUN THE LOOP BACKWARDS.  IF THE OBJECT IS IN TWO
     *  LOCS, WE DROP IT TWICE.  THIS ALSO SETS UP "PLACE" AND "FIXED" AS COPIES OF
     *  "PLAC" AND "FIXD".  ALSO, SINCE TWO-PLACED OBJECTS ARE TYPICALLY BEST
     *  DESCRIBED LAST, WE'LL DROP THEM FIRST. */
    
    for (I=1; I<=100; I++) {
        K=101-I;
        if(FIXD[K] <= 0) goto L1106;
        DROP(K+100,FIXD[K]);
        DROP(K,PLAC[K]);
    L1106:	/*etc*/ ;
    } /* end loop */
    
    /* 1107 */
    for (I=1; I<=100; I++)
    {
        K=101-I;
        FIXED[K]=FIXD[K];
        if(PLAC[K] != 0 && FIXD[K] <= 0)DROP(K,PLAC[K]);
    } /* end loop */
    
    /*  TREASURES, AS NOTED EARLIER, ARE OBJECTS 50 THROUGH MAXTRS (CURRENTLY 79).
     *  THEIR PROPS ARE INITIALLY -1, AND ARE SET TO 0 THE FIRST TIME THEY ARE
     *  DESCRIBED.  TALLY KEEPS TRACK OF HOW MANY ARE NOT YET FOUND, SO WE KNOW
     *  WHEN TO CLOSE THE CAVE. */
    
    MAXTRS=79;
    TALLY=0;
    
    for (I=50; I<=MAXTRS; I++)
    {
        if(PTEXT[I] != 0)PROP[I]= -1;
        TALLY=TALLY-PROP[I];
    } /* end loop */
    
    /*  CLEAR THE HINT STUFF.  HINTLC(I) IS HOW LONG HE'S BEEN AT LOC WITH COND BIT
     *  I.  HINTED(I) IS TRUE IFF HINT I HAS BEEN USED. */
    
    for (I=1; I<=HNTMAX; I++)
    {
        HINTED[I]=FALSE;
        HINTLC[I]=0;
    } /* end loop */
    
    /*  DEFINE SOME HANDY MNEMONICS.  THESE CORRESPOND TO OBJECT NUMBERS. */
    
    AXE=VOCWRD(12405,1);
    BATTER=VOCWRD(201202005,1);
    BEAR=VOCWRD(2050118,1);
    BIRD=VOCWRD(2091804,1);
    BLOOD=VOCWRD(212151504,1);
    BOTTLE=VOCWRD(215202012,1);
    CAGE=VOCWRD(3010705,1);
    CAVITY=VOCWRD(301220920,1);
    CHASM=VOCWRD(308011913,1);
    CLAM=VOCWRD(3120113,1);
    DOOR=VOCWRD(4151518,1);
    DRAGON=VOCWRD(418010715,1);
    DWARF=VOCWRD(423011806,1);
    FISSUR=VOCWRD(609191921,1);
    FOOD=VOCWRD(6151504,1);
    GRATE=VOCWRD(718012005,1);
    KEYS=VOCWRD(11052519,1);
    KNIFE=VOCWRD(1114090605,1);
    LAMP=VOCWRD(12011316,1);
    MAGZIN=VOCWRD(1301070126,1);
    MESSAG=VOCWRD(1305191901,1);
    MIRROR=VOCWRD(1309181815,1);
    OGRE=VOCWRD(15071805,1);
    OIL=VOCWRD(150912,1);
    OYSTER=VOCWRD(1525192005,1);
    PILLOW=VOCWRD(1609121215,1);
    PLANT=VOCWRD(1612011420,1);
    PLANT2=PLANT+1;
    RESER=VOCWRD(1805190518,1);
    ROD=VOCWRD(181504,1);
    ROD2=ROD+1;
    SIGN=VOCWRD(19090714,1);
    SNAKE=VOCWRD(1914011105,1);
    STEPS=VOCWRD(1920051619,1);
    TROLL=VOCWRD(2018151212,1);
    TROLL2=TROLL+1;
    URN=VOCWRD(211814,1);
    VEND=VOCWRD(1755140409,1);
    VOLCAN=VOCWRD(1765120301,1);
    WATER=VOCWRD(1851200518,1);
    
    /*  OBJECTS FROM 50 THROUGH WHATEVER ARE TREASURES.  HERE ARE A FEW. */
    
    AMBER=VOCWRD(113020518,1);
    CHAIN=VOCWRD(308010914,1);
    CHEST=VOCWRD(308051920,1);
    COINS=VOCWRD(315091419,1);
    EGGS=VOCWRD(5070719,1);
    EMRALD=VOCWRD(513051801,1);
    JADE=VOCWRD(10010405,1);
    NUGGET=VOCWRD(7151204,1);
    PEARL=VOCWRD(1605011812,1);
    PYRAM=VOCWRD(1625180113,1);
    RUBY=VOCWRD(18210225,1);
    RUG=VOCWRD(182107,1);
    SAPPH=VOCWRD(1901161608,1);
    TRIDNT=VOCWRD(2018090405,1);
    VASE=VOCWRD(22011905,1);
    
    /*  THESE ARE MOTION-VERB NUMBERS. */
    
    BACK=VOCWRD(2010311,0);
    CAVE=VOCWRD(3012205,0);
    DPRSSN=VOCWRD(405161805,0);
    ENTER_ADV=VOCWRD(514200518,0);
    ENTRNC=VOCWRD(514201801,0);
    LOOK=VOCWRD(12151511,0);
    NUL=VOCWRD(14211212,0);
    STREAM=VOCWRD(1920180501,0);
    
    /*  AND SOME ACTION VERBS. */
    
    FIND_ADV=VOCWRD(6091404,2);
    INVENT=VOCWRD(914220514,2);
    LOCK=VOCWRD(12150311,2);
    SAY=VOCWRD(190125,2);
    THROW=VOCWRD(2008181523,2);
    
    /*  INITIALISE THE DWARVES.  DLOC IS LOC OF DWARVES, HARD-WIRED IN.  ODLOC IS
     *  PRIOR LOC OF EACH DWARF, INITIALLY GARBAGE.  DALTLC IS ALTERNATE INITIAL LOC
     *  FOR DWARF, IN CASE ONE OF THEM STARTS OUT ON TOP OF THE ADVENTURER.  (NO 2
     *  OF THE 5 INITIAL LOCS ARE ADJACENT.)  DSEEN IS TRUE IF DWARF HAS SEEN HIM.
     *  DFLAG CONTROLS THE LEVEL OF ACTIVATION OF ALL THIS:
     *	0	NO DWARF STUFF YET (WAIT UNTIL REACHES HALL OF MISTS)
     *	1	REACHED HALL OF MISTS, BUT HASN'T MET FIRST DWARF
     *	2	MET FIRST DWARF, OTHERS START MOVING, NO KNIVES THROWN YET
     *	3	A KNIFE HAS BEEN THROWN (FIRST SET ALWAYS MISSES)
     *	3+	DWARVES ARE MAD (INCREASES THEIR ACCURACY)
     *  SIXTH DWARF IS SPECIAL (THE PIRATE).  HE ALWAYS STARTS AT HIS CHEST'S
     *  EVENTUAL LOCATION INSIDE THE MAZE.  THIS LOC IS SAVED IN CHLOC FOR REF.
     *  THE DEAD END IN THE OTHER MAZE HAS ITS LOC STORED IN CHLOC2. */
    
    CHLOC=114;
    CHLOC2=140;
    /* 1700 */
    for (I=1; I<=6; I++)
    {
        DSEEN[I]=FALSE;
    } /* end loop */
    DFLAG=0;
    DLOC[1]=19;
    DLOC[2]=27;
    DLOC[3]=33;
    DLOC[4]=44;
    DLOC[5]=64;
    DLOC[6]=CHLOC;
    DALTLC=18;
    
    /*  OTHER RANDOM FLAGS AND COUNTERS, AS FOLLOWS:
     *	ABBNUM	HOW OFTEN WE SHOULD PRINT NON-ABBREVIATED DESCRIPTIONS
     *	BONUS	USED TO DETERMINE AMOUNT OF BONUS IF HE REACHES CLOSING
     *	CLOCK1	NUMBER OF TURNS FROM FINDING LAST TREASURE TILL CLOSING
     *	CLOCK2	NUMBER OF TURNS FROM FIRST WARNING TILL BLINDING FLASH
     *	CONDS	MIN VALUE FOR COND(LOC) IF LOC HAS ANY HINTS
     *	DETAIL	HOW OFTEN WE'VE SAID "NOT ALLOWED TO GIVE MORE DETAIL"
     *	DKILL	NUMBER OF DWARVES KILLED (UNUSED IN SCORING, NEEDED FOR MSG)
     *	FOOBAR	CURRENT PROGRESS IN SAYING "FEE FIE FOE FOO".
     *	HOLDNG	NUMBER OF OBJECTS BEING CARRIED
     *	IGO	HOW MANY TIMES HE'S SAID "GO XXX" INSTEAD OF "XXX"
     *	IWEST	HOW MANY TIMES HE'S SAID "WEST" INSTEAD OF "W"
     *	KNFLOC	0 IF NO KNIFE HERE, LOC IF KNIFE HERE, -1 AFTER CAVEAT
     *	LIMIT	LIFETIME OF LAMP (NOT SET HERE)
     *	MAXDIE	NUMBER OF REINCARNATION MESSAGES AVAILABLE (UP TO 5)
     *	NUMDIE	NUMBER OF TIMES KILLED SO FAR
     *	THRESH	NEXT #TURNS THRESHHOLD (-1 IF NONE)
     *	TRNDEX	INDEX IN TRNVAL OF NEXT THRESHHOLD (SECTION 14 OF DATABASE)
     *	TRNLUZ	# POINTS LOST SO FAR DUE TO NUMBER OF TURNS USED
     *	TURNS	TALLIES HOW MANY COMMANDS HE'S GIVEN (IGNORES YES/NO)
     *	LOGICALS WERE EXPLAINED EARLIER */
    
    TURNS=0;
    TRNDEX=1;
    THRESH= -1;
    if(TRNVLS > 0)THRESH=fmod(TRNVAL[1],100000)+1;
    TRNLUZ=0;
    LMWARN=FALSE;
    IGO=0;
    IWEST=0;
    KNFLOC=0;
    DETAIL=0;
    ABBNUM=5;
    for (I=0; I<=4; I++)
    {
        long x = 2*I+81;
        if(RandomSection6Texts[x] != 0)MAXDIE=I+1;
    } /* end loop */
    NUMDIE=0;
    HOLDNG=0;
    DKILL=0;
    FOOBAR=0;
    BONUS=0;
    CLOCK1=30;
    CLOCK2=50;
    CONDS=SETBIT(11);
    SAVED=0;
    CLOSNG=FALSE;
    PANIC=FALSE;
    CLOSED=FALSE;
    CLSHNT=FALSE;
    NOVICE=FALSE;
    SETUP=1;
    
    /* if we can ever think of how, we should save it at this point */
    
    return(0); /* then we won't actually return from initialisation */
}

/*  REPORT ON AMOUNT OF ARRAYS ACTUALLY USED, TO PERMIT REDUCTIONS. */

static void report(void )
{
    for (K=1; K<=LOCSIZ; K++)
    {
        KK=LOCSIZ+1-K;
        if(LTEXT[KK] != 0) goto L1997;
    
    } /* end loop */
    
    OBJ=0;
L1997:	/* 1996 */ for (K=1; K<=100; K++)
{
    if(PTEXT[K] != 0)OBJ=OBJ+1;
} /* end loop */
    
    for (K=1; K<=TABNDX; K++)
    {
        if(KTAB[K]/1000 == 2)VERB=KTAB[K]-2000;
    } /* end loop */
    
    for (K=1; K<=RTXSIZ; K++)
    {
        J=RTXSIZ+1-K;
        if(RandomSection6Texts[J] != 0) goto L1993;
        
    } /* end loop */
    
L1993:	fSetParametersForSpeak(1,LINUSE,LINSIZ);
    fSetParametersForSpeak(3,TRVS,TRVSIZ);
    fSetParametersForSpeak(5,TABNDX,TABSIZ);
    fSetParametersForSpeak(7,KK,LOCSIZ);
    fSetParametersForSpeak(9,OBJ,100);
    fSetParametersForSpeak(11,VERB,VRBSIZ);
    fSetParametersForSpeak(13,J,RTXSIZ);
    fSetParametersForSpeak(15,CLSSES,CLSMAX);
    fSetParametersForSpeak(17,HNTMAX,HNTSIZ);
    fSetParametersForSpeak(19,TRNVLS,TRNSIZ);
    SpeakMessageFromSect6(267);
    TYPE0();
}

static long init_reading, init_cksum;
static FILE *f;

static void quick_item(long*);
static void quick_array(long*, long);




static int quick_init(void)
{
#ifdef AMIGA
	f = fopen("ram:adventure.data", READ_MODE);
#else
    //extern char *getenv();
	char *adv = getenv("ADVENTURE");
	f = NULL;
	if(adv)f = fopen(adv,READ_MODE);
#endif
	if(f == NULL)f = fopen("adventure.data",READ_MODE);
	if(f == NULL)return(FALSE);
	init_reading = TRUE;
	init_cksum = 1;
	quick_io();
	if(fread(&K,4,1,f) == 1) init_cksum -= K; else init_cksum = 1;
	fclose(f);
	if(init_cksum != 0)printf("Checksum error!\n");
	return(init_cksum == 0);
}

static int quick_save(void) {
	printf("Writing adventure.data...\n");
	f = fopen("adventure.data",WRITE_MODE);
	if(f == NULL){printf("Can't open file!\n"); return(0);}
	init_reading = FALSE;
	init_cksum = 1;
	quick_io();
	fwrite(&init_cksum,4,1,f);
	fclose(f);
    return(0);
}

static int quick_io(void) {
	quick_item(&LINUSE);
	quick_item(&TRVS);
	quick_item(&CLSSES);
	quick_item(&TRNVLS);
	quick_item(&TABNDX);
	quick_item(&HNTMAX);
	quick_array(PTEXT,100);
	quick_array(RandomSection6Texts,RTXSIZ);
	quick_array(CTEXT,CLSMAX);
	quick_array(OBJSND,100);
	quick_array(OBJTXT,100);
	quick_array(STEXT,LOCSIZ);
	quick_array(LTEXT,LOCSIZ);
	quick_array(COND,LOCSIZ);
	quick_array(KEY,LOCSIZ);
	quick_array(LOCSND,LOCSIZ);
    quick_array(LINES_ADV,LINSIZ);
	quick_array(CVAL,CLSMAX);
	quick_array(TTEXT,TRNSIZ);
	quick_array(TRNVAL,TRNSIZ);
	quick_array(TRAVEL,TRVSIZ);
	quick_array(KTAB,TABSIZ);
	quick_array(ATAB,TABSIZ);
	quick_array(PLAC,100);
	quick_array(FIXD,100);
	quick_array(ACTSPK,VRBSIZ);
	quick_array((long *)HINTS,(HNTMAX+1)*5-1);
	return(0);
}

static void quick_item(W)long *W; {
	if(init_reading && fread(W,4,1,f) != 1)return;
	init_cksum = fmod(init_cksum*13+(*W),60000000);
	if(!init_reading)fwrite(W,4,1,f);
}

static void quick_array(A,N)long *A, N; { long I;
	if(init_reading && fread(A,4,N+1,f) != N+1)printf("Read error!\n");
	for(I=1;I<=N;I++)init_cksum = fmod(init_cksum*13+A[I],60000000);
	if(!init_reading && fwrite(A,4,N+1,f)!=N+1)printf("Write error!\n");
}
