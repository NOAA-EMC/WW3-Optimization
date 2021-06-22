#! /usr/bin/env bash
# --------------------------------------------------------------------------- #
# install nlopt with matlab plugin on hera                                    #
#                                                      Ali Abdolali           #
#                                                        June 2021            #
#                                              Updated:  June 2021            #
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
HOME=${PWD%/*}

module purge
module load cmake/3.20.1
module load  gnu
module load  matlab
module list
if [ -d tools/install ]; then rm -rf tools/install; fi
#if [ -d nlopt ]; then rm -rf nlopt; fi
mkdir tools/install
# --------------------------------------------------------------------------- #
# 1.  clone nlopt and install                                                 #
# --------------------------------------------------------------------------- #
#git clone git@github.com:stevengj/nlopt.git nlopt
cd ${HOME}/nlopt
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/tools/install -DBUILD_SHARED_LIBS=OFF ..
make
cd ${HOME}/nlopt/build
make install

  echo ' '                                                                 
  echo '       *****************************************************************'     
  echo "     ***                  NLOPT w/ MATLAB plugin installed             ***"   
  echo '       *****************************************************************'    
  echo ' ' 

# --------------------------------------------------------------------------- #
# End                                                                         #
# --------------------------------------------------------------------------- #

