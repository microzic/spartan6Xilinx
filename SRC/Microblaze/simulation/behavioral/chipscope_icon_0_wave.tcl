#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     chipscope_icon_0_wave.tcl (Tue Feb 07 11:54:20 2023)
#
#  Module   system_chipscope_icon_0_wrapper
#  Instance chipscope_icon_0
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}system" }

  wave add $tbpath${ps}chipscope_icon_0${ps}control0 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control1 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control2 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control3 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control4 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control5 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control6 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control7 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control8 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control9 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control10 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control11 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control12 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control13 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control14 -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}control15 -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}tdi_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}reset_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}shift_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}update_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}sel_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}drck_in -into $id
  wave add $tbpath${ps}chipscope_icon_0${ps}capture_in -into $id
# wave add $tbpath${ps}chipscope_icon_0${ps}tdo_out -into $id

