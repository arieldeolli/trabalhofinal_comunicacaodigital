-- Trabalho de Comunicação Digital
-- Alunos: Ariel, Carlos e Eric
-- Professor: Felipe Viel

-- Bibliotecas utilizadas
library ieee;
use ieee.std_logic_1164.all;

entity ip is port
(

	i_CLK, i_RESET, i_VALID  : in std_logic; -- clock do IP
	i_DATA  : in std_logic_vector (7 downto 0);
	o_SS : out std_logic;
	o_IP  : out std_logic_vector (11 downto 0) -- entrada de dados
	
);
end ip;

architecture arch_ip of ip is

component reg8 -- declara o componente reg8
	port (i_DATA  : in std_logic_vector (7 downto 0);
	      i_RESETN, i_CLOCK : in std_logic;
	      o_DATA  : out std_logic_vector (7 downto 0));
	end component reg8;
	
	
	component axi4 -- declara o componente axi4
	port (i_ACLK, i_VALID, i_TREADY : in std_logic;
	      i_DATA  : in std_logic_vector (7 downto 0);
			o_TVALID : out std_logic;
			o_TDATA  : out std_logic_vector (7 downto 0));
	end component axi4;
	
	component spi -- declara o componente spi
	port (i_SCLK, i_TVALID : in std_logic;
	      i_DATA  : in std_logic_vector (7 downto 0);
			o_TREADY : out  std_logic;
			o_TDATA  : out std_logic_vector (11 downto 0); 
			o_SS : out std_logic);
	end component spi;
	
	
	signal w_TREADY : std_logic; -- fio para interligar TREADY do SPI no AXI4
	signal w_TVALID : std_logic; -- fio para interligar TVALID do AXI4 no SPI
	signal w_DATA1 : std_logic_vector(7 downto 0); -- fio para interligar saída do REG8 no AXI4
	signal w_DATA2 : std_logic_vector(7 downto 0); -- fio para interligar saída do AXI4 no SPI

begin
   
	x0: reg8 PORT MAP(i_DATA, i_RESET, i_CLK, w_DATA1); -- interliga reg8 ao ip e ao AXI4
	x1: axi4 PORT MAP (i_CLK, i_VALID, w_TREADY, w_DATA1, w_TVALID, w_DATA2); -- interliga AXI4 ao IP, REG8 e SPI
   x2: spi PORT MAP(i_CLK, w_TVALID, w_DATA2, w_TREADY, o_IP, o_SS); -- interliga SPI ao AXI4 e ao IP
end arch_ip;
