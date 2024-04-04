library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSimonSays is
    Port (
        CLK, RST, enter: in std_logic;
        salidaMux1: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux2: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux3: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux4: out STD_LOGIC_VECTOR(3 downto 0);
        secuencia: out STD_LOGIC_VECTOR(3 downto 0);
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
        CLK, RST, enter, iSecuenciaAleatoriaT: in std_logic;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro: out STD_LOGIC;
        longitudSecuencia: out integer range 4 to 32
    );
end component eStateMachine;

component eSecuenciaAleatoria is
    Port ( 
        selectorSecuencia: in STD_LOGIC_VECTOR(4 downto 0);
        outSecuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end component eSecuenciaAleatoria;

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


signal S_i, selectorSecuenciaMux_i, enableSecuenciaOut_i, indicadorSecuenciaTerminada_i, rstSecuenciaAleatoria_i, indicadorCero_i, rstCronometro_i: STD_LOGIC;
signal outSecuencia_i : STD_LOGIC_VECTOR(3 downto 0);
signal Q_i : STD_LOGIC_VECTOR(4 downto 0);
signal longitudSecuencia_i: integer range 4 to 32 := 3;


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
        S => S_i,
        selectorSecuenciaMux => selectorSecuenciaMux_i,
        rstSecuenciaAleatoria => rstSecuenciaAleatoria_i,
        rstCronometro => rstCronometro_i,
        longitudSecuencia => longitudSecuencia_i
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
    InstCronometro: eCronometro port map(
        CLK => CLK,
        RST => rstCronometro_i,
        indicadorCero => indicadorCero_i,
        outCuenta => outCrometro
    );
 
end Behavioral;
