module SPI_Wrapper_tb();

reg clk,rst_n,SS_n,MOSI; 
wire MISO;

SPI_Wrapper DUT (.clk(clk),.rst_n(rst_n),.SS_n(SS_n),.MOSI(MOSI),.MISO(MISO));

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end  

initial begin

    $readmemh("mem.dat", DUT.RAM.mem);
    
    // Initialize signals
    rst_n = 0;
    SS_n = 1;
    MOSI = 1;
    @(negedge clk);
    rst_n = 1;

    repeat(5) begin
        SS_n = 1;
        MOSI = $random; 
        @(negedge clk); 
    end

    // WRITE SEQUENCE (WRITE ADDRESS + WRITE DATA)
    SS_n = 0;
    MOSI = 0; // Start write command
    repeat(20) @(negedge clk); 
    SS_n = 1; // End write command
    @(negedge clk);

    // READ ADDRESS
    SS_n = 0;
    MOSI = 1; // Read command
    repeat(20) @(negedge clk); 
    SS_n = 1;
    @(negedge clk);

    // READ DATA
    SS_n = 0;
    MOSI = 1;
    repeat(20) @(negedge clk); 
    SS_n = 1;
    @(negedge clk);

    $stop;
end
endmodule
