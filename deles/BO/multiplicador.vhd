LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity multiplicador is
    generic(n: integer:=8);
    port(
         inicio: in std_logic;
         reset: in std_logic;
         ck: in std_logic;
         entA: in std_logic_vector(3 downto 0);
         entB: in std_logic_vector(3 downto 0);
         pronto: out std_logic;
         saida: out std_logic_vector(N-1 downto 0);
         conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
         );
end multiplicador;

architecture teste of multiplicador is
    signal tempaz, tempbz, tempCP, tempCA, tempdec, tempini: std_logic;

    component bo is
        port (clk : IN STD_LOGIC;
              ini, CP, CA, dec : IN STD_LOGIC;
              entA, entB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
              Az, Bz : OUT STD_LOGIC;
              conteudoA, conteudoB : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              saida: out std_logic_vector(N-1 downto 0));
    end component;

    component bc is
        port (Reset, clk, inicio : IN STD_LOGIC;
              Az, Bz : IN STD_LOGIC;
              pronto : OUT STD_LOGIC;
              ini, CA, dec, CP: OUT STD_LOGIC );
    end component;

begin

    BO1: bo port map(clk => ck,
                     ini => tempini,
                     CP => tempCP,
                     CA => tempCA,
                     dec => tempdec,
                     entA => entA,
                     entB => entB,
                     Az => tempaz,
                     Bz => tempbz,
                     saida => saida,
                     conteudoA => conteudoA,
                     conteudoB => conteudoB);

    BC1: bc port map(Reset => reset,
                     clk => ck,
                     inicio => inicio,
                     Az => tempaz,
                     Bz => tempbz,
                     pronto => pronto,
                     ini => tempini,
                     CA => tempCA,
                     dec => tempdec,
                     CP => tempCP);
end teste;