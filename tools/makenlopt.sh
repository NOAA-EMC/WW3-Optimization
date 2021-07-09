#! /usr/bin/env bash
# --------------------------------------------------------------------------- #
# install nlopt with matlab plugin on hera                                    #
#                                                      Ali Abdolali           #
#                                                        June 2021            #
#                             Updated:  Matthew Masarik  July 2021            #
#                                                                             #
#    Copyright 2013 National Weather Service (NWS),                           #
#       National Oceanic and Atmospheric Administration.  All rights          #
#       reserved.  WAVEWATCH III is a trademark of the NWS.                   #
#       No unauthorized use without permission.                               #
#                                                                             #
# --------------------------------------------------------------------------- #
  echo ' '                                                                 
  echo '       *****************************************************************'     
  echo "     ***         install nlopt with matlab plugin on hera              ***"   
  echo '       *****************************************************************'    
  echo ' ' 
# --------------------------------------------------------------------------- #
# 1.  clean up and modules                                                    #
# --------------------------------------------------------------------------- #
OPTDIR=${PWD%/*}

  ishera=`hostname | grep hfe`
  isorion=`hostname | grep Orion`
  module purge
  if [ $ishera ]
  then
     module load cmake
     module load  matlab
     module list
  elif [ $isorion ]
  then
     module load cmake
     module load matlab
  else
    echo "machine is not detected"
  fi
# --------------------------------------------------------------------------- #
# 1.  clone nlopt and install                                                 #
# --------------------------------------------------------------------------- #
#git clone git@github.com:stevengj/nlopt.git nlopt
cd ${OPTDIR}/nlopt
mkdir build
cd build
#dynamic
cmake -DCMAKE_INSTALL_PREFIX=$OPTDIR/tools/install ..
make
cd ${OPTDIR}/nlopt/build
make install

  echo ' '                                                                 
  echo '       *****************************************************************'     
  echo "     ***                  NLOPT w/ MATLAB plugin installed             ***"   
  echo '       *****************************************************************'    
  echo ' ' 

# --------------------------------------------------------------------------- #
# End                                                                         #
# --------------------------------------------------------------------------- #

