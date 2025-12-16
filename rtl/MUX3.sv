module MUX3 (
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [1:0]sel,
    output reg [31:0] out
);

always @(*) begin

    if( sel == 2 ) begin
        out = in0 ;
    end
    else if ( sel == 1 ) begin 
        out = in1 ; 
    end
    else if (sel == 0) begin
        out = in2 ;
    end

end

endmodule