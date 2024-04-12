library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eStateMachine is
    Port ( 
        CLK, clkBotones, RST, enter, iSecuenciaAleatoriaT, A,B,C,D, indicadorCero, esIgualSecuencia, notEsIgualSecuencia, cronometroPuntaje, indicadorCronometroFin: in std_logic;
        aciertosCantidad: in integer range 0 to 32;
        cantidadVidas: in integer range 0 to 2;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria, rstCronometro, rstCtoComparador, selectorSecuenciaAleatoriaMux, enCtoComparador, sumarPuntaje, rstPuntaje, rstCronometroPuntaje, rstVidas, sumarVida, restarVida, rstRegistroUsuario, selectorMuxFinJuego, finJuego: out STD_LOGIC;
        cantidadSumarPuntaje: out integer range 0 to 244;
        longitudSecuencia: out integer range 3 to 32;
        iSecuenciaUsuario_dir: out integer range 0 to 31;
        iSecuenciaUsuario: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eStateMachine;

architecture Behavioral of eStateMachine is

type state_type is (S0, S1, S2, S3, S5, S6, S7, S9); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;

-- Declarar señales internas para todas las salidas
signal S_i, selectorSecuenciaMux_i, rstSecuenciaAleatoria_i, rstCronometro_i, rstCtoComparador_i, selectorSecuenciaAleatoriaMux_i, enCtoComparador_i, sumarPuntaje_i, rstPuntaje_i, rstCronometroPuntaje_i, rstVidas_i,sumarVida_i, restarVida_i, rstRegistroUsuario_i, selectorMuxFinJuego_i, finJuego_i: STD_LOGIC;
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
        if state = S0 then -- Estado en donde se muestra el mensaje.
            S_i <= '0'; -- Este selector es una salida del sistema para mostrar o no el mensaje
            selectorSecuenciaMux_i <= '0'; -- Muestra ceros en la salida de la secuencia. 
            rstSecuenciaAleatoria_i <= '1'; -- Reset del contador secuencia
            longitudSecuencia_i <= 3; -- Longitud de la secuencia
            rstCronometro_i <= '1'; -- Cronometro de 3s para que el usuario ingrese un valor
            iSecuenciaUsuario_dir_i <= 0; -- Direccion del array del registro secuencia usuario
            iSecuenciaUsuario_i <= "0000"; -- Valor que se sobreescribe en la direccion del array secuencia usuario
            rstCtoComparador_i <= '1'; -- El circuito comparador permanece apagado
            selectorSecuenciaAleatoriaMux_i <= '0'; -- El contador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '0'; -- El circuito comparador permanece apagado
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '1'; -- Reinicia el puntaje
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
            rstVidas_i <= '1';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S1 then -- Estado de mostrar secuencia
            S_i <= '1'; -- Deja de mostrar el mensaje y empieza el juego
            longitudSecuencia_i <= longitudSecuencia_i + 1; -- La secuencia aumenta en 1, en la primera iteracion empieza en 4
            selectorSecuenciaMux_i <= '1'; -- Permite que se vea la secuencia
            rstSecuenciaAleatoria_i <= '0'; -- Inicia el contador de la secuencia
            rstCronometro_i <= '1'; -- Cronometro de 3s para que el usuario ingrese un valor
            iSecuenciaUsuario_dir_i <= 0; 
            iSecuenciaUsuario_i <= "0000";
            i := 0; -- Se reinicia el registro
            restarVida_i <= '0';
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            rstCtoComparador_i <= '1'; -- El circuito comparador permanece apagado
            selectorSecuenciaAleatoriaMux_i <= '0'; -- El contador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '0'; -- El circuito comparador permanece apagado
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
            rstRegistroUsuario_i <= '1'; -- Se resetea el registro de usuario a ceros
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S2 then --  Estado de ingresar secuencia
            S_i <= '1'; 
            selectorSecuenciaMux_i <= '0'; -- Muestra un cero a la salida de la secuencia
            rstSecuenciaAleatoria_i <= '1'; -- Detiene el contador de la secuencia y lo reinicia
            longitudSecuencia_i <= longitudSecuencia_i; 
            rstCronometro_i <= '0'; -- Empieza a contar el cronometro por 3s 
            iSecuenciaUsuario_dir_i <= i; -- i va aumentando a medida que el usuario ingresa los datos
            iSecuenciaUsuario_i <= iSecuenciaUsuario_i; -- valor que se va sobreescribir
            rstCtoComparador_i <= '1'; -- El circuito comparador permanece apagado
            selectorSecuenciaAleatoriaMux_i <= '1'; -- El comparador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '0'; -- El circuito comparador permanece apagado
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0'; -- No se resetea el registro de usuario
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S3 then -- Estado de guardar el registro
            S_i <= '1';
            selectorSecuenciaMux_i <= '0'; -- Muestra un cero a la salida de la secuencia
            rstSecuenciaAleatoria_i <= '1';  -- el contador de la secuencia permanece apagado
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1'; -- Reinicia el cronometro
            iSecuenciaUsuario_dir_i <= i; 
            rstCtoComparador_i <= '1'; -- El circuito comparador permanece apagado
            i := i + 1; -- Aumenta el valor 
            -- LLEVO EL VALOR AL REGISTRO USUARIO
            if A = '1' then
                iSecuenciaUsuario_i <= "1100";
            elsif B = '1' then
                iSecuenciaUsuario_i <= "1101";
            elsif C = '1' then
                iSecuenciaUsuario_i <= "1110";
            elsif D = '1' then
                iSecuenciaUsuario_i <= "1111";
            end if;
            selectorSecuenciaAleatoriaMux_i <= '1'; -- El comparador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '0'; -- El circuito comparador permanece apagado
            sumarPuntaje_i <= '0';
            rstPuntaje_i <= '0';
            cantidadSumarPuntaje_i <= 0;
            rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
            rstVidas_i <= '0';
            sumarVida_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0'; -- No se resetea el registro de usuario
            selectorMuxFinJuego_i <= '0';
            finJuego_i <= '0';
        elsif state = S5 then -- Estado de comparacion
            S_i <= '1'; -- Muestra los valores del juego
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1'; -- el contador de la secuencia permanece apagado
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1'; -- El cronometro permanece apagado
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            rstCtoComparador_i <= '0'; -- El circuito comparador comienza a funcionar
            selectorSecuenciaAleatoriaMux_i <= '1'; -- El comparador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '1'; -- El circuito comparador se enciende
            sumarPuntaje_i <= '0'; -- No suma puntaje
            rstPuntaje_i <= '0'; -- No reinicia el puntaje
            cantidadSumarPuntaje_i <= 0; -- No se suma nada al puntaje
            rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
            rstVidas_i <= '0'; -- No se resetean las vidas
            sumarVida_i <= '0'; -- No se suma vida
            restarVida_i <= '0'; -- No se resta vida
            rstRegistroUsuario_i <= '0'; -- No se resetea el registro de usuario
            selectorMuxFinJuego_i <= '0';
        elsif state = S6 then --Estado gano el juego, 
            S_i <= '1'; -- Muestra los valores del juego 
            selectorSecuenciaMux_i <= '0'; -- Muestra ceros en la salida de la secuencia. 
            rstSecuenciaAleatoria_i <= '1'; -- el contador de la secuencia permanece apagado
            longitudSecuencia_i <= longitudSecuencia_i; 
            rstCronometro_i <= '1'; -- El cronometro permanece apagado
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000"; 
            rstCtoComparador_i <= '0'; -- El circuito comparador sigue funcionando porque esta mostrando el led 5 s
            selectorSecuenciaAleatoriaMux_i <= '0'; -- El contador esta habilitado para pedir valores de la secuencia aleatoria
            enCtoComparador_i <= '0';  -- Se desahilita el enable de cto comparador
            juegosGanados <= juegosGanados + 1; -- Se aumenta juegos ganados
            -- SE CALCULA LA CANTIDAD DE PUNTAJE
            if juegosGanados = 12 or juegosGanados = 24 or juegosGanados = 32 then
                cantidadSumarPuntaje_i <= aciertosCantidad * 7 + 10;
            else
                cantidadSumarPuntaje_i <= aciertosCantidad * 7;
            end if;
            sumarPuntaje_i <= '1'; -- Se suma el puntaje
            if juegosGanados = 32 then -- Si gano todos los juegos
                rstCronometroPuntaje_i <= '0'; -- Se muestra el puntaje obtenido
                selectorMuxFinJuego_i <= '1'; -- Se muestra los LED parpadeando
            else
                rstCronometroPuntaje_i <= '1'; -- El cronometro puntaje permanece apagado
                selectorMuxFinJuego_i <= '0'; -- No se muestran los LEDs parpadeando
            end if;
            rstPuntaje_i <= '0'; -- No se resetea puntaje
            if juegosGanados = 16 then -- Si los juegos ganados es igual a 16 se suma una vida
                sumarVida_i <= '1';
            else
                sumarVida_i <= '0'; 
            end if;
            rstVidas_i <= '0'; -- Se mantiene el valor de las vidas
            restarVida_i <= '0'; -- No se resta vidas
            rstRegistroUsuario_i <= '0'; -- No se resetea el registro del usuario
        elsif state = S7 then --Estado del jugador pierde. 
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i - 1;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
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
        elsif state = S9 then -- Estado de cronometro cuando pierde el jugador
            S_i <= '1';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
            longitudSecuencia_i <= longitudSecuencia_i;
            rstCronometro_i <= '1';
            iSecuenciaUsuario_dir_i <= i;
            iSecuenciaUsuario_i <= "0000";
            rstCtoComparador_i <= '1';
            selectorSecuenciaAleatoriaMux_i <= '0';
            enCtoComparador_i <= '0';
            juegosGanados <= juegosGanados;
            cantidadSumarPuntaje_i <= cantidadSumarPuntaje_i;
            rstCronometroPuntaje_i <= '0';
            selectorMuxFinJuego_i <= '0';
            sumarPuntaje_i <= '1';
            rstPuntaje_i <= '0';
            sumarVida_i <= '0';
            rstVidas_i <= '0';
            restarVida_i <= '0';
            rstRegistroUsuario_i <= '0';
        end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, enter, iSecuenciaAleatoriaT, A, B, C, D, indicadorCero, esIgualSecuencia, notEsIgualSecuencia, cronometroPuntaje, cantidadVidas, selectorMuxFinJuego_i, finJuego_i, indicadorCronometroFin, clkBotones)
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
                if (A = '0' and B = '0' and C = '0' and D = '0' and rising_edge(clkBotones)) then    
                    next_state <= S2;
                else 
                    next_state <= S3;
                end if;
            when S5 =>
                if esIgualSecuencia = '1' then
                    next_state <= S6;
                elsif notEsIgualSecuencia = '1' then
                    next_state <= S7;
                else
                    next_state <= S5;
                end if;
            when S6 =>
                if selectorMuxFinJuego_i = '1' then
                    if cronometroPuntaje = '1' then
                        next_state <= S0;
                    else
                        next_state <= S6;
                    end if;
                else
                    if indicadorCronometroFin = '1' then
                        next_state <= S1;
                    else
                        next_state <= S6;
                    end if;
                    -- next_state <= S10;
                end if;
            when S7 =>
                next_state <= S9;
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

