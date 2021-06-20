#!/bin/bash
set -eux

source default_vars.sh

source edit_inputs.sh

#inp prep
edit_ww3_multi < parm/ww3_multi.inp.IN > input/ww3_multi_grdset_a.inp
edit_ww3_fld < parm/ww3_gint.inp.IN > input/ww3_gint_grdset_a.inp
edit_ww3_fld < parm/ww3_ounf.inp.IN > input/ww3_ounf.inp
edit_ww3_fld < parm/ww3_grib_gnh_10m.inp.IN > input/ww3_grib_gnh_10m.inp
edit_ww3_fld < parm/ww3_grib_gsh_15m.inp.IN > input/ww3_grib_gsh_15m.inp
edit_ww3_fld < parm/ww3_grib_aoc_9km.inp.IN > input/ww3_grib_aoc_9km.inp
edit_ww3_fld < parm/ww3_grib_glo_15mxt.inp.IN > input/ww3_grib_glo_15mxt.inp
edit_ww3_ounp < parm/ww3_ounp.inp.IN > input/ww3_ounp_points.inp

#forcing
edit_forcing < parm/retreive_wind_hpss.sh.IN > forcing/retreive_wind_hpss.sh
edit_forcing < parm/retreive_ice.sh.IN > forcing/retreive_ice.sh
edit_forcing < parm/retreive_cur.sh.IN > forcing/retreive_cur.sh
edit_forcing < parm/retreive_restart_hpss.sh.IN > forcing/retreive_restart_hpss.sh
