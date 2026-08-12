`timescale 1ns / 1ps

module I2C_Controller(
        input sys_tick,         // 400kHz * 4  
        input reset_n,
        input [3:0] cmd,         
        input [6:0] i2c_seven_bit_addr,
        input [7:0] i2c_eight_bit_opcode,
        output i2c_sclk,
        inout i2c_sda,
        output i2c_transaction_complete
    );
    
    localparam NUMBER_OF_READ_BYTES = 2'b10;    // read 2 bytes
    localparam START_CMD = 3'b111;
    localparam WR_CMD = 3'b000;
    localparam RD_CMD = 3'b001;
    localparam STOP_CMD = 3'b011;
    localparam RESTART_CMD = 3'b100;
    
    typedef enum {idle, start1, start2, hold, restart, stop1, stop2, 
    addr1, addr2, addr3, addr4, addr_end, data1, data2, data3, data4, data_end} state_type;
    
    state_type stateNow, stateNext = idle;
    reg i2c_sclk_reg_now = 'd1; reg i2c_sclk_reg_next = 'd1;    // SCL reg
    reg i2c_sda_reg_now = 'd1; reg i2c_sda_reg_next = 'd1;      // SDA reg
    reg i2c_transaction_complete_now = 'd0; reg i2c_transaction_complete_next = 'd0;
    
    reg [4:0] dataBit_now = 'd0; reg [4:0] dataBit_next = 'd0;      // 0~7 data bits + ACK/NACK
    reg [4:0] dataByte_now = 'd0; reg [4:0] dataByte_next = 'd0;    // 0~NUMBER_OF_READ_BYTES-1
    reg read_write_reg = 'd0; reg read_write_reg_next = 'd0;        // this register keeps track of whether read/ write was selected during i2c addressing stage 0 for write, 1 for read.
    reg i2c_sda_out_en = 'd1; reg i2c_sda_out_en_next = 'd1;        // this register keeps track of whether i2c sda bus is input or output
    
    
    always_ff @ (posedge sys_tick)
    begin
        if (!reset_n)
            begin
                stateNow            <= idle;
                i2c_sclk_reg_now    <= 'd1;     // idle
                i2c_sda_reg_now     <= 'd1;     // idle
                dataBit_now         <= 'd0;     // idle
                dataByte_now        <= 'd0;     // idle
                read_write_reg      <= 'd0;
                i2c_sda_out_en      <= 'd1;
                i2c_transaction_complete_now <= 'd0;
            end
        else
            begin
                stateNow <= stateNext;
                i2c_sclk_reg_now    <= i2c_sclk_reg_next;
                i2c_sda_reg_now     <= i2c_sda_reg_next;
                dataBit_now         <= dataBit_next;
                dataByte_now        <= dataByte_next;
                read_write_reg      <= read_write_reg_next;
                i2c_sda_out_en      <= i2c_sda_out_en_next;
                i2c_transaction_complete_now <= i2c_transaction_complete_next;
            end
    end
    
    always_comb
    begin
        stateNext           = stateNow;
        i2c_sclk_reg_next   = i2c_sclk_reg_now;
        i2c_sda_reg_next    = i2c_sda_reg_now;
        dataBit_next        = dataBit_now;
        dataByte_next       = dataByte_now;
        read_write_reg_next = read_write_reg;
        i2c_sda_out_en_next = i2c_sda_out_en;
        i2c_transaction_complete_next = i2c_transaction_complete_now;
        case(stateNow)
            idle:
                begin
                    i2c_sda_reg_next    = 'd1;
                    i2c_sclk_reg_next   = 'd1;    // idle condition
                    i2c_transaction_complete_next = 'd0;
                    if(cmd == WR_CMD || cmd == RD_CMD)
                        begin
                            if(cmd==WR_CMD)
                                read_write_reg_next = 'd0;
                            else
                                read_write_reg_next = 'd1;  
                            stateNext   = start1; 
                        end
                    else
                        begin
                            stateNext   = idle;
                            read_write_reg_next = 'd0; 
                        end
                end
            start1:
                begin
                    stateNext = start2;   
                    i2c_sda_reg_next    = 'd0;      
                    i2c_sclk_reg_next   = 'd1;    // start1 condition
                end
            start2:
                begin
                    stateNext = addr1;         
                    i2c_sclk_reg_next   = 'd0;    // start2 condition
                    i2c_sda_reg_next    = 'd0;
                end
                
            hold:
                begin
                    i2c_sclk_reg_next   = 'd0;    // hold condition 
                    i2c_sda_reg_next    = 'd0;
                    if(cmd == WR_CMD || cmd == RD_CMD)
                        begin
                            stateNext = data1;    
                        end
                    else if(cmd == STOP_CMD)
                        begin
                            stateNext = stop1;         
                        end
                    else if(cmd == RESTART_CMD)
                        begin
                            stateNext = restart;         
                        end
                    else
                        begin
                            stateNext = hold;
                        end
                end

            addr1:
                begin
                    stateNext = addr2;
                    i2c_sclk_reg_next   = 'd0;                                  // SCLK 0
                    i2c_sda_reg_next   = i2c_seven_bit_addr[6-dataBit_next];  
                    // process the read_write bit (SDA)
                    if(dataBit_next == 7)
                        begin   
                            i2c_sda_reg_next = read_write_reg_next;
                        end
                    if(dataBit_next == 8)
                        begin
                            i2c_sda_out_en_next = 'd0;   
//                            i2c_sda_reg_next = 1'dZ;
                        end      
                end
            addr2:
                begin
                    stateNext = addr3;
                    i2c_sclk_reg_next   = 'd1;  // 1
                    i2c_sda_reg_next   = i2c_seven_bit_addr[6-dataBit_next];  
                    // process the read_write bit (SDA)
                    if(dataBit_next == 7)
                        begin   
                            i2c_sda_reg_next = read_write_reg_next;
                        end
                    if(dataBit_next == 8)
                        begin
                            i2c_sda_out_en_next = 'd0; 
//                            i2c_sda_reg_next = 1'dZ;
                        end   
                end
            addr3:
                begin
                    stateNext = addr4;
                    i2c_sclk_reg_next   = 'd1;  // 1    
                    i2c_sda_reg_next   = i2c_seven_bit_addr[6-dataBit_next];  
                    // process the read_write bit (SDA)
                    if(dataBit_next == 7)
                        begin   
                            i2c_sda_reg_next = read_write_reg_next;
                        end
                    if(dataBit_next == 8)
                        begin   
                            i2c_sda_out_en_next = 'd0; 
//                            i2c_sda_reg_next = 1'dZ;
                        end   
                end
            addr4:
                begin
                    i2c_sclk_reg_next   = 'd0;  // 0
                    i2c_sda_reg_next   = i2c_seven_bit_addr[6-dataBit_next];   
                    if(dataBit_next < 7)
                        begin 
                            stateNext = addr1; 
                            dataBit_next = dataBit_next + 'd1;
                        end
                    else if(dataBit_next == 7)
                        begin
                            stateNext = addr1; 
                            dataBit_next = dataBit_next + 'd1;
                            i2c_sda_reg_next   = read_write_reg_next;
                        end
                    else
                        begin 
                            stateNext = addr_end; 
                            i2c_sda_out_en_next = 'd0; 
//                            i2c_sda_reg_next = 1'dZ;
                        end   
                end
                
            addr_end:
                begin
                    i2c_sda_out_en_next      = 'd1; 
                    dataBit_next        = 'd0;
                    i2c_sda_reg_next    = 'd0;
                    i2c_sclk_reg_next   = 'd0;  // data_end condition 
                    stateNext           = data1;
                end
                
            data1:
                begin
                    stateNext = data2;
                    i2c_sclk_reg_next   = 'd0;                                  // SCLK 0
                    if(read_write_reg_next == 'd0)   // write
                        begin
                            i2c_sda_reg_next   = i2c_eight_bit_opcode[7-dataBit_next];  
                            // process the read_write bit (SDA)
                            if(dataBit_next == 8)
                                begin
                                    i2c_sda_out_en_next = 'd0;    
                                    //i2c_sda_reg_next = 1'dZ;
                                end
                        end
                    else                                                    // read
                        begin
                            if(dataBit_next == 8)                           // Ack bit
                                begin
                                    i2c_sda_out_en_next = 'd1; 
                                    if(dataByte_next == NUMBER_OF_READ_BYTES-1)                  // Reached Packet End 
                                        begin              
                                            i2c_sda_reg_next = 'd1;        // NACK
                                        end
                                    else
                                        begin
                                            i2c_sda_reg_next = 'd0;
                                        end
                                end
                            else
                                i2c_sda_out_en_next = 'd0; 
                        end    
                end
            data2:
                begin
                    stateNext = data3;
                    i2c_sclk_reg_next   = 'd1;  // 1
                    if(read_write_reg_next == 'd0)   // i2c write command
                        begin
                            i2c_sda_reg_next   = i2c_eight_bit_opcode[7-dataBit_next];   
                            if(dataBit_next == 8)
                                begin
                                    i2c_sda_out_en_next = 'd0;    
                                end
                        end
                    else
                        begin                        // i2c read command
                            if(dataBit_next == 8)                           
                                begin
                                    i2c_sda_out_en_next = 'd1; 
                                    if(dataByte_next == NUMBER_OF_READ_BYTES-1) // Reached Packet End 
                                        begin              
                                            i2c_sda_reg_next = 'd1;        
                                        end
                                    else
                                        begin
                                            i2c_sda_reg_next = 'd0;
                                        end
                                end
                            else
                                i2c_sda_out_en_next = 'd0; 
                        end 
                end
            data3:
                begin
                    stateNext = data4;
                    i2c_sclk_reg_next   = 'd1;  
                    if(read_write_reg_next == 'd0)   // i2c write command
                        begin
                            i2c_sda_reg_next    = i2c_eight_bit_opcode[7-dataBit_next];  
                            if(dataBit_next == 8)
                                begin   
                                    i2c_sda_out_en_next = 'd0;    
                                end 
                        end
                    else                            // i2c read command
                        begin
                            if(dataBit_next == 8)                           
                                begin
                                    i2c_sda_out_en_next = 'd1; 
                                    if(dataByte_next == NUMBER_OF_READ_BYTES-1)                  // Reached Packet End 
                                        begin              
                                            i2c_sda_reg_next = 'd1;        
                                        end
                                    else
                                        begin
                                            i2c_sda_reg_next = 'd0;
                                        end
                                end
                            else
                                i2c_sda_out_en_next = 'd0; 
                        end 
                end
            data4:
                begin
                    i2c_sclk_reg_next = 'd0;  // 0
                    if(read_write_reg_next == 'd0)   // write
                        begin
                            i2c_sda_reg_next    = i2c_eight_bit_opcode[7-dataBit_next];   
                            if(dataBit_next <8)
                                begin 
                                    stateNext = data1; 
                                    dataBit_next = dataBit_next + 'd1;
                                end
                            else
                                begin 
                                    stateNext = data_end; 
                                    i2c_sda_out_en_next = 'd0;    
                                    //i2c_sda_reg_next = 1'dZ;
                                end  
                        end
                    else
                        begin
                            if(dataBit_next <8)
                                begin
                                    i2c_sda_out_en_next = 'd0; 
                                    stateNext = data1; 
                                    dataBit_next = dataBit_next + 'd1;
                                end
                            else
                                begin
                                    i2c_sda_out_en_next = 'd1; 
                                    if(dataByte_now == NUMBER_OF_READ_BYTES - 1) begin      
                                        stateNext = data_end;
                                        i2c_sda_reg_next = 'd1;                             // Send NACK
                                    end else begin 
                                        stateNext = data1;
                                        dataByte_next = dataByte_now + 1'b1;
                                        dataBit_next  = 'd0;                                // <--- CRITICAL FIX: Reset bit counter for Byte 2
                                        i2c_sda_reg_next = 'd1;                             // Send ACK
                                    end
                                end  
                        end 
                end
            
            data_end:
                begin
                    dataBit_next        = 'd0;
                    dataByte_next        = 'd0;
                    i2c_sda_reg_next    = 'd0;
                    i2c_sclk_reg_next   = 'd0;  // data_end condition 
                    i2c_sda_out_en_next = 'd1;    
                    if(read_write_reg_next == 'd1)
                        begin
                            stateNext = stop1;  
                        end
                    else    // else is write, goto stop1 straight forward
                        stateNext = stop1;  
                end
                
            stop1:
                begin
                    i2c_sda_reg_next = 'd0;
                    i2c_sclk_reg_next = 'd1;    // stop1 condition
                    stateNext = stop2;
                end   
            stop2:
                begin
                    i2c_sda_reg_next = 'd1;
                    i2c_sclk_reg_next = 'd1;    // stop2 condition
                    i2c_transaction_complete_next = 'd1;    // we raise this flag high for 1 clock cycle. 
                    stateNext = idle;
                end
            default:
                begin
                    stateNext = idle;
                    i2c_sclk_reg_next = 'd1;
                    i2c_sda_reg_next = 'd1;
                end
        endcase
    end
    

    assign i2c_sclk = i2c_sclk_reg_now;
    assign i2c_sda = (i2c_sda_out_en == 'd1) ? i2c_sda_reg_now : 'dZ;
    assign i2c_transaction_complete = i2c_transaction_complete_now;

endmodule
