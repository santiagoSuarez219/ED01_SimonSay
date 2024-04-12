library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seleccionDisplay is
  Port (secuencia, outCrometro, outVida, secuenciaUsuario, milesimas, centecimas, decimas, unidades: in STD_LOGIC_VECTOR(3 downto 0);
        clk : in STD_LOGIC;
        dataBCD: out STD_LOGIC_VECTOR(3 downto 0); 
        anodos: out STD_LOGIC_VECTOR(7 downto 0)
);
end seleccionDisplay;

architecture Behavioral of seleccionDisplay is

begin
    process(clk)
    variable posicionDisplay:INTEGER RANGE 0 TO 7;
    begin
        if rising_edge(clk) then
            if posicionDisplay = 0 then
                anodos <= "11111110";
                dataBCD <= unidades;
            elsif posicionDisplay = 1 then
                anodos <= "11111101";
                dataBCD <= decimas;
            elsif posicionDisplay = 2 then
                anodos <= "11111011";
                dataBCD <= centecimas;
            elsif posicionDisplay = 3 then
                anodos <= "11110111";
                dataBCD <= milesimas;
            elsif posicionDisplay = 4 then
                anodos <= "11101111";
                dataBCD <= outVida;
            elsif posicionDisplay = 5 then
                anodos <= "11011111";
                dataBCD <= outCrometro;
            elsif posicionDisplay = 6 then
                anodos <= "10111111";
                dataBCD <= secuenciaUsuario;
            else
                anodos <= "01111111";
                dataBCD <= secuencia;
            end if;
            posicionDisplay := posicionDisplay + 1;
            if posicionDisplay > 7 then
                posicionDisplay := 0;
            end if;
        end if;
    end process;
end Behavioral;
