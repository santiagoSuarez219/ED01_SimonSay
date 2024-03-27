library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimSimonSays is
--  Port ( );
end SimSimonSays;

architecture Behavioral of SimSimonSays is

component eSimonSays is
    Port ( 
        CLK, RST: in STD_LOGIC;
        enter, aButton, bButton, cButton, dButton: in std_logic;
        ledMux, cantidadVidas: out std_logic;
        puntaje: out std_logic_vector(7 downto 0);
        cronometro: out std_logic_vector(2 downto 0)
    );
end component eSimonSays;

signal CLK, RST, enter, aButton, bButton, cButton, dButton: STD_LOGIC;
signal ledMux, cantidadVidas: std_logic;
signal puntaje: std_logic_vector(7 downto 0);
signal cronometro: std_logic_vector(2 downto 0);

begin

InstSimonSays: eSimonSays port map(
    CLK => CLK,
    RST => RST,
    enter => enter,
    aButton => aButton,
    bButton => bButton,
    cButton => cButton,
    dButton => dButton,
    ledMux => ledMux,
    cantidadVidas => cantidadVidas,
    puntaje => puntaje,
    cronometro => cronometro
);

P_CLK: process
    begin
    wait for 5 ns;
    CLK <= not CLK;
end process;

procEstimulos: process
    begin
        -- Presionar BTN reset
        enter <= '0';
        aButton <= '0';
        bButton <= '0';
        cButton <= '0';
        dButton <= '0'; 
        RST <= '1';
        wait for 17 ns;
        -- Soltar BTN reset
        RST <= '0';
        wait for 10 ns;

        -- Presionar BTN enter
        enter <= '1';
        wait for 11 ns;
        -- Soltar BTN enter
        enter <= '0';
end process;
end Behavioral;
