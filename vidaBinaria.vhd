library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vidaBinaria is
  Port (vidasInteger : in integer range 0 to 2;
        vidasBinaria : out std_logic_vector(3 downto 0)
         );
end vidaBinaria;

architecture Behavioral of vidaBinaria is

begin
vidasBinaria <= std_logic_vector(to_unsigned(vidasInteger,4)); 

end Behavioral;
