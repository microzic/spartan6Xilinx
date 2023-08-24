setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
assignFile -p 1 -file "D:/AX309-master/SRC/Verilog/05_key_test/key_test.bit"
attachflash -position 1 -spi "M25P16"
assignfiletoattachedflash -position 1 -file "D:/AX309-master/SRC/Verilog/05_key_test/Untitled.mcs"
attachflash -position 1 -spi "M25P16"
Program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
deleteDevice -position 1
