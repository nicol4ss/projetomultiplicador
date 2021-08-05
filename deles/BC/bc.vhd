LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
      Az, Bz : IN STD_LOGIC;
      pronto : OUT STD_LOGIC;
      ini, CA, dec, CP: OUT STD_LOGIC );
END bc;

-- Sinais de comando
-- ini = RstP = mA = CB  => ini=1 somente em S1
-- CA=1 em S1 e em S4
-- dec = op = m1 = m2  => dec=1 somente em S4 (estado no qual ocorre A <= A - 1 )
-- CP=1 somente em S3 (estado no qual ocorre P <= P + B )


ARCHITECTURE estrutura OF bc IS
	TYPE STATES IS (S0, S1, S2, S3, S4, S5 );
	SIGNAL EAtual, PEstado: STATES;
BEGIN
	-- Logica de proximo estado (e registrador de estado)
	PROCESS (clk, Reset)
	BEGIN
		if(Reset = '1') THEN
			EAtual <= S0 ;
		ELSIF (clk'EVENT AND clk = '1') THEN
			EAtual <= PEstado;
		end if;
	end process;
	
	process(EAtual, PEstado, inicio, Az, Bz)
	begin
			CASE EAtual IS
				WHEN S0 =>
                ini <= '0';
				    CA <= '0';
				    dec <= '0';
				    CP <= '0';
				    pronto <= '0';
					 
					if (inicio = '0') then
                    PEstado <= S0;
                else
                    PEstado <= S1;
                end if;

				WHEN S1 => 
                pronto <= '0';
				    CA <= '1';
				    ini <= '1';
				    dec <= '0';
				    CP <= '0';

                PEstado <= S2;
					

				WHEN S2 =>
                ini <= '0';
				    CA <= '0';
				    dec <= '0';
				    CP <= '0';
				    pronto <= '0';
					if (Az = '1' or Bz = '1') then
						 PEstado <= S5;
					else
						 PEstado <= S3;
					end if;

				WHEN S3 =>
						ini <= '0';
               	CA <= '0';
               	dec <= '0';
               	CP <= '1';
               	pronto <= '0';
            
					PEstado <= S4;

				WHEN S4 =>
					ini <= '0';
				    CA <= '1';
				    dec <= '1';
				    CP <= '0';
				    pronto <= '0';

                PEstado <= S2;

				WHEN S5 =>
                pronto <= '1';
				    ini <= '0';
				    CA <= '0';
				    dec <= '0';
				    CP <= '0';

                PEstado <= S0;
			END CASE;		
	END PROCESS;
END estrutura;