C***  HOLDNG .TRUE. IF HOLDING OBJ


       LOGICAL FUNCTION HOLDNG(OBJ)

C  HOLDNG(OBJ)  = TRUE IF THE OBJ IS BEING CARRIED IN HAND.

       IMPLICIT INTEGER(A-Z)
       COMMON /PLACOM/ ATLOC(250),LINK(300),PLACE(150),
     1          FIXED(150),MAXOBJ
       HOLDNG=PLACE(OBJ).EQ.-1
       RETURN
       END
