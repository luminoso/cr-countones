//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Sat May 20 16:19:51 2017
//Host        : khona5 running 64-bit Fedora release 25 (Twenty Five)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (AN,
    VGA_B,
    VGA_G,
    VGA_HS,
    VGA_R,
    VGA_VS,
    btnCpuReset,
    clk,
    led,
    seg);
  output [7:0]AN;
  output [3:0]VGA_B;
  output [3:0]VGA_G;
  output VGA_HS;
  output [3:0]VGA_R;
  output VGA_VS;
  input btnCpuReset;
  input clk;
  output [8:0]led;
  output [6:0]seg;

  wire [7:0]AN;
  wire [3:0]VGA_B;
  wire [3:0]VGA_G;
  wire VGA_HS;
  wire [3:0]VGA_R;
  wire VGA_VS;
  wire btnCpuReset;
  wire clk;
  wire [8:0]led;
  wire [6:0]seg;

  design_1 design_1_i
       (.AN(AN),
        .VGA_B(VGA_B),
        .VGA_G(VGA_G),
        .VGA_HS(VGA_HS),
        .VGA_R(VGA_R),
        .VGA_VS(VGA_VS),
        .btnCpuReset(btnCpuReset),
        .clk(clk),
        .led(led),
        .seg(seg));
endmodule
