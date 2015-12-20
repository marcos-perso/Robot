-------------------------------------------------------------------------------
--  File name : s29gl032n.vhd
-------------------------------------------------------------------------------
--  Copyright (C) 2007. Spansion, LLC.
--
--  MODIFICATION HISTORY :
--
--  version: |    author:       |  mod date:  | changes made:
--   V1.0       I.Milutinovic     07 Mar 07     Initial release
--
-------------------------------------------------------------------------------
--  PART DESCRIPTION:
--
--  Library:        FLASH
--  Technology:     Flash Memory
--  Part:           S29GL032N
--
--  Description:  32 Megabit (x8/x16) Page Mode Flash Memory
--
-------------------------------------------------------------------------------
--  Comments :
--      When testing with NCSim 05.82-p002 default value for TimingModel in
--      generic list should be removed, otherwise backannotation of this value
--      will not be done properly
-------------------------------------------------------------------------------
--  Known Bugs:
--
-------------------------------------------------------------------------------
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.VITAL_timing.ALL;
    USE IEEE.VITAL_primitives.ALL;
    USE STD.textio.ALL;

LIBRARY FMF;
    USE FMF.gen_utils.all;
    USE FMF.conversions.all;

library work;
use work.stringfkt.all;

-------------------------------------------------------------------------------
-- ENTITY DECLARATION
-------------------------------------------------------------------------------
ENTITY s29gl032n IS
    GENERIC (
        -- tipd delays: interconnect path delays
        tipd_A0             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A1             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A2             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A3             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A4             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A5             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A6             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A7             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A8             : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A9             : VitalDelayType01 := VitalZeroDelay01; --address
        tipd_A10            : VitalDelayType01 := VitalZeroDelay01; --lines
        tipd_A11            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A12            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A13            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A14            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A15            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A16            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A17            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A18            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A19            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_A20            : VitalDelayType01 := VitalZeroDelay01; --

        tipd_DQ0            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ1            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ2            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ3            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ4            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ5            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ6            : VitalDelayType01 := VitalZeroDelay01; -- data
        tipd_DQ7            : VitalDelayType01 := VitalZeroDelay01; -- lines
        tipd_DQ8            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ9            : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ10           : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ11           : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ12           : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ13           : VitalDelayType01 := VitalZeroDelay01; --
        tipd_DQ14           : VitalDelayType01 := VitalZeroDelay01; --

        tipd_DQ15           : VitalDelayType01 := VitalZeroDelay01; -- DQ15/A-1

        tipd_CENeg          : VitalDelayType01 := VitalZeroDelay01;
        tipd_OENeg          : VitalDelayType01 := VitalZeroDelay01;
        tipd_WENeg          : VitalDelayType01 := VitalZeroDelay01;
        tipd_RESETNeg       : VitalDelayType01 := VitalZeroDelay01;
        tipd_WPNeg          : VitalDelayType01 := VitalZeroDelay01; --WP#/ACC
        tipd_BYTENeg        : VitalDelayType01 := VitalZeroDelay01;

        -- tpd delays
        --tpd_A0_DQ0          : VitalDelayType01 := UnitDelay01;--tACC
        --tpd_A0_DQ1          : VitalDelayType01 := UnitDelay01;--tPACC
        tpd_A0_DQ0          : VitalDelayType01 := (90 ns, 90 ns);--tACC
        tpd_A0_DQ1          : VitalDelayType01 := (90 ns, 90 ns);--tPACC
        tpd_CENeg_DQ0       : VitalDelayType01Z := UnitDelay01Z;
        --(tCE,tCE,tDF,-,tDF,-)
        --tpd_OENeg_DQ0       : VitalDelayType01Z := UnitDelay01Z;
        tpd_OENeg_DQ0       : VitalDelayType01Z := (25 ns, 25 ns, 25 ns, 25 ns, 25 ns, 25 ns);
        --(tOE,tOE,tDF,-,tDF,-)
        tpd_RESETNeg_DQ0    : VitalDelayType01Z := UnitDelay01Z;
        --(-,-,0,-,0,-)
        tpd_CENeg_RY        : VitalDelayType01 := UnitDelay01; --tBUSY
        tpd_WENeg_RY        : VitalDelayType01 := UnitDelay01; --tBUSY

        --tsetup values
        tsetup_A0_CENeg     : VitalDelayType := UnitDelay;  --tAS edge \
        --tsetup_A0_OENeg     : VitalDelayType := UnitDelay;  --tASO edge \
        tsetup_A0_OENeg     : VitalDelayType := 15 ns;  --tASO edge \
        --tsetup_DQ0_CENeg    : VitalDelayType := UnitDelay;  --tDS edge /
        tsetup_DQ0_CENeg    : VitalDelayType := 35 ns;  --tDS edge /

        --thold values
        thold_CENeg_RESETNeg: VitalDelayType := UnitDelay;   --tRH  edge /
        thold_OENeg_WENeg   : VitalDelayType := UnitDelay;   --tOEH edge /
        thold_A0_CENeg      : VitalDelayType := UnitDelay;   --tAH  edge \
        thold_A0_OENeg      : VitalDelayType := UnitDelay;   --tAHT edge \
        thold_DQ0_CENeg     : VitalDelayType := UnitDelay;   --tDH edge /
        thold_WENeg_OENeg   : VitalDelayType := UnitDelay;   --tGHWL edge /

        --tpw values: pulse width
        tpw_RESETNeg_negedge: VitalDelayType := UnitDelay; --tRP
        tpw_OENeg_posedge   : VitalDelayType := UnitDelay; --tOEPH
        tpw_WENeg_negedge   : VitalDelayType := UnitDelay; --tWP
        tpw_WENeg_posedge   : VitalDelayType := UnitDelay; --tWPH
        tpw_CENeg_negedge   : VitalDelayType := UnitDelay; --tCP
        tpw_CENeg_RY_EQ_1_posedge : VitalDelayType := UnitDelay; --tCPH
        tpw_A0_negedge      : VitalDelayType := UnitDelay; --tWC tRC
        tpw_CENeg_RY_EQ_0_posedge : VitalDelayType := UnitDelay; --tCEPH

        -- tdevice values: values for internal delays
            --Effective Write Buffer Program Operation  tWHWH1
        tdevice_WBPB        : VitalDelayType    := 7.5 us;-- 15 us per word
            --Program Operation
        tdevice_POW         : VitalDelayType    := 60 us;-- per word
            --Sector Erase Operation    tWHWH2
        tdevice_SEO         : VitalDelayType    := 500 ms;
            --Timing Limit Exceeded
        tdevice_HANG        : VitalDelayType    := 400 ms;
            --program/erase suspend timeout
        tdevice_START_T1    : VitalDelayType    := 5 us;
            --sector erase command sequence timeout
        tdevice_CTMOUT      : VitalDelayType    := 50 us;
            --device ready after Hardware reset(during embeded algorithm)
        tdevice_READY       : VitalDelayType    := 20 us;
        -- Password Unlock
        tdevice_UNLOCK      : VitalDelayType    := 2 us;
        -- configuring the PPB Lock bit to the freeze state
        tdevice_PPBLOCK     : VitalDelayType    := 100 ns;
        -- generic control parameters
        InstancePath        : STRING    := DefaultInstancePath;
        TimingChecksOn      : BOOLEAN   := DefaultTimingChecks;
        MsgOn               : BOOLEAN   := DefaultMsgOn;
        XOn                 : BOOLEAN   := DefaultXon;
        -- memory file to be loaded
        mem_file_name       : STRING    := "none1";--"s29gl032n.mem";
        prot_file_name      : STRING    := "none2";--"s29gl032n_prot.mem";
        secsi_file_name     : STRING    := "none3";--"s29gl032n_secsi.mem";

        UserPreload         : BOOLEAN   := FALSE;
        LongTimming         : BOOLEAN   := TRUE;

        -- For FMF SDF technology file usage
        TimingModel         : STRING    := DefaultTimingModel
    );
    PORT (
        A20             : IN    std_ulogic := 'U'; --
        A19             : IN    std_ulogic := 'U'; --
        A18             : IN    std_ulogic := 'U'; --
        A17             : IN    std_ulogic := 'U'; --
        A16             : IN    std_ulogic := 'U'; --
        A15             : IN    std_ulogic := 'U'; --
        A14             : IN    std_ulogic := 'U'; --
        A13             : IN    std_ulogic := 'U'; --address
        A12             : IN    std_ulogic := 'U'; --lines
        A11             : IN    std_ulogic := 'U'; --
        A10             : IN    std_ulogic := 'U'; --
        A9              : IN    std_ulogic := 'U'; --
        A8              : IN    std_ulogic := 'U'; --
        A7              : IN    std_ulogic := 'U'; --
        A6              : IN    std_ulogic := 'U'; --
        A5              : IN    std_ulogic := 'U'; --
        A4              : IN    std_ulogic := 'U'; --
        A3              : IN    std_ulogic := 'U'; --
        A2              : IN    std_ulogic := 'U'; --
        A1              : IN    std_ulogic := 'U'; --
        A0              : IN    std_ulogic := 'U'; --

        DQ15            : INOUT std_ulogic := 'U'; -- DQ15/A-1
        DQ14            : INOUT std_ulogic := 'U'; --
        DQ13            : INOUT std_ulogic := 'U'; --
        DQ12            : INOUT std_ulogic := 'U'; --
        DQ11            : INOUT std_ulogic := 'U'; --
        DQ10            : INOUT std_ulogic := 'U'; --
        DQ9             : INOUT std_ulogic := 'U'; -- data
        DQ8             : INOUT std_ulogic := 'U'; -- lines
        DQ7             : INOUT std_ulogic := 'U'; --
        DQ6             : INOUT std_ulogic := 'U'; --
        DQ5             : INOUT std_ulogic := 'U'; --
        DQ4             : INOUT std_ulogic := 'U'; --
        DQ3             : INOUT std_ulogic := 'U'; --
        DQ2             : INOUT std_ulogic := 'U'; --
        DQ1             : INOUT std_ulogic := 'U'; --
        DQ0             : INOUT std_ulogic := 'U'; --

        CENeg           : IN    std_ulogic := 'U';
        OENeg           : IN    std_ulogic := 'U';
        WENeg           : IN    std_ulogic := 'U';
        RESETNeg        : IN    std_ulogic := 'U';
        WPNeg           : IN    std_ulogic := 'U'; --WP#/ACC
        BYTENeg         : IN    std_ulogic := 'U';
        RY              : OUT   std_ulogic := 'U'  --RY/BY#
    );
    ATTRIBUTE VITAL_LEVEL0 of s29gl032n : ENTITY IS TRUE;
END s29gl032n;

-------------------------------------------------------------------------------
-- ARCHITECTURE DECLARATION
-------------------------------------------------------------------------------
ARCHITECTURE vhdl_behavioral of s29gl032n IS
    ATTRIBUTE VITAL_LEVEL0 of vhdl_behavioral : ARCHITECTURE IS TRUE;

    CONSTANT PartID        : STRING  := "S29GL032N";
    CONSTANT MaxData       : NATURAL := 16#FF#;
    CONSTANT SecSize       : NATURAL := 16#FFFF#;-- 64 Kbyte
    CONSTANT SecNum        : NATURAL := 70;
    CONSTANT SecSiSize     : NATURAL := 255;
    CONSTANT HiAddrBit     : NATURAL := 20;
    CONSTANT AddrRANGE     : NATURAL := 16#3FFFFF#;

    -- interconnect path delay signals
    SIGNAL A20_ipd         : std_ulogic := 'U';
    SIGNAL A19_ipd         : std_ulogic := 'U';
    SIGNAL A18_ipd         : std_ulogic := 'U';
    SIGNAL A17_ipd         : std_ulogic := 'U';
    SIGNAL A16_ipd         : std_ulogic := 'U';
    SIGNAL A15_ipd         : std_ulogic := 'U';
    SIGNAL A14_ipd         : std_ulogic := 'U';
    SIGNAL A13_ipd         : std_ulogic := 'U';
    SIGNAL A12_ipd         : std_ulogic := 'U';
    SIGNAL A11_ipd         : std_ulogic := 'U';
    SIGNAL A10_ipd         : std_ulogic := 'U';
    SIGNAL A9_ipd          : std_ulogic := 'U';
    SIGNAL A8_ipd          : std_ulogic := 'U';
    SIGNAL A7_ipd          : std_ulogic := 'U';
    SIGNAL A6_ipd          : std_ulogic := 'U';
    SIGNAL A5_ipd          : std_ulogic := 'U';
    SIGNAL A4_ipd          : std_ulogic := 'U';
    SIGNAL A3_ipd          : std_ulogic := 'U';
    SIGNAL A2_ipd          : std_ulogic := 'U';
    SIGNAL A1_ipd          : std_ulogic := 'U';
    SIGNAL A0_ipd          : std_ulogic := 'U';

    SIGNAL DQ15_ipd        : std_ulogic := 'U';
    SIGNAL DQ14_ipd        : std_ulogic := 'U';
    SIGNAL DQ13_ipd        : std_ulogic := 'U';
    SIGNAL DQ12_ipd        : std_ulogic := 'U';
    SIGNAL DQ11_ipd        : std_ulogic := 'U';
    SIGNAL DQ10_ipd        : std_ulogic := 'U';
    SIGNAL DQ9_ipd         : std_ulogic := 'U';
    SIGNAL DQ8_ipd         : std_ulogic := 'U';
    SIGNAL DQ7_ipd         : std_ulogic := 'U';
    SIGNAL DQ6_ipd         : std_ulogic := 'U';
    SIGNAL DQ5_ipd         : std_ulogic := 'U';
    SIGNAL DQ4_ipd         : std_ulogic := 'U';
    SIGNAL DQ3_ipd         : std_ulogic := 'U';
    SIGNAL DQ2_ipd         : std_ulogic := 'U';
    SIGNAL DQ1_ipd         : std_ulogic := 'U';
    SIGNAL DQ0_ipd         : std_ulogic := 'U';

    SIGNAL CENeg_ipd       : std_ulogic := 'U';
    SIGNAL OENeg_ipd       : std_ulogic := 'U';
    SIGNAL WENeg_ipd       : std_ulogic := 'U';
    SIGNAL RESETNeg_ipd    : std_ulogic := 'U';
    SIGNAL WPNeg_ipd       : std_ulogic := 'U';
    SIGNAL BYTENeg_ipd     : std_ulogic := 'U';

    ---  internal delays
    SIGNAL WBPO_in         : std_ulogic := '0';
    SIGNAL WBPO_out        : std_ulogic := '0';
    SIGNAL PO_in           : std_ulogic := '0';
    SIGNAL PO_out          : std_ulogic := '0';
    SIGNAL SEO_in          : std_ulogic := '0';
    SIGNAL SEO_out         : std_ulogic := '0';

    SIGNAL HANG_out        : std_ulogic := '0'; --Program/Erase Timing Limit
    SIGNAL HANG_in         : std_ulogic := '0';
    SIGNAL sSTART_T1       : std_ulogic := '0'; --Program/Erase Start TimeOut
    SIGNAL START_T1_in     : std_ulogic := '0';
    SIGNAL sCTMOUT         : std_ulogic := '0'; --Sector Erase sequence TimeOut
    SIGNAL CTMOUT_in       : std_ulogic := '0';
    SIGNAL READY_in        : std_ulogic := '0';
    SIGNAL sREADY          : std_ulogic := '0'; -- Device ready after reset
    SIGNAL sSTART_T1t      : std_ulogic := '0'; --Program/Erase Start TimeOut
    SIGNAL START_T1_int    : std_ulogic := '0';
    SIGNAL sCTMOUTt        : std_ulogic := '0'; --Sector Erase sequence TimeOut
    SIGNAL CTMOUT_int      : std_ulogic := '0';
    SIGNAL READY_int       : std_ulogic := '0';
    SIGNAL sREADYt         : std_ulogic := '0'; -- Device ready after reset

    SIGNAL UNLOCKDONE_in   : std_ulogic := '0';
    SIGNAL UNLOCKDONE_out  : std_ulogic := '0';

    SIGNAL PBPROG_in       : std_ulogic := '0';
    SIGNAL PBPROG_out      : std_ulogic := '0';

    -- Annotate
    SIGNAL P1_in       : std_ulogic := '0';
    SIGNAL P1_out      : std_ulogic := '0';
    SIGNAL P2_in       : std_ulogic := '0';
    SIGNAL P2_out      : std_ulogic := '0';

BEGIN

    ---------------------------------------------------------------------------
    -- Internal Delays
    ---------------------------------------------------------------------------
    -- Artificial VITAL primitives to incorporate internal delays
    WBPB     :VitalBuf(WBPO_out,WBPO_in,     (tdevice_WBPB    ,UnitDelay));
    POW      :VitalBuf(PO_out,  PO_in,       (tdevice_POW     ,UnitDelay));
    SEO      :VitalBuf(SEO_out, SEO_in,      (tdevice_SEO     ,UnitDelay));
    HANG     :VitalBuf(HANG_out,HANG_in,     (tdevice_HANG    ,UnitDelay));
    START_T1 :VitalBuf(sSTART_T1t,START_T1_int,(tdevice_START_T1,UnitDelay));
    CTMOUT   :VitalBuf(sCTMOUTt,CTMOUT_int, (tdevice_CTMOUT - 1 ns ,UnitDelay));
    READY    :VitalBuf(sREADYt,  READY_int,  (tdevice_READY   ,UnitDelay));
    UNLOCK   :VitalBuf(P1_out,P1_in,         (tdevice_UNLOCK   ,UnitDelay));
    PPBLOCK  :VitalBuf(P2_out,P2_in,         (tdevice_PPBLOCK  ,UnitDelay));
    ---------------------------------------------------------------------------
    -- Wire Delays
    ---------------------------------------------------------------------------
    WireDelay : BLOCK
    BEGIN
        w_1  : VitalWireDelay (A20_ipd, A20, tipd_A20);
        w_2  : VitalWireDelay (A19_ipd, A19, tipd_A19);
        w_3  : VitalWireDelay (A18_ipd, A18, tipd_A18);
        w_4  : VitalWireDelay (A17_ipd, A17, tipd_A17);
        w_5  : VitalWireDelay (A16_ipd, A16, tipd_A16);
        w_6  : VitalWireDelay (A15_ipd, A15, tipd_A15);
        w_7  : VitalWireDelay (A14_ipd, A14, tipd_A14);
        w_8  : VitalWireDelay (A13_ipd, A13, tipd_A13);
        w_9  : VitalWireDelay (A12_ipd, A12, tipd_A12);
        w_10 : VitalWireDelay (A11_ipd, A11, tipd_A11);
        w_11 : VitalWireDelay (A10_ipd, A10, tipd_A10);
        w_12 : VitalWireDelay (A9_ipd, A9, tipd_A9);
        w_13 : VitalWireDelay (A8_ipd, A8, tipd_A8);
        w_14 : VitalWireDelay (A7_ipd, A7, tipd_A7);
        w_15 : VitalWireDelay (A6_ipd, A6, tipd_A6);
        w_16 : VitalWireDelay (A5_ipd, A5, tipd_A5);
        w_17 : VitalWireDelay (A4_ipd, A4, tipd_A4);
        w_18 : VitalWireDelay (A3_ipd, A3, tipd_A3);
        w_19 : VitalWireDelay (A2_ipd, A2, tipd_A2);
        w_20 : VitalWireDelay (A1_ipd, A1, tipd_A1);
        w_21 : VitalWireDelay (A0_ipd, A0, tipd_A0);

        w_22 : VitalWireDelay (DQ15_ipd, DQ15, tipd_DQ15);
        w_23 : VitalWireDelay (DQ14_ipd, DQ14, tipd_DQ14);
        w_24 : VitalWireDelay (DQ13_ipd, DQ13, tipd_DQ13);
        w_25 : VitalWireDelay (DQ12_ipd, DQ12, tipd_DQ12);
        w_26 : VitalWireDelay (DQ11_ipd, DQ11, tipd_DQ11);
        w_27 : VitalWireDelay (DQ10_ipd, DQ10, tipd_DQ10);
        w_28 : VitalWireDelay (DQ9_ipd, DQ9, tipd_DQ9);
        w_29 : VitalWireDelay (DQ8_ipd, DQ8, tipd_DQ8);
        w_30 : VitalWireDelay (DQ7_ipd, DQ7, tipd_DQ7);
        w_31 : VitalWireDelay (DQ6_ipd, DQ6, tipd_DQ6);
        w_32 : VitalWireDelay (DQ5_ipd, DQ5, tipd_DQ5);
        w_33 : VitalWireDelay (DQ4_ipd, DQ4, tipd_DQ4);
        w_34 : VitalWireDelay (DQ3_ipd, DQ3, tipd_DQ3);
        w_35 : VitalWireDelay (DQ2_ipd, DQ2, tipd_DQ2);
        w_36 : VitalWireDelay (DQ1_ipd, DQ1, tipd_DQ1);
        w_37 : VitalWireDelay (DQ0_ipd, DQ0, tipd_DQ0);

        w_38 : VitalWireDelay (OENeg_ipd, OENeg, tipd_OENeg);
        w_39 : VitalWireDelay (WENeg_ipd, WENeg, tipd_WENeg);
        w_40 : VitalWireDelay (RESETNeg_ipd, RESETNeg, tipd_RESETNeg);
        w_41 : VitalWireDelay (WPNeg_ipd, WPNeg, tipd_WPNeg);
        w_42 : VitalWireDelay (CENeg_ipd, CENeg, tipd_CENeg);
        w_43 : VitalWireDelay (BYTENeg_ipd, BYTENeg, tipd_BYTENeg);

    END BLOCK;

    ---------------------------------------------------------------------------
    -- Main Behavior Block
    ---------------------------------------------------------------------------
    Behavior: BLOCK

        PORT (
            A              : IN    std_logic_vector(HiAddrBit downto 0) :=
                                               (OTHERS => 'U');
            DIn            : IN    std_logic_vector(15 downto 0) :=
                                               (OTHERS => 'U');
            DOut           : OUT   std_ulogic_vector(15 downto 0) :=
                                               (OTHERS => 'Z');
            CENeg          : IN    std_ulogic := 'U';
            OENeg          : IN    std_ulogic := 'U';
            WENeg          : IN    std_ulogic := 'U';
            RESETNeg       : IN    std_ulogic := 'U';
            WPNeg          : IN    std_ulogic := 'U';
            BYTENeg        : IN    std_ulogic := 'U';
            RY             : OUT   std_ulogic := 'U'
        );
        PORT MAP (
             A(20)    => A20_ipd,
             A(19)    => A19_ipd,
             A(18)    => A18_ipd,
             A(17)    => A17_ipd,
             A(16)    => A16_ipd,
             A(15)    => A15_ipd,
             A(14)    => A14_ipd,
             A(13)    => A13_ipd,
             A(12)    => A12_ipd,
             A(11)    => A11_ipd,
             A(10)    => A10_ipd,
             A(9)     => A9_ipd,
             A(8)     => A8_ipd,
             A(7)     => A7_ipd,
             A(6)     => A6_ipd,
             A(5)     => A5_ipd,
             A(4)     => A4_ipd,
             A(3)     => A3_ipd,
             A(2)     => A2_ipd,
             A(1)     => A1_ipd,
             A(0)     => A0_ipd,

             DIn(15)  => DQ15_ipd,
             DIn(14)  => DQ14_ipd,
             DIn(13)  => DQ13_ipd,
             DIn(12)  => DQ12_ipd,
             DIn(11)  => DQ11_ipd,
             DIn(10)  => DQ10_ipd,
             DIn(9)   => DQ9_ipd,
             DIn(8)   => DQ8_ipd,
             DIn(7)   => DQ7_ipd,
             DIn(6)   => DQ6_ipd,
             DIn(5)   => DQ5_ipd,
             DIn(4)   => DQ4_ipd,
             DIn(3)   => DQ3_ipd,
             DIn(2)   => DQ2_ipd,
             DIn(1)   => DQ1_ipd,
             DIn(0)   => DQ0_ipd,

             DOut(15) => DQ15,
             DOut(14) => DQ14,
             DOut(13) => DQ13,
             DOut(12) => DQ12,
             DOut(11) => DQ11,
             DOut(10) => DQ10,
             DOut(9)  => DQ9,
             DOut(8)  => DQ8,
             DOut(7)  => DQ7,
             DOut(6)  => DQ6,
             DOut(5)  => DQ5,
             DOut(4)  => DQ4,
             DOut(3)  => DQ3,
             DOut(2)  => DQ2,
             DOut(1)  => DQ1,
             DOut(0)  => DQ0,

             CENeg    => CENeg_ipd,
             OENeg    => OENeg_ipd,
             WENeg    => WENeg_ipd,
             RESETNeg => RESETNeg_ipd,
             WPNeg    => WPNeg_ipd,
             BYTENeg  => BYTENeg_ipd,

             RY       => RY
        );

        -- State Machine : State_Type
        TYPE state_type IS (
                            RESET,
                            Z001,
                            PREL_SETBWB,
                            PREL_ULBYPASS,
                            EXIT_ULBYPASS,
                            CFI,
                            AS,
                            LOCKREG_CMDSET,
                            LOCKREG_A0SEEN,
                            EXIT_LOCKREG,
                            PPB_CMDSET,
                            PPB_A0SEEN,
                            PPB_80SEEN,
                            EXIT_PPB,
                            DYB_CMDSET,
                            DYB_SETCLEAR,
                            EXIT_DYB,
                            PASS_CMDSET,
                            PASS_A0SEEN,
                            PASSUNLOCK1,
                            PASSUNLOCK2,
                            PASSUNLOCK3,
                            PASSUNLOCK4,
                            PASSUNLOCK5,
                            PASSUNLOCK6,
                            PASSUNLOCK7,
                            PASSUNLOCK8,
                            PASSUNLOCK9,
                            PASSUNLOCK10,
                            PASSUNLOCK,
                            EXIT_PASS,
                            PPBLOCK_CMDSET,
                            PPBLOCK_A0SEEN,
                            PPBLOCK_SET,
                            EXIT_PPBLOCK,
                            A0SEEN,
                            OTP,
                            OTP_Z001,
                            OTP_PREL,
                            OTP_AS,
                            OTP_A0SEEN,
                            C8,
                            C8_Z001,
                            C8_PREL,
                            ERS,
                            SERS,
                            ESPS,
                            SERS_EXEC,
                            ESP,
                            ESP_Z001,
                            ESP_PREL,
                            ESP_CFI,
                            ESP_A0SEEN,
                            ESP_AS,
                            PGMS,
                            PSPS,
                            PSP,
                            PSP_Z001,
                            PSP_PREL,
                            PSP_CFI,
                            PSP_AS,
                            WBPGMS_WBCNT,
                            WBPGMS_WBLSTA,
                            WBPGMS_WBLOAD,
                            WBPGMS_CONFB,
                            WBPGMS_WBABORT,
                            WBPGMS_Z001,
                            WBPGMS_PREL
                            );

        TYPE PASS_TYPE IS ARRAY(0 TO 7) OF std_logic_vector(7 downto 0);
        TYPE LOG_TYPE IS ARRAY(0 TO 1) OF std_logic_vector(7 downto 0);

        TYPE PassUnlockType IS ARRAY(0 TO 7) OF BOOLEAN;

        TYPE PgmsTargetType IS (MEMORY,
                                OTP,
                                PASSW,
                                PPB_BIT,
                                LREG);

        SHARED VARIABLE LockReg     : LOG_TYPE;
        SHARED VARIABLE Password    : PASS_TYPE;
        -- Protection parameters
        SHARED VARIABLE DYB         : std_logic_vector(SecNum downto 0) :=
                                                   (OTHERS => '1');
        SHARED VARIABLE PPB         : std_logic_vector(SecNum downto 0) :=
                                                   (OTHERS => '1');
        SHARED VARIABLE PPBLock     : std_logic;

signal            A_deb              :     std_logic_vector(HiAddrBit downto 0) :=
                                               (OTHERS => 'U');
        signal AddressLatched_deb : NATURAL RANGE 0 TO ADDRRange;

        -- states
        SIGNAL current_state    : state_type;
        SIGNAL next_state       : state_type;

        -- powerup
        SIGNAL PoweredUp        : std_logic := '0';

        --zero delay signals
        SIGNAL DOut_zd          : std_logic_vector(15 downto 0):=(OTHERS=>'Z');
        SIGNAL DOut_Pass        : std_logic_vector(15 downto 0):=(OTHERS=>'Z');
        SIGNAL RY_zd            : std_logic := 'Z';

        --FSM control signals
        SIGNAL ULBYPASS         : std_logic := '0'; --Unlock Bypass Active
        SIGNAL OTP_ACT          : std_logic := '0'; --SecSi access
        SIGNAL PSP_ACT          : std_logic := '0'; --Program Suspend
        SIGNAL ESP_ACT          : std_logic := '0'; --Erase Suspend
        SIGNAL PASS_ACT         : std_logic := '0'; --Password access
        SIGNAL PPB_ACT          : std_logic := '0'; --PPB access
        SIGNAL LOCK_ACT         : std_logic := '0'; -- LOck register access
        SIGNAL LCNT             : NATURAL RANGE 0 TO 31:= 0; --Load Counter

        --number of location to be writen in Write Buffer: 0-31 bytes.
        --if 32 word/byte programming
        SIGNAL PCNT             : NATURAL RANGE 0 TO 32:= 0;

        --Model should never hang!!!!!!!!!!!!!!!
        SIGNAL HANG             : std_logic := '0';

        SIGNAL PDONE            : std_logic := '1'; --Prog. Done
        SIGNAL PSTART           : std_logic := '0'; --Start Programming
        SIGNAL PSUSP            : std_logic := '0'; --Suspend programming
        SIGNAL PRES             : std_logic := '0'; --Resume Programming
        --Program location is in protected sector
        SIGNAL PERR             : std_logic := '0';

        SIGNAL EDONE            : std_logic := '1'; --Ers. Done
        SIGNAL ESTART           : std_logic := '0'; --Start Erase
        SIGNAL ESUSP            : std_logic := '0'; --Suspend Erase
        SIGNAL ERES             : std_logic := '0'; --Resume Erase
        --All sectors selected for erasure are protected
        SIGNAL EERR             : std_logic := '0';
        --Sectors selected for erasure
        SIGNAL ERS_QUEUE        : std_logic_vector(SecNum downto 0) :=
                                                   (OTHERS => '0');
        --Command Register
        SIGNAL write            : std_logic := '0';
        SIGNAL read             : std_logic := '0';

        --Sector Address
        SIGNAL SecAddr          : NATURAL RANGE 0 TO SecNum := 0;
        SIGNAL SA               : NATURAL RANGE 0 TO SecNum := 0;
        SIGNAL WBPage           : NATURAL;

        --Address within sector
        SIGNAL Address          : NATURAL RANGE 0 TO SecSize := 0;

        SIGNAL D_tmp0 : NATURAL RANGE 0 TO MaxData;
        SIGNAL D_tmp1 : NATURAL RANGE 0 TO MaxData;

        --A20:A11 Don't Care
        SIGNAL Addr             : NATURAL RANGE 0 TO 16#7FF# := 0;

        SIGNAL WPage            : NATURAL RANGE 0 TO 16#7FF# := 0;
        SIGNAL RPage            : NATURAL RANGE 0 TO 16#2000# := 0;
        SIGNAL RPChange         : boolean := true;

        --glitch protection
        SIGNAL gWE_n            : std_logic := '1';
        SIGNAL gCE_n            : std_logic := '1';
        SIGNAL gOE_n            : std_logic := '1';

        SIGNAL RST              : std_logic := '1';
        SIGNAL reseted          : std_logic := '0';

        --SecSi ProtectionStatus
        SIGNAL FactoryProt      : std_logic := '1';

        -- timing check violation
        SIGNAL Viol             : X01 := '0';

        -- Address of the Protected Sector
        SIGNAL ProtSecNum    : integer := -1 ;
        SIGNAL ProtSecNum1   : integer := -1 ;
        -- Access time variables
        SHARED VARIABLE OPENLATCH    : BOOLEAN;
        SHARED VARIABLE FROMCE       : BOOLEAN;
        SHARED VARIABLE FROMOE       : BOOLEAN;

        PROCEDURE ADDRHILO(
            VARIABLE   AddrLOW  : INOUT NATURAL RANGE 0 to  ADDRRange;
            VARIABLE   AddrHIGH : INOUT NATURAL RANGE 0 to ADDRRange;
            VARIABLE   SectorID : NATURAL
            ) IS
        BEGIN
            IF (TimingModel(16) = '3') THEN
                IF (SectorID < 63) THEN
                    AddrLOW  := SectorID*16#10000#;
                    AddrHIGH := SectorID*16#10000# + 16#0FFFF#;
                ELSE
                    AddrLOW  := (SectorID - 63)*16#2000# + 16#3F0000#;
                    AddrHIGH := (SectorID - 63)*16#2000# +
                                16#3F0000# + 16#01FFF#;
                END IF;
            ELSIF (TimingModel(16) = '4') THEN
                IF (SectorID <= 7) THEN
                    AddrLOW  := SectorID*16#02000#;
                    AddrHIGH := SectorID*16#02000# + 16#01FFF#;
                ELSE
                    AddrLOW  := (SectorID-7)*16#10000#;
                    AddrHIGH := (SectorID-7)*16#10000#+16#0FFFF#;
                END IF;
            ELSIF (TimingModel(16) = '1' OR TimingModel(16) = '2') THEN
                AddrLOW  := SectorID*16#10000#;
                AddrHIGH := SectorID*16#10000# + 16#0FFFF#;
            END IF;
        END AddrHILO;

        FUNCTION ReturnSectorID(ADDR : NATURAL)
        RETURN NATURAL IS
            VARIABLE result : NATURAL;
            VARIABLE conv   : NATURAL;
        BEGIN
            conv := ADDR / 16#8000#;
            IF (TimingModel(16) = '3') THEN
                IF (conv <= 62) THEN
                    result := conv;
                ELSE
                    result := 63 + (ADDR - 16#1F8000#)/16#1000#;
                END IF;
            ELSIF (TimingModel(16) = '4') THEN
                IF (conv = 0) THEN
                    result := ADDR / 16#1000#;
                ELSE
                    result := 7 + conv;
                END IF;
            ELSIF (TimingModel(16) = '1' OR TimingModel(16) = '2')  THEN
                result := conv;
            END IF;

            RETURN result;
        END ReturnSectorID;

        FUNCTION ReturnSectorID1(ADDR : NATURAL)
        RETURN NATURAL IS
            VARIABLE result : NATURAL;
            VARIABLE conv   : NATURAL;
        BEGIN
            conv := ADDR / 16#10000#;
            IF (TimingModel(16) = '3') THEN
                IF ( conv <= 62 ) THEN
                    result := conv;
                ELSE
                    result := 63 + (ADDR - 16#3F0000#)/16#2000#;
                END IF;
            ELSIF (TimingModel(16) = '4') THEN
                IF ( conv = 0 ) THEN
                    result := ADDR / 16#2000#;
                ELSIF ( conv >= 1 ) THEN
                    result := 7 + conv;
                END IF;
            ELSIF (TimingModel(16) = '1' OR TimingModel(16) = '2')  THEN
                result := conv;
            END IF;

            RETURN result;
        END ReturnSectorID1;

        FUNCTION READMEM(Data    : INTEGER RANGE -1 TO MaxData)
        RETURN STD_LOGIC_VECTOR IS
            VARIABLE ReadData : STD_LOGIC_VECTOR(7 downto 0);
        BEGIN
            IF Data = -1 THEN
                ReadData := (OTHERS=>'X');
            ELSE
                ReadData := to_slv(Data,8);
            END IF;
            RETURN ReadData;
        END READMEM;

    BEGIN

    ---------------------------------------------------------------------------
    --protected sectors
    ---------------------------------------------------------------------------
    ProtSec: PROCESS
    BEGIN
        IF TimingModel(16) = '1' THEN
            ProtSecNum <= 63;
        ELSIF TimingModel(16) = '2' THEN
            ProtSecNum <= 0;
        ELSIF TimingModel(16) = '3' THEN
            ProtSecNum <= 69;
            ProtSecNum1 <= 70;
        ELSIF TimingModel(16) = '4' THEN
            ProtSecNum <= 0;
            ProtSecNum1 <= 1;
        END IF;
        WAIT;
    END PROCESS ProtSec;
    ----------------------------------------------------------------------------
    --Power Up time 100 ns
    ---------------------------------------------------------------------------
    PoweredUp <= '1' AFTER 100 ns;
    RST <= RESETNeg AFTER 500 ns;

    ---------------------------------------------------------------------------
    -- VITAL Timing Checks Procedures
    ---------------------------------------------------------------------------
    VITALTimingCheck: PROCESS(A, Din, CENeg, OENeg, WENeg, RESETNeg, WPNeg)

         -- Timing Check Variables
        VARIABLE Tviol_A0_CENeg   : X01 := '0';
        VARIABLE TD_A0_CENeg      : VitalTimingDataType;

        VARIABLE Tviol_A0_WENeg   : X01 := '0';
        VARIABLE TD_A0_WENeg      : VitalTimingDataType;

        VARIABLE Tviol_A0_OENeg   : X01 := '0';
        VARIABLE TD_A0_OENeg      : VitalTimingDataType;

        VARIABLE Tviol_DQ0_WENeg  : X01 := '0';
        VARIABLE TD_DQ0_WENeg     : VitalTimingDataType;

        VARIABLE Tviol_DQ0_CENeg  : X01 := '0';
        VARIABLE TD_DQ0_CENeg     : VitalTimingDataType;

        VARIABLE Tviol_CENeg_RESETNeg  : X01 := '0';
        VARIABLE TD_CENeg_RESETNeg     : VitalTimingDataType;

        VARIABLE Tviol_OENeg_RESETNeg  : X01 := '0';
        VARIABLE TD_OENeg_RESETNeg     : VitalTimingDataType;

        VARIABLE Tviol_OENeg_WENeg  : X01 := '0';
        VARIABLE TD_OENeg_WENeg     : VitalTimingDataType;

        VARIABLE Tviol_WENeg_OENeg  : X01 := '0';
        VARIABLE TD_WENeg_OENeg     : VitalTimingDataType;

        VARIABLE Pviol_RESETNeg    : X01 := '0';
        VARIABLE PD_RESETNeg       : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Pviol_OENeg       : X01 := '0';
        VARIABLE PD_OENeg          : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Pviol_CENeg       : X01 := '0';
        VARIABLE PD_CENeg          : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Pviol_CENeg1      : X01 := '0';
        VARIABLE PD_CENeg1         : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Pviol_WENeg       : X01 := '0';
        VARIABLE PD_WENeg          : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Pviol_A0          : X01 := '0';
        VARIABLE PD_A0             : VitalPeriodDataType := VitalPeriodDataInit;

        VARIABLE Violation         : X01 := '0';

    BEGIN
    ---------------------------------------------------------------------------
    -- Timing Check Section
    ---------------------------------------------------------------------------
    IF (TimingChecksOn) THEN

        -- Setup/Hold Check between A and CENeg
        VitalSetupHoldCheck (
            TestSignal      => A,
            TestSignalName  => "A",
            RefSignal       => CENeg,
            RefSignalName   => "CE#",
            SetupHigh       => tsetup_A0_CENeg,
            SetupLow        => tsetup_A0_CENeg,
            HoldHigh        => thold_A0_CENeg,
            HoldLow         => thold_A0_CENeg,
            CheckEnabled    => TRUE,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_A0_CENeg,
            Violation       => Tviol_A0_CENeg
        );
        -- Setup/Hold Check between A and WENeg
        VitalSetupHoldCheck (
            TestSignal      => A,
            TestSignalName  => "A",
            RefSignal       => WENeg,
            RefSignalName   => "WE#",
            SetupHigh       => tsetup_A0_CENeg,
            SetupLow        => tsetup_A0_CENeg,
            HoldHigh        => thold_A0_CENeg,
            HoldLow         => thold_A0_CENeg,
            CheckEnabled    => TRUE,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_A0_WENeg,
            Violation       => Tviol_A0_WENeg
        );
        -- Setup/Hold Check between A and OENeg
        VitalSetupHoldCheck (
            TestSignal      => A,
            TestSignalName  => "A",
            RefSignal       => OENeg,
            RefSignalName   => "OE#",
            SetupHigh       => tsetup_A0_OENeg,
            SetupLow        => tsetup_A0_OENeg,
            HoldHigh        => thold_A0_OENeg,
            HoldLow         => thold_A0_OENeg,
            CheckEnabled    => TRUE,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_A0_OENeg,
            Violation       => Tviol_A0_OENeg
        );
        -- Setup/Hold Check between DQ and CENeg
        VitalSetupHoldCheck (
            TestSignal      => DQ0,
            TestSignalName  => "DQ",
            RefSignal       => CENeg,
            RefSignalName   => "CE#",
            SetupHigh       => tsetup_DQ0_CENeg,
            SetupLow        => tsetup_DQ0_CENeg,
            HoldHigh        => thold_DQ0_CENeg,
            HoldLow         => thold_DQ0_CENeg,
            CheckEnabled    => DIn(14 downto 0)/=DOut_zd(14 downto 0),
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_DQ0_CENeg,
            Violation       => Tviol_DQ0_CENeg
        );
        -- Setup/Hold Check between DQ and WENeg
        VitalSetupHoldCheck (
            TestSignal      => DQ0,
            TestSignalName  => "DQ",
            RefSignal       => WENeg,
            RefSignalName   => "WE#",
            SetupHigh       => tsetup_DQ0_CENeg,
            SetupLow        => tsetup_DQ0_CENeg,
            HoldHigh        => thold_DQ0_CENeg,
            HoldLow         => thold_DQ0_CENeg,
            CheckEnabled    => DIn(14 downto 0)/=DOut_zd(14 downto 0),
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_DQ0_WENeg,
            Violation       => Tviol_DQ0_WENeg
        );
        -- Hold Check between CENeg and RESETNeg
        VitalSetupHoldCheck (
            TestSignal      => CENeg,
            TestSignalName  => "CE#",
            RefSignal       => RESETNeg,
            RefSignalName   => "RESET#",
            HoldHigh        => thold_CENeg_RESETNeg,
            CheckEnabled    => TRUE,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_CENeg_RESETNeg,
            Violation       => Tviol_CENeg_RESETNeg
        );
        -- Hold Check between OENeg and RESETNeg
        VitalSetupHoldCheck (
            TestSignal      => OENeg,
            TestSignalName  => "OE#",
            RefSignal       => RESETNeg,
            RefSignalName   => "RESET#",
            HoldHigh        => thold_CENeg_RESETNeg,
            CheckEnabled    => TRUE,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_OENeg_RESETNeg,
            Violation       => Tviol_OENeg_RESETNeg
        );
        -- Hold Check between OENeg and WENeg
        VitalSetupHoldCheck (
            TestSignal      => OENeg,
            TestSignalName  => "OE#",
            RefSignal       => WENeg,
            RefSignalName   => "WE#",
            HoldHigh        => thold_OENeg_WENeg,
            CheckEnabled    => TRUE,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_OENeg_WENeg,
            Violation       => Tviol_OENeg_WENeg
        );
        -- Hold Check between WENeg and OENeg
        VitalSetupHoldCheck (
            TestSignal      => WENeg,
            TestSignalName  => "WE#",
            RefSignal       => OENeg,
            RefSignalName   => "OE#",
            HoldHigh        => thold_WENeg_OENeg,
            CheckEnabled    => TRUE,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_WENeg_OENeg,
            Violation       => Tviol_WENeg_OENeg
        );
        -- PulseWidth Check for RESETNeg
        VitalPeriodPulseCheck (
            TestSignal        => RESETNeg,
            TestSignalName    => "RESET#",
            PulseWidthLow     => tpw_RESETNeg_negedge,
            CheckEnabled      => TRUE,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_RESETNeg,
            Violation         => Pviol_RESETNeg
        );
        -- PulseWidth Check for OENeg
        VitalPeriodPulseCheck (
            TestSignal        => OENeg,
            TestSignalName    => "OE#",
            PulseWidthHigh    => tpw_OENeg_posedge,
            CheckEnabled      => TRUE,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_OENeg,
            Violation         => Pviol_OENeg
        );
        -- PulseWidth Check for WENeg
        VitalPeriodPulseCheck (
            TestSignal        => WENeg,
            TestSignalName    => "WE#",
            PulseWidthHigh    => tpw_WENeg_posedge,
            PulseWidthLow     => tpw_WENeg_negedge,
            CheckEnabled      => TRUE,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_WENeg,
            Violation         => Pviol_WENeg
        );
        -- PulseWidth Check for CENeg
        VitalPeriodPulseCheck (
            TestSignal        => CENeg,
            TestSignalName    => "CE#",
            PulseWidthHigh    => tpw_CENeg_RY_EQ_1_posedge, --tpw_CENeg_posedge,
            PulseWidthLow     => tpw_CENeg_negedge,
            CheckEnabled      => RY_zd = '1',
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_CENeg,
            Violation         => Pviol_CENeg
        );
        -- PulseWidth Check for CENeg
        VitalPeriodPulseCheck (
            TestSignal        => CENeg,
            TestSignalName    => "CE#",
            PulseWidthHigh    => tpw_CENeg_RY_EQ_0_posedge,
            CheckEnabled      => RY_zd = '0',
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_CENeg1,
            Violation         => Pviol_CENeg1
        );
        -- PulseWidth Check for A
        VitalPeriodPulseCheck (
            TestSignal        => A(0),
            TestSignalName    => "A",
            PulseWidthHigh    => tpw_A0_negedge,
            PulseWidthLow     => tpw_A0_negedge,
            CheckEnabled      => TRUE,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_A0,
            Violation         => Pviol_A0
        );

        Violation := Tviol_A0_CENeg          OR
                     Tviol_A0_WENeg          OR
                     Tviol_A0_OENeg          OR
                     Tviol_DQ0_WENeg         OR
                     Tviol_DQ0_CENeg         OR
                     Tviol_CENeg_RESETNeg    OR
                     Tviol_OENeg_RESETNeg    OR
                     Tviol_OENeg_WENeg       OR
                     Tviol_WENeg_OENeg       OR
                     Pviol_RESETNeg          OR
                     Pviol_OENeg             OR
                     Pviol_CENeg             OR
                     Pviol_CENeg1            OR
                     Pviol_WENeg             OR
                     Pviol_A0               ;

        Viol <= Violation;

        ASSERT Violation = '0'
            REPORT InstancePath & partID & ": simulation may be" &
                    " inaccurate due to timing violations"
            SEVERITY WARNING;
    END IF;
    END PROCESS VITALTimingCheck;

    ----------------------------------------------------------------------------
    -- sequential process for reset control and FSM state transition
    ----------------------------------------------------------------------------
    StateTransition : PROCESS(next_state, RESETNeg, RST, sREADY, PDone, EDone,
                              PoweredUp)
        VARIABLE R  : std_logic := '0'; --prog or erase in progress
        VARIABLE E  : std_logic := '0'; --reset timming error

    BEGIN
        IF PoweredUp = '1' THEN
        --Hardware reset timing control
            IF falling_edge(RESETNeg) THEN
                E := '0';
                IF (PDONE = '0' OR EDONE = '0') THEN
                    --if program or erase in progress
                    READY_in <= '1';
                    R := '1';
                ELSE
                    READY_in <= '0';
                    R := '0';         --prog or erase not in progress
                END IF;
            ELSIF rising_edge(RESETNeg) AND RST = '1' THEN
                --RESET# pulse < tRP
                READY_in <= '0';
                R := '0';
                E := '1';
            END IF;

            IF  RESETNeg = '1' AND ( R = '0' OR (R = '1' AND sREADY = '1')) THEN
                current_state <= next_state;
                READY_in <= '0';
                E := '0';
                R := '0';
                reseted <= '1';

            ELSIF (R = '0' AND RESETNeg = '0' AND RST = '0') OR
            (R = '1' AND RESETNeg = '0' AND RST = '0' AND sREADY = '0') OR
            (R = '1' AND RESETNeg = '1' AND RST = '0' AND sREADY = '0') THEN
                --no state transition while RESET# low
                current_state <= RESET; --reset start
                reseted       <= '0';
            END IF;

        ELSE
            current_state <= RESET; -- reset
            reseted <= '0';
            E := '0';
            R := '0';
        END IF;

    END PROCESS StateTransition;
    ---------------------------------------------------------------------------
    --Glitch Protection: Inertial Delay does not propagate pulses < 3ns
    ---------------------------------------------------------------------------
    gWE_n <= WENeg AFTER 3 ns;
    gCE_n <= CENeg AFTER 3 ns;
    gOE_n <= OENeg AFTER 3 ns;

    --latch address on rising edge and data on falling edge  of write
    write_dc: PROCESS (gWE_n, gCE_n, gOE_n, RESETNeg, reseted)

    BEGIN
        IF RESETNeg /= '0' AND reseted ='1' THEN
            IF (gWE_n = '0') AND (gCE_n = '0') AND (gOE_n = '1') THEN
                write <= '1';
            ELSIF (gWE_n = '1' OR gCE_n = '1') AND gOE_n = '1' THEN
                write <= '0';
            ELSE
                write <= 'X';
            END IF;
        END IF;

        IF ((gWE_n = '1') AND (gCE_n = '0') AND (gOE_n = '0')) THEN
            read <= '1';
        ELSE
            read <= '0';
        END IF;

    END PROCESS write_dc;

    ---------------------------------------------------------------------------
    --Process that reports warning when changes on signals WE#, CE#, OE# are
    --discarded
    ---------------------------------------------------------------------------
    PulseWatch : PROCESS (WENeg, CENeg, OENeg, gWE_n, gCE_n, gOE_n)
    BEGIN
        IF (gWE_n'EVENT AND (gWE_n /= WENeg)) OR
        (gCE_n'EVENT AND (gCE_n /= CENeg)) OR
        (gOE_n'EVENT AND (gOE_n /= OENeg)) THEN
            ASSERT false
                REPORT "Glitch detected on write control signals"
                SEVERITY warning;
        END IF;
    END PROCESS PulseWatch;

    ----------------------------------------------------------------------------
    -- Device internal operation control
    ----------------------------------------------------------------------------
    -- configuring the PPB Lock Bit to the freeze state
    ProtPROG : PROCESS(PBPROG_in)
    BEGIN
        IF PBPROG_in = '0' THEN
            PBPROG_out <= '0';
        ELSE
            IF LongTimming = TRUE THEN
                PBPROG_out <= '1' AFTER (tdevice_PPBLOCK - 1 ns);
            ELSE
                PBPROG_out <= '1' AFTER (tdevice_PPBLOCK - 1 ns)/1;
            END IF;
        END IF;
    END PROCESS ProtPROG;

    UNL : PROCESS(UNLOCKDONE_in)
    BEGIN
        IF UNLOCKDONE_in = '0' THEN
            UNLOCKDONE_out <= '0';
        ELSE
            IF LongTimming = TRUE THEN
                UNLOCKDONE_out <= '1' AFTER (tdevice_UNLOCK- 1 ns);
            ELSE
                UNLOCKDONE_out <= '1' AFTER (tdevice_UNLOCK- 1 ns)/1;
            END IF;
        END IF;
    END PROCESS UNL;

    ---------------------------------------------------------------------------
    -- Latch address on falling edge of WE# or CE# what ever comes later
    -- Latches data on rising edge of WE# or CE# what ever comes first
    -- also Write cycle decode
    ---------------------------------------------------------------------------
    BusCycleDecode : PROCESS(A, Din, write, WENeg, CENeg, OENeg, BYTENeg,
                             reseted, read)

        VARIABLE A_tmp  : NATURAL RANGE 0 TO 16#7FF#;
        VARIABLE A_tmp1 : NATURAL RANGE 0 TO SecSize;
        VARIABLE AddrTmp        : NATURAL RANGE 0 TO ADDRRange;
        VARIABLE AddressLatched : NATURAL RANGE 0 TO ADDRRange;
        VARIABLE AddrLOW        : NATURAL RANGE 0 TO ADDRRange;
        VARIABLE AddrHIGH       : NATURAL RANGE 0 TO ADDRRange;
        VARIABLE sector         : NATURAL;
        VARIABLE CE     : std_logic;
    BEGIN
        IF reseted = '1' THEN
            IF (falling_edge(WENeg) AND CENeg ='0' AND OENeg = '1') OR
            (falling_edge(CENeg) AND WENeg/= OENeg) OR
            (falling_edge(OENeg) AND WENeg ='1' AND CENeg = '0') OR
            ((A'EVENT OR (Din(15)'EVENT AND BYTENeg='0') OR BYTENeg'EVENT )
            AND WENeg = '1' AND CENeg = '0' AND OENeg = '0') THEN

                A_tmp :=  to_nat(A(10 downto 0));
                A_deb <= A;
                AddressLatched := to_nat(A);
                sector := ReturnSectorID(AddressLatched);
                AddressLatched_deb <= AddressLatched;
               -- report "Sector is" & i2s(integer(AddressLatched),15) severity note;
              --  report "Sector is" & i2s(integer(sector),10) severity note;
                ADDRHILO(AddrLOW, AddrHIGH, sector);
                AddrTmp :=  AddressLatched - (AddrLOW/2);

                IF (BYTENeg = '0') THEN
                    A_tmp1 := to_nat(to_slv(AddrTmp,15) & Din(15));
                ELSE
                    A_tmp1 := to_nat(to_slv(AddrTmp,15) & '0');
                END IF;

            ELSIF (rising_edge(WENeg) OR rising_edge(CENeg)) AND
            write = '1' THEN
                D_tmp0 <= to_nat(Din(7 downto 0));
                IF BYTENeg = '1' THEN
                    D_tmp1 <= to_nat(Din(15 downto 8));
                END IF;
            END IF;

            IF rising_edge(write) OR rising_edge(read) OR
            falling_edge(OENeg) OR
            ((A'EVENT OR ( Din(15)'EVENT AND BYTENeg = '0') OR
            BYTENeg'EVENT) AND WENeg = '1' AND CENeg = '0' AND
            OENeg = '0') THEN
                SecAddr <= sector;
                Address <= A_tmp1;
                WPage   <= A_tmp1 / 32;
                IF (RPage  /= (A_tmp1 / 16)) OR (CENeg /= CE) THEN
                    RPchange <= true;
                ELSE
                    RPchange <= false;
                END IF;
                RPage <= A_tmp1 / 16;
                CE := CENeg;
                Addr <= A_tmp;
            END IF;
        END IF;
    END PROCESS BusCycleDecode;

    ---------------------------------------------------------------------------
    -- Timing control for the Program/ Write Buffer Program Operations
    -- start/ suspend/ resume
    ---------------------------------------------------------------------------
    ProgTime : PROCESS(PSTART, PSUSP, PRES, BYTENeg, reseted)
        VARIABLE cnt      : NATURAL RANGE 0 TO SecNum + 1 := 0;
        VARIABLE elapsed  : time;
        VARIABLE duration : time;
        VARIABLE start    : time;
        VARIABLE pow      : time;
        VARIABLE wbpb     : time;
    BEGIN
        IF LongTimming THEN
            pow  := tdevice_POW;
            wbpb := tdevice_WBPB;--per byte
        ELSE
            pow  := tdevice_POW / 10;
            wbpb := tdevice_WBPB / 5; --per byte
        END IF;
        IF rising_edge(reseted) THEN
            PDONE <= '1';  -- reset done, programing terminated

        ELSIF reseted = '1' THEN
            IF rising_edge(PSTART) AND PDONE = '1' THEN
                IF NOT ( ( (DYB(SA)  = '0' OR PPB(SA) = '0') AND OTP_ACT = '0'
                AND PPB_ACT = '0' AND LOCK_ACT = '0' AND PASS_ACT = '0') OR
                --password protection mode
                (PASS_ACT = '1' AND LockReg(0)(2) = '0') OR
                (Ers_queue(SA) = '1' AND ESP_ACT = '1') OR
                (FactoryProt = '1' AND OTP_ACT = '1') OR
                (LockReg(0)(0) = '0' AND OTP_ACT = '1') OR
                (WPNeg = '0' AND (SA = ProtSecNum OR SA = ProtSecNum1)) ) THEN

                    IF PCNT < 32 THEN --buffer
                        IF BYTENeg = '1' THEN
                            cnt := PCNT + 2;
                        ELSE
                            cnt := PCNT + 1;
                        END IF;
                        duration := cnt * wbpb;
                    ELSE   --Word/Byte program
                        IF BYTENeg = '1' THEN
                            cnt := 1;
                            duration := cnt * pow; --per word
                        ELSE
                            duration := pow / 2; -- per byte
                        END IF;

                    END IF;

                    elapsed := 0 ns;
                    PDONE <= '0', '1' AFTER duration;
                    start := NOW;
                ELSE
                    PERR <= '1', '0' AFTER 1 us;
                END IF;
            ELSIF rising_edge(PSUSP) AND PDONE = '0' THEN
                elapsed  := NOW - start;
                duration := duration - elapsed;
                PDONE <= '0';
            ELSIF rising_edge(PRES) AND PDONE = '0'  THEN
                start := NOW;
                PDONE <= '0', '1' AFTER duration;
            END IF;

        END IF;
    END PROCESS ProgTime;

    ---------------------------------------------------------------------------
    -- Timing control for the Erase Operations
    ---------------------------------------------------------------------------
    ErsTime :PROCESS(ESTART, ESUSP, ERES, Ers_Queue, reseted)
        VARIABLE cnt      : NATURAL RANGE 0 TO SecNum + 1 := 0;
        VARIABLE elapsed  : time;
        VARIABLE erase_duration : time;
        VARIABLE start    : time;
        VARIABLE seo      : time;

    BEGIN
        IF LongTimming THEN
            seo  := tdevice_SEO;
        ELSE
            seo  := tdevice_SEO / 1000;
        END IF;
        IF rising_edge(reseted) THEN
            EDONE <= '1';  -- reset done, ERASE terminated
        ELSIF reseted = '1' THEN
            IF rising_edge(ESTART) AND EDONE = '1' THEN
                cnt := 0;
                FOR i IN Ers_Queue'RANGE LOOP
                    IF (Ers_Queue(i) = '1' AND DYB(i) = '1' AND PPB(i) = '1'
                    AND NOT (WPNeg = '0' AND (i = ProtSecNum OR
                    i = ProtSecNum1)) AND PPB_ACT = '0') THEN
                        cnt := cnt + 1;
                    END IF;
                END LOOP;
                IF PPB_ACT = '1' THEN
                    cnt := 1;
                END IF;

                IF cnt > 0 THEN
                  --report "Counting reset" severity note;
                    elapsed := 0 ns;
                    erase_duration := cnt * seo;
                    EDONE <= '0', '1' AFTER erase_duration;
                    start := NOW;
                ELSE
                    EERR <= '1', '0' AFTER 100 us;
                END IF;
            ELSIF rising_edge(ESUSP) AND EDONE = '0' THEN
                elapsed  := NOW - start;
                erase_duration := erase_duration - elapsed;
                EDONE <= '0';
            ELSIF rising_edge(ERES) AND EDONE = '0' THEN
                start := NOW;
                EDONE <= '0', '1' AFTER erase_duration;
            END IF;
        END IF;
    END PROCESS;
    ---------------------------------------------------------------------------
    -- Main Behavior Process
    -- combinational process for next state generation
    ---------------------------------------------------------------------------
    StateGen :PROCESS(write, Addr, D_tmp0, ULBYPASS, PDONE, EDONE, HANG,
                      sCTMOUT, sSTART_T1, reseted, sREADY, PERR,
                      EERR, RST, UNLOCKDONE_out, PBPROG_out)

        VARIABLE PATTERN_1         : boolean := FALSE;
        VARIABLE PATTERN_2         : boolean := FALSE;
        VARIABLE A_PAT_1           : boolean := FALSE;

        --DATA  High Byte
        VARIABLE DataHi           : NATURAL RANGE 0 TO MaxData := 0;
        --DATA Low Byte
        VARIABLE DataLo           : NATURAL RANGE 0 TO MaxData := 0;
        VARIABLE tempLR           : std_logic_vector(7 downto 0);

    BEGIN
        -----------------------------------------------------------------------
        -- Functionality Section
        -----------------------------------------------------------------------
        IF falling_edge(write) THEN
            DataLo    := D_tmp0;
            PATTERN_1 := (Addr=16#555#) AND (DataLo = 16#AA#) ;
            PATTERN_2 := (Addr=16#2AA#) AND (DataLo = 16#55#) ;
            A_PAT_1   := (Addr=16#555#);
        END IF;

        IF falling_edge(RST) AND RESETNeg = '0' THEN
            LOCK_ACT <= '0';
            PPB_ACT <= '0';
        END IF;

        IF reseted /= '1' THEN
            next_state <= current_state;
        ELSE
        CASE current_state IS
            WHEN RESET =>
                IF falling_edge(write) THEN
                    IF (PATTERN_1) THEN
                        next_state <= Z001;
                    ELSIF ((Addr=16#55#) AND (DataLo=16#98#))THEN
                        next_state <= CFI;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN Z001 =>
                IF falling_edge(write) THEN
                    IF (PATTERN_2) THEN
                        next_state <= PREL_SETBWB;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN PREL_SETBWB =>
                IF falling_edge(write) THEN
                    IF (A_PAT_1 AND (DataLo=16#20#)) THEN
                        next_state <= PREL_ULBYPASS;
                    ELSIF (A_PAT_1 AND (DataLo=16#90#)) THEN
                        next_state <= AS;
                    ELSIF (A_PAT_1 AND (DataLo=16#A0#)) THEN
                        next_state <= A0SEEN;
                    ELSIF (A_PAT_1 AND (DataLo=16#88#)) THEN
                        next_state <= OTP;
                    ELSIF (A_PAT_1 AND (DataLo = 16#40#)) THEN
                        next_state <= LOCKREG_CMDSET;
                        LOCK_ACT <= '1';
                    ELSIF (A_PAT_1 AND (DataLo = 16#60#)) THEN
                        next_state <= PASS_CMDSET;
                        PASS_ACT <= '1';
                    ELSIF (A_PAT_1 AND (DataLo = 16#50#)) THEN
                        next_state <= PPBLOCK_CMDSET;
                    ELSIF (A_PAT_1 AND (DataLo = 16#C0#)) THEN
                        next_state <= PPB_CMDSET;
                        PPB_ACT <= '1';
                    ELSIF (A_PAT_1 AND (DataLo = 16#E0#)) THEN
                        next_state <= DYB_CMDSET;
                    ELSIF (A_PAT_1 AND (DataLo=16#80#)) THEN
                        next_state <= C8;
                    ELSIF (DataLo=16#25#) THEN
                        next_state <= WBPGMS_WBCNT;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN PREL_ULBYPASS  =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= A0SEEN;
                    ELSIF (DataLo = 16#80#) THEN
                        next_state <= C8_PREL;
                    ELSIF (DataLo = 16#90# ) THEN
                        next_state <= EXIT_ULBYPASS;
                    ELSIF (DataLo = 16#25#)  THEN
                        next_state <= WBPGMS_WBCNT;
                    ELSE
                        next_state <= PREL_ULBYPASS;
                    END IF;
                END IF;

            WHEN EXIT_ULBYPASS =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                    ELSE
                        next_state <= PREL_ULBYPASS;
                    END IF;
                END IF;

            WHEN CFI =>
                IF falling_edge(write) THEN
                    IF (Addr=16#55#) AND (DataLo=16#98#) THEN
                        next_state <= CFI;
                    ELSIF (DataLo=16#F0#) THEN
                        next_state <= RESET;
                    ELSE
                        next_state <=  CFI;
                    END IF;
                END IF;

            WHEN AS =>
                IF falling_edge(write) THEN
                    IF (DataLo=16#F0#) THEN
                        next_state <= RESET;
                    ELSE
                        next_state <= AS;
                    END IF;
                END IF;

            WHEN LOCKREG_CMDSET =>
                IF falling_edge(WRITE) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= LOCKREG_A0SEEN;
                    ELSIF (DataLo = 16#90#) THEN
                        next_state <= EXIT_LOCKREG;
                    END IF;
                END IF;

            WHEN LOCKREG_A0SEEN =>
                IF falling_edge(WRITE) THEN
                    tempLR := to_slv(DataLo,8);
                    IF NOT (tempLR(1) = '0' AND tempLR(2) = '0') THEN
                        next_state <= PGMS;
                    ELSE
                        next_state <= LOCKREG_CMDSET;
                    END IF;
                END IF;

            WHEN EXIT_LOCKREG =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                        LOCK_ACT <= '0';
                    ELSE
                        next_state <= LOCKREG_CMDSET;
                    END IF;
                END IF;

            WHEN PPB_CMDSET =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= PPB_A0SEEN;
                    ELSIF (DataLo = 16#80#) THEN
                        next_state <= PPB_80SEEN;
                    ELSIF (DataLo = 16#90#) THEN
                        next_state <= EXIT_PPB;
                    END IF;
                END IF;

            WHEN PPB_A0SEEN =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= PGMS;
                    ELSE
                        next_state <= PPB_CMDSET;
                    END IF;
                END IF;

            WHEN PPB_80SEEN =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#30#)AND (Addr=16#00#) THEN
                        next_state <= SERS;
                    ELSE
                        next_state <= PPB_CMDSET;
                    END IF;
                END IF;

            WHEN EXIT_PPB =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                        PPB_ACT <= '0';
                    ELSE
                        next_state <= PPB_CMDSET;
                    END IF;
                END IF;

            WHEN DYB_CMDSET =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= DYB_SETCLEAR;
                    ELSIF (DataLo = 16#90#) THEN
                        next_state <= EXIT_DYB;
                    END IF;
                END IF;

            WHEN DYB_SETCLEAR =>
                IF falling_edge(write) THEN
                    next_state <= DYB_CMDSET;
                END IF;

            WHEN EXIT_DYB =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                    ELSE
                        next_state <= DYB_CMDSET;
                    END IF;
                END IF;

            WHEN PPBLOCK_CMDSET =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= PPBLOCK_A0SEEN;
                    ELSIF (DataLo = 16#90#) THEN
                        next_state <= EXIT_PPBLOCK;
                    END IF;
                END IF;

            WHEN PPBLOCK_A0SEEN =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= PPBLOCK_SET;
                    ELSE
                        next_state <= PPBLOCK_CMDSET;
                    END IF;
                END IF;

            WHEN PPBLOCK_SET =>
                IF rising_edge(PBPROG_out) THEN
                    next_state <= PPBLOCK_CMDSET;
               END IF;

            WHEN EXIT_PPBLOCK =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                    ELSE
                        next_state <= PPBLOCK_CMDSET;
                    END IF;
                END IF;

            WHEN PASS_CMDSET =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#A0#) THEN
                        next_state <= PASS_A0SEEN;
                    ELSIF (DataLo = 16#90#) THEN
                        next_state <= EXIT_PASS;
                    ELSIF (Addr mod 16#100# = 16#00#) AND
                    (DataLo = 16#25#) THEN
                        next_state <= PASSUNLOCK1;
                    END IF;
                END IF;

            WHEN PASS_A0SEEN =>
                IF falling_edge(WRITE) THEN
                    next_state <= PGMS;
                END IF;

            WHEN PASSUNLOCK1 =>
                IF falling_edge(write) THEN
                    IF (Addr mod 16#100# = 16#00#) AND (DataLo = 16#03#) THEN
                        next_state <= PASSUNLOCK2;
                    ELSE
                        next_state <= PASS_CMDSET;
                    END IF;
                END IF;

            WHEN PASSUNLOCK2 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK3;
                END IF;

            WHEN PASSUNLOCK3 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK4;
                END IF;

            WHEN PASSUNLOCK4 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK5;
                END IF;

            WHEN PASSUNLOCK5 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK6;
                END IF;

            WHEN PASSUNLOCK6 =>
                IF falling_edge(write) THEN
                    IF BYTENeg = '1' THEN
                        IF ( Addr = 16#00# ) AND DataLo = 16#29# THEN
                            next_state <= PASSUNLOCK;
                        ELSE
                            next_state <= PASS_CMDSET;
                        END IF;
                    ELSE
                        next_state <= PASSUNLOCK7;
                    END IF;
                END IF;

            WHEN PASSUNLOCK7 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK8;
                END IF;

            WHEN PASSUNLOCK8 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK9;
                END IF;

            WHEN PASSUNLOCK9 =>
                IF falling_edge(write) THEN
                    next_state <= PASSUNLOCK10;
                END IF;

            WHEN PASSUNLOCK10 =>
                IF falling_edge(write) THEN
                    IF ( Addr mod 16#100# = 16#00# ) AND DataLo = 16#29# THEN
                        next_state <= PASSUNLOCK;
                    ELSE
                        next_state <= PASS_CMDSET;
                    END IF;
                END IF;

            WHEN PASSUNLOCK =>
                IF rising_edge(UNLOCKDONE_out) THEN
                    next_state <= PASS_CMDSET;
                END IF;

            WHEN EXIT_PASS =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        next_state <= RESET;
                        PASS_ACT <= '0';
                    ELSE
                        next_state <= PASS_CMDSET;
                    END IF;
                END IF;

            WHEN A0SEEN         =>
                IF falling_edge(write) THEN
                    next_state <= PGMS;
                ELSE
                    next_state <= A0SEEN;
                END IF;

            WHEN OTP            =>
                IF falling_edge(write) THEN
                    IF PATTERN_1 THEN
                        next_state <= OTP_Z001;
                    ELSE
                        next_state <= OTP;
                    END IF;
                END IF;

            WHEN OTP_Z001       =>
                IF falling_edge(write) THEN
                    IF PATTERN_2 THEN
                        next_state <= OTP_PREL;
                    ELSE
                        next_state <= OTP;
                    END IF;
                END IF;

            WHEN OTP_PREL       =>
                IF falling_edge(write) THEN
                    IF (A_PAT_1 AND (DataLo = 16#90#))THEN
                        next_state <= OTP_AS;
                    ELSIF DataLo = 16#25# THEN
                        --fix Sector Address  SA
                        next_state <= WBPGMS_WBCNT;
                    ELSIF (A_PAT_1 AND (DataLo = 16#A0#))THEN
                        next_state <= OTP_A0SEEN;
                    ELSE
                        next_state <= OTP;
                    END IF;
                END IF;

            WHEN OTP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo=16#F0# THEN
                        IF PSP_ACT = '1' THEN
                            next_state <= PSP;
                        ELSIF ESP_ACT = '1' THEN
                            next_state <= ESP;
                        ELSE
                            next_state <= RESET;
                        END IF;
                    ELSIF DataLo=16#00# THEN
                        IF PSP_ACT = '1' THEN
                            next_state <= PSP;
                        ELSIF ESP_ACT = '1' THEN
                            next_state <= ESP;
                        ELSE
                            next_state <= RESET;
                        END IF;
                    ELSE
                        next_state <= OTP;
                    END IF;
                END IF;

            WHEN OTP_A0SEEN     =>
                IF falling_edge(write) THEN
                    next_state <= PGMS; --set OTP
                ELSE
                    next_state <= OTP_A0SEEN;
                END IF;

            WHEN C8             =>
                IF falling_edge(write) THEN
                    IF PATTERN_1 THEN
                        next_state <= C8_Z001;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN C8_Z001        =>
                IF falling_edge(write) THEN
                    IF PATTERN_2 THEN
                        next_state <= C8_PREL;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN C8_PREL        =>
                IF falling_edge(write) THEN
                    IF ( A_PAT_1 OR ULBYPASS = '1' ) AND DataLo=16#10# THEN
                        next_state <= ERS;
                    ELSIF DataLo=16#30# THEN
                        next_state <= SERS;
                    ELSIF ULBYPASS = '1' THEN
                        next_state <= PREL_ULBYPASS;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN ERS            =>
                IF rising_edge(EDONE) OR falling_edge(EERR) THEN
                    IF ULBYPASS = '1' THEN
                        next_state <= PREL_ULBYPASS;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN SERS           =>
                IF sCTMOUT = '1' THEN
                    next_state <= SERS_EXEC;
                ELSIF falling_edge(write) THEN
                    IF (DataLo = 16#B0#) THEN
                        next_state <= ESP; -- ESP according to datasheet
                    ELSIF (DataLo=16#30#) THEN
                        next_state <= SERS;
                    ELSIF ULBYPASS = '1' THEN
                        next_state <= PREL_ULBYPASS;
                    ELSE
                        next_state <= RESET;
                    END IF;
                END IF;

            WHEN ESPS           =>
                IF (sSTART_T1 = '1') THEN
                    next_state <= ESP;
                END IF;

            WHEN WBPGMS_WBCNT   =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA) AND
                    ((BYTENeg = '0'AND DataLo < 32) OR
                    (BYTENeg = '1'AND DataLo < 16)) THEN
                        next_state <= WBPGMS_WBLSTA;
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN WBPGMS_WBLSTA  =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA) THEN -- fix WriteBufferPage  WBPage
                        IF (LCNT > 0) THEN
                            next_state <= WBPGMS_WBLOAD;
                        ELSE
                            next_state <= WBPGMS_CONFB;
                        END IF;
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN WBPGMS_WBLOAD  =>
                IF falling_edge(write) THEN
                    IF (WPage = WBPage) THEN
                        IF (LCNT > 0) THEN
                            next_state <= WBPGMS_WBLOAD;
                        ELSE
                            next_state <= WBPGMS_CONFB;
                        END IF;
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN WBPGMS_CONFB   =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA) AND (DataLo = 16#29#) THEN
                        next_state <= PGMS; --WBPGMS
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN WBPGMS_WBABORT =>
                IF falling_edge(write) THEN
                    IF PATTERN_1 THEN
                        next_state <= WBPGMS_Z001;
                    END IF;
                END IF;

            WHEN WBPGMS_Z001    =>
                IF falling_edge(write) THEN
                    IF PATTERN_2 THEN
                        next_state <= WBPGMS_PREL;
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN WBPGMS_PREL    =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        IF ESP_ACT ='1' THEN
                            next_state <= ESP;
                        ELSIF ULBYPASS ='1' THEN
                            next_state <= PREL_ULBYPASS;
                        ELSIF OTP_ACT ='1' THEN
                            next_state <= OTP;
                        ELSE
                            next_state <= RESET;
                        END IF;
                    ELSE
                        next_state <= WBPGMS_WBABORT;
                    END IF;
                END IF;

            WHEN SERS_EXEC      =>
                IF rising_edge(EDONE) OR falling_edge(EERR) THEN
                    IF ULBYPASS = '1' THEN
                        next_state <= PREL_ULBYPASS;
                    ELSIF PPB_ACT = '1' THEN
                        next_state <= PPB_CMDSET;
                    ELSE
                        next_state <= RESET;
                        --report "Reset finished" severity note;
                    END IF;
                ELSIF EERR /= '1' THEN
                    IF falling_edge(write) THEN
                        IF DataLo=16#B0# THEN
                            next_state <= ESPS;
                        END IF;
                    END IF;
                END IF;

            WHEN ESP            =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#30# THEN
                        next_state <= SERS_EXEC;
                    ELSE
                        IF Addr = 16#55# AND DataLo = 16#98# THEN
                            next_state <= ESP_CFI;
                        ELSIF PATTERN_1 THEN
                            next_state <= ESP_Z001;
                        END IF;
                    END IF;
                END IF;

            WHEN ESP_Z001       =>
                IF falling_edge(write) THEN
                    IF PATTERN_2 THEN
                        next_state <= ESP_PREL;
                    ELSE
                        next_state <= ESP;
                    END IF;
                END IF;

            WHEN ESP_PREL       =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#25# THEN
                        --fix SA
                        next_state <= WBPGMS_WBCNT; --set ESP
                    ELSIF A_PAT_1 AND DataLo = 16#A0# THEN
                        next_state <= ESP_A0SEEN;
                    ELSIF A_PAT_1 AND DataLo = 16#88# THEN
                        next_state <= OTP; --set ESP
                    ELSIF A_PAT_1 AND DataLo = 16#90# THEN
                        next_state <= ESP_AS;
                    ELSE
                        next_state <= ESP;
                    END IF;
                END IF;

            WHEN ESP_CFI        =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        next_state <= ESP;
                    END IF;
                END IF;

            WHEN ESP_A0SEEN     =>
                IF falling_edge(write) THEN
                    next_state <= PGMS; --set ESP
                END IF;

            WHEN ESP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        -- reset ULBYPASS
                        next_state <= ESP;
                    END IF;
                END IF;

            WHEN PGMS           =>
                IF rising_edge(PDONE) OR falling_edge(PERR) THEN
                    IF ESP_ACT = '1' THEN
                        next_state <= ESP;
                    ELSIF LOCK_ACT = '1' THEN
                        next_state <= LOCKREG_CMDSET;
                    ELSIF PPB_ACT = '1' THEN
                        next_state <= PPB_CMDSET;
                    ELSIF PASS_ACT = '1' THEN
                        next_state <= PASS_CMDSET;
                    ELSIF ULBYPASS = '1' THEN
                        next_state <= PREL_ULBYPASS;
                    ELSIF OTP_ACT = '1' THEN
                        next_state <= OTP;
                    ELSE
                        next_state <= RESET;
                    END IF;
                ELSIF OTP_ACT = '1' THEN
                    null;
                ELSIF falling_edge(write) AND PERR /= '1' THEN
                    IF DataLo = 16#B0# THEN
                        next_state <= PSPS;
                    END IF;
                END IF;

            WHEN PSPS           =>
                IF sSTART_T1 = '1' THEN
                    next_state <= PSP;
                END IF;

            WHEN PSP            =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#30# THEN
                        next_state <= PGMS;
                    ELSIF Addr = 16#55# AND DataLo = 16#98# THEN
                        next_state <= PSP_CFI;
                    ELSIF PATTERN_1 THEN
                        next_state <= PSP_Z001;
                    END IF;
                END IF;

            WHEN PSP_CFI        =>
                IF falling_edge(write) THEN
                    IF Addr = 16#55# AND DataLo = 16#98# THEN
                        null;
                    ELSIF DataLo =16#F0# THEN
                        next_state <= PSP;
                    END IF;
                END IF;

            WHEN PSP_Z001       =>
                IF falling_edge(write) THEN
                    IF PATTERN_2 THEN
                        next_state <= PSP_PREL;
                    ELSE
                        next_state <= PSP;
                    END IF;
                END IF;

            WHEN PSP_PREL       =>
                IF falling_edge(write) THEN
                    IF A_PAT_1 AND DataLo = 16#90# THEN
                        next_state <= PSP_AS;
                    ELSIF A_PAT_1 AND DataLo =16#88# THEN
                        next_state <= OTP; --set PSP
                    ELSE
                        next_state <= PSP;
                    END IF;
                END IF;

            WHEN PSP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        -- reset ULBYPASS
                        next_state <= PSP;
                    END IF;
                END IF;

        END CASE;
        END IF;
    END PROCESS StateGen;

    ---------------------------------------------------------------------------
    --FSM Output generation and general functionality
    ---------------------------------------------------------------------------
    Functional : PROCESS(write, read, Addr, D_tmp0, D_tmp1, Address, SecAddr,
                         PDONE, EDONE, HANG, sSTART_T1, sCTMOUT, RST,
                         reseted, sREADY, gOE_n, current_state, UNLOCKDONE_out,
                         PBPROG_out)

        --Flash Memory Array
        TYPE SecType IS ARRAY (0 TO SecSize) OF INTEGER RANGE -1 TO MaxData;
        TYPE MemArray IS ARRAY (0 TO SecNum) OF SecType;
        --Common Flash Interface Query codes
        TYPE CFItype IS ARRAY (16#10# TO 16#50#) OF NATURAL RANGE 0 TO 16#FF#;
        --SecSi Sector
        TYPE SecSiType IS ARRAY (0 TO SecSiSize) OF INTEGER RANGE -1 TO MaxData;
        --WriteBuffer
        TYPE WBDataType IS ARRAY ( 0 TO 31) OF INTEGER RANGE -1 TO MaxData;
        TYPE WBAddrType IS ARRAY ( 0 TO 31) OF INTEGER RANGE -1 TO 31;

            -- Mem(SecAddr)(Address)....
        VARIABLE Mem         : MemArray := (OTHERS => (OTHERS => MaxData));
        VARIABLE CFI_array   : CFItype   := (OTHERS => 0);
        VARIABLE SecSi       : SecSiType := (OTHERS => 0);

        VARIABLE WBData      : WBDataType:= (OTHERS => 0);
        variable v_A : integer range -1 to MaxData;
        VARIABLE WBAddr      : WBAddrType:= (OTHERS => -1);

        VARIABLE BaseLoc     : NATURAL RANGE 0 TO SecSize := 0;

        VARIABLE cnt         : NATURAL RANGE 0 TO 31 := 0;

        VARIABLE PATTERN_1   : boolean := FALSE;
        VARIABLE PATTERN_2   : boolean := FALSE;
        VARIABLE A_PAT_1     : boolean := FALSE;

        VARIABLE oe          : boolean := FALSE;
        VARIABLE oe_toggle   : boolean := FALSE;
        --Status reg.
        VARIABLE Status      : std_logic_vector(7 downto 0) := (OTHERS => '0');

        VARIABLE PGMS_FLAG   : PgmsTargetType;

        VARIABLE PassMATCH   : PassUnlockType;

        -- text file input variables
        FILE prot_file       : text  is  prot_file_name;
        FILE mem_file        : text  is  mem_file_name;
        FILE secsi_file      : text  is  secsi_file_name;

        VARIABLE S_ind       : NATURAL RANGE 0 TO SecNum := 0;
        VARIABLE ind         : NATURAL := 0;
        VARIABLE index       : NATURAL RANGE 0 TO SecSize:=0;
        VARIABLE buf         : line;

        VARIABLE AddrHi      : NATURAL;
        VARIABLE AddrLo      : NATURAL;

        VARIABLE old_bit     : std_logic_vector(7 downto 0);
        VARIABLE new_bit     : std_logic_vector(7 downto 0);
        VARIABLE old_int     : INTEGER RANGE -1 to MaxData;
        VARIABLE new_int     : INTEGER RANGE -1 to MaxData;
        VARIABLE wr_cnt      : NATURAL RANGE 0 TO 31;

        VARIABLE PassAddr    : NATURAL RANGE 0 TO 7;

        VARIABLE old_PPB     : std_logic_vector(7 downto 0);

        --DATA  High Byte
        VARIABLE DataHi      : NATURAL RANGE 0 TO MaxData := 0;
        --DATA Low Byte
        VARIABLE DataLo      : NATURAL RANGE 0 TO MaxData := 0;

        VARIABLE PR_FLAG     : BOOLEAN := FALSE;
        VARIABLE ER_FLAG     : BOOLEAN := FALSE;

        VARIABLE temp        : std_logic_vector(7 downto 0);
        VARIABLE tempLo      : std_logic_vector(7 downto 0);
        VARIABLE SecSiAddr   : NATURAL RANGE 0 TO SecSiSize := 0;
    BEGIN
        -----------------------------------------------------------------------
        -- Functionality Section
        -----------------------------------------------------------------------
        IF falling_edge(write) THEN
            DataLo    := D_tmp0;
            DataHi    := D_tmp1;
            PATTERN_1 := (Addr=16#555#) AND (DataLo=16#AA#) ;
            PATTERN_2 := (Addr=16#2AA#) AND (DataLo=16#55#) ;
            A_PAT_1   := (Addr=16#555#);
        END IF;
        oe := rising_edge(read) OR (read = '1' AND Address'EVENT);
        oe_toggle := rising_edge(read);

        IF falling_edge(RST) AND RESETNeg = '0' THEN
            ULBYPASS <= '0';
            ESP_ACT <= '0';
            PSP_ACT <= '0';
            IF LockReg(0)(2) = '0' THEN
            -- password unlock needed to unfreeze PPBLock
                PPBLock := '0';--Password Sector Protection
            ELSE
                PPBLock := '1';-- Pesistent Protection
            -- PPBLOck cleared after hardware reset
            END IF;
            DYB := (OTHERS => '1');-- unprotected state 01h after hardware reset
            UNLOCKDONE_in <= '0';
            START_T1_in <= '0';
        END IF;

        IF reseted = '1' THEN
        CASE current_state IS
            WHEN RESET          =>
                OTP_ACT   <= '0';
                PSP_ACT   <= '0';
                ESP_ACT   <= '0';

                IF falling_edge(write) THEN
                    IF ((Addr=16#55#) AND (DataLo=16#98#))THEN
                        ULBYPASS <= '0';
                    END IF;
                ELSIF oe THEN
                    DOut_zd(7 downto 0) <= READMEM(Mem(SecAddr)(Address));
                    --report "Memory read" & i2s(Mem(SecAddr)(Address),9) severity note;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <=
                                        READMEM(Mem(SecAddr)(Address + 1));
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN Z001           =>
                null;

            WHEN PREL_SETBWB    =>
                IF falling_edge(write) THEN
                    IF (A_PAT_1 AND (DataLo = 16#20#)) THEN
                        ULBYPASS <= '1';
                    ELSIF (A_PAT_1 AND (DataLo = 16#90#)) THEN
                        ULBYPASS <= '0';
                    ELSIF (A_PAT_1 AND (DataLo = 16#88#)) THEN
                        ULBYPASS <= '0';
                        OTP_ACT  <= '1';
                    ELSIF (DataLo=16#25#) THEN
                        --fix Sector Address SA
                        SA <= SecAddr;
                    END IF;
                END IF;

            WHEN PREL_ULBYPASS  =>
                IF falling_edge(write) THEN
                    IF (DataLo=16#25#) THEN
                        --fix Sector Address  SA
                        SA <= SecAddr;
                    END IF;
                ELSIF oe THEN
                    DOut_zd(7 downto 0) <= READMEM(Mem(SecAddr)(Address));
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <=
                                        READMEM(Mem(SecAddr)(Address + 1));
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN EXIT_ULBYPASS =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        ULBYPASS <= '0';
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN CFI            =>
                IF falling_edge(write) THEN
                    IF (DataLo=16#F0#) THEN
                        ULBYPASS  <= '0';
                    END IF;
                ELSIF oe THEN
                    DOut_zd(15 downto 0) <= (OTHERS => '0');
                    IF ((Addr>=16#10#) AND (Addr <= 16#50#)) THEN
                        DOut_zd(7 downto 0) <= to_slv(CFI_array(Addr) ,8);
                    ELSE
                        ASSERT FALSE
                            REPORT "Invalid CFI query address"
                            SEVERITY warning;
                    END IF;
                END IF;

            WHEN AS             =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#F0#) THEN
                        ULBYPASS  <= '0';
                    END IF;
                ELSIF oe THEN
                    IF BYTENeg = '1' THEN
                        IF Address = 0 THEN
                            DOut_zd(15 downto 8) <= to_slv(0,8);
                        ELSE
                            DOut_zd(15 downto 8) <= to_slv(16#22#,8);
                        END IF;
                    ELSE
                        DOut_zd(15 downto 8) <= "ZZZZZZZZ";
                    END IF;

                    IF Addr = 0 THEN
                        DOut_zd(7 downto 0) <= to_slv(1,8);
                    ELSIF Addr = 1 THEN
                        DOut_zd(7 downto 0) <= to_slv(16#7E#,8);
                    ELSIF Addr = 2 THEN
                        DOut_zd(7 downto 1) <= to_slv(0,7);
                        IF ( DYB(SecAddr) = '1' AND
                        PPB(SecAddr) = '1' ) THEN
                            DOut_zd(0) <= '0'; --unprotected (inverted statuses)
                        ELSE
                            DOut_zd(0) <= '1'; -- protected(inverted statuses)
                        END IF;
                    ELSIF Addr = 3 THEN
                        DOut_zd(7 downto 0) <= to_slv(10,8);
                        IF ProtSecNum > 0 THEN
                            --Highest Address Sector Protected by WP#
                            DOut_zd(4) <= '1';
                        END IF;
                        IF FactoryProt = '1' THEN
                            DOut_zd(7) <= '1';
                        END IF;
                    ELSIF Addr = 16#E# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1D#,8);
                        ELSIF TimingModel(16) = '3' OR TimingModel(16) = '4'
                        THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1A#,8);
                        END IF;
                    ELSIF Addr = 16#F# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        ELSIF TimingModel(16) = '3' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#01#,8);
                        ELSIF TimingModel(16) = '4' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        END IF;
                    END IF;
                END IF;

            WHEN LOCKREG_CMDSET =>
                IF oe THEN
                    IF (Addr = 16#00#) THEN
                        DOut_zd(7 downto 0) <= LockReg(0);-- lower byte

                        IF BYTENeg = '1' THEN
                            DOut_zd(15 downto 8) <= LockReg(1); -- upper byte
                        END IF;
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN LOCKREG_A0SEEN =>
                IF falling_edge(WRITE) THEN
                    tempLo := to_slv(DataLo, 8);
                    IF  NOT(temp(1) = '0' AND temp(2) = '0') THEN
                        PSTART <= '1', '0' AFTER 1 ns;
                        PSUSP <= '0';
                        PRES <= '0';
                        PCNT   <= 32;

                        IF tempLo(1) = '0' AND LockReg(0)(2) = '0' THEN
                            -- Can not program SPMLB if PPMLB programmed
                            tempLo(1) := '1';
                        ELSIF tempLo(2) = '0' AND LockReg(0)(1) = '0' THEN
                            -- Can not program PPMLB if SPMLB programmed
                            tempLo(2) := '1';
                        END IF;
                        WBData(0) := -1;
                        WBData(1) := -1;
                        IF Viol = '0' THEN
                            WBData(0) := to_nat(tempLo);
                            WBData(1) := DataHi;
                        END IF;
                        WBAddr(0) := 0; --- Addr don't care XXX
                        PGMS_FLAG := LREG;
                        PR_FLAG := FALSE;
                        WBPage <= WPage;
                        SA <= SecAddr;
                        temp := to_slv(DataLo, 8);
                        Status(7) := NOT temp(7);

                        IF BYTENeg = '1' THEN
                            WBAddr(1) := WBAddr(0) +1;
                        ELSE
                            WBAddr(1) := -1;
                        END IF;
                    END IF;
                END IF;

            WHEN EXIT_LOCKREG =>
                NULL;

            WHEN PPB_CMDSET =>
                IF oe THEN
                    DOut_zd(7 downto 1) <= (OTHERS => '0');
                    DOut_zd(0) <= PPB(SecAddr);

                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN PPB_A0SEEN =>
                IF falling_edge(write) THEN
                    PSTART <= '1', '0' AFTER 1 ns;
                    PSUSP <= '0';
                    PRES <= '0';
                    PCNT   <= 32;

                    WBAddr(0) := 0; --- Addr don't care XXX
                    WBAddr(1) := -1;
                    WBData(0) := -1;
                    WBData(1) := -1;
                    IF Viol = '0' THEN
                        WBData(0) := 1;
                    END IF;

                    PGMS_FLAG := PPB_BIT;
                    PR_FLAG := FALSE;
                    WBPage <= WPage;
                    SA <= SecAddr;
                    temp := to_slv(DataLo, 8);
                    Status(7) := NOT temp(7);
                END IF;

            WHEN PPB_80SEEN =>
                IF falling_edge(write) THEN
                    IF DataLo=16#30#  AND Addr=16#00# THEN
                        --start timeout
                        CTMOUT_in <= '0', '1' AFTER 1 ns;
                    END IF;
                END IF;

            WHEN EXIT_PPB =>
                NULL;

            WHEN DYB_CMDSET =>
                IF oe THEN
                    DOut_zd(7 downto 1) <= (OTHERS => '0');
                    DOut_zd(0) <= DYB(SecAddr);

                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;

            WHEN DYB_SETCLEAR =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#00# THEN
                        DYB(SecAddr) := '0';
                    ELSIF DataLo = 16#01# THEN
                        DYB(SecAddr) := '1';
                    END IF;
                END IF;

            WHEN EXIT_DYB =>
                NULL;

            WHEN PPBLOCK_CMDSET =>
                IF oe THEN
                    DOut_zd(7 downto 1) <= (OTHERS => '0');
                    DOut_zd(0) <= PPBLock;

                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;

            WHEN PPBLOCK_A0SEEN =>
                IF falling_edge(write) THEN
                    IF (DataLo = 16#00#) THEN
                        PBPROG_in <= '0', '1' AFTER 1 ns;
                    END IF;
                END IF;

            WHEN PPBLOCK_SET =>
                IF rising_edge(PBPROG_out) THEN
                    PPBLock := '0';
                    PBPROG_in <= '0';
                END IF;

            WHEN EXIT_PPBLOCK =>
                NULL;

            WHEN PASS_CMDSET =>
                IF oe THEN
                    IF LockReg(0)(2) /= '0' THEN
                        DOut_zd(7 downto 0) <= Password(Address mod 8);
                    ELSE
                        DOut_zd(7 downto 0) <= (OTHERS => '1');
                    END IF;

                    IF BYTENeg = '1' THEN
                        IF LockReg(0)(2) /= '0' THEN
                            DOut_zd(15 downto 8) <= Password((Address mod 8)+1);
                        ELSE
                            DOut_zd(15 downto 8) <= (OTHERS => '1');
                        END IF;
                    END IF;

                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN PASS_A0SEEN =>
                IF falling_edge(write) THEN
                    PSTART <= '1', '0' AFTER 1 ns;
                    PSUSP <= '0';
                    PRES <= '0';
                    PCNT   <= 32;

                    WBData(0) := -1;
                    WBData(1) := -1;
                    IF Viol = '0' THEN
                        WBData(0) := DataLo;
                        WBData(1) := DataHi;
                    END IF;

                    WBAddr(0) := Address MOD 8;
                    PGMS_FLAG := PASSW;
                    PR_FLAG := FALSE;

                    SA <= SecAddr;
                    temp := to_slv(DataLo, 8);
                    Status(7) := NOT temp(7);

                    IF BYTENeg = '1' THEN
                        WBAddr(1) := WBAddr(0) +1;
                    ELSE
                        WBAddr(1) := -1;
                    END IF;
                END IF;

            WHEN PASSUNLOCK1 =>
                PassMATCH := (FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);

            WHEN PASSUNLOCK2 | PASSUNLOCK3 | PASSUNLOCK4 | PASSUNLOCK5 =>
                IF falling_edge(write) THEN
                    PassAddr := (Address mod 16#100#) mod 8;
                    IF BYTENeg = '1' THEN
                        PassMATCH(PassAddr) :=
                        to_nat(Password(PassAddr)) = DataLo;
                        PassMATCH(PassAddr+1) :=
                        to_nat(Password(PassAddr+1)) = DataHi;
                    ELSE
                        PassMATCH(PassAddr) :=
                        to_nat(Password(PassAddr)) = DataLo;
                    END IF;
                END IF;

            WHEN PASSUNLOCK6 =>
                IF falling_edge(write) THEN
                    IF BYTENeg = '1' AND Addr = 16#00# AND DataLo = 16#29# THEN
                        UNLOCKDONE_in <= '0', '1' AFTER 1 ns;
                    ELSIF BYTENeg = '0' THEN
                        PassAddr := (Address mod 16#100#) mod 8;
                        PassMATCH(PassAddr) :=
                        to_nat(Password(PassAddr)) = DataLo;
                    END IF;
                END IF;

            WHEN PASSUNLOCK7 | PASSUNLOCK8| PASSUNLOCK9 =>
                IF falling_edge(write) THEN
                    PassAddr := (Address mod 16#100#) mod 8;
                    PassMATCH(PassAddr) :=
                    to_nat(Password(PassAddr)) = DataLo;
                END IF;

            WHEN PASSUNLOCK10 =>
                IF falling_edge(write) AND Addr = 16#00#
                AND DataLo = 16#29# THEN
                    UNLOCKDONE_in <= '0', '1' AFTER 1 ns;
                END IF;

            WHEN PASSUNLOCK =>
                IF rising_edge(UNLOCKDONE_out) AND
                PassMATCH = (TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE) THEN
                    PPBLock := '1';
                END IF;

            WHEN EXIT_PASS =>
                NULL;

            WHEN A0SEEN         =>
                IF falling_edge(write) THEN
                    PSTART <= '1', '0' AFTER 1 ns;
                    PSUSP  <= '0';
                    PRES   <= '0';
                    PCNT   <= 32;

                    PGMS_FLAG := MEMORY;
                    PR_FLAG := FALSE;

                    WBData(0) := -1;
                    WBData(1) := -1;
                    IF Viol = '0' THEN
                        WBData(0) := DataLo;
                        WBData(1) := DataHi;
                    END IF;
                    WBAddr(0) := Address MOD 32;
                    WBPage <= WPage;
                    SA <= SecAddr;
                    temp := to_slv(DataLo, 8);
                    Status(7) := NOT temp(7);

                    IF BYTENeg = '1' THEN
                        WBAddr(1) := WBAddr(0) +1;
                    ELSE
                        WBAddr(1) := -1;
                    END IF;
                END IF;

            WHEN OTP            =>
                OTP_ACT <= '1';
                IF oe THEN
                    --read SecSi Sector Region
                    SecSiAddr := Address MOD (SecSiSize + 1);
                    DOut_zd(7 downto 0) <= (OTHERS => 'X');
                    IF SecSi(SecSiAddr) /= -1 THEN
                        DOut_zd(7 downto 0) <= to_slv(SecSi(SecSiAddr),8);
                    END IF;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => 'X');
                        IF SecSi(SecSiAddr + 1) /= -1 THEN
                            DOut_zd(15 downto 8)
                                    <= to_slv(SecSi(SecSiAddr + 1),8);
                        END IF;
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN OTP_Z001       =>
                null;

            WHEN OTP_PREL       =>
                IF falling_edge(write) THEN
                    IF (A_PAT_1 AND (DataLo = 16#90#))THEN
                        ULBYPASS <= '0';
                    ELSIF DataLo = 16#25# THEN
                        --fix Sector Address  SA
                        SA <= 0;
                        ASSERT SecAddr=0
                            REPORT "Invalid sector address in SecSi mode"
                            SEVERITY warning;
                        --activate OTP
                        OTP_ACT <= '1';
                    END IF;
                END IF;

            WHEN OTP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo=16#F0#  OR DataLo=16#00# THEN
                        OTP_ACT <='0';
                        IF (PSP_ACT = '1' OR ESP_ACT = '1') THEN
                            ULBYPASS  <= '0';
                        END IF;
                    END IF;
                ELSIF oe THEN
                    IF BYTENeg = '1' THEN
                        IF Address = 0 THEN
                            DOut_zd(15 downto 8) <= to_slv(0,8);
                        ELSE
                            DOut_zd(15 downto 8) <= to_slv(16#22#,8);
                        END IF;
                    ELSE
                        DOut_zd(15 downto 8) <= "ZZZZZZZZ";
                    END IF;

                    IF Addr = 0 THEN
                        DOut_zd(7 downto 0) <= to_slv(1,8);
                    ELSIF Addr = 1 THEN
                        DOut_zd(7 downto 0) <= to_slv(16#7E#,8);
                    ELSIF Addr = 2 THEN
                        DOut_zd(7 downto 1) <= to_slv(0,7);
                        IF ( DYB(SecAddr) = '1' AND
                        PPB(SecAddr) = '1' ) THEN
                            DOut_zd(0) <= '0'; --unprotected (inverted statuses)
                        ELSE
                            DOut_zd(0) <= '1'; -- protected(inverted statuses)
                        END IF;
                    ELSIF Addr = 3 THEN
                        DOut_zd(7 downto 0) <= to_slv(10,8);
                        IF ProtSecNum > 0 THEN
                            --Highest Address Sector Protected by WP#
                            DOut_zd(4) <= '1';
                        END IF;
                        IF FactoryProt = '1' THEN
                            DOut_zd(7) <= '1';
                        END IF;
                    ELSIF Addr = 16#E# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1D#,8);
                        ELSIF TimingModel(16) = '3' OR TimingModel(16) = '4'
                        THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1A#,8);
                        END IF;
                    ELSIF Addr = 16#F# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        ELSIF TimingModel(16) = '3' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#01#,8);
                        ELSIF TimingModel(16) = '4' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        END IF;
                    END IF;
                END IF;

            WHEN OTP_A0SEEN     =>
                IF falling_edge(write) THEN
                    OTP_ACT <= '1';
                    -----------------------------------------------------------
                    --SecSi programming: TBD
                    -----------------------------------------------------------
                    PSTART <= '1', '0' AFTER 1 ns;
                    PSUSP  <= '0';
                    PRES   <= '0';
                    PCNT   <= 32;

                    PGMS_FLAG := OTP;
                    PR_FLAG := FALSE;

                    WBData(0) := -1;
                    WBData(1) := -1;
                    IF Viol = '0' THEN
                        WBData(0) := DataLo;
                        WBData(1) := DataHi;
                    END IF;
                    WBAddr(0) := Address MOD 32;
                    WBPage <= WPage MOD 8;

                    SA <= 0;
                    ASSERT SecAddr =0
                        REPORT "Invalid sector Address in SecSi"
                        SEVERITY warning;

                    ASSERT Address < 256
                        REPORT "Invalid program address in SecSi region. "&
                               "Adress= "& to_int_str(Address)
                        SEVERITY warning;

                    temp := to_slv(DataLo, 8);
                    Status(7) := NOT temp(7);

                    IF BYTENeg = '1' THEN
                        WBAddr(1) := WBAddr(0) + 1;
                    ELSE
                        WBAddr(1) := -1;
                    END IF;
                END IF;

            WHEN C8             =>
                NULL;

            WHEN C8_Z001        =>
                NULL;

            WHEN C8_PREL        =>
                IF falling_edge(write) THEN
                    IF ( A_PAT_1 OR ULBYPASS = '1' ) AND DataLo=16#10# THEN
                        --Start Chip Erase
                        ESTART <= '1', '0' AFTER 1 ns;
                        ESUSP  <= '0';
                        ERES   <= '0';
                        Ers_Queue <= (OTHERS => '1');
                        Status := "00001000";
                        ER_FLAG := FALSE;
                    ELSIF DataLo=16#30# THEN
                        --put selected sector to sec. ers. queue
                        --start timeout
                        Ers_Queue <= (OTHERS => '0');
                        Ers_Queue(SecAddr) <= '1';
                        ER_FLAG := FALSE;
                        CTMOUT_in <= '0', '1' AFTER 1 ns;
                    END IF;
                END IF;

            WHEN ERS            =>
                IF oe_toggle THEN
                    -----------------------------------------------------------
                    -- read status / embeded erase algorithm - Chip Erase
                    -----------------------------------------------------------
                    Status(7) := '0';
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    Status(3) := '1';
                    Status(2) := NOT Status(2); --toggle

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;

                END IF;
                IF EERR /= '1' THEN
                    IF NOT ER_FLAG THEN
                        ER_FLAG:= TRUE;
                        FOR i IN 0 TO SecNum LOOP
                            IF (DYB(i) = '1' AND PPB(i) = '1'
                            AND NOT(WPNeg = '0' AND (i = ProtSecNum OR
                            i = ProtSecNum1) ) ) THEN
                              --report "Memory written 1" severity note;
                                Mem(i) := (OTHERS => -1);
                            END IF;
                        END LOOP;
                    END IF;
                    IF EDONE = '1' THEN
                        ER_FLAG:= FALSE;
                        FOR i IN 0 TO SecNum LOOP
                            IF (DYB(i) = '1' AND PPB(i) = '1'
                            AND NOT (WPNeg = '0' AND (i = ProtSecNum OR
                                                      i = ProtSecNum1) ) ) THEN
                              --report "Memory written 2" severity note;
                                Mem(i) := (OTHERS => MaxData);
                            END IF;
                        END LOOP;
                    END IF;
                END IF;
                -- busy signal active
                RY_zd <= '0';

            WHEN SERS           =>
                IF sCTMOUT = '1' THEN
                    CTMOUT_in <= '0';
                    START_T1_in <= '0';
                    ESTART <= '1', '0' AFTER 1 ns;
                    ESUSP  <= '0';
                    ERES   <= '0';

                ELSIF falling_edge(write) THEN
                    IF (DataLo = 16#B0#) THEN
                        --need to start erase process prior to suspend
                        ESTART <= '1', '0' AFTER 1 ns;
                        ESUSP  <= '0';
                        ERES   <= '0';
                        --suspend timeout (should be 0 according to datasheet)
                        ESUSP <= '1' AFTER 2 ns, '0' AFTER 3 ns;
                    ELSIF (DataLo=16#30#) THEN
                        CTMOUT_in <= '0', '1' AFTER 1 ns;
                        Ers_Queue(SecAddr) <= '1';
                    END IF;
                ELSIF oe THEN
                    -----------------------------------------------------------
                    --read status - sector erase timeout
                    -----------------------------------------------------------
                    Status(3) := '0';

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN ESPS           =>
                IF (sSTART_T1 = '1') THEN
                    ESP_ACT <= '1';
                    START_T1_in <= '0';
                ELSIF oe_toggle THEN
                    -----------------------------------------------------------
                    --read status / erase suspend timeout - stil erasing
                    -----------------------------------------------------------
                    Status(7) := '0';
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    Status(3) := '1';
                    IF Ers_Queue(SecAddr) = '1' THEN
                        Status(2) := NOT Status(2); --toggle
                    END IF;

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;

                END IF;
                --busy signal active
                RY_zd <= '0';

            WHEN WBPGMS_WBCNT   =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA)AND
                    ((BYTENeg = '0' AND DataLo < 32) OR
                    (BYTENeg = '1'AND DataLo < 16)) THEN
                        cnt := DataLo;
                        IF BYTENeg = '1' THEN
                            cnt := cnt * 2;
                        END IF;
                        PCNT <= cnt;
                        LCNT <= cnt;
                    END IF;
                END IF;

            WHEN WBPGMS_WBLSTA  =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA) THEN -- fix WriteBufferPage  WBPage
                        WBData(cnt) := -1;
                        IF Viol = '0' THEN
                            WBData(cnt) := DataLo;
                        END IF;
                        WBAddr(cnt) := Address MOD 32;
                        IF BYTENeg = '1'  THEN
                            WBData(cnt + 1) := -1;
                            IF Viol = '0' THEN
                                WBData(cnt + 1) := DataHi;
                            END IF;
                            WBAddr(cnt + 1) := (Address MOD 32) +1;
                            IF cnt > 0 THEN
                                cnt := cnt -1;
                            END IF;
                        END IF;
                        IF cnt > 0 THEN
                            cnt := cnt -1;
                        END IF;

                        --save last loaded data for data polling
                        temp := to_slv(DataLo, 8);
                        Status(7) := NOT temp(7);

                        IF OTP_ACT = '1' THEN
                            WBPage <= WPage MOD 8;
                            ASSERT WPage<8
                                REPORT "Invalid Write Buffer Page selected in "&
                                        " SecSi"
                                SEVERITY warning;
                        ELSE
                            WBPage <= WPage;
                        END IF;
                    END IF;
                    LCNT <= cnt;
                END IF;

            WHEN WBPGMS_WBLOAD  =>
                IF falling_edge(write) THEN
                    IF (WPage = WBPage) THEN
                        WBData(cnt) := -1;
                        IF Viol = '0' THEN
                            WBData(cnt) := DataLo;
                        END IF;
                        WBAddr(cnt) := Address MOD 32;
                        IF BYTENeg = '1'  THEN
                            WBData(cnt + 1) := -1;
                            IF Viol = '0' THEN
                                WBData(cnt + 1) := DataHi;
                            END IF;
                            WBAddr(cnt + 1) := (Address MOD 32) + 1;
                            IF cnt > 0 THEN
                                cnt := cnt - 1;
                            END IF;
                        END IF;
                        IF cnt > 0 THEN
                            cnt := cnt - 1;
                        END IF;
                        --save last loaded data for data polling

                        temp := to_slv(DataLo, 8);
                        Status(7) := NOT temp(7);
                    END IF;
                    LCNT <= cnt;
                END IF;

            WHEN WBPGMS_CONFB   =>
                IF falling_edge(write) THEN
                    IF (SecAddr = SA) AND (DataLo = 16#29#) THEN
                        PSTART <= '1', '0' AFTER 1 ns;
                        PSUSP  <= '0';
                        PRES   <= '0';
                        IF OTP_ACT = '1' THEN
                            PGMS_FLAG := OTP;
                        ELSE
                            PGMS_FLAG := MEMORY;
                        END IF;
                        PR_FLAG := FALSE;
                    END IF;
                END IF;

            WHEN WBPGMS_WBABORT =>
                IF oe_toggle THEN
                ---------------------------------------------------------------
                --read status / write buffer abort
                ---------------------------------------------------------------
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    Status(1) := '1';

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;

                END IF;
                --busy signal active
                RY_zd <= '0';

            WHEN WBPGMS_Z001    =>
                null;

            WHEN WBPGMS_PREL    =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        PSP_ACT <= '0';
                    END IF;
                END IF;

            WHEN SERS_EXEC      =>
                IF oe_toggle THEN
                    -----------------------------------------------------------
                    --read status Erase Busy
                    -----------------------------------------------------------
                    Status(7) := '0';
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    Status(3) := '1';
                    IF Ers_Queue(SecAddr) = '1' THEN
                        Status(2) := NOT Status(2); --toggle
                    END IF;

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;
                IF EERR /= '1' THEN
                    IF NOT ER_FLAG THEN
                        ER_FLAG:= TRUE;
                        IF PPB_ACT = '0' THEN
                            FOR i IN Ers_Queue'RANGE LOOP
                                IF Ers_Queue(i) = '1' AND
                                (DYB(i) = '1' AND PPB(i) = '1'
                                AND NOT (WPNeg='0' AND (i =ProtSecNum OR
                                i =ProtSecNum1) ) ) THEN
                                  --report "Memory written 3" severity note;
                                    Mem(i) := (OTHERS => -1);
                                END IF;
                            END LOOP;
                        ELSE
                            IF PPBLock = '1' THEN
                                PPB := (OTHERS => 'X');
                            END IF;
                        END IF;
                    END IF;

                    IF EDONE = '1' THEN
                        ER_FLAG:= FALSE;
                        IF PPB_ACT = '0' THEN
                            FOR i IN Ers_Queue'RANGE LOOP
                                IF Ers_Queue(i) = '1' AND
                                (DYB(i) = '1' AND PPB(i) = '1'
                                AND NOT (WPNeg = '0' AND (i = ProtSecNum OR
                                i = ProtSecNum1) ) ) THEN
                                  --report "Memory written 4" severity note;
                                    Mem(i) := (OTHERS => MaxData);
                                END IF;
                            END LOOP;
                        ELSE
                            IF PPBLock = '1' THEN
                                PPB := (OTHERS => '1');
                            END IF;
                        END IF;
                    ELSIF falling_edge(write) THEN
                        IF DataLo=16#B0# THEN
                            START_T1_in <= '1';
                            ESUSP <= '1', '0' AFTER 1 ns;
                        END IF;
                    END IF;
                END IF;
                --busy signal active
                RY_zd <= '0';

            WHEN ESP            =>
                ESUSP <= '0';
                IF falling_edge(write) THEN
                    IF DataLo = 16#30# THEN
                        --resume erase
                        ERES <= '1', '0' AFTER 1 ns;
                    END IF;
                ELSIF oe THEN
                    -----------------------------------------------------------
                    --read
                    -----------------------------------------------------------
                    IF Ers_Queue(SecAddr) /= '1' THEN
                        DOut_zd(7 downto 0) <= READMEM(Mem(SecAddr)(Address));
                        IF BYTENeg = '1' THEN
                            DOut_zd(15 downto 8) <=
                                        READMEM(Mem(SecAddr)(Address + 1));
                        END IF;
                    ELSE
                        -------------------------------------------------------
                        --read status
                        -------------------------------------------------------
                        Status(7) := '1';
                        -- Status(6) No toggle
                        Status(5) := '0';
                        IF oe_toggle THEN
                            Status(2) := NOT Status(2); --toggle
                        END IF;

                        DOut_zd(7 downto 0) <= Status;
                        IF BYTENeg = '1' THEN
                            DOut_zd(15 downto 8) <= (OTHERS => '0');
                        END IF;

                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN ESP_Z001       =>
                null;

            WHEN ESP_PREL       =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#25# THEN
                        --fix SA
                        SA <= SecAddr;
                        ESP_ACT <= '1';
                    ELSIF A_PAT_1 AND DataLo = 16#88# THEN
                        ESP_ACT <= '1';
                    END IF;
                END IF;

            WHEN ESP_CFI        =>
                IF falling_edge(write) THEN
                    IF Addr = 16#55# AND DataLo = 16#98# THEN
                        null;
                    ELSIF DataLo = 16#F0# THEN
                        ESP_ACT <= '1';
                    ELSE
                        ESP_ACT <= '1';
                    END IF;
                ELSIF oe THEN
                    DOut_zd(15 downto 0) <= (OTHERS => '0');
                    IF ((Addr >= 16#10#) AND (Addr<=16#50#)) THEN
                        DOut_zd(7 downto 0) <= to_slv(CFI_array(Addr) ,8);
                    ELSE
                        ASSERT FALSE
                            REPORT "Invalid CFI query address"
                            SEVERITY warning;
                    END IF;
                END IF;

            WHEN ESP_A0SEEN     =>
                IF falling_edge(write) THEN
                    ESP_ACT <= '1';
                    PSTART <= '1', '0' AFTER 1 ns;
                    PRES   <= '0';
                    PSUSP  <= '0';
                    PCNT   <= 32;

                    WBData(0) := -1;
                    WBData(1) := -1;
                    IF Viol = '0' THEN
                        WBData(0) := DataLo;
                        WBData(1) := DataHi;
                    END IF;
                    WBAddr(0) := Address MOD 32;
                    WBPage <= WPage;
                    SA <= SecAddr;

                    PGMS_FLAG := MEMORY;
                    PR_FLAG := FALSE;

                    temp := to_slv(DataLo, 8);
                    Status(7) := NOT temp(7);

                    IF BYTENeg = '1' THEN
                        WBAddr(1) := WBAddr(0) + 1;
                    ELSE
                        WBAddr(1) := -1;
                    END IF;
                END IF;

            WHEN ESP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        -- reset ULBYPASS
                        ULBYPASS <= '0';
                    END IF;
                ELSIF oe THEN
                    IF BYTENeg = '1' THEN
                        IF Address = 0 THEN
                            DOut_zd(15 downto 8) <= to_slv(0,8);
                        ELSE
                            DOut_zd(15 downto 8) <= to_slv(16#22#,8);
                        END IF;
                    ELSE
                        DOut_zd(15 downto 8) <= "ZZZZZZZZ";
                    END IF;

                    IF Addr = 0 THEN
                        DOut_zd(7 downto 0) <= to_slv(1,8);
                    ELSIF Addr = 1 THEN
                        DOut_zd(7 downto 0) <= to_slv(16#7E#,8);
                    ELSIF Addr = 2 THEN
                        DOut_zd(7 downto 1) <= to_slv(0,7);
                        IF ( DYB(SecAddr) = '1' AND PPB(SecAddr) = '1' ) THEN
                            DOut_zd(0) <= '0'; --unprotected (inverted statuses)
                        ELSE
                            DOut_zd(0) <= '1'; --protected(inverted statuses)
                        END IF;
                    ELSIF Addr = 3 THEN
                        DOut_zd(7 downto 0) <= to_slv(10,8);
                        IF ProtSecNum > 0 THEN
                            --Highest Address Sector Protected by WP#
                            DOut_zd(4) <= '1';
                        END IF;
                        IF FactoryProt = '1' THEN
                            DOut_zd(7) <= '1';
                        END IF;
                    ELSIF Addr = 16#E# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1D#,8);
                        ELSIF TimingModel(16) = '3' OR TimingModel(16) = '4'
                        THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1A#,8);
                        END IF;
                    ELSIF Addr = 16#F# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        ELSIF TimingModel(16) = '3' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#01#,8);
                        ELSIF TimingModel(16) = '4' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        END IF;
                    END IF;
                END IF;

            WHEN PGMS           =>
                IF oe_toggle THEN
                    -----------------------------------------------------------
                    --read status
                    -----------------------------------------------------------
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    --Status(2) no toggle
                    Status(1) := '0';
                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;
                END IF;

                IF PERR /= '1' THEN
                    IF NOT PR_FLAG THEN
                        PR_FLAG:=TRUE;
                        BaseLoc := WBPage * 32;

                        IF PCNT < 32 THEN --buffer
                            wr_cnt := PCNT;
                            IF BYTENeg = '1' THEN
                                wr_cnt := wr_cnt + 1;
                            END IF;
                        ELSE   --Word/Byte program
                            IF WBAddr(1) < 0 THEN
                                wr_cnt := 0;
                            ELSE
                                wr_cnt := 1;
                            END IF;
                        END IF;
                        FOR i IN wr_cnt downto 0 LOOP
                            new_int :=  WBData(i);
                            IF WBAddr(i) < 0 THEN
                                old_int := -1;
                            ELSIF PGMS_FLAG = MEMORY THEN --mem write
                                old_int := Mem(SA)(BaseLoc+WBAddr(i));
                            ELSIF PGMS_FLAG = OTP THEN
                                old_int := SecSi(BaseLoc+WBAddr(i));
                            ELSIF PGMS_FLAG = PASSW THEN
                                old_bit := Password(WBAddr(i));
                            ELSIF PGMS_FLAG = LREG THEN
                                old_bit := LockReg(i);
                            ELSIF PGMS_FLAG = PPB_BIT THEN
                                old_bit(0) := PPB(SA);
                            END IF;

                            IF new_int > -1 THEN
                                new_bit := to_slv(new_int,8);
                                IF (PGMS_FLAG = OTP OR
                                PGMS_FLAG = MEMORY) AND (old_int>-1) THEN
                                    old_bit := to_slv(old_int,8);
                                    FOR j IN 0 TO 7 LOOP
                                        IF old_bit(j) = '0' THEN
                                            new_bit(j) := '0';
                                        END IF;
                                    END LOOP;
                                ELSIF (PGMS_FLAG = PASSW OR
                                PGMS_FLAG = LREG) AND (old_bit(0)/='X') THEN
                                    FOR j IN 0 TO 7 LOOP
                                         IF old_bit(j) = '0' THEN
                                            new_bit(j) := '0';
                                        END IF;
                                    END LOOP;
                                ELSIF PGMS_FLAG = PPB_BIT THEN
                                    IF old_bit(0) = '0' THEN
                                        new_bit(0) := '0'; --PPB_FLAG
                                    END IF;
                                    new_bit(7 downto 1) := (others => '0');
                                ELSE
                                    new_bit(0) := 'X';
                                END IF;
                                IF new_bit(0)/='X' THEN
                                    new_int := to_nat(new_bit);
                                    WBData(i) := new_int;
                                ELSE
                                    WBData(i) := -1;
                                END IF;
                            ELSE
                                WBData(i) := -1;
                            END IF;
                        END LOOP;

                        FOR i IN wr_cnt downto 0 LOOP
                            IF PGMS_FLAG = MEMORY THEN --mem write
                                  --report "Memory written 5" severity note;
                                Mem(SA)(BaseLoc + WBAddr(i)) := -1;
                            ELSIF PGMS_FLAG = OTP THEN
                                SecSi(BaseLoc + WBAddr(i))   := -1;
                            ELSIF PGMS_FLAG = PASSW THEN
                                Password(WBAddr(i)) := (OTHERS => 'X');
                            ELSIF PGMS_FLAG = LREG THEN
                                LockReg(i) := (OTHERS => 'X');
                            ELSIF PGMS_FLAG = PPB_BIT THEN
                                PPB(SA) := 'X';
                            END IF;
                        END LOOP;
                    END IF;

                    IF HANG /= '1' AND PDONE = '1' AND (NOT PERR'EVENT) THEN
                        PR_FLAG :=FALSE;
                        FOR i IN wr_cnt downto 0 LOOP
                            IF WBAddr(i) > -1 AND WBdata(i) > -1 THEN
                                IF PGMS_FLAG = MEMORY THEN --mem write
                                    Mem(SA)(BaseLoc + WBAddr(i)) := WBData(i);
                                    v_A := WBData(i);
                                    --report "Memory written" & i2s(WBData(i),9) severity note;
                                ELSIF PGMS_FLAG = OTP THEN --SecSi write
                                    SecSi(BaseLoc+WBAddr(i)) := WBData(i);
                                ELSIF PGMS_FLAG = LREG THEN
                                    LockReg(i) := to_slv(WBData(i),8);
                                ELSIF PGMS_FLAG = PASSW THEN
                                    Password(WBAddr(i)) := to_slv(WBData(i),8);
                                ELSIF PGMS_FLAG = PPB_BIT THEN
                                    IF PPBLock = '1' THEN
                                        PPB(SA) := '0';
                                    ELSE
                                        old_PPB :=  to_slv(WBData(i),8);
                                        PPB(SA) := old_PPB(0);
                                    END IF;
                                END IF;
                            END IF;
                            WBData(i) := -1;
                        END LOOP;

                    ELSIF falling_edge(write) THEN
                        IF DataLo = 16#B0# THEN
                            START_T1_in <= '1';
                        END IF;
                    END IF;
                END IF;
                --busy signal active
                RY_zd <= '0';

            WHEN PSPS           =>
                PSUSP <= '1';
                IF sSTART_T1 = '1' THEN
                    START_T1_in <= '0';
                ELSIF oe_toggle THEN
                    -----------------------------------------------------------
                    --read status / stil programming
                    -----------------------------------------------------------
                    Status(6) := NOT Status(6); --toggle
                    Status(5) := '0';
                    --Status(2) no toggle
                    Status(1) := '0';

                    DOut_zd(7 downto 0) <= Status;
                    IF BYTENeg = '1' THEN
                        DOut_zd(15 downto 8) <= (OTHERS => '0');
                    END IF;

                END IF;
                --busy signal active
                RY_zd <= '0';

            WHEN PSP            =>
                PSUSP <= '0';
                IF falling_edge(write) THEN
                    IF DataLo = 16#30# THEN
                        PRES <= '1', '0' AFTER 1 ns;
                    END IF;
                ELSIF oe THEN
                    -----------------------------------------------------------
                    --read  - program suspend
                    -----------------------------------------------------------
                    IF SecAddr = SA THEN
                        --read program suspended sector
                        --Invalid (not allowed)
                        ASSERT false
                            REPORT "Read from program suspended sector " &
                                   "is NOT allowed"
                            SEVERITY warning;
                    ELSIF ESP_ACT = '1' AND Ers_Queue(SecAddr) = '1' THEN
                        Status(7) := '1';
                        -- Status(6) No toggle
                        Status(5) := '0';
                        IF oe_toggle THEN
                            Status(2) := NOT Status(2); --toggle
                        END IF;

                        DOut_zd(7 downto 0) <= Status;
                        IF BYTENeg = '1' THEN
                            DOut_zd(15 downto 8) <= (OTHERS => '0');
                        END IF;

                    ELSE
                        --read sector other than program suspended one
                        DOut_zd(7 downto 0) <= READMEM(Mem(SecAddr)(Address));
                        IF BYTENeg = '1' THEN
                            DOut_zd(15 downto 8) <=
                                        READMEM(Mem(SecAddr)(Address + 1));
                        END IF;

                    END IF;
                END IF;
                --ready signal active
                RY_zd <= '1';

            WHEN PSP_CFI        =>
                IF oe THEN
                    DOut_zd(15 downto 0) <= (OTHERS => '0');
                    IF ((Addr >= 16#10#) AND (Addr <= 16#50#)) THEN
                        DOut_zd(7 downto 0) <= to_slv(CFI_array(Addr),8);
                    ELSE
                        ASSERT FALSE
                            REPORT "Invalid CFI query address"
                            SEVERITY warning;
                    END IF;
                END IF;

            WHEN PSP_Z001       =>
                null;

            WHEN PSP_PREL       =>
                IF falling_edge(write) THEN
                    IF A_PAT_1 AND DataLo =16#88# THEN
                        PSP_ACT <= '1';
                    END IF;
                END IF;

            WHEN PSP_AS         =>
                IF falling_edge(write) THEN
                    IF DataLo = 16#F0# THEN
                        -- reset ULBYPASS
                        ULBYPASS <= '0';
                    END IF;
                ELSIF oe THEN
                    IF BYTENeg = '1' THEN
                        IF Address = 0 THEN
                            DOut_zd(15 downto 8) <= to_slv(0,8);
                        ELSE
                            DOut_zd(15 downto 8) <= to_slv(16#22#,8);
                        END IF;
                    ELSE
                        DOut_zd(15 downto 8) <= "ZZZZZZZZ";
                    END IF;

                    IF Addr = 0 THEN
                        DOut_zd(7 downto 0) <= to_slv(1,8);
                    ELSIF Addr = 1 THEN
                        DOut_zd(7 downto 0) <= to_slv(16#7E#,8);
                    ELSIF Addr = 2 THEN
                        DOut_zd(7 downto 1) <= to_slv(0,7);
                        IF ( DYB(SecAddr) = '1' AND
                                PPB(SecAddr) = '1' ) THEN
                            DOut_zd(0) <= '0'; --unprotected (inverted statuses)
                        ELSE
                            DOut_zd(0) <= '1'; -- protected(inverted statuses)
                        END IF;
                    ELSIF Addr = 3 THEN
                        DOut_zd(7 downto 0) <= to_slv(10,8);
                        IF ProtSecNum > 0 THEN
                            --Highest Address Sector Protected by WP#
                            DOut_zd(4) <= '1';
                        END IF;
                        IF FactoryProt = '1' THEN
                            DOut_zd(7) <= '1';
                        END IF;
                    ELSIF Addr = 16#E# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1D#,8);
                        ELSIF TimingModel(16) = '3' OR TimingModel(16) = '4'
                        THEN
                            DOut_zd(7 downto 0) <= to_slv(16#1A#,8);
                        END IF;
                    ELSIF Addr = 16#F# THEN
                        IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        ELSIF TimingModel(16) = '3' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#01#,8);
                        ELSIF TimingModel(16) = '4' THEN
                            DOut_zd(7 downto 0) <= to_slv(16#00#,8);
                        END IF;
                    END IF;
                END IF;

        END CASE;
        END IF;

        --Output Disable Control
        IF (gOE_n = '1') OR (RESETNeg = '0' AND RST = '0') THEN
            DOut_zd <= (OTHERS => 'Z');
        ELSE
            IF (BYTENeg = '0') THEN
                DOut_zd(15 downto 8) <= (OTHERS =>'Z');
            END IF;
        END IF;

        --Preload Control
-------------------------------------------------------------------------------
-- File Read Section
-------------------------------------------------------------------------------
        IF NOW = 0 ns  THEN
            LockReg := (OTHERS => ( OTHERS => '1'));
            PPB := (OTHERS => '1');-- unprotected state
            DYB := (OTHERS => '1');-- unprotected state
            Password := (OTHERS => ( OTHERS => '1'));

-------------------------------------------------------------------------------
-----s29gl032n sector protection preload file format-------------------------
-------------------------------------------------------------------------------
--   /       - comment
--   @aaa    - <aaa> stands for sector address
--   b       - <b> is 1 for protected sector <aaa>, 0 for unprotect.
--             If <aaa> > SecNum SecSi is protected/unprotected
--   only first 1-4 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------
            IF (prot_file_name /= "none" AND UserPreload ) THEN

              assert false report "MMV: Opening file (prot) ..." severity warning;
                ind := 0;
                FactoryProt <= '0';
                WHILE (not ENDFILE (prot_file)) LOOP
                    READLINE (prot_file, buf);
                    IF buf(1) = '/' THEN
                        NEXT;
                    ELSIF buf(1) = '@' THEN
                        ind := h(buf(2 to 4)); --address
                    ELSE
                        IF ind > SecNum THEN
                            --SecSi Factory protect preload
                            IF buf(1) = '1' THEN
                                FactoryProt <= '1';
                            END IF;
                        ELSE
                            -- Standard Sector preload
                            IF buf(1) = '1' THEN
                                PPB(ind) := '0';-- protected state '0'
                            END IF;
                            ind := ind + 1;
                        END IF;
                    END IF;
                END LOOP;
            END IF;

-------------------------------------------------------------------------------
-----s29gl032n SecSi preload file format------ --------------------------------
-------------------------------------------------------------------------------
--   /       - comment
--   @aa     - <aa> stands for address within sector
--   dd      - <dd> is byte to be written at SecSi(aa++)
--             (aa is incremented at every load)
--   only first 1-3 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------
            IF (SecSi_file_name /= "none" AND UserPreload ) THEN
                SecSi := (OTHERS => MaxData);
                ind := 0;
                WHILE (not ENDFILE (SecSi_file)) LOOP
                    READLINE (SecSi_file, buf);
                    IF buf(1) = '/' THEN
                        NEXT;
                    ELSIF buf(1) = '@' THEN
                        ind := h(buf(2 to 3)); --address
                    ELSE
                        IF ind <= SecSiSize THEN
                            SecSi(ind) := h(buf(1 TO 2));
                            ind := ind + 1;
                        END IF;
                    END IF;
                END LOOP;
            END IF;

-------------------------------------------------------------------------------
-----s29gl032n memory preload file format -----------------------------------
-------------------------------------------------------------------------------
--   /       - comment
--   @aaaaaaa  - <aaaaaaa> stands for address within sector
--   dd      - <dd> is byte to be written at Mem(*)(aaaaaaa++)
--             (aaaaaaa is incremented at every load)
--   only first 1-8 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------
            IF (mem_file_name /= "none" ) THEN

              assert false report "MMV: Opening file..." severity error;
                ind   := 0;
                S_ind := 0;
              --report "Memory written 7" severity note;
                Mem := (OTHERS => (OTHERS => MaxData));
                -- load sector 0
                WHILE (not ENDFILE (mem_file)) LOOP
                    READLINE (mem_file, buf);
                    IF buf(1) = '/' THEN
                        NEXT;
                    ELSIF buf(1) = '@' THEN
                        ind := h(buf(2 to 8)); --address
                    ELSE
                        IF ind=0 THEN
                            S_ind := 0;
                            index := 0;
                            --report "Memory written 8" severity note;
                            Mem(S_ind)(index) := h(buf(1 to 2));
                            ind := ind + 1;
                        ELSIF ind <= AddrRANGE THEN
                            S_ind     := ReturnSectorID1(ind);
                            ADDRHILO(AddrLo,AddrHi,S_ind);
                            index := ind - AddrLo;
                            --report "Memory written 9" severity note;
                            Mem(S_ind)(index) := h(buf(1 to 2));
                            ind := ind + 1;
                        ELSE
                            REPORT " Memory address out of range" &
                            to_hex_str(ind)
                            SEVERITY warning;
                        END IF;

                    END IF;
                END LOOP;
            END IF;
        -----------------------------------------------------------------------
        --CFI array data
        -----------------------------------------------------------------------
            --CFI query identification string
            CFI_array(16#10#) := 16#51#;
            CFI_array(16#11#) := 16#52#;
            CFI_array(16#12#) := 16#59#;
            CFI_array(16#13#) := 16#02#;
            CFI_array(16#14#) := 16#00#;
            CFI_array(16#15#) := 16#40#;
            CFI_array(16#16#) := 16#00#;
            CFI_array(16#17#) := 16#00#;
            CFI_array(16#18#) := 16#00#;
            CFI_array(16#19#) := 16#00#;
            CFI_array(16#1A#) := 16#00#;
            --System interface string
            CFI_array(16#1B#) := 16#27#;
            CFI_array(16#1C#) := 16#36#;
            CFI_array(16#1D#) := 16#00#;
            CFI_array(16#1E#) := 16#00#;
            CFI_array(16#1F#) := 16#07#;
            CFI_array(16#20#) := 16#07#;
            CFI_array(16#21#) := 16#08#;
            CFI_array(16#22#) := 16#0E#;
            CFI_array(16#23#) := 16#04#;
            CFI_array(16#24#) := 16#05#;
            CFI_array(16#25#) := 16#05#;
            CFI_array(16#26#) := 16#00#;
            CFI_array(16#27#) := 16#16#;
            CFI_array(16#28#) := 16#02#;
            CFI_array(16#29#) := 16#00#;
            CFI_array(16#2A#) := 16#05#;
            CFI_array(16#2B#) := 16#00#;
            IF TimingModel(16) = '1' OR TimingModel(16) = '2' THEN
                CFI_array(16#2C#) := 16#01#;
                CFI_array(16#2D#) := 16#01#;
                CFI_array(16#2E#) := 16#00#;
                CFI_array(16#2F#) := 16#00#;
                CFI_array(16#30#) := 16#3F#;
                CFI_array(16#31#) := 16#00#;
                CFI_array(16#32#) := 16#00#;
                CFI_array(16#33#) := 16#00#;
                CFI_array(16#34#) := 16#00#;
            ELSIF TimingModel(16) = '3' OR TimingModel(16) = '4' THEN
                CFI_array(16#2C#) := 16#02#;
                CFI_array(16#2D#) := 16#00#;
                CFI_array(16#2E#) := 16#20#;
                CFI_array(16#2F#) := 16#00#;
                CFI_array(16#30#) := 16#07#;
                CFI_array(16#31#) := 16#01#;
                CFI_array(16#32#) := 16#00#;
                CFI_array(16#33#) := 16#00#;
                CFI_array(16#34#) := 16#7E#;
            END IF;
            CFI_array(16#35#) := 16#00#;
            CFI_array(16#36#) := 16#00#;
            CFI_array(16#37#) := 16#00#;
            CFI_array(16#38#) := 16#00#;
            CFI_array(16#39#) := 16#00#;
            CFI_array(16#3A#) := 16#00#;
            CFI_array(16#3B#) := 16#00#;
            CFI_array(16#3C#) := 16#00#;
            --primary vendor-specific extended query
            CFI_array(16#40#) := 16#50#;
            CFI_array(16#41#) := 16#52#;
            CFI_array(16#42#) := 16#49#;
            CFI_array(16#43#) := 16#31#;
            CFI_array(16#44#) := 16#33#;
            CFI_array(16#45#) := 16#08#;
            CFI_array(16#46#) := 16#02#;
            CFI_array(16#47#) := 16#01#;
            CFI_array(16#48#) := 16#00#;
            CFI_array(16#49#) := 16#08#;
            CFI_array(16#4A#) := 16#00#;
            CFI_array(16#4B#) := 16#00#;
            CFI_array(16#4C#) := 16#03#;
            CFI_array(16#4D#) := 16#B5#;
            CFI_array(16#4E#) := 16#C5#;
            IF TimingModel(16) = '1' THEN
                CFI_array(16#4F#) := 16#05#;
            ELSIF TimingModel(16) = '2' THEN
                CFI_array(16#4F#) := 16#04#;
            ELSIF TimingModel(16) = '3' THEN
                CFI_array(16#4F#) := 16#03#;
            ELSIF TimingModel(16) = '4' THEN
                CFI_array(16#4F#) := 16#02#;
            END IF;
            CFI_array(16#50#) := 16#01#;
        END IF;
    END PROCESS Functional;

    Start_T1_time : PROCESS (START_T1_in)
    BEGIN
        IF rising_edge ( START_T1_in ) THEN
            IF LongTimming = TRUE THEN
                sSTART_T1 <= '0', '1' AFTER tdevice_START_T1;
            ELSE
                sSTART_T1 <= '0', '1' AFTER tdevice_START_T1/1;
            END IF;
        ELSE
            sSTART_T1 <= '0';
        END IF;
    END PROCESS Start_T1_time;

    CTMOUT_time : PROCESS (CTMOUT_in)
    BEGIN
        IF rising_edge ( CTMOUT_in ) THEN
            IF LongTimming = TRUE THEN
                sCTMOUT <= '0', '1' AFTER (tdevice_CTMOUT - 1 ns);
            ELSE
                sCTMOUT <= '0', '1' AFTER (tdevice_CTMOUT - 1 ns)/5;
            END IF;
        ELSE
            sCTMOUT <= '0';
        END IF;
    END PROCESS CTMOUT_time;

    READY_time : PROCESS (READY_in)
    BEGIN
        IF rising_edge ( READY_in ) THEN
            IF LongTimming = TRUE THEN
                sREADY <= '0', '1' AFTER (tdevice_READY - 1 ns);
            ELSE
                sREADY <= '0', '1' AFTER (tdevice_READY - 1 ns)/10;
            END IF;
        ELSE
            sREADY <= '0';
        END IF;
    END PROCESS READY_time;

    DOutPassThrough : PROCESS(DOut_zd)
        VARIABLE ValidData         : std_logic_vector(15 downto 0);
        VARIABLE CEDQ_t            : TIME;
        VARIABLE OEDQ_t            : TIME;
        VARIABLE ADDRDQ_t          : TIME;

    BEGIN
       IF DOut_zd(0) /= 'Z' THEN
           OPENLATCH := TRUE;
           CEDQ_t := -CENeg'LAST_EVENT + tpd_CENeg_DQ0(trz0);
           OEDQ_t := -OENeg'LAST_EVENT + tpd_OENeg_DQ0(trz0);
           ADDRDQ_t := -A'LAST_EVENT + tpd_A0_DQ0(tr01);
           IF ( BYTENeg = '0' ) AND (DIn(15)'LAST_EVENT < A'LAST_EVENT)  THEN
               ADDRDQ_t := -DIn(15)'LAST_EVENT + tpd_A0_DQ0(tr01);
           END IF;
           FROMOE := (OEDQ_t >= CEDQ_t) AND (OEDQ_t > 0 ns);
           FROMCE := (CEDQ_t > OEDQ_t) AND (CEDQ_t > 0 ns);

           IF BYTENeg = '0' THEN
               ValidData := "ZZZZZZZZXXXXXXXX";
           ELSE
               ValidData := "XXXXXXXXXXXXXXXX";
           END IF;

           IF ((ADDRDQ_t > 0 ns) AND
           (((ADDRDQ_t > CEDQ_t) AND FROMCE) OR
           ((ADDRDQ_t > OEDQ_t) AND FROMOE))) THEN
               DOut_Pass <= ValidData,
               DOut_zd AFTER ADDRDQ_t;
           ELSE
               DOut_Pass <= DOut_zd;
           END IF;
       ELSE
           OPENLATCH := FALSE;
           DOut_Pass <= DOut_zd;
       END IF;
    END PROCESS DOutPassThrough;

    -----------------------------------------------------------------------
    -- Path Delay Section
    -----------------------------------------------------------------------
    RY_OUT: PROCESS(RY_zd)
        VARIABLE RY_tmp        : std_logic;
        VARIABLE RY_GlitchData : VitalGlitchDataType;
    BEGIN
        IF  RY_zd = '1' THEN
            RY_tmp := 'Z';
        ELSE
            RY_tmp := RY_zd;
        END IF;
        VitalPathDelay01(
            OutSignal     => RY,
            OutSignalName => "RY/BY#",
            OutTemp       => RY_tmp,
            Mode          => VitalTransport,
            GlitchData    => RY_GlitchData,
            Paths         => (
            0 => (InputChangeTime   => CENeg'LAST_EVENT,
                  PathDelay         => tpd_CENeg_RY,
                  PathCondition     => TRUE),
            1 => (InputChangeTime   => WENeg'LAST_EVENT,
                  PathDelay         => tpd_WENeg_RY,
                  PathCondition     => TRUE),
            2 => (InputChangeTime   => sREADY'LAST_EVENT,
                  PathDelay         => VitalZeroDelay01,
                  PathCondition     => EDONE = '1'),
            3 => (InputChangeTime   => EDONE'LAST_EVENT,
                  PathDelay         => VitalZeroDelay01,
                  PathCondition     => EDONE = '1'),
            4 => (InputChangeTime   => PDONE'LAST_EVENT,
                  PathDelay         => VitalZeroDelay01,
                  PathCondition     => PDONE = '1')
            )
        );
    END PROCESS RY_Out;
    ---------------------------------------------------------------------------
    -- Path Delay Section for DOut signal
    ---------------------------------------------------------------------------
    D_Out_PathDelay_Gen : FOR i IN DOut_Pass'RANGE GENERATE
        PROCESS(DOut_Pass(i))
        VARIABLE D0_GlitchData     : VitalGlitchDataType;

        BEGIN
            VitalPathDelay01Z(
                OutSignal           => DOut(i),
                OutSignalName       => "DOut",
                OutTemp             => DOut_Pass(i),
                GlitchData          => D0_GlitchData,
                Mode                => VitalTransport,
                Paths               => (
                0 => (InputChangeTime => CENeg'LAST_EVENT,
                      PathDelay       => tpd_CENeg_DQ0,
                      PathCondition   => NOT OPENLATCH OR
                                         (OPENLATCH AND FROMCE)),
                1 => (InputChangeTime => OENeg'LAST_EVENT,
                      PathDelay       => tpd_OENeg_DQ0,
                      PathCondition   => NOT OPENLATCH OR
                                         (OPENLATCH AND FROMOE)),
                2 => (InputChangeTime => RESETNeg'LAST_EVENT,
                      PathDelay       => tpd_RESETNeg_DQ0,
                      PathCondition   => RESETNeg='0'),
                3 => (InputChangeTime => A'LAST_EVENT,
                      PathDelay       => VitalExtendToFillDelay(tpd_A0_DQ0),
                      PathCondition   => DOut_pass(i) /= 'X' AND RPchange),
                4 => (InputChangeTime => A'LAST_EVENT,
                      PathDelay       => VitalExtendToFillDelay(tpd_A0_DQ1),
                      PathCondition   => DOut_pass(i)/= 'X' AND (NOT RPchange)),
                5 => (InputChangeTime => Din(15)'LAST_EVENT,
                      PathDelay       => VitalExtendToFillDelay(tpd_A0_DQ1),
                      PathCondition   => DOut_pass(i) /= 'X' AND
                                         BYTENeg='0'AND(NOT RPchange))
                )
            );
        END PROCESS;
    END GENERATE D_Out_PathDelay_Gen;

    END BLOCK behavior;
END vhdl_behavioral;