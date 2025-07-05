if {[file exists work]} {
    vdel -lib work -all
}

vlib work
vlog -sv tb_system.sv 
vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/system.sv 

vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/AES_DATA_mem.v
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/aes_encrypter/verilog/rtl/aes_encrypter.sv
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/key_expansion/verilog/rtl/key_expansion.sv
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/key_expansion/verilog/rtl/sub_word.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/memory/verilog/rtl/aes_sbox.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/mix_column/verilog/rtl/mix_column.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/mix_column/verilog/rtl/gf_mul.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/shift_rows/verilog/rtl/shift_rows.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/ENCRYPTION/sub_byte/verilog/rtl/sub_byte.sv 
vlog -sv E:/intelFPGA_lite/19.1/modelsim_ase/altera/verilog/src/altera_mf.v

vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/DECRYPTION/aes_decrypter/verilog/rtl/aes_decrypter.sv
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/DECRYPTION/memory/verilog/rtl/aes_isbox.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/DECRYPTION/inv_mix_column/verilog/rtl/inv_mix_column.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/DECRYPTION/inv_shift_rows/verilog/rtl/inv_shift_rows.sv 
vlog -sv C:/Users/PC/Desktop/fyd/AES_Hardware_Accellerator/FYP_RTL_DESIGN/DECRYPTION/inv_sub_byte/verilog/rtl/inv_sub_byte.sv 

vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/reset_debouncer.sv

vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/AES_riscv_connect.sv

vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/vga_pll.v 
vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/vga_pll/vga_pll_0002.v

vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/system_PLL/system_PLL_0002.v 
vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/system_PLL/system_PLL_0002/system_PLL_0002_0002.v

vlog -sv E:/intelFPGA_lite/19.1/modelsim_ase/altera/verilog/src/altera_lnsim.sv

vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/processor_6_stage.sv
vlog -sv C:/Users/PC/Desktop/fyd/single_cycle_processor/controller/rtl/controller.sv ../../single_cycle_processor/ALUdecoder/rtl/ALUdecoder.sv 
vlog -sv C:/Users/PC/Desktop/fyd/single_cycle_processor/opdecoder/rtl/opdecoder.sv ../../single_cycle_processor/extend/rtl/extend.sv
vlog -sv C:/Users/PC/Desktop/fyd/single_cycle_processor/adder/rtl/adder.sv ../../single_cycle_processor/ALU/rtl/ALU.sv 
vlog -sv C:/Users/PC/Desktop/fyd/single_cycle_processor/flipflop/rtl/flip_flop.sv ../../single_cycle_processor/memory/rtl/memory.v
vlog -sv E:/intelFPGA_lite/19.1/modelsim_ase/altera/verilog/src/altera_mf.v
vlog -sv E:/intelFPGA_lite/19.1/modelsim_ase/altera/verilog/src/altera_mf.v
vlog -sv C:/Users/PC/Desktop/fyd/processor_6_stage/forwordingunit_up/rtl/forwordingunit_up.sv
vlog -sv C:/Users/PC/Desktop/fyd/processor_6_stage/hazardunit_up/rtl/hazardunit_up.sv
vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/register_up.sv

vlog -sv C:/Users/PC/Desktop/fyd/system/rtl/connect_riscv_vga.sv 
vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/memory_write_VGA.sv 
vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/vgamem.v 
vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/dispmem.v 
vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/dispmem_1.v

vlog -sv C:/Users/PC/Desktop/fyd/burning_riscv_vga/rtl/VGA_port.sv 

vsim -novopt tb_system
# add wave *
do wave_tb_system.do
run -all
