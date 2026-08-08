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
    reg i2c_sclk_reg_now, i2c_sclk_reg_next = 'd1;
    reg i2c_sda_reg_now, i2c_sda_reg_next = 'd1;
    
    always_ff @ (posedge sys_tick)
    begin
        if (!reset_n)
            begin
                stateNow            <= idle;
                i2c_sclk_reg_now    <= 'd1; // idle
                i2c_sda_reg_now     <= 'd1; // idle
            end
        else
            begin
                stateNow <= stateNext;
                i2c_sclk_reg_now <= i2c_sclk_reg_next;
                i2c_sda_reg_now <= i2c_sda_reg_next;
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
                    if(cmd==START_CMD)
                        begin
                            stateNext = start1;         // start condition
                        end
                    else
                        begin
                            i2c_sclk_reg_next = 'd1;    // idle condition
                            i2c_sda_reg_next = 'd1;
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
            default:
                begin
                    stateNext = idle;
                    i2c_sclk_reg_next = 'd1;
                    i2c_sda_reg_next = 'd1;
                end
        endcase
    end
    

    

    
endmodule
