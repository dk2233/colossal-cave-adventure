#include "misc.h"
#include "main.h"
#include "share.h"
#import <stdlib.h>
#import <Foundation/Foundation.h>

/*
 * SCORING AND WRAP-UP
 */

void score(long MODE)
{
	/* <0 if scoring, >0 if quitting, =0 if died or won */

/*  THE PRESENT SCORING ALGORITHM IS AS FOLLOWS:
 *     OBJECTIVE:          POINTS:        PRESENT TOTAL POSSIBLE:
 *  GETTING WELL INTO CAVE   25                    25
 *  EACH TREASURE < CHEST    12                    60
 *  TREASURE CHEST ITSELF    14                    14
 *  EACH TREASURE > CHEST    16                   224
 *  SURVIVING             (MAX-NUM)*10             30
 *  NOT QUITTING              4                     4
 *  REACHING "CLOSNG"        25                    25
 *  "CLOSED": QUIT/KILLED    10
 *            KLUTZED        25
 *            WRONG WAY      30
 *            SUCCESS        45                    45
 *  CAME TO WITT'S END        1                     1
 *  ROUND OUT THE TOTAL       2                     2
 *                                       TOTAL:   430
 *  POINTS CAN ALSO BE DEDUCTED FOR USING HINTS OR TOO MANY TURNS, OR FOR
 *  SAVING INTERMEDIATE POSITIONS. */

    SCORE=0;
	MXSCOR=0;

/*  FIRST TALLY UP THE TREASURES.  MUST BE IN BUILDING AND NOT BROKEN.
 *  GIVE THE POOR GUY 2 POINTS JUST FOR FINDING EACH TREASURE. */

    for (I=50; I<=MAXTRS; I++)
    {
        if(PTEXT[I] == 0) goto L20010;
        K=12;
        if(I == CHEST)K=14;
        if(I > CHEST)K=16;
        if(PROP[I] >= 0)SCORE=SCORE+2;
        if(PLACE[I] == 3 && PROP[I] == 0)SCORE=SCORE+K-2;
        MXSCOR=MXSCOR+K;
    L20010: /*etc*/ ;
    } /* end loop */

/*  NOW LOOK AT HOW HE FINISHED AND HOW FAR HE GOT.  MAXDIE AND NUMDIE TELL US
 *  HOW WELL HE SURVIVED.  DFLAG WILL
 *  TELL US IF HE EVER GOT SUITABLY DEEP INTO THE CAVE.  CLOSNG STILL INDICATES
 *  WHETHER HE REACHED THE ENDGAME.  AND IF HE GOT AS FAR AS "CAVE CLOSED"
 *  (INDICATED BY "CLOSED"), THEN BONUS IS ZERO FOR MUNDANE EXITS OR 133, 134,
 *  135 IF HE BLEW IT (SO TO SPEAK). */

	SCORE=SCORE+(MAXDIE-NUMDIE)*10;
	MXSCOR=MXSCOR+MAXDIE*10;
	if(MODE == 0)SCORE=SCORE+4;
	MXSCOR=MXSCOR+4;
	if(DFLAG != 0)SCORE=SCORE+25;
	MXSCOR=MXSCOR+25;
	if(CLOSNG)SCORE=SCORE+25;
	MXSCOR=MXSCOR+25;
	if(!CLOSED) goto L20020;
	if(BONUS == 0)SCORE=SCORE+10;
	if(BONUS == 135)SCORE=SCORE+25;
	if(BONUS == 134)SCORE=SCORE+30;
	if(BONUS == 133)SCORE=SCORE+45;
L20020: MXSCOR=MXSCOR+45;

/*  DID HE COME TO WITT'S END AS HE SHOULD? */

	if(PLACE[MAGZIN] == 108)SCORE=SCORE+1;
	MXSCOR=MXSCOR+1;

/*  ROUND IT OFF. */

	SCORE=SCORE+2;
	MXSCOR=MXSCOR+2;

/*  DEDUCT FOR HINTS/TURNS/SAVES.  HINTS < 4 ARE SPECIAL; SEE DATABASE DESC. */

	/* 20030 */ for (I=1; I<=HNTMAX; I++) {
L20030: if(HINTED[I])SCORE=SCORE-HINTS[I][2];
	} /* end loop */
	if(NOVICE)SCORE=SCORE-5;
	if(CLSHNT)SCORE=SCORE-10;
	SCORE=SCORE-TRNLUZ-SAVED;

/*  RETURN TO SCORE COMMAND IF THAT'S WHERE WE CAME FROM. */

	if(MODE < 0) return;

/*  THAT SHOULD BE GOOD ENOUGH.  LET'S TELL HIM ALL ABOUT IT. */

	if(SCORE+TRNLUZ+1 >= MXSCOR && TRNLUZ != 0)SpeakMessageFromSect6(242);
	if(SCORE+SAVED+1 >= MXSCOR && SAVED != 0)SpeakMessageFromSect6(143);
	fSetParametersForSpeak(1,SCORE,MXSCOR);
	fSetParametersForSpeak(3,TURNS,TURNS);
	SpeakMessageFromSect6(262);
	/* 20200 */ for (I=1; I<=CLSSES; I++) {
	if(CVAL[I] >= SCORE) goto L20210;
L20200: /*etc*/ ;
	} /* end loop */
	SPK=265;
	 goto L25000;

L20210: SPEAK(CTEXT[I]);
	SPK=264;
	if(I >= CLSSES) goto L25000;
	I=CVAL[I]+1-SCORE;
	fSetParametersForSpeak(1,I,I);
	SPK=263;
L25000: SpeakMessageFromSect6(SPK);
	exit(FALSE);

}
