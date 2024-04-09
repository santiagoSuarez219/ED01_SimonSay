library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eSecuenciaAleatoria is
    Port (
        modoDemo: in STD_LOGIC;
        selectorSecuencia: in STD_LOGIC_VECTOR(4 downto 0);
        outSecuencia: out STD_LOGIC_VECTOR(3 downto 0)
    );
end eSecuenciaAleatoria;

architecture Behavioral of eSecuenciaAleatoria is
begin
    process(modoDemo, selectorSecuencia)
    begin
        if modoDemo = '1' then
            case selectorSecuencia is
                when "00000" => outSecuencia <= "1010";
                when "00001" => outSecuencia <= "1011";
                when "00010" => outSecuencia <= "1100";
                when "00011" => outSecuencia <= "1101";
                when "00100" => outSecuencia <= "1010";
                when "00101" => outSecuencia <= "1011";
                when "00110" => outSecuencia <= "1100";
                when "00111" => outSecuencia <= "1101";
                when "01000" => outSecuencia <= "1010";
                when "01001" => outSecuencia <= "1011";
                when "01010" => outSecuencia <= "1100";
                when "01011" => outSecuencia <= "1101";
                when "01100" => outSecuencia <= "1010";
                when "01101" => outSecuencia <= "1011";
                when "01110" => outSecuencia <= "1100";
                when "01111" => outSecuencia <= "1101";
                when "10000" => outSecuencia <= "1010";
                when "10001" => outSecuencia <= "1011";
                when "10010" => outSecuencia <= "1100";
                when "10011" => outSecuencia <= "1101";
                when "10100" => outSecuencia <= "1010";
                when "10101" => outSecuencia <= "1011";
                when "10110" => outSecuencia <= "1100";
                when "10111" => outSecuencia <= "1101";
                when "11000" => outSecuencia <= "1010";
                when "11001" => outSecuencia <= "1011";
                when "11010" => outSecuencia <= "1100";
                when "11011" => outSecuencia <= "1101";
                when "11100" => outSecuencia <= "1010";
                when "11101" => outSecuencia <= "1011";
                when "11110" => outSecuencia <= "1100";
                when "11111" => outSecuencia <= "1101";
                when others => outSecuencia <= "1101";
            end case;
        else
            case selectorSecuencia is
                when "00000" => outSecuencia <= "1100";
                when "00001" => outSecuencia <= "1010";
                when "00010" => outSecuencia <= "1100";
                when "00011" => outSecuencia <= "1101";
                when "00100" => outSecuencia <= "1010";
                when "00101" => outSecuencia <= "1011";
                when "00110" => outSecuencia <= "1010";
                when "00111" => outSecuencia <= "1100";
                when "01000" => outSecuencia <= "1010";
                when "01001" => outSecuencia <= "1011";
                when "01010" => outSecuencia <= "1010";
                when "01011" => outSecuencia <= "1101";
                when "01100" => outSecuencia <= "1010";
                when "01101" => outSecuencia <= "1100";
                when "01110" => outSecuencia <= "1010";
                when "01111" => outSecuencia <= "1011";
                when "10000" => outSecuencia <= "1010";
                when "10001" => outSecuencia <= "1100";
                when "10010" => outSecuencia <= "1101";
                when "10011" => outSecuencia <= "1100";
                when "10100" => outSecuencia <= "1010";
                when "10101" => outSecuencia <= "1011";
                when "10110" => outSecuencia <= "1100";
                when "10111" => outSecuencia <= "1011";
                when "11000" => outSecuencia <= "1010";
                when "11001" => outSecuencia <= "1101";
                when "11010" => outSecuencia <= "1010";
                when "11011" => outSecuencia <= "1101";
                when "11100" => outSecuencia <= "1100";
                when "11101" => outSecuencia <= "1011";
                when "11110" => outSecuencia <= "1011";
                when "11111" => outSecuencia <= "1100";
                when others => outSecuencia <= "1100";
            end case;
        end if;
    end process;

end Behavioral;
