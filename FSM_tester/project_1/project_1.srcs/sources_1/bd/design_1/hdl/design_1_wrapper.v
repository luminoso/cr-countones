//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Thu Jul 27 19:14:58 2017
//Host        : khona5 running 64-bit Fedora release 26 (Twenty Six)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (AN,
    BTNC,
    clk,
    led,
    seg);
  output [7:0]AN;
  input BTNC;
  input clk;
  output [9:0]led;
  output [6:0]seg;

  wire [7:0]AN;
  wire BTNC;
  wire clk;
  wire [9:0]led;
  wire [6:0]seg;

  design_1 design_1_i
       (.AN(AN),
        .BTNC(BTNC),
        .clk(clk),
        .led(led),
        .seg(seg));
endmodule
