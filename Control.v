module Control(
    No_Op,
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    Branch_o
);

input No_Op;
input [6:0] Op_i;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;
output MemtoReg_o;
output MemRead_o;
output MemWrite_o;
output Branch_o;

reg [1:0] ALUOp_o;
reg ALUSrc_o,RegWrite_o,MemtoReg_o,MemRead_o,MemWrite_o,Branch_o;

always @(*)begin
    if(!No_Op)begin
        if(Op_i==7'b0110011)begin //and xor all add sub mul 
            ALUOp_o = 2'b10;
            ALUSrc_o = 1'b0;
            RegWrite_o = 1'b1;
            MemtoReg_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
        end 
        else if(Op_i==7'b0010011)begin //addi srai
            ALUOp_o = 2'b11;
            ALUSrc_o = 1'b1;
            RegWrite_o = 1'b1;
            MemtoReg_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
        end
        else if(Op_i==7'b0000011)begin //lw
            ALUOp_o = 2'b00;
            ALUSrc_o = 1'b1;
            RegWrite_o = 1'b1;
            MemtoReg_o = 1'b1;
            MemRead_o = 1'b1;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
        end
        else if(Op_i==7'b0100011)begin //sw
            ALUOp_o = 2'b00;
            ALUSrc_o = 1'b1;
            RegWrite_o = 1'b0;
            MemtoReg_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b1;
            Branch_o = 1'b0;    
        end
        else if(Op_i==7'b1100011)begin //beq
            ALUOp_o = 2'b01;
            ALUSrc_o = 1'b0;
            RegWrite_o = 1'b0;
            MemtoReg_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b1;
        end
        else begin
            ALUOp_o = 2'b00;
            ALUSrc_o = 1'b0;
            RegWrite_o = 1'b0;
            MemtoReg_o = 1'b0;
            MemRead_o = 1'b0;
            MemWrite_o = 1'b0;
            Branch_o = 1'b0;
        end
    end
    else begin
        ALUOp_o = 2'b00;
        ALUSrc_o = 1'b0;
        RegWrite_o = 1'b0;
        MemtoReg_o = 1'b0;
        MemRead_o = 1'b0;
        MemWrite_o = 1'b0;
        Branch_o = 1'b0;
    end
end

endmodule