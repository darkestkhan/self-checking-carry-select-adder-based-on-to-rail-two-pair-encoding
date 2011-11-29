library IEEE;
use IEEE.Std_Logic_1164.all;

entity Four_Bit_And
is

  port (A, B: in Std_Logic_Vector (3 downto 0);
        R: out Std_Logic_Vector (3 downto 0));

end Four_Bit_And;

architecture Behav of Four_Bit_And
is
begin
  FBA: for I in R'Range generate
    R (I) <= A (I) and B (I);
  end generate FBA;
end architecture Behav;
