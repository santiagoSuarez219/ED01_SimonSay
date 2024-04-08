library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rSecuenciaUsuario is
    Port (
        RST: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(3 downto 0);
        input_dir: in integer range 0 to 31; -- Puntero
        Selector: in integer range 0 to 31; -- Lo utiliza el comparador
        output: out STD_LOGIC_VECTOR(3 downto 0) --Lo utiliza el comparador
    );
end rSecuenciaUsuario;

architecture Behavioral of rSecuenciaUsuario is

type tSecuencia is array (0 to 31) of STD_LOGIC_VECTOR(3 downto 0);
signal sTSecuencia : tSecuencia := (others => "0000");

begin
    process(input, input_dir, RST)
    begin
        if RST = '1' then
            sTSecuencia <= (others => "0000");
        else 
            sTSecuencia(input_dir) <= input;
        end if;
    end process;

    process(Selector)
    begin
        output <= sTSecuencia(Selector);
    end process;


end Behavioral;
