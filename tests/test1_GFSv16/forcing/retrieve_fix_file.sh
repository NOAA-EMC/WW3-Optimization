##!/bin/bash

FIXwave=/scratch1/NCEPDEV/global/glopara/fix_nco_gfsv16/fix_wave_gfs/

source ../input_vars.sh
#cd $FORCING_PATH

#-----------------------------------------------------------------------------------#
#                                   RMP_SRC_TO_DST*                                 #
#-----------------------------------------------------------------------------------#
  echo ' '                                                                 
  echo '       *****************************************************************'     
  echo "      ***                     RMP_SRC_TO_DST* Prep                     ***"
  echo '       *****************************************************************'    
  echo ' ' 


file_rmp=`( ls ${FIXwave}rmp_src_to_dst_conserv* )`
cp ${FIXwave}rmp_src_to_dst_conserv* ../input
  echo "$file_rmp"
cp ${FIXwave}WHTGRIDINT.bin.glo_15mxt ../input/WHTGRIDINT.bin
  echo "WHTGRIDINT.bin.glo_15mxt"
cp ${FIXwave}ww3_grid.inp.glo_15mxt ../input/ww3_grid_glo_15mxt.inp
  echo "ww3_grid_glo_15mxt.inp"
cp ${FIXwave}ww3_grid.inp.points ../input/ww3_grid_points.inp
  echo "ww3_grid_points.inp"
cp ${FIXwave}ww3_grid.inp.glix_10m ../input/ww3_grid_glix_10m.inp
  echo "ww3_grid_glix_10m.inp"
cp ${FIXwave}ww3_grid.inp.glox_10m ../input/ww3_grid_glox_10m.inp
  echo "ww3_grid_glox_10m.inp"
  echo "copied over"
  echo ' '                                                                 
  echo '       *****************************************************************'     
  echo "     ***                            done                               ***"
  echo '       *****************************************************************'    
  echo ' '     

