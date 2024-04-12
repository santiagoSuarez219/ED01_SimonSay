library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity visualizarPuntaje is
  Port (puntaje : in  integer range 0 to 4096;
        milesimas, centecimas, decimas, unidades: out std_logic_vector(3 downto 0)
   );
end visualizarPuntaje;

architecture Behavioral of visualizarPuntaje is

begin
process(puntaje)
begin
    unidades <= std_logic_vector(to_unsigned(puntaje mod 10, 4)); -- unidades
    decimas <= std_logic_vector(to_unsigned((puntaje/10) mod 10, 4)); -- decimas
    centecimas <= std_logic_vector(to_unsigned((puntaje/100) mod 10, 4)); -- centesimas
    milesimas <= std_logic_vector(to_unsigned((puntaje/1000) mod 10, 4)); -- milesimas
    end process;
end Behavioral;
