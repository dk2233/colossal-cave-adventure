#include "misc.h"
#include "main.h"
#include "share.h"
#include "funcs.h"
#include <stdlib.h>



/* This stuff was broken off as part of an effort to get the main program
 * to compile without running out of memory.  We're called with a number
 * that says what label the caller wanted to "goto", and we return a
 * similar label number for the caller to "goto".
 */

/*  ANALYSE A VERB.  REMEMBER WHAT IT WAS, GO BACK FOR OBJECT IF SECOND WORD
 *  UNLESS VERB IS "SAY", WHICH SNARFS ARBITRARY SECOND WORD. */

int action(long STARTAT)
{
	switch(STARTAT)
    {
        case 4000:
            VERB=K;
            SPK=ACTSPK[VERB];
            if(WD2 > 0 && VERB != SAY) return(2800);
            if(VERB == SAY)OBJ=WD2;
            if(OBJ > 0) goto L4090;
            goto L4080;
        case 4090: goto L4090;
        case 5000: goto L5000;
    }
	BUG(99);



/*  ANALYSE AN INTRANSITIVE VERB (IE, NO OBJECT GIVEN YET). */

L4080:	switch (VERB-1)
    {
        case 0: goto L8010;
        case 1: return(8000);
        case 2:
            return(8000);
        case 3: goto L8040;
        case 4: return(2009);
        case 5: goto L8040;
        case 6: goto L8070;
        case 7:
            goto L8080;
        case 8: return(8000);
        case
            9: return(8000);
        case 10: return(2011);
        case 11: goto L9120;
        case 12:
            goto L9130;
        case 13: goto L8140;
        case 14: goto L9150;
        case 15:
            return(8000);
        case 16: return(8000);
        case 17: goto L8180;
        case 18:
            return(8000);
        case 19: goto L8200;
        case 20: return(8000);
        case 21:
            goto L9220;
        case 22: goto L9230;
        case 23: goto L8240;
        case 24:
            goto L8250;
        case 25:
            
            /*  BRIEF.  INTRANSITIVE ONLY.  SUPPRESS LONG DESCRIPTIONS AFTER FIRST TIME. */
            
            SPK=156;
            ABBNUM=10000;
            DETAIL=3;
            return(2011);
        case 26: goto L8270;
        case 27:
            return(8000);
        case 28: return(8000);
        case 29: goto L8300;
        case 30:
            goto L8310;
        case 31: goto L8320;
        case 32: goto L8330;
        case 33:
            goto L8340;
            
    }
/*	     TAKE DROP  SAY OPEN NOTH LOCK   ON  OFF WAVE CALM
 *	     WALK KILL POUR  EAT DRNK  RUB TOSS QUIT FIND INVN
 *	     FEED FILL BLST SCOR  FOO  BRF READ BREK WAKE SUSP
 *	     RESU FLY  LSTN ZZZZ */
	BUG(23);

/*  ANALYSE A TRANSITIVE VERB.
 using simple algoithm
 word are in section 4 of Text file
 from number 2001 to 2034
 
 for 2001 -1 we have carry -> that is case 0
 
 */

L4090:	switch (VERB-1) {
        
        /*  TRANSITIVE CARRY/DROP ARE IN SEPARATE FILE. */

    case 0: return(carry());
    case 1: return(discard(FALSE));
        
    case 2: goto L9030;
    case 3: goto L9040;
    case 4: return(2009);
    case 5: goto L9040;
		case 6: goto L9070;
    case 7: goto L9080;
    case 8: goto L9090;
    case 9: return(2011);
    case 10: return(2011);
    case 11: goto L9120;
    case 12:
		goto L9130;
    case 13: goto L9140;
    case 14: goto L9150;
    case 15:
		goto L9160; case 16: goto L9170; case 17: return(2011); case 18:
		goto L9190; case 19: goto L9190; case 20: goto L9210; case 21:
		goto L9220; case 22: goto L9230; case 23: return(2011); case 24:
		return(2011); case 25: return(2011); case 26: goto L9270; case 27:
		goto L9280; case 28: goto L9290; case 29: return(2011); case 30:
		return(2011); case 31: goto L9320; case 32: return(2011); case 33:
		goto L8340; }
/*	     TAKE DROP  SAY OPEN NOTH LOCK   ON  OFF WAVE CALM
 *	     WALK KILL POUR  EAT DRNK  RUB TOSS QUIT FIND INVN
 *	     FEED FILL BLST SCOR  FOO  BRF READ BREK WAKE SUSP
 *	     RESU FLY  LSTN ZZZZ */
	BUG(24);

/*  ANALYSE AN OBJECT WORD.  SEE IF THE THING IS HERE, WHETHER WE'VE GOT A VERB
 *  YET, AND SO ON.  OBJECT MUST BE HERE UNLESS VERB IS "FIND" OR "INVENT(ORY)"
 *  (AND NO NEW VERB YET TO BE ANALYSED).  WATER AND OIL ARE ALSO FUNNY, SINCE
 *  THEY ARE NEVER ACTUALLY DROPPED AT ANY LOCATION, BUT MIGHT BE HERE INSIDE
 *  THE BOTTLE OR URN OR AS A FEATURE OF THE LOCATION. */

L5000:	OBJ=K;
	if(!HERE(K)) goto L5100;
L5010:	if(WD2 > 0) return(2800);
	if(VERB != 0) goto L4090;
	fSetParametersForSpeak(1,WD1,WD1X);
	RandomMessageSpeakFromSect6(255);
	 return(2600);

L5100:	if(K != GRATE) goto L5110;
	if(LOC == 1 || LOC == 4 || LOC == 7)K=DPRSSN;
	if(LOC > 9 && LOC < 15)K=ENTRNC;
	if(K != GRATE) return(8);
L5110:	if(K == DWARF && ATDWRF(LOC) > 0) goto L5010;
	if((LIQ(0) == K && HERE(BOTTLE)) || K == LIQLOC(LOC)) goto L5010;
	if(OBJ != OIL || !HERE(URN) || PROP[URN] == 0) goto L5120;
	OBJ=URN;
	 goto L5010;
L5120:	if(OBJ != PLANT || !AT(PLANT2) || PROP[PLANT2] == 0) goto L5130;
	OBJ=PLANT2;
	 goto L5010;
L5130:	if(OBJ != KNIFE || KNFLOC != LOC) goto L5140;
	KNFLOC= -1;
	SPK=116;
	 return(2011);
L5140:	if(OBJ != ROD || !HERE(ROD2)) goto L5190;
	OBJ=ROD2;
	 goto L5010;
L5190:	if((VERB == FIND_ADV || VERB == INVENT) && WD2 <= 0) goto L5010;
	fSetParametersForSpeak(1,WD1,WD1X);
	RandomMessageSpeakFromSect6(256);
	 return(2012);




/*  ROUTINES FOR PERFORMING THE VARIOUS ACTION VERBS */

/*  STATEMENT NUMBERS IN THIS SECTION ARE 8000 FOR INTRANSITIVE VERBS, 9000 FOR
 *  TRANSITIVE, PLUS TEN TIMES THE VERB NUMBER.  MANY INTRANSITIVE VERBS USE THE
 *  TRANSITIVE CODE, AND SOME VERBS USE CODE FOR OTHER VERBS, AS NOTED BELOW. */

/*  CARRY, NO OBJECT GIVEN YET.  OK IF ONLY ONE OBJECT PRESENT. */

L8010:	if(ATLOC[LOC] == 0 || LINK[ATLOC[LOC]] != 0 || ATDWRF(LOC) > 0) return(8000);
	OBJ=ATLOC[LOC];



/*  SAY.  ECHO WD2 (OR WD1 IF NO WD2 (SAY WHAT?, ETC.).)  MAGIC WORDS OVERRIDE. */

L9030:	fSetParametersForSpeak(1,WD2,WD2X);
	if(WD2 <= 0)fSetParametersForSpeak(1,WD1,WD1X);
	if(WD2 > 0)WD1=WD2;
	I=VOCAB(WD1,-1);
	if(I == 62 || I == 65 || I == 71 || I == 2025 || I == 2034) goto L9035;
	RandomMessageSpeakFromSect6(258);
	 return(2012);

L9035:	WD2=0;
	OBJ=0;
	 return(2630);

/*  LOCK, UNLOCK, NO OBJECT GIVEN.  ASSUME VARIOUS THINGS IF PRESENT. */

L8040:	SPK=28;
	if(HERE(CLAM))OBJ=CLAM;
	if(HERE(OYSTER))OBJ=OYSTER;
	if(AT(DOOR))OBJ=DOOR;
	if(AT(GRATE))OBJ=GRATE;
	if(OBJ != 0 && HERE(CHAIN)) return(8000);
	if(HERE(CHAIN))OBJ=CHAIN;
	if(OBJ == 0) return(2011);

/*  LOCK, UNLOCK OBJECT.  SPECIAL STUFF FOR OPENING CLAM/OYSTER AND FOR CHAIN. */

L9040:	if(OBJ == CLAM || OBJ == OYSTER) goto L9046;
	if(OBJ == DOOR)SPK=111;
	if(OBJ == DOOR && PROP[DOOR] == 1)SPK=54;
	if(OBJ == CAGE)SPK=32;
	if(OBJ == KEYS)SPK=55;
	if(OBJ == GRATE || OBJ == CHAIN)SPK=31;
	if(SPK != 31 || !HERE(KEYS)) return(2011);
	if(OBJ == CHAIN) goto L9048;
	if(!CLOSNG) goto L9043;
	K=130;
	if(!PANIC)CLOCK2=15;
	PANIC=TRUE;
	 return(2010);

L9043:	K=34+PROP[GRATE];
	PROP[GRATE]=1;
	if(VERB == LOCK)PROP[GRATE]=0;
	K=K+2*PROP[GRATE];
	 return(2010);

/*  CLAM/OYSTER. */
L9046:	K=0;
	if(OBJ == OYSTER)K=1;
	SPK=124+K;
	if(TOTING(OBJ))SPK=120+K;
	if(!TOTING(TRIDNT))SPK=122+K;
	if(VERB == LOCK)SPK=61;
	if(SPK != 124) return(2011);
	DSTROY(CLAM);
	DROP(OYSTER,LOC);
	DROP(PEARL,105);
	 return(2011);

/*  CHAIN. */
L9048:	if(VERB == LOCK) goto L9049;
	SPK=171;
	if(PROP[BEAR] == 0)SPK=41;
	if(PROP[CHAIN] == 0)SPK=37;
	if(SPK != 171) return(2011);
	PROP[CHAIN]=0;
	FIXED[CHAIN]=0;
	if(PROP[BEAR] != 3)PROP[BEAR]=2;
	FIXED[BEAR]=2-PROP[BEAR];
	 return(2011);

L9049:	SPK=172;
	if(PROP[CHAIN] != 0)SPK=34;
	if(LOC != PLAC[CHAIN])SPK=173;
	if(SPK != 172) return(2011);
	PROP[CHAIN]=2;
	if(TOTING(CHAIN))DROP(CHAIN,LOC);
	FIXED[CHAIN]= -1;
	 return(2011);

/*  LIGHT.  APPLICABLE ONLY TO LAMP AND URN. */

L8070:	if(HERE(LAMP) && PROP[LAMP] == 0 && LIMIT >= 0)OBJ=LAMP;
	if(HERE(URN) && PROP[URN] == 1)OBJ=OBJ*100+URN;
	if(OBJ == 0 || OBJ > 100) return(8000);

L9070:
    if(OBJ == URN)
    {
    SPK=38;
    if(PROP[URN] == 0) return(2011);
    SPK=209;
    PROP[URN]=2;
    return(2011);
    }
    
	if(OBJ != LAMP) return(2011);
	SPK=184;
	if(LIMIT < 0) return(2011);
	PROP[LAMP]=1;
	RandomMessageSpeakFromSect6(39);
	if(WZDARK) return(2000);
	 return(2012);



/*  EXTINGUISH.  LAMP, URN, DRAGON/VOLCANO (NICE TRY). */

L8080:	if(HERE(LAMP) && PROP[LAMP] == 1)OBJ=LAMP;
	if(HERE(URN) && PROP[URN] == 2)OBJ=OBJ*100+URN;
	if(OBJ == 0 || OBJ > 100) return(8000);

L9080:	if(OBJ == URN) goto L9083;
	if(OBJ == LAMP) goto L9086;
	if(OBJ == DRAGON || OBJ == VOLCAN)SPK=146;
	 return(2011);

L9083:	PROP[URN]=PROP[URN]/2;
	SPK=210;
	 return(2011);

L9086:	PROP[LAMP]=0;
	RandomMessageSpeakFromSect6(40);
	if(DARK(0))RandomMessageSpeakFromSect6(16);
	 return(2012);

/*  WAVE.  NO EFFECT UNLESS WAVING ROD AT FISSURE OR AT BIRD. */

L9090:	if((!TOTING(OBJ)) && (OBJ != ROD || !TOTING(ROD2)))SPK=29;
	if(OBJ != ROD || !TOTING(OBJ) || (!HERE(BIRD) && (CLOSNG || !AT(FISSUR))))
		return(2011);
	if(HERE(BIRD))SPK=206+fmod(PROP[BIRD],2);
	if(SPK == 206 && LOC == PLACE[STEPS] && PROP[JADE] < 0) goto L9094;
	if(CLOSED) return(18999);
	if(CLOSNG || !AT(FISSUR)) return(2011);
	if(HERE(BIRD))RandomMessageSpeakFromSect6(SPK);
	PROP[FISSUR]=1-PROP[FISSUR];
	PSPEAK(FISSUR,2-PROP[FISSUR]);
	 return(2012);

L9094:	DROP(JADE,LOC);
	PROP[JADE]=0;
	TALLY=TALLY-1;
	SPK=208;
	 return(2011);

/*  ATTACK ALSO MOVED INTO SEPARATE MODULE. */

L9120:	return(attack());

/*  POUR.  IF NO OBJECT, OR OBJECT IS BOTTLE, ASSUME CONTENTS OF BOTTLE.
 *  SPECIAL TESTS FOR POURING WATER OR OIL ON PLANT OR RUSTY DOOR. */

L9130:	if(OBJ == BOTTLE || OBJ == 0)OBJ=LIQ(0);
	if(OBJ == 0) return(8000);
	if(!TOTING(OBJ)) return(2011);
	SPK=78;
	if(OBJ != OIL && OBJ != WATER) return(2011);
	if(HERE(URN) && PROP[URN] == 0) goto L9134;
	PROP[BOTTLE]=1;
	PLACE[OBJ]=0;
	SPK=77;
	if(!(AT(PLANT) || AT(DOOR))) return(2011);

	if(AT(DOOR)) goto L9132;
	SPK=112;
	if(OBJ != WATER) return(2011);
	PSPEAK(PLANT,PROP[PLANT]+3);
	PROP[PLANT]=fmod(PROP[PLANT]+1,3);
	PROP[PLANT2]=PROP[PLANT];
	K=NUL;
	 return(8);

L9132:	PROP[DOOR]=0;
	if(OBJ == OIL)PROP[DOOR]=1;
	SPK=113+PROP[DOOR];
	 return(2011);

L9134:	OBJ=URN;
	 goto L9220;

/*  EAT.  INTRANSITIVE: ASSUME FOOD IF PRESENT, ELSE ASK WHAT.  TRANSITIVE: FOOD
 *  OK, SOME THINGS LOSE APPETITE, REST ARE RIDICULOUS. */

L8140:	if(!HERE(FOOD)) return(8000);
L8142:	DSTROY(FOOD);
	SPK=72;
	 return(2011);

L9140:	if(OBJ == FOOD) goto L8142;
	if(OBJ == BIRD || OBJ == SNAKE || OBJ == CLAM || OBJ == OYSTER || OBJ ==
		DWARF || OBJ == DRAGON || OBJ == TROLL || OBJ == BEAR || OBJ ==
		OGRE)SPK=71;
	 return(2011);

/*  DRINK.  IF NO OBJECT, ASSUME WATER AND LOOK FOR IT HERE.  IF WATER IS IN
 *  THE BOTTLE, DRINK THAT, ELSE MUST BE AT A WATER LOC, SO DRINK STREAM. */

L9150:	if(OBJ == 0 && LIQLOC(LOC) != WATER && (LIQ(0) != WATER || !HERE(BOTTLE)))
		return(8000);
	if(OBJ == BLOOD) goto L9153;
	if(OBJ != 0 && OBJ != WATER)SPK=110;
	if(SPK == 110 || LIQ(0) != WATER || !HERE(BOTTLE)) return(2011);
	PROP[BOTTLE]=1;
	PLACE[WATER]=0;
	SPK=74;
	 return(2011);

L9153:	DSTROY(BLOOD);
	PROP[DRAGON]=2;
	OBJSND[BIRD]=OBJSND[BIRD]+3;
	SPK=240;
	 return(2011);

/*  RUB.  YIELDS VARIOUS SNIDE REMARKS EXCEPT FOR LIT URN. */

L9160:	if(OBJ != LAMP)SPK=76;
	if(OBJ != URN || PROP[URN] != 2) return(2011);
	DSTROY(URN);
	DROP(AMBER,LOC);
	PROP[AMBER]=1;
	TALLY=TALLY-1;
	DROP(CAVITY,LOC);
	SPK=216;
	 return(2011);

/*  THROW MOVED INTO SEPARATE MODULE. */

L9170:	return(throw());

/*  QUIT.  INTRANSITIVE ONLY.  VERIFY INTENT AND EXIT IF THAT'S WHAT HE WANTS. */

L8180:	if(YES_ADV(22,54,54)) score(1);
	 return(2012);

/*  FIND.  MIGHT BE CARRYING IT, OR IT MIGHT BE HERE.  ELSE GIVE CAVEAT. */

L9190:	if(AT(OBJ) || (LIQ(0) == OBJ && AT(BOTTLE)) || K == LIQLOC(LOC) || (OBJ ==
		DWARF && ATDWRF(LOC) > 0))SPK=94;
	if(CLOSED)SPK=138;
	if(TOTING(OBJ))SPK=24;
	 return(2011);

/*  INVENTORY.  IF OBJECT, TREAT SAME AS FIND.  ELSE REPORT ON CURRENT BURDEN. */

L8200:	SPK=98;
	/* 8201 */ for (I=1; I<=100; I++) {
	if(I == BEAR || !TOTING(I)) goto L8201;
	if(SPK == 98)RandomMessageSpeakFromSect6(99);
	BLKLIN=FALSE;
	PSPEAK(I,-1);
	BLKLIN=TRUE;
	SPK=0;
L8201:	/*etc*/ ;
	} /* end loop */
	if(TOTING(BEAR))SPK=141;
	 return(2011);

/* FEED/FILL ARE IN THE OTHER MODULE. */

L9210:	return(feed());
L9220:	return(fill());

/*  BLAST.  NO EFFECT UNLESS YOU'VE GOT DYNAMITE, WHICH IS A NEAT TRICK! */

L9230:	if(PROP[ROD2] < 0 || !CLOSED) return(2011);
	BONUS=133;
	if(LOC == 115)BONUS=134;
	if(HERE(ROD2))BONUS=135;
	RandomMessageSpeakFromSect6(BONUS);
	 score(0);

/*  SCORE.  CALL SCORING ROUTINE BUT TELL IT TO RETURN. */

L8240:	score(-1);
	fSetParametersForSpeak(1,SCORE,MXSCOR);
	fSetParametersForSpeak(3,TURNS,TURNS);
	RandomMessageSpeakFromSect6(259);
	 return(2012);

/*  FEE FIE FOE FOO (AND FUM).  ADVANCE TO NEXT STATE IF GIVEN IN PROPER ORDER.
 *  LOOK UP WD1 IN SECTION 3 OF VOCAB TO DETERMINE WHICH WORD WE'VE GOT.  LAST
 *  WORD ZIPS THE EGGS BACK TO THE GIANT ROOM (UNLESS ALREADY THERE). */

L8250:	K=VOCAB(WD1,3);
	SPK=42;
	if(FOOBAR == 1-K) goto L8252;
	if(FOOBAR != 0)SPK=151;
	 return(2011);

L8252:	FOOBAR=K;
	if(K != 4) return(2009);
	FOOBAR=0;
	if(PLACE[EGGS] == PLAC[EGGS] || (TOTING(EGGS) && LOC == PLAC[EGGS])) 
		return(2011);
/*  BRING BACK TROLL IF WE STEAL THE EGGS BACK FROM HIM BEFORE CROSSING. */
	if(PLACE[EGGS] == 0 && PLACE[TROLL] == 0 && PROP[TROLL] ==
		0)PROP[TROLL]=1;
	K=2;
	if(HERE(EGGS))K=1;
	if(LOC == PLAC[EGGS])K=0;
	MOVE(EGGS,PLAC[EGGS]);
	PSPEAK(EGGS,K);
	 return(2012);



/*  READ.  PRINT STUFF BASED ON OBJTXT.  OYSTER (?) IS SPECIAL CASE. */

L8270:	/* 8275 */ for (I=1; I<=100; I++) {
L8275:	if(HERE(I) && OBJTXT[I] != 0 && PROP[I] >= 0)OBJ=OBJ*100+I;
	} /* end loop */
	if(OBJ > 100 || OBJ == 0 || DARK(0)) return(8000);

L9270:	if(DARK(0)) goto L5190;
	if(OBJTXT[OBJ] == 0 || PROP[OBJ] < 0) return(2011);
	if(OBJ == OYSTER && !CLSHNT) goto L9275;
	PSPEAK(OBJ,OBJTXT[OBJ]+PROP[OBJ]);
	 return(2012);

L9275:	CLSHNT=YES_ADV(192,193,54);
	 return(2012);

/*  BREAK.  ONLY WORKS FOR MIRROR IN REPOSITORY AND, OF COURSE, THE VASE. */

L9280:	if(OBJ == MIRROR)SPK=148;
	if(OBJ == VASE && PROP[VASE] == 0) goto L9282;
	if(OBJ != MIRROR || !CLOSED) return(2011);
	SPK=197;
	 return(18999);

L9282:	SPK=198;
	if(TOTING(VASE))DROP(VASE,LOC);
	PROP[VASE]=2;
	FIXED[VASE]= -1;
	 return(2011);

/*  WAKE.  ONLY USE IS TO DISTURB THE DWARVES. */

L9290:	if(OBJ != DWARF || !CLOSED) return(2011);
	SPK=199;
	 return(18999);

/*  SUSPEND.  OFFER TO SAVE THINGS IN A FILE, BUT CHARGING SOME POINTS (SO
 *  CAN'T WIN BY USING SAVED GAMES TO RETRY BATTLES OR TO START OVER AFTER
 *  LEARNING ZZWORD). */

L8300:	SPK=201;
	RandomMessageSpeakFromSect6(260);
	if(!YES_ADV(200,54,54)) return(2012);
	SAVED=SAVED+5;
	KK= -1;

/*  THIS NEXT PART IS SHARED WITH THE "RESUME" CODE.  THE TWO CASES ARE
 *  DISTINGUISHED BY THE VALUE OF KK (-1 FOR SUSPEND, +1 FOR RESUME). */

L8305:	fGetDateTime(&I,&K);
	K=I+650*K;
	SAVWRD(KK,K);
	K=VRSION;
	SAVWRD(0,K);
	if(K != VRSION) goto L8312;
/*  HEREWITH ARE ALL THE VARIABLES WHOSE VALUES CAN CHANGE DURING A GAME,
 *  OMITTING A FEW (SUCH AS I, J, ATTACK) WHOSE VALUES BETWEEN TURNS ARE
 *  IRRELEVANT AND SOME WHOSE VALUES WHEN A GAME IS
 *  SUSPENDED OR RESUMED ARE GUARANTEED TO MATCH.  IF UNSURE WHETHER A VALUE
 *  NEEDS TO BE SAVED, INCLUDE IT.  OVERKILL CAN'T HURT.  PAD THE LAST SAVWDS
 *  WITH JUNK VARIABLES TO BRING IT UP TO 7 VALUES. */
	SAVWDS(ABBNUM,BLKLIN,BONUS,CLOCK1,CLOCK2,CLOSED,CLOSNG);
	SAVWDS(DETAIL,DFLAG,DKILL,DTOTAL,FOOBAR,HOLDNG,IWEST);
	SAVWDS(KNFLOC,LIMIT,LL,LMWARN,LOC,NEWLOC,NUMDIE);
	SAVWDS(OBJ,OLDLC2,OLDLOC,OLDOBJ,PANIC,SAVED,SETUP);
	SAVWDS(SPK,TALLY,THRESH,TRNDEX,TRNLUZ,TURNS,OBJTXT[OYSTER]);
	SAVWDS(VERB,WD1,WD1X,WD2,WZDARK,ZZWORD,OBJSND[BIRD]);
	SAVWDS(OBJTXT[SIGN],CLSHNT,NOVICE,K,K,K,K);
	SAVARR(ABB,LOCSIZ);
	SAVARR(ATLOC,LOCSIZ);
	SAVARR(DLOC,6);
	SAVARR(DSEEN,6);
	SAVARR(FIXED,100);
	SAVARR(HINTED,HNTSIZ);
	SAVARR(HINTLC,HNTSIZ);
	SAVARR(LINK,200);
	SAVARR(ODLOC,6);
	SAVARR(PLACE,100);
	SAVARR(PROP,100);
	SAVWRD(KK,K);
	if(K != 0) goto L8318;
	K=NUL;
	ZZWORD=RNDVOC(3,ZZWORD-MESH*2)+MESH*2;
	if(KK > 0) return(8);
	RandomMessageSpeakFromSect6(266);
	exit(FALSE);

/*  RESUME.  READ A SUSPENDED GAME BACK FROM A FILE. */

L8310:	KK=1;
	if(LOC == 1 && ABB[1] == 1) goto L8305;
	RandomMessageSpeakFromSect6(268);
	if(!YES_ADV(200,54,54)) return(2012);
	 goto L8305;

L8312:	fSetParametersForSpeak(1,K/10,fmod(K,10));
	fSetParametersForSpeak(3,VRSION/10,fmod(VRSION,10));
	RandomMessageSpeakFromSect6(269);
	 return(2000);

L8318:	RandomMessageSpeakFromSect6(270);
	exit(FALSE);

/*  FLY.  SNIDE REMARKS UNLESS HOVERING RUG IS HERE. */

L8320:	if(PROP[RUG] != 2)SPK=224;
	if(!HERE(RUG))SPK=225;
	if(SPK/2 == 112) return(2011);
	OBJ=RUG;

L9320:	if(OBJ != RUG) return(2011);
	SPK=223;
	if(PROP[RUG] != 2) return(2011);
	OLDLC2=OLDLOC;
	OLDLOC=LOC;
	NEWLOC=PLACE[RUG]+FIXED[RUG]-LOC;
	SPK=226;
	if(PROP[SAPPH] >= 0)SPK=227;
	RandomMessageSpeakFromSect6(SPK);
	 return(2);

/*  LISTEN.  INTRANSITIVE ONLY.  PRINT STUFF BASED ON OBJSND/LOCSND. */

L8330:	SPK=228;
	K=LOCSND[LOC];
	if(K == 0) goto L8332;
    RandomMessageSpeakFromSect6(labs(K));
	if(K < 0) return(2012);
	SPK=0;
L8332:	fSetParametersForSpeak(1,ZZWORD-MESH*2,0);
	/* 8335 */ for (I=1; I<=100; I++) {
	if(!HERE(I) || OBJSND[I] == 0 || PROP[I] < 0) goto L8335;
	PSPEAK(I,OBJSND[I]+PROP[I]);
	SPK=0;
	if(I == BIRD && OBJSND[I]+PROP[I] == 8)DSTROY(BIRD);
L8335:	/*etc*/ ;
	} /* end loop */
	 return(2011);

/*  Z'ZZZ (WORD GETS RECOMPUTED AT STARTUP; DIFFERENT EACH GAME). */

L8340:	if(!AT(RESER) && LOC != FIXED[RESER]-1) return(2011);
	PSPEAK(RESER,PROP[RESER]+1);
	PROP[RESER]=1-PROP[RESER];
	if(AT(RESER)) return(2012);
	OLDLC2=LOC;
	NEWLOC=0;
	RandomMessageSpeakFromSect6(241);
	 return(2);

}
