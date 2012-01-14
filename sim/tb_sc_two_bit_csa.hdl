library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_SC_Two_Bit_CSA
is
end TB_SC_Two_Bit_CSA;

architecture TB of TB_SC_Two_Bit_CSA
is

  component SC_Two_Bit_CSA is
    port (A, B: in Std_Logic_Vector (1 downto 0);
          Fault: in Std_Logic_Vector (7 downto 0);
          Sum: out Std_Logic_Vector (1 downto 0);
          Cin: in Std_Logic;
          Cout: out Std_Logic;
          Encoded: out Std_Logic_Vector (1 downto 0);
          MUX_Error: out Std_Logic);
  end component SC_Two_Bit_CSA;

  signal T_A, T_B, T_Sum, T_Encoded: Std_Logic_Vector (1 downto 0);
  signal T_Cin, T_Cout, T_Mux_Error: Std_Logic;
  signal T_Fault: Std_Logic_Vector (7 downto 0);

begin

  TBA: SC_Two_Bit_CSA
    port map (A => T_A, B => T_B, Fault => T_Fault, Sum => T_Sum,
              Cin => T_Cin, Cout => T_Cout, Mux_Error => T_Mux_Error, Encoded => T_Encoded);

  process
    variable Err_Cnt: Integer := 0;
  begin
    T_Fault <= "00000001";
    -- First we will be testing for Control_In 0, after that the same test for Control_In 1
    T_Cin <= '0';

    -- Test Case 1: A -> 00, B -> 00
    T_A <= "00";
    T_B <= "00";
    wait for 10 ns;
    assert ((T_Sum = "00") and (T_Cout = '0') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 1" severity error;
    if (T_Sum /= "00") or (T_Cout /= '0') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 01, B -> 01
    T_A <= "01";
    T_B <= "01";
    wait for 10 ns;
    assert ((T_Sum = "10") and (T_Cout = '0') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 2" severity error;
    if (T_Sum /= "10") or (T_Cout /= '0') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 11, B -> 01
    T_A <= "11";
    T_B <= "01";
    wait for 10 ns;
    assert ((T_Sum = "00") and (T_Cout = '1') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 3" severity error;
    if (T_Sum /= "00") or (T_Cout /= '1') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
      Err_Cnt := Err_Cnt + 1;
    end if;

    T_Cin <= '1';

    -- Test Case 4: A -> 00, B -> 00
    T_A <= "00";
    T_B <= "00";
    wait for 10 ns;
    assert ((T_Sum = "01") and (T_Cout = '0') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 4" severity error;
    if (T_Sum /= "01") or (T_Cout /= '0') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 5: A -> 01, B -> 01
    T_A <= "01";
    T_B <= "01";
    wait for 10 ns;
    assert ((T_Sum = "11") and (T_Cout = '0') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 5" severity error;
    if (T_Sum /= "11") or (T_Cout /= '0') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 6: A -> 11, B -> 01
    T_A <= "11";
    T_B <= "01";
    wait for 10 ns;
    assert ((T_Sum = "01") and (T_Cout = '1') and (T_Mux_Error = '0') and (T_Encoded = "01" or T_Encoded = "10"))
      report "Failed Case 6" severity error;
    if (T_Sum /= "01") or (T_Cout /= '1') or (T_Mux_Error /= '0') or (T_Encoded /= "01") or (T_Encoded /= "10") then
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

configuration CFG_TB of TB_SC_Two_Bit_CSA
is
  for TB
  end for;
end CFG_TB;
