module SPI_Slave #( parameter IDLE = 3'b000,
                    parameter CHK_CMD = 3'b001,
                    parameter WRITE = 3'b010,
                    parameter READ_ADD = 3'b011,
                    parameter READ_DATA = 3'b100 )
(
input clk,                     // clock
input rst_n,                   // Synchronous active low reset
input tx_valid,                // If it is HIGH , read data
input MOSI,                    // Master out slave in
input SS_n,                    // Slave select active low , when it is 0 the master will begin communication
input  [7:0] tx_data,          // Data in  from RAM

output reg [9:0] rx_data,      // Data out from RAM
output rx_valid,               // Valid flag when it is HIGh it informs the RAM that it should expect data on din bus[WRITE/READ ADD/READ DATA]
output reg MISO                // Master in slave out
);            

(* fsm_encoding = "gray" *)    // gray encoding
reg [2:0] cs, ns;              // Current state and next state
reg read_check;                // To check "READ_ADD" or "READ_DATA"
reg [3:0] stp_cnt;             // Serial to parallel counter , 4 bits because it convertes [9:0] rx_data
reg [2:0] pts_cnt;             // Parallel to serial counter [read data state only],3 bits because it convertes [7:0] tx_data on MISO  


//state memory
always @(posedge clk) begin
    if(!rst_n)
    cs<=IDLE;
    else 
    cs<=ns;
end

//next state logic
always @(*) begin
    case(cs)
        
    IDLE:      if(!SS_n)
               ns=CHK_CMD;
               else
               ns=IDLE;


    CHK_CMD:   if(!SS_n && !MOSI)
               ns=WRITE;

               else if((!SS_n) && (MOSI))begin

               if(!read_check)
               ns=READ_ADD;
               else
               ns=READ_DATA;
               end 

               else if(SS_n)
               ns=IDLE;

               else 
               ns=CHK_CMD;

    WRITE:     if(SS_n)
               ns=IDLE;
               else
               ns=WRITE;


    READ_ADD:  if(SS_n)
               ns=IDLE;
               else 
               ns=READ_ADD;

    READ_DATA: if(SS_n)
               ns=IDLE;
               else
               ns=READ_DATA; 

    default:   ns=IDLE;
 endcase
end

//output logic
always @(posedge clk) begin
    if(!rst_n)begin
    stp_cnt<=0;
    pts_cnt<=3'b111; 
    MISO<=0;
    rx_data<=0;
    read_check<= 0; 
    end
       
    else begin    
    case(cs)
    IDLE: begin
        stp_cnt<=0;
        pts_cnt<=3'b111;
        MISO<=0;
        rx_data<=0;
    end


    CHK_CMD: begin
        stp_cnt<=0;
        pts_cnt<=3'b111;
        MISO<=0;
        rx_data<=0;
    end


    WRITE: begin
        if(stp_cnt<10)begin 
          rx_data <= {rx_data[8:0],MOSI}; 
          stp_cnt<=stp_cnt + 1;
        end  
    end


    READ_ADD:begin

        read_check <= 1;  // to go to READ_DATA

        if(stp_cnt<10)begin
          rx_data <= {rx_data[8:0],MOSI}; //MSB First
          stp_cnt<=stp_cnt + 1;
        end 
    end


    READ_DATA: begin

        read_check <= 0;  // to go to READ_ADD
        
        if(stp_cnt==10)begin 

        if(tx_valid)begin
        if (pts_cnt >= 0) begin
            MISO <= tx_data[pts_cnt]; //MSB First
            pts_cnt <= pts_cnt - 1;   
            end 
        end
        end

        else begin

        if(stp_cnt<10)begin
          rx_data <= {rx_data[8:0],MOSI}; //MSB First
          stp_cnt<=stp_cnt + 1;
        end 
        
        end
    end

    default: begin
    stp_cnt<=0;
    pts_cnt<=3'b111; 
    MISO<=0;
    rx_data<=0;
    end
    endcase
end
end

assign rx_valid=((cs==WRITE || cs==READ_ADD || cs==READ_DATA) && (stp_cnt==10))? 1'b1 : 1'b0;

endmodule