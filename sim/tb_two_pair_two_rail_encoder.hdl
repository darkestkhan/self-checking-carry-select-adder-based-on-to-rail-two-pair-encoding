library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_Two_Pair_Two_Rail_Encoder is
end TB_Two_Pair_Two_Rail_Encoder;

architecture TB of TB_Two_Pair_Two_Rail_Encoder is

  component Two_Pair_Two_Rail_Encoder is
    port (X0, X1, Y0, Y1: in Std_Logic;
          F, G: out Std_Logic);
  end component Two_Pair_Two_Rail_Encoder;

  signal T_F, T_G, T_X0, T_X1, T_Y0, T_Y1: Std_Logic;

begin

  T_TPTRE: Two_Pair_Two_Rail_Encoder
    port map (X0 => T_X0, X1 => T_X1, Y0 => T_Y0, Y1 => T_Y1, F => T_F, G => T_G);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- test case one
    T_X0 <= '1';
    T_X1 <= '1';
    T_Y0 <= '0';
    T_Y1 <= '0';
    wait for 10 ns;
    assert (T_F = '1' and T_G = '0')
      report "Failed Test Case 1" severity error;
    if T_F /= '1' or T_G /= '0' then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- test case two
    T_X0 <= '1';
    T_X1 <= '1';
    T_Y0 <= '0';
    T_Y1 <= '1';
    wait for 10 ns;
    assert (T_F = '1' and T_G = '1')
      report "Failed Test Case 1" severity error;
    if T_F /= '1' or T_G /= '1' then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- summary
    if Err_Cnt = 0 then
      assert false
        report "Testbench Completed Succesfully!" severity note;
    else
      assert true
        report "Something has gone wrong, try again later!" severity error;
    end if;

    wait;
  end process;

end architecture TB;

configuration CFG_TB of TB_Two_Pair_Two_Rail_Encoder
is
  for TB
  end for;
end CFG_TB;
