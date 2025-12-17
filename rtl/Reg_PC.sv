module Reg_PC (
    input clk,
    input rst,
    input [31:0] next_pc,
    input stall,            //new
    output reg [31:0] current_pc
);


always @(posedge clk or negedge rst) begin
    if(rst == 0)begin
        current_pc <= 0 ;
    end
    else begin 
        if(stall == 1) begin
            current_pc <= current_pc ; 
        end
        else begin 
            current_pc <= next_pc ; 
        end
    end
end
endmodule
