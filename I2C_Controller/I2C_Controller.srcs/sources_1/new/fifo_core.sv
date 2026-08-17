`timescale 1ns / 1ps

module fifo_core #(depth=64, log2_depth=6, width=8)
    (
        input clk,
        input reset_n,
        
        input wr_en,
        input rd_en,
        input [(width-1):0] wr_data,
        output reg [(width-1):0] rd_data,
        
        // flags to notify the user the status of the fifo
        output reg full,
        output empty       
    );
    
    // BRAM Utilization
    (* ram_style = "block" *) reg [(width-1): 0] memory1 [0: (depth-1)];
    
    // LUTRAM Utilization
    // (* ram_style = "distributed" *) reg [(width-1): 0] memory2 [0: (depth-1)];
    
    initial begin
        for(int i = 0; i < depth; i++)
        begin
            memory1[i] <= 'hFF; 
        end
    end
    
    // read and write pointers 
    reg [(log2_depth):0] wr_addr = 'd0;
    reg [(log2_depth):0] rd_addr = 'd0;
    
    // Resets the fifo back to original position. Loss of data
    always @ (posedge clk)
    if (!reset_n)
        begin 
            wr_addr <= 'd0;
            rd_addr <= 'd0;
            rd_data <= 'd0;
        end
    else
        begin
            if (full != 1 && wr_en == 1)
                begin
                    memory1[wr_addr[log2_depth-1:0]] <= wr_data;
                    wr_addr <= wr_addr + 'd1;
                end
                
            if (empty != 1 && rd_en == 1)
                begin
                    rd_data <= memory1[rd_addr[log2_depth-1:0]];
                    rd_addr <= rd_addr + 'd1;
                end
        
        end
        
     assign empty = (wr_addr == rd_addr) ? 1 : 0;
     
     // lower bits matched, but the upper bits don't . meaning wr_addr is leading by a single bit
     assign full = (wr_addr[log2_depth] != rd_addr[log2_depth]) 
     && (wr_addr[(log2_depth-1):0] == rd_addr[(log2_depth-1):0]);
 
endmodule
