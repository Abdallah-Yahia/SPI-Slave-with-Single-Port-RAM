vlib work
vlog spr.v SPI_Slave.v SPI_Wrapper.v SPI_Wrapper_tb.v
vsim -voptargs=+acc work.SPI_Wrapper_tb
add wave *
run -all
#quit -sim
