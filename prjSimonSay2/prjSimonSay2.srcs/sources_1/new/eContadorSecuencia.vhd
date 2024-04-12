library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eContadorSecuencia is
    Port ( 
        CLK, RST: in STD_LOGIC;
        longitudSecuencia: in integer range 4 to 32;
        indicadorSecuenciaTerminada: out STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(4 downto 0)
    );
end eContadorSecuencia;

architecture Behavioral of eContadorSecuencia is

signal Q_i : STD_LOGIC_VECTOR(4 downto 0) := "00000";
signal i : integer range 0 to 32 := 0;

begin
    process(CLK, RST)
    begin
        if RST = '1' then
            Q_i <= "00000";
            i <= 1;
            indicadorSecuenciaTerminada <= '0';
        elsif rising_edge(CLK) then
            if i = longitudSecuencia then
                indicadorSecuenciaTerminada <= '1';
            else
                if Q_i = "11111" then
                    Q_i <= "00000";
                else
                    Q_i <= Q_i + 1;
                end if;
                i <= i + 1;
                indicadorSecuenciaTerminada <= '0';
            end if;                
        end if;
        Q <= Q_i;

    end process;


end Behavioral;
