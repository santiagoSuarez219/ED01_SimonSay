library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimSimonSays is
--  Port ( );
end SimSimonSays;

architecture Behavioral of SimSimonSays is

component eSimonSays is
    Port (
        CLK, CLKBotones, RST, enter, A,B,C,D: in std_logic;
        salidaMux1: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux2: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux3: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux4: out STD_LOGIC_VECTOR(3 downto 0);
        secuencia: out STD_LOGIC_VECTOR(3 downto 0);
        secuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0);
        outCrometro: out STD_LOGIC_VECTOR(3 downto 0);
        ledVictoria: out STD_LOGIC
    );
end component eSimonSays;

signal salidaMux1, salidaMux2, salidaMux3, salidaMux4, secuencia, secuenciaUsuario, outCronometro: STD_LOGIC_VECTOR(3 downto 0);
signal CLK, RST, enter,A,B,C,D,CLKBotones, ledVictoria: STD_LOGIC;


begin

SimSimonSays: eSimonSays port map (
    CLK => CLK,
    RST => RST,
    enter => enter,
    A => A,
    B => B,
    C => C,
    D => D,
    CLKBotones => CLKBotones,
    salidaMux1 => salidaMux1,
    salidaMux2 => salidaMux2,
    salidaMux3 => salidaMux3,
    salidaMux4 => salidaMux4,
    secuencia => secuencia,
    secuenciaUsuario => secuenciaUsuario,
    outCrometro => outCronometro,
    ledVictoria => ledVictoria
);

P_CLK: process
    begin
    CLK <= '1';
    wait for 5 ns;
    CLK <= '0';
    wait for 5 ns;
end process;

P_CLK_BOTONES: process
    begin
    CLKBotones <= '1';
    wait for 120 ns;
    CLKBotones <= '0';
    wait for 120 ns;
end process;


procEstimulos: process
    begin
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        RST <= '1';
        enter <= '0';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        enter <= '1';
        wait for 20 ns;
        enter <= '0';
        wait for 100 ns;
        C <= '1';
        wait for 60 ns;
        C <= '0';
        wait for 60 ns;
        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        C <= '1';
        wait for 60 ns;
        C <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        enter <= '1';
        wait for 60 ns;
        enter <= '0';
        wait;

end process;

end Behavioral;
