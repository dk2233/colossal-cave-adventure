C***  PLURAL .TRUE. IF OBJ IS MULTIPLE OBJS


       LOGICAL FUNCTION PLURAL(OBJ)

C  PLURAL(OBJ)  = TRUE IF OBJECT IS A "BUNCH" OF THINGS (COINS, SHOES).

       IMPLICIT INTEGER(A-Z)
       LOGICAL BITSET
      INTEGER*4 LOCCON,OBJCON
       COMMON /CONCOM/ LOCCON(250),OBJCON(150)

      PLURAL=BITSET(OBJCON(OBJ),13)

       RETURN
       END
