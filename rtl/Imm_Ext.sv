module Imm_Ext (
    input [31:0] inst,
    output reg [31:0] imm_ext_out
);

always @(*) begin
     if ( inst[6:2] == 5'b00000 )begin // I type -> opcode[6:2] = 00000 
         imm_ext_out = {{20{inst[31]}}, inst[31: 20]} ;
     end
     else if ( inst[6:2] == 5'b00100 )begin // I type -> opcode[6:2] = 00100 
          if( inst[14:12] == 3'b001 ) begin
               imm_ext_out = {27'b0, inst[24:20]} ;
          end
          else if( inst[14:12] == 3'b101 ) begin
               imm_ext_out = {27'b0, inst[24:20]} ;
          end
          else begin
               imm_ext_out = {{20{inst[31]}}, inst[31: 20]} ;
          end 
     end 
     else if (inst[6:2] == 5'b11001 )begin // I type -> opcode[6:2] = 11001 
         imm_ext_out = {{20{inst[31]}}, inst[31: 20]} ;
     end 
     else if (inst[6:2] == 5'b01000 )begin // S type -> opcode[6:2] = 01000 
         imm_ext_out = {{20{inst[31]}}, inst[31: 25], inst[11: 7]} ;
     end 
     else if (inst[6:2] == 5'b11000 )begin // B type -> opcode[6:2] = 11000 
         imm_ext_out = {{20{inst[31]}}, inst[7] , inst[30: 25], inst[11: 8], 1'b0} ;
     end 
     else if (inst[6:2] == 5'b01101 )begin // U type -> opcode[6:2] = 01101 
         imm_ext_out = {inst[31: 12], 12'b0} ;
     end 
     else if (inst[6:2] == 5'b00101 )begin // U type -> opcode[6:2] = 00101 
         imm_ext_out = {inst[31: 12], 12'b0} ;
     end 
     else if (inst[6:2] == 5'b11011 )begin // J type -> opcode[6:2] = 11011 
         imm_ext_out = {{12{inst[31]}}, inst[19: 12] , inst[20], inst[30: 21], 1'b0} ;
     end 
end
endmodule
