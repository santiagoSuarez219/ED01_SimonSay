library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimSimonSays is
--  Port ( );
end SimSimonSays;

architecture Behavioral of SimSimonSays is

component eSimonSays is
    Port (
        CLK, CLKBotones, CLKLento, RST, enter, A,B,C,D, modoDemo: in std_logic;
        secuencia: out STD_LOGIC_VECTOR(3 downto 0);
        secuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0);
        outCrometro: out STD_LOGIC_VECTOR(3 downto 0);
        ledVictoria, selectorMensaje: out STD_LOGIC;
        ledFinalJuego: out STD_LOGIC_VECTOR(3 downto 0);
        vidasOut : out integer range 0 to 2;
        puntajeOut : out integer range 0 to 4096
    );
end component eSimonSays;


signal secuencia, secuenciaUsuario, outCronometro: STD_LOGIC_VECTOR(3 downto 0);
signal CLK, RST, enter,A,B,C,D,CLKBotones, CLKLento, ledVictoria, selectorMensaje, modoDemo: STD_LOGIC;
signal puntajeOut : integer range 0 to 2048;
signal vidasOut : integer range 0 to 2;
signal ledFinalJuego: STD_LOGIC_VECTOR(3 downto 0);


begin

SimSimonSays: eSimonSays port map (
    CLK => CLK,
    RST => RST,
    enter => enter,
    A => A,
    B => B,
    C => C,
    D => D,
    modoDemo => modoDemo,
    CLKBotones => CLKBotones,
    CLKLento => CLKLento,
    secuencia => secuencia,
    secuenciaUsuario => secuenciaUsuario,
    outCrometro => outCronometro,
    ledVictoria => ledVictoria,
    selectorMensaje => selectorMensaje,
    ledFinalJuego => ledFinalJuego,
    vidasOut => vidasOut,
    puntajeOut => puntajeOut
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
    wait for 10 ns;
    CLKBotones <= '0';
    wait for 10 ns;
end process;

P_CLK_LENTO: process
    begin
    CLKLento <= '1';
    wait for 40 ns;
    CLKLento <= '0';
    wait for 40 ns;
end process;


procEstimulos: process
    begin
        --Primera secuencia: el usuario gana
        A <= '0';
        B <= '0';
        C <= '0';
        D <= '0';
        RST <= '1';
        modoDemo <= '0';
        enter <= '0';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        enter <= '1';
        wait for 20 ns;
        enter <= '0';
        wait for 320 ns;

        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        B <= '1';
        wait for 60 ns;
        B <= '0';
        wait for 60 ns;
        enter <= '1';
        wait for 60 ns;
        enter <= '0';
        wait for 600 ns;

        --Primera secuencia: el usuario gana, aumenta en 1 la secuencia
        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        B <= '1';
        wait for 60 ns;
        B <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        enter <= '1';
        wait for 60 ns;
        enter <= '0';        
        wait for 650 ns;

        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        A <= '1';
        wait for 60 ns;
        A <= '0';
        wait for 60 ns;
        B <= '1';
        wait for 60 ns;
        B <= '0';
        wait for 60 ns;
        D <= '1';
        wait for 60 ns;
        D <= '0';
        wait for 60 ns;
        C <= '1';
        wait for 60 ns;
        C <= '0';
        wait for 60 ns;
        enter <= '1';
        wait for 60 ns;
        enter <= '0';        
        wait for 730 ns;

        -- El usuario pierde, la secuencia no es igual
        A <= '1';
        wait for 50 ns;
        A <= '0';
        wait for 50 ns;
        D <= '1';
        wait for 50 ns;
        D <= '0';
        wait for 50 ns;
        A <= '1';
        wait for 50 ns;
        A <= '0';
        wait for 50 ns;
        B <= '1';
        wait for 50 ns;
        B <= '0';
        wait for 50 ns;
        A <= '1'; -- Esta no la acierta
        wait for 50 ns;
        A <= '0';
        wait for 50 ns;
        C <= '1';
        wait for 50 ns;
        C <= '0';
        wait for 50 ns;
        D <= '1';
        wait for 50 ns;
        D <= '0';
        enter <= '1';
        wait for 50 ns;
        enter <= '0';        
        wait for 200 ns;

        --EL CRONOMETRO LLEGA A CERO
        -- A <= '1';
        -- wait for 50 ns;
        -- A <= '0';
        -- wait for 50 ns;
        -- D <= '1';
        -- wait for 50 ns;
        -- D <= '0';
        -- wait for 50 ns;

        -- MODO DEMO
        -- A <= '1';
        -- wait for 60 ns;
        -- A <= '0';
        -- wait for 60 ns;
        -- B <= '1';
        -- wait for 60 ns;
        -- B <= '0';
        -- wait for 60 ns;
        -- C <= '1';
        -- wait for 60 ns;
        -- C <= '0';
        -- wait for 60 ns;
        -- D <= '1';
        -- wait for 60 ns;
        -- D <= '0';
        -- wait for 60 ns;
        -- enter <= '1';
        -- wait for 60 ns;
        -- enter <= '0';
        -- wait for 200 ns;

        -- A <= '1';
        -- wait for 60 ns;
        -- A <= '0';
        -- wait for 60 ns;
        -- B <= '1';
        -- wait for 60 ns;
        -- B <= '0';
        -- wait for 60 ns;
        -- C <= '1';
        -- wait for 60 ns;
        -- C <= '0';
        -- wait for 60 ns;
        -- D <= '1';
        -- wait for 60 ns;
        -- D <= '0';
        -- wait for 60 ns;
        -- A <= '1';
        -- wait for 60 ns;
        -- A <= '0';
        -- wait for 60 ns;
        -- enter <= '1';
        -- wait for 60 ns;
        -- enter <= '0';        
        -- wait for 200 ns;

        -- A <= '1';
        -- wait for 60 ns;
        -- A <= '0';
        -- wait for 60 ns;
        -- B <= '1';
        -- wait for 60 ns;
        -- B <= '0';
        -- wait for 60 ns;
        -- C <= '1';
        -- wait for 60 ns;
        -- C <= '0';
        -- wait for 60 ns;
        -- D <= '1';
        -- wait for 60 ns;
        -- D <= '0';
        -- wait for 60 ns;
        -- A <= '1';
        -- wait for 60 ns;
        -- A <= '0';
        -- wait for 60 ns;
        -- B <= '1';
        -- wait for 60 ns;
        -- B <= '0';
        -- wait for 60 ns;
        -- enter <= '1';
        -- wait for 60 ns;
        -- enter <= '0';        
        -- wait for 200 ns;

        wait;


end process;

end Behavioral;
