----------------------------------------------------------
-- Control		                                        --
-- Max Santana                                          --
-- Antonio Filho	  (2023)                            --
-- CEComp/Univasf                                       --
----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity control is
  port(
 	funct    : in std_logic_vector(5 downto 0);   -- funct    
    op		 : in std_logic_vector(5 downto 0);
    regDst	 : out std_logic_vector(1 downto 0);
    jump	 : out std_logic_vector(1 downto 0);
    branch	 : out std_logic;
    bne		 : out std_logic;
    memWR	 : out std_logic;                    -- when 0 (write), 1 (read)
    memToReg     : out std_logic_vector(1 downto 0);
    aluOp	 : out std_logic_vector(1 downto 0); -- when 10 (R-type),                                                    
    jr		:  out std_logic;                                              
    aluSrc	 : out std_logic;
    regWrite     : out std_logic
    
  );
end control;

architecture behavior of control is
begin
  process(op)
  begin
    case (op) is   
      when "000000" => 		-- R type 
        regDst   <= "01";
		jump <= "10" when funct = "001000" else "00";
        branch   <= '0';
        memWR    <= 'X';
        bne		 <= '0';
        jr		<= '1' when funct = "001000" else '0';
        memToReg <= "00";
        aluOp	 <= "10";
        aluSrc	 <= '0';
        regWrite <= '1';          
      when "100011" => 		-- lw
      	bne		 <= '0';
      when "101011" =>
      	bne		 <= '0';	-- sw        
      when "000100" =>
      	bne		 <= '0';	-- beq       
      when "000101" =>  	-- bne  
      regDst	 <= "XX";
		jump	 <= "00";
        branch	 <= '0';
        bne		 <= '1';
        memWR	 <= 'X';
        memToReg <= "XX";
        aluOp	 <= "01";
        aluSrc	 <= 'X';
        regWrite <= 'X'; 	           
      when "001000" => 		-- addi
     	bne		 <= '0';
        regDst	 <= "00";
		jump	 <= "00";
        branch	 <= '0';        
        memWR	 <= 'X';
        memToReg <= "00";
        aluOp	 <= "00";
        aluSrc	 <= '1';
        regWrite <= '1';
      when "000010" =>		-- j
        regDst	 <= "XX";
		jump	 <= "01";
        branch	 <= 'X';
        bne		 <= 'X';
        memWR	 <= 'X';
        memToReg <= "XX";
        aluOp	 <= "XX";
        aluSrc	 <= 'X';
        regWrite <= 'X';
       when "000011" => 	-- jal
        regDst	 <= "10";
		jump	 <= "01";
        branch	 <= 'X';
        bne		 <= 'X';
        memWR	 <= '0';
        memToReg <= "10";
        aluOp	 <= "XX";
        aluSrc	 <= 'X';
        regWrite <= '1';     
      when others =>
    	bne		 <= 'X';
        regDst	 <= "XX";
		jump	 <= "XX";
        branch	 <= 'X';
        memWR	 <= 'X';
        memToReg <= "XX";
        aluOp	 <= "XX";
        aluSrc	 <= 'X';
        regWrite <= '0';	 
    end case;	    
  end process;

end behavior;