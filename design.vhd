----------------------------------------------------------
-- DESIGN		                                        --
-- Max Santana                                          --
-- Antonio Filho	  (2023)                            --
-- CEComp/Univasf                                       --
----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity processor is
	port(clock, reset: in std_logic);
end processor;

architecture behavior of processor is 
	
    signal wireJr,
    wireBranch, 
    wireBne, 
    wireMemRW,    
    wireAluSrc, 
    wireRegWrite, 
    wireZero, 
    wireMemWrite : std_logic;
    
    signal wirePCplus4, 
    wireInst, 
    wireWriteData,
    wireJumpAddr,
    wireReadData1,
    wireReadData2,
    wireResult, 
    wireBranchAddr,
    wireImm, wireAddress,
    wireMemoryData : std_logic_vector(31 downto 0); 
        
	signal wireOp,
    wireFunct : std_logic_vector (5 downto 0);
    
    signal wireAluOp, 
    wireMemToReg,
    wireJump, 
    wireRegDst : std_logic_vector (1 downto 0);
    
    begin
    
   ICONTROL : entity work.control port map (
        op		 => wireOp,
        jr 		=> wireJr,
        funct	=> wireFunct,
        regDst	 => wireRegDst,
        jump	 => wireJump,
        branch	 => wireBranch,
        bne		 => wireBne,
        memWR	 => wireMemRW,                   
        memToReg => wireMemToReg,
        aluOp	 => wireAluOp,                                            
        aluSrc	 => wireAluSrc,
        regWrite => wireRegWrite
    );
		
    IDECODE : entity work.decode port map ( 
        clk        => clock,
        rst        => reset,
        PCplus4    => wirePCplus4,
        inst       => wireInst,
        writeData  => wireWriteData,
        regDst     => wireRegDst,              
        regWrite   => wireRegWrite,
        opcode     => wireOp,
        jumpAddr   => wireJumpAddr,
        readData1  => wireReadData1,
        readData2  => wireReadData2,
        imm        => wireImm,
        funct      => wireFunct
    );
	
    IEXECUTE : entity work.execute port map ( 
    	PCplus4    => wirePCplus4,
        aluSrc     => wireAluSrc,                     
        readData1  => wireReadData1,
        readData2  => wireReadData2,
        imm  	   => wireImm,
        funct      => wireFunct,
        aluOP	   => wireAluOp,
        zero       => wireZero,                
        result     => wireResult,
        branchAddr => wireBranchAddr
    );
	
    
    IFETCH : entity work.fetch port map ( 
    	clk        => clock,
        rst        => reset,
        jr			=> wireJr,
        bne	       => wireBne,
        readData1	=> wireReadData1,
        branch     => wireBranch, 
        jump       => wireJump,                   
        zero       => wireZero,                
        jumpAddr   => wireJumpAddr,
        branchAddr => wireBranchAddr,
        PCplus4    => wirePCplus4,
        inst       => wireInst

    );
    
    IMEMORYACCESS : entity work.memoryAccess port map (
    	address    => wireAddress,
        memWrite   => wireMemWrite,
        writeData  => wireWriteData,
        clock        => clock,
        memoryData => wireMemoryData
    );
	
    IWRITEBACK : entity work.writeback port map ( 
        memoryData => wireMemoryData,
        result     => wireResult,
        PCplus4		=> wirePCplus4,
        memToReg   => wireMemToReg,
        writeData  => wireWriteData
    );
      
end architecture behavior;