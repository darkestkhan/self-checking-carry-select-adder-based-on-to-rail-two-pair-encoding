library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_CSA_Part
is
end TB_CSA_Part;

architecture TB of TB_CSA_Part
is

  constant Width: Positive := 4;

  component CSA_Part
  is
    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Sum: out Std_Logic_Vector (Width - 1 downto 0);
          Control_In: in Std_Logic;
          Control_Out: out Std_Logic);

  end component CSA_Part;

  signal T_A, T_B, T_Sum: Std_Logic_Vector (Width - 1 downto 0);
  signal T_Control_In, T_Control_Out: Std_Logic;

begin

  FBA: CSA_Part -- testing for 4 bit
    generic map (Width => 4)
    port map (A => T_A, B => T_B, Sum => T_Sum, Control_In => T_Control_In, Control_Out => T_Control_Out);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- First we will be testing for Control_In 0, after that the same test for Control_In 1
    T_Control_In <= '0';

    -- Test Case 1: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Control_Out = '0'))
      report "Failed Case 1" severity error;
    if (T_Sum /= "0000") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 0101, B -> 0101
    T_A <= "0101";
    T_B <= "0101";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Control_Out = '0'))
      report "Failed Case 2" severity error;
    if (T_Sum /= "1010") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1100, B -> 0111
    T_A <= "1100";
    T_B <= "0111";
    wait for 10 ns;
    assert ((T_Sum = "0011") and (T_Control_Out = '1'))
      report "Failed Case 3" severity error;
    if (T_Sum /= "0011") or (T_Control_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 4: A -> 0111, B -> 0011
    T_A <= "0111";
    T_B <= "0011";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Control_Out = '0'))
      report "Failed Case 4" severity error;
    if (T_Sum /= "1010") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 5: A -> 1000, B -> 1000
    T_A <= "1000";
    T_B <= "1000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Control_Out = '1'))
      report "Failed Case 5" severity error;
    if (T_Sum /= "0000") or (T_Control_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 6: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert ((T_Sum = "1110") and (T_Control_Out = '1'))
      report "Failed Case 6" severity error;
    if (T_Sum /= "1110") or (T_Control_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    T_Control_In <= '1';

    -- Test Case 7: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert ((T_Sum = "0001") and (T_Control_Out = '0'))
      report "Failed Case 7" severity error;
    if (T_Sum /= "0001") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 8: A -> 0101, B -> 0101
    T_A <= "0101";
    T_B <= "0101";
    wait for 10 ns;
    assert ((T_Sum = "1011") and (T_Control_Out = '0'))
      report "Failed Case 8" severity error;
    if (T_Sum /= "1011") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 9: A -> 1100, B -> 0111
    T_A <= "1100";
    T_B <= "0111";
    wait for 10 ns;
    assert ((T_Sum = "0110") and (T_Control_Out = '1'))
      report "Failed Case 9" severity error;
    if (T_Sum /= "0110") or (T_Control_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 10: A -> 0111, B -> 0011
    T_A <= "0111";
    T_B <= "0011";
    wait for 10 ns;
    assert ((T_Sum = "1011") and (T_Control_Out = '0'))
      report "Failed Case 10" severity error;
    if (T_Sum /= "1011") or (T_Control_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 11: A -> 1000, B -> 1000
    T_A <= "1000";
    T_B <= "1000";
    wait for 10 ns;
    assert ((T_Sum = "0001") and (T_Control_Out = '1'))
      report "Failed Case 10" severity error;
    if (T_Sum /= "0001") or (T_Control_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 12: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert ((T_Sum = "1111") and (T_Control_Out = '1'))
      report "Failed Case 12" severity error;
    if (T_Sum /= "1111") or (T_Control_Out /= '1') then
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

configuration CFG_TB of TB_CSA_Part
is
  for TB
  end for;
end CFG_TB;

