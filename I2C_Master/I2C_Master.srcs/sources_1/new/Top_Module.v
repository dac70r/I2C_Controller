`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2026 10:19:34 AM
// Design Name: 
// Module Name: Top_Module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_Module(
        input   system_clock,
        input   reset_n,
	 
        // Core Signals: I2C_SCLK and I2C_SDA
        output  I2C_SCLK,                       // I2C_SCLK
        inout   I2C_SDA//,                        // I2C_SDA
        //output  LED
    );
    
//reg [31:0] count    = 32'd0;
//reg i2c_sclk_local = 'd1;

// Creates a 100kHz clock for I2C SCLK
//always @ (posedge system_clock)
//begin
//    if(count == 49_999_999)
//    begin
//         i2c_sclk_local <= ~i2c_sclk_local;
//         count <= 32'd1;
//    end
//    else
//        count <= count + 32'd1;
//end   
    
//assign I2C_SCLK = i2c_sclk_local;
//assign LED = (reset_n == 1) ? i2c_sclk_local : I2C_SDA;
    
    wire  		I2C_SCLK_Ref;                   	// Reference Clock
    wire  		I2C_SCLK_Ref_200k;              	// Reference Clock 200khz
    wire  [3:0] presentState_output;					// Displays presentState 
    wire  [7:0] i2c_clock_cycles_output;			// Displays i2c_clock_cycles
    wire  [7:0] i2c_bit_count_output;				// Displays i2c_bit_count
    wire			sda_out_en_output;					// Displays sda_out_en
    reg			read_I2C_SDA;							// Probes the I2C_SDA Signal
    reg			read_I2C_SCLK;							// Probes the I2C_SCLK Signal
    wire  [31:0]counter_last_output;					// Counter for Delay after each I2C Read
    
    
    I2C_BH1750 my_I2C_BH1750 (
    .system_clock(system_clock),
    .reset_n(reset_n),
	 
	  //Core Signals: I2C_SCLK and I2C_SDA
    .I2C_SCLK(I2C_SCLK),                       // I2C_SCLK
    .I2C_SDA(I2C_SDA),                        // I2C_SDA
	 
	 // Debug Signals (Signal Tap) - Remove to conserve resources
    .I2C_SCLK_Ref(I2C_SCLK_Ref),                   	// Reference Clock
    .I2C_SCLK_Ref_200k(I2C_SCLK_Ref_200k),              	// Reference Clock 200khz
    .presentState_output(presentState_output),					// Displays presentState 
    .i2c_clock_cycles_output(i2c_clock_cycles_output),			// Displays i2c_clock_cycles
    .i2c_bit_count_output(i2c_bit_count_output),				// Displays i2c_bit_count
	 .sda_out_en_output(sda_out_en_output),					// Displays sda_out_en
	 .read_I2C_SDA(read_I2C_SDA),							// Probes the I2C_SDA Signal
	 .read_I2C_SCLK(read_I2C_SCLK),							// Probes the I2C_SCLK Signal
	 .counter_last_output(counter_last_output)					// Counter for Delay after each I2C Read
);
    
endmodule
