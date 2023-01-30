module imm_gen(
    data_i,
    data_o
);

input [31:0] data_i;
output [31:0] data_o;

assign data_o = (data_i[6:0]==7'b1100011)?{{21{data_i[31]}},data_i[7],data_i[30:25],data_i[11:8]}:
                ((data_i[6:0]==7'b0100011)?{{21{data_i[31]}},data_i[30:25],data_i[11:7]}:
                {{21{data_i[31]}},data_i[30:20]});

endmodule