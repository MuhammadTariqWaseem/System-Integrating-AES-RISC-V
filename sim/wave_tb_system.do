onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_system/HEX0
add wave -noupdate -radix hexadecimal /tb_system/HEX1
add wave -noupdate -radix hexadecimal /tb_system/HEX2
add wave -noupdate -radix hexadecimal /tb_system/HEX3
add wave -noupdate -radix hexadecimal /tb_system/HEX4
add wave -noupdate -radix hexadecimal /tb_system/HEX5
add wave -noupdate -radix hexadecimal /tb_system/raw_reset
add wave -noupdate -color Red -radix hexadecimal /tb_system/VR
add wave -noupdate -color {Dark Green} -radix hexadecimal /tb_system/VG
add wave -noupdate -color {Medium Blue} -radix hexadecimal /tb_system/VB
add wave -noupdate -radix hexadecimal /tb_system/blank_N
add wave -noupdate -radix hexadecimal /tb_system/sync_N
add wave -noupdate -radix hexadecimal /tb_system/H_Sync
add wave -noupdate -radix hexadecimal /tb_system/V_Sync
add wave -noupdate -radix hexadecimal /tb_system/clk
add wave -noupdate -color White -radix hexadecimal /tb_system/clk_pll
add wave -noupdate /tb_system/system/clk_aes
add wave -noupdate /tb_system/system/clk_proc
add wave -noupdate /tb_system/system/clk_vga
add wave -noupdate -divider RISC-V
add wave -noupdate -radix hexadecimal /tb_system/system/processor_6_stage/register_28
add wave -noupdate -radix hexadecimal /tb_system/system/processor_6_stage/register_29
add wave -noupdate -radix hexadecimal /tb_system/system/processor_6_stage/register_30
add wave -noupdate -radix hexadecimal /tb_system/system/processor_6_stage/register_31
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/PC
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/InstrD
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/ImmExt
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/SrcE
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/ALUResultX
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/ALUResultM
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/processor_6_stage/WriteDataW
add wave -noupdate -divider RISCV_AES_connect
add wave -noupdate -radix hexadecimal /tb_system/system/AES_riscv_connect/aes_encrypt
add wave -noupdate -radix hexadecimal /tb_system/system/AES_riscv_connect/aes_decrypt
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/write_en
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/data_addr
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/key_addr
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/write_addr
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/write_data
add wave -noupdate -color Cyan -radix hexadecimal /tb_system/system/AES_riscv_connect/no_of_words
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/read_data
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/valid_in_en
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/valid_in_de
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/data_in
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/key
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/valid_out_en
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/data_out_en
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/valid_out_de
add wave -noupdate -color Coral -radix hexadecimal /tb_system/system/AES_riscv_connect/data_out_de
add wave -noupdate -divider RISC-v_VGA
add wave -noupdate -color {Medium Spring Green} -radix hexadecimal /tb_system/system/connect_riscv_vga/address
add wave -noupdate -color {Medium Spring Green} -radix hexadecimal /tb_system/system/connect_riscv_vga/data_wr
add wave -noupdate -color {Medium Spring Green} -radix hexadecimal /tb_system/system/connect_riscv_vga/write_en
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/connect_riscv_vga/write_out_en
add wave -noupdate -color {Medium Spring Green} -radix hexadecimal /tb_system/system/connect_riscv_vga/regi_28
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/connect_riscv_vga/ascii
add wave -noupdate -divider Memory_write_VGA
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/w_en
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/ascii
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/data
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/w_en_d
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/row_offset
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb_system/system/memory_write_VGA/col_offset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {448550094500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 107
configure wave -valuecolwidth 199
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {162053320198 ps} {1066470882306 ps}
