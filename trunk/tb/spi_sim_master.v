//**************************************************************************************************** 
//File Information
//**************************************************************************************************** 
//File Name      : spi_sim_master.v 
//Project Name   : gt8305
//Description    : the spi master for simulation.
//License        : None
//**************************************************************************************************** 
//Version Information
//**************************************************************************************************** 
//Create Date    : 2017-04-01 15:30
//First Author   : bwang
//Last Modify    : 2017-04-14 14:20
//Last Author    : bwang
//Version Number : 001
//**************************************************************************************************** 
//Change History(latest change first)
//yyyy.mm.dd - Author - Your log of change
//**************************************************************************************************** 
//2017.04.14 - bwang - Add the initial of spi output signal.
//2017.04.01 - bwang - The initial version.
//**************************************************************************************************** 
//File Include : system header file

module spi_sim_master #(
    //Normal
    parameter HIGH                  =  1 ,
    parameter LOW                   =  0 ,
    parameter WRITE                 =  0 ,
    parameter READ                  =  1 , 
    //Width
    parameter CMD_WIDTH             = 05 ,
    parameter ADDR_WIDTH            = 04 ,
    parameter DATA_WIDTH            = 11 ,
    parameter BYTE                  = 08 ,
    parameter WORD                  = 16 ,
    parameter DWORD                 = 32 ,
    //SPI
    parameter tCLKL                 = 40 ,
    parameter tCLKH                 = 40 ,
    parameter tSU_SDI               = 20 ,
    parameter tHD_SDI               = 30 ,
    parameter tHD_SDO               = 40 ,
    parameter tSU_SCS               = 50 ,
    parameter tHD_SCS               = 50 ,
    parameter tHI_SCS               = 400


)
(
    output  reg                     spi_cs_n        ,//chip select
    input   wire                    spi_miso        ,//master input and slave output
    output  reg                     spi_mosi        ,//master output and slave input
    output  reg                     spi_sclk         //serial clock
);

    //************************************************************************************************
    // 1.Parameter and constant define
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 1.1 none
    //------------------------------------------------------------------------------------------------   

    //************************************************************************************************
    // 2.Register and wire declaration
    //************************************************************************************************
    //------------------------------------------------------------------------------------------------
    // 2.1 none
    //------------------------------------------------------------------------------------------------   

    //************************************************************************************************
    // 3.Main code
    //************************************************************************************************
    initial begin
        spi_cs_n = HIGH ;
        spi_sclk = LOW  ;
        spi_mosi = LOW  ;
    end
    //------------------------------------------------------------------------------------------------
    // 3.1 the subtask spi start
    //------------------------------------------------------------------------------------------------
    task spi_start();
        begin
            spi_cs_n = HIGH    ;
            #(tHI_SCS);
            spi_cs_n = LOW     ;
            #(tSU_SCS);
        end
    endtask
    //------------------------------------------------------------------------------------------------
    // 3.2 the subtask spi write and read data
    //------------------------------------------------------------------------------------------------
    task spi_wr_data(input [DWORD-1:00] send_data,output [DWORD-1:00] read_data,input integer len);
        integer i;
        begin
            spi_cs_n = LOW;
            for(i=len-1;i>=0;i=i-1) begin
                #(tCLKL-tHD_SDI);
                spi_sclk = 1'b1;
                #(tCLKH-tSU_SDI);
                spi_mosi = send_data[i]; 
                #(tSU_SDI);
                spi_sclk = 1'b0;
                read_data[i] = spi_miso;
                #(tHD_SDI);
                spi_if.sdi = 1'bz;
            end
            spi_cs_n = LOW;
        end
    endtask
    //------------------------------------------------------------------------------------------------
    // 3.2 the subtask spi stop
    //------------------------------------------------------------------------------------------------
    task spi_stop();
        begin
            spi_cs_n = LOW;
            #(tHD_SCS);
            spi_cs_n = HIGH;
        end
    endtask
    //------------------------------------------------------------------------------------------------
    // 3.2 the main task spi write/read
    //------------------------------------------------------------------------------------------------
    task spi_write_read(input [CMD_WIDTH-1:00] cmd,input [DATA_WIDTH-1:00] write_data,output [DATA_WIDTH-1:00] read_data);
        begin
            spi_start();
            spi_wr_data(cmd,read_data,CMD_WIDTH);
            spi_send_data(write_data,read_data,DATA_WIDTH);
            spi_stop();
            display(cmd,write_data,read_data);
        end
    endtask

    task display(input [CMD_WIDTH-1:00] cmd,input [DATA_WIDTH-1:00] write_data,input [DATA_WIDTH-1:00] read_data);
        reg [CMD_WIDTH-ADDR_WIDTH-1:0]         wr_bit  ;
        reg [ADDR_WIDTH-1:0]                   addr_bit;
        begin
            addr_bit = cmd[ADDR_WIDTH-1:0];
            wr_bit   = cmd[CMD_WIDTH-1:ADDR_WIDTH];
            if(wr_bit == WRITE) begin
                $display("SPI WRITE[%h] : address = %h,write data = %h,read data = %h.",wr_bit,addr_bit,write_data,read_data);
            end
            else if(wr_bit == READ) begin
                $display("SPI READ[%h]  : address = %h,write data = %h,read data = %h.",wr_bit,addr_bit,write_data,read_data);
            end
            else begin
                $display("SPI ERROR : spi write and read define error!");
            end
        end
    endtask
     
endmodule    
//****************************************************************************************************
//End of Module
//****************************************************************************************************
