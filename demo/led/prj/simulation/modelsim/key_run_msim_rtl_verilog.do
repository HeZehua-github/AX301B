transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/FPGA_Project/AX301demo/key/rtl {E:/FPGA_Project/AX301demo/key/rtl/key.v}

vlog -vlog01compat -work work +incdir+E:/FPGA_Project/AX301demo/key/prj/../testbenth {E:/FPGA_Project/AX301demo/key/prj/../testbenth/key_tb.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  key_tb

add wave *
view structure
view signals
run -all
