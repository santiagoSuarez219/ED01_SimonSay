library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop4Bits is
    Port ( 
        D: in STD_LOGIC_VECTOR(3 downto 0); 
        CLK, RST, EN: in STD_LOGIC;
        Q: out STD_LOGIC_VECTOR(3 downto 0)
    );
end FlipFlop4Bits;

architecture Behavioral of FlipFlop4Bits is

begin
    process(CLK, RST)
    begin
        if (RST = '1') then
            Q <= "0000";
        elsif (rising_edge(CLK) and EN = '1') then
            Q <= D;
        end if;
    end process; 

end Behavioral;
