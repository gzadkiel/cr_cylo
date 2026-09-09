-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
-- Date        : Thu Sep  3 10:42:01 2026
-- Host        : Geronimo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/gm/Vivado
--               Projects/complete_det_final_debug/complete_det_final_debug.gen/sources_1/bd/comblock_setup/ip/comblock_setup_comblock_0_0/comblock_setup_comblock_0_0_stub.vhdl}
-- Design      : comblock_setup_comblock_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comblock_setup_comblock_0_0 is
  Port ( 
    reg0_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg1_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg2_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg3_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg4_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg5_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg0_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    reg1_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    fifo_clk_i : in STD_LOGIC;
    fifo_clear_i : in STD_LOGIC;
    fifo_re_i : in STD_LOGIC;
    fifo_data_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    fifo_valid_o : out STD_LOGIC;
    fifo_empty_o : out STD_LOGIC;
    fifo_aempty_o : out STD_LOGIC;
    fifo_underflow_o : out STD_LOGIC;
    axil_aclk : in STD_LOGIC;
    axil_aresetn : in STD_LOGIC;
    axil_awaddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axil_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axil_awvalid : in STD_LOGIC;
    axil_awready : out STD_LOGIC;
    axil_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axil_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axil_wvalid : in STD_LOGIC;
    axil_wready : out STD_LOGIC;
    axil_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axil_bvalid : out STD_LOGIC;
    axil_bready : in STD_LOGIC;
    axil_araddr : in STD_LOGIC_VECTOR ( 7 downto 0 );
    axil_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axil_arvalid : in STD_LOGIC;
    axil_arready : out STD_LOGIC;
    axil_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axil_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    axil_rvalid : out STD_LOGIC;
    axil_rready : in STD_LOGIC
  );

end comblock_setup_comblock_0_0;

architecture stub of comblock_setup_comblock_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "reg0_i[31:0],reg1_i[31:0],reg2_i[31:0],reg3_i[31:0],reg4_i[31:0],reg5_i[31:0],reg0_o[31:0],reg1_o[31:0],fifo_clk_i,fifo_clear_i,fifo_re_i,fifo_data_o[23:0],fifo_valid_o,fifo_empty_o,fifo_aempty_o,fifo_underflow_o,axil_aclk,axil_aresetn,axil_awaddr[7:0],axil_awprot[2:0],axil_awvalid,axil_awready,axil_wdata[31:0],axil_wstrb[3:0],axil_wvalid,axil_wready,axil_bresp[1:0],axil_bvalid,axil_bready,axil_araddr[7:0],axil_arprot[2:0],axil_arvalid,axil_arready,axil_rdata[31:0],axil_rresp[1:0],axil_rvalid,axil_rready";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "axi_comblock,Vivado 2023.1";
begin
end;
