-- $Id: div_repmult_v1_0_xst.vhd,v 1.1 2010-07-10 21:43:06 mmartinez Exp $
--
--  Copyright(C) 2005 by Xilinx, Inc. All rights reserved.
--  This text/file contains proprietary, confidential
--  information of Xilinx, Inc., is distributed under license
--  from Xilinx, Inc., and may be used, copied and/or
--  disclosed only pursuant to the terms of a valid license
--  agreement with Xilinx, Inc.  Xilinx hereby grants you
--  a license to use this text/file solely for design, simulation,
--  implementation and creation of design files limited
--  to Xilinx devices or technologies. Use with non-Xilinx
--  devices or technologies is expressly prohibited and
--  immediately terminates your license unless covered by
--  a separate agreement.
--
--  Xilinx is providing this design, code, or information
--  "as is" solely for use in developing programs and
--  solutions for Xilinx devices.  By providing this design,
--  code, or information as one possible implementation of
--  this feature, application or standard, Xilinx is making no
--  representation that this implementation is free from any
--  claims of infringement.  You are responsible for
--  obtaining any rights you may require for your implementation.
--  Xilinx expressly disclaims any warranty whatsoever with
--  respect to the adequacy of the implementation, including
--  but not limited to any warranties or representations that this
--  implementation is free from claims of infringement, implied
--  warranties of merchantability or fitness for a particular
--  purpose.
--
--  Xilinx products are not intended for use in life support
--  appliances, devices, or systems. Use in such applications are
--  expressly prohibited.
--
--  This copyright and support notice must be retained as part
--  of this text at all times. (c) Copyright 1995-2005 Xilinx, Inc.
--  All rights reserved.

-------------------------------------------------------------------------------
-- Wrapper for behavioral model
-------------------------------------------------------------------------------
  
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY XilinxCoreLib;
USE XilinxCoreLib.prims_constants_v8_0.ALL;
USE Xilinxcorelib.div_repmult_v1_0_comp.ALL;

-- (A)synchronous multi-input gate
--
--core_if on entity xst
  entity div_repmult_v1_0_xst is
    GENERIC (
      C_FAMILY : string :=  "virtex2";
      C_XDEVICEFAMILY : string :=  "virtex2";
      C_MANTISSA_WIDTH : integer :=  16;
      C_EXPONENT_WIDTH : integer :=  4;
      C_BIAS : integer :=  0;
      C_LATENCY : integer :=  0;
      C_HAS_CE : integer :=  0;
      C_HAS_SCLR : integer :=  0;
      C_SYNC_ENABLE : integer :=  0;
      C_HAS_ACLR : integer :=  0;
      C_ELABORATION_DIR : string :=  "./"
      );
    PORT (
      CLK : in std_logic;
      CE : in std_logic;
      SCLR : in std_logic;
      ACLR : in std_logic;
      DIVISOR_SIGN : in std_logic;
      DIVISOR_EXPONENT : in std_logic_vector(C_EXPONENT_WIDTH-1 downto 0);
      DIVISOR_MANTISSA : in std_logic_vector(C_MANTISSA_WIDTH-1 downto 0);
      DIVIDEND_SIGN : in std_logic;
      DIVIDEND_MANTISSA : in std_logic_vector(C_MANTISSA_WIDTH-1 downto 0);
      DIVIDEND_EXPONENT : in std_logic_vector(C_EXPONENT_WIDTH-1 downto 0);
      UNDERFLOW : out std_logic;
      OVERFLOW : out std_logic;
      QUOTIENT_SIGN : out std_logic;
      QUOTIENT_MANTISSA : out std_logic_vector(C_MANTISSA_WIDTH-1 downto 0);
      QUOTIENT_EXPONENT : out std_logic_vector(C_EXPONENT_WIDTH-1 downto 0)
      );
--core_if off
  end entity div_repmult_v1_0_xst;


ARCHITECTURE behavioral OF div_repmult_v1_0_xst IS

BEGIN

  --core_if on instance i_behv no_coregen_specials
  i_behv : div_repmult_v1_0
    GENERIC MAP(
      C_MANTISSA_WIDTH => C_MANTISSA_WIDTH,
      C_EXPONENT_WIDTH => C_EXPONENT_WIDTH,
      C_BIAS => C_BIAS,
      C_LATENCY => C_LATENCY,
      C_HAS_CE => C_HAS_CE,
      C_HAS_SCLR => C_HAS_SCLR,
      C_SYNC_ENABLE => C_SYNC_ENABLE,
      C_HAS_ACLR => C_HAS_ACLR,
      C_ELABORATION_DIR => C_ELABORATION_DIR
      )
    PORT MAP(
      CLK => CLK,
      CE => CE,
      SCLR => SCLR,
      ACLR => ACLR,
      DIVISOR_SIGN => DIVISOR_SIGN,
      DIVISOR_EXPONENT => DIVISOR_EXPONENT,
      DIVISOR_MANTISSA => DIVISOR_MANTISSA,
      DIVIDEND_SIGN => DIVIDEND_SIGN,
      DIVIDEND_MANTISSA => DIVIDEND_MANTISSA,
      DIVIDEND_EXPONENT => DIVIDEND_EXPONENT,
      UNDERFLOW => UNDERFLOW,
      OVERFLOW => OVERFLOW,
      QUOTIENT_SIGN => QUOTIENT_SIGN,
      QUOTIENT_MANTISSA => QUOTIENT_MANTISSA,
      QUOTIENT_EXPONENT => QUOTIENT_EXPONENT
      );

  --core_if off
  
END behavioral;

