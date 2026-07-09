-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
-- Date        : Mon Jul  6 15:21:38 2026
-- Host        : Geronimo running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ comblock_setup_comblock_0_0_sim_netlist.vhdl
-- Design      : comblock_setup_comblock_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_AXIL is
  port (
    axil_awready : out STD_LOGIC;
    axil_wready : out STD_LOGIC;
    axil_arready : out STD_LOGIC;
    axil_bvalid : out STD_LOGIC;
    axi_rvalid_reg_0 : out STD_LOGIC;
    \axi_awaddr_reg[7]_0\ : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    rd_val_o_reg_0 : out STD_LOGIC;
    \axi_araddr_reg[2]_0\ : out STD_LOGIC;
    p_4_in : out STD_LOGIC;
    \axi_awaddr_reg[7]_1\ : out STD_LOGIC;
    \axi_araddr_reg[3]_0\ : out STD_LOGIC;
    \axi_araddr_reg[3]_1\ : out STD_LOGIC;
    \regs_out_reg[0][1]\ : out STD_LOGIC;
    axil_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axil_aclk : in STD_LOGIC;
    full_r : in STD_LOGIC;
    fifo_out_over_r : in STD_LOGIC;
    axil_awvalid : in STD_LOGIC;
    axil_wvalid : in STD_LOGIC;
    \axi_rdata_reg[1]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    reg0_i : in STD_LOGIC_VECTOR ( 30 downto 0 );
    reg0_o : in STD_LOGIC_VECTOR ( 30 downto 0 );
    O : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \axi_rdata_reg[23]_0\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \axi_rdata_reg[26]_0\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    axil_aresetn : in STD_LOGIC;
    axil_bready : in STD_LOGIC;
    axil_arvalid : in STD_LOGIC;
    axil_rready : in STD_LOGIC;
    axil_awaddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axil_araddr : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_AXIL;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_AXIL is
  signal aw_en_i_1_n_0 : STD_LOGIC;
  signal aw_en_reg_n_0 : STD_LOGIC;
  signal \^axi_araddr_reg[2]_0\ : STD_LOGIC;
  signal \^axi_araddr_reg[3]_0\ : STD_LOGIC;
  signal \^axi_araddr_reg[3]_1\ : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal \^axi_awaddr_reg[7]_1\ : STD_LOGIC;
  signal axi_awready0 : STD_LOGIC;
  signal axi_awready_i_1_n_0 : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal \axi_rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal \^axi_rvalid_reg_0\ : STD_LOGIC;
  signal axi_wready0 : STD_LOGIC;
  signal \^axil_arready\ : STD_LOGIC;
  signal \^axil_awready\ : STD_LOGIC;
  signal \^axil_bvalid\ : STD_LOGIC;
  signal \^axil_wready\ : STD_LOGIC;
  signal fifo_out_over_r_i_2_n_0 : STD_LOGIC;
  signal reg_rd_adr : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal reg_rd_dat : STD_LOGIC_VECTOR ( 31 downto 2 );
  signal reg_rd_ena : STD_LOGIC;
  signal reg_wr_adr : STD_LOGIC_VECTOR ( 7 downto 2 );
  signal \regs_out[0][31]_i_2_n_0\ : STD_LOGIC;
  signal slv_reg_rden : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of fifo_out_clear_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \regs_out[0][31]_i_1\ : label is "soft_lutpair0";
begin
  \axi_araddr_reg[2]_0\ <= \^axi_araddr_reg[2]_0\;
  \axi_araddr_reg[3]_0\ <= \^axi_araddr_reg[3]_0\;
  \axi_araddr_reg[3]_1\ <= \^axi_araddr_reg[3]_1\;
  \axi_awaddr_reg[7]_1\ <= \^axi_awaddr_reg[7]_1\;
  axi_rvalid_reg_0 <= \^axi_rvalid_reg_0\;
  axil_arready <= \^axil_arready\;
  axil_awready <= \^axil_awready\;
  axil_bvalid <= \^axil_bvalid\;
  axil_wready <= \^axil_wready\;
aw_en_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFFFFF88888888"
    )
        port map (
      I0 => \^axil_bvalid\,
      I1 => axil_bready,
      I2 => \^axil_awready\,
      I3 => axil_wvalid,
      I4 => axil_awvalid,
      I5 => aw_en_reg_n_0,
      O => aw_en_i_1_n_0
    );
aw_en_reg: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => '1',
      D => aw_en_i_1_n_0,
      Q => aw_en_reg_n_0,
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(0),
      Q => reg_rd_adr(2),
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[3]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(1),
      Q => reg_rd_adr(3),
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[4]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(2),
      Q => reg_rd_adr(4),
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[5]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(3),
      Q => reg_rd_adr(5),
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[6]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(4),
      Q => reg_rd_adr(6),
      S => axi_awready_i_1_n_0
    );
\axi_araddr_reg[7]\: unisim.vcomponents.FDSE
     port map (
      C => axil_aclk,
      CE => axi_arready0,
      D => axil_araddr(5),
      Q => reg_rd_adr(7),
      S => axi_awready_i_1_n_0
    );
axi_arready_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => axil_arvalid,
      I1 => \^axil_arready\,
      O => axi_arready0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => axi_arready0,
      Q => \^axil_arready\,
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(0),
      Q => reg_wr_adr(2),
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(1),
      Q => reg_wr_adr(3),
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(2),
      Q => reg_wr_adr(4),
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(3),
      Q => reg_wr_adr(5),
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(4),
      Q => reg_wr_adr(6),
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => axi_awready0,
      D => axil_awaddr(5),
      Q => reg_wr_adr(7),
      R => axi_awready_i_1_n_0
    );
axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => axil_aresetn,
      O => axi_awready_i_1_n_0
    );
axi_awready_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \^axil_awready\,
      I1 => axil_wvalid,
      I2 => axil_awvalid,
      I3 => aw_en_reg_n_0,
      O => axi_awready0
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => axi_awready0,
      Q => \^axil_awready\,
      R => axi_awready_i_1_n_0
    );
axi_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7444444444444444"
    )
        port map (
      I0 => axil_bready,
      I1 => \^axil_bvalid\,
      I2 => axil_awvalid,
      I3 => axil_wvalid,
      I4 => \^axil_awready\,
      I5 => \^axil_wready\,
      O => axi_bvalid_i_1_n_0
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => axi_bvalid_i_1_n_0,
      Q => \^axil_bvalid\,
      R => axi_awready_i_1_n_0
    );
\axi_rdata[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(9),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(9),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(10)
    );
\axi_rdata[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(10),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(10),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(11)
    );
\axi_rdata[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(11),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(11),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(12)
    );
\axi_rdata[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(12),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(12),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(13)
    );
\axi_rdata[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(13),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(13),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(14)
    );
\axi_rdata[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(14),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(14),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(15)
    );
\axi_rdata[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(15),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(15),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => O(0),
      O => reg_rd_dat(16)
    );
\axi_rdata[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(16),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(16),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => O(1),
      O => reg_rd_dat(17)
    );
\axi_rdata[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(17),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(17),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => O(2),
      O => reg_rd_dat(18)
    );
\axi_rdata[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(18),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(18),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => O(3),
      O => reg_rd_dat(19)
    );
\axi_rdata[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(0),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(0),
      I3 => \^axi_araddr_reg[3]_0\,
      O => \regs_out_reg[0][1]\
    );
\axi_rdata[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(19),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(19),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[23]_0\(0),
      O => reg_rd_dat(20)
    );
\axi_rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(20),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(20),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[23]_0\(1),
      O => reg_rd_dat(21)
    );
\axi_rdata[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(21),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(21),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[23]_0\(2),
      O => reg_rd_dat(22)
    );
\axi_rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(22),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(22),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[23]_0\(3),
      O => reg_rd_dat(23)
    );
\axi_rdata[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(23),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(23),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[26]_0\(0),
      O => reg_rd_dat(24)
    );
\axi_rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(24),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(24),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[26]_0\(1),
      O => reg_rd_dat(25)
    );
\axi_rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(25),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(25),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => \axi_rdata_reg[26]_0\(2),
      O => reg_rd_dat(26)
    );
\axi_rdata[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFFFFFFFFF"
    )
        port map (
      I0 => reg_rd_adr(2),
      I1 => reg_rd_adr(5),
      I2 => reg_rd_adr(6),
      I3 => reg_rd_adr(7),
      I4 => reg_rd_adr(4),
      I5 => reg_rd_adr(3),
      O => \^axi_araddr_reg[2]_0\
    );
\axi_rdata[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(26),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(26),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(27)
    );
\axi_rdata[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(27),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(27),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(28)
    );
\axi_rdata[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(28),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(28),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(29)
    );
\axi_rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888FFFFF888F888"
    )
        port map (
      I0 => \^axi_araddr_reg[3]_0\,
      I1 => reg0_i(1),
      I2 => \^axi_araddr_reg[3]_1\,
      I3 => reg0_o(1),
      I4 => \^axi_araddr_reg[2]_0\,
      I5 => fifo_out_over_r,
      O => reg_rd_dat(2)
    );
\axi_rdata[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(29),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(29),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(30)
    );
\axi_rdata[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => \^axi_rvalid_reg_0\,
      I1 => axil_arvalid,
      I2 => \^axil_arready\,
      O => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(30),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(30),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(31)
    );
\axi_rdata[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => reg_rd_adr(3),
      I1 => reg_rd_adr(4),
      I2 => reg_rd_adr(5),
      I3 => reg_rd_adr(2),
      I4 => reg_rd_adr(7),
      I5 => reg_rd_adr(6),
      O => \^axi_araddr_reg[3]_1\
    );
\axi_rdata[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => reg_rd_adr(3),
      I1 => reg_rd_adr(4),
      I2 => reg_rd_adr(5),
      I3 => reg_rd_adr(2),
      I4 => reg_rd_adr(7),
      I5 => reg_rd_adr(6),
      O => \^axi_araddr_reg[3]_0\
    );
\axi_rdata[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(2),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(2),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(3)
    );
\axi_rdata[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(3),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(3),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(4)
    );
\axi_rdata[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(4),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(4),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(5)
    );
\axi_rdata[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(5),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(5),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(6)
    );
\axi_rdata[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(6),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(6),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(7)
    );
\axi_rdata[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(7),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(7),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(8)
    );
\axi_rdata[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => reg0_o(8),
      I1 => \^axi_araddr_reg[3]_1\,
      I2 => reg0_i(8),
      I3 => \^axi_araddr_reg[3]_0\,
      O => reg_rd_dat(9)
    );
\axi_rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => \axi_rdata_reg[1]_0\(0),
      Q => axil_rdata(0),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(10),
      Q => axil_rdata(10),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(11),
      Q => axil_rdata(11),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(12),
      Q => axil_rdata(12),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(13),
      Q => axil_rdata(13),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(14),
      Q => axil_rdata(14),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(15),
      Q => axil_rdata(15),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(16),
      Q => axil_rdata(16),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(17),
      Q => axil_rdata(17),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(18),
      Q => axil_rdata(18),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(19),
      Q => axil_rdata(19),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => \axi_rdata_reg[1]_0\(1),
      Q => axil_rdata(1),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(20),
      Q => axil_rdata(20),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(21),
      Q => axil_rdata(21),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(22),
      Q => axil_rdata(22),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(23),
      Q => axil_rdata(23),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(24),
      Q => axil_rdata(24),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(25),
      Q => axil_rdata(25),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(26),
      Q => axil_rdata(26),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(27),
      Q => axil_rdata(27),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(28),
      Q => axil_rdata(28),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(29),
      Q => axil_rdata(29),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(2),
      Q => axil_rdata(2),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(30),
      Q => axil_rdata(30),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(31),
      Q => axil_rdata(31),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(3),
      Q => axil_rdata(3),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(4),
      Q => axil_rdata(4),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(5),
      Q => axil_rdata(5),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(6),
      Q => axil_rdata(6),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(7),
      Q => axil_rdata(7),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(8),
      Q => axil_rdata(8),
      R => \axi_rdata[31]_i_1_n_0\
    );
\axi_rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => reg_rd_dat(9),
      Q => axil_rdata(9),
      R => \axi_rdata[31]_i_1_n_0\
    );
axi_rvalid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"08F8"
    )
        port map (
      I0 => axil_arvalid,
      I1 => \^axil_arready\,
      I2 => \^axi_rvalid_reg_0\,
      I3 => axil_rready,
      O => axi_rvalid_i_1_n_0
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => axi_rvalid_i_1_n_0,
      Q => \^axi_rvalid_reg_0\,
      R => axi_awready_i_1_n_0
    );
axi_wready_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => aw_en_reg_n_0,
      I1 => axil_awvalid,
      I2 => axil_wvalid,
      I3 => \^axil_wready\,
      O => axi_wready0
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => axi_wready0,
      Q => \^axil_wready\,
      R => axi_awready_i_1_n_0
    );
fifo_out_clear_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002000"
    )
        port map (
      I0 => reg_wr_adr(7),
      I1 => reg_wr_adr(6),
      I2 => reg_wr_adr(4),
      I3 => reg_wr_adr(2),
      I4 => \regs_out[0][31]_i_2_n_0\,
      O => \axi_awaddr_reg[7]_0\
    );
fifo_out_over_r_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BBBB0B00"
    )
        port map (
      I0 => \^axi_araddr_reg[2]_0\,
      I1 => reg_rd_ena,
      I2 => fifo_out_over_r_i_2_n_0,
      I3 => full_r,
      I4 => fifo_out_over_r,
      O => rd_val_o_reg_0
    );
fifo_out_over_r_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEFFFFF"
    )
        port map (
      I0 => reg_wr_adr(2),
      I1 => \regs_out[0][31]_i_2_n_0\,
      I2 => reg_wr_adr(4),
      I3 => reg_wr_adr(6),
      I4 => reg_wr_adr(7),
      O => fifo_out_over_r_i_2_n_0
    );
ram_reg_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^axi_awaddr_reg[7]_1\,
      O => p_4_in
    );
ram_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFDF"
    )
        port map (
      I0 => reg_wr_adr(7),
      I1 => reg_wr_adr(6),
      I2 => reg_wr_adr(4),
      I3 => \regs_out[0][31]_i_2_n_0\,
      I4 => reg_wr_adr(2),
      I5 => full_r,
      O => \^axi_awaddr_reg[7]_1\
    );
rd_val_o_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^axil_arready\,
      I1 => axil_arvalid,
      I2 => \^axi_rvalid_reg_0\,
      O => slv_reg_rden
    );
rd_val_o_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => slv_reg_rden,
      Q => reg_rd_ena,
      R => '0'
    );
\regs_out[0][31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => reg_wr_adr(4),
      I1 => reg_wr_adr(6),
      I2 => reg_wr_adr(7),
      I3 => reg_wr_adr(2),
      I4 => \regs_out[0][31]_i_2_n_0\,
      O => E(0)
    );
\regs_out[0][31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => reg_wr_adr(5),
      I1 => reg_wr_adr(3),
      I2 => axil_awvalid,
      I3 => axil_wvalid,
      I4 => \^axil_awready\,
      I5 => \^axil_wready\,
      O => \regs_out[0][31]_i_2_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync is
  port (
    S : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][7]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \wr_ptr_r_reg[10]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DI : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][8]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][10]_0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    O : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \_inferred__1/i__carry__1\ : in STD_LOGIC;
    \_inferred__1/i__carry__1_0\ : in STD_LOGIC;
    \_inferred__1/i__carry__0\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \_inferred__1/i__carry__1_1\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \data_r_reg[0][10]_0\ : in STD_LOGIC_VECTOR ( 10 downto 0 );
    axil_aclk : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync is
  signal bin2gray : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \data_r_reg[0]\ : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \data_r_reg_n_0_[1][0]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[1][9]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in11_in : STD_LOGIC;
  signal p_0_in14_in : STD_LOGIC;
  signal p_0_in17_in : STD_LOGIC;
  signal p_0_in20_in : STD_LOGIC;
  signal p_0_in2_in : STD_LOGIC;
  signal p_0_in5_in : STD_LOGIC;
  signal p_0_in8_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal rd_in_wr_bin : STD_LOGIC_VECTOR ( 7 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_r[0][0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \data_r[0][1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \data_r[0][2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \data_r[0][3]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \data_r[0][4]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \data_r[0][5]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \data_r[0][6]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \data_r[0][7]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \data_r[0][8]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \data_r[0][9]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \i__carry__0_i_11\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \i__carry__0_i_9\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \i__carry_i_12\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \i__carry_i_13\ : label is "soft_lutpair1";
begin
\data_r[0][0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(0),
      I1 => \data_r_reg[0][10]_0\(1),
      O => bin2gray(0)
    );
\data_r[0][1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(1),
      I1 => \data_r_reg[0][10]_0\(2),
      O => bin2gray(1)
    );
\data_r[0][2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(2),
      I1 => \data_r_reg[0][10]_0\(3),
      O => bin2gray(2)
    );
\data_r[0][3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(3),
      I1 => \data_r_reg[0][10]_0\(4),
      O => bin2gray(3)
    );
\data_r[0][4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(4),
      I1 => \data_r_reg[0][10]_0\(5),
      O => bin2gray(4)
    );
\data_r[0][5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(5),
      I1 => \data_r_reg[0][10]_0\(6),
      O => bin2gray(5)
    );
\data_r[0][6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(6),
      I1 => \data_r_reg[0][10]_0\(7),
      O => bin2gray(6)
    );
\data_r[0][7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(7),
      I1 => \data_r_reg[0][10]_0\(8),
      O => bin2gray(7)
    );
\data_r[0][8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(8),
      I1 => \data_r_reg[0][10]_0\(9),
      O => bin2gray(8)
    );
\data_r[0][9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(9),
      I1 => \data_r_reg[0][10]_0\(10),
      O => bin2gray(9)
    );
\data_r_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(0),
      Q => \data_r_reg[0]\(0),
      R => '0'
    );
\data_r_reg[0][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0][10]_0\(10),
      Q => \data_r_reg[0]\(10),
      R => '0'
    );
\data_r_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(1),
      Q => \data_r_reg[0]\(1),
      R => '0'
    );
\data_r_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(2),
      Q => \data_r_reg[0]\(2),
      R => '0'
    );
\data_r_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(3),
      Q => \data_r_reg[0]\(3),
      R => '0'
    );
\data_r_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(4),
      Q => \data_r_reg[0]\(4),
      R => '0'
    );
\data_r_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(5),
      Q => \data_r_reg[0]\(5),
      R => '0'
    );
\data_r_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(6),
      Q => \data_r_reg[0]\(6),
      R => '0'
    );
\data_r_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(7),
      Q => \data_r_reg[0]\(7),
      R => '0'
    );
\data_r_reg[0][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(8),
      Q => \data_r_reg[0]\(8),
      R => '0'
    );
\data_r_reg[0][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => bin2gray(9),
      Q => \data_r_reg[0]\(9),
      R => '0'
    );
\data_r_reg[1][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(0),
      Q => \data_r_reg_n_0_[1][0]\,
      R => '0'
    );
\data_r_reg[1][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(10),
      Q => p_1_in,
      R => '0'
    );
\data_r_reg[1][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(1),
      Q => p_0_in,
      R => '0'
    );
\data_r_reg[1][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(2),
      Q => p_0_in2_in,
      R => '0'
    );
\data_r_reg[1][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(3),
      Q => p_0_in5_in,
      R => '0'
    );
\data_r_reg[1][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(4),
      Q => p_0_in8_in,
      R => '0'
    );
\data_r_reg[1][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(5),
      Q => p_0_in11_in,
      R => '0'
    );
\data_r_reg[1][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(6),
      Q => p_0_in14_in,
      R => '0'
    );
\data_r_reg[1][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(7),
      Q => p_0_in17_in,
      R => '0'
    );
\data_r_reg[1][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(8),
      Q => p_0_in20_in,
      R => '0'
    );
\data_r_reg[1][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \data_r_reg[0]\(9),
      Q => \data_r_reg_n_0_[1][9]\,
      R => '0'
    );
\i__carry__0_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => p_0_in14_in,
      I1 => p_0_in20_in,
      I2 => p_1_in,
      I3 => \data_r_reg_n_0_[1][9]\,
      I4 => p_0_in17_in,
      O => rd_in_wr_bin(6)
    );
\i__carry__0_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
        port map (
      I0 => p_0_in20_in,
      I1 => p_1_in,
      I2 => \data_r_reg_n_0_[1][9]\,
      I3 => p_0_in17_in,
      O => \data_r_reg[1][8]_0\(3)
    );
\i__carry__0_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69969669"
    )
        port map (
      I0 => p_0_in17_in,
      I1 => \data_r_reg_n_0_[1][9]\,
      I2 => p_1_in,
      I3 => p_0_in20_in,
      I4 => p_0_in14_in,
      O => \data_r_reg[1][8]_0\(2)
    );
\i__carry__0_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
        port map (
      I0 => p_0_in14_in,
      I1 => p_0_in20_in,
      I2 => p_1_in,
      I3 => \data_r_reg_n_0_[1][9]\,
      I4 => p_0_in17_in,
      I5 => p_0_in11_in,
      O => \data_r_reg[1][8]_0\(1)
    );
\i__carry__0_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => rd_in_wr_bin(5),
      I1 => p_0_in8_in,
      O => \data_r_reg[1][8]_0\(0)
    );
\i__carry__0_i_5__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9995"
    )
        port map (
      I0 => rd_in_wr_bin(7),
      I1 => \_inferred__1/i__carry__0\(3),
      I2 => \_inferred__1/i__carry__1\,
      I3 => \_inferred__1/i__carry__1_0\,
      O => \data_r_reg[1][7]_0\(3)
    );
\i__carry__0_i_6__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9995"
    )
        port map (
      I0 => rd_in_wr_bin(6),
      I1 => \_inferred__1/i__carry__0\(2),
      I2 => \_inferred__1/i__carry__1\,
      I3 => \_inferred__1/i__carry__1_0\,
      O => \data_r_reg[1][7]_0\(2)
    );
\i__carry__0_i_7__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9995"
    )
        port map (
      I0 => rd_in_wr_bin(5),
      I1 => \_inferred__1/i__carry__0\(1),
      I2 => \_inferred__1/i__carry__1\,
      I3 => \_inferred__1/i__carry__1_0\,
      O => \data_r_reg[1][7]_0\(1)
    );
\i__carry__0_i_8__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69696999"
    )
        port map (
      I0 => rd_in_wr_bin(5),
      I1 => p_0_in8_in,
      I2 => \_inferred__1/i__carry__0\(0),
      I3 => \_inferred__1/i__carry__1\,
      I4 => \_inferred__1/i__carry__1_0\,
      O => \data_r_reg[1][7]_0\(0)
    );
\i__carry__0_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => p_0_in17_in,
      I1 => \data_r_reg_n_0_[1][9]\,
      I2 => p_1_in,
      I3 => p_0_in20_in,
      O => rd_in_wr_bin(7)
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => p_1_in,
      I1 => \data_r_reg_n_0_[1][9]\,
      O => \data_r_reg[1][10]_0\(1)
    );
\i__carry__1_i_2__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => \data_r_reg_n_0_[1][9]\,
      I1 => p_1_in,
      I2 => p_0_in20_in,
      O => \data_r_reg[1][10]_0\(0)
    );
\i__carry__1_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E0F11F0E"
    )
        port map (
      I0 => \_inferred__1/i__carry__1_0\,
      I1 => \_inferred__1/i__carry__1\,
      I2 => \_inferred__1/i__carry__1_1\(2),
      I3 => Q(0),
      I4 => p_1_in,
      O => \wr_ptr_r_reg[10]\(2)
    );
\i__carry__1_i_4__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69696999"
    )
        port map (
      I0 => p_1_in,
      I1 => \data_r_reg_n_0_[1][9]\,
      I2 => \_inferred__1/i__carry__1_1\(1),
      I3 => \_inferred__1/i__carry__1\,
      I4 => \_inferred__1/i__carry__1_0\,
      O => \wr_ptr_r_reg[10]\(1)
    );
\i__carry__1_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669966996696969"
    )
        port map (
      I0 => \data_r_reg_n_0_[1][9]\,
      I1 => p_1_in,
      I2 => p_0_in20_in,
      I3 => \_inferred__1/i__carry__1_1\(0),
      I4 => \_inferred__1/i__carry__1\,
      I5 => \_inferred__1/i__carry__1_0\,
      O => \wr_ptr_r_reg[10]\(0)
    );
\i__carry_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => p_0_in2_in,
      I1 => p_0_in8_in,
      I2 => rd_in_wr_bin(5),
      I3 => p_0_in5_in,
      O => rd_in_wr_bin(2)
    );
\i__carry_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => p_0_in,
      I1 => p_0_in5_in,
      I2 => rd_in_wr_bin(5),
      I3 => p_0_in8_in,
      I4 => p_0_in2_in,
      O => rd_in_wr_bin(1)
    );
\i__carry_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => rd_in_wr_bin(5),
      I2 => p_0_in5_in,
      O => DI(3)
    );
\i__carry_i_2__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9669"
    )
        port map (
      I0 => p_0_in5_in,
      I1 => rd_in_wr_bin(5),
      I2 => p_0_in8_in,
      I3 => p_0_in2_in,
      O => DI(2)
    );
\i__carry_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69969669"
    )
        port map (
      I0 => p_0_in2_in,
      I1 => p_0_in8_in,
      I2 => rd_in_wr_bin(5),
      I3 => p_0_in5_in,
      I4 => p_0_in,
      O => DI(1)
    );
\i__carry_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669699669969669"
    )
        port map (
      I0 => p_0_in,
      I1 => p_0_in5_in,
      I2 => rd_in_wr_bin(5),
      I3 => p_0_in8_in,
      I4 => p_0_in2_in,
      I5 => \data_r_reg_n_0_[1][0]\,
      O => DI(0)
    );
\i__carry_i_5__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9669966996696969"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => rd_in_wr_bin(5),
      I2 => p_0_in5_in,
      I3 => O(3),
      I4 => \_inferred__1/i__carry__1\,
      I5 => \_inferred__1/i__carry__1_0\,
      O => S(3)
    );
\i__carry_i_6__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9995"
    )
        port map (
      I0 => rd_in_wr_bin(2),
      I1 => O(2),
      I2 => \_inferred__1/i__carry__1\,
      I3 => \_inferred__1/i__carry__1_0\,
      O => S(2)
    );
\i__carry_i_7__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9995"
    )
        port map (
      I0 => rd_in_wr_bin(1),
      I1 => O(1),
      I2 => \_inferred__1/i__carry__1\,
      I3 => \_inferred__1/i__carry__1_0\,
      O => S(1)
    );
\i__carry_i_8__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69696999"
    )
        port map (
      I0 => rd_in_wr_bin(1),
      I1 => \data_r_reg_n_0_[1][0]\,
      I2 => O(0),
      I3 => \_inferred__1/i__carry__1\,
      I4 => \_inferred__1/i__carry__1_0\,
      O => S(0)
    );
\i__carry_i_9__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => p_0_in11_in,
      I1 => p_0_in17_in,
      I2 => \data_r_reg_n_0_[1][9]\,
      I3 => p_1_in,
      I4 => p_0_in20_in,
      I5 => p_0_in14_in,
      O => rd_in_wr_bin(5)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync_0 is
  port (
    S : out STD_LOGIC_VECTOR ( 2 downto 0 );
    wr_in_rd_bin : out STD_LOGIC_VECTOR ( 9 downto 0 );
    \data_r_reg[1][4]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][8]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \_inferred__4/i__carry__1\ : in STD_LOGIC;
    ret : in STD_LOGIC_VECTOR ( 10 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \data_r_reg[0][10]_0\ : in STD_LOGIC_VECTOR ( 10 downto 0 );
    fifo_clk_i : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync_0 : entity is "GraySync";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync_0;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync_0 is
  signal bin2gray : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \data_r_reg_n_0_[0][0]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][10]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][1]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][2]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][3]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][4]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][5]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][6]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][7]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][8]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[0][9]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[1][0]\ : STD_LOGIC;
  signal \data_r_reg_n_0_[1][9]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in11_in : STD_LOGIC;
  signal p_0_in14_in : STD_LOGIC;
  signal p_0_in17_in : STD_LOGIC;
  signal p_0_in20_in : STD_LOGIC;
  signal p_0_in2_in : STD_LOGIC;
  signal p_0_in5_in : STD_LOGIC;
  signal p_0_in8_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal \^wr_in_rd_bin\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \data_r[0][0]_i_1__0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \data_r[0][1]_i_1__0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \data_r[0][2]_i_1__0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \data_r[0][3]_i_1__0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \data_r[0][4]_i_1__0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \data_r[0][5]_i_1__0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \data_r[0][6]_i_1__0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \data_r[0][7]_i_1__0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \data_r[0][8]_i_1__0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \data_r[0][9]_i_1__0\ : label is "soft_lutpair8";
begin
  wr_in_rd_bin(9 downto 0) <= \^wr_in_rd_bin\(9 downto 0);
\data_r[0][0]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(0),
      I1 => \data_r_reg[0][10]_0\(1),
      O => bin2gray(0)
    );
\data_r[0][1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(1),
      I1 => \data_r_reg[0][10]_0\(2),
      O => bin2gray(1)
    );
\data_r[0][2]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(2),
      I1 => \data_r_reg[0][10]_0\(3),
      O => bin2gray(2)
    );
\data_r[0][3]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(3),
      I1 => \data_r_reg[0][10]_0\(4),
      O => bin2gray(3)
    );
\data_r[0][4]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(4),
      I1 => \data_r_reg[0][10]_0\(5),
      O => bin2gray(4)
    );
\data_r[0][5]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(5),
      I1 => \data_r_reg[0][10]_0\(6),
      O => bin2gray(5)
    );
\data_r[0][6]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(6),
      I1 => \data_r_reg[0][10]_0\(7),
      O => bin2gray(6)
    );
\data_r[0][7]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(7),
      I1 => \data_r_reg[0][10]_0\(8),
      O => bin2gray(7)
    );
\data_r[0][8]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(8),
      I1 => \data_r_reg[0][10]_0\(9),
      O => bin2gray(8)
    );
\data_r[0][9]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg[0][10]_0\(9),
      I1 => \data_r_reg[0][10]_0\(10),
      O => bin2gray(9)
    );
\data_r_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(0),
      Q => \data_r_reg_n_0_[0][0]\,
      R => '0'
    );
\data_r_reg[0][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg[0][10]_0\(10),
      Q => \data_r_reg_n_0_[0][10]\,
      R => '0'
    );
\data_r_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(1),
      Q => \data_r_reg_n_0_[0][1]\,
      R => '0'
    );
\data_r_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(2),
      Q => \data_r_reg_n_0_[0][2]\,
      R => '0'
    );
\data_r_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(3),
      Q => \data_r_reg_n_0_[0][3]\,
      R => '0'
    );
\data_r_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(4),
      Q => \data_r_reg_n_0_[0][4]\,
      R => '0'
    );
\data_r_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(5),
      Q => \data_r_reg_n_0_[0][5]\,
      R => '0'
    );
\data_r_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(6),
      Q => \data_r_reg_n_0_[0][6]\,
      R => '0'
    );
\data_r_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(7),
      Q => \data_r_reg_n_0_[0][7]\,
      R => '0'
    );
\data_r_reg[0][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(8),
      Q => \data_r_reg_n_0_[0][8]\,
      R => '0'
    );
\data_r_reg[0][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => bin2gray(9),
      Q => \data_r_reg_n_0_[0][9]\,
      R => '0'
    );
\data_r_reg[1][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][0]\,
      Q => \data_r_reg_n_0_[1][0]\,
      R => '0'
    );
\data_r_reg[1][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][10]\,
      Q => p_1_in,
      R => '0'
    );
\data_r_reg[1][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][1]\,
      Q => p_0_in,
      R => '0'
    );
\data_r_reg[1][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][2]\,
      Q => p_0_in2_in,
      R => '0'
    );
\data_r_reg[1][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][3]\,
      Q => p_0_in5_in,
      R => '0'
    );
\data_r_reg[1][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][4]\,
      Q => p_0_in8_in,
      R => '0'
    );
\data_r_reg[1][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][5]\,
      Q => p_0_in11_in,
      R => '0'
    );
\data_r_reg[1][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][6]\,
      Q => p_0_in14_in,
      R => '0'
    );
\data_r_reg[1][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][7]\,
      Q => p_0_in17_in,
      R => '0'
    );
\data_r_reg[1][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][8]\,
      Q => p_0_in20_in,
      R => '0'
    );
\data_r_reg[1][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \data_r_reg_n_0_[0][9]\,
      Q => \data_r_reg_n_0_[1][9]\,
      R => '0'
    );
\i__carry__0_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => p_0_in17_in,
      I1 => \data_r_reg_n_0_[1][9]\,
      I2 => p_1_in,
      I3 => p_0_in20_in,
      O => \^wr_in_rd_bin\(7)
    );
\i__carry__0_i_2__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => p_0_in14_in,
      I1 => p_0_in20_in,
      I2 => p_1_in,
      I3 => \data_r_reg_n_0_[1][9]\,
      I4 => p_0_in17_in,
      O => \^wr_in_rd_bin\(6)
    );
\i__carry__0_i_3__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => p_0_in11_in,
      I1 => p_0_in17_in,
      I2 => \data_r_reg_n_0_[1][9]\,
      I3 => p_1_in,
      I4 => p_0_in20_in,
      I5 => p_0_in14_in,
      O => \^wr_in_rd_bin\(5)
    );
\i__carry__0_i_4__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_0_in8_in,
      I1 => \^wr_in_rd_bin\(5),
      O => \^wr_in_rd_bin\(4)
    );
\i__carry__0_i_5__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7887877887787887"
    )
        port map (
      I0 => ret(7),
      I1 => \_inferred__4/i__carry__1\,
      I2 => p_0_in20_in,
      I3 => p_1_in,
      I4 => \data_r_reg_n_0_[1][9]\,
      I5 => p_0_in17_in,
      O => \data_r_reg[1][8]_0\(3)
    );
\i__carry__0_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"87"
    )
        port map (
      I0 => ret(6),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \^wr_in_rd_bin\(6),
      O => \data_r_reg[1][8]_0\(2)
    );
\i__carry__0_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"87"
    )
        port map (
      I0 => ret(5),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \^wr_in_rd_bin\(5),
      O => \data_r_reg[1][8]_0\(1)
    );
\i__carry__0_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7887"
    )
        port map (
      I0 => ret(4),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \^wr_in_rd_bin\(5),
      I3 => p_0_in8_in,
      O => \data_r_reg[1][8]_0\(0)
    );
\i__carry__1_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \data_r_reg_n_0_[1][9]\,
      I1 => p_1_in,
      O => \^wr_in_rd_bin\(9)
    );
\i__carry__1_i_2__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => p_0_in20_in,
      I1 => p_1_in,
      I2 => \data_r_reg_n_0_[1][9]\,
      O => \^wr_in_rd_bin\(8)
    );
\i__carry__1_i_3__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8D72"
    )
        port map (
      I0 => \_inferred__4/i__carry__1\,
      I1 => ret(10),
      I2 => Q(0),
      I3 => p_1_in,
      O => S(2)
    );
\i__carry__1_i_4__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7887"
    )
        port map (
      I0 => ret(9),
      I1 => \_inferred__4/i__carry__1\,
      I2 => p_1_in,
      I3 => \data_r_reg_n_0_[1][9]\,
      O => S(1)
    );
\i__carry__1_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"87787887"
    )
        port map (
      I0 => ret(8),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \data_r_reg_n_0_[1][9]\,
      I3 => p_1_in,
      I4 => p_0_in20_in,
      O => S(0)
    );
\i__carry_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => p_0_in5_in,
      I1 => \^wr_in_rd_bin\(5),
      I2 => p_0_in8_in,
      O => \^wr_in_rd_bin\(3)
    );
\i__carry_i_2__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => p_0_in2_in,
      I1 => p_0_in8_in,
      I2 => \^wr_in_rd_bin\(5),
      I3 => p_0_in5_in,
      O => \^wr_in_rd_bin\(2)
    );
\i__carry_i_3__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => p_0_in,
      I1 => p_0_in5_in,
      I2 => \^wr_in_rd_bin\(5),
      I3 => p_0_in8_in,
      I4 => p_0_in2_in,
      O => \^wr_in_rd_bin\(1)
    );
\i__carry_i_4__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \data_r_reg_n_0_[1][0]\,
      I1 => p_0_in2_in,
      I2 => p_0_in8_in,
      I3 => \^wr_in_rd_bin\(5),
      I4 => p_0_in5_in,
      I5 => p_0_in,
      O => \^wr_in_rd_bin\(0)
    );
\i__carry_i_5__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"87787887"
    )
        port map (
      I0 => ret(3),
      I1 => \_inferred__4/i__carry__1\,
      I2 => p_0_in8_in,
      I3 => \^wr_in_rd_bin\(5),
      I4 => p_0_in5_in,
      O => \data_r_reg[1][4]_0\(3)
    );
\i__carry_i_6__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7887877887787887"
    )
        port map (
      I0 => ret(2),
      I1 => \_inferred__4/i__carry__1\,
      I2 => p_0_in5_in,
      I3 => \^wr_in_rd_bin\(5),
      I4 => p_0_in8_in,
      I5 => p_0_in2_in,
      O => \data_r_reg[1][4]_0\(2)
    );
\i__carry_i_7__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"87"
    )
        port map (
      I0 => ret(1),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \^wr_in_rd_bin\(1),
      O => \data_r_reg[1][4]_0\(1)
    );
\i__carry_i_8__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7887"
    )
        port map (
      I0 => ret(0),
      I1 => \_inferred__4/i__carry__1\,
      I2 => \^wr_in_rd_bin\(1),
      I3 => \data_r_reg_n_0_[1][0]\,
      O => \data_r_reg[1][4]_0\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdpram is
  port (
    fifo_data_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    axil_aclk : in STD_LOGIC;
    fifo_clk_i : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 9 downto 0 );
    ram_reg_0 : in STD_LOGIC_VECTOR ( 9 downto 0 );
    axil_wdata : in STD_LOGIC_VECTOR ( 23 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdpram;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdpram is
  signal NLW_ram_reg_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_DBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_INJECTDBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_INJECTSBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_SBITERR_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_DOADO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_ram_reg_DOBDO_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 24 );
  signal NLW_ram_reg_DOPADOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_ram_reg_DOPBDOP_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_ram_reg_ECCPARITY_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_ram_reg_RDADDRECC_UNCONNECTED : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of ram_reg : label is "p0_d24";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of ram_reg : label is "p0_d24";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of ram_reg : label is "{SYNTH-6 {cell *THIS*}}";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of ram_reg : label is 24576;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of ram_reg : label is "U0/comblock_i/fifo_out_g.fifo_out_i/i_memory/ram_reg";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of ram_reg : label is "RAM_SDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of ram_reg : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of ram_reg : label is 1023;
  attribute ram_offset : integer;
  attribute ram_offset of ram_reg : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of ram_reg : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of ram_reg : label is 23;
begin
ram_reg: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "NO_CHANGE",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 5) => Q(9 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 5) => ram_reg_0(9 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '1',
      CASCADEINB => '1',
      CASCADEOUTA => NLW_ram_reg_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => NLW_ram_reg_CASCADEOUTB_UNCONNECTED,
      CLKARDCLK => axil_aclk,
      CLKBWRCLK => fifo_clk_i,
      DBITERR => NLW_ram_reg_DBITERR_UNCONNECTED,
      DIADI(31 downto 24) => B"00000000",
      DIADI(23 downto 0) => axil_wdata(23 downto 0),
      DIBDI(31 downto 0) => B"00000000111111111111111111111111",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => NLW_ram_reg_DOADO_UNCONNECTED(31 downto 0),
      DOBDO(31 downto 24) => NLW_ram_reg_DOBDO_UNCONNECTED(31 downto 24),
      DOBDO(23 downto 0) => fifo_data_o(23 downto 0),
      DOPADOP(3 downto 0) => NLW_ram_reg_DOPADOP_UNCONNECTED(3 downto 0),
      DOPBDOP(3 downto 0) => NLW_ram_reg_DOPBDOP_UNCONNECTED(3 downto 0),
      ECCPARITY(7 downto 0) => NLW_ram_reg_ECCPARITY_UNCONNECTED(7 downto 0),
      ENARDEN => p_4_in,
      ENBWREN => '1',
      INJECTDBITERR => NLW_ram_reg_INJECTDBITERR_UNCONNECTED,
      INJECTSBITERR => NLW_ram_reg_INJECTSBITERR_UNCONNECTED,
      RDADDRECC(8 downto 0) => NLW_ram_reg_RDADDRECC_UNCONNECTED(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => NLW_ram_reg_SBITERR_UNCONNECTED,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_FIFO is
  port (
    fifo_data_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    full_r : out STD_LOGIC;
    fifo_empty_o : out STD_LOGIC;
    fifo_valid_o : out STD_LOGIC;
    O : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][8]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][10]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    fifo_underflow_o : out STD_LOGIC;
    \regs_out_reg[0][1]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    fifo_aempty_o : out STD_LOGIC;
    axil_aclk : in STD_LOGIC;
    fifo_clk_i : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    axil_wdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    \wr_ptr_r_reg[3]_0\ : in STD_LOGIC;
    fifo_re_i : in STD_LOGIC;
    \wr_ptr_r_reg[0]_0\ : in STD_LOGIC;
    fifo_clear_i : in STD_LOGIC;
    \axi_rdata_reg[0]\ : in STD_LOGIC;
    reg0_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    \axi_rdata_reg[0]_0\ : in STD_LOGIC;
    reg0_o : in STD_LOGIC_VECTOR ( 0 to 0 );
    \axi_rdata_reg[1]\ : in STD_LOGIC;
    \axi_rdata_reg[1]_0\ : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_FIFO;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_FIFO is
  signal \^o\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \_inferred__1/i__carry__0_n_0\ : STD_LOGIC;
  signal \_inferred__1/i__carry__0_n_1\ : STD_LOGIC;
  signal \_inferred__1/i__carry__0_n_2\ : STD_LOGIC;
  signal \_inferred__1/i__carry__0_n_3\ : STD_LOGIC;
  signal \_inferred__1/i__carry__1_n_2\ : STD_LOGIC;
  signal \_inferred__1/i__carry__1_n_3\ : STD_LOGIC;
  signal \_inferred__1/i__carry_n_0\ : STD_LOGIC;
  signal \_inferred__1/i__carry_n_1\ : STD_LOGIC;
  signal \_inferred__1/i__carry_n_2\ : STD_LOGIC;
  signal \_inferred__1/i__carry_n_3\ : STD_LOGIC;
  signal \_inferred__4/i__carry__0_n_0\ : STD_LOGIC;
  signal \_inferred__4/i__carry__0_n_1\ : STD_LOGIC;
  signal \_inferred__4/i__carry__0_n_2\ : STD_LOGIC;
  signal \_inferred__4/i__carry__0_n_3\ : STD_LOGIC;
  signal \_inferred__4/i__carry__1_n_2\ : STD_LOGIC;
  signal \_inferred__4/i__carry__1_n_3\ : STD_LOGIC;
  signal \_inferred__4/i__carry_n_0\ : STD_LOGIC;
  signal \_inferred__4/i__carry_n_1\ : STD_LOGIC;
  signal \_inferred__4/i__carry_n_2\ : STD_LOGIC;
  signal \_inferred__4/i__carry_n_3\ : STD_LOGIC;
  signal \axi_rdata[0]_i_2_n_0\ : STD_LOGIC;
  signal \axi_rdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_3_n_0\ : STD_LOGIC;
  signal \axi_rdata[1]_i_4_n_0\ : STD_LOGIC;
  signal \^data_r_reg[1][10]\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^data_r_reg[1][8]\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal empty_r : STD_LOGIC;
  signal \^fifo_empty_o\ : STD_LOGIC;
  signal fifo_empty_o_INST_0_i_1_n_0 : STD_LOGIC;
  signal full : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_0\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_1\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_10\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_11\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_12\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_13\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_14\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_15\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_16\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_17\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_18\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_19\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_2\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_20\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_3\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_4\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_5\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_6\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_7\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_8\ : STD_LOGIC;
  signal \g_async.i_sync_rd2wr_n_9\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_0\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_1\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_13\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_14\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_15\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_16\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_17\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_18\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_19\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_2\ : STD_LOGIC;
  signal \g_async.i_sync_wr2rd_n_20\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_1\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_2\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_3\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_4\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_5\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_6\ : STD_LOGIC;
  signal \i__carry__0_i_10_n_7\ : STD_LOGIC;
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_5_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_9__0_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_9__0_n_1\ : STD_LOGIC;
  signal \i__carry__0_i_9__0_n_2\ : STD_LOGIC;
  signal \i__carry__0_i_9__0_n_3\ : STD_LOGIC;
  signal \i__carry__1_i_1__1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_6__0_n_2\ : STD_LOGIC;
  signal \i__carry__1_i_6__0_n_3\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_2\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_3\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_5\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_6\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_7\ : STD_LOGIC;
  signal \i__carry_i_10__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_10_n_0\ : STD_LOGIC;
  signal \i__carry_i_10_n_1\ : STD_LOGIC;
  signal \i__carry_i_10_n_2\ : STD_LOGIC;
  signal \i__carry_i_10_n_3\ : STD_LOGIC;
  signal \i__carry_i_10_n_4\ : STD_LOGIC;
  signal \i__carry_i_10_n_5\ : STD_LOGIC;
  signal \i__carry_i_10_n_6\ : STD_LOGIC;
  signal \i__carry_i_10_n_7\ : STD_LOGIC;
  signal \i__carry_i_11_n_0\ : STD_LOGIC;
  signal \i__carry_i_14_n_0\ : STD_LOGIC;
  signal \i__carry_i_1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_5_n_0\ : STD_LOGIC;
  signal \i__carry_i_6_n_0\ : STD_LOGIC;
  signal \i__carry_i_7_n_0\ : STD_LOGIC;
  signal \i__carry_i_8_n_0\ : STD_LOGIC;
  signal \i__carry_i_9__1_n_0\ : STD_LOGIC;
  signal \i__carry_i_9__1_n_1\ : STD_LOGIC;
  signal \i__carry_i_9__1_n_2\ : STD_LOGIC;
  signal \i__carry_i_9__1_n_3\ : STD_LOGIC;
  signal \i__carry_i_9_n_0\ : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal rd_ptr_r : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal ret : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \ret_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \ret_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \ret_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \ret_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \ret_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \ret_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \ret_carry__0_n_0\ : STD_LOGIC;
  signal \ret_carry__0_n_1\ : STD_LOGIC;
  signal \ret_carry__0_n_2\ : STD_LOGIC;
  signal \ret_carry__0_n_3\ : STD_LOGIC;
  signal \ret_carry__0_n_4\ : STD_LOGIC;
  signal \ret_carry__0_n_5\ : STD_LOGIC;
  signal \ret_carry__0_n_6\ : STD_LOGIC;
  signal \ret_carry__0_n_7\ : STD_LOGIC;
  signal \ret_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \ret_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \ret_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \ret_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \ret_carry__1_n_2\ : STD_LOGIC;
  signal \ret_carry__1_n_3\ : STD_LOGIC;
  signal \ret_carry__1_n_5\ : STD_LOGIC;
  signal \ret_carry__1_n_6\ : STD_LOGIC;
  signal \ret_carry__1_n_7\ : STD_LOGIC;
  signal ret_carry_i_1_n_0 : STD_LOGIC;
  signal ret_carry_i_2_n_0 : STD_LOGIC;
  signal ret_carry_i_3_n_0 : STD_LOGIC;
  signal ret_carry_i_4_n_0 : STD_LOGIC;
  signal ret_carry_i_5_n_0 : STD_LOGIC;
  signal ret_carry_i_6_n_0 : STD_LOGIC;
  signal ret_carry_i_7_n_0 : STD_LOGIC;
  signal ret_carry_i_8_n_0 : STD_LOGIC;
  signal ret_carry_n_0 : STD_LOGIC;
  signal ret_carry_n_1 : STD_LOGIC;
  signal ret_carry_n_2 : STD_LOGIC;
  signal ret_carry_n_3 : STD_LOGIC;
  signal ret_carry_n_4 : STD_LOGIC;
  signal ret_carry_n_5 : STD_LOGIC;
  signal ret_carry_n_6 : STD_LOGIC;
  signal ret_carry_n_7 : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_0\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_1\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_2\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_3\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_4\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_5\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_6\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__0_n_7\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__1_n_2\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__1_n_3\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__1_n_5\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__1_n_6\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry__1_n_7\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_0\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_1\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_2\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_3\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_4\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_5\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_6\ : STD_LOGIC;
  signal \ret_inferred__1/i__carry_n_7\ : STD_LOGIC;
  signal rst : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal wr_in_rd_bin : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal wr_ptr_r : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal \NLW__inferred__1/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW__inferred__1/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW__inferred__4/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW__inferred__4/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_i__carry__1_i_6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_i__carry__1_i_6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_i__carry__1_i_6__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_i__carry__1_i_6__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_ret_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_ret_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_ret_inferred__1/i__carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_ret_inferred__1/i__carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \_inferred__1/i__carry\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__1/i__carry\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \_inferred__1/i__carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__1/i__carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \_inferred__1/i__carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__1/i__carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \_inferred__4/i__carry\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__4/i__carry\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \_inferred__4/i__carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__4/i__carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \_inferred__4/i__carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \_inferred__4/i__carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of fifo_underflow_o_INST_0 : label is "soft_lutpair16";
  attribute ADDER_THRESHOLD of \i__carry__0_i_10\ : label is 35;
  attribute SOFT_HLUTNM of \i__carry__0_i_5\ : label is "soft_lutpair13";
  attribute ADDER_THRESHOLD of \i__carry__0_i_9__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \i__carry__0_i_9__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \i__carry__1_i_4\ : label is "soft_lutpair14";
  attribute ADDER_THRESHOLD of \i__carry__1_i_6\ : label is 35;
  attribute ADDER_THRESHOLD of \i__carry__1_i_6__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \i__carry__1_i_6__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \i__carry_i_10\ : label is 35;
  attribute SOFT_HLUTNM of \i__carry_i_8\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \i__carry_i_9\ : label is "soft_lutpair13";
  attribute ADDER_THRESHOLD of \i__carry_i_9__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \i__carry_i_9__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of ret_carry_i_6 : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of ret_carry_i_8 : label is "soft_lutpair15";
  attribute METHODOLOGY_DRC_VIOS of \ret_inferred__1/i__carry\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \ret_inferred__1/i__carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \ret_inferred__1/i__carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of valid_r_i_2 : label is "soft_lutpair16";
begin
  O(3 downto 0) <= \^o\(3 downto 0);
  \data_r_reg[1][10]\(2 downto 0) <= \^data_r_reg[1][10]\(2 downto 0);
  \data_r_reg[1][8]\(3 downto 0) <= \^data_r_reg[1][8]\(3 downto 0);
  fifo_empty_o <= \^fifo_empty_o\;
\_inferred__1/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \_inferred__1/i__carry_n_0\,
      CO(2) => \_inferred__1/i__carry_n_1\,
      CO(1) => \_inferred__1/i__carry_n_2\,
      CO(0) => \_inferred__1/i__carry_n_3\,
      CYINIT => '1',
      DI(3) => \g_async.i_sync_rd2wr_n_11\,
      DI(2) => \g_async.i_sync_rd2wr_n_12\,
      DI(1) => \g_async.i_sync_rd2wr_n_13\,
      DI(0) => \g_async.i_sync_rd2wr_n_14\,
      O(3 downto 0) => \^o\(3 downto 0),
      S(3) => \g_async.i_sync_rd2wr_n_0\,
      S(2) => \g_async.i_sync_rd2wr_n_1\,
      S(1) => \g_async.i_sync_rd2wr_n_2\,
      S(0) => \g_async.i_sync_rd2wr_n_3\
    );
\_inferred__1/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \_inferred__1/i__carry_n_0\,
      CO(3) => \_inferred__1/i__carry__0_n_0\,
      CO(2) => \_inferred__1/i__carry__0_n_1\,
      CO(1) => \_inferred__1/i__carry__0_n_2\,
      CO(0) => \_inferred__1/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \g_async.i_sync_rd2wr_n_15\,
      DI(2) => \g_async.i_sync_rd2wr_n_16\,
      DI(1) => \g_async.i_sync_rd2wr_n_17\,
      DI(0) => \g_async.i_sync_rd2wr_n_18\,
      O(3 downto 0) => \^data_r_reg[1][8]\(3 downto 0),
      S(3) => \g_async.i_sync_rd2wr_n_4\,
      S(2) => \g_async.i_sync_rd2wr_n_5\,
      S(1) => \g_async.i_sync_rd2wr_n_6\,
      S(0) => \g_async.i_sync_rd2wr_n_7\
    );
\_inferred__1/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \_inferred__1/i__carry__0_n_0\,
      CO(3 downto 2) => \NLW__inferred__1/i__carry__1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \_inferred__1/i__carry__1_n_2\,
      CO(0) => \_inferred__1/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \g_async.i_sync_rd2wr_n_19\,
      DI(0) => \g_async.i_sync_rd2wr_n_20\,
      O(3) => \NLW__inferred__1/i__carry__1_O_UNCONNECTED\(3),
      O(2 downto 0) => \^data_r_reg[1][10]\(2 downto 0),
      S(3) => '0',
      S(2) => \g_async.i_sync_rd2wr_n_8\,
      S(1) => \g_async.i_sync_rd2wr_n_9\,
      S(0) => \g_async.i_sync_rd2wr_n_10\
    );
\_inferred__4/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \_inferred__4/i__carry_n_0\,
      CO(2) => \_inferred__4/i__carry_n_1\,
      CO(1) => \_inferred__4/i__carry_n_2\,
      CO(0) => \_inferred__4/i__carry_n_3\,
      CYINIT => '1',
      DI(3 downto 0) => wr_in_rd_bin(3 downto 0),
      O(3 downto 0) => sel0(3 downto 0),
      S(3) => \g_async.i_sync_wr2rd_n_13\,
      S(2) => \g_async.i_sync_wr2rd_n_14\,
      S(1) => \g_async.i_sync_wr2rd_n_15\,
      S(0) => \g_async.i_sync_wr2rd_n_16\
    );
\_inferred__4/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \_inferred__4/i__carry_n_0\,
      CO(3) => \_inferred__4/i__carry__0_n_0\,
      CO(2) => \_inferred__4/i__carry__0_n_1\,
      CO(1) => \_inferred__4/i__carry__0_n_2\,
      CO(0) => \_inferred__4/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => wr_in_rd_bin(7 downto 4),
      O(3 downto 0) => sel0(7 downto 4),
      S(3) => \g_async.i_sync_wr2rd_n_17\,
      S(2) => \g_async.i_sync_wr2rd_n_18\,
      S(1) => \g_async.i_sync_wr2rd_n_19\,
      S(0) => \g_async.i_sync_wr2rd_n_20\
    );
\_inferred__4/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \_inferred__4/i__carry__0_n_0\,
      CO(3 downto 2) => \NLW__inferred__4/i__carry__1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \_inferred__4/i__carry__1_n_2\,
      CO(0) => \_inferred__4/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => wr_in_rd_bin(9 downto 8),
      O(3) => \NLW__inferred__4/i__carry__1_O_UNCONNECTED\(3),
      O(2 downto 0) => sel0(10 downto 8),
      S(3) => '0',
      S(2) => \g_async.i_sync_wr2rd_n_0\,
      S(1) => \g_async.i_sync_wr2rd_n_1\,
      S(0) => \g_async.i_sync_wr2rd_n_2\
    );
\axi_rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF888F888F888"
    )
        port map (
      I0 => \axi_rdata_reg[0]\,
      I1 => reg0_i(0),
      I2 => \axi_rdata_reg[0]_0\,
      I3 => reg0_o(0),
      I4 => \axi_rdata[0]_i_2_n_0\,
      I5 => \axi_rdata[0]_i_3_n_0\,
      O => \regs_out_reg[0][1]\(0)
    );
\axi_rdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => \^data_r_reg[1][8]\(3),
      I1 => \^data_r_reg[1][10]\(0),
      I2 => \^data_r_reg[1][8]\(1),
      I3 => \^data_r_reg[1][8]\(2),
      I4 => \^data_r_reg[1][10]\(1),
      I5 => \^data_r_reg[1][10]\(2),
      O => \axi_rdata[0]_i_2_n_0\
    );
\axi_rdata[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \^o\(3),
      I1 => \^data_r_reg[1][8]\(0),
      I2 => \^o\(2),
      I3 => \^o\(1),
      I4 => \^o\(0),
      I5 => \axi_rdata_reg[1]\,
      O => \axi_rdata[0]_i_3_n_0\
    );
\axi_rdata[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCFEEE"
    )
        port map (
      I0 => \^data_r_reg[1][10]\(2),
      I1 => \axi_rdata_reg[1]_0\,
      I2 => \axi_rdata[1]_i_3_n_0\,
      I3 => \axi_rdata[1]_i_4_n_0\,
      I4 => \axi_rdata_reg[1]\,
      O => \regs_out_reg[0][1]\(1)
    );
\axi_rdata[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \^data_r_reg[1][8]\(2),
      I1 => \^data_r_reg[1][8]\(3),
      I2 => \^data_r_reg[1][8]\(0),
      I3 => \^data_r_reg[1][8]\(1),
      I4 => \^data_r_reg[1][10]\(1),
      I5 => \^data_r_reg[1][10]\(0),
      O => \axi_rdata[1]_i_3_n_0\
    );
\axi_rdata[1]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \^o\(1),
      I1 => \^o\(0),
      I2 => \^o\(3),
      I3 => \^o\(2),
      O => \axi_rdata[1]_i_4_n_0\
    );
empty_r_reg: unisim.vcomponents.FDSE
     port map (
      C => fifo_clk_i,
      CE => '1',
      D => \^fifo_empty_o\,
      Q => empty_r,
      S => rst
    );
fifo_aempty_o_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00010000"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(4),
      I2 => sel0(1),
      I3 => sel0(2),
      I4 => fifo_empty_o_INST_0_i_1_n_0,
      O => fifo_aempty_o
    );
fifo_empty_o_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(4),
      I2 => sel0(2),
      I3 => sel0(1),
      I4 => sel0(0),
      I5 => fifo_empty_o_INST_0_i_1_n_0,
      O => \^fifo_empty_o\
    );
fifo_empty_o_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => sel0(7),
      I1 => sel0(8),
      I2 => sel0(5),
      I3 => sel0(6),
      I4 => sel0(10),
      I5 => sel0(9),
      O => fifo_empty_o_INST_0_i_1_n_0
    );
fifo_underflow_o_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => fifo_re_i,
      I1 => empty_r,
      O => fifo_underflow_o
    );
full_r_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => \^o\(3),
      I1 => \^data_r_reg[1][8]\(0),
      I2 => \^o\(2),
      I3 => \^o\(1),
      I4 => \^o\(0),
      I5 => \axi_rdata[0]_i_2_n_0\,
      O => full
    );
full_r_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => full,
      Q => full_r,
      R => rst
    );
\g_async.i_sync_rd2wr\: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync
     port map (
      DI(3) => \g_async.i_sync_rd2wr_n_11\,
      DI(2) => \g_async.i_sync_rd2wr_n_12\,
      DI(1) => \g_async.i_sync_rd2wr_n_13\,
      DI(0) => \g_async.i_sync_rd2wr_n_14\,
      O(3) => \i__carry_i_10_n_4\,
      O(2) => \i__carry_i_10_n_5\,
      O(1) => \i__carry_i_10_n_6\,
      O(0) => \i__carry_i_10_n_7\,
      Q(0) => wr_ptr_r(10),
      S(3) => \g_async.i_sync_rd2wr_n_0\,
      S(2) => \g_async.i_sync_rd2wr_n_1\,
      S(1) => \g_async.i_sync_rd2wr_n_2\,
      S(0) => \g_async.i_sync_rd2wr_n_3\,
      \_inferred__1/i__carry__0\(3) => \i__carry__0_i_10_n_4\,
      \_inferred__1/i__carry__0\(2) => \i__carry__0_i_10_n_5\,
      \_inferred__1/i__carry__0\(1) => \i__carry__0_i_10_n_6\,
      \_inferred__1/i__carry__0\(0) => \i__carry__0_i_10_n_7\,
      \_inferred__1/i__carry__1\ => ret_carry_i_7_n_0,
      \_inferred__1/i__carry__1_0\ => \i__carry_i_11_n_0\,
      \_inferred__1/i__carry__1_1\(2) => \i__carry__1_i_6_n_5\,
      \_inferred__1/i__carry__1_1\(1) => \i__carry__1_i_6_n_6\,
      \_inferred__1/i__carry__1_1\(0) => \i__carry__1_i_6_n_7\,
      axil_aclk => axil_aclk,
      \data_r_reg[0][10]_0\(10 downto 0) => rd_ptr_r(10 downto 0),
      \data_r_reg[1][10]_0\(1) => \g_async.i_sync_rd2wr_n_19\,
      \data_r_reg[1][10]_0\(0) => \g_async.i_sync_rd2wr_n_20\,
      \data_r_reg[1][7]_0\(3) => \g_async.i_sync_rd2wr_n_4\,
      \data_r_reg[1][7]_0\(2) => \g_async.i_sync_rd2wr_n_5\,
      \data_r_reg[1][7]_0\(1) => \g_async.i_sync_rd2wr_n_6\,
      \data_r_reg[1][7]_0\(0) => \g_async.i_sync_rd2wr_n_7\,
      \data_r_reg[1][8]_0\(3) => \g_async.i_sync_rd2wr_n_15\,
      \data_r_reg[1][8]_0\(2) => \g_async.i_sync_rd2wr_n_16\,
      \data_r_reg[1][8]_0\(1) => \g_async.i_sync_rd2wr_n_17\,
      \data_r_reg[1][8]_0\(0) => \g_async.i_sync_rd2wr_n_18\,
      \wr_ptr_r_reg[10]\(2) => \g_async.i_sync_rd2wr_n_8\,
      \wr_ptr_r_reg[10]\(1) => \g_async.i_sync_rd2wr_n_9\,
      \wr_ptr_r_reg[10]\(0) => \g_async.i_sync_rd2wr_n_10\
    );
\g_async.i_sync_wr2rd\: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_GraySync_0
     port map (
      Q(0) => rd_ptr_r(10),
      S(2) => \g_async.i_sync_wr2rd_n_0\,
      S(1) => \g_async.i_sync_wr2rd_n_1\,
      S(0) => \g_async.i_sync_wr2rd_n_2\,
      \_inferred__4/i__carry__1\ => \i__carry__1_i_4_n_0\,
      \data_r_reg[0][10]_0\(10 downto 0) => wr_ptr_r(10 downto 0),
      \data_r_reg[1][4]_0\(3) => \g_async.i_sync_wr2rd_n_13\,
      \data_r_reg[1][4]_0\(2) => \g_async.i_sync_wr2rd_n_14\,
      \data_r_reg[1][4]_0\(1) => \g_async.i_sync_wr2rd_n_15\,
      \data_r_reg[1][4]_0\(0) => \g_async.i_sync_wr2rd_n_16\,
      \data_r_reg[1][8]_0\(3) => \g_async.i_sync_wr2rd_n_17\,
      \data_r_reg[1][8]_0\(2) => \g_async.i_sync_wr2rd_n_18\,
      \data_r_reg[1][8]_0\(1) => \g_async.i_sync_wr2rd_n_19\,
      \data_r_reg[1][8]_0\(0) => \g_async.i_sync_wr2rd_n_20\,
      fifo_clk_i => fifo_clk_i,
      ret(10 downto 0) => ret(10 downto 0),
      wr_in_rd_bin(9 downto 0) => wr_in_rd_bin(9 downto 0)
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => \i__carry__0_i_5_n_0\,
      I1 => rd_ptr_r(5),
      I2 => rd_ptr_r(4),
      I3 => rd_ptr_r(6),
      I4 => rd_ptr_r(7),
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \i__carry_i_10_n_0\,
      CO(3) => \i__carry__0_i_10_n_0\,
      CO(2) => \i__carry__0_i_10_n_1\,
      CO(1) => \i__carry__0_i_10_n_2\,
      CO(0) => \i__carry__0_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \i__carry__0_i_10_n_4\,
      O(2) => \i__carry__0_i_10_n_5\,
      O(1) => \i__carry__0_i_10_n_6\,
      O(0) => \i__carry__0_i_10_n_7\,
      S(3 downto 0) => wr_ptr_r(7 downto 4)
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => \i__carry__0_i_5_n_0\,
      I1 => rd_ptr_r(5),
      I2 => rd_ptr_r(4),
      I3 => rd_ptr_r(7),
      I4 => rd_ptr_r(6),
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => rd_ptr_r(4),
      I1 => rd_ptr_r(5),
      I2 => \i__carry__0_i_5_n_0\,
      I3 => rd_ptr_r(7),
      I4 => rd_ptr_r(6),
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => rd_ptr_r(5),
      I1 => rd_ptr_r(4),
      I2 => \i__carry__0_i_5_n_0\,
      I3 => rd_ptr_r(7),
      I4 => rd_ptr_r(6),
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__0_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFFFFFF"
    )
        port map (
      I0 => \i__carry_i_8_n_0\,
      I1 => empty_r,
      I2 => fifo_re_i,
      I3 => rd_ptr_r(8),
      I4 => rd_ptr_r(9),
      O => \i__carry__0_i_5_n_0\
    );
\i__carry__0_i_9__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \i__carry_i_9__1_n_0\,
      CO(3) => \i__carry__0_i_9__0_n_0\,
      CO(2) => \i__carry__0_i_9__0_n_1\,
      CO(1) => \i__carry__0_i_9__0_n_2\,
      CO(0) => \i__carry__0_i_9__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => ret(7 downto 4),
      S(3 downto 0) => rd_ptr_r(7 downto 4)
    );
\i__carry__1_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \i__carry__1_i_4_n_0\,
      I1 => rd_ptr_r(10),
      O => \i__carry__1_i_1__1_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCC4CC"
    )
        port map (
      I0 => rd_ptr_r(8),
      I1 => rd_ptr_r(9),
      I2 => \i__carry_i_6_n_0\,
      I3 => fifo_re_i,
      I4 => empty_r,
      O => \i__carry__1_i_2_n_0\
    );
\i__carry__1_i_3__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCC4CC"
    )
        port map (
      I0 => rd_ptr_r(9),
      I1 => rd_ptr_r(8),
      I2 => \i__carry_i_6_n_0\,
      I3 => fifo_re_i,
      I4 => empty_r,
      O => \i__carry__1_i_3__0_n_0\
    );
\i__carry__1_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFFFF"
    )
        port map (
      I0 => \i__carry_i_7_n_0\,
      I1 => rd_ptr_r(2),
      I2 => rd_ptr_r(3),
      I3 => rd_ptr_r(0),
      I4 => rd_ptr_r(1),
      O => \i__carry__1_i_4_n_0\
    );
\i__carry__1_i_6\: unisim.vcomponents.CARRY4
     port map (
      CI => \i__carry__0_i_10_n_0\,
      CO(3 downto 2) => \NLW_i__carry__1_i_6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \i__carry__1_i_6_n_2\,
      CO(0) => \i__carry__1_i_6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_i__carry__1_i_6_O_UNCONNECTED\(3),
      O(2) => \i__carry__1_i_6_n_5\,
      O(1) => \i__carry__1_i_6_n_6\,
      O(0) => \i__carry__1_i_6_n_7\,
      S(3) => '0',
      S(2 downto 0) => wr_ptr_r(10 downto 8)
    );
\i__carry__1_i_6__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \i__carry__0_i_9__0_n_0\,
      CO(3 downto 2) => \NLW_i__carry__1_i_6__0_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \i__carry__1_i_6__0_n_2\,
      CO(0) => \i__carry__1_i_6__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_i__carry__1_i_6__0_O_UNCONNECTED\(3),
      O(2 downto 0) => ret(10 downto 8),
      S(3) => '0',
      S(2 downto 0) => rd_ptr_r(10 downto 8)
    );
\i__carry_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20303030"
    )
        port map (
      I0 => \i__carry_i_6_n_0\,
      I1 => empty_r,
      I2 => fifo_re_i,
      I3 => rd_ptr_r(8),
      I4 => rd_ptr_r(9),
      O => \i__carry_i_1_n_0\
    );
\i__carry_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \i__carry_i_10_n_0\,
      CO(2) => \i__carry_i_10_n_1\,
      CO(1) => \i__carry_i_10_n_2\,
      CO(0) => \i__carry_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => wr_ptr_r(0),
      O(3) => \i__carry_i_10_n_4\,
      O(2) => \i__carry_i_10_n_5\,
      O(1) => \i__carry_i_10_n_6\,
      O(0) => \i__carry_i_10_n_7\,
      S(3 downto 1) => wr_ptr_r(3 downto 1),
      S(0) => \i__carry_i_14_n_0\
    );
\i__carry_i_10__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A6"
    )
        port map (
      I0 => rd_ptr_r(0),
      I1 => fifo_re_i,
      I2 => empty_r,
      O => \i__carry_i_10__0_n_0\
    );
\i__carry_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => wr_ptr_r(1),
      I1 => wr_ptr_r(0),
      I2 => wr_ptr_r(3),
      I3 => wr_ptr_r(2),
      O => \i__carry_i_11_n_0\
    );
\i__carry_i_14\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => wr_ptr_r(0),
      I1 => \wr_ptr_r_reg[3]_0\,
      O => \i__carry_i_14_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => \i__carry_i_7_n_0\,
      I1 => rd_ptr_r(1),
      I2 => rd_ptr_r(0),
      I3 => rd_ptr_r(2),
      I4 => rd_ptr_r(3),
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => \i__carry_i_7_n_0\,
      I1 => rd_ptr_r(1),
      I2 => rd_ptr_r(0),
      I3 => rd_ptr_r(3),
      I4 => rd_ptr_r(2),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => rd_ptr_r(0),
      I1 => rd_ptr_r(1),
      I2 => \i__carry_i_7_n_0\,
      I3 => rd_ptr_r(3),
      I4 => rd_ptr_r(2),
      O => \i__carry_i_4_n_0\
    );
\i__carry_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => rd_ptr_r(1),
      I1 => rd_ptr_r(0),
      I2 => \i__carry_i_7_n_0\,
      I3 => rd_ptr_r(3),
      I4 => rd_ptr_r(2),
      O => \i__carry_i_5_n_0\
    );
\i__carry_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFFFF"
    )
        port map (
      I0 => \i__carry_i_8_n_0\,
      I1 => rd_ptr_r(6),
      I2 => rd_ptr_r(7),
      I3 => rd_ptr_r(4),
      I4 => rd_ptr_r(5),
      O => \i__carry_i_6_n_0\
    );
\i__carry_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF7FFF"
    )
        port map (
      I0 => rd_ptr_r(6),
      I1 => rd_ptr_r(7),
      I2 => rd_ptr_r(4),
      I3 => rd_ptr_r(5),
      I4 => \i__carry_i_9_n_0\,
      O => \i__carry_i_7_n_0\
    );
\i__carry_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => rd_ptr_r(1),
      I1 => rd_ptr_r(0),
      I2 => rd_ptr_r(3),
      I3 => rd_ptr_r(2),
      O => \i__carry_i_8_n_0\
    );
\i__carry_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => rd_ptr_r(9),
      I1 => rd_ptr_r(8),
      I2 => fifo_re_i,
      I3 => empty_r,
      O => \i__carry_i_9_n_0\
    );
\i__carry_i_9__1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \i__carry_i_9__1_n_0\,
      CO(2) => \i__carry_i_9__1_n_1\,
      CO(1) => \i__carry_i_9__1_n_2\,
      CO(0) => \i__carry_i_9__1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => rd_ptr_r(0),
      O(3 downto 0) => ret(3 downto 0),
      S(3 downto 1) => rd_ptr_r(3 downto 1),
      S(0) => \i__carry_i_10__0_n_0\
    );
i_memory: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tdpram
     port map (
      Q(9 downto 0) => wr_ptr_r(9 downto 0),
      axil_aclk => axil_aclk,
      axil_wdata(23 downto 0) => axil_wdata(23 downto 0),
      fifo_clk_i => fifo_clk_i,
      fifo_data_o(23 downto 0) => fifo_data_o(23 downto 0),
      p_4_in => p_4_in,
      ram_reg_0(9 downto 0) => rd_ptr_r(9 downto 0)
    );
\rd_ptr_r_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry_n_7\,
      Q => rd_ptr_r(0),
      R => rst
    );
\rd_ptr_r_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__1_n_5\,
      Q => rd_ptr_r(10),
      R => rst
    );
\rd_ptr_r_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry_n_6\,
      Q => rd_ptr_r(1),
      R => rst
    );
\rd_ptr_r_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry_n_5\,
      Q => rd_ptr_r(2),
      R => rst
    );
\rd_ptr_r_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry_n_4\,
      Q => rd_ptr_r(3),
      R => rst
    );
\rd_ptr_r_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__0_n_7\,
      Q => rd_ptr_r(4),
      R => rst
    );
\rd_ptr_r_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__0_n_6\,
      Q => rd_ptr_r(5),
      R => rst
    );
\rd_ptr_r_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__0_n_5\,
      Q => rd_ptr_r(6),
      R => rst
    );
\rd_ptr_r_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__0_n_4\,
      Q => rd_ptr_r(7),
      R => rst
    );
\rd_ptr_r_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__1_n_7\,
      Q => rd_ptr_r(8),
      R => rst
    );
\rd_ptr_r_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => fifo_clk_i,
      CE => '1',
      D => \ret_inferred__1/i__carry__1_n_6\,
      Q => rd_ptr_r(9),
      R => rst
    );
ret_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ret_carry_n_0,
      CO(2) => ret_carry_n_1,
      CO(1) => ret_carry_n_2,
      CO(0) => ret_carry_n_3,
      CYINIT => ret_carry_i_1_n_0,
      DI(3 downto 0) => B"0000",
      O(3) => ret_carry_n_4,
      O(2) => ret_carry_n_5,
      O(1) => ret_carry_n_6,
      O(0) => ret_carry_n_7,
      S(3) => ret_carry_i_2_n_0,
      S(2) => ret_carry_i_3_n_0,
      S(1) => ret_carry_i_4_n_0,
      S(0) => ret_carry_i_5_n_0
    );
\ret_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => ret_carry_n_0,
      CO(3) => \ret_carry__0_n_0\,
      CO(2) => \ret_carry__0_n_1\,
      CO(1) => \ret_carry__0_n_2\,
      CO(0) => \ret_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \ret_carry__0_n_4\,
      O(2) => \ret_carry__0_n_5\,
      O(1) => \ret_carry__0_n_6\,
      O(0) => \ret_carry__0_n_7\,
      S(3) => \ret_carry__0_i_1_n_0\,
      S(2) => \ret_carry__0_i_2_n_0\,
      S(1) => \ret_carry__0_i_3_n_0\,
      S(0) => \ret_carry__0_i_4_n_0\
    );
\ret_carry__0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => \ret_carry__0_i_5_n_0\,
      I1 => wr_ptr_r(6),
      I2 => wr_ptr_r(7),
      O => \ret_carry__0_i_1_n_0\
    );
\ret_carry__0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => \ret_carry__0_i_5_n_0\,
      I1 => wr_ptr_r(7),
      I2 => wr_ptr_r(6),
      O => \ret_carry__0_i_2_n_0\
    );
\ret_carry__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C4"
    )
        port map (
      I0 => wr_ptr_r(4),
      I1 => wr_ptr_r(5),
      I2 => \ret_carry__0_i_6_n_0\,
      O => \ret_carry__0_i_3_n_0\
    );
\ret_carry__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C4"
    )
        port map (
      I0 => wr_ptr_r(5),
      I1 => wr_ptr_r(4),
      I2 => \ret_carry__0_i_6_n_0\,
      O => \ret_carry__0_i_4_n_0\
    );
\ret_carry__0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFFFFF"
    )
        port map (
      I0 => wr_ptr_r(9),
      I1 => wr_ptr_r(8),
      I2 => \wr_ptr_r_reg[3]_0\,
      I3 => \i__carry_i_11_n_0\,
      I4 => wr_ptr_r(5),
      I5 => wr_ptr_r(4),
      O => \ret_carry__0_i_5_n_0\
    );
\ret_carry__0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFFFFF"
    )
        port map (
      I0 => wr_ptr_r(9),
      I1 => wr_ptr_r(8),
      I2 => \wr_ptr_r_reg[3]_0\,
      I3 => \i__carry_i_11_n_0\,
      I4 => wr_ptr_r(7),
      I5 => wr_ptr_r(6),
      O => \ret_carry__0_i_6_n_0\
    );
\ret_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \ret_carry__0_n_0\,
      CO(3 downto 2) => \NLW_ret_carry__1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \ret_carry__1_n_2\,
      CO(0) => \ret_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_ret_carry__1_O_UNCONNECTED\(3),
      O(2) => \ret_carry__1_n_5\,
      O(1) => \ret_carry__1_n_6\,
      O(0) => \ret_carry__1_n_7\,
      S(3) => '0',
      S(2) => \ret_carry__1_i_1_n_0\,
      S(1) => \ret_carry__1_i_2_n_0\,
      S(0) => \ret_carry__1_i_3_n_0\
    );
\ret_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF7FFF00008000"
    )
        port map (
      I0 => wr_ptr_r(1),
      I1 => wr_ptr_r(0),
      I2 => wr_ptr_r(3),
      I3 => wr_ptr_r(2),
      I4 => ret_carry_i_7_n_0,
      I5 => wr_ptr_r(10),
      O => \ret_carry__1_i_1_n_0\
    );
\ret_carry__1_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C4"
    )
        port map (
      I0 => wr_ptr_r(8),
      I1 => wr_ptr_r(9),
      I2 => \ret_carry__1_i_4_n_0\,
      O => \ret_carry__1_i_2_n_0\
    );
\ret_carry__1_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C4"
    )
        port map (
      I0 => wr_ptr_r(9),
      I1 => wr_ptr_r(8),
      I2 => \ret_carry__1_i_4_n_0\,
      O => \ret_carry__1_i_3_n_0\
    );
\ret_carry__1_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF7FFF"
    )
        port map (
      I0 => wr_ptr_r(5),
      I1 => wr_ptr_r(4),
      I2 => wr_ptr_r(7),
      I3 => wr_ptr_r(6),
      I4 => \i__carry_i_11_n_0\,
      I5 => \wr_ptr_r_reg[3]_0\,
      O => \ret_carry__1_i_4_n_0\
    );
ret_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2333"
    )
        port map (
      I0 => ret_carry_i_6_n_0,
      I1 => \wr_ptr_r_reg[3]_0\,
      I2 => wr_ptr_r(8),
      I3 => wr_ptr_r(9),
      O => ret_carry_i_1_n_0
    );
ret_carry_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => ret_carry_i_7_n_0,
      I1 => wr_ptr_r(1),
      I2 => wr_ptr_r(0),
      I3 => wr_ptr_r(2),
      I4 => wr_ptr_r(3),
      O => ret_carry_i_2_n_0
    );
ret_carry_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF0000"
    )
        port map (
      I0 => ret_carry_i_7_n_0,
      I1 => wr_ptr_r(1),
      I2 => wr_ptr_r(0),
      I3 => wr_ptr_r(3),
      I4 => wr_ptr_r(2),
      O => ret_carry_i_3_n_0
    );
ret_carry_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => wr_ptr_r(0),
      I1 => wr_ptr_r(1),
      I2 => ret_carry_i_7_n_0,
      I3 => wr_ptr_r(3),
      I4 => wr_ptr_r(2),
      O => ret_carry_i_4_n_0
    );
ret_carry_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"C4CCCCCC"
    )
        port map (
      I0 => wr_ptr_r(1),
      I1 => wr_ptr_r(0),
      I2 => ret_carry_i_7_n_0,
      I3 => wr_ptr_r(3),
      I4 => wr_ptr_r(2),
      O => ret_carry_i_5_n_0
    );
ret_carry_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFFFFFF"
    )
        port map (
      I0 => \i__carry_i_11_n_0\,
      I1 => wr_ptr_r(6),
      I2 => wr_ptr_r(7),
      I3 => wr_ptr_r(4),
      I4 => wr_ptr_r(5),
      O => ret_carry_i_6_n_0
    );
ret_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => ret_carry_i_8_n_0,
      I1 => \wr_ptr_r_reg[3]_0\,
      I2 => wr_ptr_r(8),
      I3 => wr_ptr_r(9),
      O => ret_carry_i_7_n_0
    );
ret_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => wr_ptr_r(5),
      I1 => wr_ptr_r(4),
      I2 => wr_ptr_r(7),
      I3 => wr_ptr_r(6),
      O => ret_carry_i_8_n_0
    );
\ret_inferred__1/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \ret_inferred__1/i__carry_n_0\,
      CO(2) => \ret_inferred__1/i__carry_n_1\,
      CO(1) => \ret_inferred__1/i__carry_n_2\,
      CO(0) => \ret_inferred__1/i__carry_n_3\,
      CYINIT => \i__carry_i_1_n_0\,
      DI(3 downto 0) => B"0000",
      O(3) => \ret_inferred__1/i__carry_n_4\,
      O(2) => \ret_inferred__1/i__carry_n_5\,
      O(1) => \ret_inferred__1/i__carry_n_6\,
      O(0) => \ret_inferred__1/i__carry_n_7\,
      S(3) => \i__carry_i_2_n_0\,
      S(2) => \i__carry_i_3_n_0\,
      S(1) => \i__carry_i_4_n_0\,
      S(0) => \i__carry_i_5_n_0\
    );
\ret_inferred__1/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \ret_inferred__1/i__carry_n_0\,
      CO(3) => \ret_inferred__1/i__carry__0_n_0\,
      CO(2) => \ret_inferred__1/i__carry__0_n_1\,
      CO(1) => \ret_inferred__1/i__carry__0_n_2\,
      CO(0) => \ret_inferred__1/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \ret_inferred__1/i__carry__0_n_4\,
      O(2) => \ret_inferred__1/i__carry__0_n_5\,
      O(1) => \ret_inferred__1/i__carry__0_n_6\,
      O(0) => \ret_inferred__1/i__carry__0_n_7\,
      S(3) => \i__carry__0_i_1_n_0\,
      S(2) => \i__carry__0_i_2_n_0\,
      S(1) => \i__carry__0_i_3_n_0\,
      S(0) => \i__carry__0_i_4_n_0\
    );
\ret_inferred__1/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \ret_inferred__1/i__carry__0_n_0\,
      CO(3 downto 2) => \NLW_ret_inferred__1/i__carry__1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \ret_inferred__1/i__carry__1_n_2\,
      CO(0) => \ret_inferred__1/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_ret_inferred__1/i__carry__1_O_UNCONNECTED\(3),
      O(2) => \ret_inferred__1/i__carry__1_n_5\,
      O(1) => \ret_inferred__1/i__carry__1_n_6\,
      O(0) => \ret_inferred__1/i__carry__1_n_7\,
      S(3) => '0',
      S(2) => \i__carry__1_i_1__1_n_0\,
      S(1) => \i__carry__1_i_2_n_0\,
      S(0) => \i__carry__1_i_3__0_n_0\
    );
valid_r_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \wr_ptr_r_reg[0]_0\,
      I1 => fifo_clear_i,
      O => rst
    );
valid_r_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => fifo_re_i,
      I1 => empty_r,
      O => p_2_in
    );
valid_r_reg: unisim.vcomponents.FDRE
     port map (
      C => fifo_clk_i,
      CE => '1',
      D => p_2_in,
      Q => fifo_valid_o,
      R => rst
    );
\wr_ptr_r_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => ret_carry_n_7,
      Q => wr_ptr_r(0),
      R => rst
    );
\wr_ptr_r_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__1_n_5\,
      Q => wr_ptr_r(10),
      R => rst
    );
\wr_ptr_r_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => ret_carry_n_6,
      Q => wr_ptr_r(1),
      R => rst
    );
\wr_ptr_r_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => ret_carry_n_5,
      Q => wr_ptr_r(2),
      R => rst
    );
\wr_ptr_r_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => ret_carry_n_4,
      Q => wr_ptr_r(3),
      R => rst
    );
\wr_ptr_r_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__0_n_7\,
      Q => wr_ptr_r(4),
      R => rst
    );
\wr_ptr_r_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__0_n_6\,
      Q => wr_ptr_r(5),
      R => rst
    );
\wr_ptr_r_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__0_n_5\,
      Q => wr_ptr_r(6),
      R => rst
    );
\wr_ptr_r_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__0_n_4\,
      Q => wr_ptr_r(7),
      R => rst
    );
\wr_ptr_r_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__1_n_7\,
      Q => wr_ptr_r(8),
      R => rst
    );
\wr_ptr_r_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => \ret_carry__1_n_6\,
      Q => wr_ptr_r(9),
      R => rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ComBlock is
  port (
    fifo_data_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    full_r : out STD_LOGIC;
    fifo_empty_o : out STD_LOGIC;
    fifo_valid_o : out STD_LOGIC;
    O : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][8]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \data_r_reg[1][10]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    fifo_out_over_r : out STD_LOGIC;
    fifo_underflow_o : out STD_LOGIC;
    \regs_out_reg[0][1]_0\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    reg0_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    fifo_aempty_o : out STD_LOGIC;
    axil_aclk : in STD_LOGIC;
    fifo_clk_i : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    axil_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    fifo_out_over_r_reg_0 : in STD_LOGIC;
    fifo_out_clear_reg_0 : in STD_LOGIC;
    \wr_ptr_r_reg[3]\ : in STD_LOGIC;
    fifo_re_i : in STD_LOGIC;
    fifo_clear_i : in STD_LOGIC;
    \axi_rdata_reg[0]\ : in STD_LOGIC;
    reg0_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    \axi_rdata_reg[0]_0\ : in STD_LOGIC;
    \axi_rdata_reg[1]\ : in STD_LOGIC;
    \axi_rdata_reg[1]_0\ : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ComBlock;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ComBlock is
  signal fifo_out_clear_reg_n_0 : STD_LOGIC;
  signal \^reg0_o\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  reg0_o(31 downto 0) <= \^reg0_o\(31 downto 0);
fifo_out_clear_reg: unisim.vcomponents.FDRE
     port map (
      C => axil_aclk,
      CE => '1',
      D => fifo_out_clear_reg_0,
      Q => fifo_out_clear_reg_n_0,
      R => '0'
    );
\fifo_out_g.fifo_out_i\: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_FIFO
     port map (
      O(3 downto 0) => O(3 downto 0),
      \axi_rdata_reg[0]\ => \axi_rdata_reg[0]\,
      \axi_rdata_reg[0]_0\ => \axi_rdata_reg[0]_0\,
      \axi_rdata_reg[1]\ => \axi_rdata_reg[1]\,
      \axi_rdata_reg[1]_0\ => \axi_rdata_reg[1]_0\,
      axil_aclk => axil_aclk,
      axil_wdata(23 downto 0) => axil_wdata(23 downto 0),
      \data_r_reg[1][10]\(2 downto 0) => \data_r_reg[1][10]\(2 downto 0),
      \data_r_reg[1][8]\(3 downto 0) => \data_r_reg[1][8]\(3 downto 0),
      fifo_aempty_o => fifo_aempty_o,
      fifo_clear_i => fifo_clear_i,
      fifo_clk_i => fifo_clk_i,
      fifo_data_o(23 downto 0) => fifo_data_o(23 downto 0),
      fifo_empty_o => fifo_empty_o,
      fifo_re_i => fifo_re_i,
      fifo_underflow_o => fifo_underflow_o,
      fifo_valid_o => fifo_valid_o,
      full_r => full_r,
      p_4_in => p_4_in,
      reg0_i(0) => reg0_i(0),
      reg0_o(0) => \^reg0_o\(0),
      \regs_out_reg[0][1]\(1 downto 0) => \regs_out_reg[0][1]_0\(1 downto 0),
      \wr_ptr_r_reg[0]_0\ => fifo_out_clear_reg_n_0,
      \wr_ptr_r_reg[3]_0\ => \wr_ptr_r_reg[3]\
    );
fifo_out_over_r_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => '1',
      D => fifo_out_over_r_reg_0,
      Q => fifo_out_over_r,
      R => '0'
    );
\regs_out_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(0),
      Q => \^reg0_o\(0),
      R => '0'
    );
\regs_out_reg[0][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(10),
      Q => \^reg0_o\(10),
      R => '0'
    );
\regs_out_reg[0][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(11),
      Q => \^reg0_o\(11),
      R => '0'
    );
\regs_out_reg[0][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(12),
      Q => \^reg0_o\(12),
      R => '0'
    );
\regs_out_reg[0][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(13),
      Q => \^reg0_o\(13),
      R => '0'
    );
\regs_out_reg[0][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(14),
      Q => \^reg0_o\(14),
      R => '0'
    );
\regs_out_reg[0][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(15),
      Q => \^reg0_o\(15),
      R => '0'
    );
\regs_out_reg[0][16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(16),
      Q => \^reg0_o\(16),
      R => '0'
    );
\regs_out_reg[0][17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(17),
      Q => \^reg0_o\(17),
      R => '0'
    );
\regs_out_reg[0][18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(18),
      Q => \^reg0_o\(18),
      R => '0'
    );
\regs_out_reg[0][19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(19),
      Q => \^reg0_o\(19),
      R => '0'
    );
\regs_out_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(1),
      Q => \^reg0_o\(1),
      R => '0'
    );
\regs_out_reg[0][20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(20),
      Q => \^reg0_o\(20),
      R => '0'
    );
\regs_out_reg[0][21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(21),
      Q => \^reg0_o\(21),
      R => '0'
    );
\regs_out_reg[0][22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(22),
      Q => \^reg0_o\(22),
      R => '0'
    );
\regs_out_reg[0][23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(23),
      Q => \^reg0_o\(23),
      R => '0'
    );
\regs_out_reg[0][24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(24),
      Q => \^reg0_o\(24),
      R => '0'
    );
\regs_out_reg[0][25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(25),
      Q => \^reg0_o\(25),
      R => '0'
    );
\regs_out_reg[0][26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(26),
      Q => \^reg0_o\(26),
      R => '0'
    );
\regs_out_reg[0][27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(27),
      Q => \^reg0_o\(27),
      R => '0'
    );
\regs_out_reg[0][28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(28),
      Q => \^reg0_o\(28),
      R => '0'
    );
\regs_out_reg[0][29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(29),
      Q => \^reg0_o\(29),
      R => '0'
    );
\regs_out_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(2),
      Q => \^reg0_o\(2),
      R => '0'
    );
\regs_out_reg[0][30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(30),
      Q => \^reg0_o\(30),
      R => '0'
    );
\regs_out_reg[0][31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(31),
      Q => \^reg0_o\(31),
      R => '0'
    );
\regs_out_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(3),
      Q => \^reg0_o\(3),
      R => '0'
    );
\regs_out_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(4),
      Q => \^reg0_o\(4),
      R => '0'
    );
\regs_out_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(5),
      Q => \^reg0_o\(5),
      R => '0'
    );
\regs_out_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(6),
      Q => \^reg0_o\(6),
      R => '0'
    );
\regs_out_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(7),
      Q => \^reg0_o\(7),
      R => '0'
    );
\regs_out_reg[0][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(8),
      Q => \^reg0_o\(8),
      R => '0'
    );
\regs_out_reg[0][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => axil_aclk,
      CE => E(0),
      D => axil_wdata(9),
      Q => \^reg0_o\(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_comblock is
  port (
    fifo_data_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    axil_awready : out STD_LOGIC;
    axil_wready : out STD_LOGIC;
    axil_arready : out STD_LOGIC;
    axil_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    axi_rvalid_reg : out STD_LOGIC;
    fifo_empty_o : out STD_LOGIC;
    fifo_valid_o : out STD_LOGIC;
    reg0_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    fifo_underflow_o : out STD_LOGIC;
    fifo_aempty_o : out STD_LOGIC;
    axil_bvalid : out STD_LOGIC;
    fifo_re_i : in STD_LOGIC;
    axil_aclk : in STD_LOGIC;
    fifo_clk_i : in STD_LOGIC;
    axil_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axil_awaddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axil_araddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    axil_arvalid : in STD_LOGIC;
    axil_awvalid : in STD_LOGIC;
    axil_wvalid : in STD_LOGIC;
    fifo_clear_i : in STD_LOGIC;
    reg0_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    axil_aresetn : in STD_LOGIC;
    axil_bready : in STD_LOGIC;
    axil_rready : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_comblock;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_comblock is
  signal AXIL_inst_n_10 : STD_LOGIC;
  signal AXIL_inst_n_11 : STD_LOGIC;
  signal AXIL_inst_n_12 : STD_LOGIC;
  signal AXIL_inst_n_13 : STD_LOGIC;
  signal AXIL_inst_n_5 : STD_LOGIC;
  signal AXIL_inst_n_7 : STD_LOGIC;
  signal AXIL_inst_n_8 : STD_LOGIC;
  signal comblock_i_n_27 : STD_LOGIC;
  signal comblock_i_n_28 : STD_LOGIC;
  signal comblock_i_n_29 : STD_LOGIC;
  signal comblock_i_n_30 : STD_LOGIC;
  signal comblock_i_n_31 : STD_LOGIC;
  signal comblock_i_n_32 : STD_LOGIC;
  signal comblock_i_n_33 : STD_LOGIC;
  signal comblock_i_n_34 : STD_LOGIC;
  signal comblock_i_n_35 : STD_LOGIC;
  signal comblock_i_n_36 : STD_LOGIC;
  signal comblock_i_n_37 : STD_LOGIC;
  signal \fifo_out_g.fifo_out_i/full_r\ : STD_LOGIC;
  signal \fifo_out_g.fifo_out_i/p_4_in\ : STD_LOGIC;
  signal fifo_out_over_r : STD_LOGIC;
  signal \^reg0_o\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal reg_rd_dat : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \regs_out[0]_0\ : STD_LOGIC;
begin
  reg0_o(31 downto 0) <= \^reg0_o\(31 downto 0);
AXIL_inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_AXIL
     port map (
      E(0) => \regs_out[0]_0\,
      O(3) => comblock_i_n_27,
      O(2) => comblock_i_n_28,
      O(1) => comblock_i_n_29,
      O(0) => comblock_i_n_30,
      \axi_araddr_reg[2]_0\ => AXIL_inst_n_8,
      \axi_araddr_reg[3]_0\ => AXIL_inst_n_11,
      \axi_araddr_reg[3]_1\ => AXIL_inst_n_12,
      \axi_awaddr_reg[7]_0\ => AXIL_inst_n_5,
      \axi_awaddr_reg[7]_1\ => AXIL_inst_n_10,
      \axi_rdata_reg[1]_0\(1 downto 0) => reg_rd_dat(1 downto 0),
      \axi_rdata_reg[23]_0\(3) => comblock_i_n_31,
      \axi_rdata_reg[23]_0\(2) => comblock_i_n_32,
      \axi_rdata_reg[23]_0\(1) => comblock_i_n_33,
      \axi_rdata_reg[23]_0\(0) => comblock_i_n_34,
      \axi_rdata_reg[26]_0\(2) => comblock_i_n_35,
      \axi_rdata_reg[26]_0\(1) => comblock_i_n_36,
      \axi_rdata_reg[26]_0\(0) => comblock_i_n_37,
      axi_rvalid_reg_0 => axi_rvalid_reg,
      axil_aclk => axil_aclk,
      axil_araddr(5 downto 0) => axil_araddr(5 downto 0),
      axil_aresetn => axil_aresetn,
      axil_arready => axil_arready,
      axil_arvalid => axil_arvalid,
      axil_awaddr(5 downto 0) => axil_awaddr(5 downto 0),
      axil_awready => axil_awready,
      axil_awvalid => axil_awvalid,
      axil_bready => axil_bready,
      axil_bvalid => axil_bvalid,
      axil_rdata(31 downto 0) => axil_rdata(31 downto 0),
      axil_rready => axil_rready,
      axil_wready => axil_wready,
      axil_wvalid => axil_wvalid,
      fifo_out_over_r => fifo_out_over_r,
      full_r => \fifo_out_g.fifo_out_i/full_r\,
      p_4_in => \fifo_out_g.fifo_out_i/p_4_in\,
      rd_val_o_reg_0 => AXIL_inst_n_7,
      reg0_i(30 downto 0) => reg0_i(31 downto 1),
      reg0_o(30 downto 0) => \^reg0_o\(31 downto 1),
      \regs_out_reg[0][1]\ => AXIL_inst_n_13
    );
comblock_i: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ComBlock
     port map (
      E(0) => \regs_out[0]_0\,
      O(3) => comblock_i_n_27,
      O(2) => comblock_i_n_28,
      O(1) => comblock_i_n_29,
      O(0) => comblock_i_n_30,
      \axi_rdata_reg[0]\ => AXIL_inst_n_11,
      \axi_rdata_reg[0]_0\ => AXIL_inst_n_12,
      \axi_rdata_reg[1]\ => AXIL_inst_n_8,
      \axi_rdata_reg[1]_0\ => AXIL_inst_n_13,
      axil_aclk => axil_aclk,
      axil_wdata(31 downto 0) => axil_wdata(31 downto 0),
      \data_r_reg[1][10]\(2) => comblock_i_n_35,
      \data_r_reg[1][10]\(1) => comblock_i_n_36,
      \data_r_reg[1][10]\(0) => comblock_i_n_37,
      \data_r_reg[1][8]\(3) => comblock_i_n_31,
      \data_r_reg[1][8]\(2) => comblock_i_n_32,
      \data_r_reg[1][8]\(1) => comblock_i_n_33,
      \data_r_reg[1][8]\(0) => comblock_i_n_34,
      fifo_aempty_o => fifo_aempty_o,
      fifo_clear_i => fifo_clear_i,
      fifo_clk_i => fifo_clk_i,
      fifo_data_o(23 downto 0) => fifo_data_o(23 downto 0),
      fifo_empty_o => fifo_empty_o,
      fifo_out_clear_reg_0 => AXIL_inst_n_5,
      fifo_out_over_r => fifo_out_over_r,
      fifo_out_over_r_reg_0 => AXIL_inst_n_7,
      fifo_re_i => fifo_re_i,
      fifo_underflow_o => fifo_underflow_o,
      fifo_valid_o => fifo_valid_o,
      full_r => \fifo_out_g.fifo_out_i/full_r\,
      p_4_in => \fifo_out_g.fifo_out_i/p_4_in\,
      reg0_i(0) => reg0_i(0),
      reg0_o(31 downto 0) => \^reg0_o\(31 downto 0),
      \regs_out_reg[0][1]_0\(1 downto 0) => reg_rd_dat(1 downto 0),
      \wr_ptr_r_reg[3]\ => AXIL_inst_n_10
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    reg0_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    reg0_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "comblock_setup_comblock_0_0,axi_comblock,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "package_project";
  attribute x_core_info : string;
  attribute x_core_info of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "axi_comblock,Vivado 2023.1";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of axil_aclk : signal is "xilinx.com:signal:clock:1.0 axil_aclk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of axil_aclk : signal is "XIL_INTERFACENAME axil_aclk, ASSOCIATED_RESET axil_aresetn, ASSOCIATED_BUSIF AXIL, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN comblock_setup_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute x_interface_info of axil_aresetn : signal is "xilinx.com:signal:reset:1.0 axil_aresetn RST";
  attribute x_interface_parameter of axil_aresetn : signal is "XIL_INTERFACENAME axil_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of axil_arready : signal is "xilinx.com:interface:aximm:1.0 AXIL ARREADY";
  attribute x_interface_info of axil_arvalid : signal is "xilinx.com:interface:aximm:1.0 AXIL ARVALID";
  attribute x_interface_info of axil_awready : signal is "xilinx.com:interface:aximm:1.0 AXIL AWREADY";
  attribute x_interface_info of axil_awvalid : signal is "xilinx.com:interface:aximm:1.0 AXIL AWVALID";
  attribute x_interface_info of axil_bready : signal is "xilinx.com:interface:aximm:1.0 AXIL BREADY";
  attribute x_interface_info of axil_bvalid : signal is "xilinx.com:interface:aximm:1.0 AXIL BVALID";
  attribute x_interface_info of axil_rready : signal is "xilinx.com:interface:aximm:1.0 AXIL RREADY";
  attribute x_interface_info of axil_rvalid : signal is "xilinx.com:interface:aximm:1.0 AXIL RVALID";
  attribute x_interface_info of axil_wready : signal is "xilinx.com:interface:aximm:1.0 AXIL WREADY";
  attribute x_interface_info of axil_wvalid : signal is "xilinx.com:interface:aximm:1.0 AXIL WVALID";
  attribute x_interface_info of fifo_aempty_o : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_aempty_o";
  attribute x_interface_info of fifo_clear_i : signal is "xilinx.com:signal:reset:1.0 fifo_clear_i RST";
  attribute x_interface_parameter of fifo_clear_i : signal is "XIL_INTERFACENAME fifo_clear_i, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute x_interface_info of fifo_clk_i : signal is "xilinx.com:signal:clock:1.0 fifo_clk_i CLK";
  attribute x_interface_parameter of fifo_clk_i : signal is "XIL_INTERFACENAME fifo_clk_i, ASSOCIATED_BUSIF IN_FIFO:OUT_FIFO, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN comblock_setup_fifo_clk_i_0, INSERT_VIP 0";
  attribute x_interface_info of fifo_empty_o : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_empty_o";
  attribute x_interface_info of fifo_re_i : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_re_i";
  attribute x_interface_info of fifo_underflow_o : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_underflow_o";
  attribute x_interface_info of fifo_valid_o : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_valid_o";
  attribute x_interface_info of axil_araddr : signal is "xilinx.com:interface:aximm:1.0 AXIL ARADDR";
  attribute x_interface_info of axil_arprot : signal is "xilinx.com:interface:aximm:1.0 AXIL ARPROT";
  attribute x_interface_info of axil_awaddr : signal is "xilinx.com:interface:aximm:1.0 AXIL AWADDR";
  attribute x_interface_parameter of axil_awaddr : signal is "XIL_INTERFACENAME AXIL, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 8, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN comblock_setup_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of axil_awprot : signal is "xilinx.com:interface:aximm:1.0 AXIL AWPROT";
  attribute x_interface_info of axil_bresp : signal is "xilinx.com:interface:aximm:1.0 AXIL BRESP";
  attribute x_interface_info of axil_rdata : signal is "xilinx.com:interface:aximm:1.0 AXIL RDATA";
  attribute x_interface_info of axil_rresp : signal is "xilinx.com:interface:aximm:1.0 AXIL RRESP";
  attribute x_interface_info of axil_wdata : signal is "xilinx.com:interface:aximm:1.0 AXIL WDATA";
  attribute x_interface_info of axil_wstrb : signal is "xilinx.com:interface:aximm:1.0 AXIL WSTRB";
  attribute x_interface_info of fifo_data_o : signal is "ictp:user:OFIFO:1.0 OUT_FIFO fifo_data_o";
  attribute x_interface_info of reg0_i : signal is "ictp:user:IREGS:1.0 IN_REGS reg0_i";
  attribute x_interface_info of reg0_o : signal is "ictp:user:OREGS:1.0 OUT_REGS reg0_o";
begin
  axil_bresp(1) <= \<const0>\;
  axil_bresp(0) <= \<const0>\;
  axil_rresp(1) <= \<const0>\;
  axil_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_axi_comblock
     port map (
      axi_rvalid_reg => axil_rvalid,
      axil_aclk => axil_aclk,
      axil_araddr(5 downto 0) => axil_araddr(7 downto 2),
      axil_aresetn => axil_aresetn,
      axil_arready => axil_arready,
      axil_arvalid => axil_arvalid,
      axil_awaddr(5 downto 0) => axil_awaddr(7 downto 2),
      axil_awready => axil_awready,
      axil_awvalid => axil_awvalid,
      axil_bready => axil_bready,
      axil_bvalid => axil_bvalid,
      axil_rdata(31 downto 0) => axil_rdata(31 downto 0),
      axil_rready => axil_rready,
      axil_wdata(31 downto 0) => axil_wdata(31 downto 0),
      axil_wready => axil_wready,
      axil_wvalid => axil_wvalid,
      fifo_aempty_o => fifo_aempty_o,
      fifo_clear_i => fifo_clear_i,
      fifo_clk_i => fifo_clk_i,
      fifo_data_o(23 downto 0) => fifo_data_o(23 downto 0),
      fifo_empty_o => fifo_empty_o,
      fifo_re_i => fifo_re_i,
      fifo_underflow_o => fifo_underflow_o,
      fifo_valid_o => fifo_valid_o,
      reg0_i(31 downto 0) => reg0_i(31 downto 0),
      reg0_o(31 downto 0) => reg0_o(31 downto 0)
    );
end STRUCTURE;
