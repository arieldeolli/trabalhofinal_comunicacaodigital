-- Trabalho de Comunicação Digital
-- Alunos: Ariel, Carlos e Eric
-- Professor: Felipe Viel

-- Bibliotecas utilizadas
library ieee;
use ieee.std_logic_1164.all;

entity hamming12x8 is port
(

	i_DATA  : in std_logic_vector (7 downto 0); -- entrada de dados
	o_DATA  : out std_logic_vector (11 downto 0) -- saída	

);
end hamming12x8;

architecture arch_hamming12x8 of hamming12x8 is
  signal a : std_logic;
  signal b : std_logic;
  signal c : std_logic;
  signal d : std_logic;

begin
   a <= i_DATA(0) xor i_DATA(1) xor i_DATA(3) xor i_DATA(4) xor i_DATA(6);
	b <= i_DATA(0) xor i_DATA(2) xor i_DATA(3) xor i_DATA(5) xor i_DATA(6);
	c <= i_DATA(1) xor i_DATA(2) xor i_DATA(3) xor i_DATA(7);
	d <= i_DATA(4) xor i_DATA(5) xor i_DATA(6) xor i_DATA(7);
	
	o_DATA(0) <= a;
	o_DATA(1) <= b;
	o_DATA(2) <= i_DATA(0);
	o_DATA(3) <= c;
	o_DATA(4) <= i_DATA(1);
	o_DATA(5) <= i_DATA(2);
	o_DATA(6) <= i_DATA(3);
	o_DATA(7) <= d;
	o_DATA(8) <= i_DATA(4);
	o_DATA(9) <= i_DATA(5);
	o_DATA(10) <= i_DATA(6);
	o_DATA(11) <= i_DATA(7);

end arch_hamming12x8;
