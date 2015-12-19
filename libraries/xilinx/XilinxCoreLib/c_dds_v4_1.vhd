---------------------------------------------------------------------------------------------------
--
-- Title       : dds_v4_1
-- Design      : C_DDS_V4_1
-- Author      : Bob Slous
-- Company     : Xilinx, Inc.
--
---------------------------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\C_DDS_V4_1\compile\c_dds_v4_1.vhd
-- Generated   : Sun Mar  3 20:28:20 2002
-- From        : C:\My_Designs\C_DDS_V4_1\src\c_dds_v4_1.bde
-- By          : Bde2Vhdl ver. 2.01
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------
-- Design unit header --
--$Id: c_dds_v4_1.vhd,v 1.1 2010-07-10 21:42:42 mmartinez Exp $
library IEEE;
use IEEE.std_logic_1164.all;
library XilinxCoreLib;
use XilinxCoreLib.c_sin_cos_v4_1_pack.all;
use XilinxCoreLib.c_sin_cos_v4_1_comp.all;
use XilinxCoreLib.c_addsub_v5_0_comp.all;
use XilinxCoreLib.c_accum_v5_0_comp.all;
use XilinxCoreLib.c_reg_fd_v5_0_comp.all;
use XilinxCoreLib.dither_add_v4_1_comp.all;
use XilinxCoreLib.c_dds_v4_1_pack.all;
use XilinxCoreLib.c_eff_v4_1_comp.all;

-- standard libraries declarations
library XILINXCORELIB;
use XILINXCORELIB.prims_constants_v5_0.all;

entity c_dds_v4_1 is
  generic(
       C_ACCUMULATOR_LATENCY:integer :=ONE_CYCLE; 
       C_ACCUMULATOR_WIDTH:integer            :=16; 
       C_DATA_WIDTH:integer       :=5; 
       C_ENABLE_RLOCS:integer :=0; 
       C_HAS_ACLR:integer :=0; 
       C_HAS_CE:integer :=0; 
       C_HAS_RDY:integer :=1; 
       C_HAS_RFD:integer :=0; 
       C_HAS_SCLR:integer   :=0; 
       C_LATENCY:integer   :=0; 
       C_MEM_TYPE:integer :=DIST_ROM; 
       C_NEGATIVE_COSINE:integer :=0; 
       C_NEGATIVE_SINE:integer     :=0; 
       C_NOISE_SHAPING:integer       :=NONE; 
       C_OUTPUTS_REQUIRED:integer :=SINE_AND_COSINE; 
       C_OUTPUT_WIDTH:integer       :=16; 
       C_PHASE_ANGLE_WIDTH:integer       :=4; 
       C_PHASE_INCREMENT:integer       :=REG; 
       C_PHASE_INCREMENT_VALUE:string         :="0"; 
       C_PHASE_OFFSET:integer  :=NONE; 
       C_PHASE_OFFSET_VALUE:string :="0"; 
       C_PIPELINED:integer       :=1 
  );
  port(
       a : in STD_LOGIC := '0';
       aclr : in STD_LOGIC := '0';
       ce : in STD_LOGIC := '0';
       clk : in STD_LOGIC;
       sclr : in STD_LOGIC := '0';
       we : in STD_LOGIC := '0';
       data : in STD_LOGIC_VECTOR(C_DATA_WIDTH-1 downto 0) := (others=>'0');
       rdy : out STD_LOGIC;
       rfd : out STD_LOGIC;
       cosine : out STD_LOGIC_VECTOR(C_OUTPUT_WIDTH-1 downto 0);
       sine : out STD_LOGIC_VECTOR(C_OUTPUT_WIDTH-1 downto 0)
  );
end c_dds_v4_1;

architecture behavioral of c_dds_v4_1 is

---- Architecture declarations -----
constant sincosLatency : integer := C_LATENCY - (C_PIPELINED *
	(hasDithering(C_NOISE_SHAPING, C_ACCUMULATOR_WIDTH>C_PHASE_ANGLE_WIDTH) + 
	hasOffset(C_PHASE_OFFSET))) - (hasEff(C_NOISE_SHAPING) * 6 );
constant sincosWidth : integer := lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH);
signal aInt : std_logic;


----     Constants     -----
constant VCC_CONSTANT   : STD_LOGIC := '1';

---- Signal declarations used on the diagram ----

signal ditherNd : STD_LOGIC;
signal ditherRdy : STD_LOGIC;
signal pincEnable : STD_LOGIC;
signal poffEnable : STD_LOGIC;
signal rdyLookup : STD_LOGIC;
signal sinCosNd : STD_LOGIC;
signal VCC : STD_LOGIC;
signal cosLookup : STD_LOGIC_VECTOR (sincosWidth-1 downto 0);
signal ditherOut : STD_LOGIC_VECTOR (C_PHASE_ANGLE_WIDTH-1 downto 0);
signal offsetBus : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal offsetQ : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal offsetS : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal phaseAccumBus : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal phaseAccumQ : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal phaseAccumS : STD_LOGIC_VECTOR (C_ACCUMULATOR_WIDTH-1 downto 0);
signal phaseAngleBus : STD_LOGIC_VECTOR (C_PHASE_ANGLE_WIDTH-1 downto 0);
signal phaseIncBus : STD_LOGIC_VECTOR (C_DATA_WIDTH-1 downto 0);
signal phaseOffsetBus : STD_LOGIC_VECTOR (C_DATA_WIDTH-1 downto 0);
signal sinLookup : STD_LOGIC_VECTOR (sincosWidth-1 downto 0);
signal toNdNet : STD_LOGIC_VECTOR (0 downto 0);
signal vccbus : STD_LOGIC_VECTOR (0 downto 0);

---- Configuration specifications for declared components 

for CE_DELAY : C_REG_FD_V5_0 use entity xilinxcorelib.C_REG_FD_V5_0;
for DITHER : dither_add_v4_1 use entity xilinxcorelib.dither_add_v4_1;
for EFF : c_eff_v4_1 use entity xilinxcorelib.c_eff_v4_1;
for OFFSET_ADDER : C_ADDSUB_V5_0 use entity xilinxcorelib.C_ADDSUB_V5_0;
for PHASE_ACCUMULATOR : C_ACCUM_V5_0 use entity xilinxcorelib.C_ACCUM_V5_0;
for PHASE_INCREMENT_REG : C_REG_FD_V5_0 use entity xilinxcorelib.C_REG_FD_V5_0;
for PHASE_OFFSET_REG : C_REG_FD_V5_0 use entity xilinxcorelib.C_REG_FD_V5_0;
for SIN_COS_LOOKUP : C_SIN_COS_V4_1 use entity xilinxcorelib.C_SIN_COS_V4_1;

begin

---- User Signal Assignments ----
gen0: if (C_PHASE_INCREMENT=REG and C_PHASE_OFFSET=REG) generate
		aInt <= a;
	end generate;
gen1: if (not (C_PHASE_INCREMENT=REG) and C_PHASE_OFFSET=REG) generate
		aInt <= '1'; -- offset register selected
	end generate;
gen2: if (C_PHASE_INCREMENT=REG and not (C_PHASE_OFFSET=REG)) generate
		aInt <= '0'; -- increment register selected
	end generate;
gen5 : if  C_NOISE_SHAPING=PHASE_DITHERING and 
	C_ACCUMULATOR_WIDTH>C_PHASE_ANGLE_WIDTH generate
	phaseAngleBus <= ditherOut;
	sinCosNd <= ditherRdy;
end generate;
gen6: if C_NOISE_SHAPING/=PHASE_DITHERING or
	not(C_ACCUMULATOR_WIDTH>C_PHASE_ANGLE_WIDTH) generate
	phaseAngleBus <= offsetBus(C_ACCUMULATOR_WIDTH-1 
	downto  C_ACCUMULATOR_WIDTH-C_PHASE_ANGLE_WIDTH);
	sinCosNd <= ditherNd;
end generate;
gen3: if (C_PHASE_OFFSET/=NONE AND C_PIPELINED=1) generate
		ditherNd <= toNdNet(0); -- nd signal gets delayed
	end generate;
gen4: if not(C_PHASE_OFFSET/=NONE AND C_PIPELINED=1) generate
		ditherNd <= '1';
	end generate;
gen7 : if C_ACCUMULATOR_LATENCY=ZERO_CYCLE generate
	phaseAccumBus <= phaseAccumS;
end generate;
gen8: if C_ACCUMULATOR_LATENCY=ONE_CYCLE generate
	phaseAccumBus <= phaseAccumQ;
end generate;
phaseOffsetEnable: process(aInt, we)
	begin
		poffEnable <= aInt and we;
	end process;
phaseIncEnable: process(aInt, we)
	begin
		pincEnable <= not(aInt) and we;
	end process;
gen9 : if C_PIPELINED=1 and C_PHASE_OFFSET/=NONE generate
	offsetBus <= offsetQ;
end generate;
gen10: if C_PIPELINED=0 and C_PHASE_OFFSET/=NONE generate
	offsetBus <= offsetS;
end generate;
gen11: if C_PHASE_OFFSET=NONE generate
	offsetBus <= phaseAccumBus;
end generate;

----  Component instantiations  ----

CE_DELAY : C_REG_FD_V5_0
  generic map (
       C_ENABLE_RLOCS => C_ENABLE_RLOCS,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_SCLR => C_HAS_SCLR,
       C_WIDTH => 1
  )
  port map(
       ACLR => ACLR,
       CE => CE,
       CLK => CLK,
       D => vccbus( 0 downto 0 ),
       Q => toNdNet( 0 downto 0 ),
       SCLR => SCLR
  );

DITHER : dither_add_v4_1
  generic map (
       ACCUM_WIDTH => C_ACCUMULATOR_WIDTH,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_SCLR => C_HAS_SCLR,
       C_PIPELINED => C_PIPELINED,
       PHASE_WIDTH => C_PHASE_ANGLE_WIDTH
  )
  port map(
       A => offsetBus( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       ACLR => ACLR,
       CE => CE,
       CLK => CLK,
       DITHERED_PHASE => ditherOut( C_PHASE_ANGLE_WIDTH-1 downto 0 ),
       ND => ditherNd,
       RDY => ditherRdy,
       SCLR => SCLR
  );

EFF : C_EFF_V4_1
  generic map (
       C_ACCUM_WIDTH => C_ACCUMULATOR_WIDTH,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_SCLR => C_HAS_SCLR,
       C_INPUT_WIDTH => sincosWidth,
       C_LOOKUP_LATENCY => sinCosLatency,
       C_NOISE_SHAPING => C_NOISE_SHAPING,
       C_OUTPUT_WIDTH => C_OUTPUT_WIDTH,
       C_PHASE_WIDTH => C_PHASE_ANGLE_WIDTH,
       C_PIPELINED => C_PIPELINED
  )
  port map(
       ACCUMULATOR => offsetBus( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       ACLR => ACLR,
       CE => CE,
       CLK => CLK,
       COS => cosine,
       COS_IN => cosLookup( lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH)-1 downto 0 ),
       ND => rdyLookup,
       RDY => rdy,
       SCLR => SCLR,
       SIN => sine,
       SIN_IN => sinLookup( lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH)-1 downto 0 )
  );

OFFSET_ADDER : C_ADDSUB_V5_0
  generic map (
       C_A_WIDTH => C_ACCUMULATOR_WIDTH,
       C_B_CONSTANT => has_const(C_PHASE_OFFSET),
       C_B_VALUE => C_PHASE_OFFSET_VALUE,
       C_B_WIDTH => C_DATA_WIDTH,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_C_IN => 0,
       C_HAS_Q => has_q(C_PIPELINED),
       C_HAS_S => has_s(C_PIPELINED),
       C_HAS_SCLR => C_HAS_SCLR,
       C_HIGH_BIT => C_ACCUMULATOR_WIDTH-1,
       C_LOW_BIT => 0,
       C_OUT_WIDTH => C_ACCUMULATOR_WIDTH,
       C_PIPE_STAGES => 0
  )
  port map(
       A => phaseAccumBus( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       ACLR => ACLR,
       B => phaseOffsetBus( C_DATA_WIDTH-1 downto 0 ),
       CE => CE,
       CLK => CLK,
       Q => offsetQ( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       S => offsetS( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       SCLR => SCLR
  );

PHASE_ACCUMULATOR : C_ACCUM_V5_0
  generic map (
       C_B_CONSTANT => has_const(C_PHASE_INCREMENT),
       C_B_VALUE => C_PHASE_INCREMENT_VALUE,
       C_B_WIDTH => C_DATA_WIDTH,
       C_ENABLE_RLOCS => C_ENABLE_RLOCS,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_S => has_s(C_ACCUMULATOR_LATENCY),
       C_HAS_SCLR => C_HAS_SCLR,
       C_HIGH_BIT => C_ACCUMULATOR_WIDTH-1,
       C_LOW_BIT => 0,
       C_OUT_WIDTH => C_ACCUMULATOR_WIDTH,
       C_PIPE_STAGES => 0
  )
  port map(
       ACLR => ACLR,
       B => phaseIncBus( C_DATA_WIDTH-1 downto 0 ),
       CE => CE,
       CLK => CLK,
       Q => phaseAccumQ( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       S => phaseAccumS( C_ACCUMULATOR_WIDTH-1 downto 0 ),
       SCLR => SCLR
  );

PHASE_INCREMENT_REG : C_REG_FD_V5_0
  generic map (
       C_ENABLE_RLOCS => C_ENABLE_RLOCS,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => 1,
       C_HAS_SCLR => C_HAS_SCLR,
       C_WIDTH => C_DATA_WIDTH
  )
  port map(
       ACLR => ACLR,
       CE => pincEnable,
       CLK => CLK,
       D => data( C_DATA_WIDTH-1 downto 0 ),
       Q => phaseIncBus( C_DATA_WIDTH-1 downto 0 ),
       SCLR => SCLR
  );

PHASE_OFFSET_REG : C_REG_FD_V5_0
  generic map (
       C_ENABLE_RLOCS => C_ENABLE_RLOCS,
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => 1,
       C_HAS_SCLR => C_HAS_SCLR,
       C_WIDTH => C_DATA_WIDTH
  )
  port map(
       ACLR => ACLR,
       CE => poffEnable,
       CLK => CLK,
       D => data( C_DATA_WIDTH-1 downto 0 ),
       Q => phaseOffsetBus( C_DATA_WIDTH-1 downto 0 ),
       SCLR => SCLR
  );

SIN_COS_LOOKUP : C_SIN_COS_V4_1
  generic map (
       C_HAS_ACLR => C_HAS_ACLR,
       C_HAS_CE => C_HAS_CE,
       C_HAS_ND => 1,
       C_HAS_RDY => hasSinCosRdy(C_HAS_RDY, C_NOISE_SHAPING),
       C_HAS_RFD => C_HAS_RFD,
       C_HAS_SCLR => C_HAS_SCLR,
       C_LATENCY => sincosLatency,
       C_MEM_TYPE => C_MEM_TYPE,
       C_NEGATIVE_COSINE => C_NEGATIVE_COSINE,
       C_NEGATIVE_SINE => C_NEGATIVE_SINE,
       C_OUTPUTS_REQUIRED => C_OUTPUTS_REQUIRED,
       C_OUTPUT_WIDTH => lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH),
       C_REG_INPUT => 0,
       C_REG_OUTPUT => C_PIPELINED,
       C_THETA_WIDTH => C_PHASE_ANGLE_WIDTH
  )
  port map(
       aclr => aclr,
       ce => ce,
       clk => clk,
       cosine => cosLookup( lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH)-1 downto 0 ),
       nd => sinCosNd,
       rdy => rdyLookup,
       rfd => rfd,
       sclr => sclr,
       sine => sinLookup( lookupOutputWidth(C_NOISE_SHAPING, C_OUTPUT_WIDTH)-1 downto 0 ),
       theta => phaseAngleBus( C_PHASE_ANGLE_WIDTH-1 downto 0 )
  );


---- Power , ground assignment ----

VCC <= VCC_CONSTANT;
vccbus(0) <= VCC;

end behavioral;
