module connect_riscv_vga (
	input  logic        clk         ,
	input  logic        reset       ,
	input  logic [31:0] address     ,
	input  logic [31:0] data_wr     ,
	input  logic        write_en    ,
	input  logic [31:0] regi_28     ,
	output logic        write_out_en,
	output logic [ 7:0] ascii
);

always_ff @(posedge clk) begin
	if(reset) begin
		write_out_en <= 0;
		ascii        <= 0;
	end
	else if(write_en && (address == 7756)) begin
		if(regi_28[1:0] == 0) begin
			write_out_en <= 1;
			ascii        <= data_wr[7:0];
		end
		else if(regi_28[1:0] == 1) begin
			write_out_en <= 1;
			ascii        <= data_wr[15:8];
		end
		else if(regi_28[1:0] == 2) begin
			write_out_en <= 1;
			ascii        <= data_wr[23:16];
		end
		else if(regi_28[1:0] == 3) begin
			write_out_en <= 1;
			ascii        <= data_wr[31:24];
		end
	end
	else begin
		write_out_en <= 0;
		ascii        <= 0;
	end
end

endmodule