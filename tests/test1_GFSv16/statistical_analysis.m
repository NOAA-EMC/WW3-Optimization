%clear all
%clc
addpath('../../tools/matlab_bin/')
plott=1;
for i=23
    i
cd (['work_p_',num2str(i)])
%satellite
[S_N_GLOBAL(i,1),S_RMSE_GLOBAL(i,1),S_BIAS_GLOBAL(i,1),S_AE_GLOBAL(i,1),S_N_REGIONAL(i,1),S_RMSE_REGIONAL(i,1),S_BIAS_REGIONAL(i,1),S_AE_REGIONAL(i,1)] = satellite_hs_error('../obs/satellite_obs.nc',...
'lon','lat','time','swh',['ww3_out_grd_field.nc'],'longitude','latitude','time','hs',...
270.0,320.0,25.0,55.0,plott);
%buoy
[B_N_GLOBAL(i,1),B_RMSE_GLOBAL(i,1),B_BIAS_GLOBAL(i,1),B_AE_GLOBAL(i,1),B_N_REGIONAL(i,1),B_RMSE_REGIONAL(i,1),B_BIAS_REGIONAL(i,1),B_AE_REGIONAL(i,1)]  = buoy_hs_error('../obs/BUOY.nc',...
'station_name','longitude','latitude','time','wave_height',['ww3_out_pnt_tab.nc'],'longitude','latitude','time','hs',...
270.0,320.0,25.0,55.0,plott);
%global
ErrTot_GLOBAL(i,1)=((S_N_GLOBAL(i,1)*S_RMSE_GLOBAL(i,1))+(B_N_GLOBAL(i,1)*B_RMSE_GLOBAL(i,1)))/(S_N_GLOBAL(i,1)+B_N_GLOBAL(i,1));
%regional
ErrTot_REGIONAL(i,1)=((S_N_REGIONAL(i,1)*S_RMSE_REGIONAL(i,1))+(B_N_REGIONAL(i,1)*B_RMSE_REGIONAL(i,1)))/(S_N_REGIONAL(i,1)+B_N_REGIONAL(i,1))


%satellite
[Nsat_GLOBAL(i,1),ERRsat_GLOBAL(i,1),Nsat_REGIONAL(i,1),ERRsat_REGIONAL(i,1)] = satellite_error('../obs/satellite_obs.nc',...
'lon','lat','time','swh','ww3_out_grd_field.nc','longitude','latitude','time','hs',...
270.0,320.0,25.0,55.0);
%buoy
[Nbuoy_GLOBAL(i,1),ERRbuoy_GLOBAL(i,1),Nbuoy_REGIONAL(i,1),ERRbuoy_REGIONAL(i,1)] = buoy_error('../obs/BUOY.nc',...
'station_name','time','wave_height','ww3_out_pnt_tab.nc','station_name','time','hs',...
270.0,320.0,25.0,55.0);


cd ..
end
%%
figure
subplot(2,1,1)
plot(1:0.025:2,S_BIAS_REGIONAL,'b');
hold on;
plot(1:0.025:2,S_BIAS_GLOBAL,'r');
hold on;

plot(1:0.025:2,B_BIAS_REGIONAL,'k');
hold on;
plot(1:0.025:2,B_BIAS_GLOBAL,'m');
hold on;
subplot(2,1,2)
plot(1:0.025:2,ErrTot_GLOBAL,'b')
hold on
plot(1:0.025:2,ErrTot_REGIONAL,'r')
legend('global','regional')
hold on
figure
plot(1:0.025:2,ERRsat_GLOBAL,'-b');
hold on;
plot(1:0.025:2,ERRsat_REGIONAL,'-r')
hold on
plot(1:0.025:2,ERRbuoy_GLOBAL,'-k');
hold on;
plot(1:0.025:2,ERRbuoy_REGIONAL,'-m')


% Normalize input variables
%input_norm=dlmread('norm.nml');
%input_unnorm=dlmread('../input_6/unnorm.nml');
%input_norm_nml=input_norm(~isnan(input_norm));
%input_unnorm_nml=input_unnorm(~isnan(input_norm));

%Err_norm=[ErrTot_GLOBAL ErrTot_REGIONAL input_norm_nml];
%Err_unnorm=[ErrTot_GLOBAL ErrTot_REGIONAL input_unnorm_nml];
%dlmwrite('../input_6/Err_norm.nml',Err_norm,'delimiter',' ','precision',8);
%dlmwrite('../input_6/Err_unnorm.nml',Err_unnorm,'delimiter',' ','precision',8);
%dlmwrite('../work_6/Err_norm.nml',Err_norm,'delimiter',' ','precision',8);
%dlmwrite('../work_6/Err_unnorm.nml',Err_unnorm,'delimiter',' ','precision',8);






    