C***    MONITR    2 JANUARY 1978   MIKE ST JOHNS
C
C  THIS IS THE WIZARD'S MONITOR MODULE.  IT IS INVOKED FROM THE
C  MAIN PROGRAM BY TYPING  'WIZARD MODE' FOLLOWED BY 'WIZ'
C  THIS MODULE ALLOWS THE WIZARDS OF ADVENT TO MONITOR AND CONTROL
C  THE USE OF THE GAME.
C
C  MONITR SUPPORTS THE FOLLOWING FUNCTIONS:
C    SCAN     FIND OUT WHOS PLAYING
C    LOGOUT   DELETE A USER FROM THE GAME
C    WATCH    WATCH A USER PLAY THE GAME
C
C
C  WATCH AND LOGOUT TAKE ARGUMENTS IN THE FORM OF THE USER NUMBER.
C  TAKE CARE.  MONITR DOES NOT CURRENTLY CHECK *ANYTHING*!!
C
C
C  TO GET BACK TO ADVENT  TYPE 'EXIT'.
C
C
C  MIGHT AS WELL DESCRIBE SOME ARRAYS HERE:
C
C  THE COMMON LNKCOM IS SHARED BETWEEN ALL USERS.  I.E. THERE IS EXACTLY
C  ONE COPY OF LNKCOM! NO MATTER HOW MANY USERS ARE USING IT.
C
C  ACTIVE(MAXUSR)   IS THIS USER IN ADVENT?
C  USER(15,MAXUSR)  COPIES OF ALL USERS TIMDAT VECTOR  (SET BY LOGIN SUB)
C  MESSGS(32)       IF 0, NO MESSAGES PENDING, IF -1 MESSAGE PENDING IN TEXT
C                   IF >0 THEN IS A POINTER TO A MESSAGE IN LINES BUFFER
C                   AND CAN BE PRINTED BY A CALL TO SPEAK.  MESSGS IS INT*4
C  MONITO(32)       WHICH WIZARD IS WATCHING THIS USER? ZERO IF NONE.
C  TEXT(70,32)      TEXT FROM THE WATCHED USERS GETLIN BUFFER.
C
C
      SUBROUTINE MONITR
      IMPLICIT INTEGER(A-Z)
      COMMON/WRUCOM/ME
      COMMON/LNKCOM/ACTIVE(32),USER(15,32),MESSGS(32),MONITO(32),
     1  TEXT(70,32)
      REAL*8 WORD1,WORD2(1),X,Y
      INTEGER*4 MESSGS,M
      LOGICAL ACTIVE
      DIMENSION MESS(70)
      DIMENSION VEC(15)
C  SCAN.  PRINT ALL USERS AND THE AMOUNT OF TIME THEY'VE BEEN ON
10    CALL TIMDAT(VEC,15)
      DO 20 I=1,32
      IF(.NOT.ACTIVE(I))GOTO 20
      MIN=VEC(4)-USER(4,I)
      IF(MIN.LT.0)MIN=MIN+1440
      WRITE(1,105)(USER(J,I),J=12,15),MIN
105   FORMAT(I2,'\',3A2,'\',3X,I8)
20    CONTINUE
30    CALL GETIN(WORD1,X,WORD2,Y)
      IF(WORD1.EQ.'EXIT    ')RETURN
      IF(WORD1.EQ.'SCAN    ')GOTO 10
      IF(WORD1.EQ.'WATCH   ')GOTO 50
      IF(WORD1.EQ.'>       ')GOTO 60
      IF(WORD1.NE.'LOGOUT  ')GOTO 10
40    IF(WORD2(1).EQ.0.0D0)GOTO 30    /*  WATCH MUST HAVE USER NUMBER
      DECODE(2,101,WORD2,ERR=200)BYE  /* ONLY FIRST TWO CHARS
101   FORMAT(I2)
      WRITE(1,109)BYE
109   FORMAT('Logging user ',I4,' off of ADVENTure.')
      ACTIVE(BYE)=.FALSE. /*  IF ACTIVE FOR A USER IS .FALSE. THE
                          /*  USER PROGRAM TAKES CARE OF GETTING RID OF HIM
      GOTO 30
200   WRITE(1,103)
103   FORMAT('Problems converting logout number')
      GOTO 30
201   WRITE(1,202)
202   FORMAT('Problems converting watch number')
      GOTO 30
50    IF(WORD2(1).EQ.0.0D0)GOTO 30
      DECODE(2,101,WORD2,ERR=201)WATCH
      CALL SEM$DR(ME,CODE)
55    IF(MONITO(WATCH).LT.0.AND.ACTIVE(WATCH))GOTO 55
      IF(MONITO(WATCH).NE.0)GOTO 10
      MONITO(WATCH)=ME
      MESSGS(WATCH)=0
      CALL SEM$NF(ME,CODE)
      GOTO 52
51    CHAR=0
      CALL ENTER(DUMMY,2,1,TIME,CHAR)
      IF(CHAR.EQ.0)GOTO 52
      MONITO(WATCH)=0
      CALL SEM$DR(ME,CODE)
      GOTO 30
52    IF(MESSGS(WATCH).EQ.0)GOTO 51
      M=MESSGS(WATCH)
      MESSGS(WATCH)=0
      IF(M.LT.0)GOTO 53
      CALL SEM$NF(ME,CODE)
      CALL SPEAK(M)
      GOTO 52
53    DO 54 I=1,70
54    MESS(I)=TEXT(I,WATCH)
      CALL SEM$NF(ME,CODE)
      WRITE(1,112)MESS
112   FORMAT(70A1)
      GOTO 52
60    DECODE(2,101,WORD2,ERR=201)WHO
      READ(1,62)(TEXT(I,ME),I=1,70)
      MONITO(WHO)=-ME
      GOTO 10
62    FORMAT(70A1)
      END
