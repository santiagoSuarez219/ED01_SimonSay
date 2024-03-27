library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eSimonSays is
    Port ( 
        CLK, RST: in STD_LOGIC;
        enter, aButton, bButton, cButton, dButton: in std_logic;
        ledMux, cantidadVidas: out std_logic;
        puntaje: out std_logic_vector(7 downto 0);
        cronometro: out std_logic_vector(2 downto 0)
    );
end eSimonSays;

architecture Behavioral of eSimonSays is

begin


end Behavioral;
