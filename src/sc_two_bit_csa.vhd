library IEEE;
use IEEE.Std_Logic_1164.all;

entity SC_Two_Bit_CSA is

  port (A, B: in Std_Logic_Vector (1 downto 0);
        Fault: in Std_Logic_Vector (7 downto 0);
        Sum: out Std_Logic_Vector (1 downto 0);
        Cin: in Std_Logic;
        Cout: out Std_Logic;
        Encoded: out Std_Logic_Vector (1 downto 0);
        MUX_Error: out Std_Logic);

end entity SC_Two_Bit_CSA;

architecture Structure of SC_Two_Bit_CSA is

  component RCA is
    generic (Width: Positive := 2; Carry_In: Std_Logic := '0');
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Fault: in Std_Logic_Vector ((Width * 2) - 1 downto 0);
          Sum: out Std_Logic_Vector (Width - 1 downto 0);
          Carry_Out: out Std_Logic);
  end component RCA;

  component SC_MUX is
    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Control: in Std_Logic;
          Output, Not_Output: out Std_Logic_Vector (Width - 1 downto 0));
  end component SC_MUX;

  component CLB is
    port (S00, S10, S11, S01: in Std_Logic;
          X0, X1, Y0, Y1: out Std_Logic);
  end component CLB;

  component Two_Pair_Two_Rail_Encoder is
    port (X0, X1, Y0, Y1: in Std_Logic;
          F, G: out Std_Logic);
  end component Two_Pair_Two_Rail_Encoder;

  -- WOC for Without_Carry, WC for With_Carry, Co for Carry_Out
  signal WOC_Co, WC_Co: Std_Logic_Vector (0 downto 0);
  signal WOC_Sum, WC_Sum: Std_Logic_Vector (1 downto 0);
  -- used by CLB and Encoder
  signal FWD_X, FWD_Y: Std_Logic_Vector (1 downto 0);
  -- used to detect mutex error
  signal Inverse_Sum, Temp_Sum: Std_Logic_Vector (1 downto 0);
  signal Inverse_Cout, Temp_Cout: Std_Logic;

begin

  WOC: RCA
    generic map (Width => 2, Carry_In => '0')
    port map (A => A, B => B, Fault => Fault (3 downto 0), Sum => WOC_Sum, Carry_Out => WOC_Co (0));
  WC: RCA
    generic map (Width => 2, Carry_In => '1')
    port map (A => A, B => B, Sum => WC_Sum, Fault => Fault (7 downto 4), Carry_Out => WC_Co (0));
  Results: SC_MUX
    generic map (Width => 2)
    port map (A => WOC_Sum, B => WC_Sum, Control => Cin, Output => Temp_Sum, Not_Output => Inverse_Sum);
  Carry_Out: SC_MUX
    generic map (Width => 1)
    port map (A => WOC_Co, B (0) => WC_Co (0), Control => Cin,
              Output (0) => Temp_Cout, Not_Output (0) => Inverse_Cout);
  Configure: CLB
    port map (S00 => WOC_Sum (0), S10 => WC_Sum (0), S01 => WOC_Sum (1), S11 => WC_Sum (1),
              X0 => FWD_X (0), X1 => FWD_X (1), Y0 => FWD_Y (0), Y1 => FWD_Y (1));
  Encoder: Two_Pair_Two_Rail_Encoder
    port map (X0 => FWD_X (0), X1 => FWD_X (1), Y0 => FWD_Y (0), Y1 => FWD_Y (1),
              F => Encoded (0), G => Encoded (1));

  Mux_Error <= not ((Temp_Sum (0) xor Inverse_Sum (0)) and
                    (Temp_Sum (1) xor Inverse_Sum (1)) and
                    (Temp_Cout xor Inverse_Cout));

  Sum <= Temp_Sum;
  Cout <= Temp_Cout;

end architecture Structure;
