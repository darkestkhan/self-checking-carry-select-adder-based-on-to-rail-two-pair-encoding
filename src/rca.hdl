library IEEE;
use IEEE.Std_Logic_1164.all;

entity RCA is
  generic (Width: Positive := 4; Carry_In: Std_Logic := '0');
  -- width specifies the size of number to be added
  -- carry_in specifies wether we increase the sum by 1 or not
  port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
        Fault: in Std_Logic_Vector ((Width * 2) - 1 downto 0);
        Sum: out Std_Logic_Vector (Width - 1 downto 0);
        Carry_Out: out Std_Logic);
end RCA;

architecture Structure of RCA
is

  component Full_Adder is
    port  (A, B, Carry_In: in Std_Logic;
           Sum, Carry_Out: out Std_Logic);
  end component Full_Adder;

  signal Cin: Std_Logic_Vector (Width - 1 downto 1); 

  signal Fault_A, Fault_B: Std_Logic_Vector (Width - 1 downto 0);

begin

  Inject_Faults:
    for I in 0 to Width - 1 generate
      Fault_A (I) <= A (I) xor Fault (I);
      Fault_B (I) <= B (I) xor Fault (Width + I);
    end generate Inject_Faults;

  Adder:
    for I in 0 to Width generate
      Lowest_Bit:
        if I = 0 generate
          Lowest_Cell: Full_Adder port map (A => Fault_A (0), B => Fault_B (0), Carry_In => Carry_In, Sum => Sum (0), Carry_Out => Cin (1));
        end generate Lowest_Bit;

      Middle_Bit:
        if I > 0 and I < Width - 1 generate
          Middle_Cell: Full_Adder port map (A => Fault_A (I), B => Fault_B (I), Carry_In => Cin (I), Sum => Sum (I), Carry_Out => Cin (I + 1));
        end generate Middle_Bit;

      Highest_Bit:
        if I = Width - 1 generate
          Highest_Cell: Full_Adder port map (A => Fault_A (I), B => Fault_B (I), Carry_In => Cin (I), Sum => Sum (I), Carry_Out => Carry_Out);
        end generate Highest_Bit;
    end generate Adder;

end architecture Structure;
