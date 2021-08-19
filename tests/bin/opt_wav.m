%function [] = opt_wav
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program provides the x_opt for the next round of iteration or stops %
% computations if one of stop critera is met.                              %
% Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov                        %
% Matthew Masarik (EMC/NCEP/NOAA matthew.masarik@noaa.gov                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Refs:
%    * nlopt docs - https://nlopt.readthedocs.io/en/latest/NLopt_Introduction/
%
%          [IN]       x    := [x1, ..., xn], initial optimization parameters
%                     xn    := number of optimization parameters
%                     f    := f(x), objective fucntion, we seek min(f)
%                     lb   := lower bound on x
%                     ub   := upper bound on x
%          [OUT]      xopt := [y1, ..., yn], optimized parameter values
%                     fmin := minimized value of objective function
% ------------------------------------------------------------------------------
% add paths
    mat_bin_path = '../../tools/matlab_bin';
    mex_path = '../../tools/install/lib64/matlab';
    addpath(mex_path,mat_bin_path);
% ------------------------------------------------------------------------------
% constants
    xn   = 17;       % num optimization params, x
% ------------------------------------------------------------------------------
% read the table of bias and normalized 'x' (global error, regional error, x1, x2, ...)
    AA=dlmread('../opt_table_Err_norm',' ', 1, 0);
    x=load('default_x_norm');
% define lower and upper bounds for x (all are normalized and vary between 0 and 1)
    lb = zeros(xn,1);
    ub = ones(xn,1);
% ------------------------------------------------------------------------------
% opt: nlopt structure
    opt.algorithm     = NLOPT_LN_BOBYQA;
    opt.lower_bounds  = lb;
    opt.upper_bounds  = ub;
    opt.min_objective = @f;
    opt.xtol_abs      = ones(xn,1) * 10e-3;
    opt.xtol_rel      = 10e-3;
    opt.ftol_abs      = 10e-3;
    opt.ftol_rel      = 10e-3;
    opt.stopval       = 0; %acceptable BIAS
    opt.verbose       = 1;
    opt.maxeval       = 200;
%    opt.maxeval=length((AA(:,1)))+1
% ------------------------------------------------------------------------------
% initialize iteration
    m=0
    dlmwrite('m',m)
    % call: nlopt optimization function
    [xopt, fmin, retcode] = nlopt_optimize(opt, x)
% stop criteria
if retcode ==1
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'Generic success return value.');
    fclose(fileID);
end
if retcode ==2
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'stopval was reached.');
    fclose(fileID);
end
if retcode ==3
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'ftol_rel or ftol_abs was reached.');
    fclose(fileID);
end
if retcode ==4
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'xtol_rel or xtol_abs was reached.');
    fclose(fileID);
end
if retcode ==5
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'maxeval was reached.');
    fclose(fileID);
end
if retcode ==6
    fileID = fopen('../stop','w');
    fprintf(fileID,['%s\n'], 'maxtime was reached.');
    fclose(fileID);
end

% ------------------------------------------------------------------------------
  function [fval] = f(x)
   m=dlmread('m')
   m=m+1
    A=dlmread('../opt_table_Err_norm',' ', 1, 0);

%    if m<=length(A(:,1))
%    fval=A(m,2);
    [fval] = match_record(A, x, 10e-3)
%    else
%        fval=nan
%    end

    fileID = fopen('x_opt','w');
    fprintf(fileID,['%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n'], x);
    fclose(fileID);
    fileID = fopen('m','w');
    fprintf(fileID,['%d\n'], m);
    fclose(fileID);
    end
% ------------------------------------------------------------------------------
  function [fval_match] = match_record(RECS, new_rec, tol)
      fval_match = nan;    % init to 'no record found' value

      num_recs = size(RECS,1);
      num_params = size(RECS,2)-2;
      for r=1:num_recs
          curr_rec = RECS(r,3:num_params+2);
          if abs(curr_rec-new_rec) <= tol
              fval_match = RECS(r,2);
          end
      end
  end
