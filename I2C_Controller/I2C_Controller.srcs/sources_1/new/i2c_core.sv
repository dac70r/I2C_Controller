/*
    
        This module is the i2c core. As of now it writes ADDR and OPCODE followed by READ ADDR and 2 Data Bytes. 

*/
module i2c_core # (parameter 
                readBytes = 2,
                readBits = 16)(
        input       sys_tick,         // 400kHz * 4  
        input       reset_n,
        input [2:0] cmd,         
        output      i2c_sclk,
        inout       i2c_sda,
        output reg [readBits-1: 0] i2c_sda_read_bit, 
        output      i2c_transaction_complete
    );
    
    `include "i2c_peripheral.vh"
    
    localparam i2c_seven_bit_addr = ADDR_BH1750;                // 7-bit i2c address (0x23)        
    localparam i2c_eight_bit_opcode = CMD_CONT_LOW_RES;       // 8-bit opecode (config data) 
    
    localparam DELAY_COUNT_BETWEEN_READ = 19'd288_000;    // 180ms / (1/400kHz)
    localparam START_CMD                = 3'b111;
    localparam WR_CMD                   = 3'b000;
    localparam RD_CMD                   = 3'b001;
    localparam STOP_CMD                 = 3'b011;
    localparam RESTART_CMD              = 3'b100;
    
    typedef enum {idle, start1, start2, hold, restart, stop1, stop2, 
                    addr1, addr2, addr3, addr4, addr_end, data1, data2, 
                    data3, data4, ack_nack, data_end, delay1, delay2} state_type;
    
    state_type stateNow, stateNext = idle;
    reg i2c_sclk_reg_now = 'd1; reg i2c_sclk_reg_next = 'd1;    // SCL reg
    reg i2c_sda_reg_now = 'd1; reg i2c_sda_reg_next = 'd1;      // SDA reg
    reg i2c_transaction_complete_now = 'd0; reg i2c_transaction_complete_next = 'd0;
    
    reg [18:0] delayCountNow = 'd0;  reg [18:0] delayCountNext = 'd0;
    reg [4:0] dataBit_now = 'd0;    reg [4:0] dataBit_next = 'd0;         // 0~7 data bits + ACK/NACK
    reg [4:0] dataByte_now = 'd0;   reg [4:0] dataByte_next = 'd0;        // 0~NUMBER_OF_READ_BYTES-1
    reg read_write_reg = 'd0;       reg read_write_reg_next = 'd0;        // this register keeps track of whether read/ write was selected during i2c addressing stage 0 for write, 1 for read.
    reg i2c_sda_out_en = 'd1;       reg i2c_sda_out_en_next = 'd1;        // this register keeps track of whether i2c sda bus is input or output
    
    reg [7:0] i2c_data_storage [readBytes-1:0];                           // Read Bytes are seperated into chunks of 8, there are (readBytes) chunks
    //reg [readBits-1:0] i2c_data_read_bit_register = '0;                   // Concatenate 
    
    always_ff @ (posedge sys_tick)              // sys_tick is 
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
                delayCountNow       <= 'd0;
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
                delayCountNow       <= delayCountNext;
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
        delayCountNext      = delayCountNow;
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
                            stateNext = data1;
                                
                    else if(cmd == STOP_CMD)
                            stateNext = stop1;
                                     
                    else if(cmd == RESTART_CMD)
                            stateNext = restart;         
                    else
                            stateNext = hold;
                end

            addr1:
                begin
                    stateNext           = addr2;
                    i2c_sclk_reg_next   = 'd0;                                  // SCLK 0
                    i2c_sda_reg_next   = i2c_seven_bit_addr[6-dataBit_next];  
                    if(dataBit_next == 7)
                            i2c_sda_reg_next = read_write_reg_next;             // 7th BIT = READ/ WRITE BYTE
                    if(dataBit_next == 8)                                       
                            i2c_sda_out_en_next = 'd0;                          // 8th BIT = ACK (By I2C SLAVE)     
                end
            addr2:
                begin
                    stateNext           = addr3;
                    i2c_sclk_reg_next   = 'd1;                                  // SCLK 1         
                end
            addr3:
                begin
                    stateNext           = addr4;
                    i2c_sclk_reg_next   = 'd1;                                  // SCLK 1      
                end
            addr4:
                begin
                    i2c_sclk_reg_next   = 'd0;                                  // SCLK 0 
                    if(dataBit_next <= 7)
                        begin
                            stateNext = addr1; 
                            dataBit_next = dataBit_next + 'd1;
                            if(dataBit_next == 7)
                                i2c_sda_reg_next   = read_write_reg_next;
                        end
                    else
                        begin 
                            stateNext = addr_end; 
                            i2c_sda_out_en_next = 'd0; 
                        end   
                end
                
            addr_end:
                begin
                    i2c_sda_out_en_next         = 'd1;  
                    dataBit_next                = 'd0;  // reset dataBit
                    i2c_sda_reg_next            = 'd0;  
                    i2c_sclk_reg_next           = 'd0;  // data_end condition 
                    stateNext                   = data1;
                end
                
            data1:
                begin
                    stateNext = data2;
                    i2c_sclk_reg_next   = 'd0;                                      // SCLK 0
                    if(read_write_reg_next == 'd0)                                  // I2C WRITE
                        begin
                            i2c_sda_reg_next   = i2c_eight_bit_opcode[7-dataBit_next];  
                            if(dataBit_next == 8)
                                i2c_sda_out_en_next = 'd0;                  // SDA = 'dZ (I2C Slave Acks)   
                        end
                    else                                                    // read
                        begin
                            if(dataBit_next == 8)                           // Ack bit process
                                begin
                                    i2c_sda_out_en_next = 'd1;              // SDA = i2c_sda_reg_now 
                                    if(dataByte_next == readBytes-1)        // Reached the last byte in a read transaction?  If yes NACK (1) if no ACK (0)    
                                            i2c_sda_reg_next = 'd1;         // NACK (1)
                                    else
                                            i2c_sda_reg_next = 'd0;         // ACK (0)
                                end
                            else
                                i2c_sda_out_en_next = 'd0;                  // SDA = 'dZ                     
                        end    
                end
            data2:
                begin
                    stateNext = data3;
                    i2c_sclk_reg_next   = 'd1;                                      // SCLK 1
                    if(read_write_reg_next == 'd1)        
                        i2c_data_storage[dataByte_next][7-dataBit_next] = i2c_sda;
     
                end
            data3:
                begin
                    stateNext = data4;
                    i2c_sclk_reg_next   = 'd1;                                       // SCLK 1           
                end
            data4:
                begin
                    i2c_sclk_reg_next = 'd0;                                         // SCLK 0
                    if(read_write_reg_next == 'd0)                                   // I2C WRITE
                        begin
                            if(dataBit_next <8)
                                begin 
                                    stateNext = data1; 
                                    dataBit_next = dataBit_next + 'd1;
                                end
                            else
                                begin 
                                    stateNext = data_end; 
                                    i2c_sda_out_en_next = 'd0;    
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
                                    if(dataByte_next == readBytes - 1) begin      
                                        stateNext = data_end;
                                        i2c_sda_reg_next = 'd1;                             // Send NACK
                                    end else begin 
                                        stateNext = data1;
                                        dataByte_next = dataByte_next + 1'b1;
                                        dataBit_next  = 'd0;                                // <--- CRITICAL FIX: Reset bit counter for Byte 2
                                        i2c_sda_reg_next = 'd1;                             // Send ACK
                                    end
                                end  
                        end 
                end
            
            data_end:
                begin
                    stateNext           = stop1; 
                    dataBit_next        = 'd0;
                    dataByte_next       = 'd0;
                    i2c_sda_reg_next    = 'd0;
                    i2c_sclk_reg_next   = 'd0;  // data_end condition 
                    i2c_sda_out_en_next = 'd1;  
                    //readBitCount_next   = 'd15;   
                end
                
            stop1:
                begin
                    stateNext = stop2;
                    i2c_sda_reg_next = 'd0;
                    i2c_sclk_reg_next = 'd1;    // stop1 condition
                end   
            stop2:
                begin
                    stateNext = delay1;
                    i2c_sda_reg_next = 'd1;
                    i2c_sclk_reg_next = 'd1;    // stop2 condition
                    i2c_transaction_complete_next = 'd1;    // we raise this flag high for 1 clock cycle.  
                end
            delay1:                                         // delay1 is solely to deassert i2c_transaction_complete
                begin
                    stateNext = delay2;
                    i2c_sda_reg_next = 'd1;
                    i2c_sclk_reg_next = 'd1;                // idle condition
                    i2c_transaction_complete_next = 'd0;    // we raise this flag high for 1 clock cycle. 
                end
            delay2:
                begin
                    if(delayCountNext == DELAY_COUNT_BETWEEN_READ-1)
                        begin 
                            delayCountNext = 'd0;
                            stateNext = idle;
                        end
                    else
                        delayCountNext = delayCountNext + 'd1;
                end
            default:
                begin
                    stateNext = idle;
                    i2c_sclk_reg_next = 'd1;
                    i2c_sda_reg_next = 'd1;
                end
        endcase
    end
    
    always_comb
    begin
        for(int count=0; count<readBytes; count++)
        begin
            i2c_sda_read_bit = {i2c_sda_read_bit << 8 | i2c_data_storage[count]};
        end
    end
    

    assign i2c_sclk = i2c_sclk_reg_now;
    assign i2c_sda = (i2c_sda_out_en == 'd1) ? i2c_sda_reg_now : 'dZ;
    assign i2c_transaction_complete = i2c_transaction_complete_now;
    //assign i2c_sda_read_bit = {i2c_data_storage[0],i2c_data_storage[1]};  
endmodule
