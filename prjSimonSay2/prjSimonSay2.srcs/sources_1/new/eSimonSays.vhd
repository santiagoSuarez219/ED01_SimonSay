library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSimonSays is
    Port (
        CLK, CLKBotones, RST, enter, A,B,C,D: in std_logic;
        salidaMux1: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux2: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux3: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux4: out STD_LOGIC_VECTOR(3 downto 0);
        secuencia: out STD_LOGIC_VECTOR(3 downto 0);
        secuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0);
        outCrometro: out STD_LOGIC_VECTOR(3 downto 0)
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
        CLK, RST, enter, iSecuenciaAleatoriaT, A,B,C,D, CLKBotones, indicadorCero: in std_logic;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro, selectorClkSecuencia: out STD_LOGIC;
        longitudSecuencia: out integer range 4 to 32;
        iSecuenciaUsuario_dir: out integer range 0 to 31;
        iSecuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eStateMachine;

component eSecuenciaAleatoria is
    Port ( 
        selectorSecuencia: in STD_LOGIC_VECTOR(4 downto 0);
        outSecuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eSecuenciaAleatoria;

component rSecuenciaUsuario is
    Port ( 
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

signal S_i, selectorSecuenciaMux_i, enableSecuenciaOut_i, indicadorSecuenciaTerminada_i, rstSecuenciaAleatoria_i, indicadorCero_i, rstCronometro_i, CLKBotones_i, selectorClkSecuencia_i: STD_LOGIC;
signal outSecuencia_i,iSecuenciaUsuario_i, outRegistroSecUsu_i: STD_LOGIC_VECTOR(3 downto 0);
signal Q_i : STD_LOGIC_VECTOR(4 downto 0);
signal longitudSecuencia_i: integer range 4 to 32 := 3;
signal iSecuenciaUsuario_dir_i: integer range 0 to 31;

begin
    Inst1Mux2to1: eMux2to1 port map(I0 => "1000", I1 => "0000", S => S_i, O => salidaMux1);
    Inst2Mux2to1: eMux2to1 port map(I0 => "0000", I1 => "0000", S => S_i, O => salidaMux2);
    Inst3Mux2to1: eMux2to1 port map(I0 => "1001", I1 => "0000", S => S_i, O => salidaMux3);
    Inst4Mux2to1: eMux2to1 port map(I0 => "1010", I1 => "0000", S => S_i, O => salidaMux4);
    Inst5Mux2to1: eMux2to1 port map(I0 => "1110", I1 => outSecuencia_i, S => selectorSecuenciaMux_i, O => secuencia);
    InstStateMachine: eStateMachine port map(
        CLK => CLK, 
        RST => RST, 
        enter => enter,
        iSecuenciaAleatoriaT => indicadorSecuenciaTerminada_i,
        A => A,
        B => B,
        C => C,
        D => D,
        CLKBotones => CLKBotones_i,
        indicadorCero => indicadorCero_i,
        S => S_i,
        selectorSecuenciaMux => selectorSecuenciaMux_i,
        rstSecuenciaAleatoria => rstSecuenciaAleatoria_i,
        rstCronometro => rstCronometro_i,
        selectorClkSecuencia => selectorClkSecuencia_i,
        longitudSecuencia => longitudSecuencia_i,
        iSecuenciaUsuario_dir => iSecuenciaUsuario_dir_i,
        iSecuenciaUsuario => iSecuenciaUsuario_i
    );
    InstSecuenciaAleatoria: eSecuenciaAleatoria port map(
        selectorSecuencia => Q_i,
        outSecuencia => outSecuencia_i
    );
    InstContadorSecuencia: eContadorSecuencia port map(
        CLK => CLK,
        RST => rstSecuenciaAleatoria_i,
        longitudSecuencia => longitudSecuencia_i,
        indicadorSecuenciaTerminada => indicadorSecuenciaTerminada_i,
        Q => Q_i
    );
    InstCronometro: eCronometro port map( --TODO: Posiblemente deba llebar un Mux
        CLK => CLKBotones,
        RST => rstCronometro_i,
        indicadorCero => indicadorCero_i,
        outCuenta => outCrometro
    );
    InstSecuenciaUsuario: rSecuenciaUsuario port map(
        input => iSecuenciaUsuario_i,
        input_dir => iSecuenciaUsuario_dir_i,
        Selector => 0,
        output => outRegistroSecUsu_i
    );
    Inst1BitMux2to1: e1BitMux2 port map(
        I0 => '0',
        I1 => CLKBotones,
        S => selectorClkSecuencia_i,
        O => CLKBotones_i
    );
    secuenciaUsuario <= iSecuenciaUsuario_i;
 
end Behavioral;
