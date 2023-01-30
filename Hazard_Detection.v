module Hazard_Detection(
    rs1,
    rs2,
    rd,
    MemRead,
    PCWrite,
    Stall_o,
    No_Op
);

input [4:0] rs1;
input [4:0] rs2;
input [4:0] rd;
input MemRead;
output PCWrite;
output Stall_o;
output No_Op;

assign PCWrite = (MemRead&&(rs1==rd||rs2==rd))?1'b0:1'b1;
assign Stall_o = (MemRead&&(rs1==rd||rs2==rd))?1'b1:1'b0;
assign No_Op = (MemRead&&(rs1==rd||rs2==rd))?1'b1:1'b0; 

endmodule