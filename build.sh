#!/bin/bash
source ~/oss-cad-suite/environment
veryl clean
veryl build
echo "Yosys..."
yosys -l yosys.log -p "read_verilog -sv output/axi_if.sv output/axi_test.sv; synth_gowin -top axi_test -json build.yosys.json -family gw2a" 
echo "Yosys variant 2..."
yosys -l yosys-variant.log -p "read_verilog -sv output/axi_if_variant.sv output/axi_test_variant.sv; synth_gowin -top axi_test -json build.yosys.json -family gw2a" 

