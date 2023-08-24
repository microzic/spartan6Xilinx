#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     chipscope_ila_0_wave.tcl (Tue Feb 07 11:54:20 2023)
#
#  Module   system_chipscope_ila_0_wrapper
#  Instance chipscope_ila_0
#  Because EDK did not create the testbench, the user
#  specifies the path to the device under test, $tbpath.
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}system" }

  wave add $tbpath${ps}chipscope_ila_0${ps}CHIPSCOPE_ILA_CONTROL -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}CLK -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}DATA -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG0 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG1 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG2 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG3 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG4 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG5 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG6 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG7 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG8 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG9 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG10 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG11 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG12 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG13 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG14 -into $id
  wave add $tbpath${ps}chipscope_ila_0${ps}TRIG15 -into $id
# wave add $tbpath${ps}chipscope_ila_0${ps}TRIG_OUT -into $id

