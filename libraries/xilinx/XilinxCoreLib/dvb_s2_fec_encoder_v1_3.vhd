--------------------------------------------------------------------------------

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
--------------------------------------------------------------------------------
--
-- $RCSfile: dvb_s2_fec_encoder_v1_3.vhd,v $
--
--------------------------------------------------------------------------------
--
-- Top level dummy model for ROMS.
--

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;


ENTITY dvb_s2_fec_encoder_v1_3  IS
   GENERIC (   
      c_width              : INTEGER := 4; -- this can currently be 1,2,or 4
      c_has_ce             : INTEGER := 0;
      c_has_sclr           : INTEGER := 0;
      c_elaboration_dir    : STRING  := "./";
      c_elaboration_transient_dir    : STRING  := "./";
      c_mem_init_prefix    : STRING  := "intlv1";
      c_family             : STRING  := "virtex2"
   );
   PORT (
      din            : IN STD_LOGIC_VECTOR(c_width-1 DOWNTO 0):= (OTHERS => '0');
      rate           : IN STD_LOGIC_VECTOR(16-1 DOWNTO 0) := (OTHERS => '0'); 
      nd             : IN STD_LOGIC := '0';
      fd_in          : IN STD_LOGIC := '0';
      cts            : IN STD_LOGIC := '1';
      
      -- output
      dout           : OUT STD_LOGIC_VECTOR(c_width-1 DOWNTO 0);
      fd_out         : OUT STD_LOGIC;
      rate_out       : OUT STD_LOGIC_VECTOR(16-1 DOWNTO 0); 
      
      rffd           : OUT STD_LOGIC;
      rfd            : OUT STD_LOGIC;
      rdy            : OUT STD_LOGIC;

      -- optional pins
      ce             : IN STD_LOGIC := '0';
      sclr           : IN STD_LOGIC := '0';
      clk            : IN STD_LOGIC 
      );


END dvb_s2_fec_encoder_v1_3;

ARCHITECTURE behavioral OF dvb_s2_fec_encoder_v1_3 IS

BEGIN
   
---------------------------------------------------------------
END behavioral;
          
