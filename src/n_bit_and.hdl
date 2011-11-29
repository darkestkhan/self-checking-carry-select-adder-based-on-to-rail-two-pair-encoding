library IEEE;
use IEEE.Std_Logic_1164.all;

entity N_Bit_And is
  generic (Width: Positive := 4);

  port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
        R: out Std_Logic_Vector (Width - 1 downto 0));

end N_Bit_And;

architecture Behav of N_Bit_And
is
begin

  NBA: for I in 0 to Width - 1 generate
    R (I) <= A (I) and B (I);
  end generate NBA;

end architecture Behav;
