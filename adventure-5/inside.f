C***   INSIDE .TRUE. IF LOCATION IS WELL WITHIN THE CAVE


       LOGICAL FUNCTION INSIDE(LOC)

C  INSIDE(LOC)  = TRUE IF LOCATION IS WELL WITHIN THE CAVE

       IMPLICIT INTEGER(A-Z)
       LOGICAL OUTSID,PORTAL
       INSIDE=.NOT.OUTSID(LOC).AND..NOT.PORTAL(LOC)
       RETURN
       END
