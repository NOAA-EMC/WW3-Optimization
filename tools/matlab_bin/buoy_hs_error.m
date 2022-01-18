function [N_GLOBAL,RMSE_GLOBAL,BIAS_GLOBAL,AE_GLOBAL,N_REGIONAL,RMSE_REGIONAL,BIAS_REGIONAL,AE_REGIONAL] = buoy_hs_error(buoy_netcdf,var_buoy_name,var_buoy_lon,var_buoy_lat,var_buoy_time,var_buoy_v,model_netcdf,var_model_lon,var_model_lat,var_model_time,var_model_v,lon_min,lon_max,lat_min,lat_max,plott)
%-------------------------------------------------------------------------
% This program compares the buoy observation (hs) and wave model          %
% outouts (point).                                                        %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%-------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%buoy_netcdf: the name of netcdf file for buoy observations
%var_buoy_name: the name of buoy station (station)
%var_buoy_time: the name of variable for time in buoy observations [Q,1]
%var_buoy_lon: the name of variable for longitude in observations [Q,1]
%var_buoy_lat: the name of variable for latitude in observations [Q,1]
%var_buoy_v: the name of variable to be compared with the model in
%observations [Q,1]
%model_netcdf: the name of netcdf file for ATM model (gridded) 
%var_model_lon: the name of variable for longitude in WW3 [M,1]
%var_model_lat: the name of variable for latitude in WW3 [P,1]
%var_model_time: the name of variable for time in WW3 [M,1]
%var_model_v: the name of variable to be compared with the observations in
%model [P,M] 
%[lon_min lon_max]: logitude minimum and maximum bounds for regional analysis
%[lat_min lat_max]: latitude minimum and maximum bounds for regional analysis
%DT: time frame for model validation [t-DT/2-t+DT/2] (hr)
% PLOTT: plot the data if plott=1 
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%N_GLOBAL: number of observations and model outputs for all data
%RMSE_GLOBAL: Root mean square error (rmse) for all data
%BIAS_GLOBAL: error (bias) for all data
%AE_GLOBAL: absolute error (ae) for all data
%N_REGIONAL: number of observations and model outputs for regional coverage
%RMSE_REGIONAL: Root mean square error (rmse) for regional coverage
%BIAS_REGIONAL: error (bias) for regional coverage
%AE_REGIONAL: absolute error (ae) for regional coverage
%%%%%%%%%%%%%%%%%%%%%%%% Dependency %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%convert_time: reads the unit from buoy/satellite/model and convert them to
% matlab time
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N_GLOBAL,ERR_GLOBAL,N_REGIONAL,ERR_REGIONAL] = ...
% buoy_hs_error('NDBC_obs.nc','station_name','lon','lat','time',...
% 'hs','gfs.nc','longitude','latitude','time',...
% 'hs',40,60,10,50,0)
%-------------------------------------------------------------------------
%read buoy data
latbuoy=double(ncread(buoy_netcdf,var_buoy_lat));
lonbuoy=double(ncread(buoy_netcdf,var_buoy_lon));
lonbuoy(lonbuoy<0)=lonbuoy(lonbuoy<0)+360;
buoy_name=cellstr(flipud(rot90(ncread(buoy_netcdf,var_buoy_name))));
[timebuoy_tmp]=convert_time(buoy_netcdf,var_buoy_time);
vbuoy_tmp=double(ncread(buoy_netcdf,var_buoy_v));
%average every 6 time steps (hourly)
vbuoy_tmp(:,end:6*(floor(length(vbuoy_tmp(1,:))/6)+1))=nan;
timebuoy_tmp(end:6*(floor(length(timebuoy_tmp(:,1))/6)+1))=timebuoy_tmp(end);
vbuoy_tmp(vbuoy_tmp<=0.5)=nan;
timebuoy_tmp2=reshape(timebuoy_tmp(:,1),6,[]);
timebuoy(:,1)=nanmean(timebuoy_tmp2);
for i=1:length(vbuoy_tmp(:,1))
clear vbuoy_tmp2
vbuoy_tmp2=reshape(vbuoy_tmp(i,:),6,[]);
vbuoy(i,:)=nanmean(vbuoy_tmp2);
end
%-------------------------------------------------------------------------
%read model data
latmodel=double(ncread(model_netcdf,var_model_lat));
lonmodel=double(ncread(model_netcdf,var_model_lon));
lonmodel(lonmodel<0)=lonmodel(lonmodel<0)+360;
[timemodel_tmp]=convert_time(model_netcdf,var_model_time);
vmodel_tmp=double(ncread(model_netcdf,var_model_v));
%average every 6 time steps (hourly)
vmodel_tmp(:,end:6*(floor(length(vmodel_tmp(1,:))/6)+1))=nan;
timemodel_tmp(end:6*(floor(length(timemodel_tmp(:,1))/6)+1))=timemodel_tmp(end);
vmodel_tmp(vmodel_tmp<=0.5)=nan;
timemodel_tmp2=reshape(timemodel_tmp(:,1),6,[]);
timemodel(:,1)=nanmean(timemodel_tmp2);
for i=1:length(vmodel_tmp(:,1))
clear vmodel_tmp2
vmodel_tmp2=reshape(vmodel_tmp(i,:),6,[]);
vmodel(i,:)=nanmean(vmodel_tmp2);
end

%mesh grid the gridded model for interpolation
%X=lonmodel;
%Y=latmodel;
%[T]=ones(size(lonmodel)).*rot90(timemodel);
%[Y,X,T]=meshgrid(latmodel(:,1),lonmodel(:,1),timemodel);
%-------------------------------------------------------------------------
%global
%interpolation
%VMODEL_GLOBAL=interp3(Y,X,T,vmodel,latbuoy,lonbuoy,timebuoy);
%rot90 the time variables
tmodel(1,:)=timemodel(:,1);
tbuoy(1,:)=timebuoy(:,1);
%interpolation
for i=1:length(vmodel(:,1))
  VMODEL_GLOBAL(i,:)=interp1(tmodel,vmodel(i,:),tbuoy);
end

%number of scatters
DIFF_GLOBAL=VMODEL_GLOBAL(:)-vbuoy(:);
[in,jn]=find(~isnan(DIFF_GLOBAL));
N_GLOBAL=length(DIFF_GLOBAL(~isnan(DIFF_GLOBAL)));
%RMSE
RMSE_GLOBAL = sqrt(nanmean((VMODEL_GLOBAL(:)-vbuoy(:)).^2));  % Root Mean Squared Error
BIAS_GLOBAL = nanmean((VMODEL_GLOBAL(:)-vbuoy(:)));  % Error
AE_GLOBAL = nanmean(abs(VMODEL_GLOBAL(:)-vbuoy(:)));  % Absolute Error

%-------------------------------------------------------------------------
%regional
%regional
LON(:,1)=lonmodel(:,1);
LAT(:,1)=latmodel(:,1);
[ii,jj]=find(LON<lon_min | LON>lon_max | LAT<lat_min | LAT>lat_max);

% the following block is the same as previous line to determine the points outside box
%m=0;
%n=0;
%for i=1:length(LON)
%  if (LON(i,1)>=lon_min && LON(i,1)<=lon_max && LAT(i,1)>=lat_min && LAT(i,1)<=lat_max);
%    n=n+1;
%    in(n)=i;
%  else
%    m=m+1;
%    ii(m,1)=i;
%  end
%end

VWW3_REGIONAL=VMODEL_GLOBAL;
for i=1:length(ii)
  VWW3_REGIONAL(ii(i),:)=nan;
end
%number of scatters
DIFF_REGIONAL=(VWW3_REGIONAL(:)-vbuoy(:));
N_REGIONAL=length(DIFF_REGIONAL(~isnan(DIFF_REGIONAL)));
%RMSE
RMSE_REGIONAL = sqrt(nanmean((DIFF_REGIONAL).^2));  % Root Mean Squared Error
BIAS_REGIONAL = nanmean((DIFF_REGIONAL));  % Error
AE_REGIONAL = nanmean(abs(DIFF_REGIONAL));  % Absolute Error

%-------------------------------------------------------------------------
%plotting fields
   if plott==1
   close all
    width=1200;  % Width of figure for movie [pixels]
    height=500;  % Height of figure of movie [pixels]
    left=200;     % Left margin between figure and screen edge [pixels]
    bottom=200;  % Bottom margin between figure and screen edge [pixels]
 %load coastline for continent boundaries
 load coast
 long(long<0)=long(long<0)+360;
 long(long<2)=nan;
    
    figure
    set(gcf,'Position', [left bottom width height])
    subplot(1,2,1)
    scatter(lonbuoy,latbuoy,'xr');
    hold on
    scatter(lonbuoy(ii),latbuoy(ii),'ob','filled');
    hold on
    plot(long,lat','k','linewidth',2);
    hold on
    plot([lon_min lon_max lon_max lon_min lon_min],[lat_min lat_min lat_max lat_max lat_min],'m','linewidth',2)
    box on
    axis on
    axis equal
    xlim([nanmin(lonmodel(:)),nanmax(lonmodel(:))])
    ylim([nanmin(latmodel(:)),nanmax(latmodel(:))])
    xlabel('Longitude','FontSize',12)
    ylabel('Latitude','FontSize',12)
    title(['Date: ',datestr(timemodel(1)),' - ',datestr(timemodel(end))],'FontSize',12)
    subplot(1,2,2)
    p1=scatter(vbuoy(:),VMODEL_GLOBAL(:),'xb');
    hold on;
    p2=scatter(vbuoy(:),VWW3_REGIONAL(:),'or');
    hold on
    p3=plot([0 40],[0 40],'--k','linewidth',2)
    legend([p1,p2,p3],['global-master Blend N = ',num2str(N_GLOBAL),' RMSE = ',num2str(RMSE_GLOBAL),' E = ',num2str(BIAS_GLOBAL),' |E| = ',num2str(AE_GLOBAL)],['Regional N = ',num2str(N_REGIONAL),' RMSE = ',num2str(RMSE_REGIONAL),' E = ',num2str(BIAS_REGIONAL),' |E| = ',num2str(AE_REGIONAL)],'1:1','location','northoutside')
    max_val=nanmax(nanmax(VMODEL_GLOBAL(in)),nanmax(vbuoy(in)))+1;
    max_val(isempty(max_val))=1;
    max_val(isnan(max_val))=1;
    xlim([0 max_val])
    ylim([0 max_val])
    axis on
    box on
    grid on
    xlabel('obs','FontSize',12)
    ylabel('model','FontSize',12)
    print('-dpng',[model_netcdf,'_buoy.png'])
   end
   %-------------------------------------------------------------------------
