-- Trabalho de Comunicação Digital
-- Alunos: Ariel, Carlos e Eric
-- Professor: Felipe Viel

-- Bibliotecas utilizadas
library ieee;
use ieee.std_logic_1164.all;

entity axi4 is port
(

	i_ACLK  : in std_logic; -- clock do axi4
	i_VALID : in  std_logic; -- VALID 
	i_TREADY : in  std_logic; -- TREADY
	i_DATA  : in std_logic_vector (7 downto 0); -- para ler dados do Buffer
   o_TVALID : out std_logic; -- TVALID
	o_TDATA  : out std_logic_vector (7 downto 0) -- saída

);
end axi4;

architecture arch_axi4 of axi4 is

signal sinal_1 : std_logic := '1';
begin
  p0: process (i_ACLK, i_DATA, i_VALID, i_TREADY) --inicia processo p0
  begin
	  if(i_TREADY = '1') then -- se i_TREADY for 1, envia dados para TDATA
	     o_TDATA <= i_DATA; -- envia dados
		  o_TVALID <= sinal_1; -- depois que enviou os dados o_TVALID = 1
	  end if;
  end process p0;	-- fim do processo p0  

end arch_axi4;
