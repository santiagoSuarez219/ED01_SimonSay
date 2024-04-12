
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity selectorMensajePuntaje is
  Port (milesimas, centecimas, decimas, unidades: in std_logic_vector(3 downto 0);
        selector: in std_logic;
        milesimasSelector, centecimasSelector, decimasSelector, unidadesSelector: out std_logic_vector(3 downto 0));
end selectorMensajePuntaje;

architecture Behavioral of selectorMensajePuntaje is

begin
process (selector, milesimas, centecimas, decimas, unidades)
begin
  if selector = '0' then
    milesimasSelector <= "1111";
    centecimasSelector <= "0000";
    decimasSelector <= "1110";
    unidadesSelector <= "1010";
  elsif selector = '1' then
    milesimasSelector <= milesimas;
    centecimasSelector <= centecimas;
    decimasSelector <= decimas;
    unidadesSelector <= unidades;
    end if;

end process;

end Behavioral;
