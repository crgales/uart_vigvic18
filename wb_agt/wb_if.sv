`timescale 1ns/10ps
interface wb_if(input bit clk, input bit rst);
  /*parameter uart_data_width = 8;
  parameter uart_addr_width = 3; */
  logic [2:0] wb_addr_i;
  logic [7:0] wb_dat_i;
  logic [7:0]wb_dat_o;
  logic [3:0] wb_sel_i;
  logic wb_we_i;
  logic wb_stb_i;
  logic wb_cyc_i;
  logic wb_ack_o;
  logic wb_int_o;
  logic srx_pad_i;
  logic stx_pad_o;

  clocking wb_driv@(posedge clk);

    default input #1 output #1;
    
    input rst;
    output  wb_addr_i;
    output  wb_sel_i;
    output wb_dat_i;
    output wb_we_i;
    output wb_stb_i;
    output wb_cyc_i;
    input wb_ack_o;
  //  output wb_ack_o;  
    input wb_dat_o;
    input wb_int_o;
  
  endclocking

  clocking wb_mon@(posedge clk);
    
    default input #1 output #1;
    
    input rst;
    input wb_addr_i;
    input wb_sel_i;
    input wb_dat_i;
    input wb_we_i;
    input wb_stb_i;
    input wb_cyc_i;
    input wb_ack_o;
    input  wb_dat_o;
    input wb_int_o;
  endclocking
  
endinterface

