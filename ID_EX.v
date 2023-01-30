module ID_EX(
    clk_i,
    rst_i,
    flush_i,
    RegWrite,
    MemtoReg,
    MemRead,
    MemWrite,
    ALUOp,
    ALUSrc,
    rs1_data,
    rs2_data,
    imm,
    ins1,
    ins2,
    ins3,
    ins4,
    branch,
    PC,
    PC_branch,
    prev_predict,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    rs1_data_o,
    rs2_data_o,
    imm_o,
    ins1_o,
    ins2_o,
    ins3_o,
    ins4_o,
    branch_o,
    PC_o,
    PC_branch_o,
    prev_predict_o
);

input clk_i;
input rst_i;
input flush_i;
input RegWrite;
input MemtoReg;
input MemRead;
input MemWrite;
input [1:0] ALUOp;
input ALUSrc;
input [31:0] rs1_data;
input [31:0] rs2_data;
input [31:0] imm;
input [9:0] ins1;
input [4:0] ins2;
input [4:0] ins3;
input [4:0] ins4;
input branch;
input [31:0] PC;
input [31:0] PC_branch;
input prev_predict;
output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output [31:0] rs1_data_o;
output [31:0] rs2_data_o;
output [31:0] imm_o;
output [9:0] ins1_o;
output [4:0] ins2_o;
output [4:0] ins3_o; 
output [4:0] ins4_o; 
output branch_o;
output [31:0] PC_o;
output [31:0] PC_branch_o;
output prev_predict_o;

reg RegWrite_o, MemtoReg_o, MemRead_o,MemWrite_o, ALUSrc_o, branch_o,prev_predict_o;
reg [1:0] ALUOp_o;
reg [4:0] ins2_o, ins3_o, ins4_o;
reg [9:0] ins1_o;
reg [31:0] rs1_data_o,rs2_data_o,imm_o,PC_o,PC_branch_o;

always@(posedge clk_i or posedge rst_i)begin
    if(rst_i)begin
        RegWrite_o <= 1'b0;
        MemtoReg_o <= 1'b0;
        MemRead_o <= 1'b0;
        MemWrite_o <= 1'b0;
        ALUOp_o <= 2'b0;
        ALUSrc_o <= 1'b0;
        rs1_data_o <= 32'b0;
        rs2_data_o <= 32'b0;
        imm_o <= 32'b0;
        ins1_o <= 10'b0;
        ins2_o <= 5'b0;
        ins3_o <= 5'b0;
        ins4_o <= 5'b0; 
        branch_o <= 1'b0;
        PC_o <= 32'b0;
        PC_branch_o <= 32'b0; 
        prev_predict_o <= 1'b0;
    end
    else begin
        if(flush_i)begin
            RegWrite_o <= 1'b0;
            MemtoReg_o <= 1'b0;
            MemRead_o <= 1'b0;
            MemWrite_o <= 1'b0;
            ALUOp_o <= 2'b0;
            ALUSrc_o <= 1'b0;
            rs1_data_o <= 32'b0;
            rs2_data_o <= 32'b0;
            imm_o <= 32'b0;
            ins1_o <= 10'b0;
            ins2_o <= 5'b0;
            ins3_o <= 5'b0;
            ins4_o <= 5'b0; 
            branch_o <= 1'b0;
            PC_o <= 32'b0;
            PC_branch_o <= 32'b0; 
            prev_predict_o <= 1'b0;
        end
        else begin
            RegWrite_o <= RegWrite;
            MemtoReg_o <= MemtoReg;
            MemRead_o <= MemRead;
            MemWrite_o <= MemWrite;
            ALUOp_o <= ALUOp;
            ALUSrc_o <= ALUSrc;
            rs1_data_o <= rs1_data;
            rs2_data_o <= rs2_data;
            imm_o <= imm;
            ins1_o <= ins1;
            ins2_o <= ins2;
            ins3_o <= ins3;
            ins4_o <= ins4; 
            branch_o <= branch;
            PC_o <= PC;
            PC_branch_o <= PC_branch;
            prev_predict_o <= prev_predict;
        end       
    end
end 
endmodule
