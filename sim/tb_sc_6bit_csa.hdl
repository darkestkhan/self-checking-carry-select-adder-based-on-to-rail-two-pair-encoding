library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_SC_6Bit_CSA
is
end TB_SC_6Bit_CSA;

architecture TB of TB_SC_6Bit_CSA is

  component SC_6bit_CSA is
    port (A, B: in Std_Logic_Vector (5 downto 0);
          Sum: out Std_Logic_Vector (5 downto 0);
          Fault: in Std_Logic_Vector (23 downto 0);
          Cout: out Std_Logic;
          Was_Error: out Std_Logic);
  end component SC_6bit_CSA;

  signal T_A, T_B, T_Sum: Std_Logic_Vector (5 downto 0);
  signal T_Fault: Std_Logic_Vector (23 downto 0);
  signal T_Carry_Out, T_WE: Std_Logic;

begin

  SC6BA: SC_6Bit_CSA
    port map (A => T_A, B => T_B, Fault => T_Fault, Sum => T_Sum,
              Cout => T_Carry_Out, Was_Error => T_WE);

  process
    variable Err_Cnt: Integer := 0;
  begin
    T_Fault <= "000000000000000000000000";
    -- Test Case 1: A -> 0000 00, B -> 0000 00
    T_A <= "000000";
    T_B <= "000000";
    wait for 10 ns;
    assert ((T_Sum = "000000") and (T_Carry_Out = '0') and (T_WE = '0'))
      report "Failed Case 1" severity error;
    if (T_Sum /= "000000") or (T_Carry_Out /= '0') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 0101 01, B -> 0101 01
    T_A <= "010101";
    T_B <= "010101";
    wait for 10 ns;
    assert ((T_Sum = "101010") and (T_Carry_Out = '0') and (T_WE = '0'))
      report "Failed Case 2" severity error;
    if (T_Sum /= "101010") or (T_Carry_Out /= '0') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1100 00, B -> 0111 00
    T_A <= "110000";
    T_B <= "011100";
    wait for 10 ns;
    assert ((T_Sum = "001100") and (T_Carry_Out = '1') and (T_WE = '0'))
      report "Failed Case 3" severity error;
    if (T_Sum /= "001100") or (T_Carry_Out /= '1') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 4: A -> 0111 00, B -> 0011 00
    T_A <= "011100";
    T_B <= "001100";
    wait for 10 ns;
    assert ((T_Sum = "101000") and (T_Carry_Out = '0') and (T_WE = '0'))
      report "Failed Case 4" severity error;
    if (T_Sum /= "101000") or (T_Carry_Out /= '0') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 5: A -> 1000 00, B -> 1000 00
    T_A <= "100000";
    T_B <= "100000";
    wait for 10 ns;
    assert ((T_Sum = "000000") and (T_Carry_Out = '1') and (T_WE = '0'))
      report "Failed Case 5" severity error;
    if (T_Sum /= "000000") or (T_Carry_Out /= '1') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 6: A -> 1111 11, B -> 1111 11
    T_A <= "111111";
    T_B <= "111111";
    wait for 10 ns;
    assert ((T_Sum = "111110") and (T_Carry_Out = '1') and (T_WE = '0'))
      report "Failed Case 6" severity error;
    if (T_Sum /= "111110") or (T_Carry_Out /= '1') or (T_WE /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- inject fault
    T_Fault <= "000000000000100000000000";
    -- Test Case 7: A -> 0000 00, B -> 0000 00
    T_A <= "000000";
    T_B <= "000000";
    wait for 10 ns;
    assert (((T_Sum = "000000") and (T_Carry_Out = '0')) or (T_WE = '1'))
      report "Failed Case 7" severity error;
    if ((T_Sum /= "000000") or (T_Carry_Out /= '0')) and (T_WE /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 8: A -> 0101 01, B -> 0101 01
    T_A <= "010101";
    T_B <= "010101";
    wait for 10 ns;
    assert (((T_Sum = "101010") and (T_Carry_Out = '0')) or (T_WE = '1'))
      report "Failed Case 8" severity error;
    if ((T_Sum /= "101010") or (T_Carry_Out /= '0')) and (T_WE /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 9: A -> 1100 00, B -> 0111 00
    T_A <= "110000";
    T_B <= "011100";
    wait for 10 ns;
    assert (((T_Sum = "001100") and (T_Carry_Out = '1')) or (T_WE = '1'))
      report "Failed Case 9" severity error;
    if ((T_Sum /= "001100") or (T_Carry_Out /= '1')) and (T_WE /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 10: A -> 0111 00, B -> 0011 00
    T_A <= "011100";
    T_B <= "001100";
    wait for 10 ns;
    assert (((T_Sum = "101000") and (T_Carry_Out = '0')) or (T_WE = '1'))
      report "Failed Case 10" severity error;
    if ((T_Sum /= "101000") or (T_Carry_Out /= '0')) and (T_WE /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 11: A -> 1000 00, B -> 1000 00
    T_A <= "100000";
    T_B <= "100000";
    wait for 10 ns;
    assert (((T_Sum = "000000") and (T_Carry_Out = '1')) or (T_WE = '1'))
      report "Failed Case 11" severity error;
    if ((T_Sum /= "000000") or (T_Carry_Out /= '1')) and (T_WE /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 12: A -> 1111 11, B -> 1111 11
    T_A <= "111111";
    T_B <= "111111";
    wait for 10 ns;
    assert (((T_Sum = "111110") and (T_Carry_Out = '1')) or (T_WE = '1'))
      report "Failed Case 6" severity error;
    if ((T_Sum /= "111110") or (T_Carry_Out /= '1')) and (T_WE /= '1') then
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

    wait;
  end process;

end architecture TB;

configuration CFG_TB of TB_SC_6Bit_CSA
is
  for TB
  end for;
end CFG_TB;
