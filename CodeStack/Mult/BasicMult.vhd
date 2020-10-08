----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2019 03:17:43 PM
-- Design Name: 
-- Module Name: BasicMult - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BasicMult is
	Generic(
		cIWGlobal		: integer := 32; --Input Integer part Width
		cFWGlobal		: integer := 32 --Input Fractional part Width
		);
    Port ( 
		I1 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        I2 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        O : out signed (2*(cIWGlobal+cFWGlobal)-1 downto 0)
		);
end BasicMult;

architecture Behavioral of BasicMult is
begin
	O <= I1 * I2;
end Behavioral;
