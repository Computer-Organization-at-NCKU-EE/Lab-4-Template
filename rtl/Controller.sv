module Controller(
    input clk,
    input rst, 
    input [4:0] D_op,
    input [2:0] D_f3,
    input D_f7,
    input [4:0] D_rd,
    input [4:0] D_rs1,
    input [4:0] D_rs2,
    input alu_out,
    output reg stall,
    output reg next_pc_sel,
    output reg [3:0] F_im_w_en,
    output reg D_rs1_data_sel,
    output reg D_rs2_data_sel,
    output reg [1:0] E_rs1_data_sel,
    output reg [1:0] E_rs2_data_sel,
    output reg E_jb_op1_sel,
    output reg E_alu_op1_sel,
    output reg E_alu_op2_sel,
    output reg [4:0] E_op_1,
    output reg [2:0] E_f3_1,
    output reg E_f7_1,
    output reg [3:0] M_dm_w_en,
    output reg W_wb_en,
    output reg [4:0] W_rd_index,
    output reg [2:0] W_f3_1,
    output reg W_wb_data_sel
);
    // controller-internal pipeline registers
    reg [4:0] E_op ;
    reg [2:0] E_f3 ;
    reg E_f7 ;
    reg [4:0] E_rd ;
    reg [4:0] E_rs1 ;
    reg [4:0] E_rs2 ;
    reg [4:0] M_op ; 
    reg [2:0] M_f3 ; 
    reg [4:0] M_rd ; 
    reg [4:0] W_op ; 
    reg [2:0] W_f3 ;
    reg [4:0] W_rd ;

    // TODO: finish Controller design
    // ...
endmodule





