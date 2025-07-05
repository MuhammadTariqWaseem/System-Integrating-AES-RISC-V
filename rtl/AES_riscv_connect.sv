module AES_riscv_connect (
	input  logic        clk_processor,
	input  logic        clk_aes      ,
	input  logic        reset        ,
	input  logic        aes_encrypt  ,
	input  logic        aes_decrypt  ,
	input  logic        write_en     ,
	input  logic [16:0] data_addr    ,
	input  logic [15:0] key_addr     ,
	input  logic [15:0] write_addr   ,
	input  logic [31:0] write_data   ,
	input  logic [ 9:0] no_of_words  ,
	output logic [31:0] read_data
);

	logic [ 13:0] aes_data_addr ;
	logic [ 13:0] aes_writ_addr ;
	logic [ 13:0] aes_key_addr  ;

	logic [13:0]       write_addr_AES;
	logic [13:0]       write_addr_KEY;
	logic [25:0][13:0] write_addr_OUT;

	logic [127:0] data_in       ;
	logic [127:0] key           ;
	logic         valid_in_en   ;
	logic         valid_in_de   ;

	logic [ 31:0] read_data_0   ;
	logic [ 31:0] read_data_1   ;
	logic [ 31:0] read_data_2   ;

	logic [127:0] data_out_en   ;
	logic [127:0] data_out_de   ;
	logic         valid_out     ;

	logic         aes_encrypt_1d;
	logic         aes_encrypt_2d;
	logic         aes_encrypt_3d;

	logic         aes_decrypt_1d;
	logic         aes_decrypt_2d;
	logic         aes_decrypt_3d;

	logic [ 9:0]  count_input   ;
	logic [ 9:0]  count_done    ;

	assign read_data = (no_of_words[1])? read_data_2 : ((no_of_words[0])? read_data_1 : read_data_0);

// Recieve Signals from PRocessor in clockprocessor 
	always_ff @(posedge clk_processor) begin
		if(reset) begin
			aes_encrypt_1d <= 0;
			aes_decrypt_1d <= 0;
		end
		else begin
			aes_encrypt_1d <= aes_encrypt;
			aes_decrypt_1d <= aes_decrypt;
		end
  end

	always_ff @(posedge clk_aes) begin
		if(reset)
			count_done <= 0;
		else if(aes_encrypt_1d | aes_decrypt_1d)
			count_done <= 1;
		else
			count_done <= count_done + 1;
  end


	always_ff @(posedge clk_processor) begin
		if(reset)
			count_input <= 0;
		else if(aes_encrypt | aes_decrypt)
			count_input <= no_of_words;
  end

	always_ff @(posedge clk_processor) begin
		if(reset) begin
			aes_data_addr  <= 0;
			aes_writ_addr  <= 0;
			aes_key_addr   <= 0;
		end
		else if(aes_encrypt | aes_decrypt) begin
			aes_data_addr  <= data_addr [15:2];
			aes_writ_addr  <= write_addr[15:2];
			aes_key_addr   <= key_addr  [15:2];
		end
	end

	always_ff @(posedge clk_aes) begin
		if(reset) begin
			aes_encrypt_2d <= 0;
			aes_encrypt_3d <= 0;
			aes_decrypt_2d <= 0;
			aes_decrypt_3d <= 0;
		end 
		else begin
			aes_encrypt_2d <= aes_encrypt_1d;
			aes_encrypt_3d <= aes_encrypt_2d;
			aes_decrypt_2d <= aes_decrypt_1d;
			aes_decrypt_3d <= aes_decrypt_2d;
		end
	end

	always_ff @(posedge clk_aes) begin
		if(reset) begin
			write_addr_OUT <= 0;
		end
		else if(aes_encrypt_1d | aes_decrypt_1d) begin
			write_addr_OUT[0]    <= aes_writ_addr       ;
			write_addr_OUT[25:1] <= write_addr_OUT[24:0];
		end
		else if((count_done < count_input) && (count_done != 0)) begin
			write_addr_OUT[0]    <= write_addr_OUT[0] + 1;
			write_addr_OUT[25:1] <= write_addr_OUT[24:0];
		end
		else begin
			write_addr_OUT[25:1] <= write_addr_OUT[24:0];
			write_addr_OUT[0]    <= 0;
		end
	end

	always_ff @(posedge clk_aes) begin
		if(reset) begin
			write_addr_AES <= 0;
			write_addr_KEY <= 0;
		end
		else if(aes_encrypt_1d | aes_decrypt_1d) begin
			write_addr_AES <= aes_data_addr;
			write_addr_KEY <= aes_key_addr;
		end
		else if((count_done < count_input) && (count_done != 0)) begin
			write_addr_AES <= write_addr_AES + 1;
			write_addr_KEY <= write_addr_KEY + 1;
		end
	end

	always_ff @(posedge clk_aes) begin
		if(reset)
			valid_in_en <= 0;
		else if(aes_encrypt_2d)
			valid_in_en <= 1;
		else if((count_done <= count_input) && (count_done != 0) && valid_in_en)
			valid_in_en <= 1;
		else begin
			valid_in_en <= 0;
		end
	end

	always_ff @(posedge clk_aes) begin
		if(reset)
			valid_in_de <= 0;
		else if(aes_decrypt_2d)
			valid_in_de <= 1;
		else if((count_done <= count_input) && (count_done != 0) && valid_in_de)
			valid_in_de <= 1;
		else begin
			valid_in_de <= 0;
		end
	end

	AES_DATA_mem AES_KEY_mem (
		.address_a(data_addr[15:0]          ),
		.address_b(write_addr_KEY           ),
		.clock_a  (clk_processor            ),
		.clock_b  (clk_aes                  ),
		.data_a   (write_data               ),
		.data_b   (128'b0                   ),
		.wren_a   (write_en && data_addr[16]),
		.wren_b   (1'b0                     ),
		.q_a      (read_data_1              ),
		.q_b      (key                      )
	);

	AES_DATA_mem AES_DATA_mem (
		.address_a(data_addr[15:0]           ),
		.address_b(write_addr_AES            ),
		.clock_a  (clk_processor             ),
		.clock_b  (clk_aes                   ),
		.data_a   (write_data                ),
		.data_b   (128'b0                    ),
		.wren_a   (write_en && ~data_addr[16]),
		.wren_b   (1'b0                      ),
		.q_a      (read_data_2               ),
		.q_b      (data_in                   )
	);

	AES_DATA_mem AES_OUT_mem (
		.address_a(data_addr[15:0]                                        ),
		.address_b((valid_out_de)? write_addr_OUT[23] : write_addr_OUT[13]),
		.clock_a  (clk_processor                                          ),
		.clock_b  (clk_aes                                                ),
		.data_a   (32'b0                                                  ),
		.data_b   ((valid_out_de)? data_out_de : data_out_en              ),
		.wren_a   (1'b0                                                   ),
		.wren_b   (valid_out_en | valid_out_de                            ),
		.q_a      (read_data_0                                            ),
		.q_b      (                                                       )
	);

	aes_encrypter aes_encrypter (
		.clk      (clk_aes     ),
		.rst      (reset       ),
		.data_in  (data_in     ),
		.key      (key         ),
		.valid_in (valid_in_en ),
		.data_out (data_out_en ),
		.valid_out(valid_out_en)
	);

	aes_decrypter aes_decrypter (
		.clk      (clk_aes     ),
		.rst      (reset       ),
		.data_in  (data_in     ),
		.key      (key         ),
		.valid_in (valid_in_de ),
		.data_out (data_out_de ),
		.valid_out(valid_out_de)
	);

endmodule
