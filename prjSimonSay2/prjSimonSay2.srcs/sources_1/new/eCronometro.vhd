library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity eCronometro is
    generic(
        cuenta : integer range 3 to 6 := 3
    );
    Port ( 
        CLK, RST : in STD_LOGIC;
        indicadorCero: out STD_LOGIC;
        outCuenta : out STD_LOGIC_VECTOR(3 downto 0)
    );
end eCronometro;

architecture Behavioral of eCronometro is

begin
    process(CLK, RST)
    variable cuenta_i : integer range 3 to 6 := cuenta;
    begin
        if RST = '1' then
            cuenta_i := cuenta; 
            indicadorCero <= '0';
        elsif rising_edge(CLK) and cuenta_i > 0 then
            cuenta_i := cuenta_i - 1;
        end if;
        
        if cuenta_i = 0 then
            indicadorCero <= '1';
        else
            indicadorCero <= '0';
        end if;
        outCuenta <= std_logic_vector(to_unsigned(cuenta_i, 4));
    end process;


end Behavioral;
