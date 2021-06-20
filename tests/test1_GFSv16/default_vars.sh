
###############################################################################
#
# Export variables to the default values
#  - first common variables, then model specific ones
#  - different machines, different defaults:
#
###############################################################################
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

export FHMAX=${FHMAX:-`expr $DAYS \* 24`}
#waves
#restsrt interval (hr)
export WW3RSTDTHR='0'
#output interval (hr)
export WW3OUTDTHR='1'
export WW3OUTPUTTYPE=' '
export OUTPARS_WAV="WND HS FP DP PHS PTP PDIR"
export CPLILINE='$'
export ICELINE='$'
export WINDLINE='$'
export CURRLINE='$'
export NFGRIDS=0
export NFGRIDS=1
export NMGRIDS=3
export CPLILINE="'glo_15mxt'  F T F T F F F"
export ww3gline="'gnh_10m' 'no' 'glo_15mxt' 'native' 'glo_15mxt'  'no' 'no' 'no'  1 10  0.00 1.00  F\n"
export ww3gline="${ww3gline}'gsh_15m' 'no' 'glo_15mxt' 'native' 'glo_15mxt'  'no' 'no' 'no'  2 20  0.00 1.00  F\n"
export ww3gline="${ww3gline}'aoc_9km' 'no' 'glo_15mxt' 'native' 'glo_15mxt'  'no' 'no' 'no'  3 30  0.00 1.00  F"

#physics parameters default
#SIN4 (wind input)
#(1)
export BETAMAXvar='1.315'
export BETAMAXmin='1'
export BETAMAXmax='2'
#(2)
export TAUWSHELTERvar='1.0'
export TAUWSHELTEmin='0'
export TAUWSHELTEmax='1.5'
#(3)
export SWELLFvar='0.798'
export SWELLFmin='0.5'
export SWELLFmax='1.2'
#(4)
export SWELLF2var='-0.0127'
export SWELLF2min='−0.03'
export SWELLF2max='−0.01'
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

export FXFM3var='2.501'
export FXFM3min=''
export FXFM3max=''
#(9)
export SDSC2var='-2.1975e-05'
export SDSC2min='−2.5e-0.5'
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
export NLPROPvar='2.502E7'
export NLPROPmin='2.400E7'
export NLPROPmax='2.800E7'
