library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity eContadorVidas is
    Port ( 
        CLK, RST, SumarVida, RestarVida  : in STD_LOGIC;
        vidasOut : out STD_LOGIC
    );
end eContadorVidas;

architecture Behavioral of eContadorVidas is

begin
    process(CLK, RST)
        variable vidasInt : STD_LOGIC := '0';
    begin
        if RST = '1' then
            vidasInt := '0';
        elsif rising_edge(CLK) then
            if SumarVida = '1' then
                vidasInt := '1';
            end if;
            if RestarVida = '1' then
                vidasInt := '0';
            end if;
        end if;
        vidasOut <= vidasInt;
    end process;


end Behavioral;