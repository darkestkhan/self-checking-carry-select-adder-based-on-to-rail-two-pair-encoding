library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_Half_Adder
is
end TB_Half_Adder;

architecture TB of TB_Half_Adder
is

  component Half_Adder
  is
    port (A, B: in Std_Logic;
          Sum, Carry_Out: out Std_Logic);
  end component Half_Adder;

  signal T_A, T_B, T_Sum, T_Carry_Out: Std_Logic;

begin

  Test: Half_Adder port map (A => T_A, B => T_B, Sum => T_Sum, Carry_Out => T_Carry_Out);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 1: A -> 0, B -> 0
    T_A <= '0';
    T_B <= '0';
    wait for 10 ns;
    assert ((T_Sum = '0') and (T_Carry_Out = '0'))
      report "Failed Case 1" severity error;
    if (T_Sum /= '0') or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 1, B -> 0
    -- NOTE: no need to test for A -> 0 and B -> 1 as they are symmetric
    T_A <= '1';
    T_B <= '0';
    wait for 10 ns;
    assert ((T_Sum = '1') and (T_Carry_Out = '0'))
      report "Failed Case 2" severity error;
    if (T_Sum /= '1') or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1, B -> 1
    T_A <= '1';
    T_B <= '1';
    wait for 10 ns;
    assert ((T_Sum = '0') and (T_Carry_Out = '1'))
      report "Failed Case 3" severity error;
    if (T_Sum /= '0') or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Summary
    if (Err_Cnt = 0) then
      assert false report "Testbench completed succesfully!"
        severity note;
    else
      assert true report "Something has gone wrong, try again please!"
        severity error;
    end if;

    wait; -- stop running
  end process;

end architecture TB;

configuration CFG_TB of TB_Half_Adder
is
  for TB
  end for;
end CFG_TB;
