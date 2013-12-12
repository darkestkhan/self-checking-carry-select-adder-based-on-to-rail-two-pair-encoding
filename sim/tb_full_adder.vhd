library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_Full_Adder
is
end TB_Full_Adder;

architecture TB of TB_Full_Adder
is

  component Full_Adder
  is
    port (A, B, Carry_In: in Std_Logic;
          Sum, Carry_Out: out Std_Logic);
  end component Full_Adder;

  signal T_A, T_B, T_Carry_In, T_Sum, T_Carry_Out: Std_Logic;

begin

  FA: Full_Adder port map (A => T_A, B => T_B, Carry_In => T_Carry_In, Sum => T_Sum, Carry_Out => T_Carry_Out);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 1: A -> 0, B -> 0, Carry_In -> 0
    T_A <= '0';
    T_B <= '0';
    T_Carry_In <= '0';
    wait for 10 ns;
    assert ((T_Sum = '0') and (T_Carry_Out = '0'))
      report "Failed Case 1" severity error;
    if (T_Sum /= '0') or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 1, B -> 0, Carry_In -> 0
    -- NOTE: no need to test for A -> 0 and B -> 1 as they are symmetric
    T_A <= '1';
    T_B <= '0';
    T_Carry_In <= '0';
    wait for 10 ns;
    assert ((T_Sum = '1') and (T_Carry_Out = '0'))
      report "Failed Case 2" severity error;
    if (T_Sum /= '1') or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1, B -> 1, Carry_In -> 0
    T_A <= '1';
    T_B <= '1';
    T_Carry_In <= '0';
    wait for 10 ns;
    assert ((T_Sum = '0') and (T_Carry_Out = '1'))
      report "Failed Case 3" severity error;
    if (T_Sum /= '0') or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 4: A -> 0, B -> 0, Carry_In -> 1
    T_A <= '0';
    T_B <= '0';
    T_Carry_In <= '1';
    wait for 10 ns;
    assert ((T_Sum = '1') and (T_Carry_Out = '0'))
      report "Failed Case 4" severity error;
    if (T_Sum /= '1') or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 5: A -> 1, B -> 0, Carry_In -> 1
    T_A <= '1';
    T_B <= '0';
    T_Carry_In <= '1';
    wait for 10 ns;
    assert ((T_Sum = '0') and (T_Carry_Out = '1'))
      report "Failed Case 5" severity error;
    if (T_Sum /= '0') or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 6: A -> 1, B -> 1, Carry_In -> 1
    T_A <= '1';
    T_B <= '1';
    T_Carry_In <= '1';
    wait for 10 ns;
    assert ((T_Sum = '1') and (T_Carry_Out = '1'))
      report "Failed Case 6" severity error;
    if (T_Sum /= '1') or (T_Carry_Out /= '1') then
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

configuration CFG_TB of TB_Full_Adder
is
  for TB
  end for;
end CFG_TB;
