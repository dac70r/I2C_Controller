module my_sim();

    logic sys_clk;
    logic reset_n;
    logic sclk;
    wire sda;

    Top_Module 
    my_Top_Module(.sys_clk(sys_clk), .reset_n(reset_n), .sclk(sclk), .sda(sda));

    initial begin
        sys_clk = 0;
        reset_n = 1;
        sclk = 1;
    end

    always begin
        #5; 
            sys_clk = 1; 
        #5;
            sys_clk = 0;
    end
endmodule