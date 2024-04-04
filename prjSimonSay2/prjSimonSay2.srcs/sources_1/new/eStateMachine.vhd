library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eStateMachine is
    Port ( 
        CLK, RST, enter: in std_logic;
        S, selectorSecuenciaMux, rstSecuenciaAleatoria: out STD_LOGIC
    );
end eStateMachine;

architecture Behavioral of eStateMachine is

type state_type is (S0, S1); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;

-- Declarar señales internas para todas las salidas
signal S_i, selectorSecuenciaMux_i, rstSecuenciaAleatoria_i : std_logic;

begin
    SYNC_PROC: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RST = '1') then
                state <= S0;
                S <= '0';
                selectorSecuenciaMux <= '0';
                rstSecuenciaAleatoria <= '1';
            else
                state <= next_state;
                S <= S_i;
                selectorSecuenciaMux <= selectorSecuenciaMux_i;
                rstSecuenciaAleatoria <= rstSecuenciaAleatoria_i;
          end if;
       end if;
    end process;
 
    --MOORE State-Machine - Outputs based on state only
    OUTPUT_DECODE: process (state)
    begin
        if state = S0 then
            S_i <= '0';
            selectorSecuenciaMux_i <= '0';
            rstSecuenciaAleatoria_i <= '1';
        elsif state = S1 then
            S_i <= '1';
            selectorSecuenciaMux_i <= '1';
            rstSecuenciaAleatoria_i <= '0';
        end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, enter, RST)
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
                next_state <= S1;
            when others =>
                next_state <= S0;
        end case;
    end process;


end Behavioral;

