library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eCronometro is
    Port ( 
        CLK, RST : in STD_LOGIC;
        indicadorCero: out STD_LOGIC;
        outCuenta : out STD_LOGIC_VECTOR(2 downto 0)
    );
end eCronometro;

architecture Behavioral of eCronometro is

begin
    process(CLK, RST)
    variable cuenta : STD_LOGIC_VECTOR(2 downto 0) := "011";
    begin
        if RST = '1' then
            cuenta := "011";
        elsif rising_edge(CLK) then
            cuenta := cuenta - 1;
            if cuenta = "000" then
                cuenta := "011";
                indicadorCero <= '1';
            end if;
        end if;

        outCuenta <= cuenta;
    end process;


end Behavioral;
