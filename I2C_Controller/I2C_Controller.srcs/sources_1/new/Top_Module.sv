/*
    File description: Top module file for the I2C Controller project.
*/

module I2C_Controller (
    input       sys_clk,
    input       reset_n,
    // ------------------ //
    input [3:0] cmd, 
    output      sclk,
    inout       sda,
    output      i2c_transaction_complete,
    // ------------------ //
    input       uart_rx,
    output      uart_tx
);
    localparam READBYTES = 2'd2;        
    localparam READBITS = 5'd16;        // <---------------- CHANGE THIS FOR APPROPRIATE NO OF READBITS (READBYTES * 8)
    
    //reg [6:0] 
    localparam i2c_seven_bit_addr_reg = 7'b010_0011;         // 7-bit i2c address (0x23)
    //reg [7:0] 
    localparam i2c_eight_bit_addr_reg = 8'b0001_0001;        // 8-bit opecode (config data) 
    
    wire i2c_sys_tick, uart_sys_tick;                       // wire for: i2c, uart
    wire pll_output_clk;                                    // Output Clock from clocking wizard
    wire [READBITS-1:0] i2c_sda_read_bit;                   // Output from I2C_Core
    
    sys_pll clock_40mhz
    (.clk_in1(sys_clk), .resetn(reset_n), .clk_out1(pll_output_clk));    // Generate 40Mhz CLK
  
    baud_rate_generator #(.counterTickMax(24)) i2c_baud_rate_generator  // Generate 1600kHz CLK (400kHz * 4)
    (.sys_clk(pll_output_clk), .reset_n(reset_n), .sys_tick(i2c_sys_tick));
    
    I2C_Core my_I2C_Core(
        .sys_tick(i2c_sys_tick),
        .reset_n(reset_n),
        .cmd(cmd),   
        .i2c_seven_bit_addr(i2c_seven_bit_addr_reg),    
        .i2c_eight_bit_opcode(i2c_eight_bit_addr_reg),
        .i2c_sclk(sclk),
        .i2c_sda(sda),
        .i2c_sda_read_bit(i2c_sda_read_bit),
        .i2c_transaction_complete(i2c_transaction_complete)
    );
    
    // ------------------------------------------------------------------------------------------------------- //
    baud_rate_generator #(.counterTickMax(651)) uart_baud_rate_generator // Generate 153.6kHz (9600Hz * 16)
    (.sys_clk(clk), .reset_n(reset_n), .sys_tick(uart_sys_tick));
    
endmodule