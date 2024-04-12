library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSistema is
    Port (
        CLK, RST, enter, A,B,C,D, modoDemo: in std_logic;
        ledVictoria: out STD_LOGIC;
        ledFinalJuego: out STD_LOGIC_VECTOR(3 downto 0);
        catodos : out STD_LOGIC_VECTOR(7 downto 0);
        anodos : out STD_LOGIC_VECTOR(7 downto 0)
    );
end eSistema;

architecture Behavioral of eSistema is

component eSimonSays is
    Port (
        CLK, RST, enter, A,B,C,D, modoDemo: in std_logic;
        secuencia: out STD_LOGIC_VECTOR(3 downto 0);
        secuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0);
        outCrometro: out STD_LOGIC_VECTOR(3 downto 0);
        ledVictoria, selectorMensaje: out STD_LOGIC;
        ledFinalJuego: out STD_LOGIC_VECTOR(3 downto 0);
        vidasOut : out integer range 0 to 2;
        puntajeOut : out integer range 0 to 4096
    );
end component eSimonSays;

component display is
    Port (
        clk, S : in STD_LOGIC;
        secuencia, outCrometro, secuenciaUsuario: in STD_LOGIC_VECTOR(3 downto 0);
        puntaje : in integer range 0 to 4096;
        vidasInteger : in integer range 0 to 2;
        catodos : out STD_LOGIC_VECTOR(7 downto 0);
        anodos : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component display;

signal S: STD_LOGIC;
signal secuencia, outCrometro, secuenciaUsuario: STD_LOGIC_VECTOR(3 downto 0);
signal vidasOut : integer range 0 to 2;
signal puntajeOut : integer range 0 to 4096;

begin

InstSimonSay: eSimonSays port map (
    CLK => CLK, 
    RST => RST, 
    enter => enter, 
    A => A,
    B => B,
    C => C,
    D => D, 
    modoDemo => modoDemo,
    secuencia => secuencia,
    secuenciaUsuario => secuenciaUsuario,
    outCrometro => outCrometro, 
    ledVictoria => ledVictoria, 
    selectorMensaje => S,
    ledFinalJuego => ledFinalJuego,
    vidasOut => vidasOut,
    puntajeOut => puntajeOut
);

InstDisplay: display port map (
    clk => CLK,
    S => S,
    secuencia => secuencia,
    outCrometro => outCrometro,
    secuenciaUsuario => secuenciaUsuario,
    puntaje => puntajeOut,
    vidasInteger => vidasOut,
    catodos => catodos,
    anodos  => anodos
);


end Behavioral;
