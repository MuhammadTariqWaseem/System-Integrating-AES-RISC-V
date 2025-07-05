module processor_6_stage (
	input  logic        clk        ,
	input  logic        reset      ,
	input  logic [31:0] aes_read   ,
	output logic [31:0] ALUResultX ,
	output logic [31:0] RD2X       ,
	output logic        MemWriteX  ,
	output logic [31:0] register_28,
	output logic [31:0] register_29,
	output logic [31:0] register_30,
	output logic [31:0] register_31
);
   
  logic [31:0] WriteDataW_p;

	logic [31:0] PCPlus4  ;
	logic [31:0] PCTargetE;
	logic [31:0] PCNext   ;
	logic [31:0] PC       ;
	logic [31:0] Instr    ;
	logic [31:0] InstrF   ;
	logic [31:0] InstrZ   ;
	logic        PCSrc    ;

	logic [31:0] aes_read_W ;
	logic [31:0] aes_read_W1;

	logic [31:0] InstrD    ;
	logic [31:0] InstrL    ;
	logic [31:0] InstrK    ;
	logic [31:0] PCD       ;
	logic [31:0] PCPlus4D  ;
	logic [31:0] WriteDataW;
	logic [31:0] RD1       ;
	logic [31:0] RD2       ;
	logic [31:0] ImmExt    ;
	logic [ 4:0] WriteAddW ;
	logic [ 2:0] ALUControl;
	logic [ 1:0] ResultSrc ;
	logic [ 1:0] ImmSrc    ;
	logic        Branch    ;
	logic        MemWrite  ;
	logic        ALUSrc    ;
	logic        RegWrite  ;
	logic        Jump      ;
	logic        RegWriteW ;
	logic        FF        ;
	logic        FD        ;
	logic        FE        ;

	logic [31:0] RD1E          ;
	logic [31:0] RD2E          ;
	logic [31:0] PCE           ;
	logic [31:0] ImmExtE       ;
	logic [31:0] PCPlus4E      ;
	logic [31:0] SrcE          ;
	logic [31:0] A32           ;
	logic [31:0] B32           ;
	logic [ 4:0] WriteAddE     ;
	logic [ 4:0] rs1           ;
	logic [ 4:0] rs2           ;
	logic [ 4:0] IS1           ;
	logic [ 4:0] IS2           ;
	logic [ 2:0] ALUControlE   ;
	logic [ 1:0] ResultSrcE    ;
	logic [ 1:0] ResultSrcX    ;
	logic [ 1:0] forword_path_A;
	logic [ 1:0] forword_path_B;
	logic        RegWriteE     ;
	logic        MemWriteE     ;
	logic        RegWriteE1    ;
	logic        MemWriteE1    ;
	logic        JumpE         ;
	logic        JumpE1        ;
	logic        BranchE       ;
	logic        BranchE1      ;
	logic        ALUSrcE       ;

	logic [31:0] SrcX       ;
	logic [31:0] A32X       ;
	logic [31:0] PCPlus4X   ;
	logic [31:0] C          ;
	logic [31:0] C1         ;
	logic [31:0] PCX        ;
	logic [31:0] ImmExtX    ;
	logic [ 4:0] WriteAddX  ;
	logic [ 2:0] ALUControlX;
	logic [ 2:0] funct3X    ;
	logic        RegWriteX  ;
	logic        JumpX      ;
	logic        BranchX    ;
	logic        Zero       ;

	logic [31:0] ALUResultM;
	logic [31:0] RD2M      ;
	logic [31:0] PCPlus4M  ;
	logic [31:0] ReadDataM ;
	logic [ 4:0] WriteAddM ;
	logic [ 1:0] ResultSrcM;
	logic        RegWriteM ;
	logic        MemWriteM ;
	logic        FF_d      ;
	logic        s         ;
	logic        STF       ;
	logic        STD       ;
	logic        STE       ;
	logic        STF1      ;

	logic [31:0] ReadDataW ;
	logic [31:0] ALUResultW;
	logic [31:0] PCPlus4W  ;
	logic [ 1:0] ResultSrcW;

	logic [31:0] WriteDataU;
	logic [ 4:0] WriteAddU ;
	logic        RegWriteU ;

	logic [63:0] E[15:0];
	logic [63:0] F[15:0];

	assign PCNext = (reset)? 32'h0 : ((PCSrc)? (PCTargetE) : (PCPlus4));

	flip_flop #(.WIDTH(32)) flipflop_0 (
		.clk  (clk   ),
		.reset(reset ),
		.ST   (STF   ),
		.d    (PCNext),
		.q    (PC    )
	);

	flip_flop #(.WIDTH(33)) flipflop_STF (
		.clk  (clk          ),
		.reset(reset        ),
		.ST   (1'b0         ),
		.d    ({STF,Instr}  ),
		.q    ({STF1,InstrZ})
	);

	assign Instr = (STF1)? InstrZ : InstrF;               

	adder adder_0 (
		.in1(PC     ),
		.in2(32'd4  ),
		.out(PCPlus4)
	);

	flip_flop #(.WIDTH(107)) flipflop_1 (
		.clk  (clk                                            ),
		.reset(reset                                          ),
		.ST   (STD                                            ),
		.d    ({Instr,PC,PCPlus4,Instr[19:15],Instr[24:20],FF}),
		.q    ({InstrL,PCD,PCPlus4D,IS1,IS2,FF_d}             )
	);

  assign InstrD = (~FF_d)? (32'h13) : (InstrL);
	
	controller controller (
		.op        (InstrD[6:0]),
		.funct3    (InstrD[14:12]),
		.funct7b5  (InstrD[30]),
		.SS2       (FD        ),
		.funct7b1  (InstrD[25]),
		.MemWrite  (MemWrite  ),
		.Branch    (Branch    ),
		.ALUSrc    (ALUSrc    ),
		.RegWrite  (RegWrite  ),
		.Jump      (Jump      ),
		.ALUControl(ALUControl),
		.ResultSrc (ResultSrc ),
		.ImmSrc    (ImmSrc    )
	);

	register_up register_up (
		.clk         (clk          ),
		.reset       (reset        ),
		.write_enable(RegWriteW    ),
		.read_addr1  (InstrD[19:15]),
		.read_addr2  (InstrD[24:20]),
		.write_addr  (WriteAddW    ),
		.write_data  (WriteDataW   ),
		.read_data1  (RD1          ),
		.read_data2  (RD2          ),
		.register_28 (register_28  ),
		.register_29 (register_29  ),
		.register_30 (register_30  ),
		.register_31 (register_31  )
	);

	extend extend (
		.instr (InstrD[31:7]),
		.immsrc(ImmSrc      ),
		.immext(ImmExt      )
	);

	hazardUnit_up hazardUnit_up (
		.WriteAddX (WriteAddX    ),
		.WriteAddM (WriteAddM    ),
		.rs1E      (rs1          ),
		.rs2E      (rs2          ),
		.ResultSrcX(ResultSrcX[0]),
		.ResultSrcM(ResultSrcM[0]),
		.RegWriteX (RegWriteX    ),
		.PCSrc     (PCSrc        ),
		.FF        (FF           ),
		.FD        (FD           ),
		.FE        (FE           ),
		.STF       (STF          ),
		.STD       (STD          ),
		.STE       (STE          )
	);

	flip_flop #(.WIDTH(217)) flipflop_2 (
		.clk  (clk  ),
		.reset(reset),
		.ST   (STE  ),
		.d    ({RegWrite,ResultSrc,MemWrite,Jump,Branch,ALUControl,ALUSrc,RD1,RD2,PCD,
			      InstrD[11:7],ImmExt,PCPlus4D,InstrD[19:15], InstrD[24:20],InstrD}),
		.q    ({RegWriteE,ResultSrcE,MemWriteE,JumpE,BranchE,ALUControlE,ALUSrcE,RD1E,
			      RD2E,PCE,WriteAddE,ImmExtE,PCPlus4E,rs1,rs2,InstrK})
	);
  
  assign A32  = (forword_path_A[1])? ((forword_path_A[0])? (WriteDataU) : (WriteDataW) ) : ((forword_path_A[0])? (ALUResultM) : (RD1E) );
  assign B32  = (forword_path_B[1])? ((forword_path_B[0])? (WriteDataU) : (WriteDataW) ) : ((forword_path_B[0])? (ALUResultM) : (RD2E) );
	assign SrcE = (ALUSrcE)? (ImmExtE) : (B32);

	forwardingunit_up forwardingunit_up (
		.rdM           (WriteAddM     ),
		.rdW           (WriteAddW     ),
		.rdU           (WriteAddU     ),
		.rs1           (rs1           ),
		.rs2           (rs2           ),
		.RegWriteM     (RegWriteM     ),
		.RegWriteW     (RegWriteW     ),
		.RegWriteU     (RegWriteU     ),
		.forword_path_A(forword_path_A),
		.forword_path_B(forword_path_B)
	);

	assign {BranchE1,JumpE1,RegWriteE1,MemWriteE1} = (FE)? ({BranchE,JumpE,RegWriteE,MemWriteE}) : (4'b0);

  flip_flop #(.WIDTH(209)) flipflop_3 (
		.clk  (clk  ),
		.reset(reset),
		.ST   (1'b0  ),
		.d    ({RegWriteE1,ResultSrcE,MemWriteE1,A32,SrcE,B32,WriteAddE,PCPlus4E,
			      ALUControlE,InstrK[14:12],BranchE1,JumpE1,PCE,ImmExtE}),
		.q    ({RegWriteX,ResultSrcX,MemWriteX,A32X,SrcX,RD2X,WriteAddX,PCPlus4X,
			      ALUControlX,funct3X,BranchX,JumpX,PCX,ImmExtX})
	);

	ALU ALU (
		.A        (A32X       ),
		.B        (SrcX       ),
		.ALUOp    (ALUControlX),
		.funct3   (funct3X    ),
		.ALUResult(ALUResultX ),
		.zero     (Zero       )
	);

	adder adder_1 (
		.in1(PCX      ),
		.in2(ImmExtX  ),
		.out(PCTargetE)
	);

	always@(*) begin
		if((BranchX === 1'bx)|(Zero === 1'bx)|(JumpX === 1'bx))
			PCSrc = 0;
		else
			PCSrc = (BranchX & Zero) | JumpX ;
	end

  flip_flop #(.WIDTH(106)) flipflop_4 (
		.clk  (clk  ),
		.reset(reset),
		.ST   (1'b0  ),
		.d    ({RegWriteX,ResultSrcX,MemWriteX,ALUResultX,RD2X,WriteAddX,PCPlus4X,funct3X[0]}),
		.q    ({RegWriteM,ResultSrcM,MemWriteM,ALUResultM,RD2M,WriteAddM,PCPlus4M,s})
	);

	memory memory_0 (
		.aclr     (1'b0                                                       ),
		.address_a({PCNext[14:2],2'b00}                                       ),
		.address_b({ALUResultX[14:2],2'b00}                                   ),
		.clock    (clk                                                        ),
		.data_a   (8'b0                                                       ),
		.data_b   (RD2X[7:0]                                                  ),
		.wren_a   (1'b0                                                       ),
		.wren_b   (MemWriteX && (ALUResultX != 77) && (ALUResultX[31:2] != 14)),
		.q_a      (InstrF[7:0]                                                ),
		.q_b      (ReadDataM[7:0]                                             )
	);
	memory memory_1 (
		.aclr     (1'b0                                                       ),
		.address_a({PCNext[14:2],2'b01}                                       ),
		.address_b({ALUResultX[14:2],2'b01}                                   ),
		.clock    (clk                                                        ),
		.data_a   (8'b0                                                       ),
		.data_b   (RD2X[15:8]                                                 ),
		.wren_a   (1'b0                                                       ),
		.wren_b   (MemWriteX && (ALUResultX != 77) && (ALUResultX[31:2] != 14)),
		.q_a      (InstrF[15:8]                                               ),
		.q_b      (ReadDataM[15:8]                                            )
	);
	memory memory_2 (
		.aclr     (1'b0                                                       ),
		.address_a({PCNext[14:2],2'b10}                                       ),
		.address_b({ALUResultX[14:2],2'b10}                                   ),
		.clock    (clk                                                        ),
		.data_a   (8'b0                                                       ),
		.data_b   (RD2X[23:16]                                                ),
		.wren_a   (1'b0                                                       ),
		.wren_b   (MemWriteX && (ALUResultX != 77) && (ALUResultX[31:2] != 14)),
		.q_a      (InstrF[23:16]                                              ),
		.q_b      (ReadDataM[23:16]                                           )
	);
	memory memory_3 (
		.aclr     (1'b0                                                       ),
		.address_a({PCNext[14:2],2'b11}                                       ),
		.address_b({ALUResultX[14:2],2'b11}                                   ),
		.clock    (clk                                                        ),
		.data_a   (8'b0                                                       ),
		.data_b   (RD2X[31:24]                                                ),
		.wren_a   (1'b0                                                       ),
		.wren_b   (MemWriteX && (ALUResultX != 77) && (ALUResultX[31:2] != 14)),
		.q_a      (InstrF[31:24]                                              ),
		.q_b      (ReadDataM[31:24]                                           )
	);

  flip_flop #(.WIDTH(168)) flipflop_5 (
		.clk  (clk  ),
		.reset(reset),
		.ST   (1'b0  ),
		.d    ({RegWriteM,ResultSrcM,ALUResultM,ReadDataM,WriteAddM,PCPlus4M,aes_read,aes_read_W}),
		.q    ({RegWriteW,ResultSrcW,ALUResultW,ReadDataW,WriteAddW,PCPlus4W,aes_read_W,aes_read_W1})
	);

  assign WriteDataW_p = (ResultSrcW[1])? ((ResultSrcW[0])? (32'b0) : (PCPlus4W) ) : ((ResultSrcW[0])? (ReadDataW) : (ALUResultW));
  assign WriteDataW   = ((ResultSrcW == 1) && (ALUResultW[31:2] == 14))? aes_read_W1 : WriteDataW_p;

  flip_flop #(.WIDTH(38)) flipflop_U (
		.clk  (clk  ),
		.reset(reset),
		.ST   (1'b0  ),
		.d    ({RegWriteW,WriteAddW,WriteDataW}),
		.q    ({RegWriteU,WriteAddU,WriteDataU})
	);

endmodule
