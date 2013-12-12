library IEEE;
use IEEE.Std_Logic_1164.all;

entity Eight_Bit_CSA is

  port (A, B: in Std_Logic_Vector (7 downto 0);
        Sum: out Std_Logic_Vector (7 downto 0);
        Carry_Out: out Std_Logic);

end Eight_Bit_CSA;

architecture Structure of Eight_Bit_CSA is

  component CSA_Part is
    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Sum: out Std_Logic_Vector (Width - 1 downto 0);
          Control_In: in Std_Logic;
          Control_Out: out Std_Logic);
  end component CSA_Part;

  component Half_Adder is
    port (A, B: in Std_Logic;
          Sum, Carry_Out: out Std_Logic);
  end component Half_Adder;

  signal Controls: Std_Logic_Vector (3 downto 1);

begin

  Lowest_Bit: Half_Adder
    port map (A => A (0), B => B (0), Sum => Sum (0), Carry_Out => Controls (1));
  Bits_Two_To_Three: CSA_Part
    generic map (Width => 2)
    port map (A => A (2 downto 1), B => B (2 downto 1), Sum => Sum (2 downto 1), Control_In => Controls (1), Control_Out => Controls (2));
  Bits_Four_To_Five: CSA_Part
    generic map (Width => 2)
    port map (A => A (4 downto 3), B => B (4 downto 3), Sum => Sum (4 downto 3), Control_In => Controls (2), Control_Out => Controls (3));
  Bits_Six_To_Eight: CSA_Part
    generic map (Width => 3)
    port map (A => A (7 downto 5), B => B (7 downto 5), Sum => Sum (7 downto 5), Control_In => Controls (3), Control_Out => Carry_Out);

end architecture Structure;
