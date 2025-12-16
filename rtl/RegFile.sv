module RegFile (
    input clk,
    input wb_en,
    input [31:0] wb_data,
    input [4:0] rd_index,
    input [4:0] rs1_index,
    input [4:0] rs2_index,
    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out
);

reg [31:0] registers [0:31] ;

always @(*) begin
    rs1_data_out = registers[rs1_index] ;
    rs2_data_out = registers[rs2_index] ; 
end

always @(posedge clk) begin
    registers[0] <= 0;
    if ( wb_en == 1 ) begin    //if wb_en = 1 
        if (!rd_index[4] && !rd_index[3] && !rd_index[2] && !rd_index[1] && !rd_index[0]) begin  //if rd = x0
            registers[rd_index] <= 32'b0 ;
        end
        else begin
            registers[rd_index] <= wb_data ;
        end
    end
end
endmodule
