
/*
    This file contains the i2c addresses of i2c peripherals
*/

localparam ADDR_BH1750  = 7'h23;        // Ambient Light Sensor - ROHM Semiconductor BH1750 

localparam CMD_CONT_HIGH_RES_1 = 8'b10;    // Continuous, High Resolution Mode 1 (120ms)
localparam CMD_CONT_HIGH_RES_2 = 8'b11;    // Continuous, High Resolution Mode 2 (120ms)
localparam CMD_CONT_LOW_RES = 8'h13;    // Continuous, Low Resolution (16ms)

localparam ADDR_SENSOR  = 7'h1E;      // Gyroscope - Honeywell's HMC5883L