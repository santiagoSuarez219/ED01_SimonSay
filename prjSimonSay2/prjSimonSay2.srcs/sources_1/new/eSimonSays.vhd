library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSimonSays is
    Port (
        CLK, RST, enter: in std_logic;
        salidaMux1: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux2: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux3: out STD_LOGIC_VECTOR(3 downto 0);
        salidaMux4: out STD_LOGIC_VECTOR(3 downto 0);
        secuencia: out STD_LOGIC_VECTOR(3 downto 0)
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
        CLK, RST, enter: in std_logic;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria: out STD_LOGIC
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
        Q : out STD_LOGIC_VECTOR(4 downto 0)
    );
end component eContadorSecuencia;

signal S_i, selectorSecuenciaMux_i, enableSecuenciaOut_i, indicadorSecuenciaTerminada_i, rstSecuenciaAleatoria_i : STD_LOGIC;
signal outSecuencia_i : STD_LOGIC_VECTOR(3 downto 0);
signal Q_i : STD_LOGIC_VECTOR(4 downto 0);


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
        S => S_i,
        selectorSecuenciaMux => selectorSecuenciaMux_i,
        rstSecuenciaAleatoria => rstSecuenciaAleatoria_i
    );
    InstSecuenciaAleatoria: eSecuenciaAleatoria port map(
        selectorSecuencia => Q_i,
        outSecuencia => outSecuencia_i
    );
    InstContadorSecuencia: eContadorSecuencia port map(
        CLK => CLK,
        RST => rstSecuenciaAleatoria_i,
        Q => Q_i
    );
 
end Behavioral;
