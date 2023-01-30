module IF_ID (
    clk_i, rst_i, flush_i, stall_i, 
    inst_i, PC_i,
    inst_o, PC_o
);
input         clk_i, rst_i, flush_i, stall_i;
input  [31:0] inst_i, PC_i;
output reg [31:0] inst_o, PC_o;

always @(posedge clk_i or posedge rst_i)begin
    if(rst_i)begin
        inst_o <= 32'b0;
        PC_o <= 32'b0;
    end
    else begin
        if(flush_i)begin
            PC_o <= 32'b0;
            inst_o <= 32'b0;
        end
        else if(!stall_i)begin
            PC_o <= PC_i;
            inst_o <= inst_i;
        end
    end
end
endmodule
