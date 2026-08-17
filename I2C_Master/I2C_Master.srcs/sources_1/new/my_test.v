`timescale 1ns / 1ps

module my_test(
        input sw,
        output [1:0] LED
    );
    
    assign LED[1] = sw;
    assign LED[0] = ~sw;
    
endmodule
