library IEEE;
use IEEE.Std_Logic_1164.all;

entity Four_Bit_Adder
is

  port (A, B: in Std_Logic_Vector (3 downto 0);
        Sum: out Std_Logic_Vector (3 downto 0);
        Carry_Out: out Std_Logic);

end Four_Bit_Adder;

architecture Four_Bit_Adder_Structure of Four_Bit_Adder
is

  signal C: Std_Logic_Vector (4 downto 0);

  component Full_Adder

    port (A, B, Carry_In: in Std_Logic;
          Sum, Carry_Out: out Std_Logic);

  end component Full_Adder;

  component Half_Adder

    port (A, B: in Std_Logic;
          Sum, Carry_Out: out Std_Logic);

  end component Half_Adder;

begin

  HA0: Half_Adder port map (A (0), B (0), Sum (0), C (1));
  FA1: Full_Adder port map (A (1), B (1), C (1), Sum (1), C (2));
  FA2: Full_Adder port map (A (2), B (2), C (2), Sum (2), C (3));
  FA3: Full_Adder port map (A (3), B (3), C (3), Sum (3), C (4));

  Carry_Out <= C (4);

end Four_Bit_Adder_Structure;
