# 🕸️SPI-Slave-with-Single-Port-RAM

# 📌Project Overview: 
##  i): Description: 
The Serial Peripheral Interface (SPI) is a high-speed, synchronous serial 
communication protocol commonly used for short-distance data exchange, 
particularly in embedded systems. It enables efficient and simultaneous two-way (full 
duplex) communication between a master device and one or more slave devices. 
Thanks to its simplicity, flexibility, and performance, SPI is widely adopted for 
connecting microcontrollers with peripherals such as sensors, memory devices, and 
display modules. 
## ii): SPI Architecture: 
### Wire connections: 
• rx_data in the SPI slave module is connected to the din port in the RAM module. 

• rx_valid in the SPI slave module is connected to rx_valid in the RAM module.

• dout in the RAM module is connected to tx_data in the SPI slave module. 

• tx_valid in the RAM module is connected to tx_valid in the SPI slave module.

![image](https://github.com/user-attachments/assets/8cad3e3e-252d-45bc-b5fa-a36bc2009a0a)

## iii): SPI State Diagram: 
![image](https://github.com/user-attachments/assets/6dc7f7e0-0793-4b1b-83db-6d60c802dcbc)
### State Descriptions:
IDLE: The initial state where the SPI slave waits for communication. The state machine returns to IDLE on reset or when SS_n (Slave Select) is high.

CHK_CMD (Check Command): When SS_n is low, the SPI slave checks the command bit (MOSI). If MOSI is high, it transitions to READ_ADDR; if low, it transitions to WRITE.

WRITE: In this state, the SPI slave writes the received address/data to RAM. The state persists as long as SS_n is low and transitions to IDLE when SS_n is high.

READ_ADDR: When SS_n is low and MOSI is high, the SPI slave transitions to READ_ADDR to receive the address for reading from RAM.

READ_DATA: In this state, the SPI slave sends the requested data from RAM to the master. The state persists as long as SS_n is low and transitions to IDLE when SS_n is high.

## iv): Signal Description:
| Feature        | Description                     | Feature        | Description                     |
|----------------|---------------------------------|----------------|---------------------------------|
| Power Saving   | Gray encoding reduces switching | Power Saving   | Gray encoding reduces switching |
| Area Efficient | Fewer flip-flops needed         | Area Efficient | Fewer flip-flops needed         |





