// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Sep  3 10:42:01 2026
// Host        : Geronimo running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/gm/Vivado
//               Projects/complete_det_final_debug/complete_det_final_debug.gen/sources_1/bd/comblock_setup/ip/comblock_setup_comblock_0_0/comblock_setup_comblock_0_0_sim_netlist.v}
// Design      : comblock_setup_comblock_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "comblock_setup_comblock_0_0,axi_comblock,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "package_project" *) 
(* x_core_info = "axi_comblock,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module comblock_setup_comblock_0_0
   (reg0_i,
    reg1_i,
    reg2_i,
    reg3_i,
    reg4_i,
    reg5_i,
    reg0_o,
    reg1_o,
    fifo_clk_i,
    fifo_clear_i,
    fifo_re_i,
    fifo_data_o,
    fifo_valid_o,
    fifo_empty_o,
    fifo_aempty_o,
    fifo_underflow_o,
    axil_aclk,
    axil_aresetn,
    axil_awaddr,
    axil_awprot,
    axil_awvalid,
    axil_awready,
    axil_wdata,
    axil_wstrb,
    axil_wvalid,
    axil_wready,
    axil_bresp,
    axil_bvalid,
    axil_bready,
    axil_araddr,
    axil_arprot,
    axil_arvalid,
    axil_arready,
    axil_rdata,
    axil_rresp,
    axil_rvalid,
    axil_rready);
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg0_i" *) input [31:0]reg0_i;
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg1_i" *) input [31:0]reg1_i;
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg2_i" *) input [31:0]reg2_i;
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg3_i" *) input [31:0]reg3_i;
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg4_i" *) input [31:0]reg4_i;
  (* x_interface_info = "ictp:user:IREGS:1.0 IN_REGS reg5_i" *) input [31:0]reg5_i;
  (* x_interface_info = "ictp:user:OREGS:1.0 OUT_REGS reg0_o" *) output [31:0]reg0_o;
  (* x_interface_info = "ictp:user:OREGS:1.0 OUT_REGS reg1_o" *) output [31:0]reg1_o;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 fifo_clk_i CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME fifo_clk_i, ASSOCIATED_BUSIF IN_FIFO:OUT_FIFO, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN comblock_setup_fifo_clk_i_0, INSERT_VIP 0" *) input fifo_clk_i;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 fifo_clear_i RST" *) (* x_interface_parameter = "XIL_INTERFACENAME fifo_clear_i, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input fifo_clear_i;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_re_i" *) input fifo_re_i;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_data_o" *) output [23:0]fifo_data_o;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_valid_o" *) output fifo_valid_o;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_empty_o" *) output fifo_empty_o;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_aempty_o" *) output fifo_aempty_o;
  (* x_interface_info = "ictp:user:OFIFO:1.0 OUT_FIFO fifo_underflow_o" *) output fifo_underflow_o;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 axil_aclk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME axil_aclk, ASSOCIATED_RESET axil_aresetn, ASSOCIATED_BUSIF AXIL, FREQ_HZ 4e+07, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN comblock_setup_processing_system7_0_1_FCLK_CLK0, INSERT_VIP 0" *) input axil_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 axil_aresetn RST" *) (* x_interface_parameter = "XIL_INTERFACENAME axil_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axil_aresetn;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME AXIL, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 4e+07, ID_WIDTH 0, ADDR_WIDTH 8, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN comblock_setup_processing_system7_0_1_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [7:0]axil_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL AWPROT" *) input [2:0]axil_awprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL AWVALID" *) input axil_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL AWREADY" *) output axil_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL WDATA" *) input [31:0]axil_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL WSTRB" *) input [3:0]axil_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL WVALID" *) input axil_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL WREADY" *) output axil_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL BRESP" *) output [1:0]axil_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL BVALID" *) output axil_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL BREADY" *) input axil_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL ARADDR" *) input [7:0]axil_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL ARPROT" *) input [2:0]axil_arprot;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL ARVALID" *) input axil_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL ARREADY" *) output axil_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL RDATA" *) output [31:0]axil_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL RRESP" *) output [1:0]axil_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL RVALID" *) output axil_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 AXIL RREADY" *) input axil_rready;

  wire \<const0> ;
  wire axil_aclk;
  wire [7:0]axil_araddr;
  wire axil_aresetn;
  wire axil_arready;
  wire axil_arvalid;
  wire [7:0]axil_awaddr;
  wire axil_awready;
  wire axil_awvalid;
  wire axil_bready;
  wire axil_bvalid;
  wire [31:0]axil_rdata;
  wire axil_rready;
  wire axil_rvalid;
  wire [31:0]axil_wdata;
  wire axil_wready;
  wire axil_wvalid;
  wire fifo_aempty_o;
  wire fifo_clear_i;
  wire fifo_clk_i;
  wire [23:0]fifo_data_o;
  wire fifo_empty_o;
  wire fifo_re_i;
  wire fifo_underflow_o;
  wire fifo_valid_o;
  wire [31:0]reg0_i;
  wire [31:0]reg0_o;
  wire [31:0]reg1_i;
  wire [31:0]reg1_o;
  wire [31:0]reg2_i;
  wire [31:0]reg3_i;
  wire [31:0]reg4_i;
  wire [31:0]reg5_i;

  assign axil_bresp[1] = \<const0> ;
  assign axil_bresp[0] = \<const0> ;
  assign axil_rresp[1] = \<const0> ;
  assign axil_rresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  comblock_setup_comblock_0_0_axi_comblock U0
       (.axi_rvalid_reg(axil_rvalid),
        .axil_aclk(axil_aclk),
        .axil_araddr(axil_araddr[7:2]),
        .axil_aresetn(axil_aresetn),
        .axil_arready(axil_arready),
        .axil_arvalid(axil_arvalid),
        .axil_awaddr(axil_awaddr[7:2]),
        .axil_awready(axil_awready),
        .axil_awvalid(axil_awvalid),
        .axil_bready(axil_bready),
        .axil_bvalid(axil_bvalid),
        .axil_rdata(axil_rdata),
        .axil_rready(axil_rready),
        .axil_wdata(axil_wdata),
        .axil_wready(axil_wready),
        .axil_wvalid(axil_wvalid),
        .fifo_aempty_o(fifo_aempty_o),
        .fifo_clear_i(fifo_clear_i),
        .fifo_clk_i(fifo_clk_i),
        .fifo_data_o(fifo_data_o),
        .fifo_empty_o(fifo_empty_o),
        .fifo_re_i(fifo_re_i),
        .fifo_underflow_o(fifo_underflow_o),
        .fifo_valid_o(fifo_valid_o),
        .reg0_i(reg0_i),
        .reg0_o(reg0_o),
        .reg1_i(reg1_i),
        .reg1_o(reg1_o),
        .reg2_i(reg2_i),
        .reg3_i(reg3_i),
        .reg4_i(reg4_i),
        .reg5_i(reg5_i));
endmodule

(* ORIG_REF_NAME = "AXIL" *) 
module comblock_setup_comblock_0_0_AXIL
   (axil_awready,
    axil_wready,
    axil_arready,
    axil_bvalid,
    axi_rvalid_reg_0,
    \axi_awaddr_reg[7]_0 ,
    E,
    \axi_awaddr_reg[6]_0 ,
    \axi_awaddr_reg[2]_0 ,
    p_4_in,
    fifo_out_we,
    fifo_out_over_r0_out,
    axil_rdata,
    axil_aclk,
    axil_awvalid,
    axil_wvalid,
    ret15_out,
    full_r,
    \axi_rdata_reg[0]_0 ,
    \axi_rdata_reg[0]_1 ,
    \axi_rdata_reg[0]_2 ,
    O,
    \axi_rdata_reg[1]_0 ,
    \axi_rdata_reg[1]_1 ,
    fifo_out_over_r,
    reg0_o,
    reg1_o,
    \axi_rdata_reg[19]_0 ,
    \axi_rdata_reg[23]_0 ,
    reg5_i,
    reg4_i,
    reg1_i,
    reg3_i,
    reg0_i,
    reg2_i,
    axil_aresetn,
    axil_bready,
    axil_arvalid,
    axil_rready,
    axil_awaddr,
    axil_araddr);
  output axil_awready;
  output axil_wready;
  output axil_arready;
  output axil_bvalid;
  output axi_rvalid_reg_0;
  output \axi_awaddr_reg[7]_0 ;
  output [0:0]E;
  output [0:0]\axi_awaddr_reg[6]_0 ;
  output \axi_awaddr_reg[2]_0 ;
  output p_4_in;
  output fifo_out_we;
  output fifo_out_over_r0_out;
  output [31:0]axil_rdata;
  input axil_aclk;
  input axil_awvalid;
  input axil_wvalid;
  input ret15_out;
  input full_r;
  input \axi_rdata_reg[0]_0 ;
  input \axi_rdata_reg[0]_1 ;
  input \axi_rdata_reg[0]_2 ;
  input [2:0]O;
  input \axi_rdata_reg[1]_0 ;
  input \axi_rdata_reg[1]_1 ;
  input fifo_out_over_r;
  input [31:0]reg0_o;
  input [31:0]reg1_o;
  input [3:0]\axi_rdata_reg[19]_0 ;
  input [3:0]\axi_rdata_reg[23]_0 ;
  input [31:0]reg5_i;
  input [31:0]reg4_i;
  input [31:0]reg1_i;
  input [31:0]reg3_i;
  input [31:0]reg0_i;
  input [31:0]reg2_i;
  input axil_aresetn;
  input axil_bready;
  input axil_arvalid;
  input axil_rready;
  input [5:0]axil_awaddr;
  input [5:0]axil_araddr;

  wire [0:0]E;
  wire [2:0]O;
  wire aw_en_i_1_n_0;
  wire aw_en_reg_n_0;
  wire axi_arready0;
  wire \axi_awaddr_reg[2]_0 ;
  wire [0:0]\axi_awaddr_reg[6]_0 ;
  wire \axi_awaddr_reg[7]_0 ;
  wire axi_awready0;
  wire axi_awready_i_1_n_0;
  wire axi_bvalid_i_1_n_0;
  wire \axi_rdata[0]_i_2_n_0 ;
  wire \axi_rdata[0]_i_5_n_0 ;
  wire \axi_rdata[0]_i_6_n_0 ;
  wire \axi_rdata[0]_i_7_n_0 ;
  wire \axi_rdata[10]_i_2_n_0 ;
  wire \axi_rdata[10]_i_3_n_0 ;
  wire \axi_rdata[11]_i_2_n_0 ;
  wire \axi_rdata[11]_i_3_n_0 ;
  wire \axi_rdata[12]_i_2_n_0 ;
  wire \axi_rdata[12]_i_3_n_0 ;
  wire \axi_rdata[13]_i_2_n_0 ;
  wire \axi_rdata[13]_i_3_n_0 ;
  wire \axi_rdata[14]_i_2_n_0 ;
  wire \axi_rdata[14]_i_3_n_0 ;
  wire \axi_rdata[15]_i_2_n_0 ;
  wire \axi_rdata[15]_i_3_n_0 ;
  wire \axi_rdata[16]_i_2_n_0 ;
  wire \axi_rdata[16]_i_4_n_0 ;
  wire \axi_rdata[17]_i_2_n_0 ;
  wire \axi_rdata[17]_i_4_n_0 ;
  wire \axi_rdata[18]_i_2_n_0 ;
  wire \axi_rdata[18]_i_4_n_0 ;
  wire \axi_rdata[19]_i_2_n_0 ;
  wire \axi_rdata[19]_i_4_n_0 ;
  wire \axi_rdata[1]_i_2_n_0 ;
  wire \axi_rdata[1]_i_6_n_0 ;
  wire \axi_rdata[1]_i_7_n_0 ;
  wire \axi_rdata[1]_i_8_n_0 ;
  wire \axi_rdata[20]_i_2_n_0 ;
  wire \axi_rdata[20]_i_4_n_0 ;
  wire \axi_rdata[21]_i_2_n_0 ;
  wire \axi_rdata[21]_i_4_n_0 ;
  wire \axi_rdata[22]_i_2_n_0 ;
  wire \axi_rdata[22]_i_4_n_0 ;
  wire \axi_rdata[23]_i_2_n_0 ;
  wire \axi_rdata[23]_i_4_n_0 ;
  wire \axi_rdata[24]_i_2_n_0 ;
  wire \axi_rdata[24]_i_4_n_0 ;
  wire \axi_rdata[25]_i_2_n_0 ;
  wire \axi_rdata[25]_i_4_n_0 ;
  wire \axi_rdata[26]_i_3_n_0 ;
  wire \axi_rdata[26]_i_5_n_0 ;
  wire \axi_rdata[26]_i_6_n_0 ;
  wire \axi_rdata[26]_i_7_n_0 ;
  wire \axi_rdata[26]_i_8_n_0 ;
  wire \axi_rdata[27]_i_2_n_0 ;
  wire \axi_rdata[27]_i_3_n_0 ;
  wire \axi_rdata[28]_i_2_n_0 ;
  wire \axi_rdata[28]_i_3_n_0 ;
  wire \axi_rdata[29]_i_2_n_0 ;
  wire \axi_rdata[29]_i_3_n_0 ;
  wire \axi_rdata[2]_i_2_n_0 ;
  wire \axi_rdata[2]_i_4_n_0 ;
  wire \axi_rdata[30]_i_2_n_0 ;
  wire \axi_rdata[30]_i_3_n_0 ;
  wire \axi_rdata[31]_i_1_n_0 ;
  wire \axi_rdata[31]_i_3_n_0 ;
  wire \axi_rdata[31]_i_4_n_0 ;
  wire \axi_rdata[31]_i_5_n_0 ;
  wire \axi_rdata[31]_i_6_n_0 ;
  wire \axi_rdata[3]_i_2_n_0 ;
  wire \axi_rdata[3]_i_3_n_0 ;
  wire \axi_rdata[4]_i_2_n_0 ;
  wire \axi_rdata[4]_i_3_n_0 ;
  wire \axi_rdata[5]_i_2_n_0 ;
  wire \axi_rdata[5]_i_3_n_0 ;
  wire \axi_rdata[6]_i_2_n_0 ;
  wire \axi_rdata[6]_i_3_n_0 ;
  wire \axi_rdata[7]_i_2_n_0 ;
  wire \axi_rdata[7]_i_3_n_0 ;
  wire \axi_rdata[8]_i_2_n_0 ;
  wire \axi_rdata[8]_i_3_n_0 ;
  wire \axi_rdata[9]_i_2_n_0 ;
  wire \axi_rdata[9]_i_3_n_0 ;
  wire \axi_rdata_reg[0]_0 ;
  wire \axi_rdata_reg[0]_1 ;
  wire \axi_rdata_reg[0]_2 ;
  wire [3:0]\axi_rdata_reg[19]_0 ;
  wire \axi_rdata_reg[1]_0 ;
  wire \axi_rdata_reg[1]_1 ;
  wire [3:0]\axi_rdata_reg[23]_0 ;
  wire axi_rvalid_i_1_n_0;
  wire axi_rvalid_reg_0;
  wire axi_wready0;
  wire axil_aclk;
  wire [5:0]axil_araddr;
  wire axil_aresetn;
  wire axil_arready;
  wire axil_arvalid;
  wire [5:0]axil_awaddr;
  wire axil_awready;
  wire axil_awvalid;
  wire axil_bready;
  wire axil_bvalid;
  wire [31:0]axil_rdata;
  wire axil_rready;
  wire axil_wready;
  wire axil_wvalid;
  wire \comblock_i/reg_rd_data_o19_out ;
  wire [26:0]\comblock_i/regs_in[0]__159 ;
  wire fifo_out_over_r;
  wire fifo_out_over_r0_out;
  wire fifo_out_over_r_i_4_n_0;
  wire fifo_out_we;
  wire full_r;
  wire p_4_in;
  wire [31:0]reg0_i;
  wire [31:0]reg0_o;
  wire [31:0]reg1_i;
  wire [31:0]reg1_o;
  wire [31:0]reg2_i;
  wire [31:0]reg3_i;
  wire [31:0]reg4_i;
  wire [31:0]reg5_i;
  wire [7:2]reg_rd_adr;
  wire [31:0]reg_rd_dat;
  wire reg_rd_ena;
  wire [7:2]reg_wr_adr;
  wire \regs_out[0][31]_i_2_n_0 ;
  wire ret15_out;
  wire slv_reg_rden;

  LUT6 #(
    .INIT(64'hBFFFBF00BF00BF00)) 
    aw_en_i_1
       (.I0(axil_awready),
        .I1(axil_wvalid),
        .I2(axil_awvalid),
        .I3(aw_en_reg_n_0),
        .I4(axil_bready),
        .I5(axil_bvalid),
        .O(aw_en_i_1_n_0));
  FDSE aw_en_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(aw_en_i_1_n_0),
        .Q(aw_en_reg_n_0),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[2] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[0]),
        .Q(reg_rd_adr[2]),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[3] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[1]),
        .Q(reg_rd_adr[3]),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[4] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[2]),
        .Q(reg_rd_adr[4]),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[5] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[3]),
        .Q(reg_rd_adr[5]),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[6] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[4]),
        .Q(reg_rd_adr[6]),
        .S(axi_awready_i_1_n_0));
  FDSE \axi_araddr_reg[7] 
       (.C(axil_aclk),
        .CE(axi_arready0),
        .D(axil_araddr[5]),
        .Q(reg_rd_adr[7]),
        .S(axi_awready_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    axi_arready_i_1
       (.I0(axil_arvalid),
        .I1(axil_arready),
        .O(axi_arready0));
  FDRE axi_arready_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(axi_arready0),
        .Q(axil_arready),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[2] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[0]),
        .Q(reg_wr_adr[2]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[3] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[1]),
        .Q(reg_wr_adr[3]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[4] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[2]),
        .Q(reg_wr_adr[4]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[5] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[3]),
        .Q(reg_wr_adr[5]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[6] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[4]),
        .Q(reg_wr_adr[6]),
        .R(axi_awready_i_1_n_0));
  FDRE \axi_awaddr_reg[7] 
       (.C(axil_aclk),
        .CE(axi_awready0),
        .D(axil_awaddr[5]),
        .Q(reg_wr_adr[7]),
        .R(axi_awready_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    axi_awready_i_1
       (.I0(axil_aresetn),
        .O(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0080)) 
    axi_awready_i_2
       (.I0(aw_en_reg_n_0),
        .I1(axil_awvalid),
        .I2(axil_wvalid),
        .I3(axil_awready),
        .O(axi_awready0));
  FDRE axi_awready_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(axi_awready0),
        .Q(axil_awready),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000FFFF80008000)) 
    axi_bvalid_i_1
       (.I0(axil_wvalid),
        .I1(axil_awvalid),
        .I2(axil_wready),
        .I3(axil_awready),
        .I4(axil_bready),
        .I5(axil_bvalid),
        .O(axi_bvalid_i_1_n_0));
  FDRE axi_bvalid_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(axi_bvalid_i_1_n_0),
        .Q(axil_bvalid),
        .R(axi_awready_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    \axi_rdata[0]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[0]_0 ),
        .I2(\axi_rdata_reg[0]_1 ),
        .I3(\axi_rdata_reg[0]_2 ),
        .I4(\axi_rdata[0]_i_5_n_0 ),
        .I5(\axi_rdata[0]_i_6_n_0 ),
        .O(\axi_rdata[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[0]_i_3 
       (.I0(\axi_rdata[0]_i_7_n_0 ),
        .I1(reg4_i[0]),
        .I2(reg5_i[0]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \axi_rdata[0]_i_5 
       (.I0(\axi_rdata[26]_i_6_n_0 ),
        .I1(reg0_o[0]),
        .O(\axi_rdata[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \axi_rdata[0]_i_6 
       (.I0(\axi_rdata[26]_i_7_n_0 ),
        .I1(reg1_o[0]),
        .O(\axi_rdata[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[0]_i_7 
       (.I0(reg1_i[0]),
        .I1(reg3_i[0]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[0]),
        .I5(reg2_i[0]),
        .O(\axi_rdata[0]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[10]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[10]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[10]),
        .I4(\axi_rdata[10]_i_2_n_0 ),
        .O(reg_rd_dat[10]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[10]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[10]),
        .I3(reg4_i[10]),
        .I4(\axi_rdata[10]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[10]_i_3 
       (.I0(reg1_i[10]),
        .I1(reg3_i[10]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[10]),
        .I5(reg2_i[10]),
        .O(\axi_rdata[10]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[11]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[11]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[11]),
        .I4(\axi_rdata[11]_i_2_n_0 ),
        .O(reg_rd_dat[11]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[11]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[11]),
        .I3(reg4_i[11]),
        .I4(\axi_rdata[11]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[11]_i_3 
       (.I0(reg1_i[11]),
        .I1(reg3_i[11]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[11]),
        .I5(reg2_i[11]),
        .O(\axi_rdata[11]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[12]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[12]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[12]),
        .I4(\axi_rdata[12]_i_2_n_0 ),
        .O(reg_rd_dat[12]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[12]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[12]),
        .I3(reg4_i[12]),
        .I4(\axi_rdata[12]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[12]_i_3 
       (.I0(reg1_i[12]),
        .I1(reg3_i[12]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[12]),
        .I5(reg2_i[12]),
        .O(\axi_rdata[12]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[13]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[13]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[13]),
        .I4(\axi_rdata[13]_i_2_n_0 ),
        .O(reg_rd_dat[13]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[13]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[13]),
        .I3(reg4_i[13]),
        .I4(\axi_rdata[13]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[13]_i_3 
       (.I0(reg1_i[13]),
        .I1(reg3_i[13]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[13]),
        .I5(reg2_i[13]),
        .O(\axi_rdata[13]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[14]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[14]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[14]),
        .I4(\axi_rdata[14]_i_2_n_0 ),
        .O(reg_rd_dat[14]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[14]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[14]),
        .I3(reg4_i[14]),
        .I4(\axi_rdata[14]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[14]_i_3 
       (.I0(reg1_i[14]),
        .I1(reg3_i[14]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[14]),
        .I5(reg2_i[14]),
        .O(\axi_rdata[14]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[15]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[15]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[15]),
        .I4(\axi_rdata[15]_i_2_n_0 ),
        .O(reg_rd_dat[15]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[15]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[15]),
        .I3(reg4_i[15]),
        .I4(\axi_rdata[15]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[15]_i_3 
       (.I0(reg1_i[15]),
        .I1(reg3_i[15]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[15]),
        .I5(reg2_i[15]),
        .O(\axi_rdata[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[16]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[19]_0 [0]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[16]),
        .I4(reg1_o[16]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[16]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[16]_i_3 
       (.I0(\axi_rdata[16]_i_4_n_0 ),
        .I1(reg4_i[16]),
        .I2(reg5_i[16]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [16]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[16]_i_4 
       (.I0(reg1_i[16]),
        .I1(reg3_i[16]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[16]),
        .I5(reg2_i[16]),
        .O(\axi_rdata[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[17]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[19]_0 [1]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[17]),
        .I4(reg1_o[17]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[17]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[17]_i_3 
       (.I0(\axi_rdata[17]_i_4_n_0 ),
        .I1(reg4_i[17]),
        .I2(reg5_i[17]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [17]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[17]_i_4 
       (.I0(reg1_i[17]),
        .I1(reg3_i[17]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[17]),
        .I5(reg2_i[17]),
        .O(\axi_rdata[17]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[18]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[19]_0 [2]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[18]),
        .I4(reg1_o[18]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[18]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[18]_i_3 
       (.I0(\axi_rdata[18]_i_4_n_0 ),
        .I1(reg4_i[18]),
        .I2(reg5_i[18]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [18]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[18]_i_4 
       (.I0(reg1_i[18]),
        .I1(reg3_i[18]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[18]),
        .I5(reg2_i[18]),
        .O(\axi_rdata[18]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[19]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[19]_0 [3]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[19]),
        .I4(reg1_o[19]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[19]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[19]_i_3 
       (.I0(\axi_rdata[19]_i_4_n_0 ),
        .I1(reg4_i[19]),
        .I2(reg5_i[19]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [19]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[19]_i_4 
       (.I0(reg1_i[19]),
        .I1(reg3_i[19]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[19]),
        .I5(reg2_i[19]),
        .O(\axi_rdata[19]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFA888)) 
    \axi_rdata[1]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(O[2]),
        .I2(\axi_rdata_reg[1]_0 ),
        .I3(\axi_rdata_reg[1]_1 ),
        .I4(\axi_rdata[1]_i_6_n_0 ),
        .I5(\axi_rdata[1]_i_7_n_0 ),
        .O(\axi_rdata[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[1]_i_3 
       (.I0(\axi_rdata[1]_i_8_n_0 ),
        .I1(reg4_i[1]),
        .I2(reg5_i[1]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \axi_rdata[1]_i_6 
       (.I0(\axi_rdata[26]_i_6_n_0 ),
        .I1(reg0_o[1]),
        .O(\axi_rdata[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \axi_rdata[1]_i_7 
       (.I0(\axi_rdata[26]_i_7_n_0 ),
        .I1(reg1_o[1]),
        .O(\axi_rdata[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[1]_i_8 
       (.I0(reg1_i[1]),
        .I1(reg3_i[1]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[1]),
        .I5(reg2_i[1]),
        .O(\axi_rdata[1]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[20]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[23]_0 [0]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[20]),
        .I4(reg1_o[20]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[20]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[20]_i_3 
       (.I0(\axi_rdata[20]_i_4_n_0 ),
        .I1(reg4_i[20]),
        .I2(reg5_i[20]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [20]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[20]_i_4 
       (.I0(reg1_i[20]),
        .I1(reg3_i[20]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[20]),
        .I5(reg2_i[20]),
        .O(\axi_rdata[20]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[21]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[23]_0 [1]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[21]),
        .I4(reg1_o[21]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[21]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[21]_i_3 
       (.I0(\axi_rdata[21]_i_4_n_0 ),
        .I1(reg4_i[21]),
        .I2(reg5_i[21]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [21]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[21]_i_4 
       (.I0(reg1_i[21]),
        .I1(reg3_i[21]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[21]),
        .I5(reg2_i[21]),
        .O(\axi_rdata[21]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[22]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[23]_0 [2]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[22]),
        .I4(reg1_o[22]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[22]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[22]_i_3 
       (.I0(\axi_rdata[22]_i_4_n_0 ),
        .I1(reg4_i[22]),
        .I2(reg5_i[22]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [22]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[22]_i_4 
       (.I0(reg1_i[22]),
        .I1(reg3_i[22]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[22]),
        .I5(reg2_i[22]),
        .O(\axi_rdata[22]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[23]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(\axi_rdata_reg[23]_0 [3]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[23]),
        .I4(reg1_o[23]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[23]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[23]_i_3 
       (.I0(\axi_rdata[23]_i_4_n_0 ),
        .I1(reg4_i[23]),
        .I2(reg5_i[23]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [23]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[23]_i_4 
       (.I0(reg1_i[23]),
        .I1(reg3_i[23]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[23]),
        .I5(reg2_i[23]),
        .O(\axi_rdata[23]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[24]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(O[0]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[24]),
        .I4(reg1_o[24]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[24]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[24]_i_3 
       (.I0(\axi_rdata[24]_i_4_n_0 ),
        .I1(reg4_i[24]),
        .I2(reg5_i[24]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [24]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[24]_i_4 
       (.I0(reg1_i[24]),
        .I1(reg3_i[24]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[24]),
        .I5(reg2_i[24]),
        .O(\axi_rdata[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[25]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(O[1]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[25]),
        .I4(reg1_o[25]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[25]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[25]_i_3 
       (.I0(\axi_rdata[25]_i_4_n_0 ),
        .I1(reg4_i[25]),
        .I2(reg5_i[25]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [25]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[25]_i_4 
       (.I0(reg1_i[25]),
        .I1(reg3_i[25]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[25]),
        .I5(reg2_i[25]),
        .O(\axi_rdata[25]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00010101)) 
    \axi_rdata[26]_i_2 
       (.I0(reg_rd_adr[5]),
        .I1(reg_rd_adr[6]),
        .I2(reg_rd_adr[7]),
        .I3(reg_rd_adr[4]),
        .I4(reg_rd_adr[3]),
        .O(\comblock_i/reg_rd_data_o19_out ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[26]_i_3 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(O[2]),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[26]),
        .I4(reg1_o[26]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[26]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[26]_i_4 
       (.I0(\axi_rdata[26]_i_8_n_0 ),
        .I1(reg4_i[26]),
        .I2(reg5_i[26]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [26]));
  LUT6 #(
    .INIT(64'h0000040000000000)) 
    \axi_rdata[26]_i_5 
       (.I0(reg_rd_adr[2]),
        .I1(reg_rd_adr[3]),
        .I2(reg_rd_adr[5]),
        .I3(reg_rd_adr[7]),
        .I4(reg_rd_adr[6]),
        .I5(reg_rd_adr[4]),
        .O(\axi_rdata[26]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \axi_rdata[26]_i_6 
       (.I0(reg_rd_adr[6]),
        .I1(reg_rd_adr[7]),
        .I2(reg_rd_adr[5]),
        .I3(reg_rd_adr[4]),
        .I4(reg_rd_adr[3]),
        .I5(reg_rd_adr[2]),
        .O(\axi_rdata[26]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \axi_rdata[26]_i_7 
       (.I0(reg_rd_adr[6]),
        .I1(reg_rd_adr[7]),
        .I2(reg_rd_adr[5]),
        .I3(reg_rd_adr[4]),
        .I4(reg_rd_adr[3]),
        .I5(reg_rd_adr[2]),
        .O(\axi_rdata[26]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[26]_i_8 
       (.I0(reg1_i[26]),
        .I1(reg3_i[26]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[26]),
        .I5(reg2_i[26]),
        .O(\axi_rdata[26]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[27]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[27]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[27]),
        .I4(\axi_rdata[27]_i_2_n_0 ),
        .O(reg_rd_dat[27]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[27]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[27]),
        .I3(reg4_i[27]),
        .I4(\axi_rdata[27]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[27]_i_3 
       (.I0(reg1_i[27]),
        .I1(reg3_i[27]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[27]),
        .I5(reg2_i[27]),
        .O(\axi_rdata[27]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[28]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[28]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[28]),
        .I4(\axi_rdata[28]_i_2_n_0 ),
        .O(reg_rd_dat[28]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[28]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[28]),
        .I3(reg4_i[28]),
        .I4(\axi_rdata[28]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[28]_i_3 
       (.I0(reg1_i[28]),
        .I1(reg3_i[28]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[28]),
        .I5(reg2_i[28]),
        .O(\axi_rdata[28]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[29]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[29]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[29]),
        .I4(\axi_rdata[29]_i_2_n_0 ),
        .O(reg_rd_dat[29]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[29]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[29]),
        .I3(reg4_i[29]),
        .I4(\axi_rdata[29]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[29]_i_3 
       (.I0(reg1_i[29]),
        .I1(reg3_i[29]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[29]),
        .I5(reg2_i[29]),
        .O(\axi_rdata[29]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
    \axi_rdata[2]_i_2 
       (.I0(\axi_rdata[26]_i_5_n_0 ),
        .I1(fifo_out_over_r),
        .I2(\axi_rdata[26]_i_6_n_0 ),
        .I3(reg0_o[2]),
        .I4(reg1_o[2]),
        .I5(\axi_rdata[26]_i_7_n_0 ),
        .O(\axi_rdata[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0CCAAAA)) 
    \axi_rdata[2]_i_3 
       (.I0(\axi_rdata[2]_i_4_n_0 ),
        .I1(reg4_i[2]),
        .I2(reg5_i[2]),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[4]),
        .O(\comblock_i/regs_in[0]__159 [2]));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[2]_i_4 
       (.I0(reg1_i[2]),
        .I1(reg3_i[2]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[2]),
        .I5(reg2_i[2]),
        .O(\axi_rdata[2]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[30]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[30]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[30]),
        .I4(\axi_rdata[30]_i_2_n_0 ),
        .O(reg_rd_dat[30]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[30]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[30]),
        .I3(reg4_i[30]),
        .I4(\axi_rdata[30]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[30]_i_3 
       (.I0(reg1_i[30]),
        .I1(reg3_i[30]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[30]),
        .I5(reg2_i[30]),
        .O(\axi_rdata[30]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \axi_rdata[31]_i_1 
       (.I0(axi_rvalid_reg_0),
        .I1(axil_arvalid),
        .I2(axil_arready),
        .O(\axi_rdata[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[31]_i_2 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[31]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[31]),
        .I4(\axi_rdata[31]_i_5_n_0 ),
        .O(reg_rd_dat[31]));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \axi_rdata[31]_i_3 
       (.I0(reg_rd_adr[5]),
        .I1(reg_rd_adr[6]),
        .I2(reg_rd_adr[7]),
        .I3(reg_rd_adr[4]),
        .I4(reg_rd_adr[3]),
        .I5(reg_rd_adr[2]),
        .O(\axi_rdata[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \axi_rdata[31]_i_4 
       (.I0(reg_rd_adr[5]),
        .I1(reg_rd_adr[6]),
        .I2(reg_rd_adr[7]),
        .I3(reg_rd_adr[4]),
        .I4(reg_rd_adr[3]),
        .I5(reg_rd_adr[2]),
        .O(\axi_rdata[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[31]_i_5 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[31]),
        .I3(reg4_i[31]),
        .I4(\axi_rdata[31]_i_6_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[31]_i_6 
       (.I0(reg1_i[31]),
        .I1(reg3_i[31]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[31]),
        .I5(reg2_i[31]),
        .O(\axi_rdata[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[3]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[3]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[3]),
        .I4(\axi_rdata[3]_i_2_n_0 ),
        .O(reg_rd_dat[3]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[3]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[3]),
        .I3(reg4_i[3]),
        .I4(\axi_rdata[3]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[3]_i_3 
       (.I0(reg1_i[3]),
        .I1(reg3_i[3]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[3]),
        .I5(reg2_i[3]),
        .O(\axi_rdata[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[4]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[4]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[4]),
        .I4(\axi_rdata[4]_i_2_n_0 ),
        .O(reg_rd_dat[4]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[4]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[4]),
        .I3(reg4_i[4]),
        .I4(\axi_rdata[4]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[4]_i_3 
       (.I0(reg1_i[4]),
        .I1(reg3_i[4]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[4]),
        .I5(reg2_i[4]),
        .O(\axi_rdata[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[5]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[5]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[5]),
        .I4(\axi_rdata[5]_i_2_n_0 ),
        .O(reg_rd_dat[5]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[5]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[5]),
        .I3(reg4_i[5]),
        .I4(\axi_rdata[5]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[5]_i_3 
       (.I0(reg1_i[5]),
        .I1(reg3_i[5]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[5]),
        .I5(reg2_i[5]),
        .O(\axi_rdata[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[6]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[6]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[6]),
        .I4(\axi_rdata[6]_i_2_n_0 ),
        .O(reg_rd_dat[6]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[6]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[6]),
        .I3(reg4_i[6]),
        .I4(\axi_rdata[6]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[6]_i_3 
       (.I0(reg1_i[6]),
        .I1(reg3_i[6]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[6]),
        .I5(reg2_i[6]),
        .O(\axi_rdata[6]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[7]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[7]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[7]),
        .I4(\axi_rdata[7]_i_2_n_0 ),
        .O(reg_rd_dat[7]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[7]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[7]),
        .I3(reg4_i[7]),
        .I4(\axi_rdata[7]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[7]_i_3 
       (.I0(reg1_i[7]),
        .I1(reg3_i[7]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[7]),
        .I5(reg2_i[7]),
        .O(\axi_rdata[7]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[8]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[8]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[8]),
        .I4(\axi_rdata[8]_i_2_n_0 ),
        .O(reg_rd_dat[8]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[8]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[8]),
        .I3(reg4_i[8]),
        .I4(\axi_rdata[8]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[8]_i_3 
       (.I0(reg1_i[8]),
        .I1(reg3_i[8]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[8]),
        .I5(reg2_i[8]),
        .O(\axi_rdata[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF888)) 
    \axi_rdata[9]_i_1 
       (.I0(\axi_rdata[31]_i_3_n_0 ),
        .I1(reg0_o[9]),
        .I2(\axi_rdata[31]_i_4_n_0 ),
        .I3(reg1_o[9]),
        .I4(\axi_rdata[9]_i_2_n_0 ),
        .O(reg_rd_dat[9]));
  LUT6 #(
    .INIT(64'hF7D5A28000000000)) 
    \axi_rdata[9]_i_2 
       (.I0(reg_rd_adr[4]),
        .I1(reg_rd_adr[2]),
        .I2(reg5_i[9]),
        .I3(reg4_i[9]),
        .I4(\axi_rdata[9]_i_3_n_0 ),
        .I5(\comblock_i/reg_rd_data_o19_out ),
        .O(\axi_rdata[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \axi_rdata[9]_i_3 
       (.I0(reg1_i[9]),
        .I1(reg3_i[9]),
        .I2(reg_rd_adr[3]),
        .I3(reg_rd_adr[2]),
        .I4(reg0_i[9]),
        .I5(reg2_i[9]),
        .O(\axi_rdata[9]_i_3_n_0 ));
  FDRE \axi_rdata_reg[0] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[0]),
        .Q(axil_rdata[0]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[0]_i_1 
       (.I0(\axi_rdata[0]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [0]),
        .O(reg_rd_dat[0]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[10] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[10]),
        .Q(axil_rdata[10]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[11] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[11]),
        .Q(axil_rdata[11]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[12] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[12]),
        .Q(axil_rdata[12]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[13] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[13]),
        .Q(axil_rdata[13]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[14] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[14]),
        .Q(axil_rdata[14]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[15] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[15]),
        .Q(axil_rdata[15]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[16] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[16]),
        .Q(axil_rdata[16]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[16]_i_1 
       (.I0(\axi_rdata[16]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [16]),
        .O(reg_rd_dat[16]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[17] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[17]),
        .Q(axil_rdata[17]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[17]_i_1 
       (.I0(\axi_rdata[17]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [17]),
        .O(reg_rd_dat[17]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[18] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[18]),
        .Q(axil_rdata[18]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[18]_i_1 
       (.I0(\axi_rdata[18]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [18]),
        .O(reg_rd_dat[18]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[19] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[19]),
        .Q(axil_rdata[19]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[19]_i_1 
       (.I0(\axi_rdata[19]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [19]),
        .O(reg_rd_dat[19]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[1] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[1]),
        .Q(axil_rdata[1]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[1]_i_1 
       (.I0(\axi_rdata[1]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [1]),
        .O(reg_rd_dat[1]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[20] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[20]),
        .Q(axil_rdata[20]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[20]_i_1 
       (.I0(\axi_rdata[20]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [20]),
        .O(reg_rd_dat[20]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[21] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[21]),
        .Q(axil_rdata[21]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[21]_i_1 
       (.I0(\axi_rdata[21]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [21]),
        .O(reg_rd_dat[21]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[22] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[22]),
        .Q(axil_rdata[22]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[22]_i_1 
       (.I0(\axi_rdata[22]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [22]),
        .O(reg_rd_dat[22]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[23] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[23]),
        .Q(axil_rdata[23]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[23]_i_1 
       (.I0(\axi_rdata[23]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [23]),
        .O(reg_rd_dat[23]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[24] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[24]),
        .Q(axil_rdata[24]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[24]_i_1 
       (.I0(\axi_rdata[24]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [24]),
        .O(reg_rd_dat[24]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[25] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[25]),
        .Q(axil_rdata[25]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[25]_i_1 
       (.I0(\axi_rdata[25]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [25]),
        .O(reg_rd_dat[25]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[26] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[26]),
        .Q(axil_rdata[26]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[26]_i_1 
       (.I0(\axi_rdata[26]_i_3_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [26]),
        .O(reg_rd_dat[26]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[27] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[27]),
        .Q(axil_rdata[27]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[28] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[28]),
        .Q(axil_rdata[28]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[29] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[29]),
        .Q(axil_rdata[29]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[2] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[2]),
        .Q(axil_rdata[2]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  MUXF7 \axi_rdata_reg[2]_i_1 
       (.I0(\axi_rdata[2]_i_2_n_0 ),
        .I1(\comblock_i/regs_in[0]__159 [2]),
        .O(reg_rd_dat[2]),
        .S(\comblock_i/reg_rd_data_o19_out ));
  FDRE \axi_rdata_reg[30] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[30]),
        .Q(axil_rdata[30]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[31] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[31]),
        .Q(axil_rdata[31]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[3] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[3]),
        .Q(axil_rdata[3]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[4] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[4]),
        .Q(axil_rdata[4]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[5] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[5]),
        .Q(axil_rdata[5]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[6] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[6]),
        .Q(axil_rdata[6]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[7] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[7]),
        .Q(axil_rdata[7]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[8] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[8]),
        .Q(axil_rdata[8]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  FDRE \axi_rdata_reg[9] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(reg_rd_dat[9]),
        .Q(axil_rdata[9]),
        .R(\axi_rdata[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h08F8)) 
    axi_rvalid_i_1
       (.I0(axil_arvalid),
        .I1(axil_arready),
        .I2(axi_rvalid_reg_0),
        .I3(axil_rready),
        .O(axi_rvalid_i_1_n_0));
  FDRE axi_rvalid_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(axi_rvalid_i_1_n_0),
        .Q(axi_rvalid_reg_0),
        .R(axi_awready_i_1_n_0));
  LUT4 #(
    .INIT(16'h0080)) 
    axi_wready_i_1
       (.I0(aw_en_reg_n_0),
        .I1(axil_awvalid),
        .I2(axil_wvalid),
        .I3(axil_wready),
        .O(axi_wready0));
  FDRE axi_wready_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(axi_wready0),
        .Q(axil_wready),
        .R(axi_awready_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h20000000)) 
    fifo_out_clear_i_1
       (.I0(reg_wr_adr[7]),
        .I1(reg_wr_adr[6]),
        .I2(reg_wr_adr[2]),
        .I3(reg_wr_adr[4]),
        .I4(\regs_out[0][31]_i_2_n_0 ),
        .O(\axi_awaddr_reg[7]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00200000)) 
    fifo_out_over_r_i_2
       (.I0(reg_wr_adr[7]),
        .I1(reg_wr_adr[6]),
        .I2(reg_wr_adr[4]),
        .I3(reg_wr_adr[2]),
        .I4(\regs_out[0][31]_i_2_n_0 ),
        .O(fifo_out_we));
  LUT6 #(
    .INIT(64'h0000000000000080)) 
    fifo_out_over_r_i_3
       (.I0(reg_rd_adr[7]),
        .I1(reg_rd_ena),
        .I2(fifo_out_over_r_i_4_n_0),
        .I3(reg_rd_adr[2]),
        .I4(reg_rd_adr[5]),
        .I5(reg_rd_adr[6]),
        .O(fifo_out_over_r0_out));
  LUT2 #(
    .INIT(4'h8)) 
    fifo_out_over_r_i_4
       (.I0(reg_rd_adr[3]),
        .I1(reg_rd_adr[4]),
        .O(fifo_out_over_r_i_4_n_0));
  LUT6 #(
    .INIT(64'h0000000000200000)) 
    ram_reg_i_1
       (.I0(\regs_out[0][31]_i_2_n_0 ),
        .I1(reg_wr_adr[2]),
        .I2(reg_wr_adr[4]),
        .I3(reg_wr_adr[6]),
        .I4(reg_wr_adr[7]),
        .I5(full_r),
        .O(p_4_in));
  LUT3 #(
    .INIT(8'h08)) 
    rd_val_o_i_1
       (.I0(axil_arready),
        .I1(axil_arvalid),
        .I2(axi_rvalid_reg_0),
        .O(slv_reg_rden));
  FDRE rd_val_o_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(slv_reg_rden),
        .Q(reg_rd_ena),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00020000)) 
    \regs_out[0][31]_i_1 
       (.I0(reg_wr_adr[6]),
        .I1(reg_wr_adr[7]),
        .I2(reg_wr_adr[2]),
        .I3(reg_wr_adr[4]),
        .I4(\regs_out[0][31]_i_2_n_0 ),
        .O(\axi_awaddr_reg[6]_0 ));
  LUT6 #(
    .INIT(64'h1000000000000000)) 
    \regs_out[0][31]_i_2 
       (.I0(reg_wr_adr[5]),
        .I1(reg_wr_adr[3]),
        .I2(axil_awready),
        .I3(axil_wready),
        .I4(axil_awvalid),
        .I5(axil_wvalid),
        .O(\regs_out[0][31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00200000)) 
    \regs_out[1][31]_i_1 
       (.I0(reg_wr_adr[6]),
        .I1(reg_wr_adr[7]),
        .I2(reg_wr_adr[2]),
        .I3(reg_wr_adr[4]),
        .I4(\regs_out[0][31]_i_2_n_0 ),
        .O(E));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry_i_1
       (.I0(p_4_in),
        .I1(ret15_out),
        .O(\axi_awaddr_reg[2]_0 ));
endmodule

(* ORIG_REF_NAME = "ComBlock" *) 
module comblock_setup_comblock_0_0_ComBlock
   (fifo_data_o,
    full_r,
    fifo_empty_o,
    fifo_valid_o,
    \data_r_reg[1][3] ,
    \data_r_reg[1][7] ,
    O,
    fifo_out_over_r,
    ret15_out,
    fifo_underflow_o,
    \_inferred__1/i__carry ,
    \_inferred__1/i__carry__0 ,
    \_inferred__1/i__carry_0 ,
    fifo_aempty_o,
    \_inferred__1/i__carry_1 ,
    \_inferred__1/i__carry__1 ,
    reg0_o,
    reg1_o,
    axil_aclk,
    fifo_clk_i,
    p_4_in,
    axil_wdata,
    \wr_ptr_r_reg[3] ,
    fifo_out_clear_reg_0,
    fifo_out_we,
    fifo_out_over_r0_out,
    fifo_clear_i,
    fifo_re_i,
    E,
    \regs_out_reg[1][31]_0 );
  output [23:0]fifo_data_o;
  output full_r;
  output fifo_empty_o;
  output fifo_valid_o;
  output [3:0]\data_r_reg[1][3] ;
  output [3:0]\data_r_reg[1][7] ;
  output [2:0]O;
  output fifo_out_over_r;
  output ret15_out;
  output fifo_underflow_o;
  output \_inferred__1/i__carry ;
  output \_inferred__1/i__carry__0 ;
  output \_inferred__1/i__carry_0 ;
  output fifo_aempty_o;
  output \_inferred__1/i__carry_1 ;
  output \_inferred__1/i__carry__1 ;
  output [31:0]reg0_o;
  output [31:0]reg1_o;
  input axil_aclk;
  input fifo_clk_i;
  input p_4_in;
  input [31:0]axil_wdata;
  input \wr_ptr_r_reg[3] ;
  input fifo_out_clear_reg_0;
  input fifo_out_we;
  input fifo_out_over_r0_out;
  input fifo_clear_i;
  input fifo_re_i;
  input [0:0]E;
  input [0:0]\regs_out_reg[1][31]_0 ;

  wire [0:0]E;
  wire [2:0]O;
  wire \_inferred__1/i__carry ;
  wire \_inferred__1/i__carry_0 ;
  wire \_inferred__1/i__carry_1 ;
  wire \_inferred__1/i__carry__0 ;
  wire \_inferred__1/i__carry__1 ;
  wire axil_aclk;
  wire [31:0]axil_wdata;
  wire [3:0]\data_r_reg[1][3] ;
  wire [3:0]\data_r_reg[1][7] ;
  wire fifo_aempty_o;
  wire fifo_clear_i;
  wire fifo_clk_i;
  wire [23:0]fifo_data_o;
  wire fifo_empty_o;
  wire fifo_out_clear_reg_0;
  wire fifo_out_clear_reg_n_0;
  wire \fifo_out_g.fifo_out_i_n_39 ;
  wire fifo_out_over_r;
  wire fifo_out_over_r0_out;
  wire fifo_out_we;
  wire fifo_re_i;
  wire fifo_underflow_o;
  wire fifo_valid_o;
  wire full_r;
  wire p_4_in;
  wire [31:0]reg0_o;
  wire [31:0]reg1_o;
  wire [0:0]\regs_out_reg[1][31]_0 ;
  wire ret15_out;
  wire \wr_ptr_r_reg[3] ;

  FDRE fifo_out_clear_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(fifo_out_clear_reg_0),
        .Q(fifo_out_clear_reg_n_0),
        .R(1'b0));
  comblock_setup_comblock_0_0_FIFO \fifo_out_g.fifo_out_i 
       (.O(O),
        .\_inferred__1/i__carry_0 (\_inferred__1/i__carry ),
        .\_inferred__1/i__carry_1 (\_inferred__1/i__carry_0 ),
        .\_inferred__1/i__carry_2 (\_inferred__1/i__carry_1 ),
        .\_inferred__1/i__carry__0_0 (\_inferred__1/i__carry__0 ),
        .\_inferred__1/i__carry__1_0 (\_inferred__1/i__carry__1 ),
        .axil_aclk(axil_aclk),
        .axil_wdata(axil_wdata[23:0]),
        .\data_r_reg[1][3] (\data_r_reg[1][3] ),
        .\data_r_reg[1][7] (\data_r_reg[1][7] ),
        .fifo_aempty_o(fifo_aempty_o),
        .fifo_clear_i(fifo_clear_i),
        .fifo_clk_i(fifo_clk_i),
        .fifo_data_o(fifo_data_o),
        .fifo_empty_o(fifo_empty_o),
        .fifo_out_over_r(fifo_out_over_r),
        .fifo_out_over_r0_out(fifo_out_over_r0_out),
        .fifo_out_over_r_reg(\fifo_out_g.fifo_out_i_n_39 ),
        .fifo_out_we(fifo_out_we),
        .fifo_re_i(fifo_re_i),
        .fifo_underflow_o(fifo_underflow_o),
        .fifo_valid_o(fifo_valid_o),
        .full_r(full_r),
        .p_4_in(p_4_in),
        .\wr_ptr_r_reg[0]_0 (fifo_out_clear_reg_n_0),
        .\wr_ptr_r_reg[1]_0 (ret15_out),
        .\wr_ptr_r_reg[3]_0 (\wr_ptr_r_reg[3] ));
  FDRE #(
    .INIT(1'b0)) 
    fifo_out_over_r_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\fifo_out_g.fifo_out_i_n_39 ),
        .Q(fifo_out_over_r),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][0] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[0]),
        .Q(reg0_o[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][10] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[10]),
        .Q(reg0_o[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][11] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[11]),
        .Q(reg0_o[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][12] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[12]),
        .Q(reg0_o[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][13] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[13]),
        .Q(reg0_o[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][14] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[14]),
        .Q(reg0_o[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][15] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[15]),
        .Q(reg0_o[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][16] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[16]),
        .Q(reg0_o[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][17] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[17]),
        .Q(reg0_o[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][18] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[18]),
        .Q(reg0_o[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][19] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[19]),
        .Q(reg0_o[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][1] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[1]),
        .Q(reg0_o[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][20] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[20]),
        .Q(reg0_o[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][21] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[21]),
        .Q(reg0_o[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][22] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[22]),
        .Q(reg0_o[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][23] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[23]),
        .Q(reg0_o[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][24] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[24]),
        .Q(reg0_o[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][25] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[25]),
        .Q(reg0_o[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][26] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[26]),
        .Q(reg0_o[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][27] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[27]),
        .Q(reg0_o[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][28] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[28]),
        .Q(reg0_o[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][29] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[29]),
        .Q(reg0_o[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][2] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[2]),
        .Q(reg0_o[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][30] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[30]),
        .Q(reg0_o[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][31] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[31]),
        .Q(reg0_o[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][3] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[3]),
        .Q(reg0_o[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][4] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[4]),
        .Q(reg0_o[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][5] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[5]),
        .Q(reg0_o[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][6] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[6]),
        .Q(reg0_o[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][7] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[7]),
        .Q(reg0_o[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][8] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[8]),
        .Q(reg0_o[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[0][9] 
       (.C(axil_aclk),
        .CE(E),
        .D(axil_wdata[9]),
        .Q(reg0_o[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][0] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[0]),
        .Q(reg1_o[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][10] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[10]),
        .Q(reg1_o[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][11] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[11]),
        .Q(reg1_o[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][12] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[12]),
        .Q(reg1_o[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][13] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[13]),
        .Q(reg1_o[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][14] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[14]),
        .Q(reg1_o[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][15] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[15]),
        .Q(reg1_o[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][16] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[16]),
        .Q(reg1_o[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][17] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[17]),
        .Q(reg1_o[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][18] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[18]),
        .Q(reg1_o[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][19] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[19]),
        .Q(reg1_o[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][1] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[1]),
        .Q(reg1_o[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][20] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[20]),
        .Q(reg1_o[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][21] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[21]),
        .Q(reg1_o[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][22] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[22]),
        .Q(reg1_o[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][23] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[23]),
        .Q(reg1_o[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][24] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[24]),
        .Q(reg1_o[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][25] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[25]),
        .Q(reg1_o[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][26] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[26]),
        .Q(reg1_o[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][27] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[27]),
        .Q(reg1_o[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][28] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[28]),
        .Q(reg1_o[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][29] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[29]),
        .Q(reg1_o[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][2] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[2]),
        .Q(reg1_o[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][30] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[30]),
        .Q(reg1_o[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][31] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[31]),
        .Q(reg1_o[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][3] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[3]),
        .Q(reg1_o[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][4] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[4]),
        .Q(reg1_o[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][5] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[5]),
        .Q(reg1_o[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][6] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[6]),
        .Q(reg1_o[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][7] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[7]),
        .Q(reg1_o[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][8] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[8]),
        .Q(reg1_o[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \regs_out_reg[1][9] 
       (.C(axil_aclk),
        .CE(\regs_out_reg[1][31]_0 ),
        .D(axil_wdata[9]),
        .Q(reg1_o[9]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "FIFO" *) 
module comblock_setup_comblock_0_0_FIFO
   (fifo_data_o,
    full_r,
    fifo_empty_o,
    fifo_valid_o,
    \data_r_reg[1][3] ,
    \data_r_reg[1][7] ,
    O,
    \wr_ptr_r_reg[1]_0 ,
    fifo_out_over_r_reg,
    fifo_underflow_o,
    \_inferred__1/i__carry_0 ,
    \_inferred__1/i__carry__0_0 ,
    \_inferred__1/i__carry_1 ,
    fifo_aempty_o,
    \_inferred__1/i__carry_2 ,
    \_inferred__1/i__carry__1_0 ,
    axil_aclk,
    fifo_clk_i,
    p_4_in,
    axil_wdata,
    \wr_ptr_r_reg[3]_0 ,
    fifo_out_over_r,
    fifo_out_we,
    fifo_out_over_r0_out,
    \wr_ptr_r_reg[0]_0 ,
    fifo_clear_i,
    fifo_re_i);
  output [23:0]fifo_data_o;
  output full_r;
  output fifo_empty_o;
  output fifo_valid_o;
  output [3:0]\data_r_reg[1][3] ;
  output [3:0]\data_r_reg[1][7] ;
  output [2:0]O;
  output \wr_ptr_r_reg[1]_0 ;
  output fifo_out_over_r_reg;
  output fifo_underflow_o;
  output \_inferred__1/i__carry_0 ;
  output \_inferred__1/i__carry__0_0 ;
  output \_inferred__1/i__carry_1 ;
  output fifo_aempty_o;
  output \_inferred__1/i__carry_2 ;
  output \_inferred__1/i__carry__1_0 ;
  input axil_aclk;
  input fifo_clk_i;
  input p_4_in;
  input [23:0]axil_wdata;
  input \wr_ptr_r_reg[3]_0 ;
  input fifo_out_over_r;
  input fifo_out_we;
  input fifo_out_over_r0_out;
  input \wr_ptr_r_reg[0]_0 ;
  input fifo_clear_i;
  input fifo_re_i;

  wire [2:0]O;
  wire \_inferred__1/i__carry_0 ;
  wire \_inferred__1/i__carry_1 ;
  wire \_inferred__1/i__carry_2 ;
  wire \_inferred__1/i__carry__0_0 ;
  wire \_inferred__1/i__carry__0_n_0 ;
  wire \_inferred__1/i__carry__0_n_1 ;
  wire \_inferred__1/i__carry__0_n_2 ;
  wire \_inferred__1/i__carry__0_n_3 ;
  wire \_inferred__1/i__carry__1_0 ;
  wire \_inferred__1/i__carry__1_n_2 ;
  wire \_inferred__1/i__carry__1_n_3 ;
  wire \_inferred__1/i__carry_n_0 ;
  wire \_inferred__1/i__carry_n_1 ;
  wire \_inferred__1/i__carry_n_2 ;
  wire \_inferred__1/i__carry_n_3 ;
  wire \_inferred__4/i__carry__0_n_0 ;
  wire \_inferred__4/i__carry__0_n_1 ;
  wire \_inferred__4/i__carry__0_n_2 ;
  wire \_inferred__4/i__carry__0_n_3 ;
  wire \_inferred__4/i__carry__1_n_2 ;
  wire \_inferred__4/i__carry__1_n_3 ;
  wire \_inferred__4/i__carry_n_0 ;
  wire \_inferred__4/i__carry_n_1 ;
  wire \_inferred__4/i__carry_n_2 ;
  wire \_inferred__4/i__carry_n_3 ;
  wire axil_aclk;
  wire [23:0]axil_wdata;
  wire [3:0]\data_r_reg[1][3] ;
  wire [3:0]\data_r_reg[1][7] ;
  wire empty_r;
  wire fifo_aempty_o;
  wire fifo_aempty_o_INST_0_i_1_n_0;
  wire fifo_clear_i;
  wire fifo_clk_i;
  wire [23:0]fifo_data_o;
  wire fifo_empty_o;
  wire fifo_empty_o_INST_0_i_1_n_0;
  wire fifo_empty_o_INST_0_i_2_n_0;
  wire fifo_out_over_r;
  wire fifo_out_over_r0_out;
  wire fifo_out_over_r_reg;
  wire fifo_out_we;
  wire fifo_re_i;
  wire fifo_underflow_o;
  wire fifo_valid_o;
  wire full;
  wire full_r;
  wire \g_async.i_sync_rd2wr_n_0 ;
  wire \g_async.i_sync_rd2wr_n_1 ;
  wire \g_async.i_sync_rd2wr_n_10 ;
  wire \g_async.i_sync_rd2wr_n_11 ;
  wire \g_async.i_sync_rd2wr_n_12 ;
  wire \g_async.i_sync_rd2wr_n_13 ;
  wire \g_async.i_sync_rd2wr_n_14 ;
  wire \g_async.i_sync_rd2wr_n_15 ;
  wire \g_async.i_sync_rd2wr_n_16 ;
  wire \g_async.i_sync_rd2wr_n_17 ;
  wire \g_async.i_sync_rd2wr_n_18 ;
  wire \g_async.i_sync_rd2wr_n_2 ;
  wire \g_async.i_sync_rd2wr_n_20 ;
  wire \g_async.i_sync_rd2wr_n_21 ;
  wire \g_async.i_sync_rd2wr_n_3 ;
  wire \g_async.i_sync_rd2wr_n_4 ;
  wire \g_async.i_sync_rd2wr_n_5 ;
  wire \g_async.i_sync_rd2wr_n_6 ;
  wire \g_async.i_sync_rd2wr_n_7 ;
  wire \g_async.i_sync_rd2wr_n_8 ;
  wire \g_async.i_sync_rd2wr_n_9 ;
  wire \g_async.i_sync_wr2rd_n_0 ;
  wire \g_async.i_sync_wr2rd_n_1 ;
  wire \g_async.i_sync_wr2rd_n_10 ;
  wire \g_async.i_sync_wr2rd_n_2 ;
  wire \g_async.i_sync_wr2rd_n_3 ;
  wire \g_async.i_sync_wr2rd_n_4 ;
  wire \g_async.i_sync_wr2rd_n_5 ;
  wire \g_async.i_sync_wr2rd_n_6 ;
  wire \g_async.i_sync_wr2rd_n_7 ;
  wire \g_async.i_sync_wr2rd_n_8 ;
  wire \g_async.i_sync_wr2rd_n_9 ;
  wire i__carry__0_i_10__0_n_0;
  wire i__carry__0_i_10__0_n_1;
  wire i__carry__0_i_10__0_n_2;
  wire i__carry__0_i_10__0_n_3;
  wire i__carry__0_i_10__0_n_4;
  wire i__carry__0_i_10__0_n_5;
  wire i__carry__0_i_10__0_n_6;
  wire i__carry__0_i_10__0_n_7;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_9__0_n_0;
  wire i__carry__0_i_9__0_n_1;
  wire i__carry__0_i_9__0_n_2;
  wire i__carry__0_i_9__0_n_3;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3__1_n_0;
  wire i__carry__1_i_6__0_n_2;
  wire i__carry__1_i_6__0_n_3;
  wire i__carry__1_i_6_n_2;
  wire i__carry__1_i_6_n_3;
  wire i__carry__1_i_6_n_5;
  wire i__carry__1_i_6_n_6;
  wire i__carry__1_i_6_n_7;
  wire i__carry_i_11__0_n_0;
  wire i__carry_i_11__0_n_1;
  wire i__carry_i_11__0_n_2;
  wire i__carry_i_11__0_n_3;
  wire i__carry_i_11__0_n_4;
  wire i__carry_i_11__0_n_5;
  wire i__carry_i_11__0_n_6;
  wire i__carry_i_11__0_n_7;
  wire i__carry_i_12__0_n_0;
  wire i__carry_i_13_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire i__carry_i_9__0_n_0;
  wire i__carry_i_9__0_n_1;
  wire i__carry_i_9__0_n_2;
  wire i__carry_i_9__0_n_3;
  wire [9:0]p_1_in;
  wire p_2_in;
  wire p_4_in;
  wire [10:0]rd_ptr_r;
  wire [10:0]ret;
  wire ret1__9;
  wire ret_carry__0_i_1_n_0;
  wire ret_carry__0_i_2_n_0;
  wire ret_carry__0_i_3_n_0;
  wire ret_carry__0_i_4_n_0;
  wire ret_carry__0_n_0;
  wire ret_carry__0_n_1;
  wire ret_carry__0_n_2;
  wire ret_carry__0_n_3;
  wire ret_carry__0_n_4;
  wire ret_carry__0_n_5;
  wire ret_carry__0_n_6;
  wire ret_carry__0_n_7;
  wire ret_carry__1_i_1_n_0;
  wire ret_carry__1_i_2_n_0;
  wire ret_carry__1_i_3_n_0;
  wire ret_carry__1_n_2;
  wire ret_carry__1_n_3;
  wire ret_carry__1_n_5;
  wire ret_carry__1_n_6;
  wire ret_carry__1_n_7;
  wire ret_carry_i_2_n_0;
  wire ret_carry_i_3_n_0;
  wire ret_carry_i_4_n_0;
  wire ret_carry_i_5_n_0;
  wire ret_carry_i_7_n_0;
  wire ret_carry_n_0;
  wire ret_carry_n_1;
  wire ret_carry_n_2;
  wire ret_carry_n_3;
  wire ret_carry_n_4;
  wire ret_carry_n_5;
  wire ret_carry_n_6;
  wire ret_carry_n_7;
  wire \ret_inferred__1/i__carry__0_n_0 ;
  wire \ret_inferred__1/i__carry__0_n_1 ;
  wire \ret_inferred__1/i__carry__0_n_2 ;
  wire \ret_inferred__1/i__carry__0_n_3 ;
  wire \ret_inferred__1/i__carry__0_n_4 ;
  wire \ret_inferred__1/i__carry__0_n_5 ;
  wire \ret_inferred__1/i__carry__0_n_6 ;
  wire \ret_inferred__1/i__carry__0_n_7 ;
  wire \ret_inferred__1/i__carry__1_n_2 ;
  wire \ret_inferred__1/i__carry__1_n_3 ;
  wire \ret_inferred__1/i__carry__1_n_5 ;
  wire \ret_inferred__1/i__carry__1_n_6 ;
  wire \ret_inferred__1/i__carry__1_n_7 ;
  wire \ret_inferred__1/i__carry_n_0 ;
  wire \ret_inferred__1/i__carry_n_1 ;
  wire \ret_inferred__1/i__carry_n_2 ;
  wire \ret_inferred__1/i__carry_n_3 ;
  wire \ret_inferred__1/i__carry_n_4 ;
  wire \ret_inferred__1/i__carry_n_5 ;
  wire \ret_inferred__1/i__carry_n_6 ;
  wire \ret_inferred__1/i__carry_n_7 ;
  wire rst;
  wire [10:0]sel0;
  wire [10:0]wr_ptr_r;
  wire \wr_ptr_r_reg[0]_0 ;
  wire \wr_ptr_r_reg[1]_0 ;
  wire \wr_ptr_r_reg[3]_0 ;
  wire [3:2]\NLW__inferred__1/i__carry__1_CO_UNCONNECTED ;
  wire [3:3]\NLW__inferred__1/i__carry__1_O_UNCONNECTED ;
  wire [3:2]\NLW__inferred__4/i__carry__1_CO_UNCONNECTED ;
  wire [3:3]\NLW__inferred__4/i__carry__1_O_UNCONNECTED ;
  wire [3:2]NLW_i__carry__1_i_6_CO_UNCONNECTED;
  wire [3:3]NLW_i__carry__1_i_6_O_UNCONNECTED;
  wire [3:2]NLW_i__carry__1_i_6__0_CO_UNCONNECTED;
  wire [3:3]NLW_i__carry__1_i_6__0_O_UNCONNECTED;
  wire [3:2]NLW_ret_carry__1_CO_UNCONNECTED;
  wire [3:3]NLW_ret_carry__1_O_UNCONNECTED;
  wire [3:2]\NLW_ret_inferred__1/i__carry__1_CO_UNCONNECTED ;
  wire [3:3]\NLW_ret_inferred__1/i__carry__1_O_UNCONNECTED ;

  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__1/i__carry 
       (.CI(1'b0),
        .CO({\_inferred__1/i__carry_n_0 ,\_inferred__1/i__carry_n_1 ,\_inferred__1/i__carry_n_2 ,\_inferred__1/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI({\g_async.i_sync_rd2wr_n_4 ,\g_async.i_sync_rd2wr_n_5 ,\g_async.i_sync_rd2wr_n_6 ,\g_async.i_sync_rd2wr_n_7 }),
        .O(\data_r_reg[1][3] ),
        .S({\g_async.i_sync_rd2wr_n_0 ,\g_async.i_sync_rd2wr_n_1 ,\g_async.i_sync_rd2wr_n_2 ,\g_async.i_sync_rd2wr_n_3 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__1/i__carry__0 
       (.CI(\_inferred__1/i__carry_n_0 ),
        .CO({\_inferred__1/i__carry__0_n_0 ,\_inferred__1/i__carry__0_n_1 ,\_inferred__1/i__carry__0_n_2 ,\_inferred__1/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({\g_async.i_sync_rd2wr_n_12 ,\g_async.i_sync_rd2wr_n_13 ,\g_async.i_sync_rd2wr_n_14 ,\g_async.i_sync_rd2wr_n_15 }),
        .O(\data_r_reg[1][7] ),
        .S({\g_async.i_sync_rd2wr_n_8 ,\g_async.i_sync_rd2wr_n_9 ,\g_async.i_sync_rd2wr_n_10 ,\g_async.i_sync_rd2wr_n_11 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__1/i__carry__1 
       (.CI(\_inferred__1/i__carry__0_n_0 ),
        .CO({\NLW__inferred__1/i__carry__1_CO_UNCONNECTED [3:2],\_inferred__1/i__carry__1_n_2 ,\_inferred__1/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\g_async.i_sync_rd2wr_n_20 ,\g_async.i_sync_rd2wr_n_21 }),
        .O({\NLW__inferred__1/i__carry__1_O_UNCONNECTED [3],O}),
        .S({1'b0,\g_async.i_sync_rd2wr_n_16 ,\g_async.i_sync_rd2wr_n_17 ,\g_async.i_sync_rd2wr_n_18 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry 
       (.CI(1'b0),
        .CO({\_inferred__4/i__carry_n_0 ,\_inferred__4/i__carry_n_1 ,\_inferred__4/i__carry_n_2 ,\_inferred__4/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI(p_1_in[3:0]),
        .O(sel0[3:0]),
        .S({\g_async.i_sync_wr2rd_n_0 ,\g_async.i_sync_wr2rd_n_1 ,\g_async.i_sync_wr2rd_n_2 ,\g_async.i_sync_wr2rd_n_3 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry__0 
       (.CI(\_inferred__4/i__carry_n_0 ),
        .CO({\_inferred__4/i__carry__0_n_0 ,\_inferred__4/i__carry__0_n_1 ,\_inferred__4/i__carry__0_n_2 ,\_inferred__4/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI(p_1_in[7:4]),
        .O(sel0[7:4]),
        .S({\g_async.i_sync_wr2rd_n_4 ,\g_async.i_sync_wr2rd_n_5 ,\g_async.i_sync_wr2rd_n_6 ,\g_async.i_sync_wr2rd_n_7 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \_inferred__4/i__carry__1 
       (.CI(\_inferred__4/i__carry__0_n_0 ),
        .CO({\NLW__inferred__4/i__carry__1_CO_UNCONNECTED [3:2],\_inferred__4/i__carry__1_n_2 ,\_inferred__4/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,p_1_in[9:8]}),
        .O({\NLW__inferred__4/i__carry__1_O_UNCONNECTED [3],sel0[10:8]}),
        .S({1'b0,\g_async.i_sync_wr2rd_n_8 ,\g_async.i_sync_wr2rd_n_9 ,\g_async.i_sync_wr2rd_n_10 }));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \axi_rdata[0]_i_4 
       (.I0(\data_r_reg[1][3] [2]),
        .I1(\data_r_reg[1][3] [1]),
        .I2(\data_r_reg[1][3] [0]),
        .O(\_inferred__1/i__carry_1 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \axi_rdata[1]_i_4 
       (.I0(\data_r_reg[1][7] [0]),
        .I1(\data_r_reg[1][7] [1]),
        .I2(\data_r_reg[1][7] [2]),
        .I3(\data_r_reg[1][7] [3]),
        .I4(O[1]),
        .I5(O[0]),
        .O(\_inferred__1/i__carry__1_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \axi_rdata[1]_i_5 
       (.I0(\data_r_reg[1][3] [1]),
        .I1(\data_r_reg[1][3] [0]),
        .I2(\data_r_reg[1][3] [3]),
        .I3(\data_r_reg[1][3] [2]),
        .O(\_inferred__1/i__carry_2 ));
  FDSE empty_r_reg
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(fifo_empty_o),
        .Q(empty_r),
        .S(rst));
  LUT5 #(
    .INIT(32'h00000002)) 
    fifo_aempty_o_INST_0
       (.I0(fifo_aempty_o_INST_0_i_1_n_0),
        .I1(sel0[3]),
        .I2(sel0[4]),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .O(fifo_aempty_o));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    fifo_aempty_o_INST_0_i_1
       (.I0(sel0[5]),
        .I1(sel0[6]),
        .I2(sel0[7]),
        .I3(sel0[8]),
        .I4(sel0[10]),
        .I5(sel0[9]),
        .O(fifo_aempty_o_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'h31000000)) 
    fifo_empty_o_INST_0
       (.I0(sel0[6]),
        .I1(sel0[8]),
        .I2(sel0[7]),
        .I3(fifo_empty_o_INST_0_i_1_n_0),
        .I4(fifo_empty_o_INST_0_i_2_n_0),
        .O(fifo_empty_o));
  LUT6 #(
    .INIT(64'h0000000000000023)) 
    fifo_empty_o_INST_0_i_1
       (.I0(sel0[4]),
        .I1(sel0[5]),
        .I2(sel0[3]),
        .I3(sel0[0]),
        .I4(sel0[1]),
        .I5(sel0[2]),
        .O(fifo_empty_o_INST_0_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    fifo_empty_o_INST_0_i_2
       (.I0(sel0[4]),
        .I1(sel0[5]),
        .I2(sel0[7]),
        .I3(sel0[8]),
        .I4(sel0[10]),
        .I5(sel0[9]),
        .O(fifo_empty_o_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'h00EA)) 
    fifo_out_over_r_i_1
       (.I0(fifo_out_over_r),
        .I1(fifo_out_we),
        .I2(full_r),
        .I3(fifo_out_over_r0_out),
        .O(fifo_out_over_r_reg));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h8)) 
    fifo_underflow_o_INST_0
       (.I0(fifo_re_i),
        .I1(empty_r),
        .O(fifo_underflow_o));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    full_r_i_1
       (.I0(\_inferred__1/i__carry_0 ),
        .I1(\_inferred__1/i__carry__0_0 ),
        .I2(\data_r_reg[1][3] [0]),
        .I3(\data_r_reg[1][3] [1]),
        .I4(\data_r_reg[1][3] [2]),
        .O(full));
  LUT4 #(
    .INIT(16'h0001)) 
    full_r_i_2
       (.I0(\data_r_reg[1][7] [2]),
        .I1(\data_r_reg[1][7] [1]),
        .I2(\data_r_reg[1][7] [0]),
        .I3(\data_r_reg[1][3] [3]),
        .O(\_inferred__1/i__carry_0 ));
  FDRE full_r_reg
       (.C(axil_aclk),
        .CE(1'b1),
        .D(full),
        .Q(full_r),
        .R(rst));
  comblock_setup_comblock_0_0_GraySync \g_async.i_sync_rd2wr 
       (.DI({\g_async.i_sync_rd2wr_n_4 ,\g_async.i_sync_rd2wr_n_5 ,\g_async.i_sync_rd2wr_n_6 ,\g_async.i_sync_rd2wr_n_7 }),
        .O({i__carry_i_11__0_n_4,i__carry_i_11__0_n_5,i__carry_i_11__0_n_6,i__carry_i_11__0_n_7}),
        .Q(wr_ptr_r[10]),
        .S({\g_async.i_sync_rd2wr_n_0 ,\g_async.i_sync_rd2wr_n_1 ,\g_async.i_sync_rd2wr_n_2 ,\g_async.i_sync_rd2wr_n_3 }),
        .\_inferred__1/i__carry__0 (\_inferred__1/i__carry__0_0 ),
        .\_inferred__1/i__carry__0_0 ({i__carry__0_i_10__0_n_4,i__carry__0_i_10__0_n_5,i__carry__0_i_10__0_n_6,i__carry__0_i_10__0_n_7}),
        .\_inferred__1/i__carry__1 (\wr_ptr_r_reg[1]_0 ),
        .\_inferred__1/i__carry__1_0 ({i__carry__1_i_6_n_5,i__carry__1_i_6_n_6,i__carry__1_i_6_n_7}),
        .axil_aclk(axil_aclk),
        .\data_r_reg[0][10]_0 (rd_ptr_r),
        .\data_r_reg[1][10]_0 ({\g_async.i_sync_rd2wr_n_16 ,\g_async.i_sync_rd2wr_n_17 ,\g_async.i_sync_rd2wr_n_18 }),
        .\data_r_reg[1][10]_1 ({\g_async.i_sync_rd2wr_n_20 ,\g_async.i_sync_rd2wr_n_21 }),
        .\data_r_reg[1][7]_0 ({\g_async.i_sync_rd2wr_n_8 ,\g_async.i_sync_rd2wr_n_9 ,\g_async.i_sync_rd2wr_n_10 ,\g_async.i_sync_rd2wr_n_11 }),
        .\data_r_reg[1][7]_1 ({\g_async.i_sync_rd2wr_n_12 ,\g_async.i_sync_rd2wr_n_13 ,\g_async.i_sync_rd2wr_n_14 ,\g_async.i_sync_rd2wr_n_15 }),
        .full_r_reg(O),
        .full_r_reg_0(\data_r_reg[1][7] [3]));
  comblock_setup_comblock_0_0_GraySync_0 \g_async.i_sync_wr2rd 
       (.Q(rd_ptr_r[10]),
        .S({\g_async.i_sync_wr2rd_n_0 ,\g_async.i_sync_wr2rd_n_1 ,\g_async.i_sync_wr2rd_n_2 ,\g_async.i_sync_wr2rd_n_3 }),
        .\data_r_reg[0][10]_0 (wr_ptr_r),
        .\data_r_reg[1][7]_0 ({\g_async.i_sync_wr2rd_n_4 ,\g_async.i_sync_wr2rd_n_5 ,\g_async.i_sync_wr2rd_n_6 ,\g_async.i_sync_wr2rd_n_7 }),
        .fifo_clk_i(fifo_clk_i),
        .\rd_ptr_r_reg[10] ({\g_async.i_sync_wr2rd_n_8 ,\g_async.i_sync_wr2rd_n_9 ,\g_async.i_sync_wr2rd_n_10 }),
        .ret(ret),
        .ret1__9(ret1__9));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_1
       (.I0(rd_ptr_r[7]),
        .I1(ret1__9),
        .O(i__carry__0_i_1_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry__0_i_10__0
       (.CI(i__carry_i_11__0_n_0),
        .CO({i__carry__0_i_10__0_n_0,i__carry__0_i_10__0_n_1,i__carry__0_i_10__0_n_2,i__carry__0_i_10__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({i__carry__0_i_10__0_n_4,i__carry__0_i_10__0_n_5,i__carry__0_i_10__0_n_6,i__carry__0_i_10__0_n_7}),
        .S(wr_ptr_r[7:4]));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_1__0
       (.I0(ret1__9),
        .I1(ret[7]),
        .O(p_1_in[7]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_2
       (.I0(rd_ptr_r[6]),
        .I1(ret1__9),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_2__0
       (.I0(ret1__9),
        .I1(ret[6]),
        .O(p_1_in[6]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_3
       (.I0(rd_ptr_r[5]),
        .I1(ret1__9),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_3__0
       (.I0(ret1__9),
        .I1(ret[5]),
        .O(p_1_in[5]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_4
       (.I0(rd_ptr_r[4]),
        .I1(ret1__9),
        .O(i__carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__0_i_4__0
       (.I0(ret1__9),
        .I1(ret[4]),
        .O(p_1_in[4]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 i__carry__0_i_9__0
       (.CI(i__carry_i_9__0_n_0),
        .CO({i__carry__0_i_9__0_n_0,i__carry__0_i_9__0_n_1,i__carry__0_i_9__0_n_2,i__carry__0_i_9__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(ret[7:4]),
        .S(rd_ptr_r[7:4]));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__1_i_1
       (.I0(ret1__9),
        .I1(rd_ptr_r[10]),
        .O(i__carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__1_i_1__0
       (.I0(ret1__9),
        .I1(ret[9]),
        .O(p_1_in[9]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_2
       (.I0(rd_ptr_r[9]),
        .I1(ret1__9),
        .O(i__carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry__1_i_2__0
       (.I0(ret1__9),
        .I1(ret[8]),
        .O(p_1_in[8]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__1_i_3__1
       (.I0(rd_ptr_r[8]),
        .I1(ret1__9),
        .O(i__carry__1_i_3__1_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry__1_i_6
       (.CI(i__carry__0_i_10__0_n_0),
        .CO({NLW_i__carry__1_i_6_CO_UNCONNECTED[3:2],i__carry__1_i_6_n_2,i__carry__1_i_6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_i__carry__1_i_6_O_UNCONNECTED[3],i__carry__1_i_6_n_5,i__carry__1_i_6_n_6,i__carry__1_i_6_n_7}),
        .S({1'b0,wr_ptr_r[10:8]}));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 i__carry__1_i_6__0
       (.CI(i__carry__0_i_9__0_n_0),
        .CO({NLW_i__carry__1_i_6__0_CO_UNCONNECTED[3:2],i__carry__1_i_6__0_n_2,i__carry__1_i_6__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_i__carry__1_i_6__0_O_UNCONNECTED[3],ret[10:8]}),
        .S({1'b0,rd_ptr_r[10:8]}));
  LUT3 #(
    .INIT(8'h04)) 
    i__carry_i_1
       (.I0(empty_r),
        .I1(fifo_re_i),
        .I2(ret1__9),
        .O(i__carry_i_1_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry_i_11__0
       (.CI(1'b0),
        .CO({i__carry_i_11__0_n_0,i__carry_i_11__0_n_1,i__carry_i_11__0_n_2,i__carry_i_11__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,wr_ptr_r[0]}),
        .O({i__carry_i_11__0_n_4,i__carry_i_11__0_n_5,i__carry_i_11__0_n_6,i__carry_i_11__0_n_7}),
        .S({wr_ptr_r[3:1],i__carry_i_13_n_0}));
  LUT3 #(
    .INIT(8'h9A)) 
    i__carry_i_12__0
       (.I0(rd_ptr_r[0]),
        .I1(empty_r),
        .I2(fifo_re_i),
        .O(i__carry_i_12__0_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_13
       (.I0(wr_ptr_r[0]),
        .I1(p_4_in),
        .O(i__carry_i_13_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry_i_1__0
       (.I0(ret1__9),
        .I1(ret[3]),
        .O(p_1_in[3]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry_i_2
       (.I0(rd_ptr_r[3]),
        .I1(ret1__9),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry_i_2__0
       (.I0(ret1__9),
        .I1(ret[2]),
        .O(p_1_in[2]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry_i_3
       (.I0(rd_ptr_r[2]),
        .I1(ret1__9),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry_i_3__0
       (.I0(ret1__9),
        .I1(ret[1]),
        .O(p_1_in[1]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry_i_4
       (.I0(rd_ptr_r[1]),
        .I1(ret1__9),
        .O(i__carry_i_4_n_0));
  LUT2 #(
    .INIT(4'hB)) 
    i__carry_i_4__0
       (.I0(ret1__9),
        .I1(ret[0]),
        .O(p_1_in[0]));
  LUT2 #(
    .INIT(4'h2)) 
    i__carry_i_5
       (.I0(rd_ptr_r[0]),
        .I1(ret1__9),
        .O(i__carry_i_5_n_0));
  LUT6 #(
    .INIT(64'h2000000000000000)) 
    i__carry_i_6
       (.I0(i__carry_i_7_n_0),
        .I1(empty_r),
        .I2(fifo_re_i),
        .I3(rd_ptr_r[9]),
        .I4(rd_ptr_r[8]),
        .I5(i__carry_i_8_n_0),
        .O(ret1__9));
  LUT4 #(
    .INIT(16'h8000)) 
    i__carry_i_7
       (.I0(rd_ptr_r[7]),
        .I1(rd_ptr_r[6]),
        .I2(rd_ptr_r[5]),
        .I3(rd_ptr_r[4]),
        .O(i__carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    i__carry_i_8
       (.I0(rd_ptr_r[1]),
        .I1(rd_ptr_r[0]),
        .I2(rd_ptr_r[3]),
        .I3(rd_ptr_r[2]),
        .O(i__carry_i_8_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 i__carry_i_9__0
       (.CI(1'b0),
        .CO({i__carry_i_9__0_n_0,i__carry_i_9__0_n_1,i__carry_i_9__0_n_2,i__carry_i_9__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,rd_ptr_r[0]}),
        .O(ret[3:0]),
        .S({rd_ptr_r[3:1],i__carry_i_12__0_n_0}));
  comblock_setup_comblock_0_0_tdpram i_memory
       (.Q(wr_ptr_r[9:0]),
        .axil_aclk(axil_aclk),
        .axil_wdata(axil_wdata),
        .fifo_clk_i(fifo_clk_i),
        .fifo_data_o(fifo_data_o),
        .p_4_in(p_4_in),
        .ram_reg_0(rd_ptr_r[9:0]));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[0] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry_n_7 ),
        .Q(rd_ptr_r[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[10] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__1_n_5 ),
        .Q(rd_ptr_r[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[1] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry_n_6 ),
        .Q(rd_ptr_r[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[2] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry_n_5 ),
        .Q(rd_ptr_r[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[3] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry_n_4 ),
        .Q(rd_ptr_r[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[4] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__0_n_7 ),
        .Q(rd_ptr_r[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[5] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__0_n_6 ),
        .Q(rd_ptr_r[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[6] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__0_n_5 ),
        .Q(rd_ptr_r[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[7] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__0_n_4 ),
        .Q(rd_ptr_r[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[8] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__1_n_7 ),
        .Q(rd_ptr_r[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \rd_ptr_r_reg[9] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\ret_inferred__1/i__carry__1_n_6 ),
        .Q(rd_ptr_r[9]),
        .R(rst));
  CARRY4 ret_carry
       (.CI(1'b0),
        .CO({ret_carry_n_0,ret_carry_n_1,ret_carry_n_2,ret_carry_n_3}),
        .CYINIT(\wr_ptr_r_reg[3]_0 ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({ret_carry_n_4,ret_carry_n_5,ret_carry_n_6,ret_carry_n_7}),
        .S({ret_carry_i_2_n_0,ret_carry_i_3_n_0,ret_carry_i_4_n_0,ret_carry_i_5_n_0}));
  CARRY4 ret_carry__0
       (.CI(ret_carry_n_0),
        .CO({ret_carry__0_n_0,ret_carry__0_n_1,ret_carry__0_n_2,ret_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({ret_carry__0_n_4,ret_carry__0_n_5,ret_carry__0_n_6,ret_carry__0_n_7}),
        .S({ret_carry__0_i_1_n_0,ret_carry__0_i_2_n_0,ret_carry__0_i_3_n_0,ret_carry__0_i_4_n_0}));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__0_i_1
       (.I0(wr_ptr_r[7]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__0_i_2
       (.I0(wr_ptr_r[6]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__0_i_3
       (.I0(wr_ptr_r[5]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__0_i_4
       (.I0(wr_ptr_r[4]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__0_i_4_n_0));
  CARRY4 ret_carry__1
       (.CI(ret_carry__0_n_0),
        .CO({NLW_ret_carry__1_CO_UNCONNECTED[3:2],ret_carry__1_n_2,ret_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_ret_carry__1_O_UNCONNECTED[3],ret_carry__1_n_5,ret_carry__1_n_6,ret_carry__1_n_7}),
        .S({1'b0,ret_carry__1_i_1_n_0,ret_carry__1_i_2_n_0,ret_carry__1_i_3_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    ret_carry__1_i_1
       (.I0(\wr_ptr_r_reg[1]_0 ),
        .I1(wr_ptr_r[10]),
        .O(ret_carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__1_i_2
       (.I0(wr_ptr_r[9]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry__1_i_3
       (.I0(wr_ptr_r[8]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry_i_2
       (.I0(wr_ptr_r[3]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry_i_3
       (.I0(wr_ptr_r[2]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry_i_4
       (.I0(wr_ptr_r[1]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    ret_carry_i_5
       (.I0(wr_ptr_r[0]),
        .I1(\wr_ptr_r_reg[1]_0 ),
        .O(ret_carry_i_5_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    ret_carry_i_6
       (.I0(wr_ptr_r[1]),
        .I1(wr_ptr_r[0]),
        .I2(wr_ptr_r[3]),
        .I3(wr_ptr_r[2]),
        .I4(ret_carry_i_7_n_0),
        .I5(p_4_in),
        .O(\wr_ptr_r_reg[1]_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    ret_carry_i_7
       (.I0(wr_ptr_r[4]),
        .I1(wr_ptr_r[5]),
        .I2(wr_ptr_r[6]),
        .I3(wr_ptr_r[7]),
        .I4(wr_ptr_r[9]),
        .I5(wr_ptr_r[8]),
        .O(ret_carry_i_7_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ret_inferred__1/i__carry 
       (.CI(1'b0),
        .CO({\ret_inferred__1/i__carry_n_0 ,\ret_inferred__1/i__carry_n_1 ,\ret_inferred__1/i__carry_n_2 ,\ret_inferred__1/i__carry_n_3 }),
        .CYINIT(i__carry_i_1_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ret_inferred__1/i__carry_n_4 ,\ret_inferred__1/i__carry_n_5 ,\ret_inferred__1/i__carry_n_6 ,\ret_inferred__1/i__carry_n_7 }),
        .S({i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0,i__carry_i_5_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ret_inferred__1/i__carry__0 
       (.CI(\ret_inferred__1/i__carry_n_0 ),
        .CO({\ret_inferred__1/i__carry__0_n_0 ,\ret_inferred__1/i__carry__0_n_1 ,\ret_inferred__1/i__carry__0_n_2 ,\ret_inferred__1/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\ret_inferred__1/i__carry__0_n_4 ,\ret_inferred__1/i__carry__0_n_5 ,\ret_inferred__1/i__carry__0_n_6 ,\ret_inferred__1/i__carry__0_n_7 }),
        .S({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \ret_inferred__1/i__carry__1 
       (.CI(\ret_inferred__1/i__carry__0_n_0 ),
        .CO({\NLW_ret_inferred__1/i__carry__1_CO_UNCONNECTED [3:2],\ret_inferred__1/i__carry__1_n_2 ,\ret_inferred__1/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_ret_inferred__1/i__carry__1_O_UNCONNECTED [3],\ret_inferred__1/i__carry__1_n_5 ,\ret_inferred__1/i__carry__1_n_6 ,\ret_inferred__1/i__carry__1_n_7 }),
        .S({1'b0,i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3__1_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    valid_r_i_1
       (.I0(\wr_ptr_r_reg[0]_0 ),
        .I1(fifo_clear_i),
        .O(rst));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h2)) 
    valid_r_i_2
       (.I0(fifo_re_i),
        .I1(empty_r),
        .O(p_2_in));
  FDRE valid_r_reg
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(p_2_in),
        .Q(fifo_valid_o),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[0] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry_n_7),
        .Q(wr_ptr_r[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[10] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__1_n_5),
        .Q(wr_ptr_r[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[1] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry_n_6),
        .Q(wr_ptr_r[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[2] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry_n_5),
        .Q(wr_ptr_r[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[3] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry_n_4),
        .Q(wr_ptr_r[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[4] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__0_n_7),
        .Q(wr_ptr_r[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[5] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__0_n_6),
        .Q(wr_ptr_r[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[6] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__0_n_5),
        .Q(wr_ptr_r[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[7] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__0_n_4),
        .Q(wr_ptr_r[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[8] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__1_n_7),
        .Q(wr_ptr_r[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \wr_ptr_r_reg[9] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(ret_carry__1_n_6),
        .Q(wr_ptr_r[9]),
        .R(rst));
endmodule

(* ORIG_REF_NAME = "GraySync" *) 
module comblock_setup_comblock_0_0_GraySync
   (S,
    DI,
    \data_r_reg[1][7]_0 ,
    \data_r_reg[1][7]_1 ,
    \data_r_reg[1][10]_0 ,
    \_inferred__1/i__carry__0 ,
    \data_r_reg[1][10]_1 ,
    O,
    \_inferred__1/i__carry__1 ,
    \_inferred__1/i__carry__0_0 ,
    \_inferred__1/i__carry__1_0 ,
    Q,
    \data_r_reg[0][10]_0 ,
    full_r_reg,
    full_r_reg_0,
    axil_aclk);
  output [3:0]S;
  output [3:0]DI;
  output [3:0]\data_r_reg[1][7]_0 ;
  output [3:0]\data_r_reg[1][7]_1 ;
  output [2:0]\data_r_reg[1][10]_0 ;
  output \_inferred__1/i__carry__0 ;
  output [1:0]\data_r_reg[1][10]_1 ;
  input [3:0]O;
  input \_inferred__1/i__carry__1 ;
  input [3:0]\_inferred__1/i__carry__0_0 ;
  input [2:0]\_inferred__1/i__carry__1_0 ;
  input [0:0]Q;
  input [10:0]\data_r_reg[0][10]_0 ;
  input [2:0]full_r_reg;
  input [0:0]full_r_reg_0;
  input axil_aclk;

  wire [3:0]DI;
  wire [3:0]O;
  wire [0:0]Q;
  wire [3:0]S;
  wire \_inferred__1/i__carry__0 ;
  wire [3:0]\_inferred__1/i__carry__0_0 ;
  wire \_inferred__1/i__carry__1 ;
  wire [2:0]\_inferred__1/i__carry__1_0 ;
  wire axil_aclk;
  wire [9:0]bin2gray;
  wire [10:0]\data_r_reg[0] ;
  wire [10:0]\data_r_reg[0][10]_0 ;
  wire [2:0]\data_r_reg[1][10]_0 ;
  wire [1:0]\data_r_reg[1][10]_1 ;
  wire [3:0]\data_r_reg[1][7]_0 ;
  wire [3:0]\data_r_reg[1][7]_1 ;
  wire \data_r_reg_n_0_[1][0] ;
  wire \data_r_reg_n_0_[1][9] ;
  wire [2:0]full_r_reg;
  wire [0:0]full_r_reg_0;
  wire p_0_in;
  wire p_0_in11_in;
  wire p_0_in14_in;
  wire p_0_in17_in;
  wire p_0_in20_in;
  wire p_0_in2_in;
  wire p_0_in5_in;
  wire p_0_in8_in;
  wire p_1_in;
  wire [6:0]rd_in_wr_bin;

  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][0]_i_1 
       (.I0(\data_r_reg[0][10]_0 [0]),
        .I1(\data_r_reg[0][10]_0 [1]),
        .O(bin2gray[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][1]_i_1 
       (.I0(\data_r_reg[0][10]_0 [1]),
        .I1(\data_r_reg[0][10]_0 [2]),
        .O(bin2gray[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][2]_i_1 
       (.I0(\data_r_reg[0][10]_0 [2]),
        .I1(\data_r_reg[0][10]_0 [3]),
        .O(bin2gray[2]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][3]_i_1 
       (.I0(\data_r_reg[0][10]_0 [3]),
        .I1(\data_r_reg[0][10]_0 [4]),
        .O(bin2gray[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][4]_i_1 
       (.I0(\data_r_reg[0][10]_0 [4]),
        .I1(\data_r_reg[0][10]_0 [5]),
        .O(bin2gray[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][5]_i_1 
       (.I0(\data_r_reg[0][10]_0 [5]),
        .I1(\data_r_reg[0][10]_0 [6]),
        .O(bin2gray[5]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][6]_i_1 
       (.I0(\data_r_reg[0][10]_0 [6]),
        .I1(\data_r_reg[0][10]_0 [7]),
        .O(bin2gray[6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][7]_i_1 
       (.I0(\data_r_reg[0][10]_0 [7]),
        .I1(\data_r_reg[0][10]_0 [8]),
        .O(bin2gray[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][8]_i_1 
       (.I0(\data_r_reg[0][10]_0 [8]),
        .I1(\data_r_reg[0][10]_0 [9]),
        .O(bin2gray[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][9]_i_1 
       (.I0(\data_r_reg[0][10]_0 [9]),
        .I1(\data_r_reg[0][10]_0 [10]),
        .O(bin2gray[9]));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][0] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[0]),
        .Q(\data_r_reg[0] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][10] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0][10]_0 [10]),
        .Q(\data_r_reg[0] [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][1] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[1]),
        .Q(\data_r_reg[0] [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][2] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[2]),
        .Q(\data_r_reg[0] [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][3] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[3]),
        .Q(\data_r_reg[0] [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][4] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[4]),
        .Q(\data_r_reg[0] [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][5] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[5]),
        .Q(\data_r_reg[0] [5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][6] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[6]),
        .Q(\data_r_reg[0] [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][7] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[7]),
        .Q(\data_r_reg[0] [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][8] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[8]),
        .Q(\data_r_reg[0] [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][9] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(bin2gray[9]),
        .Q(\data_r_reg[0] [9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][0] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [0]),
        .Q(\data_r_reg_n_0_[1][0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][10] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [10]),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][1] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [1]),
        .Q(p_0_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][2] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [2]),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][3] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [3]),
        .Q(p_0_in5_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][4] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [4]),
        .Q(p_0_in8_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][5] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [5]),
        .Q(p_0_in11_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][6] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [6]),
        .Q(p_0_in14_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][7] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [7]),
        .Q(p_0_in17_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][8] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [8]),
        .Q(p_0_in20_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][9] 
       (.C(axil_aclk),
        .CE(1'b1),
        .D(\data_r_reg[0] [9]),
        .Q(\data_r_reg_n_0_[1][9] ),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h0004)) 
    full_r_i_3
       (.I0(full_r_reg[1]),
        .I1(full_r_reg[2]),
        .I2(full_r_reg[0]),
        .I3(full_r_reg_0),
        .O(\_inferred__1/i__carry__0 ));
  LUT4 #(
    .INIT(16'h9669)) 
    i__carry__0_i_1__1
       (.I0(p_0_in17_in),
        .I1(\data_r_reg_n_0_[1][9] ),
        .I2(p_1_in),
        .I3(p_0_in20_in),
        .O(\data_r_reg[1][7]_1 [3]));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_2__1
       (.I0(rd_in_wr_bin[6]),
        .O(\data_r_reg[1][7]_1 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_3__1
       (.I0(rd_in_wr_bin[5]),
        .O(\data_r_reg[1][7]_1 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4__1
       (.I0(rd_in_wr_bin[5]),
        .I1(p_0_in8_in),
        .O(\data_r_reg[1][7]_1 [0]));
  LUT6 #(
    .INIT(64'h9669966969969669)) 
    i__carry__0_i_5
       (.I0(p_0_in17_in),
        .I1(\data_r_reg_n_0_[1][9] ),
        .I2(p_1_in),
        .I3(p_0_in20_in),
        .I4(\_inferred__1/i__carry__0_0 [3]),
        .I5(\_inferred__1/i__carry__1 ),
        .O(\data_r_reg[1][7]_0 [3]));
  LUT3 #(
    .INIT(8'h59)) 
    i__carry__0_i_6__0
       (.I0(rd_in_wr_bin[6]),
        .I1(\_inferred__1/i__carry__0_0 [2]),
        .I2(\_inferred__1/i__carry__1 ),
        .O(\data_r_reg[1][7]_0 [2]));
  LUT3 #(
    .INIT(8'h59)) 
    i__carry__0_i_7__0
       (.I0(rd_in_wr_bin[5]),
        .I1(\_inferred__1/i__carry__0_0 [1]),
        .I2(\_inferred__1/i__carry__1 ),
        .O(\data_r_reg[1][7]_0 [1]));
  LUT4 #(
    .INIT(16'h9969)) 
    i__carry__0_i_8__0
       (.I0(p_0_in8_in),
        .I1(rd_in_wr_bin[5]),
        .I2(\_inferred__1/i__carry__0_0 [0]),
        .I3(\_inferred__1/i__carry__1 ),
        .O(\data_r_reg[1][7]_0 [0]));
  LUT5 #(
    .INIT(32'h96696996)) 
    i__carry__0_i_9
       (.I0(p_0_in14_in),
        .I1(p_0_in20_in),
        .I2(p_1_in),
        .I3(\data_r_reg_n_0_[1][9] ),
        .I4(p_0_in17_in),
        .O(rd_in_wr_bin[6]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_1__1
       (.I0(p_1_in),
        .I1(\data_r_reg_n_0_[1][9] ),
        .O(\data_r_reg[1][10]_1 [1]));
  LUT3 #(
    .INIT(8'h69)) 
    i__carry__1_i_2__1
       (.I0(\data_r_reg_n_0_[1][9] ),
        .I1(p_1_in),
        .I2(p_0_in20_in),
        .O(\data_r_reg[1][10]_1 [0]));
  LUT4 #(
    .INIT(16'h59A9)) 
    i__carry__1_i_3
       (.I0(p_1_in),
        .I1(\_inferred__1/i__carry__1_0 [2]),
        .I2(\_inferred__1/i__carry__1 ),
        .I3(Q),
        .O(\data_r_reg[1][10]_0 [2]));
  LUT4 #(
    .INIT(16'hA659)) 
    i__carry__1_i_4__0
       (.I0(\data_r_reg_n_0_[1][9] ),
        .I1(\_inferred__1/i__carry__1_0 [1]),
        .I2(\_inferred__1/i__carry__1 ),
        .I3(p_1_in),
        .O(\data_r_reg[1][10]_0 [1]));
  LUT5 #(
    .INIT(32'h69699669)) 
    i__carry__1_i_5__0
       (.I0(p_0_in20_in),
        .I1(p_1_in),
        .I2(\data_r_reg_n_0_[1][9] ),
        .I3(\_inferred__1/i__carry__1_0 [0]),
        .I4(\_inferred__1/i__carry__1 ),
        .O(\data_r_reg[1][10]_0 [0]));
  LUT5 #(
    .INIT(32'h96696996)) 
    i__carry_i_10
       (.I0(p_0_in),
        .I1(p_0_in5_in),
        .I2(rd_in_wr_bin[5]),
        .I3(p_0_in8_in),
        .I4(p_0_in2_in),
        .O(rd_in_wr_bin[1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    i__carry_i_12
       (.I0(\data_r_reg_n_0_[1][0] ),
        .I1(p_0_in2_in),
        .I2(p_0_in8_in),
        .I3(rd_in_wr_bin[5]),
        .I4(p_0_in5_in),
        .I5(p_0_in),
        .O(rd_in_wr_bin[0]));
  LUT3 #(
    .INIT(8'h69)) 
    i__carry_i_1__1
       (.I0(p_0_in5_in),
        .I1(rd_in_wr_bin[5]),
        .I2(p_0_in8_in),
        .O(DI[3]));
  LUT4 #(
    .INIT(16'h9669)) 
    i__carry_i_2__1
       (.I0(p_0_in2_in),
        .I1(p_0_in8_in),
        .I2(rd_in_wr_bin[5]),
        .I3(p_0_in5_in),
        .O(DI[2]));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_3__1
       (.I0(rd_in_wr_bin[1]),
        .O(DI[1]));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4__1
       (.I0(rd_in_wr_bin[1]),
        .I1(\data_r_reg_n_0_[1][0] ),
        .O(DI[0]));
  LUT5 #(
    .INIT(32'h69699669)) 
    i__carry_i_5__1
       (.I0(p_0_in5_in),
        .I1(rd_in_wr_bin[5]),
        .I2(p_0_in8_in),
        .I3(O[3]),
        .I4(\_inferred__1/i__carry__1 ),
        .O(S[3]));
  LUT6 #(
    .INIT(64'h9669966969969669)) 
    i__carry_i_6__0
       (.I0(p_0_in2_in),
        .I1(p_0_in8_in),
        .I2(rd_in_wr_bin[5]),
        .I3(p_0_in5_in),
        .I4(O[2]),
        .I5(\_inferred__1/i__carry__1 ),
        .O(S[2]));
  LUT3 #(
    .INIT(8'h59)) 
    i__carry_i_7__1
       (.I0(rd_in_wr_bin[1]),
        .I1(O[1]),
        .I2(\_inferred__1/i__carry__1 ),
        .O(S[1]));
  LUT3 #(
    .INIT(8'h59)) 
    i__carry_i_8__1
       (.I0(rd_in_wr_bin[0]),
        .I1(O[0]),
        .I2(\_inferred__1/i__carry__1 ),
        .O(S[0]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    i__carry_i_9
       (.I0(p_0_in11_in),
        .I1(p_0_in17_in),
        .I2(\data_r_reg_n_0_[1][9] ),
        .I3(p_1_in),
        .I4(p_0_in20_in),
        .I5(p_0_in14_in),
        .O(rd_in_wr_bin[5]));
endmodule

(* ORIG_REF_NAME = "GraySync" *) 
module comblock_setup_comblock_0_0_GraySync_0
   (S,
    \data_r_reg[1][7]_0 ,
    \rd_ptr_r_reg[10] ,
    ret,
    ret1__9,
    Q,
    \data_r_reg[0][10]_0 ,
    fifo_clk_i);
  output [3:0]S;
  output [3:0]\data_r_reg[1][7]_0 ;
  output [2:0]\rd_ptr_r_reg[10] ;
  input [10:0]ret;
  input ret1__9;
  input [0:0]Q;
  input [10:0]\data_r_reg[0][10]_0 ;
  input fifo_clk_i;

  wire [0:0]Q;
  wire [3:0]S;
  wire [9:0]bin2gray;
  wire [10:0]\data_r_reg[0][10]_0 ;
  wire [3:0]\data_r_reg[1][7]_0 ;
  wire \data_r_reg_n_0_[0][0] ;
  wire \data_r_reg_n_0_[0][10] ;
  wire \data_r_reg_n_0_[0][1] ;
  wire \data_r_reg_n_0_[0][2] ;
  wire \data_r_reg_n_0_[0][3] ;
  wire \data_r_reg_n_0_[0][4] ;
  wire \data_r_reg_n_0_[0][5] ;
  wire \data_r_reg_n_0_[0][6] ;
  wire \data_r_reg_n_0_[0][7] ;
  wire \data_r_reg_n_0_[0][8] ;
  wire \data_r_reg_n_0_[0][9] ;
  wire \data_r_reg_n_0_[1][0] ;
  wire \data_r_reg_n_0_[1][9] ;
  wire fifo_clk_i;
  wire p_0_in;
  wire p_0_in11_in;
  wire p_0_in14_in;
  wire p_0_in17_in;
  wire p_0_in20_in;
  wire p_0_in2_in;
  wire p_0_in5_in;
  wire p_0_in8_in;
  wire p_1_in;
  wire [2:0]\rd_ptr_r_reg[10] ;
  wire [10:0]ret;
  wire ret1__9;
  wire [6:1]wr_in_rd_bin;

  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][0]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [0]),
        .I1(\data_r_reg[0][10]_0 [1]),
        .O(bin2gray[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][1]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [1]),
        .I1(\data_r_reg[0][10]_0 [2]),
        .O(bin2gray[1]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][2]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [2]),
        .I1(\data_r_reg[0][10]_0 [3]),
        .O(bin2gray[2]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][3]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [3]),
        .I1(\data_r_reg[0][10]_0 [4]),
        .O(bin2gray[3]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][4]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [4]),
        .I1(\data_r_reg[0][10]_0 [5]),
        .O(bin2gray[4]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][5]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [5]),
        .I1(\data_r_reg[0][10]_0 [6]),
        .O(bin2gray[5]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][6]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [6]),
        .I1(\data_r_reg[0][10]_0 [7]),
        .O(bin2gray[6]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][7]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [7]),
        .I1(\data_r_reg[0][10]_0 [8]),
        .O(bin2gray[7]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][8]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [8]),
        .I1(\data_r_reg[0][10]_0 [9]),
        .O(bin2gray[8]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \data_r[0][9]_i_1__0 
       (.I0(\data_r_reg[0][10]_0 [9]),
        .I1(\data_r_reg[0][10]_0 [10]),
        .O(bin2gray[9]));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][0] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[0]),
        .Q(\data_r_reg_n_0_[0][0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][10] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg[0][10]_0 [10]),
        .Q(\data_r_reg_n_0_[0][10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][1] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[1]),
        .Q(\data_r_reg_n_0_[0][1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][2] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[2]),
        .Q(\data_r_reg_n_0_[0][2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][3] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[3]),
        .Q(\data_r_reg_n_0_[0][3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][4] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[4]),
        .Q(\data_r_reg_n_0_[0][4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][5] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[5]),
        .Q(\data_r_reg_n_0_[0][5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][6] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[6]),
        .Q(\data_r_reg_n_0_[0][6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][7] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[7]),
        .Q(\data_r_reg_n_0_[0][7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][8] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[8]),
        .Q(\data_r_reg_n_0_[0][8] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[0][9] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(bin2gray[9]),
        .Q(\data_r_reg_n_0_[0][9] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][0] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][0] ),
        .Q(\data_r_reg_n_0_[1][0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][10] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][10] ),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][1] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][1] ),
        .Q(p_0_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][2] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][2] ),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][3] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][3] ),
        .Q(p_0_in5_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][4] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][4] ),
        .Q(p_0_in8_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][5] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][5] ),
        .Q(p_0_in11_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][6] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][6] ),
        .Q(p_0_in14_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][7] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][7] ),
        .Q(p_0_in17_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][8] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][8] ),
        .Q(p_0_in20_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \data_r_reg[1][9] 
       (.C(fifo_clk_i),
        .CE(1'b1),
        .D(\data_r_reg_n_0_[0][9] ),
        .Q(\data_r_reg_n_0_[1][9] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h96696996)) 
    i__carry__0_i_10
       (.I0(p_0_in14_in),
        .I1(p_0_in20_in),
        .I2(p_1_in),
        .I3(\data_r_reg_n_0_[1][9] ),
        .I4(p_0_in17_in),
        .O(wr_in_rd_bin[6]));
  LUT6 #(
    .INIT(64'hB44B4BB44BB4B44B)) 
    i__carry__0_i_5__0
       (.I0(ret1__9),
        .I1(ret[7]),
        .I2(p_0_in17_in),
        .I3(\data_r_reg_n_0_[1][9] ),
        .I4(p_1_in),
        .I5(p_0_in20_in),
        .O(\data_r_reg[1][7]_0 [3]));
  LUT3 #(
    .INIT(8'h39)) 
    i__carry__0_i_6
       (.I0(ret[6]),
        .I1(wr_in_rd_bin[6]),
        .I2(ret1__9),
        .O(\data_r_reg[1][7]_0 [2]));
  LUT3 #(
    .INIT(8'h39)) 
    i__carry__0_i_7
       (.I0(ret[5]),
        .I1(wr_in_rd_bin[5]),
        .I2(ret1__9),
        .O(\data_r_reg[1][7]_0 [1]));
  LUT4 #(
    .INIT(16'hD22D)) 
    i__carry__0_i_8
       (.I0(ret[4]),
        .I1(ret1__9),
        .I2(p_0_in8_in),
        .I3(wr_in_rd_bin[5]),
        .O(\data_r_reg[1][7]_0 [0]));
  LUT4 #(
    .INIT(16'h748B)) 
    i__carry__1_i_3__0
       (.I0(Q),
        .I1(ret1__9),
        .I2(ret[10]),
        .I3(p_1_in),
        .O(\rd_ptr_r_reg[10] [2]));
  LUT4 #(
    .INIT(16'hC369)) 
    i__carry__1_i_4
       (.I0(ret[9]),
        .I1(\data_r_reg_n_0_[1][9] ),
        .I2(p_1_in),
        .I3(ret1__9),
        .O(\rd_ptr_r_reg[10] [1]));
  LUT5 #(
    .INIT(32'h2DD2D22D)) 
    i__carry__1_i_5
       (.I0(ret[8]),
        .I1(ret1__9),
        .I2(p_0_in20_in),
        .I3(p_1_in),
        .I4(\data_r_reg_n_0_[1][9] ),
        .O(\rd_ptr_r_reg[10] [0]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    i__carry_i_10__0
       (.I0(p_0_in11_in),
        .I1(p_0_in17_in),
        .I2(\data_r_reg_n_0_[1][9] ),
        .I3(p_1_in),
        .I4(p_0_in20_in),
        .I5(p_0_in14_in),
        .O(wr_in_rd_bin[5]));
  LUT5 #(
    .INIT(32'h96696996)) 
    i__carry_i_11
       (.I0(p_0_in),
        .I1(p_0_in5_in),
        .I2(wr_in_rd_bin[5]),
        .I3(p_0_in8_in),
        .I4(p_0_in2_in),
        .O(wr_in_rd_bin[1]));
  LUT5 #(
    .INIT(32'h2DD2D22D)) 
    i__carry_i_5__0
       (.I0(ret[3]),
        .I1(ret1__9),
        .I2(p_0_in5_in),
        .I3(wr_in_rd_bin[5]),
        .I4(p_0_in8_in),
        .O(S[3]));
  LUT6 #(
    .INIT(64'h9669966969969669)) 
    i__carry_i_6__1
       (.I0(p_0_in2_in),
        .I1(p_0_in8_in),
        .I2(wr_in_rd_bin[5]),
        .I3(p_0_in5_in),
        .I4(ret[2]),
        .I5(ret1__9),
        .O(S[2]));
  LUT3 #(
    .INIT(8'h39)) 
    i__carry_i_7__0
       (.I0(ret[1]),
        .I1(wr_in_rd_bin[1]),
        .I2(ret1__9),
        .O(S[1]));
  LUT4 #(
    .INIT(16'hD22D)) 
    i__carry_i_8__0
       (.I0(ret[0]),
        .I1(ret1__9),
        .I2(\data_r_reg_n_0_[1][0] ),
        .I3(wr_in_rd_bin[1]),
        .O(S[0]));
endmodule

(* ORIG_REF_NAME = "axi_comblock" *) 
module comblock_setup_comblock_0_0_axi_comblock
   (fifo_data_o,
    axil_awready,
    axil_wready,
    axil_arready,
    axil_rdata,
    axi_rvalid_reg,
    fifo_empty_o,
    fifo_valid_o,
    reg0_o,
    reg1_o,
    fifo_underflow_o,
    fifo_aempty_o,
    axil_bvalid,
    axil_aclk,
    fifo_clk_i,
    axil_wdata,
    axil_awaddr,
    axil_araddr,
    axil_arvalid,
    axil_awvalid,
    axil_wvalid,
    fifo_clear_i,
    fifo_re_i,
    reg5_i,
    reg4_i,
    reg1_i,
    reg3_i,
    reg0_i,
    reg2_i,
    axil_aresetn,
    axil_bready,
    axil_rready);
  output [23:0]fifo_data_o;
  output axil_awready;
  output axil_wready;
  output axil_arready;
  output [31:0]axil_rdata;
  output axi_rvalid_reg;
  output fifo_empty_o;
  output fifo_valid_o;
  output [31:0]reg0_o;
  output [31:0]reg1_o;
  output fifo_underflow_o;
  output fifo_aempty_o;
  output axil_bvalid;
  input axil_aclk;
  input fifo_clk_i;
  input [31:0]axil_wdata;
  input [5:0]axil_awaddr;
  input [5:0]axil_araddr;
  input axil_arvalid;
  input axil_awvalid;
  input axil_wvalid;
  input fifo_clear_i;
  input fifo_re_i;
  input [31:0]reg5_i;
  input [31:0]reg4_i;
  input [31:0]reg1_i;
  input [31:0]reg3_i;
  input [31:0]reg0_i;
  input [31:0]reg2_i;
  input axil_aresetn;
  input axil_bready;
  input axil_rready;

  wire AXIL_inst_n_5;
  wire AXIL_inst_n_8;
  wire axi_rvalid_reg;
  wire axil_aclk;
  wire [5:0]axil_araddr;
  wire axil_aresetn;
  wire axil_arready;
  wire axil_arvalid;
  wire [5:0]axil_awaddr;
  wire axil_awready;
  wire axil_awvalid;
  wire axil_bready;
  wire axil_bvalid;
  wire [31:0]axil_rdata;
  wire axil_rready;
  wire [31:0]axil_wdata;
  wire axil_wready;
  wire axil_wvalid;
  wire comblock_i_n_27;
  wire comblock_i_n_28;
  wire comblock_i_n_29;
  wire comblock_i_n_30;
  wire comblock_i_n_31;
  wire comblock_i_n_32;
  wire comblock_i_n_33;
  wire comblock_i_n_34;
  wire comblock_i_n_35;
  wire comblock_i_n_36;
  wire comblock_i_n_37;
  wire comblock_i_n_41;
  wire comblock_i_n_42;
  wire comblock_i_n_43;
  wire comblock_i_n_45;
  wire comblock_i_n_46;
  wire fifo_aempty_o;
  wire fifo_clear_i;
  wire fifo_clk_i;
  wire [23:0]fifo_data_o;
  wire fifo_empty_o;
  wire \fifo_out_g.fifo_out_i/full_r ;
  wire \fifo_out_g.fifo_out_i/p_4_in ;
  wire \fifo_out_g.fifo_out_i/ret15_out ;
  wire fifo_out_over_r;
  wire fifo_out_over_r0_out;
  wire fifo_out_we;
  wire fifo_re_i;
  wire fifo_underflow_o;
  wire fifo_valid_o;
  wire [31:0]reg0_i;
  wire [31:0]reg0_o;
  wire [31:0]reg1_i;
  wire [31:0]reg1_o;
  wire [31:0]reg2_i;
  wire [31:0]reg3_i;
  wire [31:0]reg4_i;
  wire [31:0]reg5_i;
  wire \regs_out[0]_1 ;
  wire \regs_out[1]_0 ;

  comblock_setup_comblock_0_0_AXIL AXIL_inst
       (.E(\regs_out[1]_0 ),
        .O({comblock_i_n_35,comblock_i_n_36,comblock_i_n_37}),
        .\axi_awaddr_reg[2]_0 (AXIL_inst_n_8),
        .\axi_awaddr_reg[6]_0 (\regs_out[0]_1 ),
        .\axi_awaddr_reg[7]_0 (AXIL_inst_n_5),
        .\axi_rdata_reg[0]_0 (comblock_i_n_43),
        .\axi_rdata_reg[0]_1 (comblock_i_n_42),
        .\axi_rdata_reg[0]_2 (comblock_i_n_41),
        .\axi_rdata_reg[19]_0 ({comblock_i_n_27,comblock_i_n_28,comblock_i_n_29,comblock_i_n_30}),
        .\axi_rdata_reg[1]_0 (comblock_i_n_46),
        .\axi_rdata_reg[1]_1 (comblock_i_n_45),
        .\axi_rdata_reg[23]_0 ({comblock_i_n_31,comblock_i_n_32,comblock_i_n_33,comblock_i_n_34}),
        .axi_rvalid_reg_0(axi_rvalid_reg),
        .axil_aclk(axil_aclk),
        .axil_araddr(axil_araddr),
        .axil_aresetn(axil_aresetn),
        .axil_arready(axil_arready),
        .axil_arvalid(axil_arvalid),
        .axil_awaddr(axil_awaddr),
        .axil_awready(axil_awready),
        .axil_awvalid(axil_awvalid),
        .axil_bready(axil_bready),
        .axil_bvalid(axil_bvalid),
        .axil_rdata(axil_rdata),
        .axil_rready(axil_rready),
        .axil_wready(axil_wready),
        .axil_wvalid(axil_wvalid),
        .fifo_out_over_r(fifo_out_over_r),
        .fifo_out_over_r0_out(fifo_out_over_r0_out),
        .fifo_out_we(fifo_out_we),
        .full_r(\fifo_out_g.fifo_out_i/full_r ),
        .p_4_in(\fifo_out_g.fifo_out_i/p_4_in ),
        .reg0_i(reg0_i),
        .reg0_o(reg0_o),
        .reg1_i(reg1_i),
        .reg1_o(reg1_o),
        .reg2_i(reg2_i),
        .reg3_i(reg3_i),
        .reg4_i(reg4_i),
        .reg5_i(reg5_i),
        .ret15_out(\fifo_out_g.fifo_out_i/ret15_out ));
  comblock_setup_comblock_0_0_ComBlock comblock_i
       (.E(\regs_out[0]_1 ),
        .O({comblock_i_n_35,comblock_i_n_36,comblock_i_n_37}),
        .\_inferred__1/i__carry (comblock_i_n_41),
        .\_inferred__1/i__carry_0 (comblock_i_n_43),
        .\_inferred__1/i__carry_1 (comblock_i_n_45),
        .\_inferred__1/i__carry__0 (comblock_i_n_42),
        .\_inferred__1/i__carry__1 (comblock_i_n_46),
        .axil_aclk(axil_aclk),
        .axil_wdata(axil_wdata),
        .\data_r_reg[1][3] ({comblock_i_n_27,comblock_i_n_28,comblock_i_n_29,comblock_i_n_30}),
        .\data_r_reg[1][7] ({comblock_i_n_31,comblock_i_n_32,comblock_i_n_33,comblock_i_n_34}),
        .fifo_aempty_o(fifo_aempty_o),
        .fifo_clear_i(fifo_clear_i),
        .fifo_clk_i(fifo_clk_i),
        .fifo_data_o(fifo_data_o),
        .fifo_empty_o(fifo_empty_o),
        .fifo_out_clear_reg_0(AXIL_inst_n_5),
        .fifo_out_over_r(fifo_out_over_r),
        .fifo_out_over_r0_out(fifo_out_over_r0_out),
        .fifo_out_we(fifo_out_we),
        .fifo_re_i(fifo_re_i),
        .fifo_underflow_o(fifo_underflow_o),
        .fifo_valid_o(fifo_valid_o),
        .full_r(\fifo_out_g.fifo_out_i/full_r ),
        .p_4_in(\fifo_out_g.fifo_out_i/p_4_in ),
        .reg0_o(reg0_o),
        .reg1_o(reg1_o),
        .\regs_out_reg[1][31]_0 (\regs_out[1]_0 ),
        .ret15_out(\fifo_out_g.fifo_out_i/ret15_out ),
        .\wr_ptr_r_reg[3] (AXIL_inst_n_8));
endmodule

(* ORIG_REF_NAME = "tdpram" *) 
module comblock_setup_comblock_0_0_tdpram
   (fifo_data_o,
    axil_aclk,
    fifo_clk_i,
    p_4_in,
    Q,
    ram_reg_0,
    axil_wdata);
  output [23:0]fifo_data_o;
  input axil_aclk;
  input fifo_clk_i;
  input p_4_in;
  input [9:0]Q;
  input [9:0]ram_reg_0;
  input [23:0]axil_wdata;

  wire [9:0]Q;
  wire axil_aclk;
  wire [23:0]axil_wdata;
  wire fifo_clk_i;
  wire [23:0]fifo_data_o;
  wire p_4_in;
  wire [9:0]ram_reg_0;
  wire NLW_ram_reg_CASCADEOUTA_UNCONNECTED;
  wire NLW_ram_reg_CASCADEOUTB_UNCONNECTED;
  wire NLW_ram_reg_DBITERR_UNCONNECTED;
  wire NLW_ram_reg_INJECTDBITERR_UNCONNECTED;
  wire NLW_ram_reg_INJECTSBITERR_UNCONNECTED;
  wire NLW_ram_reg_SBITERR_UNCONNECTED;
  wire [31:0]NLW_ram_reg_DOADO_UNCONNECTED;
  wire [31:24]NLW_ram_reg_DOBDO_UNCONNECTED;
  wire [3:0]NLW_ram_reg_DOPADOP_UNCONNECTED;
  wire [3:0]NLW_ram_reg_DOPBDOP_UNCONNECTED;
  wire [7:0]NLW_ram_reg_ECCPARITY_UNCONNECTED;
  wire [8:0]NLW_ram_reg_RDADDRECC_UNCONNECTED;

  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d24" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d24" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "24576" *) 
  (* RTL_RAM_NAME = "U0/comblock_i/fifo_out_g.fifo_out_i/i_memory/ram_reg" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "1023" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "23" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(36),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(36),
    .WRITE_WIDTH_B(36)) 
    ram_reg
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,ram_reg_0,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b1),
        .CASCADEINB(1'b1),
        .CASCADEOUTA(NLW_ram_reg_CASCADEOUTA_UNCONNECTED),
        .CASCADEOUTB(NLW_ram_reg_CASCADEOUTB_UNCONNECTED),
        .CLKARDCLK(axil_aclk),
        .CLKBWRCLK(fifo_clk_i),
        .DBITERR(NLW_ram_reg_DBITERR_UNCONNECTED),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,axil_wdata}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(NLW_ram_reg_DOADO_UNCONNECTED[31:0]),
        .DOBDO({NLW_ram_reg_DOBDO_UNCONNECTED[31:24],fifo_data_o}),
        .DOPADOP(NLW_ram_reg_DOPADOP_UNCONNECTED[3:0]),
        .DOPBDOP(NLW_ram_reg_DOPBDOP_UNCONNECTED[3:0]),
        .ECCPARITY(NLW_ram_reg_ECCPARITY_UNCONNECTED[7:0]),
        .ENARDEN(p_4_in),
        .ENBWREN(1'b1),
        .INJECTDBITERR(NLW_ram_reg_INJECTDBITERR_UNCONNECTED),
        .INJECTSBITERR(NLW_ram_reg_INJECTSBITERR_UNCONNECTED),
        .RDADDRECC(NLW_ram_reg_RDADDRECC_UNCONNECTED[8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(NLW_ram_reg_SBITERR_UNCONNECTED),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
