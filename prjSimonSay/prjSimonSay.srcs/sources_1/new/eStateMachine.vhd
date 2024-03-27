library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eStateMachine is
    Port ( 
        CLK, RST: in std_logic;
        enter, aButton, bButton, cButton, dButton: in std_logic;
        cantidadVidas, secuenciaTerminada: in std_logic;
        puntaje: in std_logic_vector(7 downto 0); --Es posible que se necesite cambiar el tamaño
        cronometro: in std_logic_vector(1 downto 0);
        muxLed, rstCantidadVidas,rstPuntaje, rstCronometro: out std_logic
    );
end eStateMachine;

architecture Behavioral of eStateMachine is

type state_type is (S0, S1, S2); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;
-- Declarar señales internas para todas las salidas
signal muxLed_i, rstCantidadVidas_i, rstPuntaje_i, rstCronometro_i : std_logic;

begin
    SYNC_PROC: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RST = '1') then
                state <= S0;
                muxLed <= '1';
                rstCantidadVidas <= '0';
                rstPuntaje <= '0';
                rstCronometro <= '0';
            else
                state <= next_state;
                muxLed <= muxLed_i;
                rstCantidadVidas <= rstCantidadVidas_i;
                rstPuntaje <= rstPuntaje_i;
                rstCronometro <= rstCronometro_i;
          end if;
       end if;
    end process;
 
    --MOORE State-Machine - Outputs based on state only
    OUTPUT_DECODE: process (state)
    begin
       --insert statements to decode internal output signals
       --below is simple example
        if state = S0 then
            muxLed_i <= '1';
            rstCantidadVidas_i <= '0';
            rstPuntaje_i <= '0';
            rstCronometro_i <= '0';
        elsif state = S1 then
            muxLed <= '0';
            rstCantidadVidas <= '1';
            rstPuntaje <= '1';
            rstCronometro <= '0';
        elsif state = S2 then
            muxLed <= '0';
            rstCantidadVidas <= '0';
            rstPuntaje <= '0';
            rstCronometro <= '1';
       end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, CLK, RST, enter, aButton, bButton, cButton, dButton, cantidadVidas, puntaje, cronometro, secuenciaTerminada)
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
                if secuenciaTerminada = '1' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process;


end Behavioral;
