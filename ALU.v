module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);

input signed [31:0] data1_i;
input signed [31:0] data2_i;
input [2:0] ALUCtrl_i;
output signed [31:0] data_o;
output Zero_o;

reg signed [31:0] data;
reg Zero_o;

assign data_o = data;


always @(*)begin
    if(ALUCtrl_i==3'b000)begin
        data = data1_i + data2_i;
    end
    else if(ALUCtrl_i==3'b001)begin
        data = data1_i - data2_i;

    end
    else if(ALUCtrl_i==3'b010)begin
        data = data1_i*data2_i;
    end
    else if(ALUCtrl_i==3'b100)begin
        data = data1_i&data2_i;
    end
    else if(ALUCtrl_i==3'b101)begin
        data = data1_i^data2_i;
    end
    else if(ALUCtrl_i==3'b110)begin
        data = data1_i<<data2_i;
    end
    else if(ALUCtrl_i==3'b111)begin
        data = data1_i>>data2_i[4:0];
    end
    if(data1_i==data2_i)begin
        Zero_o = 1'b1;
    end
    else begin
        Zero_o = 1'b0;
    end
end 

endmodule
