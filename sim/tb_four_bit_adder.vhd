library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_Four_Bit_Adder
is
end TB_Four_Bit_Adder;

architecture TB of TB_Four_Bit_Adder
is

  component Four_Bit_Adder
  is
    port (A, B: in Std_Logic_Vector (3 downto 0);
          Sum: out Std_Logic_Vector (3 downto 0);
          Carry_Out: out Std_Logic);
  end component Four_Bit_Adder;

  signal T_A, T_B, T_Sum: Std_Logic_Vector (3 downto 0);
  signal T_Carry_Out: Std_Logic;

begin

  FBA: Four_Bit_Adder port map (A => T_A, B => T_B, Sum => T_Sum, Carry_Out => T_Carry_Out);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 1: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Carry_Out = '0'))
      report "Failed Case 1" severity error;
    if (T_Sum /= "0000") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 0101, B -> 0101
    T_A <= "0101";
    T_B <= "0101";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Carry_Out = '0'))
      report "Failed Case 2" severity error;
    if (T_Sum /= "1010") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1100, B -> 0111
    T_A <= "1100";
    T_B <= "0111";
    wait for 10 ns;
    assert ((T_Sum = "0011") and (T_Carry_Out = '1'))
      report "Failed Case 3" severity error;
    if (T_Sum /= "0011") or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 4: A -> 0111, B -> 0011
    T_A <= "0111";
    T_B <= "0011";
    wait for 10 ns;
    assert ((T_Sum = "1010") and (T_Carry_Out = '0'))
      report "Failed Case 4" severity error;
    if (T_Sum /= "1010") or (T_Carry_Out /= '0') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 5: A -> 1000, B -> 1000
    T_A <= "1000";
    T_B <= "1000";
    wait for 10 ns;
    assert ((T_Sum = "0000") and (T_Carry_Out = '1'))
      report "Failed Case 5" severity error;
    if (T_Sum /= "0000") or (T_Carry_Out /= '1') then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 6: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert ((T_Sum = "1110") and (T_Carry_Out = '1'))
      report "Failed Case 6" severity error;
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

end architecture TB;

configuration CFG_TB of TB_Four_Bit_Adder
is
  for TB
  end for;
end CFG_TB;
