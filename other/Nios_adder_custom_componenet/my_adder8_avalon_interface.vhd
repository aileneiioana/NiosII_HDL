LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY my_adder8_avalon_interface IS
PORT ( clock, resetn :IN STD_LOGIC;
read, write : IN STD_LOGIC;
writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END my_adder8_avalon_interface;

ARCHITECTURE Structure OF my_adder8_avalon_interface IS
SIGNAL to_adder : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL from_adder : STD_LOGIC_VECTOR(16 DOWNTO 0);
COMPONENT FA_8 is
 port(Cin: in std_logic;
 X,Y: in std_logic_vector(15 downto 0);
Enable_FA: in std_logic;
 sum: out std_logic_vector(15 downto 0);
Cout: out std_logic);
 end COMPONENT;
 
BEGIN
to_adder <= writedata;
full_adder_instance: FA_8 PORT MAP ('0',to_adder(31 downto 16),to_adder(15 downto
0),write,from_adder(15 downto 0),from_adder(16));
readdata <= "000000000000000" & from_adder;
END Structure;