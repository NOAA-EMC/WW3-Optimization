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

# Fill the templates and retreive the forcings from global dump and hpss   
cd tests/test<name>   
modify _default_var.sh_ and add the start day (_STARTDATE_) and number of forecast days (_forecast_day_):   
`STARTDATE="<YYYY-MM-DD>"`   
`forecast_day=<NO>`   
 execute   
`bash prep.sh`   
