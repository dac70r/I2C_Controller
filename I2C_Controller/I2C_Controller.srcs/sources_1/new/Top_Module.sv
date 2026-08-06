/*
    File description: Top module file for the I2C Controller project.
*/

module Top_Module (
    input sys_clk,
    input reset_n,
    output sclk,
    inout sda
);

    wire sys_tick;

    baud_rate_generator my_baud_rate_generator
    (.sys_clk(sys_clk), .reset_n(reset_n), .sys_tick(sys_tick));
    
    assign sclk = sys_tick;
    assign sda = (sys_tick == 1) ? 1 : 'bZ;
    
    
endmodule