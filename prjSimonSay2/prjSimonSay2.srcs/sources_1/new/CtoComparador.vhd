library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity CtoComparador is
    Port (
        CLK, RST, EN: in STD_LOGIC;
        valorSecuenciaAleatoria, valorRegistro: in STD_LOGIC_VECTOR (3 downto 0);
        longitudSecuencia: in integer range 3 to 32; 
        aciertos: out integer range 0 to 32;
        esIgual: out STD_LOGIC;
        selectorSecuencia: out STD_LOGIC_VECTOR (4 downto 0);
        selectorRegistro: out integer range 0 to 31
    );
end CtoComparador;

architecture Behavioral of CtoComparador is

type state_type is (S0, S1, S2, S3, S4); -- Declarar todos los estados en esta parte
signal state, next_state : state_type;

-- Declarar señales internas para todas las salidas
signal aciertos_i: integer range 0 to 32;
signal esIgual_i: STD_LOGIC;
signal selectorSecuencia_i: STD_LOGIC_VECTOR (4 downto 0);
signal selectorRegistro_i: integer range 0 to 31;

signal i: integer range 0 to 31 := 0;

-- type tSecuenciaAleatoria is array (0 to 31) of STD_LOGIC_VECTOR(3 downto 0);
-- type tSecuenciaUsuario is array (0 to 31) of STD_LOGIC_VECTOR(3 downto 0);
-- signal stSecuenciaAleatoria : tSecuenciaAleatoria;
-- signal stSecuenciaUsuario : tSecuenciaUsuario;

begin
    SYNC_PROC: process (CLK)
    begin
        if (CLK'event and CLK = '1') then
            if (RST = '1') then
                state <= S0;
                aciertos <= 0;
                esIgual <= '0';
                selectorSecuencia <= "00000";
                selectorRegistro <= 0;   
            else
                state <= next_state;
                aciertos <= aciertos_i;
                esIgual <= esIgual_i;
                selectorSecuencia <= selectorSecuencia_i;
                selectorRegistro <= selectorRegistro_i;  
          end if;
       end if;
    end process;
 
    --MOORE State-Machine - Outputs based on state only
    OUTPUT_DECODE: process (state)
    begin
        if state = S0 then
            aciertos_i <= 0;
            esIgual_i <= '0';
            selectorSecuencia_i <= "00000";
            selectorRegistro_i <= 0; 
            i <= 0;
        elsif state = S1 then --Comienza a recorrer el array
            aciertos_i <= aciertos_i;
            esIgual_i <= '0';
            selectorSecuencia_i <=selectorSecuencia_i;
            selectorRegistro_i <= selectorRegistro_i;
            i <= i;
        elsif state = S2 then -- Estado de comparacion
            if valorSecuenciaAleatoria = valorRegistro then
                aciertos_i <= aciertos_i + 1;
            else
                aciertos_i <= aciertos_i;
            end if;
            esIgual_i <= '0';
            selectorSecuencia_i <= selectorSecuencia_i + 1;
            selectorRegistro_i <= selectorRegistro_i + 1;
            i <= i + 1;
        elsif state = S3 then -- Se evalua el estado de la comparacion
            aciertos_i <= aciertos_i;    
            if aciertos_i = longitudSecuencia then
                esIgual_i <= '1';
            else
                esIgual_i <= '0';
            end if;
            selectorSecuencia_i <= "00000";
            selectorRegistro_i <= 0; 
            i <= 0;
        end if;
    end process;
 
    NEXT_STATE_DECODE: process (state, RST, EN, valorSecuenciaAleatoria, valorRegistro, longitudSecuencia)
    begin
        next_state <= state;  --default is to stay in current state
        case (state) is
            when S0 =>
                if EN = '1' then
                    next_state <= S1;
                else 
                    next_state <= S0;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                --Puede pasar a S1 o S3
                if (i = longitudSecuencia) then
                    next_state <= S3;
                else
                    next_state <= S1;
                end if;
            when S3 =>
                if RST = '1' then
                    next_state <= S0;
                else
                    next_state <= S3;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process;

end Behavioral;