
###############################################################################
#
# Export variables to the default values
#  - first common variables, then model specific ones
#  - different machines, different defaults:
#
###############################################################################
export TEST_DIR="${PWD}"
export FORCING_DIR="${TEST_DIR}/forcing"
export OPTDIR="${PWD%/*/*/*}"
export BIN_DIR=${OPTDIR}/tests/bin
STARTDATE="2021-04-01"
startd=$(date -d $STARTDATE +%s)
forecast_day=1
endd=$(( $startd + $forecast_day*24*3600 ))
export SYEAR=$(date -d @$startd '+%Y')
export SMONTH=$(date -d @$startd '+%m')
export SDAY=$(date -d @$startd '+%d')
export SHOUR=$(date -d @$startd '+%2H')
export EYEAR=$(date -d @$endd '+%Y')
export EMONTH=$(date -d @$endd '+%m')
export EDAY=$(date -d @$endd '+%d')
export EHOUR=$(date -d @$endd '+%2H')

##### FIX files ###############################
export GLBDUMP=/scratch1/NCEPDEV/global/glopara/dump
export FIXwave=/scratch1/NCEPDEV/global/glopara/fix_nco_gfsv16/fix_wave_gfs/

#obs #########################################
#NDBC
export NDBCfiles=/scratch2/COASTAL/coastal/save/NDBC


#wind
#choose yes if the wind is taken directly from gfs, or no if it is taken from wave
export FORCING_GFS="YES"
export FHMAX=${FHMAX:-`expr $DAYS \* 24`}

#prnc
export WINDPRNCLINE="'WND' 'LL' T T"
export WINDDIMLINE="longitude latitude time"
export WINDVARLINE="UGRD_10maboveground VGRD_10maboveground"
export WINDFRCFILE="gfs_wnd.nc"

export ICEPRNCLINE="'ICE' 'LL' T T"
export ICEDIMLINE="lon lat time"
export ICEVARLINE="var91"
export ICEFRCFILE="ice.nc"

export CURPRNCLINE="'CUR' 'LL' T T"
export CURDIMLINE="lon lat time"
export CURVARLINE="u_velocity v_velocity"
export CURFRCFILE="rtofs_current.nc"

#waves
#restsrt interval (hr)
export WW3RSTDTHR='0'
#output interval (second)
export WW3OUTDTHR='3600'
export WW3OUTDTHRPNT='600'
export WW3OUTPUTTYPE=' '
export OUTPARS_WAV="WND HS FP DP PHS PTP PDIR"
export CPLILINE='$'
export ICELINE='$'
export WINDLINE='$'
export CURRLINE='$'
export NFGRIDS=0
export NFGRIDS=2
export NMGRIDS=3
export CPLILINE="'glix_10m'  F T F T F F F"
export WINDLINE="'glox_10m'  F F T F F F F"
export ww3gline="'gnh_10m' 'no' 'glix_10m' 'glox_10m' 'glix_10m'  'no' 'no' 'no'  1 10  0.00 1.00  F\n"
export ww3gline="${ww3gline}'gsh_15m' 'no' 'glix_10m' 'glox_10m' 'glix_10m'  'no' 'no' 'no'  2 20  0.00 1.00  F\n"
export ww3gline="${ww3gline}'aoc_9km' 'no' 'glix_10m' 'glox_10m' 'glix_10m'  'no' 'no' 'no'  3 30  0.00 1.00  F"

#GRIDSET
export MODELGRIDLINE="gnh_10m gsh_15m aoc_9km"
export INPUTGRIDLINE="glix_10m glox_10m"
export POINTGRIDLINE="points"
export INTGRIDLINE="glo_15mxt"

#GINT
export NOGRID='4'
export GRIDSLINE="'gnh_10m'\n"
export GRIDSLINE="$GRIDSLINE'gsh_15m'\n"
export GRIDSLINE="$GRIDSLINE'aoc_9km'\n"
export INTEGLINE="'glo_15mxt'"

#statistial analysis
export OUTGRIDED="glo_15mxt"
export VMIN_val='0.0'
export VMAX_val='1.0'

#physics parameters default
#SIN4 (wind input)
#(1)
export BETAMAXvar='1.315'
export BETAMAXmin='1.0'
export BETAMAXmax='2.0'
#(2)
export TAUWSHELTERvar='1.0'
export TAUWSHELTERmin='0'
export TAUWSHELTERmax='1.5'
#(3)
export SWELLFvar='0.798'
export SWELLFmin='0.5'
export SWELLFmax='1.2'
#(4)
export SWELLF2var='-0.0127'
export SWELLF2min='-0.03'
export SWELLF2max='-0.01'
#(5)
export SWELLF3var='0.0151'
export SWELLF3min='0.01'
export SWELLF3max='0.02'
#(6)
export SWELLF4var='100025.0'
export SWELLF4min='80000.0'
export SWELLF4max='150000.0'
#(7)
export SWELLF5var='1.1999'
export SWELLF5min='0.8'
export SWELLF5max='1.6'
#(8)
export SWELLF7var='235500.0'
export SWELLF7min='0.0'
export SWELLF7max='400000.0'
#SDS4 (dissipation)

#export FXFM3var='2.501'
#export FXFM3min='2.501'
#export FXFM3max='2.501'

#(9)
export SDSC2var='-2.1975e-05'
export SDSC2min='-2.5e-05'
export SDSC2max='0.0'
#(10)
export SDSCUMvar='-0.4032'
export SDSCUMmin='-0.5'
export SDSCUMmax='0.0'
#(11)
export SDSC5var='0.0'
export SDSC5min='0.0'
export SDSC5max='1.2'
#(12)
export SDSC6var='0.2978'
export SDSC6min='0.0'
export SDSC6max='1.0'
#(13)
export SDSBRvar='0.0009035'
export SDSBRmin='0.0008'
export SDSBRmax='0.0010'
#(14)
export SDSBCKvar='0.0'
export SDSBCKmin='0.0'
export SDSBCKmax='0.2'
#(15)
export SDSHCKvar='1.5'
export SDSHCKmin='0.0'
export SDSHCKmax='2.0'
#(16)
export SDSCOSvar='2.0'
export SDSCOSmin='0.0'
export SDSCOSmax='2.0'

#SNL1 (nonlinear interactions)
#(17)
export NLPROPvar='2.502e7'
export NLPROPmin='2.400e7'
export NLPROPmax='2.800e7'
