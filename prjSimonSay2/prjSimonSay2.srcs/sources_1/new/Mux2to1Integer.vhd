library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1Integer is
    Port ( 
        I0 : in integer range 0 to 32;
        I1 : in integer range 0 to 32;
        S: in STD_LOGIC;
        O: out integer range 0 to 32
    );
end Mux2to1Integer;

architecture Behavioral of Mux2to1Integer is

begin
    process(S, I0, I1)
    begin
        if S = '0' then
            O <= I0;
        else
            O <= I1;
        end if;
    end process;


end Behavioral;
