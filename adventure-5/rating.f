C***   RATING

       SUBROUTINE RATING(SCORE,MXSCOR,BONUS,GAVEUP,SCORNG,CLOSNG,CLOSED)

C  CALCULATE WHAT THE PLAYER'S SCORE WOULD BE IF HE QUIT NOW.
C  THIS MAY BE THE END OF THE GAME, OR HE MAY JUST BE WONDERING
C  HOW HE IS DOING.  ALSO, PRINT IT AS PART OF A GRIPE REPORT.

       IMPLICIT INTEGER(A-Z)
       LOGICAL TREASR,GAVEUP,CLOSNG,CLOSED,SCORNG,HINTED
       COMMON /MNECOM/ BACK,CAVE,DPRSSN,ENTRNC,EXIT,GO,LOOK,NULL,
     1 AXE,BEAR,BOAT,BOOK,BOOK2,BOOTH,CARVNG,CHASM,CHASM2,DOOR,GNOME,
     2 GRATE,LAMP,PDOOR,PLANT,PLANT2,ROCKS,ROD,ROD2,SAFE,
     3 TDOOR,TDOOR2,TROLL,TROLL2,EMRALD,SPICES,
     4 FIND,YELL,INVENT,LEAVE,POUR,SAY,TAKE,THROW,
     5 KILLED,IWEST,PHUCE(2,4),TTK(20)
       COMMON /DIECOM/ NUMDIE,MAXDIE,TURNS
       COMMON /DWFCOM/ DWARF,KNIFE,KNFLOC,DFLAG,DSEEN(6),DLOC(6),
     1  ODLOC(6),DWFMAX
       COMMON /HNTCOM/ HINTLC(20),HINTED(20),HINTS(20,4),HNTSIZ,HNTMIN
      INTEGER*4 POINTS
       COMMON /OBJCOM/ PLAC(150),FIXD(150),WEIGHT(150),PROP(150),
     1          POINTS(150)
       COMMON /PLACOM/ ATLOC(250),LINK(300),PLACE(150),
     1          FIXED(150),MAXOBJ
       DIMENSION TK(20)

C  THE PRESENT SCORING ALGORITHM IS AS FOLLOWS:
C  (TREASURE POINTS ARE EXPLAINED IN A FOLLOWING COMMENT)
C     OBJECTIVE:          POINTS:        PRESENT TOTAL POSSIBLE:
C  GETTING WELL INTO CAVE   25                    25
C  TOTAL POSSIBLE FOR TREASURES (+MAG)           376
C  SURVIVING             (MAX-NUM)*10             30
C  NOT QUITTING              4                     4
C  REACHING "CLOSNG"        20                    20
C  "CLOSED": QUIT/KILLED    10
C            KLUTZED        20
C            WRONG WAY      25
C            SUCCESS        30                    30
C  ROUND OUT THE TOTAL      16                    16
C                                       TOTAL:   501
C  (POINTS CAN ALSO BE DEDUCTED FOR USING HINTS.)

       SCORE=0
       MXSCOR=0

C  FIRST TALLY UP THE TREASURES.  MUST BE IN BUILDING AND NOT BROKEN.
C  GIVE THE POOR GUY PARTIAL SCORE JUST FOR FINDING EACH TREASURE.
C  GETS FULL SCORE, TK(3), FOR OBJ IF:
C       OBJ IS AT LOC TK(1), AND
C       OBJ HAS PROP VALUE OF TK(2)
C
C               WEIGHT          TOTAL POSSIBLE
C  MAGAZINE     1 (ABSOLUTE)            1
C
C  ALL THE FOLLOWING ARE MULTIPLIED BY 5 (RANGE 5-25):
C  BOOK         2
C  CASK         3 (WITH WINE ONLY)
C  CHAIN        4 (MUST ENTER VIA STYX)
C  CHEST        5
C  CLOAK        3
C  CLOVER       1
C  COINS        5
C  CROWN        2
C  CRYSTAL-BALL 2
C  DIAMONDS     2
C  EGGS         3
C  EMERALD      3
C  GRAIL        2
C  HORN         2
C  JEWELS       1
C  LYRE         1
C  NUGGET       2
C  PEARL        4
C  PYRAMID      4
C  RADIUM       4
C  RING         4
C  RUG          3
C  SAPPHIRE     1
C  SHOES        3
C  SPICES       1
C  SWORD        4
C  TRIDENT      2
C  VASE         2
C       TOTAL: 75 * 5 = 375 + 1 ==> 376

       DO 1010 OBJ=1,MAXOBJ
       IF(POINTS(OBJ).EQ.0)GOTO 1010
       DO 1005 I=1,3
1005  TK(I)=INTS(IABS(MOD((POINTS(OBJ)/INTL(1000)**(I-1)),1000)))
       IF(POINTS(OBJ).LT.0) TK(1)=-TK(1)
       K=0
       IF(.NOT.TREASR(OBJ))GOTO 1007
       K=TK(3)*2
       IF(PROP(OBJ).GE.0)SCORE=SCORE+K
       TK(3)=TK(3)*5
1007    IF(PLACE(OBJ).EQ.TK(1).AND.PROP(OBJ).EQ.TK(2).AND.
     1  (PLACE(OBJ).NE.-CHEST.OR.PLACE(CHEST).EQ.3).AND.
     2  (PLACE(OBJ).NE.-SHIELD.OR.PLACE(SHIELD).EQ.-SAFE))
     3  SCORE=SCORE+TK(3)-K
       MXSCOR=MXSCOR+TK(3)
1010    CONTINUE

C  NOW LOOK AT HOW HE FINISHED AND HOW FAR HE GOT.  MAXDIE AND NUMDIE TELL US
C  HOW WELL HE SURVIVED.  GAVEUP SAYS WHETHER HE EXITED VIA QUIT.  DFLAG WILL
C  TELL US IF HE EVER GOT SUITABLY DEEP INTO THE CAVE.  CLOSNG STILL INDICATES
C  WHETHER HE REACHED THE ENDGAME.  AND IF HE GOT AS FAR AS "CAVE CLOSED"
C  (INDICATED BY "CLOSED"), THEN BONUS IS ZERO FOR MUNDANE EXITS OR 133, 134,
C  135 IF HE BLEW IT (SO TO SPEAK).

       SCORE=SCORE+(MAXDIE-NUMDIE)*10
       MXSCOR=MXSCOR+MAXDIE*10
       IF(.NOT.(SCORNG.OR.GAVEUP))SCORE=SCORE+4
       MXSCOR=MXSCOR+4
       IF(DFLAG.NE.0)SCORE=SCORE+25
       MXSCOR=MXSCOR+25
       IF(CLOSNG)SCORE=SCORE+20
       MXSCOR=MXSCOR+20
       IF(.NOT.CLOSED)GOTO 1020
       IF(BONUS.EQ.0)SCORE=SCORE+10
       IF(BONUS.EQ.135)SCORE=SCORE+20
       IF(BONUS.EQ.134)SCORE=SCORE+25
       IF(BONUS.EQ.133)SCORE=SCORE+30
1020    MXSCOR=MXSCOR+30

C  ROUND IT OFF.

       SCORE=SCORE+15
       MXSCOR=MXSCOR+15

C  DEDUCT POINTS FOR HINTS.  HINTS < HNTMIN ARE SPECIAL; SEE DATABASE DESCRIPTIO

       DO 1030 I=1,HNTMAX
1030    IF(HINTED(I))SCORE=SCORE-HINTS(I,2)

       RETURN
       END
