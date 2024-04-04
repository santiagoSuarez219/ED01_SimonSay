library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimSimonSays is
--  Port ( );
end SimSimonSays;

architecture Behavioral of SimSimonSays is

component eSimonSays is
    Port (
        CLK, RST, enter: in std_logic;
        salidaMux1: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux2: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux3: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux4: out STD_LOGIC_VECTOR(3 downto 0);
        secuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eSimonSays;

signal salidaMux1, salidaMux2, salidaMux3, salidaMux4, secuencia: STD_LOGIC_VECTOR(3 downto 0);
signal CLK, RST, enter : STD_LOGIC;


begin

SimSimonSays: eSimonSays port map (
    CLK => CLK,
    RST => RST,
    enter => enter,
    salidaMux1 => salidaMux1,
    salidaMux2 => salidaMux2,
    salidaMux3 => salidaMux3,
    salidaMux4 => salidaMux4,
    secuencia => secuencia
);

P_CLK: process
    begin
    CLK <= '1';
    wait for 5 ns;
    CLK <= '0';
    wait for 5 ns;
end process;


procEstimulos: process
    begin
        RST <= '1';
        enter <= '0';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        enter <= '1';
        wait for 20 ns;
        enter <= '0';
        wait for 100 ns;
        wait;

end process;

end Behavioral;
