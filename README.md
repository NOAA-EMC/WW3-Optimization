# WW3_Optimization
Physics Optimization tools

![WW3_Optimization-4](https://user-images.githubusercontent.com/37336972/129954053-71b4c4bf-0649-441a-b67e-ac97b34ff6b0.png)

Users who only need to check out the latest code or certain tags can clone the repository without having a GitHub account:   
`git clone https://github.com/aliabdolali/WW3_Optimization.git`   
or with GitHub account   
`git clone git@github.com:aliabdolali/WW3_Optimization.git`     
`cd WW3_Optimization`      
% git checkout develop (or tags)     
`git submodule update --init --recursive`     

## compile nlopt with Matlab plugin    
`cd WW3_Optimization/tools`   
`./makenlopt.sh`  

## Fill the templates and retrieve the forcings from global dump and hpss and spinup run   
`cd WW3_Optimization/tests/test<test_name>`   
modify _input_vars.sh_ and add the start day (_STARTDATE_), number of forecast days (_forecast_day_) and other required parameters:   
`STARTDATE="<YYYY-MM-DD>"`   
`spinup_day=<NO1>`     
`forecast_day=<NO2>`   
 execute   
`./prep_spinup.sh`    
 to fill templates for WW3 fix files, forcing and observations (satellite and point source data) retrieval. This script is for model spinup for the duration of `spinup_day` before `STARTDATE` and continues for `forecast_day`. The filled WW3 input templates are then added to `input_spinup`.    
 
 ## Run model spinup     
![WW3_Optimization-5](https://user-images.githubusercontent.com/37336972/129953939-9230166d-aa48-4657-85f4-32f0fd860468.png)


`cd WW3_Optimization/tests`
 execute   
`./bin/spinup_matrix_prep`  
 to prepare spinup jobcard and submit it:          
 `sbatch spinup`   
 Once the spinup simulation is done, the restart* files at (_STARTDATE_) are written in `WW3_Optimization/tests/test<test_name>/work_spinup`.   
 
 ## Run initial runs (Optional)     
 In order to optimize _n_ physics parameters, the _NLOPT_LN_BOBYQA_ optimization method requires the model skill for the default and 2 perturbations around each parameter (Total of 2n+1). These _initial_ simulations can be done concurrently. 
 `cd WW3_Optimization/tests`
 execute   
`./bin/initial_matrix_prep`  
The initial matrix can be divided into sub-matrixes using       
`./bin/divider initial 9`         
which divides initial matrix into submatrixes, each with 3 tests.       

 ## Run Optimization 
 ![WW3_Optimization-6](https://user-images.githubusercontent.com/37336972/129954078-0802f941-a420-48cc-89fd-1acbc39e3707.png)

 `cd WW3_Optimization/tests`     
 execute   
`./bin/opt_matrix_prep`     
to prepare opt_matrix jobcard and submit:          
 `sbatch opt_matrix`    
 
 `WW3_Optimization/tests/opt_table_Err_unnorm` is populated after each round of data exchange between WW3 and NLOPT, where each row starts with global and regional scores followed by _n_ input variables.      
 
 
 
 
 
 
 
Developers:      
Ali Abdolali (EMC/NCEP/NOAA ali.abdolali@noaa.gov)      
Matthew Masarik (EMC/NCEP/NOAA matthew.masarik@noaa.gov) 
