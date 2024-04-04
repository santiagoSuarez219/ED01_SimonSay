library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eContadorPuntaje is
    Port ( 
        CLK, RST, sumarPuntaje: in STD_LOGIC;
        cantidadSumar: in STD_LOGIC_VECTOR(3 downto 0);
        puntajeOut : out STD_LOGIC_VECTOR(11 downto 0)
    );
end eContadorPuntaje;

architecture Behavioral of eContadorPuntaje is

begin
    process(CLK, RST)
        variable puntajeInterno : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    begin
        if RST = '1' then
            puntajeInterno := (others => '0');
        elsif rising_edge(CLK) then
            if sumarPuntaje = '1' then
                puntajeInterno := puntajeInterno + cantidadSumar;
            end if;
        end if;
        puntajeOut <= puntajeInterno;
    end process;


end Behavioral;
