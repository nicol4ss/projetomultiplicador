LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (Reset, clk, inicio : IN STD_LOGIC;
      Bz : IN STD_LOGIC;
      pronto : OUT STD_LOGIC;
      CA, CPB, sel1: OUT STD_LOGIC);
END bc;

ARCHITECTURE estrutura OF bc IS
    TYPE STATES IS (S0, S1, S2, S3, S4);
    SIGNAL EAtual, PEstado: STATES;
BEGIN
    PROCESS (clk, Reset)
    BEGIN
        if(Reset = '1') THEN
            EAtual <= S0;
        elsif (clk'EVENT AND clk = '1') then
            EAtual <= PEstado;
        end if;
    end process;
    
    process(EAtual, PEstado, inicio, Bz)
    begin
            CASE EAtual IS
                WHEN S0 =>
                    CA <= '0';
                    CPB <= '0';
                    sel1 <= '0';
                    pronto <= '0';
                    if (inicio = '0') then
                        PEstado <= S0;
                    else
                        PEstado <= S1;
                    end if;

                WHEN S1 => 
                    CA <= '1';
                    CPB <= '1';
                    sel1 <= '1';
                    pronto <= '0';

                    PEstado <= S2;
                    

                WHEN S2 =>
                    CA <= '0';
                    CPB <= '0';
                    sel1 <= '0';
                    pronto <= '0';
                    if (Bz = '1') then
                         PEstado <= S4;
                    else
                         PEstado <= S3;
                    end if;

                WHEN S3 =>
                    CA <= '0';
                    CPB <= '1';
                    sel1 <= '0';
                    pronto <= '0';
            
                    PEstado <= S2;

                WHEN S4 =>
                    CA <= '0';
                    CPB <= '0';
                    sel1 <= '0';
                    pronto <= '1';

                    PEstado <= S0;

            END CASE;        
    END PROCESS;
END estrutura;