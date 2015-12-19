-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/simprim/VITAL/Attic/x_obuft.vhd,v 1.5 2007/07/02 22:41:57 fphillip Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 10.1i
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  3-State Output Buffer
-- /___/   /\     Filename : X_OBUFT.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:57:20 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.
--    05/09/05 - #207243 -- Added PATHPULSE. 
--    07/02/07 - CR 441959
-- End Revision
----- CELL X_OBUFT -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.Vital_Primitives.all;
use IEEE.Vital_Timing.all;

library simprim;
use simprim.Vcomponents.all;
use simprim.VPACKAGE.all;

entity X_OBUFT is
  generic(
      Xon   : boolean := true;
      MsgOn : boolean := true;

      CAPACITANCE : string  := "DONT_CARE";
      DRIVE       : integer := 12;
      IOSTANDARD  : string  := "DEFAULT";
      LOC         : string  := "UNPLACED";
      SLEW        : string  := "SLOW";

      tipd_CTL : VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_I : VitalDelayType01 := (0.000 ns, 0.000 ns);

      tpd_CTL_O : VitalDelayType01z := (0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns);
      tpd_GTS_O : VitalDelayType01z := (0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns, 0.000 ns);
      tpd_I_O : VitalDelayType01 := (0.000 ns, 0.000 ns);

      PATHPULSE : time := 0 ps            
    );

  port(
    O   : out std_ulogic;
    CTL : in  std_ulogic;
    I   : in  std_ulogic
    );

  attribute VITAL_LEVEL0 of
    X_OBUFT : entity is true;
end X_OBUFT;

architecture X_OBUFT_V of X_OBUFT is
--  attribute VITAL_LEVEL1 of
  attribute VITAL_LEVEL0 of
    X_OBUFT_V : architecture is true;

  signal CTL_ipd : std_ulogic := 'X';
  signal GTS_resolved : std_ulogic := 'X';
  signal I_ipd   : std_ulogic := 'X';
begin

  GTS_resolved <= TO_X01(GTS);

  WireDelay      : block
  begin
    VitalWireDelay (CTL_ipd, CTL, tipd_CTL);
    VitalWireDelay (I_ipd, I, tipd_I);
  end block;

  VITALBehavior           : process (CTL_ipd, GTS_resolved, I_ipd)
    variable O_zd         : std_ulogic;
    variable O_GlitchData : VitalGlitchDataType;
    variable I_GlitchData : SimprimGlitchDataType;
    variable O_prev       : std_ulogic;
    variable InputGlitch  : boolean := false;
    variable I_ipd_reg    : std_ulogic;
    variable FIRST_TRANSITION_AFTER_ENABLE_ACTIVE : boolean := false;        
  begin

    I_ipd_reg    := TO_X01(I_ipd);
    if ((falling_edge(CTL_ipd) or falling_edge(GTS_resolved)) and ((CTL_ipd = '0') and (GTS_resolved = '0'))) then
      FIRST_TRANSITION_AFTER_ENABLE_ACTIVE                  := true;
    end if;
      
    if ((CTL_ipd = '0') and (GTS_resolved = '0')) then
      if (FIRST_TRANSITION_AFTER_ENABLE_ACTIVE = true) then
        FIRST_TRANSITION_AFTER_ENABLE_ACTIVE := false;
      else
        if ((tpd_I_O(tr01) < PATHPULSE) or (tpd_I_O(tr10) < PATHPULSE)) then
        else
          SimprimGlitch
            (
            GlitchOccured => InputGlitch,
            OutSignal     => O,
            GlitchData    => I_GlitchData,
            InSignalName  => "I",
            NewValue      => I_ipd_reg,
            PrevValue     => O_Prev,
            PathpulseTime => PATHPULSE,
            MsgOn         => false,
            MsgSeverity   => warning
            );
        end if;
      end if;
    end if;        
    if (InputGlitch = false) then
      O_prev := TO_X01(O_zd);
    end if;

    
    O_zd := VitalBUFIF0 (data => I_ipd, enable => (CTL_ipd or GTS_resolved));

    VitalPathDelay01Z (
      OutSignal     => O,
      GlitchData    => O_GlitchData,
      OutSignalName => "O",
      OutTemp       => O_zd,
      Paths         => (0 => (CTL_ipd'last_event, VitalExtendToFillDelay(tpd_CTL_O), (GTS_resolved = '0')),
                        1   => (I_ipd'last_event, VitalExtendToFillDelay(tpd_I_O), ((GTS_resolved = '0') and (CTL_ipd = '0'))),
                        2   => (GTS_resolved'last_event, tpd_GTS_O, true)),
      Mode          => VitalTransport,
      Xon           => Xon,
      MsgOn         => MsgOn,
      MsgSeverity   => warning,
      OutputMap     => "UX01ZWLH-");

    if (InputGlitch = true) then
      InputGlitch := false;
    end if;            
  end process;
end X_OBUFT_V;
