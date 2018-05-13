//
//  main.m
//  AdventureOrig
//
//  Created by Daniel Kucharski on 01.04.2018.
//  Copyright © 2018 code masterss. All rights reserved.
//
#include "main.h"
#include "misc.h"
#include "funcs.h"



long ABB[186],
ATAB[331],
ATLOC[186],
BLKLIN = TRUE,
DFLAG,
DLOC[7], FIXED[101], HOLDNG,
KTAB[331];


long *LINES_ADV;
long LINK[201], LineLength, LinePosition,
PARMS[26], PLACE[101],
PTEXT[101],
RandomSection6Texts[278],
SETUP = 0,
TABSIZ = 330;

char INLINE[101];
char MAP1[129] ;
char MAP2[129] ;

long ABBNUM,
ACTSPK[36],
AMBER,
ATTACK,
AXE, BACK, BATTER, BEAR, BIRD, BLOOD, BONUS,
BOTTLE, CAGE, CAVE, CAVITY, CHAIN, CHASM, CHEST, CHLOC, CHLOC2,
CLAM, CLOCK1, CLOCK2, CLOSED, CLOSNG, CLSHNT, CLSMAX = 12, CLSSES,
COINS, COND[186], CONDS, CTEXT[13], CVAL[13], DALTLC, DETAIL,
DKILL, DOOR, DPRSSN, DRAGON, DSEEN[7], DTOTAL, DWARF, EGGS,
EMRALD, ENTER_ADV, ENTRNC, FIND_ADV, FISSUR, FIXD[101], FOOBAR, FOOD,
GRATE, HINT, HINTED[21], HINTLC[21], HINTS[21][5], HNTMAX,
HNTSIZ = 20, I, INVENT, IGO, IWEST, J, JADE, K, K2, KEY[186], KEYS, KK,
KNFLOC, KNIFE, KQ, L, LAMP, LIMIT, LINSIZ = 12500, LINUSE, LL,
LMWARN, LOC, LOCK, LOCSIZ = 185, LOCSND[186], LOOK,
LTEXT[186],
MAGZIN, MAXDIE, MAXTRS, MESH = 123456789,
MESSAG, MIRROR, MXSCOR,
NEWLOC, NOVICE, NUGGET, NUL, NUMDIE, OBJ, OBJSND[101],
OBJTXT[101], ODLOC[7], OGRE, OIL, OLDLC2, OLDLOC, OLDOBJ, OYSTER,
PANIC, PEARL, PILLOW, PLAC[101], PLANT, PLANT2, PROP[101], PYRAM,
RESER, ROD, ROD2, RTXSIZ = 277, RUBY, RUG, SAPPH, SAVED, SAY,
SCORE, SECT, SIGN, SNAKE, SPK, STEPS, STEXT[186], STICK,
STREAM, TABNDX, TALLY, THRESH, THROW, TK[21], TRAVEL[886], TRIDNT,
TRNDEX, TRNLUZ, TRNSIZ = 5, TRNVAL[6], TRNVLS, TROLL, TROLL2, TRVS,
TRVSIZ = 885, TTEXT[6], TURNS, URN, V1, V2, VASE, VEND, VERB,
VOLCAN, VRBSIZ = 35, VRSION = 25, WATER, WD1, WD1X, WD2, WD2X,
WZDARK = FALSE, ZZWORD;


/*
 * MAIN PROGRAM
 
 
 
 */







int main(int argc, const char * argv[]) {
    
    /*  ADVENTURE (REV 2: 20 TREASURES) */
    
    /*  HISTORY: ORIGINAL IDEA & 5-TREASURE VERSION (ADVENTURES) BY WILLIE CROWTHER
     *           15-TREASURE VERSION (ADVENTURE) BY DON WOODS, APRIL-JUNE 1977
     *           20-TREASURE VERSION (REV 2) BY DON WOODS, AUGUST 1978
     *        ERRATA FIXED: 78/12/25 */
    
    
    /* LOGICAL VARIABLES:
     *
     *  CLOSED SAYS WHETHER WE'RE ALL THE WAY CLOSED
     *  CLOSNG SAYS WHETHER IT'S CLOSING TIME YET
     *  CLSHNT SAYS WHETHER HE'S READ THE CLUE IN THE ENDGAME
     *  LMWARN SAYS WHETHER HE'S BEEN WARNED ABOUT LAMP GOING DIM
     *  NOVICE SAYS WHETHER HE ASKED FOR INSTRUCTIONS AT START-UP
     *  PANIC SAYS WHETHER HE'S FOUND OUT HE'S TRAPPED IN THE CAVE
     *  WZDARK SAYS WHETHER THE LOC HE'S LEAVING WAS DARK */
    
    
    /*  READ THE DATABASE IF WE HAVE NOT YET DONE SO */
    //@autoreleasepool {
        
    LINES_ADV = (long *)calloc(LINSIZ+1,sizeof(long));
    if(!LINES_ADV)
    {
        printf("Not enough memory!\n");
        exit(FALSE);
    }
    
    MAP2[1] = 0;
    if(!SETUP)initialise();
    
    //fRSPEAK(141);
    //fPSPEAK(100, -1);
    
    //printf(" Axe %ld ",AXE);
    //printf(" vocword %ld ",VOCWRD(12405,1));
    //printf(" %ld ",funcMakeWorD(12405));
    //PSPEAK(3, -1);
    
    //fYES(193, 50, 54);
    
    //SPEAK(1);
    if(SETUP <=0)
    {
        
        /*  UNLIKE EARLIER VERSIONS, ADVENTURE IS NO LONGER RESTARTABLE.  (THIS
         *  LETS US GET AWAY WITH MODIFYING THINGS SUCH AS OBJSND(BIRD) WITHOUT
         *  HAVING TO BE ABLE TO UNDO THE CHANGES LATER.)  IF A "USED" COPY IS
         *  RERUN, WE COME HERE AND TELL THE PLAYER TO RUN A FRESH COPY. */
        
        SpeakMessageFromSect6(201);
        exit(FALSE);
    }
    
    /*  START-UP, DWARF STUFF */
    
    SETUP= -1;
    I=RAN(-1);
    ZZWORD=RNDVOC(3,0)+MESH*2;
    
    //SpeakMessageFromSect6(65);
    //question about Instructions nr 65
    //wheter or not you are Novice
    NOVICE=fYES(65,1,0);
    
    NEWLOC=1;
    LOC=1;
    LIMIT=330;
    if(NOVICE)LIMIT=1000;
    
    /*  CAN'T LEAVE CAVE ONCE IT'S CLOSING (EXCEPT BY MAIN OFFICE). */
    
L2:    if(!OUTSID(NEWLOC) || NEWLOC == 0 || !CLOSNG) goto L71;
    SpeakMessageFromSect6(130);
    NEWLOC=LOC;
    if(!PANIC)CLOCK2=15;
    PANIC=TRUE;
    
    /*  SEE IF A DWARF HAS SEEN HIM AND HAS COME FROM WHERE HE WANTS TO GO.  IF SO,
     *  THE DWARF'S BLOCKING HIS WAY.  IF COMING FROM PLACE FORBIDDEN TO PIRATE
     *  (DWARVES ROOTED IN PLACE) LET HIM GET OUT (AND ATTACKED). */
    
L71:    if(NEWLOC == LOC || FORCED(LOC) || CNDBIT(LOC,3))
{
    
}
else
{
    for (I=1; I<=5; I++)
    {
        if(ODLOC[I] != NEWLOC || !DSEEN[I])
        {
            ;
        }
        else
        {
            NEWLOC=LOC;
            SpeakMessageFromSect6(2);
            break;
        }
    } /* end loop */

}
    
    
        LOC=NEWLOC;
        
        /*  DWARF STUFF.  SEE EARLIER COMMENTS FOR DESCRIPTION OF VARIABLES.  REMEMBER
         *  SIXTH DWARF IS PIRATE AND IS THUS VERY DIFFERENT EXCEPT FOR MOTION RULES. */
        
        /*  FIRST OFF, DON'T LET THE DWARVES FOLLOW HIM INTO A PIT OR A WALL.  ACTIVATE
         *  THE WHOLE MESS THE FIRST TIME HE GETS AS FAR AS THE HALL OF MISTS (LOC 15).
         *  IF NEWLOC IS FORBIDDEN TO PIRATE (IN PARTICULAR, IF IT'S BEYOND THE TROLL
         *  BRIDGE), BYPASS DWARF STUFF.  THAT WAY PIRATE CAN'T STEAL RETURN TOLL, AND
         *  DWARVES CAN'T MEET THE BEAR.  ALSO MEANS DWARVES WON'T FOLLOW HIM INTO DEAD
         *  END IN MAZE, BUT C'EST LA VIE.  THEY'LL WAIT FOR HIM OUTSIDE THE DEAD END. */
        
        if(LOC == 0 || FORCED(LOC) || CNDBIT(NEWLOC,3)) goto L2000;
        if(DFLAG != 0) goto L6000;
        if(INDEEP(LOC))DFLAG=1;
        goto L2000;
    
    
    
    
    /*  WHEN WE ENCOUNTER THE FIRST DWARF, WE KILL 0, 1, OR 2 OF THE 5 DWARVES.  IF
     *  ANY OF THE SURVIVORS IS AT LOC, REPLACE HIM WITH THE ALTERNATE. */
    
L6000:    if(DFLAG != 1) goto L6010;
    if(!INDEEP(LOC) || (PCT(95) && (!CNDBIT(LOC,4) || PCT(85)))) goto L2000;
    DFLAG=2;
    /* 6001 */ for (I=1; I<=2; I++) {
        J=1+RAN(5);
    L6001:    if(PCT(50))DLOC[J]=0;
    } /* end loop */
    /* 6002 */ for (I=1; I<=5; I++) {
        if(DLOC[I] == LOC)DLOC[I]=DALTLC;
    L6002:    ODLOC[I]=DLOC[I];
    } /* end loop */
    SpeakMessageFromSect6(3);
    DROP(AXE,LOC);
    goto L2000;
    
    /*  THINGS ARE IN FULL SWING.  MOVE EACH DWARF AT RANDOM, EXCEPT IF HE'S SEEN US
     *  HE STICKS WITH US.  DWARVES STAY DEEP INSIDE.  IF WANDERING AT RANDOM,
     *  THEY DON'T BACK UP UNLESS THERE'S NO ALTERNATIVE.  IF THEY DON'T HAVE TO
     *  MOVE, THEY ATTACK.  AND, OF COURSE, DEAD DWARVES DON'T DO MUCH OF ANYTHING. */
    
L6010:    DTOTAL=0;
    ATTACK=0;
    STICK=0;
    /* 6030 */ for (I=1; I<=6; I++) {
        if(DLOC[I] == 0) goto L6030;
        /*  FILL TK ARRAY WITH ALL THE PLACES THIS DWARF MIGHT GO. */
        J=1;
        KK=DLOC[I];
        KK=KEY[KK];
        if(KK == 0) goto L6016;
    L6012:    NEWLOC=Misc_ModuloFunction(labs(TRAVEL[KK])/1000,1000);
        {long x = J-1;
            if(NEWLOC > 300 || !INDEEP(NEWLOC) || NEWLOC == ODLOC[I] || (J > 1 &&
                                                                         NEWLOC == TK[x]) || J >= 20 || NEWLOC == DLOC[I] ||
               FORCED(NEWLOC) || (I == 6 && CNDBIT(NEWLOC,3)) ||
               labs(TRAVEL[KK])/1000000 == 100) goto L6014;}
        TK[J]=NEWLOC;
        J=J+1;
    L6014:    KK=KK+1;
        {long x = KK-1; if(TRAVEL[x] >= 0) goto L6012;}
    L6016:    TK[J]=ODLOC[I];
        if(J >= 2)J=J-1;
        J=1+RAN(J);
        ODLOC[I]=DLOC[I];
        DLOC[I]=TK[J];
        DSEEN[I]=(DSEEN[I] && INDEEP(LOC)) || (DLOC[I] == LOC || ODLOC[I] == LOC);
        if(!DSEEN[I]) goto L6030;
        DLOC[I]=LOC;
        if(I != 6) goto L6027;
        
        /*  THE PIRATE'S SPOTTED HIM.  HE LEAVES HIM ALONE ONCE WE'VE FOUND CHEST.  K
         *  COUNTS IF A TREASURE IS HERE.  IF NOT, AND TALLY=1 FOR AN UNSEEN CHEST, LET
         *  THE PIRATE BE SPOTTED.  NOTE THAT PLACE(CHEST)=0 MIGHT MEAN THAT HE'S
         *  THROWN IT TO THE TROLL, BUT IN THAT CASE HE'S SEEN THE CHEST (PROP=0). */
        
        if(LOC == CHLOC || PROP[CHEST] >= 0) goto L6030;
        K=0;
        for (J=50; J<=MAXTRS; J++)
        {
            /*  PIRATE WON'T TAKE PYRAMID FROM PLOVER ROOM OR DARK ROOM (TOO EASY!). */
            if(J == PYRAM && (LOC == PLAC[PYRAM] || LOC == PLAC[EMRALD])) goto L6020;
            if(TOTING(J)) goto L6021;
        L6020:    if(HERE(J))K=1;
        } /* end loop */
        if(TALLY == 1 && K == 0 && PLACE[CHEST] == 0 && HERE(LAMP) && PROP[LAMP]
           == 1) goto L6025;
        if(ODLOC[6] != DLOC[6] && PCT(20))SpeakMessageFromSect6(127);
        goto L6030;
        
    L6021:    if(PLACE[CHEST] == 0)
    {
        /*  INSTALL CHEST ONLY ONCE, TO INSURE IT IS THE LAST TREASURE IN THE LIST. */
        MOVE(CHEST,CHLOC);
        MOVE(MESSAG,CHLOC2);
    }
     SpeakMessageFromSect6(128);
        for (J=50; J<=MAXTRS; J++)
        {
            if(J == PYRAM && (LOC == PLAC[PYRAM] || LOC == PLAC[EMRALD])) goto L6023;
            if(AT(J) && FIXED[J] == 0)CARRY(J,LOC);
            if(TOTING(J))DROP(J,CHLOC);
        L6023:    /*etc*/ ;
        } /* end loop */
    L6024:    DLOC[6]=CHLOC;
        ODLOC[6]=CHLOC;
        DSEEN[6]=FALSE;
        goto L6030;
        
    L6025:    SpeakMessageFromSect6(186);
        MOVE(CHEST,CHLOC);
        MOVE(MESSAG,CHLOC2);
        goto L6024;
        
        /*  THIS THREATENING LITTLE DWARF IS IN THE ROOM WITH HIM! */
        
    L6027:    DTOTAL=DTOTAL+1;
        if(ODLOC[I] != DLOC[I]) goto L6030;
        ATTACK=ATTACK+1;
        if(KNFLOC >= 0)KNFLOC=LOC;
        if(RAN(1000) < 95*(DFLAG-2))STICK=STICK+1;
    L6030:    /*etc*/ ;
    } /* end loop */
    
    /*  NOW WE KNOW WHAT'S HAPPENING.  LET'S TELL THE POOR SUCKER ABOUT IT.
     *  NOTE THAT VARIOUS OF THE "KNIFE" MESSAGES MUST HAVE SPECIFIC RELATIVE
     *  POSITIONS IN THE fRSPEAK DATABASE. */
    
    if(DTOTAL == 0) goto L2000;
    fSetParametersForSpeak(1,DTOTAL,0);
    SpeakMessageFromSect6(4+1/DTOTAL);
    if(ATTACK == 0) goto L2000;
    if(DFLAG == 2)DFLAG=3;
    fSetParametersForSpeak(1,ATTACK,0);
    K=6;
    if(ATTACK > 1)K=250;
    SpeakMessageFromSect6(K);
    fSetParametersForSpeak(1,STICK,0);
    SpeakMessageFromSect6(K+1+2/(1+STICK));
    if(STICK == 0) goto L2000;
    OLDLC2=LOC;
    goto L99;
    
    
    
    
    
    
    /*  DESCRIBE THE CURRENT LOCATION AND (MAYBE) GET NEXT COMMAND. */
    
    /*  PRINT TEXT FOR CURRENT LOC. */
    
L2000:    if(LOC == 0) goto L99;
    printf("\n my location %ld \n",LOC );
    KK=STEXT[LOC];
    printf("\n Detail is %ld \n",DETAIL );
    if(Misc_ModuloFunction(ABB[LOC],ABBNUM) == 0 || KK == 0)KK=LTEXT[LOC];
    if(FORCED(LOC) || !DARK(0)) goto L2001;
    if(WZDARK && PCT(35)) goto L90;
    KK=RandomSection6Texts[16];
L2001:    if(TOTING(BEAR))SpeakMessageFromSect6(141);
    SPEAK(KK);
    K=1;
    if(FORCED(LOC)) goto L8;
    if(LOC == 33 && PCT(25) && !CLOSNG)SpeakMessageFromSect6(7);
    
    /*  PRINT OUT DESCRIPTIONS OF OBJECTS AT THIS LOCATION.  IF NOT CLOSING AND
     *  PROPERTY VALUE IS NEGATIVE, TALLY OFF ANOTHER TREASURE.  RUG IS SPECIAL
     *  CASE; ONCE SEEN, ITS PROP IS 1 (DRAGON ON IT) TILL DRAGON IS KILLED.
     *  SIMILARLY FOR CHAIN; PROP IS INITIALLY 1 (LOCKED TO BEAR).  THESE HACKS
     *  ARE BECAUSE PROP=0 IS NEEDED TO GET FULL SCORE. */
    
    if(DARK(0)) goto L2012;
    ABB[LOC]=ABB[LOC]+1;
    I=ATLOC[LOC];
L2004:    if(I == 0) goto L2012;
    OBJ=I;
    if(OBJ > 100)OBJ=OBJ-100;
    if(OBJ == STEPS && TOTING(NUGGET)) goto L2008;
    if(PROP[OBJ] >= 0) goto L2006;
    if(CLOSED) goto L2008;
    PROP[OBJ]=0;
    if(OBJ == RUG || OBJ == CHAIN)PROP[OBJ]=1;
    TALLY=TALLY-1;
    /*  NOTE: THERE USED TO BE A TEST HERE TO SEE WHETHER THE PLAYER HAD BLOWN IT
     *  SO BADLY THAT HE COULD NEVER EVER SEE THE REMAINING TREASURES, AND IF SO
     *  THE LAMP WAS ZAPPED TO 35 TURNS.  BUT THE TESTS WERE TOO SIMPLE-MINDED;
     *  THINGS LIKE KILLING THE BIRD BEFORE THE SNAKE WAS GONE (CAN NEVER SEE
     *  JEWELRY), AND DOING IT "RIGHT" WAS HOPELESS.  E.G., COULD CROSS TROLL
     *  BRIDGE SEVERAL TIMES, USING UP ALL AVAILABLE TREASURES, BREAKING VASE,
     *  USING COINS TO BUY BATTERIES, ETC., AND EVENTUALLY NEVER BE ABLE TO GET
     *  ACROSS AGAIN.  IF BOTTLE WERE LEFT ON FAR SIDE, COULD THEN NEVER GET EGGS
     *  OR TRIDENT, AND THE EFFECTS PROPAGATE.  SO THE WHOLE THING WAS FLUSHED.
     *  ANYONE WHO MAKES SUCH A GROSS BLUNDER ISN'T LIKELY TO FIND EVERYTHING
     *  ELSE ANYWAY (SO GOES THE RATIONALISATION). */
L2006:    KK=PROP[OBJ];
    if(OBJ == STEPS && LOC == FIXED[STEPS])KK=1;
    PSPEAK(OBJ,KK);
L2008:    I=LINK[I];
    goto L2004;
    
L2009:    K=54;
L2010:    SPK=K;
L2011:    SpeakMessageFromSect6(SPK);
    
L2012:    VERB=0;
    OLDOBJ=OBJ;
    OBJ=0;
    
    /*  CHECK IF THIS LOC IS ELIGIBLE FOR ANY HINTS.  IF BEEN HERE LONG ENOUGH,
     *  BRANCH TO HELP SECTION (ON LATER PAGE).  HINTS ALL COME BACK HERE EVENTUALLY
     *  TO FINISH THE LOOP.  IGNORE "HINTS" < 4 (SPECIAL STUFF, SEE DATABASE NOTES).
     */
    
L2600:    if(COND[LOC] < CONDS) goto L2603;
    /* 2602 */ for (HINT=1; HINT<=HNTMAX; HINT++) {
        if(HINTED[HINT]) goto L2602;
        if(!CNDBIT(LOC,HINT+10))HINTLC[HINT]= -1;
        HINTLC[HINT]=HINTLC[HINT]+1;
        if(HINTLC[HINT] >= HINTS[HINT][1]) goto L40000;
    L2602:    /*etc*/ ;
    } /* end loop */
    
    /*  KICK THE RANDOM NUMBER GENERATOR JUST TO ADD VARIETY TO THE CHASE.  ALSO,
     *  IF CLOSING TIME, CHECK FOR ANY OBJECTS BEING TOTED WITH PROP < 0 AND SET
     *  THE PROP TO -1-PROP.  THIS WAY OBJECTS WON'T BE DESCRIBED UNTIL THEY'VE
     *  BEEN PICKED UP AND PUT DOWN SEPARATE FROM THEIR RESPECTIVE PILES.  DON'T
     *  TICK CLOCK1 UNLESS WELL INTO CAVE (AND NOT AT Y2). */
    
L2603:    if(!CLOSED) goto L2605;
    if(PROP[OYSTER] < 0 && TOTING(OYSTER))PSPEAK(OYSTER,1);
    /* 2604 */ for (I=1; I<=100; I++) {
    L2604:    if(TOTING(I) && PROP[I] < 0)PROP[I]= -1-PROP[I];
    } /* end loop */
L2605:    WZDARK=DARK(0);
    if(KNFLOC > 0 && KNFLOC != LOC)KNFLOC=0;
    I=RAN(1);
    GETIN(WD1,WD1X,WD2,WD2X);
    
    /*  EVERY INPUT, CHECK "FOOBAR" FLAG.  IF ZERO, NOTHING'S GOING ON.  IF POS,
     *  MAKE NEG.  IF NEG, HE SKIPPED A WORD, SO MAKE IT ZERO. */
    
L2607:    FOOBAR=(FOOBAR>0 ? -FOOBAR : 0);
    TURNS=TURNS+1;
    if(TURNS != THRESH) goto L2608;
    SPEAK(TTEXT[TRNDEX]);
    TRNLUZ=TRNLUZ+TRNVAL[TRNDEX]/100000;
    TRNDEX=TRNDEX+1;
    THRESH= -1;
    if(TRNDEX <= TRNVLS)THRESH=Misc_ModuloFunction(TRNVAL[TRNDEX],100000)+1;
L2608:    if(VERB == SAY && WD2 > 0)VERB=0;
    if(VERB == SAY)
    {
        I=4090;
        goto Laction;
    }
    
    if(TALLY == 0 && INDEEP(LOC) && LOC != 33)CLOCK1=CLOCK1-1;
    
    if(CLOCK1 == 0)
    {
        PROP[GRATE]=0;
        PROP[FISSUR]=0;
        
        for (I=1; I<=6; I++)
        {
            DSEEN[I]=FALSE;
            DLOC[I]=0;
            
        } /* end loop */
        MOVE(TROLL,0);
        MOVE(TROLL+100,0);
        MOVE(TROLL2,PLAC[TROLL]);
        MOVE(TROLL2+100,FIXD[TROLL]);
        JUGGLE(CHASM);
        if (PROP[BEAR] != 3) DSTROY(BEAR);
        PROP[CHAIN]=0;
        FIXED[CHAIN]=0;
        PROP[AXE]=0;
        FIXED[AXE]=0;
        SpeakMessageFromSect6(129);
        CLOCK1= -1;
        CLOSNG=TRUE;
        goto L19999;
    }
    
    
    
    
    
    
    
    if(CLOCK1 < 0)CLOCK2=CLOCK2-1;
    if(CLOCK2 == 0)
    {
        /*  ONCE HE'S PANICKED, AND CLOCK2 HAS RUN OUT, WE COME HERE TO SET UP THE
         *  STORAGE ROOM.  THE ROOM HAS TWO LOCS, HARDWIRED AS 115 (NE) AND 116 (SW).
         *  AT THE NE END, WE PLACE EMPTY BOTTLES, A NURSERY OF PLANTS, A BED OF
         *  OYSTERS, A PILE OF LAMPS, RODS WITH STARS, SLEEPING DWARVES, AND HIM.  AT
         *  THE SW END WE PLACE GRATE OVER TREASURES, SNAKE PIT, COVEY OF CAGED BIRDS,
         *  MORE RODS, AND PILLOWS.  A MIRROR STRETCHES ACROSS ONE WALL.  MANY OF THE
         *  OBJECTS COME FROM KNOWN LOCATIONS AND/OR STATES (E.G. THE SNAKE IS KNOWN TO
         *  HAVE BEEN DESTROYED AND NEEDN'T BE CARRIED AWAY FROM ITS OLD "PLACE"),
         *  MAKING THE VARIOUS OBJECTS BE HANDLED DIFFERENTLY.  WE ALSO DROP ALL OTHER
         *  OBJECTS HE MIGHT BE CARRYING (LEST HE HAVE SOME WHICH COULD CAUSE TROUBLE,
         *  SUCH AS THE KEYS).  WE DESCRIBE THE FLASH OF LIGHT AND TRUNDLE BACK. */
        
        PROP[BOTTLE]=PUT(BOTTLE,115,1);
        PROP[PLANT]=PUT(PLANT,115,0);
        PROP[OYSTER]=PUT(OYSTER,115,0);
        OBJTXT[OYSTER]=3;
        PROP[LAMP]=PUT(LAMP,115,0);
        PROP[ROD]=PUT(ROD,115,0);
        PROP[DWARF]=PUT(DWARF,115,0);
        LOC=115;
        OLDLOC=115;
        NEWLOC=115;
        
        /*  LEAVE THE GRATE WITH NORMAL (NON-NEGATIVE) PROPERTY.  REUSE SIGN. */
        
        I=PUT(GRATE,116,0);
        I=PUT(SIGN,116,0);
        OBJTXT[SIGN]=OBJTXT[SIGN]+1;
        PROP[SNAKE]=PUT(SNAKE,116,1);
        PROP[BIRD]=PUT(BIRD,116,1);
        PROP[CAGE]=PUT(CAGE,116,0);
        PROP[ROD2]=PUT(ROD2,116,0);
        PROP[PILLOW]=PUT(PILLOW,116,0);
        
        PROP[MIRROR]=PUT(MIRROR,115,0);
        FIXED[MIRROR]=116;
        
        /* 11010 */ for (I=1; I<=100; I++) {
        L11010: if(TOTING(I))DSTROY(I);
        } /* end loop */
        
        SpeakMessageFromSect6(132);
        CLOSED=TRUE;
        goto L2;
    }
    
    
    if(PROP[LAMP] == 1)LIMIT=LIMIT-1;
    /*  ANOTHER WAY WE CAN FORCE AN END TO THINGS IS BY HAVING THE LAMP GIVE OUT.
     *  WHEN IT GETS CLOSE, WE COME HERE TO WARN HIM.  WE GO TO 12000 IF THE LAMP
     *  AND FRESH BATTERIES ARE HERE, IN WHICH CASE WE REPLACE THE BATTERIES AND
     *  CONTINUE.  12200 IS FOR OTHER CASES OF LAMP DYING.  12400 IS WHEN IT GOES
     *  OUT.  EVEN THEN, HE CAN EXPLORE OUTSIDE FOR A WHILE IF DESIRED. */
    

    printf(" Limit %ld battery? %d ", LIMIT,HERE(BATTER));
    if(LIMIT <= 30 && HERE(BATTER) && PROP[BATTER] == 0 && HERE(LAMP))
    {
        SpeakMessageFromSect6(188);
        PROP[BATTER]=1;
        if(TOTING(BATTER))DROP(BATTER,LOC);
        LIMIT=LIMIT+2500;
        LMWARN=FALSE;
        goto L19999;
    }
    if(LIMIT == 0) {
        LIMIT= -1;
        PROP[LAMP]=0;
        if(HERE(LAMP))SpeakMessageFromSect6(184);
        goto L19999;
    }
    if(LIMIT <= 30)
    {
        if(LMWARN || !HERE(LAMP)) goto L19999;
        LMWARN=TRUE;
        SPK=187;
        if(PLACE[BATTER] == 0)SPK=183;
        if(PROP[BATTER] == 1)SPK=189;
        SpeakMessageFromSect6(SPK);
        goto L19999;
    }
    
    
    
L19999: K=43;
    if(LIQLOC(LOC) == WATER)K=70;
    V1=VOCAB(WD1,-1);
    V2=VOCAB(WD2,-1);
    if(V1 == ENTER_ADV && (V2 == STREAM || V2 == 1000+WATER)) goto L2010;
    if(V1 == ENTER_ADV && WD2 > 0) goto L2800;
    if((V1 != 1000+WATER && V1 != 1000+OIL) || (V2 != 1000+PLANT && V2 !=
                                                1000+DOOR)) goto L2610;
    {long x = V2-1000; if(AT(x))WD2=funcMakeWorD(16152118);}
L2610:    if(V1 == 1000+CAGE && V2 == 1000+BIRD && HERE(CAGE) &&
             HERE(BIRD))WD1=funcMakeWorD(301200308);
L2620:    if(WD1 != funcMakeWorD(23051920)) goto L2625;
    IWEST=IWEST+1;
    if(IWEST == 10)SpeakMessageFromSect6(17);
L2625:    if(WD1 != funcMakeWorD( 715) || WD2 == 0) goto L2630;
    IGO=IGO+1;
    if(IGO == 10)SpeakMessageFromSect6(276);
L2630:    I=VOCAB(WD1,-1);
    if(I == -1) goto L3000;
    K=Misc_ModuloFunction(I,1000);
    KQ=I/1000+1;
    switch (KQ-1)
    {
        case 0: goto L8;
        case 1: I=5000; goto Laction;
        case 2: I=4000; goto Laction;
        case 3: goto L2010;
            
    }
    BUG(22);
    
    /*  GET SECOND WORD FOR ANALYSIS. */
    
L2800:    WD1=WD2;
    WD1X=WD2X;
    WD2=0;
    goto L2620;
    
    /*  GEE, I DON'T UNDERSTAND. */
    
L3000:    fSetParametersForSpeak(1,WD1,WD1X);
    SpeakMessageFromSect6(254);
    goto L2600;
    
    /* VERB AND OBJECT ANALYSIS MOVED TO SEPARATE MODULE. */

Laction:
    switch (action(I)) {
        case 2: goto L2;
        case 8: goto L8;
        case 2000: goto L2000;
        case 2009: goto L2009;
        case 2010: goto L2010;
        case 2011: goto L2011;
        case 2012: goto L2012;
        case 2600: goto L2600;
        case 2607: goto L2607;
        case 2630: goto L2630;
        case 2800: goto L2800;
        case 8000: goto L8000;
            /*  OH DEAR, HE'S DISTURBED THE DWARVES. */
        case 18999:
            SpeakMessageFromSect6(SPK);
        case 19000:
            SpeakMessageFromSect6(136);
            //END
            score(0);
    }
    BUG(99);
    
    /*  RANDOM INTRANSITIVE VERBS COME HERE.  CLEAR OBJ JUST IN CASE (SEE "ATTACK").
     */
    
    
    
    
L8000:    fSetParametersForSpeak(1,WD1,WD1X);
    SpeakMessageFromSect6(257);
    OBJ=0;
    goto L2600;
  
    
    
    

    
    /*  FIGURE OUT THE NEW LOCATION
     *
     *  GIVEN THE CURRENT LOCATION IN "LOC", AND A MOTION VERB NUMBER IN "K", PUT
     *  THE NEW LOCATION IN "NEWLOC".  THE CURRENT LOC IS SAVED IN "OLDLOC" IN CASE
     *  HE WANTS TO RETREAT.  THE CURRENT OLDLOC IS SAVED IN OLDLC2, IN CASE HE
     *  DIES.  (IF HE DOES, NEWLOC WILL BE LIMBO, AND OLDLOC WILL BE WHAT KILLED
     *  HIM, SO WE NEED OLDLC2, WHICH IS THE LAST PLACE HE WAS SAFE.) */
    
L8:    KK=KEY[LOC];
    NEWLOC=LOC;
    if(KK == 0)BUG(26);
    if(K == NUL) goto L2;
    if(K == BACK) goto L20;
    if(K == LOOK) goto L30;
    if(K == CAVE) goto L40;
    OLDLC2=OLDLOC;
    OLDLOC=LOC;
    
L9:    LL=labs(TRAVEL[KK]);
    if(Misc_ModuloFunction(LL,1000) == 1 || Misc_ModuloFunction(LL,1000) == K) goto L10;
    if(TRAVEL[KK] < 0) goto L50;
    KK=KK+1;
    goto L9;
    
L10:    LL=LL/1000;
L11:    NEWLOC=LL/1000;
    K=Misc_ModuloFunction(NEWLOC,100);
    if(NEWLOC <= 300) goto L13;
    if(PROP[K] != NEWLOC/100-3) goto L16;
L12:    if(TRAVEL[KK] < 0)BUG(25);
    KK=KK+1;
    NEWLOC=labs(TRAVEL[KK])/1000;
    if(NEWLOC == LL) goto L12;
    LL=NEWLOC;
    goto L11;
    
L13:    if(NEWLOC <= 100) goto L14;
    if(TOTING(K) || (NEWLOC > 200 && AT(K))) goto L16;
    goto L12;
    
L14:    if(NEWLOC != 0 && !PCT(NEWLOC)) goto L12;
L16:    NEWLOC=Misc_ModuloFunction(LL,1000);
    if(NEWLOC <= 300) goto L2;
    if(NEWLOC <= 500) goto L30000;
    SpeakMessageFromSect6(NEWLOC-500);
    NEWLOC=LOC;
    goto L2;
    
    /*  SPECIAL MOTIONS COME HERE.  LABELLING CONVENTION: STATEMENT NUMBERS NNNXX
     *  (XX=00-99) ARE USED FOR SPECIAL CASE NUMBER NNN (NNN=301-500). */
    
L30000: NEWLOC=NEWLOC-300;
    switch (NEWLOC)
    {
        case 1: goto L30100;
        case 2:
            /*  TRAVEL 302.  PLOVER TRANSPORT.  DROP THE EMERALD (ONLY USE SPECIAL TRAVEL IF
             *  TOTING IT), SO HE'S FORCED TO USE THE PLOVER-PASSAGE TO GET IT OUT.  HAVING
             *  DROPPED IT, GO BACK AND PRETEND HE WASN'T CARRYING IT AFTER ALL. */
            
            DROP(EMRALD,LOC);
            goto L12;
        case 3: goto L30300;
            
    }
    BUG(20);
    
    /*  TRAVEL 301.  PLOVER-ALCOVE PASSAGE.  CAN CARRY ONLY EMERALD.  NOTE: TRAVEL
     *  TABLE MUST INCLUDE "USELESS" ENTRIES GOING THROUGH PASSAGE, WHICH CAN NEVER
     *  BE USED FOR ACTUAL MOTION, BUT CAN BE SPOTTED BY "GO BACK". */
    
L30100: NEWLOC=99+100-LOC;
    if(HOLDNG == 0 || (HOLDNG == 1 && TOTING(EMRALD))) goto L2;
    NEWLOC=LOC;
    SpeakMessageFromSect6(117);
    goto L2;
    

    
    /*  TRAVEL 303.  TROLL BRIDGE.  MUST BE DONE ONLY AS SPECIAL MOTION SO THAT
     *  DWARVES WON'T WANDER ACROSS AND ENCOUNTER THE BEAR.  (THEY WON'T FOLLOW THE
     *  PLAYER THERE BECAUSE THAT REGION IS FORBIDDEN TO THE PIRATE.)  IF
     *  PROP(TROLL)=1, HE'S CROSSED SINCE PAYING, SO STEP OUT AND BLOCK HIM.
     *  (STANDARD TRAVEL ENTRIES CHECK FOR PROP(TROLL)=0.)  SPECIAL STUFF FOR BEAR. */
    
L30300: if(PROP[TROLL] != 1) goto L30310;
    PSPEAK(TROLL,1);
    PROP[TROLL]=0;
    MOVE(TROLL2,0);
    MOVE(TROLL2+100,0);
    MOVE(TROLL,PLAC[TROLL]);
    MOVE(TROLL+100,FIXD[TROLL]);
    JUGGLE(CHASM);
    NEWLOC=LOC;
    goto L2;
    
L30310: NEWLOC=PLAC[TROLL]+FIXD[TROLL]-LOC;
    if(PROP[TROLL] == 0)PROP[TROLL]=1;
    if(!TOTING(BEAR)) goto L2;
    SpeakMessageFromSect6(162);
    PROP[CHASM]=1;
    PROP[TROLL]=2;
    DROP(BEAR,NEWLOC);
    FIXED[BEAR]= -1;
    PROP[BEAR]=3;
    OLDLC2=NEWLOC;
    goto L99;
    
    /*  END OF SPECIALS. */
    
    /*  HANDLE "GO BACK".  LOOK FOR VERB WHICH GOES FROM LOC TO OLDLOC, OR TO OLDLC2
     *  IF OLDLOC HAS FORCED-MOTION.  K2 SAVES ENTRY -> FORCED LOC -> PREVIOUS LOC. */
    
L20:    K=OLDLOC;
    if(FORCED(K))K=OLDLC2;
    OLDLC2=OLDLOC;
    OLDLOC=LOC;
    K2=0;
    if(K == LOC)K2=91;
    if(CNDBIT(LOC,4))K2=274;
    if(K2 == 0) goto L21;
    SpeakMessageFromSect6(K2);
    goto L2;
    
L21:    LL=Misc_ModuloFunction((labs(TRAVEL[KK])/1000),1000);
    if(LL == K) goto L25;
    if(LL > 300) goto L22;
    J=KEY[LL];
    if(FORCED(LL) && Misc_ModuloFunction((labs(TRAVEL[J])/1000),1000) == K)K2=KK;
L22:    if(TRAVEL[KK] < 0) goto L23;
    KK=KK+1;
    goto L21;
    
L23:    KK=K2;
    if(KK != 0) goto L25;
    SpeakMessageFromSect6(140);
    goto L2;
    
L25:    K=Misc_ModuloFunction(labs(TRAVEL[KK]),1000);
    KK=KEY[LOC];
    goto L9;
    
    /*  LOOK.  CAN'T GIVE MORE DETAIL.  PRETEND IT WASN'T DARK (THOUGH IT MAY "NOW"
     *  BE DARK) SO HE WON'T FALL INTO A PIT WHILE STARING INTO THE GLOOM. */
    
L30:    if(DETAIL < 3)SpeakMessageFromSect6(15);
    DETAIL=DETAIL+1;
    WZDARK=FALSE;
    ABB[LOC]=0;
    goto L2;
    
    /*  CAVE.  DIFFERENT MESSAGES DEPENDING ON WHETHER ABOVE GROUND. */
    
L40:    K=58;
    if(OUTSID(LOC) && LOC != 8)K=57;
    SpeakMessageFromSect6(K);
    goto L2;
    
    /*  NON-APPLICABLE MOTION.  VARIOUS MESSAGES DEPENDING ON WORD GIVEN. */
    
L50:    SPK=12;
    if(K >= 43 && K <= 50)SPK=52;
    if(K == 29 || K == 30)SPK=52;
    if(K == 7 || K == 36 || K == 37)SPK=10;
    if(K == 11 || K == 19)SPK=11;
    if(VERB == FIND_ADV || VERB == INVENT)SPK=59;
    if(K == 62 || K == 65)SPK=42;
    if(K == 17)SPK=80;
    SpeakMessageFromSect6(SPK);
    goto L2;
    
    
    
    
    
    /*  "YOU'RE DEAD, JIM."
     *
     *  IF THE CURRENT LOC IS ZERO, IT MEANS THE CLOWN GOT HIMSELF KILLED.  WE'LL
     *  ALLOW THIS MAXDIE TIMES.  MAXDIE IS AUTOMATICALLY SET BASED ON THE NUMBER OF
     *  SNIDE MESSAGES AVAILABLE.  EACH DEATH RESULTS IN A MESSAGE (81, 83, ETC.)
     *  WHICH OFFERS REINCARNATION; IF ACCEPTED, THIS RESULTS IN MESSAGE 82, 84,
     *  ETC.  THE LAST TIME, IF HE WANTS ANOTHER CHANCE, HE GETS A SNIDE REMARK AS
     *  WE EXIT.  WHEN REINCARNATED, ALL OBJECTS BEING CARRIED GET DROPPED AT OLDLC2
     *  (PRESUMABLY THE LAST PLACE PRIOR TO BEING KILLED) WITHOUT CHANGE OF PROPS.
     *  THE LOOP RUNS BACKWARDS TO ASSURE THAT THE BIRD IS DROPPED BEFORE THE CAGE.
     *  (THIS KLUGE COULD BE CHANGED ONCE WE'RE SURE ALL REFERENCES TO BIRD AND CAGE
     *  ARE DONE BY KEYWORDS.)  THE LAMP IS A SPECIAL CASE (IT WOULDN'T DO TO LEAVE
     *  IT IN THE CAVE).  IT IS TURNED OFF AND LEFT OUTSIDE THE BUILDING (ONLY IF HE
     *  WAS CARRYING IT, OF COURSE).  HE HIMSELF IS LEFT INSIDE THE BUILDING (AND
     *  HEAVEN HELP HIM IF HE TRIES TO XYZZY BACK INTO THE CAVE WITHOUT THE LAMP!).
     *  OLDLOC IS ZAPPED SO HE CAN'T JUST "RETREAT". */
    
    /*  THE EASIEST WAY TO GET KILLED IS TO FALL INTO A PIT IN PITCH DARKNESS. */
    
L90:    SpeakMessageFromSect6(23);
    OLDLC2=LOC;
    
    /*  OKAY, HE'S DEAD.  LET'S GET ON WITH IT. */
    
L99:    if(CLOSNG)
{
    /*  HE DIED DURING CLOSING TIME.  NO RESURRECTION.  TALLY UP A DEATH AND EXIT. */
    
    SpeakMessageFromSect6(131);
    NUMDIE=NUMDIE+1;
    //end game
    score(0);
}
    NUMDIE=NUMDIE+1;
    if(!fYES(79+NUMDIE*2,80+NUMDIE*2,54)) score(0);
    if(NUMDIE == MAXDIE) score(0);
    PLACE[WATER]=0;
    PLACE[OIL]=0;
    if(TOTING(LAMP))PROP[LAMP]=0;
    for (J=1; J<=100; J++)
    {
        I=101-J;
        if(!TOTING(I)) goto L98;
        K=OLDLC2;
        if(I == LAMP)K=1;
        DROP(I,K);
    L98:    /*etc*/ ;
    } /* end loop */
    LOC=3;
    OLDLOC=LOC;
    goto L2000;
    
   

    
    
    
    
    /*  HINTS */
    
    /*  COME HERE IF HE'S BEEN LONG ENOUGH AT REQUIRED LOC(S) FOR SOME UNUSED HINT.
     *  HINT NUMBER IS IN VARIABLE "HINT".  BRANCH TO QUICK TEST FOR ADDITIONAL
     *  CONDITIONS, THEN COME BACK TO DO NEAT STUFF.  GOTO 40010 IF CONDITIONS ARE
     *  MET AND WE WANT TO OFFER THE HINT.  GOTO 40020 TO CLEAR HINTLC BACK TO ZERO,
     *  40030 TO TAKE NO ACTION YET. */
    
L40000:    switch (HINT-1)
    {
        case 0: goto L40100;
        case 1: goto L40200;
        case 2: goto
            L40300;
        case 3: goto L40400;
        case 4: goto L40500;
        case 5: goto
            L40600;
        case 6: goto L40700;
        case 7: goto L40800;
        case 8: goto
        L40900;
        case 9: goto L41000;
            
    }
    /*        CAVE  BIRD  SNAKE MAZE  DARK  WITT  URN   WOODS OGRE
     *        JADE */
    BUG(27);
    
L40010: HINTLC[HINT]=0;
    if(!fYES(HINTS[HINT][3],0,54)) goto L2602;
    fSetParametersForSpeak(1,HINTS[HINT][2],HINTS[HINT][2]);
    SpeakMessageFromSect6(261);
    HINTED[HINT]=fYES(175,HINTS[HINT][4],54);
    if(HINTED[HINT] && LIMIT > 30)LIMIT=LIMIT+30*HINTS[HINT][2];
L40020: HINTLC[HINT]=0;
L40030:  goto L2602;
    
    /*  NOW FOR THE QUICK TESTS.  SEE DATABASE DESCRIPTION FOR ONE-LINE NOTES. */
    
L40100: if(PROP[GRATE] == 0 && !HERE(KEYS)) goto L40010;
    goto L40020;
    
L40200: if(PLACE[BIRD] == LOC && TOTING(ROD) && OLDOBJ == BIRD) goto L40010;
    goto L40030;
    
L40300: if(HERE(SNAKE) && !HERE(BIRD)) goto L40010;
    goto L40020;
    
L40400: if(ATLOC[LOC] == 0 && ATLOC[OLDLOC] == 0 && ATLOC[OLDLC2] == 0 && HOLDNG > 1) goto L40010;
    goto L40020;
    
L40500: if(PROP[EMRALD] != -1 && PROP[PYRAM] == -1) goto L40010;
    goto L40020;
    
L40600:  goto L40010;
    
L40700: if(DFLAG == 0) goto L40010;
    goto L40020;
    
L40800: if(ATLOC[LOC] == 0 && ATLOC[OLDLOC] == 0 && ATLOC[OLDLC2] == 0) goto
    L40010;
    goto L40030;
    
L40900: I=ATDWRF(LOC);
    if(I < 0) goto L40020;
    if(HERE(OGRE) && I == 0) goto L40010;
    goto L40030;
    
L41000: if(TALLY == 1 && PROP[JADE] < 0) goto L40010;
    goto L40020;
    
    }
    
    
    
    /*  CAVE CLOSING AND SCORING */
    
    
    /*  THESE SECTIONS HANDLE THE CLOSING OF THE CAVE.  THE CAVE CLOSES "CLOCK1"
     *  TURNS AFTER THE LAST TREASURE HAS BEEN LOCATED (INCLUDING THE PIRATE'S
     *  CHEST, WHICH MAY OF COURSE NEVER SHOW UP).  NOTE THAT THE TREASURES NEED NOT
     *  HAVE BEEN TAKEN YET, JUST LOCATED.  HENCE CLOCK1 MUST BE LARGE ENOUGH TO GET
     *  OUT OF THE CAVE (IT ONLY TICKS WHILE INSIDE THE CAVE).  WHEN IT HITS ZERO,
     *  WE BRANCH TO 10000 TO START CLOSING THE CAVE, AND THEN SIT BACK AND WAIT FOR
     *  HIM TO TRY TO GET OUT.  IF HE DOESN'T WITHIN CLOCK2 TURNS, WE CLOSE THE
     *  CAVE; IF HE DOES TRY, WE ASSUME HE PANICS, AND GIVE HIM A FEW ADDITIONAL
     *  TURNS TO GET FRANTIC BEFORE WE CLOSE.  WHEN CLOCK2 HITS ZERO, WE BRANCH TO
     *  11000 TO TRANSPORT HIM INTO THE FINAL PUZZLE.  NOTE THAT THE PUZZLE DEPENDS
     *  UPON ALL SORTS OF RANDOM THINGS.  FOR INSTANCE, THERE MUST BE NO WATER OR
     *  OIL, SINCE THERE ARE BEANSTALKS WHICH WE DON'T WANT TO BE ABLE TO WATER,
     *  SINCE THE CODE CAN'T HANDLE IT.  ALSO, WE CAN HAVE NO KEYS, SINCE THERE IS A
     *  GRATE (HAVING MOVED THE FIXED OBJECT!) THERE SEPARATING HIM FROM ALL THE
     *  TREASURES.  MOST OF THESE PROBLEMS ARISE FROM THE USE OF NEGATIVE PROP
     *  NUMBERS TO SUPPRESS THE OBJECT DESCRIPTIONS UNTIL HE'S ACTUALLY MOVED THE
     *  OBJECTS. */
    
    /*  WHEN THE FIRST WARNING COMES, WE LOCK THE GRATE, DESTROY THE BRIDGE, KILL
     *  ALL THE DWARVES (AND THE PIRATE), REMOVE THE TROLL AND BEAR (UNLESS DEAD),
     *  AND SET "CLOSNG" TO TRUE.  LEAVE THE DRAGON; TOO MUCH TROUBLE TO MOVE IT.
     *  FROM NOW UNTIL CLOCK2 RUNS OUT, HE CANNOT UNLOCK THE GRATE, MOVE TO ANY
     *  LOCATION OUTSIDE THE CAVE, OR CREATE THE BRIDGE.  NOR CAN HE BE
     *  RESURRECTED IF HE DIES.  NOTE THAT THE SNAKE IS ALREADY GONE, SINCE HE GOT
     *  TO THE TREASURE ACCESSIBLE ONLY VIA THE HALL OF THE MT. KING.  ALSO, HE'S
     *  BEEN IN GIANT ROOM (TO GET EGGS), SO WE CAN REFER TO IT.  ALSO ALSO, HE'S
     *  GOTTEN THE PEARL, SO WE KNOW THE BIVALVE IS AN OYSTER.  *AND*, THE DWARVES
     *  MUST HAVE BEEN ACTIVATED, SINCE WE'VE FOUND CHEST. */
    


    

    



