-- Trabalho de Comunicação Digital
-- Alunos: Ariel, Carlos e Eric
-- Professor: Felipe Viel

-- Bibliotecas utilizadas
library ieee;
use ieee.std_logic_1164.all;

entity spi is port
(

	i_SCLK  : in std_logic; -- clock do spi
	i_TVALID : in  std_logic; -- TVALID 
	i_DATA  : in std_logic_vector (7 downto 0); -- entrada de dados
	o_TREADY : out  std_logic := '1'; -- TREADY inicia em 1 pq só vamos testar com 1 pacote de dados
	o_TDATA  : out std_logic_vector (11 downto 0); -- saída
	o_SS : out std_logic -- saida !SS

);
end spi;

architecture arch_spi of spi is

  component hamming12x8 -- declara o componente hamming12x8
	port (i_DATA  : in std_logic_vector (7 downto 0);
	      o_DATA  : out std_logic_vector (11 downto 0));
	end component hamming12x8;

  signal sinal_0 : std_logic := '0';
  signal w_ENTRADAHAMMING : std_logic_vector (7 downto 0); -- fio para iterligar i_DATA ao Hamming
  signal w_SAIDAHAMMING : std_logic_vector (11 downto 0); -- fio para interligar saída do Hamming no o_TDATA

begin
   
   x0: hamming12x8 PORT MAP(w_ENTRADAHAMMING, w_SAIDAHAMMING); -- interliga SPI ao Hamming12x8
	
   p0: process (i_SCLK, i_DATA, i_TVALID) --inicia processo p0
	variable q_VAR : std_logic_vector (11 downto 0);
   begin
	  if(i_TVALID = '1') then -- se i_TVALID for 1, inicia o processo
	     
        w_ENTRADAHAMMING <= i_DATA;
		  
		  o_SS <= sinal_0;-- saída !SS=0 antes de enviar os dados
		  
		  o_TDATA <= w_SAIDAHAMMING;  -- saída do SPI recebe saída do Hamming
		  
	  end if;
   end process p0;	-- fim do processo p0

end arch_spi;
