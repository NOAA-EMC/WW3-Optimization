# WW3_Optimization
Physics Optimization tools

Users who only need to check out the latest code or certain tags can clone the repository without having a GitHub account:   
`git clone https://github.com/aliabdolali/WW3_Optimization.git`   
or with GitHub account   
`git clone git@github.com:aliabdolali/WW3_Optimization.git`     
`cd WW3_Optimization`      
% git checkout develop (or tags)     
`git submodule update --init --recursive`     

# compile nlopt with Matlab plugin    
`cd tools`   
`./makenlopt.sh`  

# Fill the templates and retrieve the forcings from global dump and hpss   
cd tests/test<name>   
modify _input_vars.sh_ and add the start day (_STARTDATE_), number of forecast days (_forecast_day_) and other required parameters:   
`STARTDATE="<YYYY-MM-DD>"`   
`forecast_day=<NO>`   
 execute   
`bash prep.sh`    
 to fill templates for WW3 _input_, fix files, restart, forcing and observations (satellite and point source data) retrieval.    
