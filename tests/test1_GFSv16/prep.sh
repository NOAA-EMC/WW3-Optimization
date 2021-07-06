##!/bin/bash
set -eux


HOME=${PWD}

source input_vars.sh
source edit_inputs.sh

if [ ! -d ${input_i} ]
then 
   mkdir ${input_i}
else
echo -e "\e[34m${input_i} exists\e[0m"
fi 

#-----------------------------------------------------------------------------------#
#                           1- Fill namelist templates                              #
#-----------------------------------------------------------------------------------#
echo -e "\e[36mFill namelist templates\e[0m"
#inp prep
edit_ww3_multi < parm/ww3_multi.inp.IN > ${input_i}/ww3_multi_grdset_a.inp
edit_ww3_gint < parm/ww3_gint.inp.IN > ${input_i}/ww3_gint_grdset_a.inp
edit_ww3_fld < parm/ww3_ounf.inp.IN > ${input_i}/ww3_ounf.inp
edit_ww3_fld < parm/ww3_grib_gnh_10m.inp.IN > ${input_i}/ww3_grib_gnh_10m.inp
edit_ww3_fld < parm/ww3_grib_gsh_15m.inp.IN > ${input_i}/ww3_grib_gsh_15m.inp
edit_ww3_fld < parm/ww3_grib_aoc_9km.inp.IN > ${input_i}/ww3_grib_aoc_9km.inp
edit_ww3_fld < parm/ww3_grib_glo_15mxt.inp.IN > ${input_i}/ww3_grib_glo_15mxt.inp
edit_ww3_ounp < parm/ww3_ounp.inp.IN > ${input_i}/ww3_ounp_points.inp
edit_ww3_prnc_wind < parm/ww3_prnc.inp.IN > ${input_i}/ww3_prnc_glox_10m_wind.inp
edit_ww3_prnc_cur < parm/ww3_prnc.inp.IN > ${input_i}/ww3_prnc_glix_10m_current.inp
edit_ww3_prnc_ice < parm/ww3_prnc.inp.IN > ${input_i}/ww3_prnc_glix_10m_ice.inp
echo -e "\e[34minputs templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#ww3_grid parameters
edit_grdset < parm/grdset.IN > ${input_i}/grdset_a
edit_ww3_grid < parm/ww3_grid_gnh_10m.inp.IN > ${input_i}/ww3_grid_gnh_10m.inp
edit_ww3_grid < parm/ww3_grid_gsh_15m.inp.IN > ${input_i}/ww3_grid_gsh_15m.inp
edit_ww3_grid < parm/ww3_grid_aoc_9km.inp.IN > ${input_i}/ww3_grid_aoc_9km.inp
edit_ww3_grid < parm/input_nml.IN > ${input_i}/inp.nml
echo -e "\e[34mww3_grid.inp files are filled\e[0m"
#-----------------------------------------------------------------------------------#
#switch
cp grids/switch ${input_i}
echo -"\e[34mswitch is coppied\e[0m"
#-----------------------------------------------------------------------------------#
#statistical_analysis
cp parm/statistical_analysis.m ${input_i}
echo -"\e[34mstatistical_analysis.mis coppied\e[0m"
#-----------------------------------------------------------------------------------#
#forcing
edit_forcing < parm/retrieve_wind_hpss.sh.IN > forcing/retrieve_wind_hpss.sh
edit_forcing < parm/retrieve_ice.sh.IN > forcing/retrieve_ice.sh
edit_forcing < parm/retrieve_cur.sh.IN > forcing/retrieve_cur.sh
edit_forcing < parm/retrieve_restart_hpss.sh.IN > forcing/retrieve_restart_hpss.sh
echo -e "\e[34mForcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#observation
if [ ! -r ${HOME}/obs ]
then 
  mkdir ${HOME}/obs
fi
#satellite
edit_obs < parm/retrieve_sat_alt.sh.IN > obs/retrieve_sat_alt.sh
echo -e "\e[34mSatellite obs templates is filled\e[0m"
edit_obs < parm/retrieve_buoy.sh.IN > obs/retrieve_buoy.sh
echo -e "\e[34mBuoy obs templates is filled\e[0m"
#-----------------------------------------------------------------------------------#
#                     2- Forcing and Restart Retrieval                              #
#-----------------------------------------------------------------------------------#
cd ${HOME}/forcing
    echo -e "\e[36mForcing and Restart Retrieval ...\e[0m"
    if [ -f rtofs_current.nc ]
    then
       echo -e "\e[34mrtofs._current.nc exists\e[0m"
   else
       bash retrieve_cur.sh               
       echo -e "\e[31mcurrent file is retrieved\e[0m"
   fi
#-----------------------------------------------------------------------------------#
    if [ -f ice.nc ]
    then
       echo -e "\e[34mice.nc exists\e[0m"
    else
       bash retrieve_ice.sh
       echo -e "\e[31mice file is retrieved\e[0m"
   fi
#-----------------------------------------------------------------------------------#
    if [ -f gfs_wnd.nc ]
    then
      echo -e "\e[34mgfs_wnd.nc exists\e[0m"        
    else
      bash retrieve_wind_hpss.sh
      echo -e "\e[31mwind file is retrieved\e[0m"     
    fi
#-----------------------------------------------------------------------------------#
    if [[ -f ../${input_i}/restart.aoc_9km ]] && [[ -f ../${input_i}/restart.gnh_10m ]] && [[ -f ../${input_i}/restart.gsh_15m ]]
    then
       echo -e "\e[34mrestart files exist\e[0m"
    else
       bash retrieve_restart_hpss.sh
       echo -e "\e[31mrestart files are retrieved\e[0m"     
    fi
#-----------------------------------------------------------------------------------#
    if [[ -f ../${input_i}/rmp_src_to_dst_conserv_002_001.nc ]] && [[ -f ../${input_i}/rmp_src_to_dst_conserv_003_001.nc ]]
    then
       echo -e "\e[34mrmp_src_to_dst_conserv_002_001.nc and rmp_src_to_dst_conserv_003_001.nc files exist\e[0m"
    else
       bash retrieve_fix_file.sh
       echo -e "\e[31mfix files are retrieved\e[0m"
    fi
#-----------------------------------------------------------------------------------#
#                     3- Observation (satellite and buoy)                           #
#-----------------------------------------------------------------------------------#
cd ${HOME}/obs
    echo -e "\e[36mObservations Retrieval ...\e[0m"
#satellite
   if [ -f satellite_obs.nc ]
   then
       echo -e "\e[34msatellite_obs.nc file exists\e[0m"
    else
       bash retrieve_sat_alt.sh
       echo -e "\e[31mSatellite files are downloaded\e[0m"
   fi

#-----------------------------------------------------------------------------------#
# buoy
   if [ -f BUOY.nc ]
   then
       echo -e "\e[34mBUOY.nc file exists\e[0m"
    else
       bash retrieve_buoy.sh
       echo -e "\e[31mBuoy files are downloaded\e[0m"
   fi
