//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Thu Jul 27 19:14:58 2017
//Host        : khona5 running 64-bit Fedora release 26 (Twenty Six)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=12,numReposBlks=12,numNonXlnxBlks=4,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
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

  wire BTNC_1;
  wire [3:0]BinToBCD16_0_BCD0;
  wire [3:0]BinToBCD16_0_BCD1;
  wire [3:0]BinToBCD16_0_BCD2;
  wire [3:0]BinToBCD16_0_BCD3;
  wire [3:0]BinToBCD16_0_BCD4;
  wire [8:0]Count_Ones_0_data_out;
  wire Count_Ones_0_finish;
  wire [6:0]EightDisplayControl_0_segments;
  wire [7:0]EightDisplayControl_0_select_display;
  wire [3:0]Unroll_ROM_last_0_addr;
  wire [255:0]Unroll_ROM_last_0_data_out;
  wire [15:0]blk_mem_gen_0_doutb;
  wire clk_1;
  wire [15:0]xlconcat_0_dout;
  wire [9:0]xlconcat_1_dout;
  wire [6:0]xlconstant_0_dout;
  wire [3:0]xlconstant_1_dout;
  wire [0:0]xlconstant_2_dout;
  wire [15:0]xlconstant_3_dout;
  wire [0:0]xlconstant_4_dout;

  assign AN[7:0] = EightDisplayControl_0_select_display;
  assign BTNC_1 = BTNC;
  assign clk_1 = clk;
  assign led[9:0] = xlconcat_1_dout;
  assign seg[6:0] = EightDisplayControl_0_segments;
  design_1_BinToBCD16_0_0 BinToBCD16_0
       (.BCD0(BinToBCD16_0_BCD0),
        .BCD1(BinToBCD16_0_BCD1),
        .BCD2(BinToBCD16_0_BCD2),
        .BCD3(BinToBCD16_0_BCD3),
        .BCD4(BinToBCD16_0_BCD4),
        .binary(xlconcat_0_dout),
        .clk(clk_1),
        .request(xlconstant_4_dout),
        .reset(BTNC_1));
  design_1_Count_Ones_0_0 Count_Ones_0
       (.BTNC(BTNC_1),
        .clk(clk_1),
        .data_in(Unroll_ROM_last_0_data_out),
        .data_out(Count_Ones_0_data_out),
        .finish(Count_Ones_0_finish));
  design_1_EightDisplayControl_0_0 EightDisplayControl_0
       (.clk(clk_1),
        .leftL(xlconstant_1_dout),
        .leftR(BinToBCD16_0_BCD3),
        .near_leftL(xlconstant_1_dout),
        .near_leftR(BinToBCD16_0_BCD2),
        .near_rightL(xlconstant_1_dout),
        .near_rightR(BinToBCD16_0_BCD1),
        .rightL(BinToBCD16_0_BCD4),
        .rightR(BinToBCD16_0_BCD0),
        .segments(EightDisplayControl_0_segments),
        .select_display(EightDisplayControl_0_select_display));
  design_1_Unroll_ROM_last_0_0 Unroll_ROM_last_0
       (.addr(Unroll_ROM_last_0_addr),
        .clk(clk_1),
        .data_in(blk_mem_gen_0_doutb),
        .data_out(Unroll_ROM_last_0_data_out),
        .rst(BTNC_1));
  design_1_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(xlconstant_1_dout),
        .addrb(Unroll_ROM_last_0_addr),
        .clka(clk_1),
        .clkb(clk_1),
        .dina(xlconstant_3_dout),
        .doutb(blk_mem_gen_0_doutb),
        .wea(xlconstant_2_dout));
  design_1_xlconcat_0_0 xlconcat_0
       (.In0(Count_Ones_0_data_out),
        .In1(xlconstant_0_dout),
        .dout(xlconcat_0_dout));
  design_1_xlconcat_1_0 xlconcat_1
       (.In0(Count_Ones_0_finish),
        .In1(Count_Ones_0_data_out),
        .dout(xlconcat_1_dout));
  design_1_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  design_1_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
  design_1_xlconstant_2_0 xlconstant_2
       (.dout(xlconstant_2_dout));
  design_1_xlconstant_3_0 xlconstant_3
       (.dout(xlconstant_3_dout));
  design_1_xlconstant_4_0 xlconstant_4
       (.dout(xlconstant_4_dout));
endmodule
