C***   YESX



       LOGICAL FUNCTION YESX(X,Y,Z,SPK)

C  PRINT MESSAGE X, WAIT FOR YES/NO ANSWER.  IF YES, PRINT Y AND LEAVE YEA
C  TRUE; IF NO, PRINT Z AND LEAVE YEA FALSE.  SPK IS EITHER RSPEAK OR MSPEAK.

       IMPLICIT INTEGER(A-Z)
      REAL*8 REPLY,JUNK1,JUNK2,JUNK3
      EXTERNAL SPK

1       IF(X.NE.0)CALL SPK(X)
       CALL GETIN(REPLY,JUNK1,JUNK2,JUNK3)
       IF(REPLY.EQ.'YES     '.OR.REPLY.EQ.'Y       ')GOTO 10
       IF(REPLY.EQ.'NO      '.OR.REPLY.EQ.'N       ')GOTO 20
       PRINT 9
9       FORMAT(/' Please answer the question.')
       GOTO 1
10      YESX=.TRUE.
       IF(Y.NE.0)CALL SPK(Y)
       RETURN
20      YESX=.FALSE.
       IF(Z.NE.0)CALL SPK(Z)
       RETURN
       END