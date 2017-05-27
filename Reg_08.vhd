LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.std_logic_arith.ALL;
--USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
ENTITY register8 IS
	PORT(
		reg_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- input.
		ld : IN STD_LOGIC; -- load/enable.
		inc : IN STD_LOGIC; -- increment
		dec : IN STD_LOGIC; -- decrement
		clr : IN STD_LOGIC; -- async. clear.
		clk : IN STD_LOGIC; -- clock.
		shl : IN STD_LOGIC; -- shift left
		r_bit : IN STD_LOGIC; -- new 0 bit after left shift
		shr : IN STD_LOGIC; -- shift right
		l_bit : IN STD_LOGIC; -- new 7 bit after right shift
		reg_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- output
	);
	END register8;
ARCHITECTURE description OF register8 IS
	SIGNAL reg_val : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	reg_out <= reg_val;
	process(clk, clr)
	begin
		if clr = '1' then 
			reg_val <= x"00";
		elsif rising_edge(clk) then
			if ld = '1' then
				reg_val <= reg_in;
			elsif inc = '1' then
				reg_val <= STD_LOGIC_VECTOR( UNSIGNED(reg_val) + 1);
			elsif dec = '1' then
				reg_val <= STD_LOGIC_VECTOR( UNSIGNED(reg_val) - 1);
			elsif shl = '1' then
				reg_val <= reg_val(6 downto 0) & r_bit;
			elsif shr = '1' then
				reg_val <= l_bit & reg_val(7 downto 1);
			end if;
		end if;
	end process;
END description;
