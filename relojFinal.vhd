library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity relojFinal is 

port (
     clk:in std_logic;
	  sentidoI: in std_logic;
	  displayDecenas:out std_logic_vector(6 downto 0);
	  displayUnidades:out std_logic_vector(6 downto 0));
	  
end relojFinal;


architecture paimon of relojFinal is

component divisorFrecuencia is
	port(
	  clk :in std_logic;
	  out1,out2 :buffer std_logic);
	
end component;

component Contador is
   port(
      CLK:in std_logic;
      sentido:in std_logic;
      salida: out std_logic_vector(5 downto 0) );
		
end Component;

component decodificador is
   port (
      S : in std_logic_vector(5 downto 0);
      X: out std_logic_vector(7 downto 0));
		
end component;

component Displays7Seg4bits is
   port  (
	   abcd : in std_logic_vector(3 downto 0) ;
	   salida1 : out std_logic_vector(6 downto 0));
	
end component ;

signal aux1 : std_logic;
signal aux2 : std_logic_vector(5 downto 0);
signal aux3 : std_logic_vector(7 downto 0);
signal aux4, aux5 : std_logic_vector(3 downto 0);

begin

paso1 : divisorFrecuencia port map (clk => clk, out1 => aux1);
paso2 : contador port map (CLK => aux1, sentido => sentidoI, salida => aux2);
paso3 : decodificador port map (s => aux2, X => aux3);

aux4 <= aux3(7 downto 4);
aux5 <= aux3(3 downto 0);

paso4 : Displays7Seg4bits port map (abcd => aux4, salida1 => DisplayDecenas);
paso5 : Displays7Seg4bits port map (abcd => aux5, salida1 => DisplayUnidades);

end paimon;