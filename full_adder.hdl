library IEEE;
use IEEE.Std_Logic_1164.all;

entity Full_Adder
is

  port (A, B, Carry_In: in Std_Logic;
        Sum, Carry_Out: out Std_Logic);

end Full_Adder;

architecture Full_Adder_Behav of Full_Adder
is
begin

  Sum <= (A xor B) xor Carry_In;
  Carry_Out <= (A and B) or (Carry_In and (A xor B));

end Full_Adder_Behav;
