/*
    File description: Top module file for the I2C Controller project.
*/

module top_module (
    input       sys_clk,
    input       reset_n,
    output [3:0] SSEG_AN,
    // ------------------ //
    
    output      sclk,
    inout       sda,
    output      i2c_transaction_complete,
    // ------------------ //
    
    input       uart_rx,
    output      uart_tx,
    // ------------------ //
    
    output [15:0] temp_low_byte,            // LED
    output      test_port                   // Test port for probing
);
    
    `include "i2c_peripheral.vh"
    
    localparam READBYTES = 2'd2;        
    localparam READBITS = 5'd16;        // <---------------- CHANGE THIS FOR APPROPRIATE NO OF READBITS (READBYTES * 8)
    
    wire i2c_sys_tick, uart_sys_tick;                       // wire for: i2c, uart
    wire pll_output_clk;                                    // Output Clock from clocking wizard
    wire [READBITS-1:0] i2c_sda_read_bit;                   // Output from I2C_Core
    wire [2:0] command_controller_to_core;
    wire i2c_transaction_complete_core_to_controller;
    
    sys_pll clock_40mhz
    (.clk_in1(sys_clk), .resetn(reset_n), .clk_out1(pll_output_clk));    // Generate 40Mhz CLK
  
    baud_rate_generator #(.counterTickMax(24)) i2c_baud_rate_generator  // Generate 1600kHz CLK (400kHz * 4)
    (.sys_clk(pll_output_clk), .reset_n(reset_n), .sys_tick(i2c_sys_tick));
    
    i2c_controller my_i2c_controller(
        .sys_tick(i2c_sys_tick),         
        .reset_n(reset_n),
        .cmd(command_controller_to_core),         
        .i2c_transaction_complete(i2c_transaction_complete_core_to_controller)
    );
    
    i2c_core my_i2c_core(
        .sys_tick(i2c_sys_tick),
        .reset_n(reset_n),
        .cmd(command_controller_to_core),   
        .i2c_sclk(sclk),
        .i2c_sda(sda),
        .i2c_sda_read_bit(i2c_sda_read_bit),
        .i2c_transaction_complete(i2c_transaction_complete_core_to_controller)
    );
    
    // ------------------------------------ uart --------------------------------------------------------------- //
    
    wire full;
    wire empty;
    wire rd_data;
    wire rd_en;
    /*
    baud_rate_generator #(.counterTickMax(651)) uart_baud_rate_generator // Generate 153.6kHz (9600Hz * 16)
    (.sys_clk(clk), .reset_n(reset_n), .sys_tick(uart_sys_tick));
    
    fifo_core           #(.depth(64), .log2_depth(6), .width(8)) uart_tx_fifo_core
    (.clk(sys_clk), .reset_n(reset_n), .wr_en(i2c_transaction_complete), .rd_en(), .wr_data(i2c_sda_read_bit), .rd_data(), .full(full), .empty(empty));
    
    uart_tx             #(.dataBits(8), .stopBitTick(16)) uart_tx_inst
    (.clk(clk), .reset_n(reset_n), .s_tick(uart_sys_tick), .din(), 
    .stimulus,                  // push_button_stimulus
    .tx_done_tick,       // signal that this module has completed and other module can extract data
    .tx
    );
    */
    
    assign SSEG_AN [3:0]    = 4'b1111; 
    assign temp_low_byte    = i2c_sda_read_bit;
    assign test_port        = i2c_sda_read_bit[15];
    assign i2c_transaction_complete = i2c_transaction_complete_core_to_controller;
    
endmodule