module system (
	input  logic       clk      ,
	input  logic       raw_reset,
	output logic [6:0] HEX0     ,
	output logic [6:0] HEX1     ,
	output logic [6:0] HEX2     ,
	output logic [6:0] HEX3     ,
	output logic [6:0] HEX4     ,
	output logic [6:0] HEX5     ,
	output logic       clk_pll  ,
	output logic [7:0] VR       ,
	output logic [7:0] VG       ,
	output logic [7:0] VB       ,
	output logic       blank_N  ,
	output logic       sync_N   ,
	output logic       H_Sync   ,
	output logic       V_Sync    
);

	logic        reset_pll   ;
	logic [31:0] address     ;
	logic [31:0] data_wr     ;
	logic        write_en    ;
	logic        write_out_en;
	logic [ 7:0] ascii       ;
	logic        w_en_2d     ;
	logic [15:0] wr_addr     ;
	logic [ 7:0] data        ;
	logic        reset       ;
	logic        reset_d     ;
	logic [31:0] regi_28     ;
	logic [31:0] regi_29     ;
	logic [31:0] regi_30     ;
	logic [31:0] regi_31     ;
	logic [31:0] aes_read    ;

	logic clk_aes ;
	logic clk_proc;
	logic clk_vga ; 

	reset_debouncer reset_debouncer (
		.clk      (clk      ),
		.raw_reset(raw_reset),
		.sys_reset(reset    )
	);

	vga_pll vga_pll (
		.refclk  (clk      ),
		.rst     (1'b0     ),
		.outclk_0(clk_pll  ),
		.locked  (reset_pll)
	);

	system_PLL_0002 system_PLL (
		.refclk  (clk      ),
		.rst     (1'b0     ),
		.outclk_0(clk_vga  ),
		.outclk_1(clk_proc ),
		.outclk_2(clk_aes  ),
		.locked  (reset_pll)
	);


	AES_riscv_connect AES_riscv_connect (
		.clk_processor(clk_pll                                                                      ),
		.clk_aes      (clk_pll                                                                      ),
		.reset        (~reset                                                                       ),
		.aes_encrypt  (data_wr[10] && (address == 77)                                               ),
		.write_en     (write_en && (address != 77) && (address != 7756)                             ),
		.data_addr    (regi_29[16:0]                                                                ),
		.key_addr     (regi_30[15:0]                                                                ),
		.write_addr   (regi_31[15:0]                                                                ),
		.write_data   (data_wr                                                                      ),
		.aes_decrypt  (data_wr[11] && (address == 77)                                               ),
		.no_of_words  (((data_wr[10] | data_wr[11]) && (address == 77))? data_wr[9:0] : address[9:0]),
		.read_data    (aes_read                                                                     )
	);

	processor_6_stage processor_6_stage (
		.clk        (clk_pll ),
		.reset      (~reset  ),
		.aes_read   (aes_read),
		.ALUResultX (address ),
		.RD2X       (data_wr ),
		.MemWriteX  (write_en),
		.register_28(regi_28 ),
		.register_29(regi_29 ),
		.register_30(regi_30 ),
		.register_31(regi_31 )
	);

	connect_riscv_vga connect_riscv_vga (
		.clk         (clk_pll     ),
		.reset       (~reset      ),
		.address     (address     ),
		.data_wr     (data_wr     ),
		.write_en    (write_en    ),
		.write_out_en(write_out_en),
		.regi_28     (regi_28     ),
		.ascii       (ascii       )
	);
	
	memory_write_VGA memory_write_VGA (
		.clk    (clk_pll     ),
		.reset  (~reset      ),
		.w_en   (write_out_en),
		.ascii  (ascii       ),
		.w_en_2d(w_en_2d     ),
		.wr_addr(wr_addr     ),
		.data   (data        )
	);

	VGA_port #(
		.H_ACTIVE     (1024),
		.H_SYNC       (136),
		.H_BACK_PORCH (160),
		.H_FRONT_PORCH(24),
		.V_ACTIVE     (768),
		.V_SYNC       (6),
		.V_BACK_PORCH (29),
		.V_FRONT_PORCH(3)
	) VGA_port (
		.clk    (clk_pll  ),
		.reset  (~reset   ),
		.start  (1'b0     ),
		.wren   (w_en_2d  ),
		.data_wr(data     ), 
		.wr_addr(wr_addr  ),
		.VR     (VR       ),
		.VG     (VG       ),
		.VB     (VB       ),
		.blank_N(blank_N  ),
		.sync_N (sync_N   ),
		.H_Sync (H_Sync   ),
		.V_Sync (V_Sync   )
	);

endmodule 