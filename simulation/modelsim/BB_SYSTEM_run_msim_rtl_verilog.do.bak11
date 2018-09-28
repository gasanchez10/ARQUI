transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/uDataPath.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/SC_STATEMACHINE.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/SC_RegSHIFTER.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/SC_RegGENERAL.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/SC_RegFIXED.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/CC_MUXX.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/CC_DECODER.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/CC_ALU.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1 {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/BB_SYSTEM.v}
vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/rtl/WB_SYSTEM.v}

vlog -vlog01compat -work work +incdir+/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/simulation/modelsim {/media/fsegura/FES-INFO/Dropbox/work/de0nano/0DATAPATH/PRJ0_uDataPath_1/simulation/modelsim/TB_SYSTEM.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SYSTEM

add wave *
view structure
view signals
run -all
