module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

input [9:0] funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;

reg [2:0] ALUCtrl;

assign ALUCtrl_o = ALUCtrl;

always @(*)begin
    if(ALUOp_i==2'b10)begin
        if(funct_i==10'b0000000000) //add
            ALUCtrl = 3'b000;
        else if(funct_i==10'b0100000000) //sub
            ALUCtrl = 3'b001;
        else if(funct_i==10'b0000001000) //mul
            ALUCtrl = 3'b010;
        else if(funct_i==10'b0000000001) //sll
            ALUCtrl = 3'b110;
        else if(funct_i==10'b0000000100) //xor
            ALUCtrl = 3'b101;
        else if(funct_i==10'b0000000111) //and
            ALUCtrl = 3'b100;
    end
    else if(ALUOp_i==2'b11)begin
        if(funct_i[2:0]==3'b000) //addi
            ALUCtrl = 3'b000;
        else if(funct_i[2:0]==3'b101) //srai
            ALUCtrl = 3'b111;
    end
    else if(ALUOp_i==2'b00)begin //ld and sd
        ALUCtrl = 3'b000;
    end
    else if(ALUOp_i==2'b01)begin //beq
        ALUCtrl = 3'b001;
    end
end
endmodule