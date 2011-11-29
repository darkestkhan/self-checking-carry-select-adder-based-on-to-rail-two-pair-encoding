library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_N_Bit_And
is
end TB_N_Bit_And;

architecture TB of TB_N_Bit_And
is

  constant Size: Natural := 4;
  constant Size_8: Natural := 8;

  component N_Bit_And

    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          R: out Std_Logic_Vector (Width - 1 downto 0));
  end component N_Bit_And;

  signal T_A, T_B, T_R: Std_Logic_Vector (Size - 1 downto 0);
  signal ETA, ETB, ETR: Std_Logic_Vector (Size_8 - 1 downto 0);

begin

  FBA: N_Bit_And
    generic map (Width => 4)
    port map (A => T_A, B => T_B, R => T_R);

  EBA: N_Bit_And
    generic map (Width => 8)
    port map (A => ETA, B => ETB, R => ETR);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 1.1: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert (T_R = "0000")
      report "Failed Test Case 1.1" severity error;
    if T_R /= "0000" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.2: A -> 1111, B -> 0000
    T_A <= "1111";
    T_B <= "0000";
    wait for 10 ns;
    assert (T_R = "0000")
      report "Failed Test Case 1.2" severity error;
    if T_R /= "0000" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 1.3: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert (T_R = "1111")
      report "Failed Test Case 1.3" severity error;
    if T_R /= "1111" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- summary
    if Err_Cnt = 0 then
      assert false
        report "Testbench 1 Completed Succesfully!" severity note;
    else
      assert true
        report "Something has gone wrong in 1, try again later!" severity error;
    end if;

    wait;
  end process;

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 2.1: A -> 1111 1111, B -> 0000 1111
    ETA <= "11111111";
    ETB <= "00001111";
    wait for 10 ns;
    assert (ETR = "00001111")
      report "Failed Test Case 2.1" severity error;
    if ETR /= "00001111" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.2: A -> 0000 0000, B -> 0000 0000
    ETA <= "00000000";
    ETB <= "00000000";
    wait for 10 ns;
    assert (ETR = "00000000")
      report "Failed Test Case 2.2" severity error;
    if ETR /= "00000000" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2.3: A -> 1111 1111, B -> 1111 1111
    ETA <= "11111111";
    ETB <= "11111111";
    wait for 10 ns;
    assert (ETR = "11111111")
      report "Failed Test Case 2.3" severity error;
    if ETR /= "11111111" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- summary
    if Err_Cnt = 0 then
      assert false
        report "Testbench 2 Completed Succesfully!" severity note;
    else
      assert true
        report "Something has gone wrong in 2, try again later!" severity error;
    end if;

    wait;
  end process;

end architecture TB;

configuration CFG_TB of TB_N_Bit_And
is
  for TB
  end for;
end CFG_TB;

