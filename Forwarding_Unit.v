module Forwarding_Unit(
    Ex_rs1,
    Ex_rs2,
    Mem_rd,
    Wb_rd,
    Mem_RegWrite,
    Wb_RegWrite,
    Forward_a,
    Forward_b
);

input [4:0] Ex_rs1;
input [4:0] Ex_rs2;
input [4:0] Mem_rd;
input [4:0] Wb_rd;
input Mem_RegWrite;
input Wb_RegWrite;
output [1:0] Forward_a;
output [1:0] Forward_b;

// reg Forward_a, Forward_b;

assign Forward_a = (Mem_RegWrite&&Mem_rd==Ex_rs1)?2'b10:
                    ((Wb_RegWrite&&Wb_rd==Ex_rs1)?2'b01:2'b00);
assign Forward_b = (Mem_RegWrite&&Mem_rd==Ex_rs2)?2'b10:
                    ((Wb_RegWrite&&Wb_rd==Ex_rs2)?2'b01:2'b00);
// always@(*)begin
//     if(Mem_RegWrite&&Mem_rd==Ex_rs1)
//         Forward_a = 2'b10;
//     else if(Wb_RegWrite&&Wb_rd==Ex_rs1)
//         Forward_a = 2'b01;
//     else
//         Forward_a = 2'b00;
//     if(Mem_RegWrite&&Mem_rd==Ex_rs2)
//         Forward_b = 2'b10;
//     else if(Wb_RegWrite&&Wb_rd==Ex_rs2)
//         Forward_b = 2'b01;
//     else
//         Forward_b = 2'b00;
// end

endmodule