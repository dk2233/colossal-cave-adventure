C***   NEWHRS



       SUBROUTINE NEWHRS

C  SET UP NEW HOURS FOR THE CAVE.  SPECIFIED AS INVERSE--I.E., WHEN IS IT
C  CLOSED DUE TO PRIME TIME?  SEE HOURS (ABOVE) FOR DESC OF VARIABLES.

       IMPLICIT INTEGER(A-Z)
       DIMENSION HNAME(10)
      INTEGER*4 WKDAY,WKEND,HOLID,NEWHRX
      DOUBLE PRECISION MAGIC
       COMMON /WIZCOM/ WKDAY,WKEND,HOLID,HBEGIN,HEND,HNAME,
     1 SHORT,MAGIC,MAGNM,LATNCY,SAVED,SAVET,SETUP
       CALL MSPEAK(21)
       WKDAY=NEWHRX('WEEKDAYS: ')
       WKEND=NEWHRX('WEEKENDS: ')
       HOLID=NEWHRX('HOLIDAYS: ')
       CALL MSPEAK(22)
       CALL HOURS
       RETURN
       END
