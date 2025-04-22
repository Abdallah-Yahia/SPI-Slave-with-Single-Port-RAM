# 🕸️SPI-Slave-with-Single-Port-RAM

# 📌Project Overview: 


##  • Description: 
The Serial Peripheral Interface (SPI) is a high-speed, synchronous serial 
communication protocol commonly used for short-distance data exchange, 
particularly in embedded systems. It enables efficient and simultaneous two-way (full 
duplex) communication between a master device and one or more slave devices. 
Thanks to its simplicity, flexibility, and performance, SPI is widely adopted for 
connecting microcontrollers with peripherals such as sensors, memory devices, and 
display modules. 


## • SPI Architecture: 
![image](https://github.com/user-attachments/assets/8cad3e3e-252d-45bc-b5fa-a36bc2009a0a)


## • SPI State Diagram: 
![image](https://github.com/user-attachments/assets/6dc7f7e0-0793-4b1b-83db-6d60c802dcbc)
### State Descriptions:
IDLE: The initial state where the SPI slave waits for communication. The state machine returns to IDLE on reset or when SS_n (Slave Select) is high.

CHK_CMD (Check Command): When SS_n is low, the SPI slave checks the command bit (MOSI). If MOSI is high, it transitions to READ_ADDR; if low, it transitions to WRITE.

WRITE: In this state, the SPI slave writes the received address/data to RAM. The state persists as long as SS_n is low and transitions to IDLE when SS_n is high.

READ_ADDR: When SS_n is low and MOSI is high, the SPI slave transitions to READ_ADDR to receive the address for reading from RAM.

READ_DATA: In this state, the SPI slave sends the requested data from RAM to the master. The state persists as long as SS_n is low and transitions to IDLE when SS_n is high.


## • Signal Description:
| Signal     | Type   | Width | Description                                  |
|------------|--------|--------|---------------------------------------------|
| MOSI       | Input  | 1      | Master Out Slave In                         |
| MISO       | Output | 1      | Master In Slave Out                         |
| SS_n       | Input  | 1      | Slave Select (active low)                   |
| clk        | Input  | 1      | Clock signal                                |
| rst_n      | Input  | 1      | Reset signal (active low)                   |
| rx_data    | Output | 10     | Data received from SPI master               |
| rx_valid   | Output | 1      | Indicates valid data received from SPI      |
| tx_data    | Input  | 8      | Data to be transmitted to SPI master        |
| tx_valid   | Input  | 1      | Indicates valid data to transmit to SPI     |
| din        | Output | 10     | Data input to RAM                           |
| dout       | Input  | 8      | Data output from RAM                        |

# 🛠️ Tools Used:
### Vivado:
Used for design entry, synthesis, implementation, and bitstream generation. It also helped in constraint management and timing analysis.

### Questa Sim:
Used for simulation and functional verification to ensure correct functional behavior of the design.

### Questa Lint:
Used for static RTL analysis. Helped detect early design issues such as coding style violations, unreachable logic, and synthesis-simulation mismatches.

# Contact info:

You can reach me through:

- **Beacons**: [![Image](https://github.com/user-attachments/assets/c66c754f-ddcf-4fc0-b30f-24da33f59c7e)](https://beacons.ai/abdallah_yahia)




