module CoreTop (
    input clk,
    input rst,
    output [31:0] mem_addr,
    input [31:0] mem_r_data,
    output [3:0] mem_w_en,
    output [31:0] mem_w_data,
    output [31:0] wb_pc,
    output valid_inst
);

wire [31:0] a1 ;
wire [31:0] a2 ; 
wire [31:0] a3 ;
wire [31:0] a4 ; 
wire [4:0] a5 ; 
wire [2:0] a6 ; 
wire [4:0] a7 ; 
wire [4:0] a8 ; 
wire [4:0] a9 ; 
wire a10 ; 
wire [31:0] a11 ;
wire [31:0] a12 ; 
wire [31:0] a13 ; 
wire [31:0] a14 ; 
wire [31:0] a15 ; 
wire [31:0] a16 ; 
wire [31:0] a17 ;
wire [31:0] a18 ; 
wire [31:0] a19 ; 
wire [31:0] a20 ; 
wire [31:0] a21 ; 
wire [31:0] a22 ; 
wire [31:0] a23 ; 
wire [31:0] a24 ; 
wire [31:0] a25 ;
wire [31:0] a26 ; 
wire [31:0] a27 ; 
wire [31:0] a28 ; 
wire [31:0] a29 ; 
wire [31:0] a30 ;
wire [31:0] a31 ; 
wire [31:0] a32 ;
wire [31:0] a33 ;
wire [31:0] a34 ; 
wire [31:0] a35 ; 
wire [31:0] a36 ;
wire [31:0] a37 ;
wire b1 ;           //stall
wire b2 ;           // next_pc_sel
wire [3:0] b3 ;           // F_im_w_en
wire b4 ;            // D_rs1_data_sel
wire b5 ;            // D_rs2_data_sel 
wire [1:0] b6 ;           // E_rs1_data_sel
wire [1:0] b7 ;             // E_rs2_data_sel
wire b8 ;           // E_jb_op1_sel
wire b9 ;           // E_alu_op1_sel
wire b10 ;          // E_alu_op2_sel
wire [4:0] b11 ;        // E_op
wire [2:0] b12 ;        // E_f3
wire b13 ;              // E_f7
wire [3:0] b14 ;        // M_dm_w_en
wire b15 ;              // W_wb_en
wire [4:0] b16 ;        // W_rd_index
wire [2:0] b17 ;        // W_f3
wire b18 ;              //W_wb_data_sel

wire bubble_reg_D,bubble_reg_E,bubble_reg_M,bubble_reg_W;//bubble

// the im part
ROM im (.clk(clk), .addr(a1[12:0]), .r_data(a2));

// the dm part
assign mem_addr = a27;
assign mem_w_en = b14;
assign mem_w_data = a28;
assign a29 = mem_r_data;

// valid inst
assign valid_inst = ~bubble_reg_W;

RegFile regfile ( .clk(clk) , .wb_en(b15) , .wb_data(a33) , .rd_index(b16) , 
                .rs1_index(a8) , .rs2_index(a9) , .rs1_data_out(a12) , .rs2_data_out(a13) );

Decoder decoder ( .inst(a4) , .dc_out_opcode(a5) , .dc_out_func3(a6) , .dc_out_func7(a10) , 
                .dc_out_rs1_index(a8) , .dc_out_rs2_index(a9) , .dc_out_rd_index(a7) );

Imm_Ext imm_ext ( .inst(a4) , .imm_ext_out(a11) );

ALU alu ( .opcode(b11) , .func3(b12) , .func7(b13) , .operand1(a20) , .operand2(a21) , .alu_out(a25) );

JB_Unit jb_unit ( .operand1(a22) , .operand2(a19) , .jb_out(a26) );

LD_Filter ld_filter( .func3(b17) , .ld_data(a31) , .ld_data_f(a32) );


MUX2 next_pc_sel ( .in0(a26) , .in1(a35) , .sel(b2) , .out(a34) );

MUX2 E_jb_op1_sel ( .in0(a23) , .in1(a16) , .sel(b8) , .out(a22) );

MUX2 E_alu_op1_sel ( .in0(a23) , .in1(a16) , .sel(b9) , .out(a20) );

MUX2 E_alu_op2_sel ( .in0(a24) , .in1(a19) , .sel(b10) , .out(a21) );

MUX2 W_wb_data_sel ( .in0(a30) , .in1(a32) , .sel(b18) , .out(a33) );

MUX2 D_rs1_data_sel ( .in0(a12) , .in1(a33) , .sel(b4) , .out(a14) ) ;

MUX2 D_rs2_data_sel ( .in0(a13) , .in1(a33) , .sel(b5) , .out(a15) ) ;

MUX3 E_rs1_data_sel ( .in0(a33) , .in1(a27) , .in2(a17) , .sel(b6) , .out(a23) ) ;

MUX3 E_rs2_data_sel ( .in0(a33) , .in1(a27) , .in2(a18) , .sel(b7) , .out(a24) ) ;

Adder adder ( .pc(a1) , .pc_plus_4(a35) );

Reg_PC reg_pc ( .clk(clk) , .rst(rst) , .next_pc(a34) , .stall(b1) , .current_pc(a1) );

Reg_D reg_d ( .clk(clk) , .rst(rst) , .pc_in(a1) , .inst_in(a2) , .stall(b1) , .jb(b2) , .pc_out(a3) , .inst_out(a4) ,.bubble_out(bubble_reg_D) );

Reg_E  reg_e( .clk(clk) , .rst(rst) , .pc_in(a3) , .rs1_data_in(a14) , .rs2_data_in(a15) , .sext_imm_in(a11) ,
                .stall(b1) , .jb(b2) , .pc_out(a16) , .rs1_data_out(a17) , .rs2_data_out(a18) , .sext_imm_out(a19) ,
                .bubble_in(bubble_reg_D), .bubble_out(bubble_reg_E));

Reg_M  reg_m( .clk(clk), .rst(rst), .alu_out_in(a25) , .rs2_data_in(a24) , .alu_out_out(a27) , .rs2_data_out(a28),
              .bubble_in(bubble_reg_E), .bubble_out(bubble_reg_M), .pc_in(a16), .pc_out(a36));

Reg_W reg_w ( .clk(clk) , .rst(rst) , .alu_out_in(a27) , .ld_data_in(a29) , .alu_out_out(a30) , .ld_data_out(a31),
              .bubble_in(bubble_reg_M),.bubble_out(bubble_reg_W), .pc_in(a36), .pc_out(a37));
assign wb_pc = a37;

Controller controller (.clk(clk) , .rst(rst) , .D_op(a5) , .D_f3(a6) , .D_f7(a10) , .D_rd(a7) , .D_rs1(a8) , .D_rs2(a9) ,
                         .alu_out(a25[0]) , .stall(b1) , .next_pc_sel(b2) , .F_im_w_en(b3) , .D_rs1_data_sel(b4),
                         .D_rs2_data_sel(b5) , .E_rs1_data_sel(b6) , .E_rs2_data_sel(b7), .E_jb_op1_sel(b8) ,
                         .E_alu_op1_sel(b9) , .E_alu_op2_sel(b10) , .E_op_1(b11) , .E_f3_1(b12) , .E_f7_1(b13) ,
                         .M_dm_w_en(b14) , .W_wb_en(b15) , .W_rd_index(b16) , .W_f3_1(b17) , .W_wb_data_sel(b18) );
endmodule
