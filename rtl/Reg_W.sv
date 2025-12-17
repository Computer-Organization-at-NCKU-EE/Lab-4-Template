module Reg_W (
    input clk,
    input rst,
    input [31:0] alu_out_in,
    input [31:0] ld_data_in, 
    input [31:0] pc_in,
    input bubble_in,    
    output reg [31:0] alu_out_out,
    output reg [31:0] ld_data_out,
    output reg [31:0] pc_out,
    output reg bubble_out
);
    // TODO: finish Write-back stage pipeline register design
    // ...
endmodule
