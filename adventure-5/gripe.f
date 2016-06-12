C***   GRIPE

       SUBROUTINE GRIPE(LOC,SCORE,CLOSNG,CLOSED)

C  ALLOW PLAYER TO WRITE ANY LENGTH MESSAGE TO A GRIPE FILE.  ALSO INCLUDE
C  ENVIRONMENTAL INFO, IN CASE THIS IS A BUG REPORT.

       IMPLICIT INTEGER(A-Z)
$INSERT SYSCOM>A$KEYS
      LOGICAL CLOSNG,CLOSED
       COMMON /DIECOM/ NUMDIE,MAXDIE,TURNS
      DIMENSION DDD(8),MSG(36),TTT(4),VEC(15),FILE(11),PART1(3),PART2(3)
       DOUBLEPRECISION CAVE,USER
      DATA FILE/'GRIPE       GRIPE.ADV '/
      DATA PART1/:157763,:163763,:173777/,PART2/:166755,:177755,
     1 :165676/

       ERCNT=0
       CALL DATE$A(DDD)
       CALL TIME$A(TTT)
      CALL TIMDAT(VEC,15)

10    CALL CLOS$A(10)
      FILE(4)=AND(PART1(1),PART2(1))
      FILE(5)=AND(PART1(2),PART2(2))
      FILE(6)=AND(PART1(3),PART2(3))
      IF(.NOT.OPEN$A(A$WRIT,'ADVENTURE>GRIPE.ADV',19,10))GOTO 200
      CALL GEND$A(10)

       CAVE='open.'
       IF(CLOSNG)CAVE='closing.'
       IF(CLOSED)CAVE='closed.'

       WRITE (14,20)(VEC(I),I=13,15),DDD,TTT,TURNS,SCORE,NUMDIE,CAVE
20      FORMAT(//' Player: ',3A2,4X,8A2,2X,4A2,
     1/I4,' Turns;',I5,' Points;',I3,' Resurrections;',
     2'  Cave is ',A6)
       CALL GSPEAK(LOC)
       WRITE (14,32)
32      FORMAT(' Text:')
       CALL MSPEAK(23)

55      READ(1,56)(MSG(I),I=1,35),K
56      FORMAT(36A2)
       IF(K.EQ.' ')GOTO 60
       CALL MSPEAK(24)
       GOTO 55

60      DO 62 I=1,35
       K=36-I
       IF(MSG(K).NE.'  ')GOTO 65
62      CONTINUE
       GOTO 90

65      WRITE (14,67)(MSG(I),I=1,K)
67      FORMAT(36A2)
       GOTO 55

90    CALL CLOS$A(10)
      DO 1001 I=4,6
1001  FILE(I)=' '
       RETURN

200     ERCNT=ERCNT+1
       IF(ERCNT.GT.3)GOTO 90
       PRINT 202,ERCNT
202     FORMAT(/' CAN''T OPEN GRIPE FILE.  WAIT...(',I1,')')
      CALL SLEEP$(00005000)
       GOTO 10

300     PRINT 302
302     FORMAT(/' BUG: CAN''T OPEN GRIPE FILE.')
       RETURN

       END
