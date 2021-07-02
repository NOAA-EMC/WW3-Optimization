clear all
clc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program downloads the hidtorical NDBC data for a given year       %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yr=2019;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid = fopen('NDBC_ww3_list.txt');
data = textscan(fid,'%s%s%s');
fclose(fid);
% list of buoy used in GFSv16 wave
B=data{1}(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%swden - Spectral Wave Density data with Spectral Wave Direction data
disp('Spectral Wave Density data with Spectral Wave Direction data Data')
disp('Start ...')
disp(['year = ',num2str(yr)])

m=0; 


for i=1:length(B)
    %check if it exist locally
    if isfile([B{i},'w',num2str(yr),'.nc'])
       disp([B{i},'w',num2str(yr),'.nc exists.'])
    else
myURL=['https://dods.ndbc.noaa.gov/thredds/fileServer/data/swden/',B{i},'/',B{i},'w',num2str(yr),'.nc'];
[str,status] = urlread(myURL);
%if wave data is available
if status==1
    m=m+1;
urlwrite(myURL,[B{i},'w',num2str(yr),'.nc']);
%XY1(m,1)=X(i);
%XY1(m,2)=Y(i);
II1(m,1)=i;
disp(['Downloading swden for NDBC#',B{i},' ...']) 
else
disp(['swden NDBC#',B{i},' is not avaiable']) 
end
    end
  
end

disp('Finished.')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%stdmet- Standard Meteorological data
disp('Standard Meteorological data')
disp('Start ...')
disp(['year = ',num2str(yr)])

m=0; 

for i=1:length(B)
    %check if it exist locally
    if isfile([B{i},'h',num2str(yr),'.nc'])
       disp([B{i},'h',num2str(yr),'.nc exists.'])
    else
        
myURL=['https://dods.ndbc.noaa.gov/thredds/fileServer/data/stdmet/',B{i},'/',B{i},'h',num2str(yr),'.nc'];
[str,status] = urlread(myURL);
%if wave data is available
if status==1
    m=m+1;
urlwrite(myURL,[B{i},'h',num2str(yr),'.nc']);
%XY1(m,1)=X(i);
%XY1(m,2)=Y(i);
II1(m,1)=i;
disp(['Downloading stdmet for NDBC#',B{i},' ...']) 
else
disp(['stdmet NDBC#',B{i},' is not avaiable']) 
end
    end
end
  


disp('Finished.')



