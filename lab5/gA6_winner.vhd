-- entity name: gA6_winner
--
-- Copyright (C) 2017 Abbas Yadollahi - He Qian Wang
-- Version 1.0
-- Author: Abbas Yadollahi (abbas.yadollahi@mail.mcgill.ca)
--         He Qian Wang (he.q.wang@mail.mcgill.ca)
-- Date: Nov/29/2017

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity gA6_winner is
	port(
		clk			: in std_logic;
		enable		: in std_logic;
		player_sum	: in std_logic_vector(5 downto 0);
		dealer_sum	: in std_logic_vector(5 downto 0);

		player_wins		: out std_logic;
		dealer_wins		: out std_logic;
		led_display1	: out std_logic_vector(6 downto 0);
		led_display2	: out std_logic_vector(6 downto 0);
		led_display3	: out std_logic_vector(6 downto 0);
		led_display4	: out std_logic_vector(6 downto 0)
	);
end gA6_winner;

architecture behavior of gA6_winner is
	begin
		dealer: process(clk, player_sum, dealer_sum)

		variable p_win	: std_logic;
		variable d_win	: std_logic;

		begin
			if enable = '1' and rising_edge(clk) then
				if unsigned(player_sum) > 21 then
					p_win := '0';
					d_win := '1';
				elsif unsigned(dealer_sum) > 21 then
					p_win := '1';
					d_win := '0';
				elsif unsigned(player_sum) > unsigned(dealer_sum) then
					p_win := '1';
					d_win := '0';
				elsif unsigned(player_sum) < unsigned(dealer_sum) then
					p_win := '0';
					d_win := '1';
				elsif unsigned(player_sum) = unsigned(dealer_sum) then
					p_win := '1';
					d_win := '1';
				end if;

				player_wins <= p_win;
				dealer_wins <= d_win;

				if p_win = '1' and d_win = '0' then
					led_display1 <= "1000011";
					led_display2 <= "1100001";
					led_display3 <= "1111001";
					led_display4 <= "1001000";
				elsif p_win = '0' and d_win = '1' then
					led_display1 <= "1000111";
					led_display2 <= "1000000";
					led_display3 <= "0010010";
					led_display4 <= "0000110";
				elsif p_win = '1' and d_win = '1' then
					led_display1 <= "0001100";
					led_display2 <= "1000001";
					led_display3 <= "0010010";
					led_display4 <= "0001001";
				end if;
			end if;
		end process;
end behavior;