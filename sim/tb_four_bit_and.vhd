library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_Four_Bit_And
is
end TB_Four_Bit_And;

architecture TB of TB_Four_Bit_And
is

  component Four_Bit_And
  is
    port (A, B: in Std_Logic_Vector (3 downto 0);
          R: out Std_Logic_Vector (3 downto 0));
  end component Four_Bit_And;

  signal T_A, T_B, T_R: Std_Logic_Vector (3 downto 0);

begin

  FBA: Four_Bit_And port map (A => T_A, B => T_B, R => T_R);

  process
    variable Err_Cnt: Integer := 0;
  begin
    -- Test Case 1: A -> 0000, B -> 0000
    T_A <= "0000";
    T_B <= "0000";
    wait for 10 ns;
    assert (T_R = "0000")
      report "Failed Test Case 1" severity error;
    if T_R /= "0000" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: A -> 1111, B -> 0000
    T_A <= "1111";
    T_B <= "0000";
    wait for 10 ns;
    assert (T_R = "0000")
      report "Failed Test Case 2" severity error;
    if T_R /= "0000" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 3: A -> 1111, B -> 1111
    T_A <= "1111";
    T_B <= "1111";
    wait for 10 ns;
    assert (T_R = "1111")
      report "Failed Test Case 3" severity error;
    if T_R /= "1111" then
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

configuration CFG_TB of TB_Four_Bit_And
is
  for TB
  end for;
end CFG_TB;
