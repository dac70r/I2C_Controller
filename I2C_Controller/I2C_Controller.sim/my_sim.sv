module my_sim();

    logic sys_clk;
    logic reset_n;
    logic sclk;
    logic [2:0] cmd;
    logic i2c_transaction_complete;
    logic       uart_rx;
    logic       uart_tx;
    logic [15:0] temp_low_byte;
    logic [3:0] SSEG_AN;
    logic       test_port;

    wire sda;

    top_module 
    my_top_module (.sys_clk(sys_clk), .reset_n(reset_n), .cmd(cmd), .sclk(sclk), .sda(sda),
        .i2c_transaction_complete(i2c_transaction_complete), .uart_rx(uart_rx), .uart_tx(uart_tx),
        .temp_low_byte(temp_low_byte), .SSEG_AN(SSEG_AN), .test_port(test_port)
    );

    initial begin
        sys_clk = 0;
        reset_n = 1;
        sclk = 1;
        #100;
        cmd = 3'b000;       // write 
        #50000;
//        cmd = 3'b001;       // read   
//        #1000;
//        cmd = 3'b111;       // stop     
    end

    always begin
        #5; 
            sys_clk = 1; 
        #5;
            sys_clk = 0;
    end
    
    
endmodule