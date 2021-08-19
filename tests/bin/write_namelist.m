function [namelist] = write_namelist(namelist,var)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program writes the namelist                                        %  
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------    INPUT    ---------------------------------
%namelist: name of target namelist
%var:  variables (including 22 variables in the following orders for ST4
%physics)
%---------------------------    example   ---------------------------------
%[namelist] = write_namelist('work/namelist',var)
%--------------------------------------------------------------------------
%variables
BETAMAX=var(1); TAUWSHELTER=var(2); SWELLF=var(3);  SWELLF2=var(4);
SWELLF3=var(5); SWELLF4=var(6)    ; SWELLF5=var(7); SWELLF7=var(8);
NLPROP=var(9) ; FXFM3=var(10)     ; SDSC2=var(11) ; SDSCUM=var(12);
SDSC5=var(13) ; SDSC6=var(14)     ; SDSBR=var(15) ; SDSBCK=var(16);
SDSHCK=var(17); SDSCOS=var(18)    ; CICE0=var(19) ; CICEN=var(20) ;
FLAGTR=var(21); GAMMA=var(22);
%--------------------------------------------------------------------------
%write namelist
fileID = fopen(namelist,'w');
fprintf(fileID,['%s %1.5f%s\n'], '&SIN4 BETAMAX = ',BETAMAX,',');
fprintf(fileID,['%s %1.2f%s\n'], 'TAUWSHELTER = ',TAUWSHELTER,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SWELLF = ',SWELLF,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SWELLF2 = ',SWELLF2,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SWELLF3 = ',SWELLF3,',');
fprintf(fileID,['%s %6.2f%s\n'], 'SWELLF4 = ',SWELLF4,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SWELLF5 = ',SWELLF5,',');
fprintf(fileID,['%s %5.2f %s\n'], 'SWELLF7 = ',SWELLF7,'/');
fprintf(fileID,['%s\n'], '&SNL1');
fprintf(fileID,['%s %8.2f %s\n'], 'NLPROP = ',NLPROP,'/');
fprintf(fileID,['%s\n'], '&SDS4');
fprintf(fileID,['%s %1.3f%s\n'], 'FXFM3 = ',FXFM3,',');
fprintf(fileID,['%s %1.10f%s\n'], 'SDSC2 = ',SDSC2,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SDSCUM = ',SDSCUM,',');
fprintf(fileID,['%s %2.2f%s\n'], 'SDSC5 = ',SDSC5,',');
fprintf(fileID,['%s %1.5f%s\n'], 'SDSC6 = ',SDSC6,',');
fprintf(fileID,['%s %1.8f%s\n'], 'SDSBR = ',SDSBR,',');
fprintf(fileID,['%s %2.2f%s\n'], 'SDSBCK = ',SDSBCK,',');
fprintf(fileID,['%s %2.2f%s\n'], 'SDSHCK = ',SDSHCK,',');
fprintf(fileID,['%s %2.2f %s\n'], 'SDSCOS = ',SDSCOS,'/');
fprintf(fileID,['%s\n'], '&MISC');
fprintf(fileID,['%s %2.2f%s\n'], 'CICE0 = ',CICE0,',');
fprintf(fileID,['%s %2.2f%s\n'], 'CICEN = ',CICEN,',');
fprintf(fileID,['%s %d %s\n'], 'FLAGTR= ',FLAGTR,'/');
fprintf(fileID,['%s\n'], '&SBT1');
fprintf(fileID,['%s %2.3f %s\n'], 'GAMMA= ',GAMMA,'/');
%fprintf(fileID,['%s\n'], '&PRO3');
%fprintf(fileID,['%s %2.2f%s\n'], 'WDTHCG',WDTHCG,',');
%fprintf(fileID,['%s %2.2f %s\n'], 'WDTHTH',WDTHTH,'/');
%fprintf(fileID,['%s\n'], 'END OF NAMELISTS');
fclose(fileID);
