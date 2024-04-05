library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity e1BitMux2 is
    Port ( 
        I0, I1, S: in STD_LOGIC;
        O: out STD_LOGIC
    );
end e1BitMux2;

architecture Behavioral of e1BitMux2 is

begin
process(I0,I1,S)
    begin
    if S = '0'  then
        O <= I0;
    elsif S = '1' then
        O <= I1;
    end if;
end process;

end Behavioral;
