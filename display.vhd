library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
  Port (
    clk, S : in STD_LOGIC;
    secuencia, outCrometro, secuenciaUsuario: in STD_LOGIC_VECTOR(3 downto 0);
    puntaje : in integer range 0 to 4096;
    vidasInteger : in integer range 0 to 2;
    catodos : out STD_LOGIC_VECTOR(7 downto 0);
    anodos : out STD_LOGIC_VECTOR(7 downto 0)
  );
end display;

architecture Behavioral of display is

component slowClock is
  Port ( fastClock : in STD_LOGIC;
         slowClock : inout STD_LOGIC;
         prescaler : in INTEGER RANGE 0 TO 50000000);
end component slowClock;

component dataBCD7Seg is
  Port (dataBCD: in STD_LOGIC_VECTOR(3 downto 0);
        catodos : out STD_LOGIC_VECTOR(7 downto 0));
end component dataBCD7Seg;

component seleccionDisplay is
  Port (secuencia, outCrometro, outVida, secuenciaUsuario, milesimas, centecimas, decimas, unidades: in STD_LOGIC_VECTOR(3 downto 0);
        clk : in STD_LOGIC;
        dataBCD: out STD_LOGIC_VECTOR(3 downto 0); 
        anodos: out STD_LOGIC_VECTOR(7 downto 0)
);
end component seleccionDisplay;

component visualizarPuntaje is
  Port (puntaje : in  integer range 0 to 2048;
        milesimas, centecimas, decimas, unidades: out std_logic_vector(3 downto 0)
   );
end component visualizarPuntaje;

component selectorMensajePuntaje is
    Port (milesimas, centecimas, decimas, unidades: in std_logic_vector(3 downto 0);
          selector: in std_logic;
          milesimasSelector, centecimasSelector, decimasSelector, unidadesSelector: out std_logic_vector(3 downto 0));
end component selectorMensajePuntaje;

component vidaBinaria is
  Port (vidasInteger : in integer range 0 to 2;
        vidasBinaria : out std_logic_vector(3 downto 0)
         );
end component vidaBinaria;

signal slowClock_i: std_logic;
signal milesimas_i, centecimas_i, decimas_i, unidades_i: std_logic_vector(3 downto 0);
signal milesimas_ii, centecimas_ii, decimas_ii, unidades_ii: std_logic_vector(3 downto 0);
signal vidasBinaria_i: std_logic_vector(3 downto 0);
signal dataBCD_i: std_logic_vector(3 downto 0);

begin

instanciaSlowClock: slowClock port map(fastclock => clk, slowClock => slowClock_i, prescaler => 50000);
instanciavidaBinaria: vidaBinaria port map(vidasInteger => vidasInteger, vidasBinaria => vidasBinaria_i);
instanciaVisualizarPuntaje: visualizarPuntaje port map(puntaje => puntaje, milesimas => milesimas_i, centecimas => centecimas_i, decimas => decimas_i, unidades => unidades_i);
instanciaSelectorMensajePuntaje: selectorMensajePuntaje port map(milesimas => milesimas_i, centecimas => centecimas_i, decimas => decimas_i, unidades => unidades_i, selector => S, milesimasSelector => milesimas_ii, centecimasSelector => centecimas_ii, decimasSelector => decimas_ii, unidadesSelector => unidades_ii);
instanciaSeleccionDisplay: seleccionDisplay port map(secuencia => secuencia, outCrometro => outCrometro, outVida => vidasBinaria_i, secuenciaUsuario => secuenciaUsuario, milesimas => milesimas_ii, centecimas => centecimas_ii, decimas => decimas_ii, unidades => unidades_ii, clk => slowClock_i, dataBCD => dataBCD_i, anodos => anodos);
instanciaDataBCD7Seg: dataBCD7Seg port map(dataBCD => dataBCD_i, catodos => catodos);

end Behavioral;
