LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bo IS
generic(N: integer := 4);
PORT (clk : IN STD_LOGIC;
      sel1, CPB, CA : IN STD_LOGIC;
      entA, entB : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      Bz : OUT STD_LOGIC;
      conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		saida: out std_logic_vector(7 downto 0));
END bo;

ARCHITECTURE estrutura OF bo IS
	
	COMPONENT registrador IS
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

	COMPONENT registrador8 IS
	PORT (clk, carga : IN STD_LOGIC;
		  d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  	  q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT mux2para1 IS
	PORT ( a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		   sel: IN STD_LOGIC;
		   y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

	component mux2para1_8 IS
    PORT ( a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         sel: IN STD_LOGIC;
         y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
   END component;
	
	COMPONENT somador IS
	PORT (a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT subtrator IS
	PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		  s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END COMPONENT;

    COMPONENT igualazero IS
	PORT (a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          igual : OUT STD_LOGIC);
	END COMPONENT;
		
	SIGNAL saimux2, sairegA, sairegB, saisub: STD_LOGIC_VECTOR (N-1 DOWNTO 0);
	SIGNAL saimux1, sairegP, saisoma: STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
	mux1: mux2para1_8 PORT MAP (a => saisoma,
							  b => "00000000",
							  sel => sel1,
							  y => saimux1);
	mux2: mux2para1 PORT MAP (a => saisub,
							  b => entB,
							  sel => sel1,
							  y => saimux2);
	regP: registrador8 PORT MAP (clk => clk,
								  carga => CPB,
								   d => saimux1,
								   q => sairegP);
	regA: registrador PORT MAP (clk => clk,
								carga => CA,
								d => entA,
								q => sairegA);
	regB: registrador PORT MAP (clk => clk,
								carga => CPB,
								d => saimux2,
								q => sairegB);
	geraBz: igualazero PORT MAP (a => sairegB,
								 igual => Bz); 
	sub: subtrator PORT MAP (a => sairegB,
							 b => "0001",
							 s => saisub);
	som: somador PORT MAP (a => sairegP,
						   b => "0000" & sairegA,
					 	   s => saisoma);
	
	saida <= sairegP;
	conteudoA <= sairegA;
	conteudoB <= sairegB;

END estrutura;