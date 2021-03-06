library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity TB_MUX
is
end TB_MUX;

architecture TB of TB_MUX
is

  constant Size: Positive := 4;

  component MUX
  is
    generic (Width: Positive := 4);
    port (A, B: in Std_Logic_Vector (Size - 1 downto 0);
          Control: in Std_Logic;
          Output: out Std_Logic_Vector (Size - 1 downto 0));
  end component MUX;

  signal T_A, T_B, T_Output: Std_Logic_Vector (3 downto 0);
  signal T_Control: Std_Logic;

begin

  TMUX: MUX
    generic map (Width => Size)
    port map (A => T_A, B => T_B, Control => T_Control, Output => T_Output);

  process
    variable Err_Cnt: Integer := 0;
  begin
    T_A <= "1111";
    T_B <= "0000";

    -- Test Case 1: Control -> 0
    T_Control <= '0';
    wait for 10 ns;
    assert (T_Output = "1111")
      report "Failed Test Case 1" severity error;
    if T_Output /= "1111" then
      Err_Cnt := Err_Cnt + 1;
    end if;

    -- Test Case 2: Control -> 1
    T_Control <= '1';    
    wait for 10 ns;
    assert (T_Output = "0000")
      report "Failed Test Case 2" severity error;
    if T_Output /= "0000" then
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

