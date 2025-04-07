#!/bin/bash
set -e
source ~/.sdkman/bin/sdkman-init.sh
source ~/oss-cad-suite/environment
veryl clean
veryl build
echo "Yosys..."
yosys -l yosys.log -p "read_verilog -sv output/*.sv; synth_gowin -top axi4_test -json build.yosys.json -family gw2a" 

#nextpnr-himbaechel --log nextpnr.log --detailed-timing-report --freq 83 --timing-allow-fail --device GW2AR-LV18QN88C8/I7 --vopt family=GW2A-18C --vopt cst=tangnano20k.cst  --json build.yosys.json --write build.nextpnr.json
