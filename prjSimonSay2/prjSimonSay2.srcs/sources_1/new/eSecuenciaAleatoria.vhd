library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eSecuenciaAleatoria is
    Port ( 
        selectorSecuencia: in STD_LOGIC_VECTOR(4 downto 0);
        outSecuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eSecuenciaAleatoria;

architecture Behavioral of eSecuenciaAleatoria is
begin

    outSecuencia <= "1100" when selectorSecuencia = "00000" else
                    "1010" when selectorSecuencia = "00001" else
                    "1100" when selectorSecuencia = "00010" else
                    "1101" when selectorSecuencia = "00011" else
                    "1010" when selectorSecuencia = "00100" else
                    "1011" when selectorSecuencia = "00101" else
                    "1010" when selectorSecuencia = "00110" else
                    "1100" when selectorSecuencia = "00111" else
                    "1010" when selectorSecuencia = "01000" else
                    "1011" when selectorSecuencia = "01001" else
                    "1010" when selectorSecuencia = "01010" else
                    "1101" when selectorSecuencia = "01011" else
                    "1010" when selectorSecuencia = "01100" else
                    "1100" when selectorSecuencia = "01101" else
                    "1010" when selectorSecuencia = "01110" else
                    "1011" when selectorSecuencia = "01111" else
                    "1010" when selectorSecuencia = "10000" else
                    "1100" when selectorSecuencia = "10001" else
                    "1101" when selectorSecuencia = "10010" else
                    "1100" when selectorSecuencia = "10011" else
                    "1010" when selectorSecuencia = "10100" else
                    "1011" when selectorSecuencia = "10101" else
                    "1100" when selectorSecuencia = "10110" else
                    "1011" when selectorSecuencia = "10111" else
                    "1010" when selectorSecuencia = "11000" else
                    "1101" when selectorSecuencia = "11001" else
                    "1010" when selectorSecuencia = "11010" else
                    "1101" when selectorSecuencia = "11011" else
                    "1100" when selectorSecuencia = "11100" else
                    "1011" when selectorSecuencia = "11101" else
                    "1011" when selectorSecuencia = "11110" else
                    "1100" when selectorSecuencia = "11111";

end Behavioral;
