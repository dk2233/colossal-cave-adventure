C***  HINGED .TRUE. IF OBJ CAN BE OPENED


       LOGICAL FUNCTION HINGED(OBJ)

C  HINGED(OBJ)  = TRUE IF OBJECT CAN BE OPENED/SHUT.

       IMPLICIT INTEGER(A-Z)
       LOGICAL BITSET
      INTEGER*4 LOCCON,OBJCON
       COMMON /CONCOM/ LOCCON(250),OBJCON(150)

      HINGED=BITSET(OBJCON(OBJ),1)

       RETURN
       END
