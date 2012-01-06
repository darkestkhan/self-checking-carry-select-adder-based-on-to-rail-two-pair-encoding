library IEEE;
use IEEE.Std_Logic_1164.all;

entity SC_MUX is
  generic (Width: Positive := 4);
  port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
        Control: in Std_Logic;
        Output, Not_Output: out Std_Logic_Vector (Width - 1 downto 0));
end SC_MUX;

architecture Behav of SC_MUX is
begin
  Result:
    for I in 0 to Width - 1 generate
      Output (I) <= (A (I) and (not Control)) or (B (I) and Control);
      Not_Output (I) <= (not A (I) or Control) and (not B (I) or (not Control));
    end generate Result;
end architecture Behav;
