//**************************************************************************************************** 
//File Information
//**************************************************************************************************** 
//File Name      : testbench.v 
//Project Name   : gt8305
//Description    : the spi simulation master testbench.
//License        : None
//**************************************************************************************************** 
//Version Information
//**************************************************************************************************** 
//Create Date    : 2017-04-01 17:30
//First Author   : bwang
//Last Modify    : 2017-04-14 14:20
//Last Author    : bwang
//Version Number : 001
//**************************************************************************************************** 
//Change History(latest change first)
//yyyy.mm.dd - Author - Your log of change
//**************************************************************************************************** 
//2017.04.14 - bwang - Add some comment and add the i/o in the testbench.
//2017.04.01 - bwang - The initial version.
//**************************************************************************************************** 
//File Include : system header file

module testbench(
    output  wire            spi_cs_n    ,//chip select
    output  wire            spi_sclk    ,//serial clock
    input   wire            spi_miso    ,//master input and slave output
    output  wire            spi_mosi     //master output and slave input

);


    //************************************************************************************************
    // 1.Parameter and constant define
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 1.1 The standard parameter 
    //------------------------------------------------------------------------------------------------   
    //Normal
    parameter HIGH                  =   1   ;
    parameter LOW                   =   0   ;
    parameter WRITE                 =   0   ;
    parameter READ                  =   1   ; 
    //Width
    parameter CMD_WIDTH             =  05   ;
    parameter ADDR_WIDTH            =  04   ;
    parameter DATA_WIDTH            =  11   ;
    parameter BYTE                  =  08   ;
    parameter WORD                  =  16   ;
    parameter DWORD                 =  32   ;
    //------------------------------------------------------------------------------------------------
    // 1.2 The SPI Timing Parameter 
    //------------------------------------------------------------------------------------------------   
    parameter tCLKL                 =  40   ;
    parameter tCLKH                 =  40   ;
    parameter tSU_SDI               =  20   ;
    parameter tHD_SDI               =  30   ;
    parameter tHD_SDO               =  40   ;
    parameter tSU_SCS               =  50   ;
    parameter tHD_SCS               =  50   ;
    parameter tHI_SCS               = 400   ;

    parameter tPOR                  = 100_000   ;

    //------------------------------------------------------------------------------------------------
    // 1.3 The Option
    //------------------------------------------------------------------------------------------------   
    //`define WAVE_GEN                    1
    `define WAVE_FSDB                   1
    `ifndef WAVE_FSDB
        `define WAVE_VCD                1
    `endif
    //------------------------------------------------------------------------------------------------
    // 1.2 The task prototype
    //------------------------------------------------------------------------------------------------   
    //task spi_start();
    //task spi_wr_data(input [`DWORD-1:00] send_data,output [`DWORD-1:00] read_data,input integer len);
    //task spi_stop();
    //task spi_write_read(input [CMD_WIDTH-1:00] cmd,input [DATA_WIDTH-1:00] write_data,output [DATA_WIDTH-1:00] read_data);
    //task display(input [CMD_WIDTH-1:00] cmd,input [DATA_WIDTH-1:00] write_data,input [DATA_WIDTH-1:00] read_data);
    
    //------------------------------------------------------------------------------------------------
    // 1.3 The GT8305 Define
    //------------------------------------------------------------------------------------------------   
    parameter WRITE_0       =      5'b00000    ;
    parameter WRITE_1       =      5'b00001    ;
    parameter WRITE_2       =      5'b00010    ;
    parameter WRITE_3       =      5'b00011    ;
    parameter WRITE_4       =      5'b00100    ;
    parameter WRITE_5       =      5'b00101    ;
    parameter WRITE_6       =      5'b00110    ;
    parameter WRITE_7       =      5'b00111    ;
    parameter WRITE_8       =      5'b01000    ;
    parameter WRITE_9       =      5'b01001    ;
    parameter WRITE_a       =      5'b01010    ;
    parameter WRITE_b       =      5'b01011    ;
    parameter WRITE_c       =      5'b01100    ;
    parameter WRITE_d       =      5'b01101    ;
    parameter WRITE_e       =      5'b01110    ;
    parameter WRITE_f       =      5'b01111    ;
    parameter READ_0        =      5'b10000    ;
    parameter READ_1        =      5'b10001    ;
    parameter READ_2        =      5'b10010    ;
    parameter READ_3        =      5'b10011    ;
    parameter READ_4        =      5'b10100    ;
    parameter READ_5        =      5'b10101    ;
    parameter READ_6        =      5'b10110    ;
    parameter READ_7        =      5'b10111    ;
    parameter READ_8        =      5'b11000    ;
    parameter READ_9        =      5'b11001    ;
    parameter READ_a        =      5'b11010    ;
    parameter READ_b        =      5'b11011    ;
    parameter READ_c        =      5'b11100    ;
    parameter READ_d        =      5'b11101    ;
    parameter READ_e        =      5'b11110    ;
    parameter READ_f        =      5'b11111    ;



    //************************************************************************************************
    // 2.Register and wire declaration
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 2.1 SPI Interface
    //------------------------------------------------------------------------------------------------   

    //------------------------------------------------------------------------------------------------
    // 2.1 SPI Interface
    //------------------------------------------------------------------------------------------------   
    reg     [DATA_WIDTH-1:00]   read_data       ;         
    reg     [DATA_WIDTH-1:00]   write_data      ;         
    //************************************************************************************************
    // 3.Main code
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 3.1 the wave file generate
    //------------------------------------------------------------------------------------------------
    `ifdef WAVE_GEN
        initial begin
            `ifdef WAVE_VCD
                $dumpfile("wave.vcd");
                $dumpon;
            `endif
            `ifdef WAVE_FSDB
                $dumpfile("wave.fsdb");
            `endif
            $dumpvars(0,testbench);
        end
    `endif
    //------------------------------------------------------------------------------------------------
    // 3.1 the spi register write and read example
    //------------------------------------------------------------------------------------------------
    initial begin
        //1.wait por cfg done
        #tPOR;
        
        //2.spi register write and read
        write_data = 'haa;
        //2.1 spi write data : data -> 0x5 
        spi.spi_write_read(WRITE_5,write_data,read_data);
        //2.2 spi read data : data <- 0x5 
        spi.spi_write_read(READ_5,write_data,read_data);
        //2.3 data compare
        if(read_data != write_data) begin
            $display("Error : write data[%h] != read data[%h].",write_data,read_data);
            $finish();
        end
        else begin
            $display("Success : write data[%h] = read_data[%h].",write_data,read_data);
        end
        #10_000;
        `ifdef WAVE_VCD 
            $dumpoff;
        `endif
        $finish();
    end 
     
    //************************************************************************************************
    // 4.Submodule
    //************************************************************************************************
    
    spi_sim_master #(
        .HIGH       (HIGH       ),
        .LOW        (LOW        ),
        .WRITE      (WRITE      ),
        .READ       (READ       ), 
        //Width     (/Width
        .CMD_WIDTH  (CMD_WIDTH  ),
        .ADDR_WIDTH (ADDR_WIDTH ),
        .DATA_WIDTH (DATA_WIDTH ),
        .BYTE       (BYTE       ),
        .WORD       (WORD       ),
        .DWORD      (DWORD      ),
        //SPI       (/SPI
        .tCLKL      (tCLKL      ),
        .tCLKH      (tCLKH      ),
        .tSU_SDI    (tSU_SDI    ),
        .tHD_SDI    (tHD_SDI    ),
        .tHD_SDO    (tHD_SDO    ),
        .tSU_SCS    (tSU_SCS    ),
        .tHD_SCS    (tHD_SCS    ),
        .tHI_SCS    (tHI_SCS    )
    )
    spi(
        .spi_cs_n   (spi_cs_n   ),
        .spi_miso   (spi_miso   ),
        .spi_mosi   (spi_mosi   ),
        .spi_sclk   (spi_sclk   )
    );
endmodule    
//****************************************************************************************************
//End of Module
//****************************************************************************************************
