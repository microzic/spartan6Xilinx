#  Simulation Model Generator
#  Xilinx EDK 14.7 EDK_P.20131013
#  Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
#
#  File     top_level_ports_wave.tcl (Tue Feb 07 11:54:20 2023)
#
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }
if { ![info exists tbpath] } { set tbpath "${ps}system" }

wave add $tbpath${ps}RESET -into $id 
wave add $tbpath${ps}CLK_P -into $id 
wave add $tbpath${ps}led_4b_GPIO_IO_pin -into $id 
wave add $tbpath${ps}key_4b_GPIO_IO_pin -into $id 
wave add $tbpath${ps}axi_uartlite_0_RX_pin -into $id 
wave add $tbpath${ps}axi_uartlite_0_TX_pin -into $id 
wave add $tbpath${ps}axi_iic_0_Sda_pin -into $id 
wave add $tbpath${ps}axi_iic_0_Scl_pin -into $id 
wave add $tbpath${ps}axi_rtc_GPIO_IO_pin -into $id 
wave add $tbpath${ps}spi_flash_SCK_pin -into $id 
wave add $tbpath${ps}spi_flash_MISO_pin -into $id 
wave add $tbpath${ps}spi_flash_MOSI_pin -into $id 
wave add $tbpath${ps}spi_flash_SS_pin -into $id 
wave add $tbpath${ps}smg_ip_0_Scan_Sig_pin -into $id 
wave add $tbpath${ps}smg_ip_0_SMG_Data_pin -into $id 
wave add $tbpath${ps}buzzer_1b_GPIO_IO_pin -into $id 
wave add $tbpath${ps}vga_ip_0_vga_vs_pin -into $id 
wave add $tbpath${ps}vga_ip_0_vga_r_pin -into $id 
wave add $tbpath${ps}vga_ip_0_vga_hs_pin -into $id 
wave add $tbpath${ps}vga_ip_0_vga_g_pin -into $id 
wave add $tbpath${ps}vga_ip_0_vga_b_pin -into $id 

