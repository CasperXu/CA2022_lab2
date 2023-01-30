module CPU
(
    clk_i, 
    rst_i
);

// Ports
input               clk_i;
input               rst_i;

wire[31:0] pc, new_pc, pc_branch, pc_mux, pc_mux2, pc_res_ex;
wire[31:0] instruction;
wire[31:0] extended_imm;
wire[31:0] rs1_data, rs2_data, rd_data;
wire[31:0] mux_4a_res,mux_4b_res,mux_4b_imm_res;
wire[2:0] aluctrl_o;
wire[31:0] wb_writedata;
wire[31:0] alu_res;
wire[31:0] read_data_mem;
wire zero_o;

//control
wire RegWrite;
wire MemtoReg;
wire MemRead;
wire MemWrite;
wire[1:0] alu_op;
wire alu_src;
wire branch;

// IF/ID
wire[31:0] ins_id;
wire[31:0] pc_id;

// ID/EX
wire RegWrite_ex;
wire MemtoReg_ex;
wire MemRead_ex;
wire MemWrite_ex;
wire[1:0] alu_op_ex;
wire alu_src_ex;
wire[31:0] rs1_data_ex, rs2_data_ex,extended_imm_ex;
wire[9:0] alu_control_i_ex;
wire[4:0] rs1_ex, rs2_ex, rd_ex;
wire[31:0] pc_ex, pc_branch_ex;
wire prev_predict_ex;

// EX/MEM
wire RegWrite_mem;
wire MemtoReg_mem;
wire MemRead_mem;
wire MemWrite_mem;
wire[31:0] alures_mem;
wire[31:0] write_data_mem;
wire[4:0] rd_mem;

// MEM/WB
wire RegWrite_wb;
wire MemtoRed_wb;
wire[31:0] alures_wb;
wire[31:0] read_data_wb;
wire[4:0] rd_wb;

// Hazard Detection Unit
wire PCWrite;
wire Stall;
wire No_Op;

//Forwarding Unit
wire[1:0] Forward_a;
wire[1:0] Forward_b;


//branch preditor
wire update_i, predict_o;

assign predict_wrong_o = (update_i&&(prev_predict_ex!=zero_o));
assign flush_if_id = (branch&&predict_o)||predict_wrong_o;
assign pc_select = branch&&predict_o;
assign pc_res_ex = (prev_predict_ex==1'b1&&zero_o==1'b0)?pc_ex:pc_branch_ex;

Control Control(
    .No_Op      (No_Op),
    .Op_i       (ins_id[6:0]),
    .ALUOp_o    (alu_op),
    .ALUSrc_o   (alu_src),
    .RegWrite_o (RegWrite),
    .MemtoReg_o   (MemtoReg),
    .MemRead_o    (MemRead),
    .MemWrite_o   (MemWrite),
    .Branch_o     (branch)
);


Adder Add_PC(
    .data1_i   (pc),
    .data2_i   (32'h4),
    .data_o     (new_pc)
);

Adder Add_PC_branch(
    .data1_i (extended_imm<<1),
    .data2_i (pc_id),
    .data_o (pc_branch)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .PCWrite_i  (PCWrite),
    .pc_i       (pc_mux2),
    .pc_o       (pc)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (pc), 
    .instr_o    (instruction)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (ins_id[19:15]),
    .RS2addr_i   (ins_id[24:20]),
    .RDaddr_i   (rd_wb), 
    .RDdata_i   (wb_writedata),
    .RegWrite_i (RegWrite_wb), 
    .RS1data_o   (rs1_data), 
    .RS2data_o   (rs2_data) 
);

MUX32 MUX_ALUSrc(
    .data1_i    (mux_4b_res),
    .data2_i    (extended_imm_ex),
    .select_i   (alu_src_ex),
    .data_o     (mux_4b_imm_res)
);


MUX32 MUX_PC(
    .data1_i (new_pc),
    .data2_i (pc_branch),
    .select_i (pc_select),
    .data_o (pc_mux)
);


MUX32 MUX_PC2(
    .data1_i (pc_mux),
    .data2_i (pc_res_ex),
    .select_i (predict_wrong_o),
    .data_o (pc_mux2)
);


MUX32 MUX_WB(
    .data1_i (alures_wb),
    .data2_i (read_data_wb),
    .select_i (MemtoRed_wb),
    .data_o (wb_writedata)
);


MUX32_4 MUX_rs1(
    .data1_i (rs1_data_ex),
    .data2_i (wb_writedata),
    .data3_i (alures_mem),
    .data4_i (32'b0),
    .select_i (Forward_a),
    .data_o (mux_4a_res)
);


MUX32_4 MUX_rs2(
    .data1_i (rs2_data_ex),
    .data2_i (wb_writedata),
    .data3_i (alures_mem),
    .data4_i (32'b0),
    .select_i (Forward_b),
    .data_o (mux_4b_res)
);


imm_gen imm_gen(
    .data_i     (ins_id),
    .data_o     (extended_imm)
);



ALU ALU(
    .data1_i    (mux_4a_res),
    .data2_i    (mux_4b_imm_res),
    .ALUCtrl_i  (aluctrl_o),
    .data_o     (alu_res),
    .Zero_o (zero_o)
); 



ALU_Control ALU_Control(
    .funct_i    (alu_control_i_ex),
    .ALUOp_i    (alu_op_ex),
    .ALUCtrl_o  (aluctrl_o)
);



IF_ID IF_ID(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .stall_i (Stall),
    .flush_i (flush_if_id),
    .PC_i (pc),
    .inst_i (instruction),
    .PC_o (pc_id),
    .inst_o (ins_id)
); 



ID_EX ID_EX(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .flush_i (predict_wrong_o),
    .RegWrite (RegWrite),
    .MemtoReg (MemtoReg),
    .MemRead (MemRead),
    .MemWrite (MemWrite),
    .ALUOp (alu_op),
    .ALUSrc (alu_src),
    .rs1_data (rs1_data),
    .rs2_data (rs2_data),
    .imm (extended_imm),
    .ins1 ({ins_id[31:25],ins_id[14:12]}),
    .ins2 (ins_id[19:15]),
    .ins3 (ins_id[24:20]),
    .ins4 (ins_id[11:7]),
    .branch (branch),
    .PC (pc_id+32'h4),
    .PC_branch (pc_branch),
    .prev_predict (predict_o),
    .RegWrite_o (RegWrite_ex),
    .MemtoReg_o (MemtoReg_ex),
    .MemRead_o (MemRead_ex),
    .MemWrite_o (MemWrite_ex),
    .ALUOp_o (alu_op_ex),
    .ALUSrc_o (alu_src_ex),
    .rs1_data_o (rs1_data_ex),
    .rs2_data_o (rs2_data_ex),
    .imm_o (extended_imm_ex),
    .ins1_o (alu_control_i_ex),
    .ins2_o (rs1_ex),
    .ins3_o (rs2_ex),
    .ins4_o (rd_ex),
    .branch_o (update_i),
    .PC_o (pc_ex),
    .PC_branch_o (pc_branch_ex),
    .prev_predict_o (prev_predict_ex)
);


EX_MEM EX_MEM(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RegWrite (RegWrite_ex),
    .MemtoReg (MemtoReg_ex),
    .MemRead (MemRead_ex),
    .MemWrite (MemWrite_ex),
    .ALU_result (alu_res),
    .ins (rd_ex),
    .rs2_data (mux_4b_res),
    .RegWrite_o (RegWrite_mem),
    .MemtoReg_o (MemtoReg_mem),
    .MemRead_o (MemRead_mem),
    .MemWrite_o (MemWrite_mem),
    .ALU_result_o (alures_mem),
    .rs2_data_o (write_data_mem),
    .ins_o (rd_mem)
);



MEM_WB MEM_WB(
    .clk_i (clk_i),
    .rst_i (rst_i),
    .RegWrite (RegWrite_mem),
    .MemtoReg (MemtoReg_mem),
    .ALU_result (alures_mem),
    .read_data (read_data_mem),
    .ins (rd_mem),
    .RegWrite_o (RegWrite_wb),
    .MemtoReg_o (MemtoRed_wb),
    .ALU_result_o (alures_wb),
    .read_data_o (read_data_wb),
    .ins_o (rd_wb)
);



Hazard_Detection Hazard_Detection(
    .rs1 (ins_id[19:15]), 
    .rs2 (ins_id[24:20]),
    .rd (rd_ex),
    .MemRead (MemRead_ex),
    .PCWrite (PCWrite),
    .Stall_o (Stall),
    .No_Op (No_Op)
);



Forwarding_Unit Forwarding_Unit(
    .Ex_rs1 (rs1_ex),
    .Ex_rs2 (rs2_ex),
    .Mem_rd (rd_mem),
    .Wb_rd (rd_wb),
    .Mem_RegWrite (RegWrite_mem),
    .Wb_RegWrite (RegWrite_wb),
    .Forward_a (Forward_a),
    .Forward_b (Forward_b)
);

Data_Memory Data_Memory(
    .clk_i (clk_i), 
    .addr_i (alures_mem), 
    .MemRead_i (MemRead_mem),
    .MemWrite_i (MemWrite_mem),
    .data_i (write_data_mem),
    .data_o (read_data_mem)
);

branch_predictor branch_predictor(
    .clk_i (clk_i), 
    .rst_i (rst_i),
    .update_i (update_i),
	.result_i (zero_o),
	.predict_o (predict_o)
);

endmodule

