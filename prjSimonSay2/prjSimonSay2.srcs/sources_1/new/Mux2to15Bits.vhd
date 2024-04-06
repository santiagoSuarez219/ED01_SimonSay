
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux2to15Bits is
    Port ( 
        I0 : in STD_LOGIC_VECTOR(4 downto 0);
        I1 : in STD_LOGIC_VECTOR(4 downto 0);
        S: in STD_LOGIC;
        O: out STD_LOGIC_VECTOR(4 downto 0)
    );
end Mux2to15Bits;

architecture Behavioral of Mux2to15Bits is

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




