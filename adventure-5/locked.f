C***   LOCKED  .TRUE. IF LOCKABLE OBJ IS LOCKED

      LOGICAL FUNCTION LOCKED(OBJ)
      IMPLICIT INTEGER(A-Z)
      LOGICAL BITSET
      INTEGER*4 LOCCON,OBJCON
      COMMON/CONCOM/LOCCON(250),OBJCON(150)
      LOCKED=BITSET(OBJCON(OBJ),4)
      RETURN
      END