clear all
clc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program merge all the netcdf files into one (10 min) similar to   %
% WW3 format                                                             %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yr=2020;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen('NDBC_ww3_list.txt');
data = textscan(fid,'%s%s%s');
fclose(fid);
% list of buoy used in GFSv16 wave
B=data{1}(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%stdmet- Standard Meteorological data
% [time, station]
disp('Standard Meteorological data')
disp('Start ...')
disp(['year = ',num2str(yr)])

m=0; 


% define hourly time
t0=datenum([num2str(yr),'0101'],'YYYYMMDD')-60/3600/24;
t1=datenum([num2str(yr+1),'0101'],'YYYYMMDD')-60/3600/24;
TIME(:,1)=t0:1/6/24:t1;


for i=1:length(B)
    %check if it exist locally
    if isfile([B{i},'h',num2str(yr),'.nc'])
       clearvars -except i B TIME yr m LATITUDE LONGITUDE WIND_DIR WIND_SPD GUST ...
        DOMINANT_WPD WAVE_HEIGHT AVERAGE_WPD MEAN_WAVE_DIR AIR_PRESSURE AIR_PRESSURE ...
        AIR_TEMPERATURE SEA_SURFACE_TEMPERATURE VISIBILITY WATER_LEVEL DEWPT_TEMPERATURE
       %time=double(ncread([B{i},'h',num2str(yr),'.nc'],'time'))/3600/24+datenum('19700101','YYYYMMDD')-60/3600/24;
       [time]=convert_time([B{i},'h',num2str(yr),'.nc'],'time');
       latitude=ncread([B{i},'h',num2str(yr),'.nc'],'latitude');
       LATITUDE(i,1)=latitude;
       longitude=ncread([B{i},'h',num2str(yr),'.nc'],'longitude');
       LONGITUDE(i,1)=longitude;
       wind_dir(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'wind_dir');
       WIND_DIR(i,:)=interp1(time,wind_dir,TIME);
       wind_spd(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'wind_spd');
       WIND_SPD(i,:)=interp1(time,wind_spd,TIME);
       gust(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'gust');
       GUST(i,:)=interp1(time,gust,TIME);
       dominant_wpd(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'dominant_wpd');
       DOMINANT_WPD(i,:)=interp1(time,dominant_wpd,TIME);
       wave_height(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'wave_height');
       WAVE_HEIGHT(i,:)=interp1(time,wave_height,TIME);
       average_wpd(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'average_wpd');
       AVERAGE_WPD(i,:)=interp1(time,average_wpd,TIME);
       mean_wave_dir(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'mean_wave_dir');
       MEAN_WAVE_DIR(i,:)=interp1(time,mean_wave_dir,TIME);
       air_pressure(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'air_pressure');
       AIR_PRESSURE(i,:)=interp1(time,air_pressure,TIME);
       air_temperature(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'air_temperature');
       AIR_TEMPERATURE(i,:)=interp1(time,air_temperature,TIME);
       sea_surface_temperature(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'sea_surface_temperature');
       SEA_SURFACE_TEMPERATURE(i,:)=interp1(time,sea_surface_temperature,TIME);
       dewpt_temperature(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'dewpt_temperature');
       DEWPT_TEMPERATURE(i,:)=interp1(time,dewpt_temperature,TIME);
       visibility(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'visibility');
       VISIBILITY(i,:)=interp1(time,visibility,TIME);
       water_level(:,1)=ncread([B{i},'h',num2str(yr),'.nc'],'water_level');
       WATER_LEVEL(i,:)=interp1(time,water_level,TIME);
    else
       disp([B{i},'h',num2str(yr),'.nc does not exist.'])
       LATITUDE(i,1)=nan;
       LONGITUDE(i,1)=nan;
       WIND_DIR(i,:)=nan*ones(1,length(TIME));
       WIND_SPD(i,:)=nan*ones(1,length(TIME)); 
       GUST(i,:)=nan*ones(1,length(TIME));
       DOMINANT_WPD(i,:)=nan*ones(1,length(TIME));
       WAVE_HEIGHT(i,:)=nan*ones(1,length(TIME)); 
       AVERAGE_WPD(i,:)=nan*ones(1,length(TIME)); 
       MEAN_WAVE_DIR(i,:)=nan*ones(1,length(TIME));
       AIR_PRESSURE(i,:)=nan*ones(1,length(TIME));
       AIR_TEMPERATURE(i,:)=nan*ones(1,length(TIME));
       SEA_SURFACE_TEMPERATURE(i,:)=nan*ones(1,length(TIME));
       DEWPT_TEMPERATURE(i,:)=nan*ones(1,length(TIME));
       VISIBILITY(i,:)=nan*ones(1,length(TIME));
       WATER_LEVEL(i,:)=nan*ones(1,length(TIME));
    end
       
end   

disp('Data interpolation Finished.')
%%    

disp('NETCDF file preparation ...')
ncfile=['NDBC_h_',num2str(yr),'.nc'];
source='NDBC';

[nstat,nt] = size(WAVE_HEIGHT);
BB=char(B);
[nstat1,string10p]=size(BB);
%[noell,eelem] = size(triiHSOFS);
t(:,1)=TIME-datenum('19900101','YYYYMMDD');

%nc = netcdf.create(ncfile, '64BIT_OFFSET');
nc = netcdf.create(ncfile,'NETCDF4');
% define global attributes
netcdf.putAtt(nc, netcdf.getConstant('NC_GLOBAL'), 'start_date',datestr(TIME(1)))
netcdf.putAtt(nc, netcdf.getConstant('NC_GLOBAL'), 'stop_date',datestr(TIME(end)))
netcdf.putAtt(nc, netcdf.getConstant('NC_GLOBAL'), 'source',source)
netcdf.putAtt(nc, netcdf.getConstant('NC_GLOBAL'), 'field type','10 min')
netcdf.putAtt(nc, netcdf.getConstant('NC_GLOBAL'), 'content','NDBC data (merged)')

% define dimensions
level = netcdf.defDim(nc, 'level', 1);
timet = netcdf.defDim(nc, 'time', nt);
nnstat = netcdf.defDim(nc, 'station', nstat);
string10 = netcdf.defDim(nc, 'string10', string10p);
%Variables:

time_varid = netcdf.defVar(nc, 'time', 'double', [timet]);
netcdf.putAtt(nc, time_varid, 'long_name', 'julian day (UT)');
netcdf.putAtt(nc, time_varid, 'units', 'days since 1990-01-01 00:00:00');
netcdf.putAtt(nc, time_varid, 'field', 'time, scalar, series');
netcdf.putAtt(nc, time_varid, 'conventions', 'relative julian days with decimal part (as parts of the day )');
netcdf.putAtt(nc, time_varid, 'axis', 'T');

stat_varid=netcdf.defVar(nc, 'station_name' ,'NC_CHAR',[nnstat,string10]);
netcdf.putAtt(nc, stat_varid, 'long_name', 'station name');
netcdf.putAtt(nc, stat_varid, 'field', 'station, scalar, series');

lon_varid=netcdf.defVar(nc, 'longitude' ,'NC_FLOAT',[nnstat]);
netcdf.putAtt(nc, lon_varid, 'long_name', 'longitude');
netcdf.putAtt(nc, lon_varid, 'units', 'degree_east');
netcdf.putAtt(nc, lon_varid, 'field', 'lon, scalar, series');
netcdf.defVarFill(nc,lon_varid,false,999);

lat_varid=netcdf.defVar(nc, 'latitude' ,'NC_FLOAT',[nnstat]);
netcdf.putAtt(nc, lat_varid, 'long_name', 'latitude');
netcdf.putAtt(nc, lat_varid, 'units', 'degree_north');
netcdf.putAtt(nc, lat_varid, 'field', 'lat, scalar, series');
netcdf.defVarFill(nc,lat_varid,false,999);

u1_varid=netcdf.defVar(nc, 'wind_dir' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u1_varid, 'units', 'degrees_true');
netcdf.putAtt(nc, u1_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u1_varid, 'long_name', 'Wind Direction');
netcdf.defVarFill(nc,u1_varid,false,999);

u2_varid=netcdf.defVar(nc, 'wind_spd' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u2_varid, 'units', 'meters/second');
netcdf.putAtt(nc, u2_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u2_varid, 'long_name', 'Wind Speed');
netcdf.defVarFill(nc,u2_varid,false,999);

u3_varid=netcdf.defVar(nc, 'gust' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u3_varid, 'units', 'meters/second');
netcdf.putAtt(nc, u3_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u3_varid, 'long_name', 'Wind Gust Speed');
netcdf.defVarFill(nc,u3_varid,false,999);

u4_varid=netcdf.defVar(nc, 'wave_height' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u4_varid, 'units', 'meters');
netcdf.putAtt(nc, u4_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u4_varid, 'long_name', 'Significant Wave Height');
netcdf.defVarFill(nc,u4_varid,false,999);

u5_varid=netcdf.defVar(nc, 'dominant_wpd' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u5_varid, 'units', 'deconds');
netcdf.putAtt(nc, u5_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u5_varid, 'long_name', 'Dominant Wave Period');
netcdf.defVarFill(nc,u5_varid,false,999);

u6_varid=netcdf.defVar(nc, 'average_wpd' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u6_varid, 'units', 'seconds');
netcdf.putAtt(nc, u6_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u6_varid, 'long_name', 'Average Wave Period');
netcdf.defVarFill(nc,u6_varid,false,999);

u7_varid=netcdf.defVar(nc, 'mean_wave_dir' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u7_varid, 'units', 'degrees_true');
netcdf.putAtt(nc, u7_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u7_varid, 'long_name', 'Mean Wave Direction');
netcdf.defVarFill(nc,u7_varid,false,999);

u8_varid=netcdf.defVar(nc, 'air_pressure' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u8_varid, 'units', 'hPa');
netcdf.putAtt(nc, u8_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u8_varid, 'long_name', 'Sea Level Pressure');
netcdf.defVarFill(nc,u8_varid,false,999);

u9_varid=netcdf.defVar(nc, 'air_temperature' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u9_varid, 'units', 'degree_Celsius');
netcdf.putAtt(nc, u9_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u9_varid, 'long_name', 'Air Temperature');
netcdf.defVarFill(nc,u9_varid,false,999);

u10_varid=netcdf.defVar(nc, 'sea_surface_temperature' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u10_varid, 'units', 'degree_Celsius');
netcdf.putAtt(nc, u10_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u10_varid, 'long_name', 'Sea Surface Temperature');
netcdf.defVarFill(nc,u10_varid,false,999);

u11_varid=netcdf.defVar(nc, 'dewpt_temperature' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u11_varid, 'units', 'degree_Celsius');
netcdf.putAtt(nc, u11_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u11_varid, 'long_name', 'Dew Point Temperature');
netcdf.defVarFill(nc,u11_varid,false,999);

u12_varid=netcdf.defVar(nc, 'visibility' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u12_varid, 'units', 'US_statute_miles');
netcdf.putAtt(nc, u12_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u12_varid, 'long_name', 'visibility');
netcdf.defVarFill(nc,u12_varid,false,999);

u13_varid=netcdf.defVar(nc, 'water_level' ,'NC_FLOAT',[nnstat,timet]);
netcdf.putAtt(nc, u13_varid, 'units', 'feet');
netcdf.putAtt(nc, u13_varid, 'field', 'U, scalar, series');
netcdf.putAtt(nc, u13_varid, 'long_name', 'Tide Water Level');
netcdf.defVarFill(nc,u13_varid,false,999);

netcdf.endDef(nc);

netcdf.putVar(nc, time_varid, t);
netcdf.putVar(nc, stat_varid, BB);
netcdf.putVar(nc, lon_varid, LONGITUDE);
netcdf.putVar(nc, lat_varid, LATITUDE);
netcdf.putVar(nc, u1_varid, WIND_DIR);
netcdf.putVar(nc, u2_varid, WIND_SPD);
netcdf.putVar(nc, u3_varid, GUST);
netcdf.putVar(nc, u4_varid, WAVE_HEIGHT);
netcdf.putVar(nc, u5_varid, DOMINANT_WPD);
netcdf.putVar(nc, u6_varid, AVERAGE_WPD);
netcdf.putVar(nc, u7_varid, MEAN_WAVE_DIR);
netcdf.putVar(nc, u8_varid, AIR_PRESSURE);
netcdf.putVar(nc, u9_varid, AIR_TEMPERATURE);
netcdf.putVar(nc, u10_varid, SEA_SURFACE_TEMPERATURE);
netcdf.putVar(nc, u11_varid, DEWPT_TEMPERATURE);
netcdf.putVar(nc, u12_varid, VISIBILITY);
netcdf.putVar(nc, u13_varid, WATER_LEVEL);



netcdf.close(nc);

%%
%%% if %nc = netcdf.create(ncfile, '64BIT_OFFSET'); selected
%fileattrib(ncfile,'+w');
%ncwriteatt(ncfile,'latitude','_FillValue', 999);
%ncwriteatt(ncfile,'longitude','_FillValue', 999);
%ncwriteatt(ncfile,'wind_dir','_FillValue', 999);
%ncwriteatt(ncfile,'wind_spd','_FillValue', 999);
%ncwriteatt(ncfile,'gust','_FillValue', 999);
%ncwriteatt(ncfile,'wave_height','_FillValue', 999);
%ncwriteatt(ncfile,'dominant_wpd','_FillValue', 999);
%ncwriteatt(ncfile,'average_wpd','_FillValue', 999);
%ncwriteatt(ncfile,'mean_wave_dir','_FillValue', 999);
%ncwriteatt(ncfile,'air_pressure','_FillValue', 999);
%ncwriteatt(ncfile,'air_temperature','_FillValue', 999);
%ncwriteatt(ncfile,'sea_surface_temperature','_FillValue', 999);
%ncwriteatt(ncfile,'dewpt_temperature','_FillValue', 999);
%ncwriteatt(ncfile,'visibility','_FillValue', 999);
%ncwriteatt(ncfile,'water_level','_FillValue', 999);

disp('NETCDF file preparation Finished')
