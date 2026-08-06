`timescale 1ns / 1ps

module I2C_Controller(
        input sys_clk,
        output i2c_sclk,
        inout i2c_sda
    );

    typedef enum {idle, start, address, read_write, ack, nack, opecode, stop, high_byte, low_byte} state_type;

    

    
endmodule
