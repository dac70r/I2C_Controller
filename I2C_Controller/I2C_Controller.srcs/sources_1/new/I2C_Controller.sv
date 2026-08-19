/*

 * This finite state machine is what we use to build the workflow of the i2c module. 
    
    In the BH1750 Ambient Light Sensor's case, we first write address, write the opecode (resolution), then read 2 bytes. Therefore, there are 
    only 2 commands, write, followed by read.
    
*/

module i2c_controller(
        input       sys_tick,         // 400kHz * 4  
        input       reset_n,
        output      [2:0] cmd,         
        input       i2c_transaction_complete
    );
    
    
    typedef enum {write_addr, write_opecode, read_addr, read_byte1, read_byte2} command_type;
    
    command_type command_now, command_next = write_addr;
    logic [2:0] cmd_now, cmd_next = 3'b000;
    
    
    always_ff @ (posedge sys_tick)
        begin
            if(!reset_n) begin
                    command_now <= write_addr;
                    cmd_now     <= 3'b000; 
                end
            else begin
                    command_now <= command_next;
                    cmd_now     <= cmd_next; 
                end
        end
        
    always_comb
        begin
            case(command_now)
                write_addr:
                    begin
                        cmd_next = 3'b000;
                        if(i2c_transaction_complete)
                            command_next = read_addr;
                    end
//                write_opecode:
//                    begin
//                        if(i2c_transaction_complete) begin
//                            cmd_next = 3'b001;
//                            command_next = read_addr;
//                        end
//                    end
                read_addr:
                    begin
                        cmd_next = 3'b001;                          // after init, will forever read data byte unless reset
//                        if(i2c_transaction_complete) begin
//                            command_next = write_addr;
//                        end
                    end
//                read_byte1:
//                    begin
//                        if(i2c_transaction_complete) begin
//                            command_next = read_byte2;
//                        end
//                    end
//                read_byte2:
//                    begin
//                        if(i2c_transaction_complete) begin
//                            command_next = read_addr;
//                        end
//                    end
                default:
                    begin
                        cmd_next = 3'b000;
                        command_next = write_addr;
                    end
            endcase
        end
        
        assign cmd = cmd_now;

endmodule
