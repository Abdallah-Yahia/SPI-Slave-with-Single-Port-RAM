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


