library IEEE;
use IEEE.Std_Logic_1164.all;

entity Two_Pair_Two_Rail_Encoder is

  port (X0, X1, Y0, Y1: in Std_Logic;
        F, G: out Std_Logic);

end Two_Pair_Two_Rail_Encoder;

architecture Encoder_Behav of Two_Pair_Two_Rail_Encoder is
begin

  F <= (X0 and Y1) or (Y0 and X1);
  G <= (X0 and X1) or (Y0 and Y1);

end architecture Encoder_Behav;
