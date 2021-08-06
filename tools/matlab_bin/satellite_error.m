function [N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = satellite_error(sat_netcdf,var_sat_lon,var_sat_lat,var_sat_time,var_sat_v,ww3_netcdf,var_ww3_lon,var_ww3_lat,var_ww3_time,var_ww3_v,lon_min,lon_max,lat_min,lat_max)

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
%[lon_min lon_max]: logitude minimum and maximum bounds for regional analysis
%[lat_min lat_max]: latitude minimum and maximum bounds for regional analysis
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N_GLOBAL: number of observations and model outputs for all data
%ERR_GLOBAL: Root mean square error (rmse) for all data
%N_REGIONAL: number of observations and model outputs for regional coverage
%ERR_REGIONAL: Root mean square error (rmse) for regional coverage
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from satellite/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = satellite_error('satellite.nc',...
%'lon','lat','time','swh','ww3.nc','longitude','latitude','time','hs',40,60,10,50)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%read satellie data
latsat=double(ncread(sat_netcdf,var_sat_lat));
lonsat=double(ncread(sat_netcdf,var_sat_lon));
lonsat(lonsat<0)=lonsat(lonsat<0)+360;
[timesat]=convert_time(sat_netcdf,var_sat_time);
vsat=double(ncread(sat_netcdf,var_sat_v));
vsat(vsat<0)=nan;
%read model data
latww3=double(ncread(ww3_netcdf,var_ww3_lat));
lonww3=double(ncread(ww3_netcdf,var_ww3_lon));
[timeww3]=convert_time(ww3_netcdf,var_ww3_time);
vww3=double(ncread(ww3_netcdf,var_ww3_v));
%mesh grid the gridded model for interpolation
[Y,X,T]=meshgrid(latww3,lonww3,timeww3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global
%interpolation
VWW3_GLOBAL=interp3(Y,X,T,vww3,latsat,lonsat,timesat);
%VWW3 > 8 are excluded (vsat max is 8 m)
VWW3_GLOBAL(VWW3_GLOBAL>8)=nan;
%number of scatters
DIFF_GLOBAL=VWW3_GLOBAL-vsat;
N_GLOBAL=length(DIFF_GLOBAL(~isnan(DIFF_GLOBAL)));
%RMSE
ERR_GLOBAL=rmse(VWW3_GLOBAL,vsat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regional
[ii,jj]=find(lonsat>=lon_min & lonsat<=lon_max & latsat>=lat_min & latsat<=lat_max);
VWW3_REGIONAL=VWW3_GLOBAL(ii);
vsat2=vsat(ii);
%number of scatters
DIFF_REGIONAL=VWW3_REGIONAL-vsat2;
N_REGIONAL=length(DIFF_REGIONAL(~isnan(DIFF_REGIONAL)));
%RMSE
ERR_REGIONAL=rmse(VWW3_REGIONAL,vsat2);
