#!/bin/bash
ishera=`hostname | grep hfe`
  isorion=`hostname | grep Orion`
  if [ $ishera ]
  then
    # If no other h, assuming Hera 
    cmplr='hera.intel'
    batchq='slurm'
    hpcstackpath='/scratch2/NCEPDEV/nwprod/hpc-stack/libs/hpc-stack/modulefiles/stack'
    hpcstackversion='hpc/1.1.0'
    modcomp='hpc-intel/18.0.5.274'
    modnetcdf='netcdf'
    modwgrib2='wgrib2/2.0.8'
    modcdo='cdo/1.9.10'
    modnco='nco/4.9.3'
    modhpss='hpss'
  fi


