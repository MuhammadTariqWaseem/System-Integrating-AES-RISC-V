`timescale 1ns/1ps

module tb_system ();

	logic clk        = 0;
	logic raw_reset  = 1;
	logic [6:0] HEX0    ;
	logic [6:0] HEX1    ;
	logic [6:0] HEX2    ;
	logic [6:0] HEX3    ;
	logic [6:0] HEX4    ;
	logic [6:0] HEX5    ;
	logic clk_pll       ;
	logic [7:0] VR      ;
	logic [7:0] VG      ;
	logic [7:0] VB      ;
	logic blank_N       ;
	logic sync_N        ;
	logic H_Sync        ;
	logic V_Sync        ;

	system system (
		.clk      (clk      ),
		.raw_reset(raw_reset),
		.HEX0     (HEX0     ),
		.HEX1     (HEX1     ),
		.HEX2     (HEX2     ),
		.HEX3     (HEX3     ),
		.HEX4     (HEX4     ),
		.HEX5     (HEX5     ),
		.clk_pll  (clk_pll  ),
		.VR       (VR       ),
		.VG       (VG       ),
		.VB       (VB       ),
		.blank_N  (blank_N  ),
		.sync_N   (sync_N   ),
		.H_Sync   (H_Sync   ),
		.V_Sync   (V_Sync   )
	);

  always #10000 clk <= ~clk;

	initial begin
		repeat (20) @(posedge clk);
		raw_reset = 0;
		repeat (1000) @(posedge clk);
		raw_reset = 1;
		repeat (200000) @(posedge clk);
	  $stop;
	end

endmodule