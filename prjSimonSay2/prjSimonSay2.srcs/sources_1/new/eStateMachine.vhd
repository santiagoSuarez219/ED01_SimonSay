library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eStateMachine is
    Port ( 
        CLK, RST, enter, iSecuenciaAleatoriaT, A,B,C,D, CLKBotones, indicadorCero, esIgualSecuencia, notEsIgualSecuencia, cronometroPuntaje: in std_logic;
        aciertosCantidad: in integer range 0 to 32;
        cantidadVidas: in integer range 0 to 2;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro, selectorClkSecuencia, rstCtoComparador, selectorSecuenciaAleatoriaMux, enCtoComparador, sumarPuntaje, rstPuntaje, rstCronometroPuntaje, rstVidas, sumarVida, restarVida, rstRegistroUsuario, selectorMuxFinJuego, finJuego: out STD_LOGIC;
        cantidadSumarPuntaje: out integer range 0 to 244;
        longitudSecuencia: out integer range 3 to 32;
        iSecuenciaUsuario_dir: out integer range 0 to 31;
        iSecuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eStateMachine;

architecture Behavioral of eStateMachine is

type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;

-- Declarar señales internas para todas las salidas
signal S_i, selectorSecuenciaMux_i, rstSecuenciaAleatoria_i, rstCronometro_i, selectorClkSecuencia_i, rstCtoComparador_i, selectorSecuenciaAleatoriaMux_i, enCtoComparador_i, sumarPuntaje_i, rstPuntaje_i, rstCronometroPuntaje_i, rstVidas_i,sumarVida_i, restarVida_i, rstRegistroUsuario_i, selectorMuxFinJuego_i, finJuego_i: STD_LOGIC;
signal longitudSecuencia_i: integer range 3 to 32 := 3;
signal iSecuenciaUsuario_dir_i: integer range 0 to 31;
signal iSecuenciaUsuario_i: STD_LOGIC_VECTOR(3 downto 0);
signal cantidadSumarPuntaje_i: integer range 0 to 244 := 0;
signal juegosGanados: integer range 0 to 32 := 0;

begin
    SYNC_PROC: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RST = '1') then
                state <= S0;
                S <= '0';
                selectorSecuenciaMux <= '0';
                rstSecuenciaAleatoria <= '1';
                cantidadSumarPuntaje <= 0;
                longitudSecuencia <= 3;
                rstCronometro <= '1';
                iSecuenciaUsuario_dir <= 0;
                iSecuenciaUsuario <= "0000";
                selectorClkSecuencia <= '0';
                rstCtoComparador <= '1';

                selectorSecuenciaAleatoriaMux <= '0';
                enCtoComparador <= '0';
                sumarPuntaje <= '0';
                rstPuntaje <= '1';
                rstCronometroPuntaje <= '1';
                rstVidas <= '1';
                sumarVida <= '0';
                restarVida <= '0';
                rstRegistroUsuario <= '0';
                selectorMuxFinJuego <= '0';
                finJuego <= '0';
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

                selectorSecuenciaAleatoriaMux <= selectorSecuenciaAleatoriaMux_i;
                enCtoComparador <= enCtoComparador_i;
                sumarPuntaje <= sumarPuntaje_i;
                rstPuntaje <= rstPuntaje_i;
                cantidadSumarPuntaje <= cantidadSumarPuntaje_i;
                rstCronometroPuntaje <= rstCronometroPuntaje_i;
                rstVidas <= rstVidas_i;
                sumarVida <= sumarVida_i;
                restarVida <= restarVida_i;
                rstRegistroUsuario <= rstRegistroUsuario_i;
                selectorMuxFinJuego <= selectorMuxFinJuego_i;
                finJuego <= finJuego_i;
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
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '1';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '1';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S1 then -- Estado de mostrar secuencia
            S_i <= '1';
            selectorSecuenciaMux_i <= '1';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i + 1;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= 0;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            i := 0; -- Se reinicia el registro
            restarVida_i <= '0';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstRegistroUsuario_i <= '1';
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
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

            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
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
                iSecuenciaUsuario_i <= "1100";
            elsif B = '1' then
                iSecuenciaUsuario_i <= "1101";
            elsif C = '1' then
                iSecuenciaUsuario_i <= "1110";
            elsif D = '1' then
                iSecuenciaUsuario_i <= "1111";
            end if;

            selectorClkSecuencia_i <= '1';
            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S4 then --Estado de cronometro en cero --Este estado puede que se elimine
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '0';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
        elsif state = S5 then -- Estado de comparacion
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '0';

            selectorSecuenciaAleatoriaMux_i <= '1';
            enCtoComparador_i <= '1';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
        elsif state = S6 then --Estado gano el juego
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            juegosGanados <= juegosGanados + 1;
            cantidadSumarPuntaje_i <= 0;
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            rstCronometroPuntaje_i <= '1';
            sumarVida_i <= '0';
            rstVidas_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
        elsif state = S7 then --Estado del jugador pierde. 
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i - 1;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            cantidadSumarPuntaje_i <= aciertosCantidad * 7;
            sumarPuntaje_i <= '1';
            rstPuntaje_i <= '0';
            rstCronometroPuntaje_i <= '1';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            if cantidadVidas = 1 then
                finJuego_i <= '0';
            else
                finJuego_i <= '1';
            end if;
            restarVida_i <= '1';
            rstRegistroUsuario_i <= '1';
            selectorMuxFinJuego_i <= '0';
        elsif state = S8 then --Estado suma de puntaje y/o fin del juego
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            juegosGanados <= juegosGanados;
            if juegosGanados = 12 or juegosGanados = 24 or juegosGanados = 32 then
                cantidadSumarPuntaje_i <= aciertosCantidad * 7 + 10;
            else
                cantidadSumarPuntaje_i <= aciertosCantidad * 7;
            end if;
            if juegosGanados = 32 then
                rstCronometroPuntaje_i <= '0';
                selectorMuxFinJuego_i <= '1';
            else
                rstCronometroPuntaje_i <= '1';
                selectorMuxFinJuego_i <= '0';
            end if;
            sumarPuntaje_i <= '1';
            rstPuntaje_i <= '0';
            if juegosGanados = 16 then
                sumarVida_i <= '1';
            else
                sumarVida_i <= '0'; 
            end if;
            rstVidas_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
        elsif state = S9 then -- Estado de cronometro cuando pierde el jugador
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            selectorClkSecuencia_i <= '0';
            rstCtoComparador_i <= '1';

            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            juegosGanados <= juegosGanados;
            cantidadSumarPuntaje_i <= cantidadSumarPuntaje_i;
            rstCronometroPuntaje_i <= '0';
            selectorMuxFinJuego_i <= '0';
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            sumarVida_i <= '0';
            rstVidas_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
        end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, enter, iSecuenciaAleatoriaT, A, B, C, D, CLKBotones, indicadorCero, esIgualSecuencia, notEsIgualSecuencia, cronometroPuntaje, cantidadVidas, selectorMuxFinJuego_i, finJuego_i)
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
                elsif indicadorCero = '1' then
                    next_state <= S5;
                else 
                    next_state <= S2;
                end if;
            when S3 =>
                if (A = '0' and B = '0' and C = '0' and D = '0') then
                    next_state <= S2;
                else 
                    next_state <= S3;
                end if;
            when S4 => --Puede que se elimine este estado
                next_state <= S4;
            when S5 =>
                if esIgualSecuencia = '1' then
                    next_state <= S6;
                elsif notEsIgualSecuencia = '1' then
                    next_state <= S7;
                else
                    next_state <= S5;
                end if;
            when S6 =>
                next_state <= S8;
            when S7 =>
                next_state <= S9;
            when S8 =>
                if selectorMuxFinJuego_i = '1' then
                    if cronometroPuntaje = '1' then
                        next_state <= S0;
                    else
                        next_state <= S8;
                    end if;
                else
                    next_state <= S1;
                end if;
            when S9 =>
                if finJuego_i = '1' then
                    if cronometroPuntaje = '1' then 
                        next_state <= S0;
                    else
                        next_state <= S9;
                    end if;
                else
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process;


end Behavioral;

