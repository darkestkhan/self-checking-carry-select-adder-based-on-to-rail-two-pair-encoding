library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_RCA
is
end TB_RCA;

architecture TB of TB_RCA
is

  constant Width: Positive := 4;

  component RCA
  is
    generic (Width: Positive := 4; Carry_In: Std_Logic := '0');
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Fault: in Std_Logic_Vector ((2 * Width) - 1 downto 0);
          Sum: out Std_Logic_Vector (Width - 1 downto 0);
          Carry_Out: out Std_Logic);
  end component RCA;

  signal T_A, T_B, T_Sum: Std_Logic_Vector (Width - 1 downto 0);
  signal T_Carry_Out: Std_Logic;
  signal T_Fault: Std_Logic_Vector ((2 * Width) - 1 downto 0);
  -- used for simulation w/o carry in
  signal T_A1, T_B1, T_Sum1: Std_Logic_Vector (Width - 1 downto 0);
  signal T_Carry_Out1: Std_Logic;
  signal T_Fault1: Std_Logic_Vector ((2 * Width) - 1 downto 0);
  -- used for simulation with carry in

begin

  FBA: RCA -- testing for 4 bit case w/o carry in
    generic map (Width => 4, Carry_In => '0')
    port map (A => T_A, B => T_B, Fault => T_Fault, Sum => T_Sum, Carry_Out => T_Carry_Out);

  FBA1: RCA -- testing for 4 bit case with carry in
    generic map (Width => 4, Carry_In => '1')
    port map (A => T_A1, B => T_B1, Fault => T_Fault1, Sum => T_Sum1, Carry_Out => T_Carry_Out1);


  process
    variable Err_Cnt: Integer := 0;
  begin
    T_Fault <= "00000001";

    -- Test Case 1.1: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Carry_Out = '0'))
      report "Failed Case 1.1" severity error;
    if (T_Sum /= "0000") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.2: A -> 0101, B -> 0101
    T_A <= "0101";
    T_B <= "0101";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Carry_Out = '0'))
      report "Failed Case 1.2" severity error;
    if (T_Sum /= "1010") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.3: A -> 1100, B -> 0111
    T_A <= "1100";
    T_B <= "0111";
    wait for 10 ns;
    assert ((T_Sum = "0011") and (T_Carry_Out = '1'))
      report "Failed Case 1.3" severity error;
    if (T_Sum /= "0011") or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.4: A -> 0111, B -> 0011
    T_A <= "0111";
    T_B <= "0011";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Carry_Out = '0'))
      report "Failed Case 1.4" severity error;
    if (T_Sum /= "1010") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.5: A -> 1000, B -> 1000
    T_A <= "1000";
    T_B <= "1000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Carry_Out = '1'))
      report "Failed Case 1.5" severity error;
    if (T_Sum /= "0000") or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.6: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert ((T_Sum = "1110") and (T_Carry_Out = '1'))
      report "Failed Case 1.6" severity error;
    if (T_Sum /= "1110") or (T_Carry_Out /= '1') then
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

  process
    variable Err_Cnt: Integer := 0;
  begin
    T_Fault <= "00000001";

    -- Test Case 2.1: A -> 0000, B -> 0000
    T_A1 <= "0000";
    T_B1 <= "0000";
    wait for 10 ns;
    assert ((T_Sum1 = "0001") and (T_Carry_Out = '0'))
      report "Failed Case 2.1" severity error;
    if (T_Sum1 /= "0001") or (T_Carry_Out1 /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.2: A -> 0101, B -> 0101
    T_A1 <= "0101";
    T_B1 <= "0101";
    wait for 10 ns;
    assert ((T_Sum1 = "1011") and (T_Carry_Out1 = '0'))
      report "Failed Case 2.2" severity error;
    if (T_Sum1 /= "1011") or (T_Carry_Out1 /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.3: A -> 1100, B -> 0111
    T_A1 <= "1100";
    T_B1 <= "0111";
    wait for 10 ns;
    assert ((T_Sum1 = "0110") and (T_Carry_Out1 = '1'))
      report "Failed Case 2.3" severity error;
    if (T_Sum1 /= "0110") or (T_Carry_Out1 /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.4: A -> 0111, B -> 0011
    T_A1 <= "0111";
    T_B1 <= "0011";
    wait for 10 ns;
    assert ((T_Sum1 = "1011") and (T_Carry_Out1 = '0'))
      report "Failed Case 2.4" severity error;
    if (T_Sum1 /= "1011") or (T_Carry_Out1 /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.5: A -> 1000, B -> 1000
    T_A1 <= "1000";
    T_B1 <= "1000";
    wait for 10 ns;
    assert ((T_Sum1 = "0001") and (T_Carry_Out1 = '1'))
      report "Failed Case 2.5" severity error;
    if (T_Sum1 /= "0001") or (T_Carry_Out1 /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.6: A -> 1111, B -> 1111
    T_A1 <= "1111";
    T_B1 <= "1111";
    wait for 10 ns;
    assert ((T_Sum1 = "1111") and (T_Carry_Out1 = '1'))
      report "Failed Case 2.6" severity error;
    if (T_Sum1 /= "1111") or (T_Carry_Out1 /= '1') then
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

configuration CFG_TB of TB_RCA
is
  for TB
  end for;
end CFG_TB;
