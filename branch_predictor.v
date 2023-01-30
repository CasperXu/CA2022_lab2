module branch_predictor
(
    clk_i, 
    rst_i,
    update_i,
	result_i,
	predict_o,
);

input clk_i, rst_i, update_i, result_i;
output predict_o;

// reg predict_o;
reg [1:0] state; //00 strongly taken, 01 weakly taken, 10, weakly non taken, 11 strongly non taken

assign predict_o = !state[1];

always@(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin
        state <= 2'b00;
    end  
    else begin
        if(update_i)begin
            if(result_i)begin //taken
                if(state!=2'b00)begin
                    state <= state-1;
                end         
            end
            else begin //non taken
                if(state!=2'b11)begin
                    state <= state+1;
                end
            end
        end 
    end
end
endmodule
