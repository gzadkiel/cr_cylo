//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Thu Sep  3 10:41:01 2026
//Host        : Geronimo running 64-bit major release  (build 9200)
//Command     : generate_target comblock_setup_wrapper.bd
//Design      : comblock_setup_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module comblock_setup_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    IN_REGS_0_reg0_i,
    IN_REGS_0_reg1_i,
    IN_REGS_0_reg2_i,
    IN_REGS_0_reg3_i,
    IN_REGS_0_reg4_i,
    IN_REGS_0_reg5_i,
    OUT_FIFO_0_fifo_aempty_o,
    OUT_FIFO_0_fifo_data_o,
    OUT_FIFO_0_fifo_empty_o,
    OUT_FIFO_0_fifo_re_i,
    OUT_FIFO_0_fifo_underflow_o,
    OUT_FIFO_0_fifo_valid_o,
    OUT_REGS_0_reg0_o,
    OUT_REGS_0_reg1_o,
    PS_CLOCK0,
    fifo_clear_i_0,
    fifo_clk_i_0);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [31:0]IN_REGS_0_reg0_i;
  input [31:0]IN_REGS_0_reg1_i;
  input [31:0]IN_REGS_0_reg2_i;
  input [31:0]IN_REGS_0_reg3_i;
  input [31:0]IN_REGS_0_reg4_i;
  input [31:0]IN_REGS_0_reg5_i;
  output OUT_FIFO_0_fifo_aempty_o;
  output [23:0]OUT_FIFO_0_fifo_data_o;
  output OUT_FIFO_0_fifo_empty_o;
  input OUT_FIFO_0_fifo_re_i;
  output OUT_FIFO_0_fifo_underflow_o;
  output OUT_FIFO_0_fifo_valid_o;
  output [31:0]OUT_REGS_0_reg0_o;
  output [31:0]OUT_REGS_0_reg1_o;
  output PS_CLOCK0;
  input fifo_clear_i_0;
  input fifo_clk_i_0;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [31:0]IN_REGS_0_reg0_i;
  wire [31:0]IN_REGS_0_reg1_i;
  wire [31:0]IN_REGS_0_reg2_i;
  wire [31:0]IN_REGS_0_reg3_i;
  wire [31:0]IN_REGS_0_reg4_i;
  wire [31:0]IN_REGS_0_reg5_i;
  wire OUT_FIFO_0_fifo_aempty_o;
  wire [23:0]OUT_FIFO_0_fifo_data_o;
  wire OUT_FIFO_0_fifo_empty_o;
  wire OUT_FIFO_0_fifo_re_i;
  wire OUT_FIFO_0_fifo_underflow_o;
  wire OUT_FIFO_0_fifo_valid_o;
  wire [31:0]OUT_REGS_0_reg0_o;
  wire [31:0]OUT_REGS_0_reg1_o;
  wire PS_CLOCK0;
  wire fifo_clear_i_0;
  wire fifo_clk_i_0;

  comblock_setup comblock_setup_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .IN_REGS_0_reg0_i(IN_REGS_0_reg0_i),
        .IN_REGS_0_reg1_i(IN_REGS_0_reg1_i),
        .IN_REGS_0_reg2_i(IN_REGS_0_reg2_i),
        .IN_REGS_0_reg3_i(IN_REGS_0_reg3_i),
        .IN_REGS_0_reg4_i(IN_REGS_0_reg4_i),
        .IN_REGS_0_reg5_i(IN_REGS_0_reg5_i),
        .OUT_FIFO_0_fifo_aempty_o(OUT_FIFO_0_fifo_aempty_o),
        .OUT_FIFO_0_fifo_data_o(OUT_FIFO_0_fifo_data_o),
        .OUT_FIFO_0_fifo_empty_o(OUT_FIFO_0_fifo_empty_o),
        .OUT_FIFO_0_fifo_re_i(OUT_FIFO_0_fifo_re_i),
        .OUT_FIFO_0_fifo_underflow_o(OUT_FIFO_0_fifo_underflow_o),
        .OUT_FIFO_0_fifo_valid_o(OUT_FIFO_0_fifo_valid_o),
        .OUT_REGS_0_reg0_o(OUT_REGS_0_reg0_o),
        .OUT_REGS_0_reg1_o(OUT_REGS_0_reg1_o),
        .PS_CLOCK0(PS_CLOCK0),
        .fifo_clear_i_0(fifo_clear_i_0),
        .fifo_clk_i_0(fifo_clk_i_0));
endmodule
