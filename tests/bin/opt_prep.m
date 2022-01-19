clear all
clc
addpath('../../tools/matlab_bin/')
xinp=load('x_opt')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov)                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%index of parameters to be tuned
ii=[1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18];
%-------------------------------------------------------------------------
%SIN4 (wind input)
%(1)----------------------------------------------------------------------
 BETAMAX=xinp(1);
 BETAMAXmin=1.0;
 BETAMAXmax=2.0;
 var(1,:)=[BETAMAX BETAMAXmin BETAMAXmax];
%(2)----------------------------------------------------------------------
 TAUWSHELTER=xinp(2);
 TAUWSHELTERmin=0;
 TAUWSHELTERmax=1.5;
 var(2,:)=[TAUWSHELTER TAUWSHELTERmin TAUWSHELTERmax];
%(3)----------------------------------------------------------------------
 SWELLF=xinp(3);
 SWELLFmin=0.5;
 SWELLFmax=1.2;
var(3,:)=[SWELLF SWELLFmin SWELLFmax];
%(4)----------------------------------------------------------------------
 SWELLF2=xinp(4);
 SWELLF2min=-0.03;
 SWELLF2max=-0.01;
 var(4,:)=[SWELLF2 SWELLF2min SWELLF2max];
%(5)----------------------------------------------------------------------
 SWELLF3=xinp(5);
 SWELLF3min=0.01;
 SWELLF3max=0.02;
 var(5,:)=[SWELLF3 SWELLF3min SWELLF3max];
%(6)----------------------------------------------------------------------
 SWELLF4=xinp(6);
 SWELLF4min=80000.0;
 SWELLF4max=150000.0;
 var(6,:)=[SWELLF4 SWELLF4min SWELLF4max];
%(7)----------------------------------------------------------------------
 SWELLF5=xinp(7);
 SWELLF5min=0.8;
 SWELLF5max=1.6;
 var(7,:)=[SWELLF5 SWELLF5min SWELLF5max];
%(8)----------------------------------------------------------------------
 SWELLF7=xinp(8);
 SWELLF7min=0.0;
 SWELLF7max=400000.0;
 var(8,:)=[SWELLF7 SWELLF7min SWELLF7max];
%-------------------------------------------------------------------------
 %SNL1 (nonlinear interactions)
%-------------------------------------------------------------------------
%(9)----------------------------------------------------------------------
 NLPROP=xinp(9);
 NLPROPmin=2.400e7;
 NLPROPmax=2.800e7;
 var(9,:)=[NLPROP NLPROPmin NLPROPmax];
%-------------------------------------------------------------------------
%SDS4 (dissipation)
%-------------------------------------------------------------------------
%(10)---------------------------------------------------------------------
 FXFM3 = nan;
 FXFM3min=2.501;
 FXFM3max=2.501;
 var(10,:)=[FXFM3 FXFM3min FXFM3max];
%(11)---------------------------------------------------------------------
 SDSC2=xinp(10);
 SDSC2min=-2.5e-05;
 SDSC2max=0.0;
 var(11,:)=[SDSC2 SDSC2min SDSC2max];
%(12)---------------------------------------------------------------------
 SDSCUM=xinp(11);
 SDSCUMmin=-0.5;
 SDSCUMmax=0.0;
 var(12,:)=[SDSCUM SDSCUMmin SDSCUMmax];
%(13)---------------------------------------------------------------------
 SDSC5=xinp(12);
 SDSC5min=0.0;
 SDSC5max=1.2;
 var(13,:)=[SDSC5 SDSC5min SDSC5max];
%(14)---------------------------------------------------------------------
 SDSC6=xinp(13);
 SDSC6min=0.0;
 SDSC6max=1.0;
 var(14,:)=[SDSC6 SDSC6min SDSC6max];
%(15)---------------------------------------------------------------------
 SDSBR=xinp(14);
 SDSBRmin=0.0008;
 SDSBRmax=0.0010;
 var(15,:)=[SDSBR SDSBRmin SDSBRmax];
%(16)---------------------------------------------------------------------
 SDSBCK=xinp(15);
 SDSBCKmin=0.0;
 SDSBCKmax=0.2;
 var(16,:)=[SDSBCK SDSBCKmin SDSBCKmax];
%(17)---------------------------------------------------------------------
 SDSHCK=xinp(16);
 SDSHCKmin=0.0;
 SDSHCKmax=2.0;
 var(17,:)=[SDSHCK SDSHCKmin SDSHCKmax];
%(18)---------------------------------------------------------------------
 SDSCOS=xinp(17);
 SDSCOSmin=0.0;
 SDSCOSmax=2.0;
 var(18,:)=[SDSCOS SDSCOSmin SDSCOSmax];
%(19)---------------------------------------------------------------------
 CICE0 = nan;
 CICE0min=0.25;
 CICE0max=0.25;
 var(19,:)=[CICE0 CICE0min CICE0max];
%(20)---------------------------------------------------------------------
 CICEN = nan;
 CICENmin=0.75;
 CICENmax=0.75;
 var(20,:)=[CICEN CICENmin CICENmax];
%(21)---------------------------------------------------------------------
 FLAGTR = nan;
 FLAGTRmin=4;
 FLAGTRmax=4;
 var(21,:)=[FLAGTR FLAGTRmin FLAGTRmax];
%(22)---------------------------------------------------------------------
 GAMMA = nan;
 GAMMAmin = -0.038;
 GAMMAmax = -0.038;
 var(22,:)=[GAMMA GAMMAmin GAMMAmax];
%(23)---------------------------------------------------------------------
%GSE (GNH:5.5 GSH:4.0 AOC:3.0)
 GSE=[5.5 4.0 3.0];
for gse=1:3
 WDTHCG=nan;
 WDTHCGmin=GSE(gse);
 WDTHCGmax=GSE(gse);
 var(23,:)=[WDTHCG WDTHCGmin WDTHCGmax];
%(24)---------------------------------------------------------------------------
 WDTHTH=nan;
 WDTHTHmin=GSE(gse);
 WDTHTHmax=GSE(gse);
 var(24,:)=[WDTHTH WDTHTHmin WDTHTHmax];
%-------------------------------------------------------------------------
%default
 for i=1:length(var(:,1))
   [var_unnorm(i,1)] =  unnormalize(var(i,2),var(i,3),0.0,1.0,var(i,1));
 end

for i=1:length(var(:,1))
   [var_norm(i,1)] = normalize(var(i,2),var(i,3),0.0,1.0,var_unnorm(i,1));
end
%-------------------------------------------------------------------------
 if gse==1
 grid='gnh'
 end
 if gse==2
 grid='gsh'
 end
 if gse==3
 grid='aoc'
 end

write_namelist(['namelist_',grid],var_unnorm)
dlmwrite(['norm_',grid],rot90(var_norm),'delimiter',' ','precision',8);
dlmwrite(['unnorm_',grid],rot90(var_unnorm),'delimiter',' ','precision',8);
end

