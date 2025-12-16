module ALU (
    input [4:0] opcode,
    input [2:0] func3,
    input func7,
    input [31:0] operand1,
    input [31:0] operand2,
    output reg [31:0] alu_out
);

always @(*) begin

    if (opcode == 5'b01100) begin                       // if opcode = 01100  -> register to register
        if (func3 == 3'b000) begin                      // func3 = 000
            if(func7 == 1) begin                        // func7 = 1 -> sub
                 alu_out = operand1 - operand2 ;
            end
            else begin                                  //func7 = 0 -> add
                 alu_out = operand1 + operand2 ;
            end
        end
        else if (func3 == 3'b001) begin                      //func3 = 001 -> sll
             alu_out = operand1 << operand2[4:0] ;
        end
        else if (func3 == 3'b010) begin                     //func3 = 010 -> slt
            if ( $signed(operand1) < $signed(operand2) ) begin
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end       
        end
        else if (func3 == 3'b011) begin                       //func3 = 011 -> sltu
            if ( operand1 < operand2 ) begin
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end    
        end
        else if (func3 == 3'b100) begin                      //func3 = 100 -> xor
             alu_out = operand1 ^ operand2 ;
        end
        else if (func3 == 3'b101) begin                          //func3 = 101 
            if(func7 == 1) begin                                                //func7 = 1 -> sra
                 alu_out = operand1 >>> operand2[4:0] ;
            end
            else begin                                                          //func7 = 0 -> srl
                 alu_out = operand1 >> operand2[4:0] ;
            end
        end
        else if (func3 == 3'b110) begin                      //func3 = 110 -> or
             alu_out = operand1 | operand2 ;
        end    
        else if (func3 == 3'b111) begin                      //func3 = 111 -> and
             alu_out = operand1 & operand2 ;
        end            
    end
    else if (opcode == 5'b00100) begin                                              //opcode = 00100 -> register to immediate
        if (func3 == 3'b000) begin                                                  //func3 = 000 ->addi
             alu_out = operand1 + operand2 ;
        end
        else if (func3 == 3'b001) begin                                             //func3 = 001 -> slli
             alu_out = operand1 << operand2 ;
        end
        else if (func3 == 3'b010) begin                                             //func3 = 010 -> slti
            if ( $signed(operand1) < $signed(operand2) ) begin
                    alu_out = 1 ;
                end
                else begin
                    alu_out = 0 ;
                end  
        end
        else if (func3 == 3'b011) begin                                             //func3 = 011 -> sltiu
            if ( operand1 < operand2 ) begin
                    alu_out = 1 ;
                end
                else begin
                    alu_out = 0 ;
                end  
        end
        else if (func3 == 3'b100) begin                                             //func3 = 100 -> xori
             alu_out = operand1 ^ operand2 ;
        end        
        else if (func3 == 3'b101) begin                                                   //func3 = 101 
               if( func7 == 1'b1 ) begin                                                  //func7 = 1 -> srai
                    alu_out = ( { {31{operand1[31]}}, 1'b0 } << (~operand2[4:0]) ) | ( operand1 >> operand2[4:0] ) ;
                    
               end
               else begin                                                                 //func7 = 0 -> srli
                    alu_out = operand1 >> operand2 ;
               end
        end        
        else if (func3 == 3'b110) begin                                              //func3 = 110 -> ori
             alu_out = operand1 | operand2 ;
        end
        else if (func3 == 3'b111) begin                                              //func3 = 111 -> andi
             alu_out = operand1 & operand2 ;
        end    
    end
    else if (opcode == 5'b01101) begin                                              //opcode = 01101 -> lui
         alu_out = {operand2[31:12], 12'b0} ;
    end
    else if (opcode == 5'b00101) begin                                              //opcode = 00101 -> auipc
         alu_out =  operand1 + {operand2[31:12], 12'b0} ;
    end
    else if (opcode == 5'b00000) begin                                              //opcode = 00000 -> load                                                          
         alu_out = operand1 + operand2 ;
    end
    else if (opcode == 5'b01000) begin                                              //opcode = 01000 -> store                                                          
         alu_out = operand1 + operand2 ;
    end
    else if (opcode == 5'b11011) begin                                              //opcode = 11011 -> jal                                                        
         alu_out = operand1 + 4 ;
    end
    else if (opcode == 5'b11001) begin                                              //opcode = 11001 -> jalr                                                        
         alu_out = operand1 + 4 ;
    end
    else if (opcode == 5'b11000) begin                                              //opcode = 11000 -> branch
        if (func3 == 3'b000) begin                                                  //func3 = 000 -> beq
            if ( operand1 == operand2 ) begin                                       // if op1==op2 -> alu_out <= 1
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end  
        end
        else if (func3 == 3'b001) begin                                             //func3 = 001 -> bne
            if ( operand1 != operand2 ) begin                                       // if op1!=op2 -> alu_out <= 1
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end  
        end 
        else if (func3 == 3'b100) begin                                             //func3 = 100 -> blt
            if ( $signed(operand1) < $signed(operand2) ) begin                          // if op1<op2 -> alu_out <= 1
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end       
        end
        else if (func3 == 3'b101) begin                                             //func3 = 101 -> bge     
            if ( $signed(operand1) >= $signed(operand2) ) begin                         // if op1>=op2 -> alu_out <= 1
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end
        end
        else if (func3 == 3'b110) begin                                             //func3 = 110 -> bltu
            if ( operand1 < operand2 ) begin                                        // if op1<op2 -> alu_out <= 1  
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end
        end
        else if (func3 == 3'b111) begin                                             //func3 = 111 -> bgeu
            if ( operand1 >= operand2 ) begin                                       // if op1>=op2 -> alu_out <= 1  
                 alu_out = 1 ;
            end
            else begin
                 alu_out = 0 ;
            end   
        end
    end
end
endmodule
