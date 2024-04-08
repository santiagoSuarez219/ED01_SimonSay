library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eContadorPuntaje is
    Port ( 
        CLK, RST, sumarPuntaje: in STD_LOGIC;
        cantidadSumar: in integer range 0 to 244;
        puntajeOut : out integer range 0 to 4096
    );
end eContadorPuntaje;

architecture Behavioral of eContadorPuntaje is

begin
    process(CLK, RST)
        variable puntajeInterno : integer range 0 to 4096;
    begin
        if RST = '1' then
            puntajeInterno := 0;
        elsif rising_edge(CLK) then
            if sumarPuntaje = '1' then
                puntajeInterno := puntajeInterno + cantidadSumar;
            end if;
        end if;
        puntajeOut <= puntajeInterno;
    end process;


end Behavioral;
