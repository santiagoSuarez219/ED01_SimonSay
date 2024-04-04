library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eContadorSecuencia is
    Port ( 
        CLK, RST: in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(4 downto 0)
    );
end eContadorSecuencia;

architecture Behavioral of eContadorSecuencia is

signal Q_i : STD_LOGIC_VECTOR(4 downto 0) := "00000";

begin
    process(CLK, RST)
    begin
        if RST = '1' then
            Q <= "00000";
        elsif rising_edge(CLK) then
            if Q_i = "11111" then
                Q_i <= "00000";
            else
                Q_i <= Q_i + 1;
            end if;
            Q <= Q_i;
        end if;

    end process;


end Behavioral;
