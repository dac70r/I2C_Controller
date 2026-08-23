/*
    File description: Top module file for the I2C Controller project.
*/

module top_module (
    input       sys_clk,
    input       reset_n,
    // --------- i2c ---------- //
    output      sclk,
    inout       sda,
    // -------- uart ---------- //
    input       uart_rx,
    output      uart_tx,                    
    // ---- led & 7-segment --- //
    output      [15:0] LED,    
    output      [3:0] SSEG_AN,
    output      [6:0] SSEG_CA
);
    
    localparam READBYTES = 2'd2;        
    localparam READBITS = 5'd16;        // <---------------- CHANGE THIS FOR APPROPRIATE NO OF READBITS (READBYTES * 8)
    
    wire i2c_sys_tick, uart_sys_tick;                       // wire for: i2c, uart
    wire pll_output_clk;                                    // Output Clock from clocking wizard
    wire [READBITS-1:0] i2c_sda_read_bit;                   // Output from I2C_Core
    wire [2:0] command_controller_to_core;
    wire i2c_transaction_complete_core_to_controller;
    
    wire an_tick;                                           // pulse for 7 segment
    wire debounced_reset; wire debounced_reset_n;
    wire [3:0] bcd_zero_to_nine [3:0];
    
    // ------------------------------------------------------------- 7 segment ------------------------------------------------------------- //
    
    // 0. debouncer for reset_n
    debounce my_debounce (.clk(sys_clk), .stimulus(reset_n), .debounced_result(debounced_reset));
    assign debounced_reset_n = !debounced_reset;            // all modules are active low
    
    // 1. baud rate generator for 7 segment display
    baud_rate_generator #(.counterTickMax(399_999)) seven_segment_baud_rate_generator  // Generate 1600kHz CLK (400kHz * 4)
    (.sys_clk(sys_clk), .reset_n(debounced_reset_n), .sys_tick(an_tick));
    
    // 2. seven segment core
    seven_segment_core my_seven_segment_core(
    .sys_clk(an_tick),
    .reset_n(debounced_reset_n),
    .input_data(bcd_zero_to_nine),
    .an(SSEG_AN),
    .seg(SSEG_CA));
    
    // 3. binary convert decimal core
    binary_convert_decimal my_binary_convert_decimal(
        .input_data(i2c_sda_read_bit),
        .reset_n(debounced_reset_n),
        .output_data(bcd_zero_to_nine));
    
    // --------------------------------------------------------------- i2c --------------------------------------------------------------- //
    
    // 4. clock generator (40Mhz)    
    sys_pll clock_40mhz
    (.clk_in1(sys_clk), .resetn(debounced_reset_n), .clk_out1(pll_output_clk));    // Generate 40Mhz CLK
    
    // 5. baud rate generator for i2c controller & i2c core
    baud_rate_generator #(.counterTickMax(24)) i2c_baud_rate_generator  // Generate 1600kHz CLK (400kHz * 4)
    (.sys_clk(pll_output_clk), .reset_n(debounced_reset_n), .sys_tick(i2c_sys_tick));
    
    // 6. i2c controller (for workflow building)
    i2c_controller my_i2c_controller(
        .sys_tick(i2c_sys_tick),         
        .reset_n(debounced_reset_n),
        .cmd(command_controller_to_core),         
        .i2c_transaction_complete(i2c_transaction_complete_core_to_controller)
    );
    
    // 7. i2c core 
    i2c_core my_i2c_core(
        .sys_tick(i2c_sys_tick),
        .reset_n(debounced_reset_n),
        .cmd(command_controller_to_core),   
        .i2c_sclk(sclk),
        .i2c_sda(sda),
        .i2c_sda_read_bit(i2c_sda_read_bit),
        .i2c_transaction_complete(i2c_transaction_complete_core_to_controller)
    );
    
    // --------------------------------------------------------------- uart --------------------------------------------------------------- //
    
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
    
    assign LED               = i2c_sda_read_bit;
    
endmodule