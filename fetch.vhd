----------------------------------------------------------
-- Instruction Fetch                                    --
-- Max Santana                                          --
-- Antonio Filho	  (2023)                            --
-- CEComp/Univasf                                       --
----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fetch is
  port(
    clk        : in std_logic;
    rst        : in std_logic;
    bne 		: in std_logic;
    branch     : in std_logic;                      -- control signal (branch)
    jump       : in std_logic_vector(1 downto 0);                      -- control signal (jump)
    zero       : in std_logic;                      -- control signal (zero)
    jr			:  out std_logic;   
    readData1  : in std_logic_vector(31 downto 0);
    jumpAddr   : in std_logic_vector(31 downto 0);  -- Jump Address
    branchAddr : in std_logic_vector(31 downto 0);  -- Branch Address
    PCplus4    : out std_logic_vector(31 downto 0); -- next program counter (PC+4)
    inst       : out std_logic_vector(31 downto 0)  -- instruction
  );
end fetch;

architecture behavior of fetch is
  signal wireBranchAddr, wireInstAddr, wireNextPC, wireJumpAddr, wireOut : std_logic_vector(31 downto 0);
begin
  PC : entity work.rreg32 port map (
    clk => clk, 
    rst => rst, 
    d => wireNextPC, 
    q => wireInstAddr
  );
  ADDER: entity work.adder32 port map (
    a => wireInstAddr,
    b => x"00000004",
    s => PCplus4
  );
  MUXJUMP: entity work.mux332 port map (
    d0 => wireBranchAddr,
    d1 => jumpAddr,
    d2 => readData1,
    s  => jump,
    y  => wireNextPC
  );
  MUXBRANCH: entity work.mux232 port map (
    d0 => PCPlus4,
    d1 => branchAddr,
    s  => (zero and branch) or (bne and not zero),
    y  => wireBranchAddr
      );

  IMEMORY: entity work.rom port map (
    address => wireInstAddr,
    data    => inst
  );
end behavior;