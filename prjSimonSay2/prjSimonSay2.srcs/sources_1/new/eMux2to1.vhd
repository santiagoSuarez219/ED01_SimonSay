library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eMux2to1 is
    Port ( 
        I0 : in STD_LOGIC_VECTOR(3 downto 0);
        I1 : in STD_LOGIC_VECTOR(3 downto 0);
        S: in STD_LOGIC;
        O: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eMux2to1;

architecture Behavioral of eMux2to1 is

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
