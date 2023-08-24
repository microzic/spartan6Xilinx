
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name key_test -dir "D:/AX309-master/SRC/Verilog/05_key_test/planAhead_run_1" -part xc6slx9ftg256-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "key_test.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {key_test.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top key_test $srcset
add_files [list {key_test.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9ftg256-2
