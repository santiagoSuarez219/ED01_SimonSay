library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dataBCD7Seg is
  Port (dataBCD: in STD_LOGIC_VECTOR(3 downto 0);
        catodos : out STD_LOGIC_VECTOR(7 downto 0));
end dataBCD7Seg;

architecture Behavioral of dataBCD7Seg is

begin
    catodos <= "00000011" when dataBCD = "0000" else -- 0
               "10011111" when dataBCD = "0001" else -- 1
               "00100101" when dataBCD = "0010" else -- 2
               "00001101" when dataBCD = "0011" else -- 3
               "10011001" when dataBCD = "0100" else -- 4
               "01001001" when dataBCD = "0101" else -- 5
               "01000001" when dataBCD = "0110" else -- 6
               "00011111" when dataBCD = "0111" else -- 7
               "00000001" when dataBCD = "1000" else -- 8
               "00001001" when dataBCD = "1001" else -- 9
               "00010001" when dataBCD = "1010" else -- A
               "11000001" when dataBCD = "1011" else -- b
               "01100001" when dataBCD = "1100" else -- C
               "10000101" when dataBCD = "1101" else -- d
               "11100011" when dataBCD = "1110" else -- L
               "10010001" when dataBCD = "1111" else -- H
               "11111110";
end Behavioral;
