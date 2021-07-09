#! /usr/bin/env bash
set -eu

function edit_ww3_multi { 

  SDATEWW3="${SYEAR}${SMONTH}${SDAY} $(printf "%02d" $(( ${SHOUR}  )))0000"
  EDATEWW3="${EYEAR}${EMONTH}${EDAY} $(printf "%02d" $(( ${EHOUR}  )))0000"
  #note EDATE should be SDATE+FHMAX, but since this requires adding ndate 
  #a work around is to just put a date long in the future as the actual end time is
  #determined by the driver
  DT_2_RST_WAV="$(printf "%02d" $(( ${WW3RSTDTHR}*3600 )))"
  DTFLD_WAV="$(printf "%02d" $(( ${WW3OUTDTHR}*1 )))"
  DTPNT_WAV="$(printf "%02d" $(( ${WW3OUTDTHRPNT}*1 )))"

  sed -e "s/NFGRIDS/$NFGRIDS/g" \
      -e "s/NMGRIDS/${NMGRIDS}/g" \
      -e "s/FUNIPNT/T/g" \
      -e "s/IOSRV/3/g" \
      -e "s/FPNTPROC/T/g" \
      -e "s/FGRDPROC/F/g" \
      -e "s/OUTPARS/${OUTPARS_WAV}/g" \
      -e "s/CPLILINE/${CPLILINE}/g" \
      -e "s/UNIPOINTS/'points'/g" \
      -e "s/GRIDLINE/${ww3gline}/g" \
      -e "s/ICELINE/$ICELINE/g" \
      -e "s/CURRLINE/$CURRLINE/g" \
      -e "s/WINDLINE/$WINDLINE/g" \
      -e "s/RUN_BEG/$SDATEWW3/g" \
      -e "s/RUN_END/$EDATEWW3/g" \
      -e "s/OUT_BEG/$SDATEWW3/g" \
      -e "s/OUT_END/$EDATEWW3/g" \
      -e "s/DTFLD/ $DTFLD_WAV/g" \
      -e "s/FLAGMASKCOMP/ T/g" \
      -e "s/FLAGMASKOUT/ T/g" \
      -e "s/GOFILETYPE/ $WW3OUTPUTTYPE/g" \
      -e "s/POFILETYPE/ $WW3OUTPUTTYPE/g" \
      -e "s/DTPNT/ $DTPNT_WAV/g" \
      -e "s/RST_BEG/$SDATEWW3/g" \
      -e "s/RSTTYPE/F/g" \
      -e "s/RST_2_BEG/$SDATEWW3/g" \
      -e "s/DTRST/0/g" \
      -e "s/DT_2_RST/$DT_2_RST_WAV/g" \
      -e "s/RST_END/$EDATEWW3/g" \
      -e "s/RST_2_END/$EDATEWW3/g" 
}


function edit_ww3_fld { 

  SDATEWW3="${SYEAR}${SMONTH}${SDAY} $(printf "%02d" $(( ${SHOUR}  )))0000"
  sed  -e "s/OUT_BEG/$SDATEWW3/g" \
       -e "s/DTFLD/ $DTFLD_WAV/g" \
       -e "s/OUTPARS/${OUTPARS_WAV}/g"
}

function edit_ww3_gint {

  SDATEWW3="${SYEAR}${SMONTH}${SDAY} $(printf "%02d" $(( ${SHOUR}  )))0000"
  sed  -e "s/OUT_BEG/$SDATEWW3/g" \
       -e "s/DTFLD/ $DTFLD_WAV/g" \
       -e "s/NOGRD/ $NOGRID/g" \
       -e "s/GRDLN/ $GRIDSLINE/g" \
       -e "s/INTLN/ $INTEGLINE/g" \
       -e "s/OUTPARS/${OUTPARS_WAV}/g"
}

function edit_ww3_prnc_wind {

  sed  -e "s/PRNCLINE/$WINDPRNCLINE/g" \
       -e "s/DIMLINE/$WINDDIMLINE/g" \
       -e "s/VARLINE/$WINDVARLINE/g" \
       -e "s/FRCFILE/$WINDFRCFILE/g"
}


function edit_ww3_prnc_cur {

  sed  -e "s/PRNCLINE/$CURPRNCLINE/g" \
       -e "s/DIMLINE/$CURDIMLINE/g" \
       -e "s/VARLINE/$CURVARLINE/g" \
       -e "s/FRCFILE/$CURFRCFILE/g"
}

function edit_ww3_prnc_ice {

  sed  -e "s/PRNCLINE/$ICEPRNCLINE/g" \
       -e "s/DIMLINE/$ICEDIMLINE/g" \
       -e "s/VARLINE/$ICEVARLINE/g" \
       -e "s/FRCFILE/$ICEFRCFILE/g"
}

function edit_ww3_ounp {

  SDATEWW3="${SYEAR}${SMONTH}${SDAY} $(printf "%02d" $(( ${SHOUR}  )))0000"
  sed  -e "s/OUT_BEG/$SDATEWW3/g" \
       -e "s/DTPNT/ $DTPNT_WAV/g"
}


function edit_forcing {

  SDATEWW3="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEWW3="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEWW3/g" \
       -e "s/FRC_END/$EDATEWW3/g" \
       -e "s/FORCING_T/${FORCING_GFS}/g" 
}

function edit_obs {

  SDATEWW3="${SYEAR}-${SMONTH}-${SDAY}"
  EDATEWW3="${EYEAR}-${EMONTH}-${EDAY}"
  sed  -e "s/FRC_BEG/$SDATEWW3/g" \
       -e "s/FRC_END/$EDATEWW3/g"
}

function edit_grdset {

  sed  -e "s/MDLGRDLN/$MODELGRIDLINE/g" \
       -e "s/INPGRDLN/$INPUTGRIDLINE/g" \
       -e "s/PNTGRDLN/$POINTGRIDLINE/g" \
       -e "s/INTGRDLN/$INTGRIDLINE/g"
}

function normalize(){
 var = $(( ( vmin * ( upper_bound - xval ) +  vmax * ( xval - lower_bound ) )/ \
                  ( upper_bound - lower_bound ) ))

}

function edit_ww3_grid {

  sed  -e "s/BETAMAXvar/$BETAMAXvar/g" \
       -e "s/TAUWSHELTERvar/$TAUWSHELTERvar/g" \
       -e "s/SWELLFvar/$SWELLFvar/g" \
       -e "s/SWELLF2var/$SWELLF2var/g" \
       -e "s/SWELLF3var/$SWELLF3var/g" \
       -e "s/SWELLF4var/$SWELLF4var/g" \
       -e "s/SWELLF5var/$SWELLF5var/g" \
       -e "s/SWELLF7var/$SWELLF7var/g" \
       -e "s/NLPROPvar/$NLPROPvar/g" \
       -e "s/SDSC2var/$SDSC2var/g" \
       -e "s/SDSCUMvar/$SDSCUMvar/g" \
       -e "s/SDSC6var/$SDSC6var/g" \
       -e "s/SDSBRvar/$SDSBRvar/g" \
       -e "s/SDSC5var/$SDSC5var/g" \
       -e "s/SDSBCKvar/$SDSBCKvar/g" \
       -e "s/SDSHCKvar/$SDSHCKvar/g" \
       -e "s/SDSCOSvar/$SDSCOSvar/g"
}

function edit_input_lower_bound {

  sed  -e "s/BETAMAXmin/$BETAMAXmin/g" \
       -e "s/TAUWSHELTERmin/$TAUWSHELTERmin/g" \
       -e "s/SWELLFmin/$SWELLFmin/g" \
       -e "s/SWELLF2min/$SWELLF2min/g" \
       -e "s/SWELLF3min/$SWELLF3min/g" \
       -e "s/SWELLF4min/$SWELLF4min/g" \
       -e "s/SWELLF5min/$SWELLF5min/g" \
       -e "s/SWELLF7min/$SWELLF7min/g" \
       -e "s/NLPROPmin/$NLPROPmin/g" \
       -e "s/SDSC2min/$SDSC2min/g" \
       -e "s/SDSCUMmin/$SDSCUMmin/g" \
       -e "s/SDSC6min/$SDSC6min/g" \
       -e "s/SDSBRmin/$SDSBRmin/g" \
       -e "s/SDSC5min/$SDSC5min/g" \
       -e "s/SDSBCKmin/$SDSBCKmin/g" \
       -e "s/SDSHCKmin/$SDSHCKmin/g" \
       -e "s/SDSCOSmin/$SDSCOSmin/g"
}


function edit_input_upper_bound {

  sed  -e "s/BETAMAXmax/$BETAMAXmax/g" \
       -e "s/TAUWSHELTERmax/$TAUWSHELTERmax/g" \
       -e "s/SWELLFmax/$SWELLFmax/g" \
       -e "s/SWELLF2max/$SWELLF2max/g" \
       -e "s/SWELLF3max/$SWELLF3max/g" \
       -e "s/SWELLF4max/$SWELLF4max/g" \
       -e "s/SWELLF5max/$SWELLF5max/g" \
       -e "s/SWELLF7max/$SWELLF7max/g" \
       -e "s/NLPROPmax/$NLPROPmax/g" \
       -e "s/SDSC2max/$SDSC2max/g" \
       -e "s/SDSCUMmax/$SDSCUMmax/g" \
       -e "s/SDSC6max/$SDSC6max/g" \
       -e "s/SDSBRmax/$SDSBRmax/g" \
       -e "s/SDSC5max/$SDSC5max/g" \
       -e "s/SDSBCKmax/$SDSBCKmax/g" \
       -e "s/SDSHCKmax/$SDSHCKmax/g" \
       -e "s/SDSCOSmax/$SDSCOSmax/g"
}

function edit_statistical_analysis {

  sed  -e "s/WORKDIR/$work_i/g" \
       -e "s/OUTGRID/$OUTGRIDED/g" \
       -e "s/VMIN/$VMIN_val/g" \
       -e "s/VMAX/$VMAX_val/g" \
       -e "s/INPUTDIR/$input_i/g"
}
