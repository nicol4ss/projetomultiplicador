LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY igualazero IS
generic(N: integer:=8);
PORT (a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	igual : OUT STD_LOGIC);
END igualazero;

ARCHITECTURE estrutura OF igualazero IS
BEGIN
	igual <= '1' WHEN A = "00000000" ELSE '0';
END estrutura;