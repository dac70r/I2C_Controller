/*
    Description: This module generates the tick for which the i2c clock will rely on. I2C clock is 400Khz, and we shall employ an oversampling rate of 16x.
*/

module baud_rate_generator #(
    parameter  counterTickMax = 999
)
(
    input sys_clk,                      //40Mhz
    input reset_n,
    output sys_tick
);

reg [26:0] counterTick = 0;             // for synthesizing the clock
reg sys_tick_reg = 0;


always_ff @ (posedge sys_clk)
    begin
        if(!reset_n)
            begin
                counterTick <= 'd0;
            end
        else
            begin
                if(counterTick == counterTickMax) //400khz
                    begin
                        sys_tick_reg    <= 'd1;
                        counterTick     <= 'd0;
                    end
                else
                    begin
                        sys_tick_reg    <= 'd0;
                        counterTick <= counterTick + 'd1;
                    end
            end
    end

assign sys_tick = sys_tick_reg;
    
endmodule