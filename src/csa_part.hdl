library IEEE;
use IEEE.Std_Logic_1164.all;

entity CSA_Part is

  generic (Width: Positive := 4);
  port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
        Sum: out Std_Logic_Vector (Width - 1 downto 0);
        Control_In: in Std_Logic;
        Control_Out: out Std_Logic);

end CSA_Part;

architecture Structure of CSA_Part
is

  component MUX is
    generic (Width: Positive := Width);
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Control: in Std_Logic;
          Output: out Std_Logic_Vector (Width - 1 downto 0));
  end component MUX;

  component RCA is
    generic (Width: Positive := Width; Carry_In: Std_Logic := '0');
    port (A, B: in Std_Logic_Vector (Width - 1 downto 0);
          Sum: out Std_Logic_Vector (Width - 1 downto 0);
          Carry_Out: out Std_Logic);
  end component RCA;

  -- WOC for Without_Carry, WC for With_Carry, Co for Carry_Out
  signal WOC_Co, WC_Co: Std_Logic_Vector (0 downto 0);
  signal WOC_Sum, WC_Sum: Std_Logic_Vector (Width - 1 downto 0);

begin

  WOC: RCA
    generic map (Width => Width, Carry_In => '0')
    port map (A => A, B => B, Sum => WOC_Sum, Carry_Out => WOC_Co (0));
  WC: RCA
    generic map (Width => Width, Carry_In => '1')
    port map (A => A, B => B, Sum => WC_Sum, Carry_Out => WC_Co (0));
  Result: MUX
    generic map (Width => Width)
    port map (A => WOC_Sum, B => WC_Sum, Control => Control_In, Output => Sum);
  Next_Control: MUX
    generic map (Width => 1)
    port map (A => WOC_Co, B => WC_Co, Control => Control_In, Output (0) => Control_Out);

end Structure;
