function [N,ERR] = satellite_error(sat_netcdf,var_sat_lon,var_sat_lat,var_sat_time,var_sat_v,ww3_netcdf,var_ww3_lon,var_ww3_lat,var_ww3_time,var_ww3_v)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program compares the satellite observation (along track) and model %
% outouts (gridded).                                                      %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sat_netcdf: the name of netcdf file for observations
%var_sat_lon: the name of variable for longitude in observations [Q,1]
%var_sat_lat: the name of variable for latitude in observations [Q,1]
%var_sat_time: the name of variable for time in observations [Q,1]
%var_sat_v: the name of variable to be compared with the model in
%observations [Q,1]
%ww3_netcdf: the name of netcdf file for WW3 (gridded) 
%var_ww3_lon: the name of variable for longitude in WW3 [M,1]
%var_ww3_lat: the name of variable for latitude in WW3 [P,1]
%var_ww3_time: the name of variable for time in WW3 [M,1]
%var_ww3_v: the name of variable to be compared with the observations in
%model [P,M]
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N: number of observations and model outputs
%ERR: Root mean square error (rmse)
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from satellite/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N,ERR] = satellite_error('satellite.nc','lon','lat','time',...
%'swh','ww3.nc','longitude','latitude','time','hs')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%read satellie data
latsat=double(ncread(sat_netcdf,var_sat_lat));
lonsat=double(ncread(sat_netcdf,var_sat_lon));
[timesat]=convert_time(sat_netcdf,var_sat_time);
vsat=double(ncread(sat_netcdf,var_sat_v));
%read model data
latww3=double(ncread(ww3_netcdf,var_ww3_lat));
lonww3=double(ncread(ww3_netcdf,var_ww3_lon));
[timeww3]=convert_time(ww3_netcdf,var_ww3_time);
vww3=double(ncread(ww3_netcdf,var_ww3_v));
%mesh grid the gridded model for interpolation
[Y,X,T]=meshgrid(latww3,lonww3,timeww3);
%interpolation
VWW3=interp3(Y,X,T,vww3,latsat,lonsat,timesat);
%number of scatters
DIFF=VWW3-vsat;
N=length(DIFF(~isnan(DIFF)));
%RMSE
ERR=rmse(VWW3,vsat);
