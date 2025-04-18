#!/bin/bash
source ~/oss-cad-suite/environment
veryl clean
veryl build
echo "Yosys..."
yosys -m slang -l yosys.log -p "read_slang output/src/axi_if.sv output/src/axi_test.sv; synth_gowin -top axi_test -json build.yosys.json -family gw2a" 
echo "Yosys variant 2..."
yosys -m slang  -l yosys-variant.log -p "read_slang output/src/axi_if_variant.sv output/src/axi_test_variant.sv; synth_gowin -top axi_test_variant -json build.yosys.json -family gw2a" 

