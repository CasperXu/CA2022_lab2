module EX_MEM(
    clk_i,
    rst_i,
    RegWrite,
    MemtoReg,
    MemRead,
    MemWrite,
    ALU_result,
    ins,
    rs2_data,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALU_result_o,
    rs2_data_o,
    ins_o
);

input clk_i;
input rst_i;
input RegWrite;
input MemtoReg;
input MemRead;
input MemWrite;
input [31:0] ALU_result;
input [31:0] rs2_data;
input [4:0] ins;
output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output [31:0] ALU_result_o;
output [31:0] rs2_data_o;
output [4:0] ins_o;

reg RegWrite_o, MemtoReg_o, MemRead_o,MemWrite_o;
reg [4:0] ins_o;
reg [31:0] ALU_result_o, rs2_data_o;

always@(posedge clk_i or posedge rst_i)begin
    if(rst_i)begin
        RegWrite_o <= 1'b0;
        MemtoReg_o <= 1'b0;
        MemRead_o <= 1'b0;
        MemWrite_o <= 1'b0;
        ALU_result_o <= 32'b0;
        rs2_data_o <= 32'b0;
        ins_o <= 5'b0;            
    end
    else begin
        RegWrite_o <= RegWrite;
        MemtoReg_o <= MemtoReg;
        MemRead_o <= MemRead;
        MemWrite_o <= MemWrite;
        ALU_result_o <= ALU_result;
        rs2_data_o <= rs2_data;
        ins_o <= ins;        
    end
end 
endmodule