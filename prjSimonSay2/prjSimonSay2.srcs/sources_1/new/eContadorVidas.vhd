library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity eContadorVidas is
    Port ( 
        CLK, RST, SumarVida, RestarVida  : in STD_LOGIC;
        vidasOut : out integer range 0 to 2
    );
end eContadorVidas;

architecture Behavioral of eContadorVidas is

begin
    process(RST, SumarVida, RestarVida)
        variable vidasInt : integer range 0 to 1 := 0;
    begin
        if RST = '1' then
            vidasInt := 0;
        end if;
        if SumarVida = '1' then
            vidasInt := 1;
        end if;
        if RestarVida = '1' then
            vidasInt := 0;
        end if;
        vidasOut <= vidasInt;
    end process;


end Behavioral;