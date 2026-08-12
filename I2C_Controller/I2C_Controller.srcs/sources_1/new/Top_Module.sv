/*
    File description: Top module file for the I2C Controller project.
*/

module Top_Module (
    input sys_clk,
    input reset_n,
    input [3:0] cmd, 
    output sclk,
    inout sda,
    output i2c_transaction_complete
);
    reg [6:0] i2c_seven_bit_addr_reg = 7'b010_0011;         // 7-bit i2c address (0x23)
    reg [7:0] i2c_eight_bit_addr_reg = 8'b0001_0001;        // 8-bit opecode (config data) 
    
    wire sys_tick;
    wire pll_output_clk;    // Output Clock from clocking wizard          
    
    sys_pll clock_40mhz
   (.clk_out1(pll_output_clk), .resetn(reset_n), .clk_in1(sys_clk)); // Generate 40Mhz CLK
  
    baud_rate_generator my_baud_rate_generator
    (.sys_clk(pll_output_clk), .reset_n(reset_n), .sys_tick(sys_tick));
    
    I2C_Controller my_I2C_Controller(
        .sys_tick(sys_tick),
        .reset_n(reset_n),
        .cmd(cmd),   
        .i2c_seven_bit_addr(i2c_seven_bit_addr_reg),    
        .i2c_eight_bit_opcode(i2c_eight_bit_addr_reg),
        .i2c_sclk(sclk),
        .i2c_sda(sda),
        .i2c_transaction_complete(i2c_transaction_complete)
    );    
    
endmodule