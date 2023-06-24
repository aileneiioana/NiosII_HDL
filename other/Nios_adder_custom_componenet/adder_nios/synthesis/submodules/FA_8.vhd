library ieee;
 use ieee.std_logic_1164.all;
 entity FA_8 is
 port(Cin: in std_logic;
 X,Y: in std_logic_vector(15 downto 0);
Enable_FA: in std_logic;
 sum: out std_logic_vector(15 downto 0);
Cout: out std_logic);
 end FA_8;

 architecture arch of FA_8 is
begin
process(X,Y,Enable_FA,Cin)
variable C:std_logic_vector(16 downto 0);
begin
if (Enable_FA='1') then
C(0):=Cin;
for i in 0 to 15 loop
sum(i) <= (X(i) xor Y(i)) xor C(i);
C(i+1) := (X(i) and Y(i)) or (C(i) and (X(i) xor Y(i)));
end loop;
Cout<=C(16);
end if;
end process;
 end arch;