module SPI_Wrapper(

input clk,rst_n,SS_n,MOSI,
output MISO );            

wire tx_valid;
wire rx_valid;
wire [7:0] tx_data;
wire [9:0] rx_data;

SPI_Slave SPI (.clk(clk),.rst_n(rst_n),.tx_valid(tx_valid),.MOSI(MOSI),.SS_n(SS_n),.tx_data(tx_data),
               .rx_data(rx_data),.rx_valid(rx_valid),.MISO(MISO));


spr #(.MEM_DEPTH(256),.ADDR_SIZE(8)) RAM (.clk(clk),.rst_n(rst_n),.rx_valid(rx_valid),.din(rx_data),
                                          .dout(tx_data),.tx_valid(tx_valid));            

endmodule
