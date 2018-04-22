#import <Foundation/Foundation.h>
#include "main.h"
#include "misc.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/*  I/O ROUTINES (SPEAK, PSPEAK, fRSPEAK, SETPRM, GETIN, YES) */

void fSPEAK(long N)
{
long BLANK, CASE, I, K, L, NEG, NPARMS, PARM, PRMTYP, STATE;

/*  PRINT THE MESSAGE WHICH STARTS AT LINES_ADV(N).  PRECEDE IT WITH A BLANK LINE
 *  UNLESS BLKLIN IS FALSE. */


	if(N == 0)return;
    
	BLANK=BLKLIN;
	K=N;
	NPARMS=1;
L10:	L=labs(LINES_ADV[K])-1;
	K=K+1;
	LineLength=0;
	LinePosition=1;
	STATE=0;
	for (I=K; I<=L; I++)
    {
        fPUTTXT(LINES_ADV[I],&STATE,2,I);
    } /* end loop */
	LinePosition=0;
    
    do{
L30:	LinePosition=LinePosition+1;
L32:	if(LinePosition > LineLength) goto L40;
    }
    while(INLINE[LinePosition] != 63);
	{long x = LinePosition+1; PRMTYP=INLINE[x];}
/*  63 IS A "%"; THE NEXT CHARACTER DETERMINE THE TYPE OF PARAMETER:  1 (!) =
 *  SUPPRESS MESSAGE COMPLETELY, 29 (S) = NULL IF PARM=1, ELSE 'S' (OPTIONAL
 *  PLURAL ENDING), 33 (W) = WORD (TWO 30-BIT VALUES) WITH TRAILING SPACES
 *  SUPPRESSED, 22 (L) OR 31 (U) = WORD BUT MAP TO LOWER/UPPER CASE, 13 (C) =
 *  WORD IN LOWER CASE WITH FIRST LETTER CAPITALISED, 30 (T) = TEXT ENDING
 *  WITH A WORD OF -1, 65-73 (1-9) = NUMBER USING THAT MANY CHARACTERS,
 *  12 (B) = VARIABLE NUMBER OF BLANKS. */
	if(PRMTYP == 1)return;
	if(PRMTYP == 29) goto L320;
	if(PRMTYP == 30) goto L340;
	if(PRMTYP == 12) goto L360;
	if(PRMTYP == 33 || PRMTYP == 22 || PRMTYP == 31 || PRMTYP == 13) goto
		L380;
	PRMTYP=PRMTYP-64;
	if(PRMTYP < 1 || PRMTYP > 9) goto L30;
	SHFTXT(LinePosition+2,PRMTYP-2);
	LinePosition=LinePosition+PRMTYP;
	PARM=labs(PARMS[NPARMS]);
	NEG=0;
	if(PARMS[NPARMS] < 0)NEG=9;
	/* 390 */ for (I=1; I<=PRMTYP; I++) {
	LinePosition=LinePosition-1;
	INLINE[LinePosition]=fmod(PARM,10)+64;
	if(I == 1 || PARM != 0) goto L390;
	INLINE[LinePosition]=NEG;
	NEG=0;
L390:	PARM=PARM/10;
	} /* end loop */
	LinePosition=LinePosition+PRMTYP;
L395:	NPARMS=NPARMS+1;
	 goto L32;

L320:	SHFTXT(LinePosition+2,-1);
	INLINE[LinePosition]=55;
	if(PARMS[NPARMS] == 1)SHFTXT(LinePosition+1,-1);
	 goto L395;

L340:	SHFTXT(LinePosition+2,-2);
	STATE=0;
	CASE=2;
L345:	if(PARMS[NPARMS] < 0) goto L395;
	{long x = NPARMS+1; if(PARMS[x] < 0)CASE=0;}
	fPUTTXT(PARMS[NPARMS],&STATE,CASE,0);
	NPARMS=NPARMS+1;
	 goto L345;

L360:	PRMTYP=PARMS[NPARMS];
	SHFTXT(LinePosition+2,PRMTYP-2);
	if(PRMTYP == 0) goto L395;
	/* 365 */ for (I=1; I<=PRMTYP; I++) {
	INLINE[LinePosition]=0;
L365:	LinePosition=LinePosition+1;
	} /* end loop */
	 goto L395;

L380:	SHFTXT(LinePosition+2,-2);
	STATE=0;
	CASE= -1;
	if(PRMTYP == 31)CASE=1;
	if(PRMTYP == 33)CASE=0;
	I=LinePosition;
	fPUTTXT(PARMS[NPARMS],&STATE,CASE,0);
	{long x = NPARMS+1; fPUTTXT(PARMS[x],&STATE,CASE,0);}
	if(PRMTYP == 13 && INLINE[I] >= 37 && INLINE[I] <=
		62)INLINE[I]=INLINE[I]-26;
	NPARMS=NPARMS+2;
	 goto L32;

L40:	if(BLANK)TYPE0();
	BLANK=FALSE;
	TYPE();
	K=L+1;
	if(LINES_ADV[K] >= 0) goto L10;
	return;
}





void fPSPEAK(MSG,SKIP)long MSG, SKIP;
{
    long I, M;
    
    /*  FIND THE SKIP+1ST MESSAGE FROM MSG AND PRINT IT.  MSG SHOULD BE THE INDEX OF
     *  THE INVENTORY MESSAGE FOR OBJECT.  (INVEN+N+1 MESSAGE IS PROP=N MESSAGE). */
    
    M=PTEXT[MSG];
    
    //printf("%ld ",M);
    if(SKIP >= 0)
    {
        for (I=0; I<=SKIP; I++)
        {
        L1:	M=labs(LINES_ADV[M]);
            if(LINES_ADV[M] >= 0) goto L1;
        
        }
    }

    fSPEAK(M);
    return;
}


void RandomMessageSpeakFromSect6(long I)
{
    
    /*  PRINT THE I-TH "RANDOM" MESSAGE (SECTION 6 OF DATABASE). */
    
    if(I != 0)fSPEAK(RandomSection6Texts[I]);
    return;
}



#define fRSPEAK(I) fRSPEAK(I)
#undef SETPRM
void fSETPRM(FIRST,P1,P2)long FIRST, P1, P2; {
;

/*  STORES PARAMETERS INTO THE PRMCOM PARMS ARRAY FOR USE BY SPEAK.  P1 AND P2
 *  ARE STORED INTO PARMS(FIRST) AND PARMS(FIRST+1). */


	if(FIRST >= 25)BUG(29);
	PARMS[FIRST]=P1;
	{long x = FIRST+1; PARMS[x]=P2;}
	return;
}



#define SETPRM(FIRST,P1,P2) fSETPRM(FIRST,P1,P2)
#undef GETIN
#define WORD1 (*wORD1)
#define WORD1X (*wORD1X)
#define WORD2 (*wORD2)
#define WORD2X (*wORD2X)
void fGETIN(wORD1,wORD1X,wORD2,wORD2X)long *wORD1, *wORD1X, *wORD2, *wORD2X; {
long JUNK;

/*  GET A COMMAND FROM THE ADVENTURER.  SNARF OUT THE FIRST WORD, PAD IT WITH
 *  BLANKS, AND RETURN IT IN WORD1.  CHARS 6 THRU 10 ARE RETURNED IN WORD1X, IN
 *  CASE WE NEED TO PRINT OUT THE WHOLE WORD IN AN ERROR MESSAGE.  ANY NUMBER OF
 *  BLANKS MAY FOLLOW THE WORD.  IF A SECOND WORD APPEARS, IT IS RETURNED IN
 *  WORD2 (CHARS 6 THRU 10 IN WORD2X), ELSE WORD2 IS -1. */


L10:	if(BLKLIN)TYPE0();
	fMapLine(FALSE);
	WORD1=GETTXT(TRUE,TRUE,TRUE,0);
	if(BLKLIN && WORD1 < 0) goto L10;
	WORD1X=GETTXT(FALSE,TRUE,TRUE,0);
L12:	JUNK=GETTXT(FALSE,TRUE,TRUE,0);
	if(JUNK > 0) goto L12;
	WORD2=GETTXT(TRUE,TRUE,TRUE,0);
	WORD2X=GETTXT(FALSE,TRUE,TRUE,0);
L22:	JUNK=GETTXT(FALSE,TRUE,TRUE,0);
	if(JUNK > 0) goto L22;
	if(GETTXT(TRUE,TRUE,TRUE,0) <= 0)return;
	RandomMessageSpeakFromSect6(53);
	 goto L10;
}



#undef WORD1
#undef WORD1X
#undef WORD2
#undef WORD2X
#define GETIN(WORD1,WORD1X,WORD2,WORD2X) fGETIN(&WORD1,&WORD1X,&WORD2,&WORD2X)
#undef YES_ADV
long fYES(X,Y,Z)long X, Y, Z; {

long YES_ADV, REPLY, JUNK1, JUNK2, JUNK3;

/*  PRINT MESSAGE X, WAIT FOR YES/NO ANSWER.  IF YES, PRINT Y AND RETURN TRUE;
 *  IF NO, PRINT Z AND RETURN FALSE. */

L1:	RandomMessageSpeakFromSect6(X);
	GETIN(REPLY,JUNK1,JUNK2,JUNK3);
	if(REPLY == funcMakeWorD(250519) || REPLY == funcMakeWorD(25)) goto L10;
	if(REPLY == funcMakeWorD(1415) || REPLY == funcMakeWorD(14)) goto L20;
	RandomMessageSpeakFromSect6(185);
	 goto L1;
L10:	YES_ADV=TRUE;
	RandomMessageSpeakFromSect6(Y);
	return(YES_ADV);
L20:	YES_ADV=FALSE;
	RandomMessageSpeakFromSect6(Z);
	return(YES_ADV);
}





/*  LINE-PARSING ROUTINES (GETNUM, GETTXT, funcMakeWorD, PUTTXT, SHFTXT, TYPE0)
		*/

/*  THE ROUTINES ON THIS PAGE HANDLE ALL THE STUFF THAT WOULD NORMALLY BE
 *  TAKEN CARE OF BY FORMAT STATEMENTS.  WE DO IT THIS WAY INSTEAD SO THAT
 *  WE CAN HANDLE TEXTUAL DATA IN A MACHINE INDEPENDENT FASHION.  ALL THE
 *  MACHINE DEPENDENT I/O STUFF IS ON THE FOLLOWING PAGE.  SEE THAT PAGE
 *  FOR A DESCRIPTION OF MAPCOM'S INLINE ARRAY. */

long fGETNUM(long K)
{
    long DIGIT, GETNUM = 0, SIGN = 1;
    
    /*  OBTAIN THE NEXT INTEGER FROM AN INPUT LINE.
     IF K>0, WE FIRST READ A
     *  NEW INPUT LINE FROM A FILE;
     IF K<0, WE READ A LINE FROM THE KEYBOARD;
     *  IF K=0 WE USE A LINE THAT HAS ALREADY BEEN READ (AND PERHAPS PARTIALLY
     *  SCANNED).
     IF WE'RE AT THE END OF THE LINE OR ENCOUNTER AN ILLEGAL
     *  CHARACTER (NOT A DIGIT, HYPHEN, OR BLANK), WE RETURN 0. */
    
    
    if(K != 0) fMapLine(K > 0);
    
L10:	if(LinePosition > LineLength)return(GETNUM);
    if(INLINE[LinePosition] != 0) goto L20;
    LinePosition=LinePosition+1;
    goto L10;
    
L20:	SIGN=1;
    if(INLINE[LinePosition] != 9) goto L32;
    SIGN= -1;
    
L30:	LinePosition=LinePosition+1;
L32:	if(LinePosition > LineLength || INLINE[LinePosition] == 0) goto L42;

    DIGIT=INLINE[LinePosition]-64;
#ifdef TESTING
    printf("char : %c nr =  %ld ",INLINE[LinePosition],DIGIT);
#endif
    if(DIGIT < 0 || DIGIT > 9) goto L40;
    GETNUM=GETNUM*10+DIGIT;
    goto L30;
    
L40:	GETNUM=0;
L42:	GETNUM=GETNUM*SIGN;
    LinePosition=LinePosition+1;
    return(GETNUM);
}



long fGETTXT(SKIP,ONEWRD,UPPER,HASH)long HASH, ONEWRD, SKIP, UPPER; {
long CHAR, GETTXT, I; static long SPLITTING = -1;

    char * tab_s;
    
/*  TAKE CHARACTERS FROM AN INPUT LINE AND PACK THEM INTO 30-BIT WORDS.
 *  SKIP SAYS TO SKIP LEADING BLANKS.  ONEWRD SAYS STOP IF WE COME TO A
 *  BLANK.  UPPER SAYS TO MAP ALL LETTERS TO UPPERCASE.  HASH MAY BE USED
 *  AS A PARAMETER FOR ENCRYPTING THE TEXT IF DESIRED; HOWEVER, A HASH OF 0
 *  SHOULD RESULT IN UNMODIFIED BYTES BEING PACKED.  IF WE REACH THE
 *  END OF THE LINE, THE WORD IS FILLED UP WITH BLANKS (WHICH ENCODE AS 0'S).
 *  IF WE'RE ALREADY AT END OF LINE WHEN GETTXT IS CALLED, WE RETURN -1. */

	if(LinePosition != SPLITTING)SPLITTING = -1;
	GETTXT= -1;
L10:	if(LinePosition > LineLength)return(GETTXT);
	if((!SKIP) || INLINE[LinePosition] != 0) goto L11;
	LinePosition=LinePosition+1;
	 goto L10;

L11:	GETTXT=0;
	
    for (I=1; I<=5; I++)
    {
        GETTXT=GETTXT*64;
        if(LinePosition > LineLength || (ONEWRD && INLINE[LinePosition] == 0)) goto L15;
        CHAR=INLINE[LinePosition];
       
        tab_s =INLINE;
        //test only
        //printf("%s \n",tab_s);
        if(CHAR >= 63) goto L12;
        SPLITTING = -1;
        if(UPPER && CHAR >= 37) CHAR=CHAR-26;
        GETTXT=GETTXT+CHAR;
        goto L14;
        
    L12:	if(SPLITTING == LinePosition) goto L13;
        GETTXT=GETTXT+63;
        SPLITTING = LinePosition;
        goto L15;
        
    L13:	GETTXT=GETTXT+CHAR-63;
        SPLITTING = -1;
    L14:	LinePosition=LinePosition+1;
    L15:	/*etc*/ ;
    } /* end loop */

	if(HASH)GETTXT=GETTXT+fmod(HASH*13579L+5432L,97531L)*12345L+HASH;
	return(GETTXT);
}



#define GETTXT(SKIP,ONEWRD,UPPER,HASH) fGETTXT(SKIP,ONEWRD,UPPER,HASH)

long funcMakeWorD(long LETTRS)
{
long I, L, MWord;

/*  COMBINE FIVE UPPERCASE LETTERS (REPRESENTED BY PAIRS OF DECIMAL DIGITS
 *  IN LETTRS) TO FORM A 30-BIT VALUE MATCHING THE ONE THAT GETTXT WOULD
 *  RETURN GIVEN THOSE CHARACTERS PLUS TRAILING BLANKS AND HASH=0.  CAUTION:
 *  LETTRS WILL OVERFLOW 31 BITS IF 5-LETTER WORD STARTS WITH V-Z.  AS A
 *  KLUDGEY WORKAROUND, YOU CAN INCREMENT A LETTER BY 5 BY ADDING 50 TO
 *  THE NEXT PAIR OF DIGITS. */


	MWord=0;
	I=1;
	L=LETTRS;
    
    do
    {
        MWord=MWord+I*(fmod(L,50)+10);
        I=I*64;
        if(fmod(L,100) > 50)MWord=MWord+I*5;
        L=L/100;
        
        
    } while(L != 0);
	I=64L*64L*64L*64L*64L/I;
	MWord=MWord*I;
	return(MWord);
}




#undef PUTTXT
#define STATE (*sTATE)
void fPUTTXT(long WORD,long *sTATE, long CASE, long HASH)
{
    long ALPH1, ALPH2, BYTE, DIV, I, W;
    
    /*  UNPACK THE 30-BIT VALUE IN WORD TO OBTAIN UP TO 5 INTEGER-ENCODED CHARS,
     *  AND STORE THEM IN INLINE STARTING AT LinePosition.  IF LNLENG>=LinePosition, SHIFT
     *  EXISTING CHARACTERS TO THE RIGHT TO MAKE ROOM.  HASH MUST BE THE SAME
     *  AS IT WAS WHEN GETTXT CREATED THE 30-BIT WORD.  STATE WILL BE ZERO WHEN
     *  PUTTXT IS CALLED WITH THE FIRST OF A SEQUENCE OF WORDS, BUT IS THEREAFTER
     *  UNCHANGED BY THE CALLER, SO PUTTXT CAN USE IT TO MAINTAIN STATE ACROSS
     *  CALLS.  LinePosition AND LNLENG ARE INCREMENTED BY THE NUMBER OF CHARS STORED.
     *  IF CASE=1, ALL LETTERS ARE MADE UPPERCASE; IF -1, LOWERCASE; IF 0, AS IS.
     *  ANY OTHER VALUE FOR CASE IS THE SAME AS 0 BUT ALSO CAUSES TRAILING BLANKS
     *  TO BE INCLUDED (IN ANTICIPATION OF SUBSEQUENT ADDITIONAL TEXT). */
    
    
    ALPH1=13*CASE+24;
    ALPH2=26*labs(CASE)+ALPH1;
    if(labs(CASE) > 1)ALPH1=ALPH2;
    /*  ALPH1&2 DEFINE RANGE OF WRONG-CASE CHARS, 11-36 OR 37-62 OR EMPTY. */
    DIV=64L*64L*64L*64L;
    W=WORD;
    if(HASH)W=W-fmod(HASH*13579L+5432L,97531L)*12345L-HASH;
    /* 18 */ for (I=1; I<=5; I++) {
        if(W <= 0 && STATE == 0 && labs(CASE) <= 1)return;
        BYTE=W/DIV;
        if(STATE != 0 || BYTE != 63) goto L12;
        STATE=63;
        goto L18;
        
    L12:	SHFTXT(LinePosition,1);
        STATE=STATE+BYTE;
        if(STATE < ALPH2 && STATE >= ALPH1)STATE=STATE-26*CASE;
        INLINE[LinePosition]=STATE;
        LinePosition=LinePosition+1;
        STATE=0;
    L18:	W=(W-BYTE*DIV)*64;
    } /* end loop */
    return;
}



#undef STATE
#define PUTTXT(WORD,STATE,CASE,HASH) fPUTTXT(WORD,&STATE,CASE,HASH)
#undef SHFTXT
void fSHFTXT(FROM,DELTA)long DELTA, FROM; {
long I, II, JJ;

/*  MOVE INLINE(N) TO INLINE(N+DELTA) FOR N=FROM,LNLENG.  DELTA CAN BE
 *  NEGATIVE.  LNLENG IS UPDATED; LinePosition IS NOT CHANGED. */


	if(LineLength < FROM || DELTA == 0) goto L2;
	/* 1 */ for (I=FROM; I<=LineLength; I++) {
	II=I;
	if(DELTA > 0)II=FROM+LineLength-I;
	JJ=II+DELTA;
L1:	INLINE[JJ]=INLINE[II];
	} /* end loop */
L2:	LineLength=LineLength+DELTA;
	return;
}



#define SHFTXT(FROM,DELTA) fSHFTXT(FROM,DELTA)
#undef TYPE0
void fTYPE0() {
long TEMP;

/*  TYPE A BLANK LINE.  THIS PROCEDURE IS PROVIDED AS A CONVENIENCE FOR CALLERS
 *  WHO OTHERWISE HAVE NO USE FOR MAPCOM. */


	TEMP=LineLength;
	LineLength=0;
	TYPE();
	LineLength=TEMP;
	return;
}



#define TYPE0() fTYPE0()


/*  SUSPEND/RESUME I/O ROUTINES (SAVWDS, SAVARR, SAVWRD) */

#undef SAVWDS
void fSAVWDS(W1,W2,W3,W4,W5,W6,W7)long *W1, *W2, *W3, *W4, *W5, *W6, *W7; {
;

/*  WRITE OR READ 7 VARIABLES.  SEE SAVWRD. */


	SAVWRD(0,(*W1));
	SAVWRD(0,(*W2));
	SAVWRD(0,(*W3));
	SAVWRD(0,(*W4));
	SAVWRD(0,(*W5));
	SAVWRD(0,(*W6));
	SAVWRD(0,(*W7));
	return;
}


#define SAVWDS(W1,W2,W3,W4,W5,W6,W7) fSAVWDS(&W1,&W2,&W3,&W4,&W5,&W6,&W7)
#undef SAVARR
void fSAVARR(ARR,N)long ARR[], N; {
long I;

/*  WRITE OR READ AN ARRAY OF N WORDS.  SEE SAVWRD. */


	/* 1 */ for (I=1; I<=N; I++) {
L1:	SAVWRD(0,ARR[I]);
	} /* end loop */
	return;
}



#define SAVARR(ARR,N) fSAVARR(ARR,N)
#undef SAVWRD
#define WORD (*wORD)
void fSAVWRD(OP,wORD)long OP, *wORD; {
static long BUF[250], CKSUM = 0, H1, HASH = 0, N = 0, STATE = 0;

/*  IF OP<0, START WRITING A FILE, USING WORD TO INITIALISE ENCRYPTION; SAVE
 *  WORD IN THE FILE.  IF OP>0, START READING A FILE; READ THE FILE TO FIND
 *  THE VALUE WITH WHICH TO DECRYPT THE REST.  IN EITHER CASE, IF A FILE IS
 *  ALREADY OPEN, FINISH WRITING/READING IT AND DON'T START A NEW ONE.  IF OP=0,
 *  READ/WRITE A SINGLE WORD.  WORDS ARE BUFFERED IN CASE THAT MAKES FOR MORE
 *  EFFICIENT DISK USE.  WE ALSO COMPUTE A SIMPLE CHECKSUM TO CATCH ELEMENTARY
 *  POKING WITHIN THE SAVED FILE.  WHEN WE FINISH READING/WRITING THE FILE,
 *  WE STORE ZERO INTO WORD IF THERE'S NO CHECKSUM ERROR, ELSE NONZERO. */


	if(OP != 0){long ifvar; ifvar=(STATE); switch (ifvar<0? -1 : ifvar>0? 1 :
		0) { case -1: goto L30; case 0: goto L10; case 1: goto L30; }}
	if(STATE == 0)return;
	if(N == 250)fSAVEIO(1,STATE > 0,BUF);
	N=fmod(N,250)+1;
	H1=fmod(HASH*1093L+221573L,1048576L);
	HASH=fmod(H1*1093L+221573L,1048576L);
	H1=fmod(H1,1234)*765432+fmod(HASH,123);
	N--;
	if(STATE > 0)WORD=BUF[N]+H1;
	BUF[N]=WORD-H1;
	N++;
	CKSUM=fmod(CKSUM*13+WORD,1000000000L);
	return;

L10:	STATE=OP;
	fSAVEIO(0,STATE > 0,BUF);
	N=1;
	if(STATE > 0) goto L15;
	HASH=fmod(WORD,1048576L);
	BUF[0]=1234L*5678L-HASH;
L13:	CKSUM=BUF[0];
	return;

L15:	fSAVEIO(1,TRUE,BUF);
	HASH=fmod(1234L*5678L-BUF[0],1048576L);
	 goto L13;

L30:	if(N == 250)fSAVEIO(1,STATE > 0,BUF);
	N=fmod(N,250)+1;
	if(STATE > 0) goto L32;
	N--; BUF[N]=CKSUM; N++;
	fSAVEIO(1,FALSE,BUF);
L32:	N--; WORD=BUF[N]-CKSUM; N++;
	fSAVEIO(-1,STATE > 0,BUF);
	STATE=0;
	return;
}





/*  DATA STRUC. ROUTINES (VOCAB, DSTROY, JUGGLE, MOVE, PUT, CARRY, DROP, ATDWRF)
		*/

#undef WORD
#define SAVWRD(OP,WORD) fSAVWRD(OP,&WORD)
#undef VOCAB
long fVOCAB(ID,INIT)long ID, INIT; {
long HASH, I, VOCAB;

/*  LOOK UP ID IN THE VOCABULARY (ATAB) AND RETURN ITS "DEFINITION" (KTAB), OR
 *  -1 IF NOT FOUND.  IF INIT IS POSITIVE, THIS IS AN INITIALISATION CALL SETTING
 *  UP A KEYWORD VARIABLE, AND NOT FINDING IT CONSTITUTES A BUG.  IT ALSO MEANS
 *  THAT ONLY KTAB VALUES WHICH TAKEN OVER 1000 EQUAL INIT MAY BE CONSIDERED.
 *  (THUS "STEPS", WHICH IS A MOTION VERB AS WELL AS AN OBJECT, MAY BE LOCATED
 *  AS AN OBJECT.)  AND IT ALSO MEANS THE KTAB VALUE IS TAKEN MOD 1000. */

	HASH=10000;
	/* 1 */
    for (I=1; I<=TABSIZ; I++)
    {
        if(KTAB[I] == -1)
        {
            VOCAB= -1;
            if(INIT < 0)return(VOCAB);
            BUG(5);
        }
        HASH=HASH+7;
        if(INIT >= 0 && KTAB[I]/1000 != INIT) continue;
        if(ATAB[I] == ID+HASH*HASH)
        {
            VOCAB=KTAB[I];
            if(INIT >= 0)VOCAB=fmod(VOCAB,1000);
            return(VOCAB);
        }
    
    }
    BUG(21);
    return 0;
}



#define VOCAB(ID,INIT) fVOCAB(ID,INIT)
#undef DSTROY
void fDSTROY(OBJECT)long OBJECT; {
;

/*  PERMANENTLY ELIMINATE "OBJECT" BY MOVING TO A NON-EXISTENT LOCATION. */


	MOVE(OBJECT,0);
	return;
}



#define DSTROY(OBJECT) fDSTROY(OBJECT)
#undef JUGGLE
void fJUGGLE(OBJECT)long OBJECT; {
long I, J;

/*  JUGGLE AN OBJECT BY PICKING IT UP AND PUTTING IT DOWN AGAIN, THE PURPOSE
 *  BEING TO GET THE OBJECT TO THE FRONT OF THE CHAIN OF THINGS AT ITS LOC. */


	I=PLACE[OBJECT];
	J=FIXED[OBJECT];
	MOVE(OBJECT,I);
	MOVE(OBJECT+100,J);
	return;
}



#define JUGGLE(OBJECT) fJUGGLE(OBJECT)
#undef MOVE
void fMOVE(OBJECT,WHERE)long OBJECT, WHERE; {
long FROM;

/*  PLACE ANY OBJECT ANYWHERE BY PICKING IT UP AND DROPPING IT.  MAY ALREADY BE
 *  TOTING, IN WHICH CASE THE CARRY IS A NO-OP.  MUSTN'T PICK UP OBJECTS WHICH
 *  ARE NOT AT ANY LOC, SINCE CARRY WANTS TO REMOVE OBJECTS FROM ATLOC CHAINS. */


	if(OBJECT > 100) goto L1;
	FROM=PLACE[OBJECT];
	 goto L2;
L1:	{long x = OBJECT-100; FROM=FIXED[x];}
L2:	if(FROM > 0 && FROM <= 300)CARRY(OBJECT,FROM);
	DROP(OBJECT,WHERE);
	return;
}



#define MOVE(OBJECT,WHERE) fMOVE(OBJECT,WHERE)
#undef PUT
long fPUT(OBJECT,WHERE,PVAL)long OBJECT, PVAL, WHERE; {
long PUT;

/*  PUT IS THE SAME AS MOVE, EXCEPT IT RETURNS A VALUE USED TO SET UP THE
 *  NEGATED PROP VALUES FOR THE REPOSITORY OBJECTS. */


	MOVE(OBJECT,WHERE);
	PUT=(-1)-PVAL;
	return(PUT);
}



#define PUT(OBJECT,WHERE,PVAL) fPUT(OBJECT,WHERE,PVAL)
#undef CARRY
void fCARRY(OBJECT,WHERE)long OBJECT, WHERE; {
long TEMP;

/*  START TOTING AN OBJECT, REMOVING IT FROM THE LIST OF THINGS AT ITS FORMER
 *  LOCATION.  INCR HOLDNG UNLESS IT WAS ALREADY BEING TOTED.  IF OBJECT>100
 *  (MOVING "FIXED" SECOND LOC), DON'T CHANGE PLACE OR HOLDNG. */


	if(OBJECT > 100) goto L5;
	if(PLACE[OBJECT] == -1)return;
	PLACE[OBJECT]= -1;
	HOLDNG=HOLDNG+1;
L5:	if(ATLOC[WHERE] != OBJECT) goto L6;
	ATLOC[WHERE]=LINK[OBJECT];
	return;
L6:	TEMP=ATLOC[WHERE];
L7:	if(LINK[TEMP] == OBJECT) goto L8;
	TEMP=LINK[TEMP];
	 goto L7;
L8:	LINK[TEMP]=LINK[OBJECT];
	return;
}



#define CARRY(OBJECT,WHERE) fCARRY(OBJECT,WHERE)
#undef DROP
void fDROP(OBJECT,WHERE)long OBJECT, WHERE; {
;

/*  PLACE AN OBJECT AT A GIVEN LOC, PREFIXING IT ONTO THE ATLOC LIST.  DECR
 *  HOLDNG IF THE OBJECT WAS BEING TOTED. */


	if(OBJECT > 100) goto L1;
	if(PLACE[OBJECT] == -1)HOLDNG=HOLDNG-1;
	PLACE[OBJECT]=WHERE;
	 goto L2;
L1:	{long x = OBJECT-100; FIXED[x]=WHERE;}
L2:	if(WHERE <= 0)return;
	LINK[OBJECT]=ATLOC[WHERE];
	ATLOC[WHERE]=OBJECT;
	return;
}



#define DROP(OBJECT,WHERE) fDROP(OBJECT,WHERE)
#undef ATDWRF
long fATDWRF(WHERE)long WHERE; {
long ATDWRF, I;

/*  RETURN THE INDEX OF FIRST DWARF AT THE GIVEN LOCATION, ZERO IF NO DWARF IS
 *  THERE (OR IF DWARVES NOT ACTIVE YET), -1 IF ALL DWARVES ARE DEAD.  IGNORE
 *  THE PIRATE (6TH DWARF). */


	ATDWRF=0;
	if(DFLAG < 2)return(ATDWRF);
	ATDWRF= -1;
	/* 1 */ for (I=1; I<=5; I++) {
	if(DLOC[I] == WHERE) goto L2;
L1:	if(DLOC[I] != 0)ATDWRF=0;
	} /* end loop */
	return(ATDWRF);

L2:	ATDWRF=I;
	return(ATDWRF);
}




/*  UTILITY ROUTINES (SETBIT, TSTBIT, RAN, RNDVOC, BUG) */

#undef SETBIT
long fSETBIT(BIT)long BIT; {
long I, SETBIT;

/*  RETURNS 2**BIT FOR USE IN CONSTRUCTING BIT-MASKS. */


	SETBIT=1;
	if(BIT <= 0)return(SETBIT);
	/* 1 */ for (I=1; I<=BIT; I++) {
L1:	SETBIT=SETBIT+SETBIT;
	} /* end loop */
	return(SETBIT);
}



#define SETBIT(BIT) fSETBIT(BIT)
#undef TSTBIT
long fTSTBIT(MASK,BIT)long BIT, MASK; {
long TSTBIT;

/*  RETURNS TRUE IF THE SPECIFIED BIT IS SET IN THE MASK. */


	TSTBIT=fmod(MASK/SETBIT(BIT),2) != 0;
	return(TSTBIT);
}



#define TSTBIT(MASK,BIT) fTSTBIT(MASK,BIT)
#undef RAN
long fRAN(RANGE)long RANGE; {
static long D, R = 0, RAN, T;

/*  SINCE THE RAN FUNCTION IN LIB40 SEEMS TO BE A REAL LOSE, WE'LL USE ONE OF
 *  OUR OWN.  IT'S BEEN RUN THROUGH MANY OF THE TESTS IN KNUTH VOL. 2 AND
 *  SEEMS TO BE QUITE RELIABLE.  RAN RETURNS A VALUE UNIFORMLY SELECTED
 *  BETWEEN 0 AND RANGE-1. */


	D=1;
	if(R != 0 && RANGE >= 0) goto L1;
	fGetDateTime(&D,&T);
	R=fmod(T+5,1048576L);
	D=1000+fmod(D,1000);
L1:	/* 2 */ for (T=1; T<=D; T++) {
L2:	R=fmod(R*1093L+221587L,1048576L);
	} /* end loop */
	RAN=(RANGE*R)/1048576;
	return(RAN);
}



#define RAN(RANGE) fRAN(RANGE)
#undef RNDVOC
long fRNDVOC(CHAR,FORCE)long CHAR, FORCE; {
long DIV, I, J, RNDVOC;

/*  SEARCHES THE VOCABULARY FOR A WORD WHOSE SECOND CHARACTER IS CHAR, AND
 *  CHANGES THAT WORD SUCH THAT EACH OF THE OTHER FOUR CHARACTERS IS A
 *  RANDOM LETTER.  IF FORCE IS NON-ZERO, IT IS USED AS THE NEW WORD.
 *  RETURNS THE NEW WORD. */


	RNDVOC=FORCE;
	if(RNDVOC != 0) goto L3;
	/* 1 */ for (I=1; I<=5; I++) {
	J=11+RAN(26);
	if(I == 2)J=CHAR;
L1:	RNDVOC=RNDVOC*64+J;
	} /* end loop */
L3:	J=10000;
	DIV=64L*64L*64L;
	/* 5 */ for (I=1; I<=TABSIZ; I++) {
	J=J+7;
	if(fmod((ATAB[I]-J*J)/DIV,64L) == CHAR) goto L8;
L5:	/*etc*/ ;
	} /* end loop */
	BUG(5);

L8:	ATAB[I]=RNDVOC+J*J;
	return(RNDVOC);
}



#define RNDVOC(CHAR,FORCE) fRNDVOC(CHAR,FORCE)

void fBUG(NUM)long NUM; {

/*  THE FOLLOWING CONDITIONS ARE CURRENTLY CONSIDERED FATAL BUGS.  NUMBERS < 20
 *  ARE DETECTED WHILE READING THE DATABASE; THE OTHERS OCCUR AT "RUN TIME".
 *	0	MESSAGE LINE > 70 CHARACTERS
 *	1	NULL LINE IN MESSAGE
 *	2	TOO MANY WORDS OF MESSAGES
 *	3	TOO MANY TRAVEL OPTIONS
 *	4	TOO MANY VOCABULARY WORDS
 *	5	REQUIRED VOCABULARY WORD NOT FOUND
 *	6	TOO MANY RTEXT MESSAGES
 *	7	TOO MANY HINTS
 *	8	LOCATION HAS COND BIT BEING SET TWICE
 *	9	INVALID SECTION NUMBER IN DATABASE
 *	10	TOO MANY LOCATIONS
 *	11	TOO MANY CLASS OR TURN MESSAGES
 *	20	SPECIAL TRAVEL (500>L>300) EXCEEDS GOTO LIST
 *	21	RAN OFF END OF VOCABULARY TABLE
 *	22	VOCABULARY TYPE (N/1000) NOT BETWEEN 0 AND 3
 *	23	INTRANSITIVE ACTION VERB EXCEEDS GOTO LIST
 *	24	TRANSITIVE ACTION VERB EXCEEDS GOTO LIST
 *	25	CONDITIONAL TRAVEL ENTRY WITH NO ALTERNATIVE
 *	26	LOCATION HAS NO TRAVEL ENTRIES
 *	27	HINT NUMBER EXCEEDS GOTO LIST
 *	28	INVALID MONTH RETURNED BY DATE FUNCTION
 *	29	TOO MANY PARAMETERS GIVEN TO SETPRM */

	printf("Fatal error %ld.  See source code for interpretation.\n",
	   NUM);
	exit(FALSE);
}





/*  MACHINE DEPENDENT ROUTINES (fMapLine, TYPE, MPINIT, fSAVEIO) */

void fMapLine(long FIL)
{
    long I, VAL;
    static FILE *OPENED = NULL;
    char *tab_s;
    
    /*  READ A LINE OF INPUT, EITHER FROM A FILE (IF FIL=.TRUE.) OR FROM THE
     *  KEYBOARD, TRANSLATE THE CHARS TO INTEGERS IN THE RANGE 0-126 AND STORE
     *  THEM IN THE COMMON ARRAY "INLINE".  INTEGER VALUES ARE AS FOLLOWS:
     *     0   = SPACE [ASCII CODE 40 OCTAL, 32 DECIMAL]
     *    1-2  = !" [ASCII 41-42 OCTAL, 33-34 DECIMAL]
     *    3-10 = '()*+,-. [ASCII 47-56 OCTAL, 39-46 DECIMAL]
     *   11-36 = UPPER-CASE LETTERS
     *   37-62 = LOWER-CASE LETTERS
     *    63   = PERCENT (%) [ASCII 45 OCTAL, 37 DECIMAL]
     *   64-73 = DIGITS, 0 THROUGH 9
     *  REMAINING CHARACTERS CAN BE TRANSLATED ANY WAY THAT IS CONVENIENT;
     *  THE "TYPE" ROUTINE BELOW IS USED TO MAP THEM BACK TO CHARACTERS WHEN
     *  NECESSARY.  THE ABOVE MAPPINGS ARE REQUIRED SO THAT CERTAIN SPECIAL
     *  CHARACTERS ARE KNOWN TO FIT IN 6 BITS AND/OR CAN BE EASILY SPOTTED.
     *  ARRAY ELEMENTS BEYOND THE END OF THE LINE SHOULD BE FILLED WITH 0,
     *  AND LNLENG SHOULD BE SET TO THE INDEX OF THE LAST CHARACTER.
     *
     *  IF THE DATA FILE USES A CHARACTER OTHER THAN SPACE (E.G., TAB) TO
     *  SEPARATE NUMBERS, THAT CHARACTER SHOULD ALSO TRANSLATE TO 0.
     *
     *  THIS PROCEDURE MAY USE THE MAP1,MAP2 ARRAYS TO MAINTAIN STATIC DATA FOR
     *  THE MAPPING.  MAP2(1) IS SET TO 0 WHEN THE PROGRAM STARTS
     *  AND IS NOT CHANGED THEREAFTER UNLESS THE ROUTINES ON THIS PAGE CHOOSE
     *  TO DO SO.
     *
     *  NOTE THAT fMapLine IS EXPECTED TO OPEN THE FILE THE FIRST TIME IT IS
     *  ASKED TO READ A LINE FROM IT.  THAT IS, THERE IS NO OTHER PLACE WHERE
     *  THE DATA FILE IS OPENED. */
    
    if(MAP2[1] == 0)fMapInit();
    do
    {
        if(FIL)
        {
            if(!OPENED)
            {
                OPENED=fopen("adventure.text","r" /* NOT binary */);
                if(!OPENED)
                {
                    printf("Can't read adventure.text!\n");
                    exit(FALSE);
                }
            }
            
            fgets(INLINE+1,100,OPENED);
            
            char *tab_s;
            
            tab_s  = INLINE+1;
            //printf("%s",tab_s);
        }
        else
        {
            gets(INLINE+1);
            if(feof(stdin)) score(1);
            
        }
        LineLength=0;
        /* here we have in INLINE text from file
         and translate it to long values with Map1 tab
         */
        for (I=1; I<=100 && INLINE[I]!=0; I++)
        {
            
            VAL=INLINE[I]+1;
            INLINE[I]=MAP1[VAL];
            if(INLINE[I] != 0)LineLength=I;
        } /* end loop */
        LinePosition=1;
    }
    while((FIL && LineLength == 0));
    /*  ABOVE IS TO GET AROUND AN F40 COMPILER BUG WHEREIN IT READS A BLANK
     *  LINE WHENEVER A CRLF IS BROKEN ACROSS A RECORD BOUNDARY. */
    return;
}





void fTYPE() {
long I, VAL;

/*  TYPE THE FIRST "LNLENG" CHARACTERS STORED IN INLINE, MAPPING THEM
 *  FROM INTEGERS TO TEXT PER THE RULES DESCRIBED ABOVE.  INLINE(I),
 *  I=1,LNLENG MAY BE CHANGED BY THIS ROUTINE. */


	if(LineLength == 0)
    {
        printf("\n");
        return;
    }

	if(MAP2[1] == 0)fMapInit();
	
    for (I=1; I<=LineLength; I++)
    {
        VAL=INLINE[I];
        long x = VAL+1;
        INLINE[I]=MAP2[x];
    }
	{long x = LineLength+1; INLINE[x]=0;}
	printf(" %s\n",INLINE+1);
	return;
}



#define TYPE() fTYPE()
/*
 This function initialize
 maping of letters
 to other values
 */
void fMapInit(void)
{
    long FIRST, I, J, LAST, VAL;
    static long RUNS[7][2] = {32,34, 39,46, 65,90, 97,122, 37,37, 48,57, 0,126};
    
	for (I=1; I<=128; I++)
    {
        MAP1[I]= -1;
    }
    VAL=0;
     for (I=0; I<7; I++)
     {
        FIRST=RUNS[I][0];
        LAST=RUNS[I][1];
        for (J=FIRST; J<=LAST; J++)
        {
            
            if(MAP1[++J] < 0)
            {
                MAP1[J]=VAL;
                VAL=VAL+1;
            }
            J--;
        }

    }
    MAP1[128]=MAP1[10];
    /*  FOR THIS VERSION, TAB (9) MAPS TO SPACE (32), SO DEL (127) USES TAB'S VALUE */
    MAP1[10]=MAP1[33];
    MAP1[11]=MAP1[33];
    
    for (I=0; I<=126; I++)
    {
        VAL=MAP1[++I]+1;
        I--;
        MAP2[VAL]=I*('B'-'A');
    	if(I >= 64)MAP2[VAL]=(I-64)*('B'-'A')+'@';
    }
    
    return;
}





void fSAVEIO(OP,IN,ARR)long ARR[], IN, OP;
{
    static FILE *F; char NAME[50];
    
    /*  IF OP=0, ASK FOR A FILE NAME AND OPEN A FILE.  (IF IN=.TRUE., THE FILE IS FOR
     *  INPUT, ELSE OUTPUT.)  IF OP>0, READ/WRITE ARR FROM/INTO THE PREVIOUSLY-OPENED
     *  FILE.  (ARR IS A 250-INTEGER ARRAY.)  IF OP<0, FINISH READING/WRITING THE
     *  FILE.  (FINISHING WRITING CAN BE A NO-OP IF A "STOP" STATEMENT DOES IT
     *  AUTOMATICALLY.  FINISHING READING CAN BE A NO-OP AS LONG AS A SUBSEQUENT
     *  fSAVEIO(0,.FALSE.,X) WILL STILL WORK.)  IF YOU CAN CATCH ERRORS (E.G., NO SUCH
     *  FILE) AND TRY AGAIN, GREAT.  DEC F40 CAN'T. */
    
    
    
    long ifvar;
    ifvar=(OP);
    switch (ifvar<0? -1 : ifvar>0? 1 : 0)
    {
        case -1:
            fclose(F);
            return;
        case 0:
            printf("\nFile name: ");
            gets(NAME);
            F=fopen(NAME,(IN ? READ_MODE : WRITE_MODE));
            
            if(F == NULL)
                printf("Can't open file, try again.\n");
            
            return;
        case 1:
            if(IN)fread(ARR,4,250,F);
            if(!IN)fwrite(ARR,4,250,F);
            return;
    }
    
    
    
    
}

