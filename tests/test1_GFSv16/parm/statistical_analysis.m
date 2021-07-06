clear all
clc
addpath('../../../tools/matlab_bin/')

[Nsat,ERRsat] = satellite_error('../obs/satellite_obs.nc','lon','lat','time',...
'swh','ww3_ounf_glo_15mxt/ww3_out_grd_glo_15mxt.nc','longitude','latitude','time','hs')

[Nbuoy,ERRbuoy] = buoy_error('../obs/BUOY.nc','station_name','time',...
'wave_height','ww3_out_pnt_tab.nc','station_name','time','hs')

ErrTot=((Nsat*ERRsat)+(Nbuoy*ERRbuoy))/(Nsat+Nbuoy)
fileID = fopen('Err','w');
fprintf(fileID,'%d\n',ErrTot);
fclose(fileID);

