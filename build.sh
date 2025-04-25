#!/bin/bash
source ~/oss-cad-suite/environment
veryl clean
veryl build
echo "Yosys..."
yosys -m slang -l yosys.log -p "read_slang output/src/*.sv output/src/*.sv; synth_gowin -top top -json build.yosys.json -family gw2a" 

