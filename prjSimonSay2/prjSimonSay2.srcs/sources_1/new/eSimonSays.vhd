library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSimonSays is
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
end eSimonSays;

architecture Behavioral of eSimonSays is

component eMux2to1 is
    Port (
        I0 : in STD_LOGIC_VECTOR(3 downto 0);
        I1 : in STD_LOGIC_VECTOR(3 downto 0);
        S: in STD_LOGIC;
        O: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eMux2to1;

component eStateMachine is
    Port ( 
        CLK, RST, enter, iSecuenciaAleatoriaT, A,B,C,D, indicadorCero, esIgualSecuencia, notEsIgualSecuencia, cronometroPuntaje, indicadorCronometroFin: in std_logic;
        aciertosCantidad: in integer range 0 to 32;
        cantidadVidas: in integer range 0 to 2;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro, rstCtoComparador, selectorSecuenciaAleatoriaMux, enCtoComparador, sumarPuntaje, rstPuntaje, rstCronometroPuntaje, rstVidas, sumarVida, restarVida, rstRegistroUsuario, selectorMuxFinJuego, finJuego: out STD_LOGIC;
        cantidadSumarPuntaje: out integer range 0 to 244;
        longitudSecuencia: out integer range 3 to 32;
        iSecuenciaUsuario_dir: out integer range 0 to 31;
        iSecuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eStateMachine;

component eSecuenciaAleatoria is
    Port (
        modoDemo: in STD_LOGIC;
        selectorSecuencia: in STD_LOGIC_VECTOR(4 downto 0);
        outSecuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eSecuenciaAleatoria;

component rSecuenciaUsuario is
    Port (
        RST: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(3 downto 0);
        input_dir: in integer range 0 to 31; -- Puntero
        Selector: in integer range 0 to 31; -- Lo utiliza el comparador
        output: out STD_LOGIC_VECTOR(3 downto 0) --Lo utiliza el comparador
    );
end component rSecuenciaUsuario;

component eContadorSecuencia is
    Port ( 
        CLK, RST: in STD_LOGIC;
        longitudSecuencia: in integer range 4 to 32;
        indicadorSecuenciaTerminada: out STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(4 downto 0)
    );
end component eContadorSecuencia;

component eCronometro is
    generic(
        cuenta : integer range 3 to 6 := 3
    );
    Port ( 
        CLK, RST : in STD_LOGIC;
        indicadorCero: out STD_LOGIC;
        outCuenta : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eCronometro;

component e1BitMux2 is
    Port ( 
        I0, I1, S: in STD_LOGIC;
        O: out STD_LOGIC
    );
end component e1BitMux2;

component CtoComparador is
    Port (
        CLK, RST, EN, cronometroIndicador: in STD_LOGIC;
        valorSecuenciaAleatoria, valorRegistro: in STD_LOGIC_VECTOR (3 downto 0);
        longitudSecuencia: in integer range 3 to 32; 
        aciertos: out integer range 0 to 32;
        esIgual,notEsIgual, rstCronometro, indicadorCronometroFin: out STD_LOGIC;
        selectorSecuencia: out STD_LOGIC_VECTOR (4 downto 0);
        selectorRegistro: out integer range 0 to 31
    );
end component CtoComparador;


component Mux2to15Bits is
    Port ( 
        I0 : in STD_LOGIC_VECTOR(4 downto 0);
        I1 : in STD_LOGIC_VECTOR(4 downto 0);
        S: in STD_LOGIC;
        O: out STD_LOGIC_VECTOR(4 downto 0)
    );
end component Mux2to15Bits;

component Mux2to1Integer is
    Port ( 
        I0 : in integer range 0 to 32;
        I1 : in integer range 0 to 32;
        S: in STD_LOGIC;
        O: out integer range 0 to 32
    );
end component Mux2to1Integer;

component eContadorPuntaje is
    Port ( 
        CLK, RST, sumarPuntaje: in STD_LOGIC;
        cantidadSumar: in integer range 0 to 244;
        puntajeOut : out integer range 0 to 4096
    );
end component eContadorPuntaje;

component eContadorVidas is
    Port ( 
        CLK, RST, SumarVida, RestarVida  : in STD_LOGIC;
        vidasOut : out integer range 0 to 2
    );
end component eContadorVidas;

component slowClock is
    Port ( fastClock : in STD_LOGIC;
           slowClock : inout STD_LOGIC;
           prescaler : in INTEGER RANGE 0 TO 50000000);
end component slowClock;

signal selectorSecuenciaMux_i, enableSecuenciaOut_i, indicadorSecuenciaTerminada_i, rstSecuenciaAleatoria_i, indicadorCero_i, rstCronometro_i, CLKBotones_i, rstCtoComparador_i, selectorSecuenciaAleatoriaMux_i, enCtoComparador_i, ledVictoria_i, cronometroIndicadorComparador_i, rstCronometroComparador_i, notEsIgual_i, sumarPuntaje_i, rstPuntaje_i, rstCronometroPuntaje_i, cronometroPuntaje_i, rstVidas_i,sumarVida_i, restarVida_i, rstRegistroUsuario_i, selectorMuxFinJuego_i, finJuego_i,indicadorCronometroFin_i, clkContadorSecuencia_i: STD_LOGIC;
signal outSecuencia_i,iSecuenciaUsuario_i, outRegistroSecUsu_i, outCuentaComparador, outCuentaPuntaje : STD_LOGIC_VECTOR(3 downto 0);
signal Q_i, selectorSecuencia_i, selectorSecuenciaComparador_i: STD_LOGIC_VECTOR(4 downto 0);
signal longitudSecuencia_i: integer range 3 to 32 := 3;
signal aciertos_i: integer range 0 to 32 := 0;
signal iSecuenciaUsuario_dir_i: integer range 0 to 31;
signal selectorSecuenciaUsuario_i, selectorSecuenciaUsuarioMux_i: integer range 0 to 31;
signal cantidadSumar_i: integer range 0 to 244;
signal vidasOut_i: integer range 0 to 2;

begin
    Inst5Mux2to1: eMux2to1 port map(I0 => "0000", I1 => outSecuencia_i, S => selectorSecuenciaMux_i, O => secuencia);
    InstStateMachine: eStateMachine port map(
        CLK => CLK, 
        RST => RST, 
        enter => enter,
        iSecuenciaAleatoriaT => indicadorSecuenciaTerminada_i,
        A => A,
        B => B,
        C => C,
        D => D,
        indicadorCero => indicadorCero_i,
        esIgualSecuencia => ledVictoria_i,
        notEsIgualSecuencia => notEsIgual_i,
        cronometroPuntaje => cronometroPuntaje_i,
        indicadorCronometroFin => indicadorCronometroFin_i,
        cantidadVidas => vidasOut_i,
        S => selectorMensaje,
        selectorSecuenciaMux => selectorSecuenciaMux_i,
        rstSecuenciaAleatoria => rstSecuenciaAleatoria_i,
        rstCronometro => rstCronometro_i,
        rstCtoComparador  => rstCtoComparador_i,
        selectorSecuenciaAleatoriaMux => selectorSecuenciaAleatoriaMux_i,
        enCtoComparador => enCtoComparador_i,
        sumarPuntaje => sumarPuntaje_i,
        rstPuntaje => rstPuntaje_i,
        rstCronometroPuntaje => rstCronometroPuntaje_i,
        rstVidas => rstVidas_i,
        sumarVida => sumarVida_i,
        restarVida => restarVida_i,
        rstRegistroUsuario => rstRegistroUsuario_i,
        selectorMuxFinJuego => selectorMuxFinJuego_i,
        finJuego => finJuego_i,
        aciertosCantidad => aciertos_i,
        cantidadSumarPuntaje => cantidadSumar_i,
        longitudSecuencia => longitudSecuencia_i,
        iSecuenciaUsuario_dir => iSecuenciaUsuario_dir_i,
        iSecuenciaUsuario => iSecuenciaUsuario_i
    );

    InstSecuenciaAleatoria: eSecuenciaAleatoria port map(
        modoDemo => modoDemo,
        selectorSecuencia => selectorSecuencia_i,
        outSecuencia => outSecuencia_i
    );
    InstContadorSecuencia: eContadorSecuencia port map(
        CLK => CLKLento,
        RST => rstSecuenciaAleatoria_i,
        longitudSecuencia => longitudSecuencia_i,
        indicadorSecuenciaTerminada => indicadorSecuenciaTerminada_i,
        Q => Q_i
    );
    InstCronometro: eCronometro generic map ( -- Cronometro de la secuencia
        cuenta => 3
    ) port map( 
        CLK => CLKLento,
        RST => rstCronometro_i,
        indicadorCero => indicadorCero_i,
        outCuenta => outCrometro
    );
    Inst2Cronometro: eCronometro generic map ( -- Cronometro LED Victoria
        cuenta => 5
    ) port map (
        CLK => CLK,
        RST => rstCronometroComparador_i, 
        indicadorCero => cronometroIndicadorComparador_i, 
        outCuenta => outCuentaComparador
    );
    Inst3Cronometro: eCronometro generic map (  -- CronometroPuntaje
        cuenta => 5
    ) port map (
        CLK => CLK,
        RST => rstCronometroPuntaje_i, 
        indicadorCero => cronometroPuntaje_i, 
        outCuenta => outCuentaPuntaje
    );
    InstSecuenciaUsuario: rSecuenciaUsuario port map(
        RST => rstRegistroUsuario_i,
        input => iSecuenciaUsuario_i,
        input_dir => iSecuenciaUsuario_dir_i,
        Selector => selectorSecuenciaUsuarioMux_i,
        output => outRegistroSecUsu_i
    );
    secuenciaUsuario <= iSecuenciaUsuario_i;
    
    --Titilen los leds
    Inst2BitMux2to1: e1BitMux2 port map( 
        I0 => '0',
        I1 => CLK,
        S => selectorMuxFinJuego_i,
        O => ledFinalJuego(0)
    );
    Inst3BitMux2to1: e1BitMux2 port map( 
        I0 => '0',
        I1 => CLK,
        S => selectorMuxFinJuego_i,
        O => ledFinalJuego(1)
    );
    Inst4BitMux2to1: e1BitMux2 port map( 
        I0 => '0',
        I1 => CLK,
        S => selectorMuxFinJuego_i,
        O => ledFinalJuego(2)
    );
    Inst5BitMux2to1: e1BitMux2 port map( 
        I0 => '0',
        I1 => CLK,
        S => selectorMuxFinJuego_i,
        O => ledFinalJuego(3)
    );
    InstCtoComparador: CtoComparador port map (
        CLK => CLK,
        RST => rstCtoComparador_i,
        EN => enCtoComparador_i,
        cronometroIndicador => cronometroIndicadorComparador_i,      
        valorSecuenciaAleatoria => outSecuencia_i,
        valorRegistro => outRegistroSecUsu_i,
        longitudSecuencia => longitudSecuencia_i,
        aciertos => aciertos_i,
        esIgual => ledVictoria_i,
        notEsIgual => notEsIgual_i,
        rstCronometro => rstCronometroComparador_i,
        indicadorCronometroFin => indicadorCronometroFin_i,
        selectorSecuencia => selectorSecuenciaComparador_i,
        selectorRegistro => selectorSecuenciaUsuario_i
    );
    ledVictoria <= ledVictoria_i;

    InstContadorVidas: eContadorVidas port map(
        CLK => CLK,
        RST => rstVidas_i,
        SumarVida => sumarVida_i,
        RestarVida => restarVida_i,
        vidasOut => vidasOut_i
    );
    vidasOut <= vidasOut_i;

    InsteContadorPuntaje: eContadorPuntaje port map(
        CLK => CLK,
        RST => rstPuntaje_i,
        sumarPuntaje => sumarPuntaje_i,
        cantidadSumar => cantidadSumar_i,
        puntajeOut => puntajeOut
    );

    InstMux2to15Bits: Mux2to15Bits port map ( 
            I0 => Q_i,
            I1 => selectorSecuenciaComparador_i,
            S => selectorSecuenciaAleatoriaMux_i,
            O => selectorSecuencia_i
    );

    InstMux2to1Integer: Mux2to1Integer port map ( 
            I0 => selectorSecuenciaUsuario_i,
            I1 => 1,
            S => rstCtoComparador_i,
            O => selectorSecuenciaUsuarioMux_i
    );

    InstSlowClockSecuencia: slowClock port map (  --Preescaler sin conectar
        fastClock => CLK,
        slowClock => clkContadorSecuencia_i,
        prescaler => 25000000
    );
        
end Behavioral;
