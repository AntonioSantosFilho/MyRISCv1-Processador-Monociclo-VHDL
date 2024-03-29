----------------------------------------------------------
-- Testebench	                                        --
-- Max Santana                                          --
-- Antonio Filho	  (2023)                            --
-- CEComp/Univasf                                       --
----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture behavior of testbench is
	signal wire_clock, wire_reset: std_logic;
    constant clock_period: time := 10 ns;
    
    begin
    	PROCESSOR: entity work.processor port map(
            clock => wire_clock,
            reset => wire_reset
        );
        
       CLOCKGENERATOR: process
       begin
       for i in 0 to 5 loop
          wire_clock <= '0';
          wait for clock_period/2;
          wire_clock <= '1';
          wait for clock_period/2;
       end loop;
       wait;
      end process;
      
    process
    	begin
        wire_reset <= '1';
        wait for 10 ns;
        wire_reset <= '0';
        wait for 10 ns;
        wait;
      end process;
    end architecture behavior;
        
        