;;<<Default Template>><<MATRIX>><<Default>>;;
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.
RUN PGM=MATRIX MSG='Process Skims'
FILEO MATO[1] = "{SCENARIO_DIR}\intermediate_outputs\01_PROCESSED_SKIMS.MAT",
  MO=1-4,DEC=D,NAME=TIME,DISTANCE,EX_TIME, EX_DIST
FILEI MATI[1] = "{SCENARIO_DIR}\Output\01_HIGHWAY_SKIMS.MAT"

; The MATRIX module does not have any explicit phases.  The module does run within an implied ILOOP
; where I is the origin zones.  All user statements in the module are processed once for each origin.
; Matrix computation (MW[#]=) are solved for all values of J for each I.  Thus for a given origin zone I
; the values for all destination zones J are automatically computed.  The user can control the computations
; at each J by using a JLOOP.

FILLMW MW[1]=MI.1.1(2)                ; highway skims

; Reset invalid values to zero
  JLOOP
      IF (MW[1] > 1000)
          MW[1] = 0
      ENDIF

      IF (MW[2] > 1000)
          MW[2] = 0
      ENDIF


      ENDJLOOP

 JLOOP
  IF (I=1-27 && J=1-27) 
      MW[3] = MW[1]
 ENDIF
 
 IF (I=1-27 && J=1-27)
    MW[4] = MW[2]

 ENDIF
ENDJLOOP
      
      
ENDRUN
