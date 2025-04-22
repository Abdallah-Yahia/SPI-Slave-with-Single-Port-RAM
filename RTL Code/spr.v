module spr #(parameter MEM_DEPTH=2**8,
             parameter ADDR_SIZE=8     ) (

input [9:0] din,
input clk,rst_n,rx_valid,
output reg [7:0] dout,
output reg tx_valid       );

reg [7:0] mem [MEM_DEPTH-1:0]; // "The width of the output is its number of bits."

reg [ADDR_SIZE-1:0] write_addr , read_addr ;

always @(posedge clk) begin
    
    if(!rst_n)begin
    write_addr<=0;
    read_addr<=0;
    tx_valid<=0;
    dout<=0;
    end
    
    else if(rx_valid) begin
    case(din[9:8]) 

      0: begin                   // write address
         write_addr<=din[7:0];
         tx_valid<=0;
         end 

      1: begin                   // write data
         mem[write_addr]<=din[7:0];
         tx_valid<=0;
         end 

      2: begin                   // read address
         read_addr<=din[7:0];
         tx_valid<=0;
         end 

      3: begin                   // read data
         dout<=mem[read_addr];
         tx_valid<=1;
         end 

      default:begin
         dout<=0;
         tx_valid<=0;  
        end
    endcase
  end
 end    
endmodule
