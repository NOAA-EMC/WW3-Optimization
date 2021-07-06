function [N,ERR] = buoy_error(buoy_netcdf,var_buoy_name,var_buoy_time,var_buoy_v,ww3_netcdf,var_ww3_buoy_name,var_ww3_time,var_ww3_v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program compares the buoy observation (stationary) and model       %
% outouts (point).                                                        %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%buoy_netcdf: the name of netcdf file for buoy observations
%var_buoy_name: the name of buoy station (station)
%var_buoy_time: the name of variable for time in buoy observations [Q,1]
%var_buoy_v: the name of variable to be compared with the model in
%observations [Q,1]
%ww3_netcdf: the name of netcdf file for WW3 (point) 
%var_ww3_buoy_name: the name of buoy station (station)
%var_ww3_time: the name of variable for time in WW3 [M,1]
%var_ww3_v: the name of variable to be compared with the observations in
%model [station,M]
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N: number of observations and model outputs
%ERR: Root mean square error (rmse)
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from bouy/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N,ERR] = buoy_error('buoy.nc','station_name','time',...
%'wave_height','ww3.pnt.nc','station_name','time','hs')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%read buoy data
buoy_name=cellstr(flipud(rot90(ncread(buoy_netcdf,var_buoy_name))));
[timebuoy]=convert_time(buoy_netcdf,var_buoy_time);
vbuoy=double(ncread(buoy_netcdf,var_buoy_v));
%read model data
buoy_ww3_name=cellstr(flipud(rot90(ncread(ww3_netcdf,var_ww3_buoy_name))));
[timeww3]=convert_time(ww3_netcdf,var_ww3_time);
vww3=double(ncread(ww3_netcdf,var_ww3_v));
%rot90 the time variables
tww3(1,:)=timeww3(:,1);
tbuoy(1,:)=timebuoy(:,1);
%interpolation
for i=1:length(vww3(:,1))
VWW3(i,:)=interp1(tww3,vww3(i,:),tbuoy);
end
%number of scatters
DIFF=(VWW3(:)-vbuoy(:)).^2;
N=length(DIFF(~isnan(DIFF)));
%RMSE
ERR=rmse(VWW3,vbuoy);
