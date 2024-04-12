library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity slowClock is
    Port ( fastClock : in STD_LOGIC;
           slowClock : inout STD_LOGIC;
           prescaler : in INTEGER RANGE 0 TO 50000000);
end slowClock;

architecture archSlowClock of slowClock is

begin

slowClockProcess:process(fastClock)

variable countFastCycles:INTEGER RANGE 0 TO 50000000;

begin

if rising_edge(fastClock) then
    countFastCycles := countFastCycles + 1;
    if countFastCycles = prescaler then
        slowClock <= NOT slowClock;
        countFastCycles := 0;
    end if;
end if;

end process slowClockProcess;

end archSlowClock;
