#!/bin/bash
set -eux

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
echo -e "\e[36mFilling namelist templates ...\e[0m"
#inp prep
edit_ww3_multi < ${TEST_DIR}/parm/ww3_multi.inp.IN > ${TEST_DIR}/${input_i}/ww3_multi_grdset_a.inp
edit_ww3_gint  < ${TEST_DIR}/parm/ww3_gint.inp.IN > ${TEST_DIR}/${input_i}/ww3_gint_grdset_a.inp
edit_ww3_fld   < ${TEST_DIR}/parm/ww3_ounf.inp.IN > ${TEST_DIR}/${input_i}/ww3_ounf.inp
edit_ww3_fld   < ${TEST_DIR}/parm/ww3_grib_gnh_10m.inp.IN > ${TEST_DIR}/${input_i}/ww3_grib_gnh_10m.inp
edit_ww3_fld   < ${TEST_DIR}/parm/ww3_grib_gsh_15m.inp.IN > ${TEST_DIR}/${input_i}/ww3_grib_gsh_15m.inp
edit_ww3_fld   < ${TEST_DIR}/parm/ww3_grib_aoc_9km.inp.IN > ${TEST_DIR}/${input_i}/ww3_grib_aoc_9km.inp
edit_ww3_fld   < ${TEST_DIR}/parm/ww3_grib_glo_15mxt.inp.IN > ${TEST_DIR}/${input_i}/ww3_grib_glo_15mxt.inp
edit_ww3_ounp  < ${TEST_DIR}/parm/ww3_ounp.inp.IN > ${TEST_DIR}/${input_i}/ww3_ounp_points.inp
edit_ww3_prnc_wind < ${TEST_DIR}/parm/ww3_prnc.inp.IN > ${TEST_DIR}/${input_i}/ww3_prnc_glox_10m_wind.inp
edit_ww3_prnc_cur  < ${TEST_DIR}/parm/ww3_prnc.inp.IN > ${TEST_DIR}/${input_i}/ww3_prnc_glix_10m_current.inp
edit_ww3_prnc_ice  < ${TEST_DIR}/parm/ww3_prnc.inp.IN > ${TEST_DIR}/${input_i}/ww3_prnc_glix_10m_ice.inp
echo -e "\e[34minputs templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#ww3_grid parameters
edit_grdset < ${TEST_DIR}/parm/grdset.IN > ${TEST_DIR}/${input_i}/grdset_a
#inp
#edit_ww3_grid < ${TEST_DIR}/parm/ww3_grid_gnh_10m.inp.IN > ${TEST_DIR}/${input_i}/ww3_grid_gnh_10m.inp
#edit_ww3_grid < ${TEST_DIR}/parm/ww3_grid_gsh_15m.inp.IN > ${TEST_DIR}/${input_i}/ww3_grid_gsh_15m.inp
#edit_ww3_grid < ${TEST_DIR}/parm/ww3_grid_aoc_9km.inp.IN > ${TEST_DIR}/${input_i}/ww3_grid_aoc_9km.inp
#nml
edit_ww3_grid_nml < ${TEST_DIR}/parm/ww3_grid_gnh_10m.nml.IN > ${TEST_DIR}/${input_i}/ww3_grid_gnh_10m.nml
edit_ww3_grid_nml < ${TEST_DIR}/parm/ww3_grid_gsh_15m.nml.IN > ${TEST_DIR}/${input_i}/ww3_grid_gsh_15m.nml
edit_ww3_grid_nml < ${TEST_DIR}/parm/ww3_grid_aoc_9km.nml.IN > ${TEST_DIR}/${input_i}/ww3_grid_aoc_9km.nml
#edit_ww3_grid < ${TEST_DIR}/parm/input_nml.IN > ${TEST_DIR}/${input_i}/inp.nml
#edit_input_lower_bound < ${TEST_DIR}/parm/input_lower_bound_nml.IN > ${TEST_DIR}/${input_i}/inp_lower_bound.nml
#edit_input_upper_bound < ${TEST_DIR}/parm/input_upper_bound_nml.IN > ${TEST_DIR}/${input_i}/inp_upper_bound.nml
echo -e "\e[34mww3_grid.inp files are filled\e[0m"
#-----------------------------------------------------------------------------------#
#switch
cp ${TEST_DIR}/parm/switch ${TEST_DIR}/${input_i}
echo -"\e[34mswitch is coppied\e[0m"
#-----------------------------------------------------------------------------------#
#statistical_analysis
edit_statistical_analysis < ${TEST_DIR}/parm/statistical_analysis.m.IN > ${TEST_DIR}/${input_i}/statistical_analysis.m
echo -"\e[34mstatistical_analysis.m template is filled\e[0m"
#-----------------------------------------------------------------------------------#
#forcing
edit_forcing < ${TEST_DIR}/parm/retrieve_wind_hpss.sh.IN > ${FORCING_DIR}/retrieve_wind_hpss.sh
edit_forcing < ${TEST_DIR}/parm/retrieve_ice.sh.IN > ${FORCING_DIR}/retrieve_ice.sh
edit_forcing < ${TEST_DIR}/parm/retrieve_cur.sh.IN > ${FORCING_DIR}/retrieve_cur.sh
#edit_forcing < ${TEST_DIR}/parm/retrieve_restart_hpss.sh.IN > ${FORCING_DIR}/retrieve_restart_hpss.sh
edit_forcing < ${TEST_DIR}/parm/retrieve_fix_file.sh.IN  > ${FORCING_DIR}/retrieve_fix_file.sh
echo -e "\e[34mForcing templates are filled\e[0m"
#-----------------------------------------------------------------------------------#
#observation
if [ ! -r ${TEST_DIR}/obs ]
then 
  mkdir ${TEST_DIR}/obs
fi
#satellite
edit_obs < ${TEST_DIR}/parm/retrieve_sat_alt.sh.IN > ${TEST_DIR}/obs/retrieve_sat_alt.sh
echo -e "\e[34mSatellite obs templates is filled\e[0m"
edit_obs < ${TEST_DIR}/parm/retrieve_buoy.sh.IN > ${TEST_DIR}/obs/retrieve_buoy.sh
echo -e "\e[34mBuoy obs templates is filled\e[0m"
#-----------------------------------------------------------------------------------#
#                     2- Forcing Retrieval                                          #
#-----------------------------------------------------------------------------------#
cd ${FORCING_DIR}
    echo -e "\e[36mForcing Retrieval ...\e[0m"
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
#    if [[ -f ${TEST_DIR}/${input_i}/restart.aoc_9km ]] && [[ -f ${TEST_DIR}/${input_i}/restart.gnh_10m ]] && [[ -f ${TEST_DIR}/${input_i}/restart.gsh_15m ]]
#    then
#       echo -e "\e[34mrestart files exist\e[0m"
#    else
#       bash retrieve_restart_hpss.sh
#       echo -e "\e[31mrestart files are retrieved\e[0m"     
#    fi
# copy restart files from work_spinup
    if [[ -f ${TEST_DIR}/work_spinup/restart001.aoc_9km ]] && [[ -f ${TEST_DIR}/work_spinup/restart001.gnh_10m ]] && [[ -f ${TEST_DIR}/work_spinup/restart001.gsh_15m ]]
    then
       cp ${TEST_DIR}/work_spinup/restart001.gnh_10m ${TEST_DIR}/${input_i}/restart.gnh_10m
       cp ${TEST_DIR}/work_spinup/restart001.gsh_15m ${TEST_DIR}/${input_i}/restart.gsh_15m
       cp ${TEST_DIR}/work_spinup/restart001.aoc_9km ${TEST_DIR}/${input_i}/restart.aoc_9km
       echo -e "\e[31mrestart files coppied over\e[0m"
    else
       echo -e "\e[34mrestart files do not exist\e[0m"
    fi
#-----------------------------------------------------------------------------------#
    if [[ -f ${TEST_DIR}/${input_i}/rmp_src_to_dst_conserv_002_001.nc ]] && [[ -f ${TEST_DIR}/${input_i}/rmp_src_to_dst_conserv_003_001.nc ]]
    then
       echo -e "\e[34mrmp_src_to_dst_conserv_002_001.nc and rmp_src_to_dst_conserv_003_001.nc files exist\e[0m"
    else
       bash retrieve_fix_file.sh
       echo -e "\e[31mfix files are retrieved\e[0m"
    fi
#-----------------------------------------------------------------------------------#
#                     3- Observation (satellite and buoy)                           #
#-----------------------------------------------------------------------------------#
cd ${TEST_DIR}/obs
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
