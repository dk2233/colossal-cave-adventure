C***   PCT


      LOGICAL FUNCTION PCT(N)

C  PCT(N)       = TRUE N% OF THE TIME (N INTEGER FROM 0 TO 100)

       IMPLICIT INTEGER(A-Z)
       PCT=RAN(100).LT.N
       RETURN
       END
