library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_CLB is
end TB_CLB;

architecture TB of TB_CLB is

  component CLB is
    port (S00, S10, S11, S01: in Std_Logic;
          X0, X1, Y0, Y1: out Std_Logic);
  end component CLB;

  signal T_S00, T_S10, T_S11, T_S01, T_X0, T_X1, T_Y0, T_Y1: Std_Logic;

begin

  T_CLB: CLB
    port map (S00 => T_S00, S10 => T_S10, S11 => T_S11, S01 => T_S01,
              X0 => T_X0, X1 => T_X1, Y0 => T_Y0, Y1 => T_Y1);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- test case one
    T_S00 <= '0';
    T_S10 <= '1';
    T_S11 <= '1';
    T_S01 <= '1';
    wait for 10 ns;
    assert (T_Y1 = '0')
      report "Failed Case 1" severity error;
    if (T_Y1 /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- test case two
    T_S00 <= '0';
    T_S10 <= '0';
    T_S11 <= '0';
    T_S01 <= '0';
    wait for 10 ns;
    assert (T_Y1 = '1')
      report "Failed Case 1" severity error;
    if (T_Y1 /= '1') then
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

configuration CFG_TB of TB_CLB
is
  for TB
  end for;
end CFG_TB;

