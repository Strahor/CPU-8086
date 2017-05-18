LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY register16 IS
	PORT(
		reg_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- input.
		ld : IN STD_LOGIC; -- load/enable.
		inc : IN STD_LOGIC; -- increment
		dec : IN STD_LOGIC; -- decrement
		clr : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		shl : IN STD_LOGIC; -- shift left
		r_bit : IN STD_LOGIC; -- new 0 bit after left shift
		shr : IN STD_LOGIC; -- shift right
		l_bit : IN STD_LOGIC; -- new 15 bit after right shift
		reg_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- output.
	END register16;
ARCHITECTURE description OF register16 IS

BEGIN
	process(clk, clr)
	begin
		if clr = '1' then 
			reg_out <= x"0000";
		elsif rising_edge(clk) then
			if ld = '1' then
				reg_out <= reg_in;
			elsif inc = '1' then
				reg_out <= std_logic_vector( unsigned(reg_out) + 1);
			elsif dec = '1' then
				reg_out <= std_logic_vector( unsigned(reg_out) - 1);
			elsif shl = '1' then
				reg_out <= (15 downto 1 => reg_out(14 downto 0), 0 => r_bit);
			elsif shr = '1' then
				reg_out <= (15 => l_bit, 14 downto 0 => reg_out(15 downto 1));
		end if;
	end process;
END description;
