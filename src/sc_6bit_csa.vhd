library IEEE;
use IEEE.Std_Logic_1164.all;

entity SC_6bit_CSA is

  port (A, B: in Std_Logic_Vector (5 downto 0);
        Sum: out Std_Logic_Vector (5 downto 0);
        Fault: in Std_Logic_Vector (23 downto 0);
        Cout: out Std_Logic;
        Was_Error: out Std_Logic);

end SC_6bit_CSA;

architecture Structure of SC_6bit_CSA is

  component Two_Pair_Two_Rail_Encoder is
    port (X0, X1, Y0, Y1: in Std_Logic;
          F, G: out Std_Logic);
  end component Two_Pair_Two_Rail_Encoder;

  component SC_Two_Bit_CSA is
    port (A, B: in Std_Logic_Vector (1 downto 0);
          Fault: in Std_Logic_Vector (7 downto 0);
          Sum: out Std_Logic_Vector (1 downto 0);
          Cin: in Std_Logic;
          Cout: out Std_Logic;
          Encoded: out Std_Logic_Vector (1 downto 0);
          MUX_Error: out Std_Logic);
  end component SC_Two_Bit_CSA;

  component SC_MUX is
    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Control: in Std_Logic;
          Output, Not_Output: out Std_Logic_Vector (Width - 1 downto 0));
  end component SC_MUX;

  signal cins: Std_Logic_Vector (2 downto 1);
  signal MUX_Errors: Std_Logic_Vector (2 downto 0);
  signal Initial_Encoding: Std_Logic_Vector (5 downto 0);
  signal Second_Encoding: Std_Logic_Vector (1 downto 0);
  signal Final_Encoding: Std_Logic_Vector (1 downto 0);

begin

  Bits_0_to_1: SC_Two_Bit_CSA
    port map (A => A (1 downto 0), B => B (1 downto 0), Fault => Fault (7 downto 0),
              Sum => Sum (1 downto 0), Cin => '0', Cout => cins (1),
              Encoded => Initial_Encoding (1 downto 0), MUX_Error => MUX_Errors (0));
  Bits_2_to_3: SC_Two_Bit_CSA
    port map (A => A (3 downto 2), B => B (3 downto 2), Fault => Fault (15 downto 8),
              Sum => Sum (3 downto 2), Cin => cins (1), Cout => cins (2),
              Encoded => Initial_Encoding (3 downto 2), MUX_Error => MUX_Errors (1));
  Bits_4_to_5: SC_Two_Bit_CSA
    port map (A => A (5 downto 4), B => B (5 downto 4), Fault => Fault (23 downto 16),
              Sum => Sum (5 downto 4), Cin => cins (2), Cout => Cout,
              Encoded => Initial_Encoding (5 downto 4), MUX_Error => MUX_Errors (2));

  FLE_0_to_3: Two_Pair_Two_Rail_Encoder
    port map (X0 => Initial_Encoding (0), Y0 => Initial_Encoding (1),
              X1 => Initial_Encoding (2), Y1 => Initial_Encoding (3),
              F => Second_Encoding (0), G => Second_Encoding (1));

  SLE: Two_Pair_Two_Rail_Encoder
    port map (X0 => Initial_Encoding (4), Y0 => Initial_Encoding (5),
              X1 => Second_Encoding (0), Y1 => Second_Encoding (1),
              F => Final_Encoding (0), G => Final_Encoding (1));

  Was_Error <= (not (Final_Encoding (0) xor Final_Encoding (1))) or
                Mux_Errors (0) or Mux_Errors (1) or Mux_Errors (2);

end architecture Structure;
