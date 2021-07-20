function [N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = buoy_error(buoy_netcdf,var_buoy_name,var_buoy_time,var_buoy_v,ww3_netcdf,var_ww3_buoy_name,var_ww3_time,var_ww3_v,lon_min,lon_max,lat_min,lat_max)
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
%[lon_min lon_max]: logitude minimum and maximum bounds for regional analysis
%[lat_min lat_max]: latitude minimum and maximum bounds for regional analysis
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N_GLOBAL: number of observations and model outputs for all data
%ERR_GLOBAL: Root mean square error (rmse) for all data
%N_REGIONAL: number of observations and model outputs for regional coverage
%ERR_REGIONAL: Root mean square error (rmse) for regional coverage
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from bouy/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = buoy_error('buoy.nc',...
%'station_name','time','wave_height','ww3.pnt.nc','station_name','time','hs',...
%10,40,10,50);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%read buoy data
buoy_name=cellstr(flipud(rot90(ncread(buoy_netcdf,var_buoy_name))));
[timebuoy]=convert_time(buoy_netcdf,var_buoy_time);
vbuoy=double(ncread(buoy_netcdf,var_buoy_v));
%read model data
buoy_ww3_name=cellstr(flipud(rot90(ncread(ww3_netcdf,var_ww3_buoy_name))));
[timeww3]=convert_time(ww3_netcdf,var_ww3_time);
longitude=double(ncread(ww3_netcdf,'longitude'));
latitude=double(ncread(ww3_netcdf,'latitude'));
vww3=double(ncread(ww3_netcdf,var_ww3_v));
%rot90 the time variables
tww3(1,:)=timeww3(:,1);
tbuoy(1,:)=timebuoy(:,1);
%interpolation
for i=1:length(vww3(:,1))
  VWW3_GLOBAL(i,:)=interp1(tww3,vww3(i,:),tbuoy);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%global coverage
%number of scatters
DIFF_GLOBAL=(VWW3_GLOBAL(:)-vbuoy(:)).^2;
N_GLOBAL=length(DIFF_GLOBAL(~isnan(DIFF_GLOBAL)));
%RMSE
ERR_GLOBAL=rmse(VWW3_GLOBAL,vbuoy);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%regional
LON(:,1)=longitude(:,1);
LAT(:,1)=latitude(:,1);
[ii,jj]=find(LON<lon_min & LON>lon_max & LAT<lat_min & LAT>lat_max);
VWW3_REGIONAL=VWW3_GLOBAL;
for i=1:length(ii)
  VWW3_REGIONAL(ii(i),:)=nan;
end
%number of scatters
DIFF_REGIONAL=(VWW3_REGIONAL(:)-vbuoy(:)).^2;
N_REGIONAL=length(DIFF_REGIONAL(~isnan(DIFF_REGIONAL)));
%RMSE
ERR_REGIONAL=rmse(VWW3_REGIONAL,vbuoy);
