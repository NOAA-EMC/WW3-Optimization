clear all
clc
addpath('../../tools/matlab_bin/')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%number of perturbation + 1 default
max_pert=2;
%index of parameters to be tuned
ii=[1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SIN4 (wind input)
%(1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 BETAMAX=1.315;
 BETAMAXmin=1.0;
 BETAMAXmax=2.0;
 var(1,:)=[BETAMAX BETAMAXmin BETAMAXmax];
%(2)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 TAUWSHELTER=1.0;
 TAUWSHELTERmin=0;
 TAUWSHELTERmax=1.5;
 var(2,:)=[TAUWSHELTER TAUWSHELTERmin TAUWSHELTERmax];
%(3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF=0.798;
 SWELLFmin=0.5;
 SWELLFmax=1.2;
var(3,:)=[SWELLF SWELLFmin SWELLFmax];
%(4)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF2=-0.0127;
 SWELLF2min=-0.03;
 SWELLF2max=-0.01;
 var(4,:)=[SWELLF2 SWELLF2min SWELLF2max];
%(5)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF3=0.0151;
 SWELLF3min=0.01;
 SWELLF3max=0.02;
 var(5,:)=[SWELLF3 SWELLF3min SWELLF3max];
%(6)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF4=100025.0;
 SWELLF4min=80000.0;
 SWELLF4max=150000.0;
 var(6,:)=[SWELLF4 SWELLF4min SWELLF4max];
%(7)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF5=1.1999;
 SWELLF5min=0.8;
 SWELLF5max=1.6;
 var(7,:)=[SWELLF5 SWELLF5min SWELLF5max];
%(8)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SWELLF7=235500.0;
 SWELLF7min=0.0;
 SWELLF7max=400000.0;
 var(8,:)=[SWELLF7 SWELLF7min SWELLF7max];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %SNL1 (nonlinear interactions)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(9)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 NLPROP=2.502e7;
 NLPROPmin=2.400e7;
 NLPROPmax=2.800e7;
 var(9,:)=[NLPROP NLPROPmin NLPROPmax];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SDS4 (dissipation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(10)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 FXFM3 = 2.501;
 FXFM3min=2.501;
 FXFM3max=2.501;
 var(10,:)=[FXFM3 FXFM3min FXFM3max];
%(11)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSC2=-2.1975e-05;
 SDSC2min=-2.5e-05;
 SDSC2max=0.0;
 var(11,:)=[SDSC2 SDSC2min SDSC2max];
%(12)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSCUM=-0.4032;
 SDSCUMmin=-0.5;
 SDSCUMmax=0.0;
 var(12,:)=[SDSCUM SDSCUMmin SDSCUMmax];
%(13)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSC5=0.0;
 SDSC5min=0.0;
 SDSC5max=1.2;
 var(13,:)=[SDSC5 SDSC5min SDSC5max];
%(14)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSC6=0.2978;
 SDSC6min=0.0;
 SDSC6max=1.0;
 var(14,:)=[SDSC6 SDSC6min SDSC6max];
%(15)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSBR=0.0009035;
 SDSBRmin=0.0008;
 SDSBRmax=0.0010;
 var(15,:)=[SDSBR SDSBRmin SDSBRmax];
%(16)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSBCK=0.0;
 SDSBCKmin=0.0;
 SDSBCKmax=0.2;
 var(16,:)=[SDSBCK SDSBCKmin SDSBCKmax];
%(17)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSHCK=1.5;
 SDSHCKmin=0.0;
 SDSHCKmax=2.0;
 var(17,:)=[SDSHCK SDSHCKmin SDSHCKmax];
%(18)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SDSCOS=2.0;
 SDSCOSmin=0.0;
 SDSCOSmax=2.0;
 var(18,:)=[SDSCOS SDSCOSmin SDSCOSmax];
%(19)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 CICE0 = 0.25;
 CICE0min=0.25;
 CICE0max=0.25;
 var(19,:)=[CICE0 CICE0min CICE0max];
%(20)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 CICEN = 0.75;
 CICENmin=0.75;
 CICENmax=0.75;
 var(20,:)=[CICEN CICENmin CICENmax];
%(21)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 FLAGTR = 4;
 FLAGTRmin=4;
 FLAGTRmax=4;
 var(21,:)=[FLAGTR FLAGTRmin FLAGTRmax];
%(22)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 GAMMA = -0.038;
 GAMMAmin = -0.038;
 GAMMAmax = -0.038;
 var(22,:)=[GAMMA GAMMAmin GAMMAmax];
%(23)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WDTHCG=5.5;
% WDTHCGmin=5.5;
% WDTHCGmax=5.5;
% var(23,:)=[WDTHCG WDTHCGmin WDTHCGmax];
%(24)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WDTHTH=5.5;
% WDTHTHmin=5.5;
% WDTHTHmax=5.5;
% var(24,:)=[WDTHTH WDTHTHmin WDTHTHmax];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%default
for i=1:length(var(:,1))
   [var_norm(i,1)] = normalize(var(i,2),var(i,3),0.0,1.0,var(i,1));
end

 for i=1:length(var(:,1))
   [var_unnorm(i,1)] =  unnormalize(var(i,2),var(i,3),0.0,1.0,var_norm(i,1));
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 m=1;
 %two perturbation per variables for ii
 for j=1:length(ii)
     for p=1:max_pert
     m=m+1;
     var_tmp=var(:,1);
       for i=1:length(var(:,1))
         [var_norm(i,m)] = normalize(var(i,2),var(i,3),0.0,1.0,var_tmp(i,1));
       end
      var_norm(ii(j),m)=rand(1,1);
     end
 end

 for j=1:m
 for i=1:length(var(:,1))
   [var_unnorm(i,j)] =  unnormalize(var(i,2),var(i,3),0.0,1.0,var_norm(i,j));
 end
 end
% write namelist

for i=1:m
namelist=['namelist_',num2str(i)];
write_namelist(namelist,var_unnorm(:,i))
dlmwrite(['norm_',num2str(i)],rot90(var_norm(:,i)),'delimiter',' ','precision',8);
dlmwrite(['unnorm_',num2str(i)],rot90(var_unnorm(:,i)),'delimiter',' ','precision',8);
end

