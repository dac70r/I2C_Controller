module my_sim();

    logic sys_clk;
    logic reset_n;
    logic sclk;
    logic [3:0] cmd;
    
    wire sda;

    Top_Module 
    my_Top_Module(.sys_clk(sys_clk), .reset_n(reset_n), .cmd(cmd), .sclk(sclk), .sda(sda));

    initial begin
        sys_clk = 0;
        reset_n = 1;
        sclk = 1;
        #100;
        cmd = 3'b000;       // write 
        #1000;
        cmd = 3'b011;       // stop    
    end

    always begin
        #5; 
            sys_clk = 1; 
        #5;
            sys_clk = 0;
    end
    
    
endmodule