-------------------------------------------------------------------------------
-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
-------------------------------------------------------------------------------
-- This text contains proprietary, confidential
-- information of Xilinx, Inc. , is distributed by
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
-------------------------------------------------------------------------------
-- $Header: /local/Projects/CVS/P1/zpu_SoC/sources/xilinx/XilinxCoreLib/tcc_decoder_3gpp_v3_0_xst_comp.vhd,v 1.1 2010-07-10 21:43:24 mmartinez Exp $
--
-- Description: Component statement for Turbo Convolutional Decoder
--------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--LIBRARY XilinxCoreLib;
--USE XilinxCoreLib.tcc_decoder_3gpp_top_level_pkg_v3_0.ALL;

PACKAGE tcc_decoder_3gpp_v3_0_xst_comp IS

--core_if on component xst
  component tcc_decoder_3gpp_v3_0_xst
    GENERIC (
      c_elaboration_dir : STRING :=  "./";
      c_family : STRING :=  "virtex2";
      c_component_name : STRING :=  "tcc_decoder_3gpp_v3_0";
      c_input_int_bits : INTEGER :=  2;
      c_input_frac_bits : INTEGER :=  3;
      c_metric_int_bits : INTEGER :=  6;
      c_metric_frac_bits : INTEGER :=  3;
      c_output_width : INTEGER :=  1;
      c_has_fast_term : INTEGER :=  0;
      c_has_siso_count : INTEGER :=  0;
      c_has_read_output : INTEGER :=  0;
      c_max_block_size : INTEGER :=  5120;
      c_code_rate : INTEGER :=  3;
      c_mem_unit : INTEGER :=  1;
      c_external_ram : INTEGER :=  0;
      c_algorithm_type : INTEGER :=  0;
      c_has_nd : INTEGER :=  0;
      c_has_ce : INTEGER :=  0;
      c_has_sclr : INTEGER :=  0;
      c_has_aclr : INTEGER :=  0
      );
    PORT (
      block_size : IN STD_LOGIC_VECTOR(13-1 DOWNTO 0);
      clk : IN STD_LOGIC;
      d_in : IN STD_LOGIC_VECTOR(c_code_rate*(c_input_int_bits+c_input_frac_bits)-1 DOWNTO 0);
      fd_in : IN STD_LOGIC;
      iterations : IN STD_LOGIC_VECTOR(4-1 DOWNTO 0);
      ft_thres : IN STD_LOGIC_VECTOR(3-1 DOWNTO 0);
      rd_output : IN STD_LOGIC ;
      aclr : IN STD_LOGIC ;
      ce : IN STD_LOGIC ;
      nd : IN STD_LOGIC ;
      sclr : IN STD_LOGIC;
      d_out : OUT STD_LOGIC_VECTOR(c_output_width-1 DOWNTO 0);
      rdy : OUT STD_LOGIC;
      rfd : OUT STD_LOGIC;
      rffd : OUT STD_LOGIC;
      siso_count : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
      );
--core_if off
END COMPONENT;

END tcc_decoder_3gpp_v3_0_xst_comp;


PACKAGE BODY tcc_decoder_3gpp_v3_0_xst_comp IS


END tcc_decoder_3gpp_v3_0_xst_comp;
