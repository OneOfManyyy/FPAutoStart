----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2019 04:41:58 PM
-- Design Name: 
-- Module Name: WC_AddSub - Behavioral
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

entity WC_AddSub is
	Generic(
		cIWGlobal		: integer := 32; --Input Integer part Width
		cFWGlobal		: integer := 32; --Input Fractional part Width
		cAddSubSel		: boolean := true --Add/Subtract Select
		);
    Port ( 
		I1 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        I2 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        O : out signed (cIWGlobal+cFWGlobal-1 downto 0);

		-- Widths for the Width Adapters

		In1IW	: in integer range 0 to cIWGlobal; --Output Integer part Width
		In1FW	: in integer range 0 to cFWGlobal; --Output Fractional part Width
		In2IW	: in integer range 0 to cIWGlobal; --Output Integer part Width
		In2FW	: in integer range 0 to cFWGlobal --Output Fractional part Width

		);
end WC_AddSub;

architecture Behavioral of WC_AddSub is
	-- importing components
	
	-- Width Adapter
	component WidthAdapter is
		Generic(
			cIWGlobal		: integer := 32; --Input Integer part Width
			cFWGlobal		: integer := 32 --Input Fractional part Width
			);
		Port ( 
			--Input and Adapted Output
			I 		: in signed (cIWGlobal+cFWGlobal-1 downto 0);
			O 		: out signed (cIWGlobal+cFWGlobal-1 downto 0);
			--Configurable Output Widths
			OutIW	: in integer range 0 to cIWGlobal; --Output Integer part Width
			OutFW	: in integer range 0 to cFWGlobal --Output Fractional part Width
			);
	end component WidthAdapter;
	
	-- Basic Add Sub
	component BasicAddSub is
	Generic(
		cIWGlobal		: integer := 32; --Input Integer part Width
		cFWGlobal		: integer := 32; --Input Fractional part Width
		cAddSubSel		: boolean := true   --true for add, false for sub
		);
    Port ( 
		I1 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        I2 : in signed (cIWGlobal+cFWGlobal-1 downto 0);
        O : out signed (cIWGlobal+cFWGlobal-1 downto 0)
		);
	end component BasicAddSub;
	
	signal	sWAI1	: signed (cIWGlobal+cFWGlobal-1 downto 0); -- Width adapted Inputs
	signal	sWAI2	: signed (cIWGlobal+cFWGlobal-1 downto 0); -- Width adapted Inputs
	
begin
	WidthAdapter_inst1: WidthAdapter
	Generic map
	(
		cIWGlobal => cIWGlobal,
		cFWGlobal => cFWGlobal
	)
	Port map
	(
		--Input and Adapted Output
		I => I1,
		O => sWAI1,
		--Configurable Output Widths
		OutIW => In1IW,
		OutFW => In1FW
	);
	
	WidthAdapter_inst2: WidthAdapter
	Generic map
	(
		cIWGlobal => cIWGlobal,
		cFWGlobal => cFWGlobal
	)
	Port map
	(
		--Input and Adapted Output
		I => I2,
		O => sWAI2,
		--Configurable Output Widths
		OutIW => In2IW,
		OutFW => In2FW
	);
	
	BasicAddSub_inst1: BasicAddSub
	Generic map
	(
		cIWGlobal => cIWGlobal,
		cFWGlobal => cFWGlobal,
		cAddSubSel => cAddSubSel
	)
    Port map
	( 
		I1 => sWAI1,
        I2 => sWAI2,
        O => O
	);
	
	

end Behavioral;
