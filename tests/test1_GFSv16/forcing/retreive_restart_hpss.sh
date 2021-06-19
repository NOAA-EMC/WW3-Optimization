#!/bin/bash
module load intel netcdf nco cdo hpss wgrib2
CDO=/apps/cdo/1.9.10/gnu/1.9.10/bin/cdo

FIXwave=/scratch1/NCEPDEV/global/glopara/fix_nco_gfsv16/fix_wave_gfs/
GLBDUMP=/scratch1/NCEPDEV/global/glopara/dump
WGRIB2=/apps/wgrib2/2.0.8/intel/18.0.3.222/bin/wgrib2

STARTDATE="2021-04-01"
ENDDATE="2021-04-02"

start=$(date -d $STARTDATE +%s)
end=$(date -d $ENDDATE +%s)


#-----------------------------------------------------------------------------------#
#                                       RESTART                                     #
#-----------------------------------------------------------------------------------#


d="$start"
d0=$(( $d - 21600 ))
    date -d @$d '+%Y-%m-%d %2H'
    YY=$(date -d @$d '+%Y')
    MM=$(date -d @$d '+%m')
    DD=$(date -d @$d '+%d')
    HH=$(date -d @$d '+%2H')
#  take f6 form one cycle before
    YY0=$(date -d @$d0 '+%Y')
    MM0=$(date -d @$d0 '+%m')
    DD0=$(date -d @$d0 '+%d')
    HH0=$(date -d @$d0 '+%2H')

#-----------------------------------------------------------------------------------#
FILEWAVE=(/NCEPPROD/hpssprod/runhistory/rh${YY0}/${YY0}${MM0}/${YY0}${MM0}${DD0}/com_gfs_prod_gdas.${YY0}${MM0}${DD0}_${HH0}.gdaswave_keep.tar)
aoc=./gdas.${YY0}${MM0}${DD0}/${HH0}/wave/restart/${YY}${MM}${DD}.${HH}0000.restart.aoc_9km
gnh=./gdas.${YY0}${MM0}${DD0}/${HH0}/wave/restart/${YY}${MM}${DD}.${HH}0000.restart.gnh_10m
gsh=./gdas.${YY0}${MM0}${DD0}/${HH0}/wave/restart/${YY}${MM}${DD}.${HH}0000.restart.gsh_15m


if [ ! -d ./gdas.${YY0}${MM0}${DD0} ]
then
htar -xvf $FILEWAVE ${aoc} ${gnh} ${gsh}
cp ${aoc} restart.aoc_9km
cp ${gnh} restart.gnh_10m
cp ${gsh} restart.gsh_15m
else
echo "${aoc} exists"
echo "${gnh} exists"
echo "${gsh} exists"
fi
