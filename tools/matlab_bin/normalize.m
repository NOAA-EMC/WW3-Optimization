function [var] = normalize(lower_bound,upper_bound,vmin,vmax,xval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program normalizes lower_bound < xval < upper_bound to             %
% vmin < val < vmax                                                       %                                                      %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lower_bound: input min value
%upper_bound: input max value
%vmin: target min value
%vmax: target max value
%xval: input value
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%var: normalized value
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[var] = normalize(-5000,2100,0,1,-500)
%var=0.6338
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 var = ( vmin * ( upper_bound - xval ) + vmax*( xval - lower_bound) )/...
       ( upper_bound - lower_bound );
