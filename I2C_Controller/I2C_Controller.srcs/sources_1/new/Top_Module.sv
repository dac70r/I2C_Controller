/*
    File description: Top module file for the I2C Controller project.
*/

module Top_Module (
    input sys_clk,
    input reset_n,
    input [3:0] cmd, 
    output sclk,
    inout sda
);

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
        .i2c_sclk(sclk),
        .i2c_sda(sda)
    );
    
    assign sclk = sys_tick;
    assign sda = (sys_tick == 1) ? 1 : 'bZ;
    
    
endmodule