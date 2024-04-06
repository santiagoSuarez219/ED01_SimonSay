library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eStateMachine is
    Port ( 
        CLK, RST, enter, iSecuenciaAleatoriaT, A,B,C,D, CLKBotones, indicadorCero, esIgualSecuencia: in std_logic;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro, selectorClkSecuencia, rstCtoComparador, enableFlipFlop, selectorSecuenciaAleatoriaMux, enCtoComparador: out STD_LOGIC;
        longitudSecuencia: out integer range 3 to 32;
        iSecuenciaUsuario_dir: out integer range 0 to 31;
        iSecuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eStateMachine;

architecture Behavioral of eStateMachine is

type state_type is (S0, S1, S2, S3, S4,S5, S6); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;

-- Declarar señales internas para todas las salidas
signal S_i, selectorSecuenciaMux_i, rstSecuenciaAleatoria_i, rstCronometro_i, selectorClkSecuencia_i, rstCtoComparador_i, enableFlipFlop_i, selectorSecuenciaAleatoriaMux_i, enCtoComparador_i: std_logic;
signal longitudSecuencia_i: integer range 3 to 32 := 3;
signal iSecuenciaUsuario_dir_i: integer range 0 to 31;
signal iSecuenciaUsuario_i: STD_LOGIC_VECTOR(3 downto 0);

begin
    SYNC_PROC: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RST = '1') then
                state <= S0;
                S <= '0';
                selectorSecuenciaMux <= '0';
                rstSecuenciaAleatoria <= '1';
                longitudSecuencia <= 3;
                rstCronometro <= '1';
                iSecuenciaUsuario_dir <= 0;
                iSecuenciaUsuario <= "1110";
                selectorClkSecuencia <= '0';
                rstCtoComparador <= '1';
                enableFlipFlop <= '0';
                selectorSecuenciaAleatoriaMux <= '0';
                enCtoComparador_i <= '1';
            else
                state <= next_state;
                S <= S_i;
                selectorSecuenciaMux <= selectorSecuenciaMux_i;
                rstSecuenciaAleatoria <= rstSecuenciaAleatoria_i;
                longitudSecuencia <= longitudSecuencia_i;
                rstCronometro <= rstCronometro_i;
                iSecuenciaUsuario_dir <= iSecuenciaUsuario_dir_i;
                iSecuenciaUsuario <= iSecuenciaUsuario_i;
                selectorClkSecuencia <= selectorClkSecuencia_i;
                rstCtoComparador <= rstCtoComparador_i;
                enableFlipFlop <= enableFlipFlop_i;
                selectorSecuenciaAleatoriaMux <= selectorSecuenciaAleatoriaMux_i;
                enCtoComparador <= enCtoComparador_i;
          end if;
       end if;
    end process;
 
    --MOORE State-Machine - Outputs based on state only
    OUTPUT_DECODE: process (state)
    variable i : integer range 0 to 31 := 0;
    begin
        if state = S0 then
            S_i <= '0';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= 3;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= 0;
            iSecuenciaUsuario_i <= "1110";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
        elsif state = S1 then -- Estado de mostrar secuencia
            S_i <= '1';
            selectorSecuenciaMux_i <= '1';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i + 1;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= 0;
            iSecuenciaUsuario_i <= "1110";
            selectorClkSecuencia_i <= '0';
            i := 0; -- Se reinicia el registro
            rstCtoComparador_i <= '1';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
        elsif state = S2 then --  Estado de ingresar secuencia
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '0';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= iSecuenciaUsuario_i;
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
        elsif state = S3 then -- Estado de guardar el registro
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';  
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            rstCtoComparador_i <= '1';
            i := i + 1;
            if A = '1' then
                iSecuenciaUsuario_i <= "1010";
            elsif B = '1' then
                iSecuenciaUsuario_i <= "1011";
            elsif C = '1' then
                iSecuenciaUsuario_i <= "1100";
            elsif D = '1' then
                iSecuenciaUsuario_i <= "1101";
            end if;
            enableFlipFlop_i <= '1';
            selectorClkSecuencia_i <= '1';
            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
        elsif state = S4 then --Estado de cronometro en cero
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "1110";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
        elsif state = S5 then --Estado de comparacion
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "1110";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '0';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '1';
        elsif state = S5 then --Estado de LED ENCENDIDO Y SUMA DE PUNTAJE
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "1110";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';
            enableFlipFlop_i <= '0';
            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
        end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, enter, iSecuenciaAleatoriaT, A, B, C, D, CLKBotones, indicadorCero, esIgualSecuencia)
    begin
        next_state <= state;  --default is to stay in current state
        case (state) is
            when S0 =>
                if enter = '1' then
                    next_state <= S1;
                else 
                    next_state <= S0;
                end if;
            when S1 =>
                if iSecuenciaAleatoriaT = '1' then
                    next_state <= S2;
                else 
                    next_state <= S1;
                end if;
            when S2 =>
                if A = '1' OR B = '1' OR C = '1' OR D = '1' then
                    next_state <= S3;
                elsif enter = '1' then
                    next_state <= S5;
                else 
                    next_state <= S2;
                end if;
            when S3 =>
                if (CLKBotones = '1' and A = '0' and B = '0' and C = '0' and D = '0') then
                    next_state <= S2;
                elsif indicadorCero = '1' then
                    next_state <= S4; --Por ahora no va llegar a S4
                else 
                    next_state <= S3;
                end if;
            when S4 =>
                next_state <= S4;
            when S5 =>
                if esIgualSecuencia = '1' then
                    next_state <= S6;
                else
                    next_state <= S5;
                end if;
            when S6 =>
                next_state <= S6;
            when others =>
                next_state <= S0;
        end case;
    end process;


end Behavioral;

