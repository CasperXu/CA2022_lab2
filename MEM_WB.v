module MEM_WB(
    clk_i,
    rst_i,
    RegWrite,
    MemtoReg,
    ALU_result,
    read_data,
    ins,
    RegWrite_o,
    MemtoReg_o,
    ALU_result_o,
    read_data_o,
    ins_o
);

input clk_i;
input rst_i;
input RegWrite;
input MemtoReg;
input [31:0] ALU_result;
input [31:0] read_data;
input [4:0] ins;
output RegWrite_o;
output MemtoReg_o;
output [31:0] ALU_result_o;
output [31:0] read_data_o;
output [4:0] ins_o;

reg RegWrite_o, MemtoReg_o;
reg [4:0] ins_o;
reg [31:0] ALU_result_o, read_data_o;

always@(posedge clk_i or posedge rst_i)begin
    if(rst_i)begin
        RegWrite_o <= 1'b0;
        MemtoReg_o <= 1'b0;
        ALU_result_o <= 32'b0;
        read_data_o <= 32'b0;
        ins_o <= 5'b0;                
    end
    else begin
        RegWrite_o <= RegWrite;
        MemtoReg_o <= MemtoReg;
        ALU_result_o <= ALU_result;
        read_data_o <= read_data;
        ins_o <= ins;        
    end
end 
endmodule
