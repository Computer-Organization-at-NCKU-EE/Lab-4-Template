module Reg_D (
    input clk,
    input rst,
    input [31:0] pc_in,
    input [31:0] inst_in,
    input stall,
    input jb,   
    output reg [31:0] pc_out,
    output reg [31:0] inst_out,
    output reg bubble_out
);
    // TODO: finish Decode-stage Pipeline Register design
    // ...
endmodule
