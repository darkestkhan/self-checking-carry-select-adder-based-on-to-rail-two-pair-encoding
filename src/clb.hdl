library IEEE;
use IEEE.Std_Logic_1164.all;

entity CLB is

  port (S00, S01, S10, S11 : in Std_Logic;
        X0, X1, Y0, Y1: out Std_Logic);

end CLB;

architecture Configuration_Logic_Block of CLB is
begin
  X0 <= S00;
  Y0 <= S10;
  X1 <= S01;
  Y1 <= S11 xnor S00;
end Configuration_Logic_Block;
