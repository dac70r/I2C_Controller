`timescale 1ns / 1ps

module I2C_Controller(
        input sys_tick,         // 400kHz * 4  
        input reset_n,
        input [3:0] cmd,        // 
        output i2c_sclk,
        inout i2c_sda
    );

    localparam START_CMD = 3'b000;
    localparam RD_CMD = 3'b001;
    localparam WR_CMD = 3'b010;
    localparam STOP_CMD = 3'b011;
    localparam RESTART_CMD = 3'b100;
    
    typedef enum {idle, start1, start2, hold, restart, stop1, stop2, 
    data1, data2, data3, data4, data_end} state_type;
    
    state_type stateNow, stateNext = idle;
    reg i2c_sclk_reg_now = 'd1; 
    reg i2c_sclk_reg_next = 'd1;
    reg i2c_sda_reg_now = 'd1;
    reg i2c_sda_reg_next = 'd1;
    reg [4:0] dataBit_now = 'd0;
    reg [4:0] dataBit_next = 'd0;
    
    always_ff @ (posedge sys_tick)
    begin
        if (!reset_n)
            begin
                stateNow            <= idle;
                i2c_sclk_reg_now    <= 'd1;     // idle
                i2c_sda_reg_now     <= 'd1;     // idle
                dataBit_now         <= 'd0;     // idle
            end
        else
            begin
                stateNow <= stateNext;
                i2c_sclk_reg_now <= i2c_sclk_reg_next;
                i2c_sda_reg_now <= i2c_sda_reg_next;
                dataBit_now     <= dataBit_next;
            end
    end
    
    always_comb
    begin
        stateNext = stateNow;
        i2c_sclk_reg_next = i2c_sclk_reg_now;
        i2c_sda_reg_next = i2c_sda_reg_now;
        case(stateNow)
            idle:
                begin
                    i2c_sclk_reg_next = 'd1;    // idle condition
                    i2c_sda_reg_next = 'd1;
                    if(cmd==START_CMD)
                        begin
                            stateNext = start1;         // start condition
                        end
                end
            start1:
                begin
                    stateNext = start2;         
                    i2c_sclk_reg_next = 'd0;    // start1 condition
                    i2c_sda_reg_next = 'd1;
                end
            start2:
                begin
                    stateNext = hold;         
                    i2c_sclk_reg_next = 'd0;    // start2 condition
                    i2c_sda_reg_next = 'd0;
                end
            hold:
                begin
                    if(cmd==WR_CMD)
                        begin
                            stateNext = data1;         // start condition
                        end
                    else if(cmd==RD_CMD)
                        begin
                            stateNext = data1;         // start condition
                        end
                    else if(cmd==STOP_CMD)
                        begin
                            stateNext = stop1;         // start condition
                        end
                    else if(cmd==RESTART_CMD)
                        begin
                            stateNext = restart;         // start condition
                        end
                    else
                        begin
                            stateNext = hold;
                        end
                end
            data1:
                begin
                    stateNext = data2;
                end
            data2:
                begin
                    stateNext = data3;
                end
            data3:
                begin
                    stateNext = data4;
                end
            data4:
                begin
                    if(dataBit_next <8)
                        begin stateNext = data1; dataBit_next = dataBit_next + 'd1; end
                    else
                        stateNext = data_end;
                end
            data_end:
                begin
                    stateNext = hold;
                end
            stop1:
                begin
                    stateNext = hold;
                end   
            stop2:
                begin
                    stateNext = hold;
                end
            default:
                begin
                    stateNext = idle;
                    i2c_sclk_reg_next = 'd1;
                    i2c_sda_reg_next = 'd1;
                end
        endcase
    end
    

    

    
endmodule
