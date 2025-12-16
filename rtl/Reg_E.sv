module Reg_E (
    input clk,
    input rst,
    input [31:0] pc_in,
    input [31:0] rs1_data_in,
    input [31:0] rs2_data_in,
    input [31:0] sext_imm_in,
    input stall,
    input jb, 
    input bubble_in,  
    output reg [31:0] pc_out,
    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out,
    output reg [31:0] sext_imm_out,
    output reg bubble_out
);
    // TODO: finish Reg_E (execute) design
endmodule
