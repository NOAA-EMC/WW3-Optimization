function [xval] = unnormalize(lower_bound,upper_bound,vmin,vmax,var) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program unnormalizes vmin < val < vmax to                          %
% lower_bound < xval < upper_bound                                        %                                                       %                                                      %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%    INPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lower_bound: actual min value
%upper_bound:  actual max value
%vmin: normalized min value
%vmax: normalized max value
%var: normalized value
%%%%%%%%%%%%%%%%%%%    OUTPUT    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%xval: output value
%%%%%%%%%%%%%%%%%%%    example   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[xval] = unnormalize(-5000,2100,0,1,0.6338)
%var=-500
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 xval = ( lower_bound * ( vmax - var ) + upper_bound * ( var - vmin ) )/  ...
        ( vmax - vmin );
 xval(isnan(xval))=lower_bound;
