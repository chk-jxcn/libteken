-- Generated file. Do not edit.


-- '' 
function teken_state_init(t, c)
	local switch_table = {
	[''] = function()
			teken_state_switch(t, teken_state_1)
			return false
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		return teken_subr_regular_character(t, c)
		
	end
end

-- '^[' 
function teken_state_1(t, c)
	local switch_table = {
	['c'] = function() -- RIS: Reset to Initial State
			local args = {t}
			teken_callback("teken_subr_reset_to_initial_state", args)
			return true
		end,
	['7'] = function() -- DECSC: Save cursor
			local args = {t}
			teken_callback("teken_subr_save_cursor", args)
			return true
		end,
	['8'] = function() -- DECRC: Restore cursor
			local args = {t}
			teken_callback("teken_subr_restore_cursor", args)
			return true
		end,
	['='] = function() -- DECKPAM: Keypad application mode
			local args = {t}
			teken_callback("teken_subr_keypad_application_mode", args)
			return true
		end,
	['>'] = function() -- DECKPNM: Keypad numeric mode
			local args = {t}
			teken_callback("teken_subr_keypad_numeric_mode", args)
			return true
		end,
	['D'] = function() -- IND: Index
			local args = {t}
			teken_callback("teken_subr_index", args)
			return true
		end,
	['E'] = function() -- NEL: Next line
			local args = {t}
			teken_callback("teken_subr_next_line", args)
			return true
		end,
	['H'] = function() -- HTS: Horizontal Tab Set
			local args = {t}
			teken_callback("teken_subr_horizontal_tab_set", args)
			return true
		end,
	['M'] = function() -- RI: Reverse index
			local args = {t}
			teken_callback("teken_subr_reverse_index", args)
			return true
		end,
	['P'] = function() -- DCS: Device Control String
			local args = {t}
			teken_callback("teken_subr_device_control_string", args)
			return true
		end,
	[']'] = function() -- OSC: Operating System Command
			local args = {t}
			teken_callback("teken_subr_operating_system_command", args)
			return true
		end,
	['\\'] = function() -- ST: String Terminator
			local args = {t}
			teken_callback("teken_subr_string_terminator", args)
			return true
		end,
	['#'] = function()
			teken_state_switch(t, teken_state_4)
			return false
		end,
	['('] = function()
			teken_state_switch(t, teken_state_6)
			return false
		end,
	[')'] = function()
			teken_state_switch(t, teken_state_7)
			return false
		end,
	['['] = function()
			teken_state_switch(t, teken_state_2)
			return false
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_1: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[[=' 
function teken_state_8(t, c)

	if (teken_state_numbers(t, c)) then
		return
	end
	local switch_table = {
	['B'] = function() -- C25BLPD: Cons25 set bell pitch duration
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			if t.t_curnum < 2 or t.t_nums[2] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[2])
			end
			teken_callback("teken_subr_cons25_set_bell_pitch_duration", args)
			return true
		end,
	['F'] = function() -- C25ADFG: Cons25 set adapter foreground
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cons25_set_adapter_foreground", args)
			return true
		end,
	['G'] = function() -- C25ADBG: Cons25 set adapter background
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cons25_set_adapter_background", args)
			return true
		end,
	['S'] = function() -- C25CURS: Cons25 set cursor type
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cons25_set_cursor_type", args)
			return true
		end,
	['T'] = function() -- C25MODE: Cons25 set terminal mode
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cons25_set_terminal_mode", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_8: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[[>' 
function teken_state_3(t, c)

	if (teken_state_numbers(t, c)) then
		return
	end
	local switch_table = {
	['c'] = function() -- DA2: Secondary Device Attributes
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_secondary_device_attributes", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_3: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[[?' 
function teken_state_5(t, c)

	if (teken_state_numbers(t, c)) then
		return
	end
	local switch_table = {
	['h'] = function() -- DECSM: Set DEC mode
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_set_dec_mode", args)
			return true
		end,
	['l'] = function() -- DECRM: Reset DEC mode
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_reset_dec_mode", args)
			return true
		end,
	['n'] = function() -- DSR: Device Status Report
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_device_status_report", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_5: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[#' 
function teken_state_4(t, c)
	local switch_table = {
	['3'] = function() -- DECDHL: Double Height Double Width Line Top
			local args = {t}
			teken_callback("teken_subr_double_height_double_width_line_top", args)
			return true
		end,
	['4'] = function() -- DECDHL: Double Height Double Width Line Bottom
			local args = {t}
			teken_callback("teken_subr_double_height_double_width_line_bottom", args)
			return true
		end,
	['5'] = function() -- DECSWL: Single Height Single Width Line
			local args = {t}
			teken_callback("teken_subr_single_height_single_width_line", args)
			return true
		end,
	['6'] = function() -- DECDWL: Single Height Double Width Line
			local args = {t}
			teken_callback("teken_subr_single_height_double_width_line", args)
			return true
		end,
	['8'] = function() -- DECALN: Alignment test
			local args = {t}
			teken_callback("teken_subr_alignment_test", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_4: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[(' 
function teken_state_6(t, c)
	local switch_table = {
	['A'] = function() -- G0SCSA: G0 SCS UK National
			local args = {t}
			teken_callback("teken_subr_g0_scs_uk_national", args)
			return true
		end,
	['B'] = function() -- G0SCSB: G0 SCS US ASCII
			local args = {t}
			teken_callback("teken_subr_g0_scs_us_ascii", args)
			return true
		end,
	['0'] = function() -- G0SCS0: G0 SCS Special Graphics
			local args = {t}
			teken_callback("teken_subr_g0_scs_special_graphics", args)
			return true
		end,
	['1'] = function() -- G0SCS1: G0 SCS US ASCII
			local args = {t}
			teken_callback("teken_subr_g0_scs_us_ascii", args)
			return true
		end,
	['2'] = function() -- G0SCS2: G0 SCS Special Graphics
			local args = {t}
			teken_callback("teken_subr_g0_scs_special_graphics", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_6: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[)' 
function teken_state_7(t, c)
	local switch_table = {
	['0'] = function() -- G1SCS0: G1 SCS Special Graphics
			local args = {t}
			teken_callback("teken_subr_g1_scs_special_graphics", args)
			return true
		end,
	['1'] = function() -- G1SCS1: G1 SCS US ASCII
			local args = {t}
			teken_callback("teken_subr_g1_scs_us_ascii", args)
			return true
		end,
	['2'] = function() -- G1SCS2: G1 SCS Special Graphics
			local args = {t}
			teken_callback("teken_subr_g1_scs_special_graphics", args)
			return true
		end,
	['A'] = function() -- G1SCSA: G1 SCS UK National
			local args = {t}
			teken_callback("teken_subr_g1_scs_uk_national", args)
			return true
		end,
	['B'] = function() -- G1SCSB: G1 SCS US ASCII
			local args = {t}
			teken_callback("teken_subr_g1_scs_us_ascii", args)
			return true
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_7: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end

-- '^[[' 
function teken_state_2(t, c)

	if (teken_state_numbers(t, c)) then
		return
	end
	local switch_table = {
	['J'] = function() -- ED: Erase display
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_erase_display", args)
			return true
		end,
	['K'] = function() -- EL: Erase line
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_erase_line", args)
			return true
		end,
	['L'] = function() -- IL: Insert line
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_insert_line", args)
			return true
		end,
	['M'] = function() -- DL: Delete line
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_delete_line", args)
			return true
		end,
	['P'] = function() -- DC: Delete character
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_delete_character", args)
			return true
		end,
	['S'] = function() -- SU: Pan Down
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_pan_down", args)
			return true
		end,
	['T'] = function() -- SD: Pan Up
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_pan_up", args)
			return true
		end,
	['X'] = function() -- ECH: Erase character
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_erase_character", args)
			return true
		end,
	['Z'] = function() -- CBT: Cursor Backward Tabulation
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_backward_tabulation", args)
			return true
		end,
	['`'] = function() -- HPA: Horizontal Position Absolute
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_horizontal_position_absolute", args)
			return true
		end,
	['a'] = function() -- CUF: Cursor Forward
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_forward", args)
			return true
		end,
	['c'] = function() -- DA1: Primary Device Attributes
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_primary_device_attributes", args)
			return true
		end,
	['d'] = function() -- VPA: Vertical Position Absolute
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_vertical_position_absolute", args)
			return true
		end,
	['e'] = function() -- CUD: Cursor Down
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_down", args)
			return true
		end,
	['f'] = function() -- CUP: Cursor Position
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			if t.t_curnum < 2 or t.t_nums[2] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[2])
			end
			teken_callback("teken_subr_cursor_position", args)
			return true
		end,
	['g'] = function() -- TBC: Tab Clear
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_tab_clear", args)
			return true
		end,
	['h'] = function() -- SM: Set Mode
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_set_mode", args)
			return true
		end,
	['l'] = function() -- RM: Reset Mode
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_reset_mode", args)
			return true
		end,
	['m'] = function() -- SGR: Set Graphic Rendition
			teken_callback("teken_subr_set_graphic_rendition", {t, t.t_curnum, t.t_nums})
			return true
		end,
	['n'] = function() -- CPR: Cursor Position Report
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_position_report", args)
			return true
		end,
	['@'] = function() -- ICH: Insert character
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_insert_character", args)
			return true
		end,
	['r'] = function() -- DECSTBM: Set top and bottom margins
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			if t.t_curnum < 2 or t.t_nums[2] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[2])
			end
			teken_callback("teken_subr_set_top_and_bottom_margins", args)
			return true
		end,
	['s'] = function() -- DECSC: Save cursor
			local args = {t}
			teken_callback("teken_subr_save_cursor", args)
			return true
		end,
	['A'] = function() -- CUU: Cursor Up
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_up", args)
			return true
		end,
	['B'] = function() -- CUD: Cursor Down
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_down", args)
			return true
		end,
	['u'] = function() -- DECRC: Restore cursor
			local args = {t}
			teken_callback("teken_subr_restore_cursor", args)
			return true
		end,
	['C'] = function() -- CUF: Cursor Forward
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_forward", args)
			return true
		end,
	['D'] = function() -- CUB: Cursor Backward
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_backward", args)
			return true
		end,
	['E'] = function() -- CNL: Cursor Next Line
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_next_line", args)
			return true
		end,
	['x'] = function() -- C25SGR: Cons25 set graphic rendition
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			if t.t_curnum < 2 or t.t_nums[2] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[2])
			end
			teken_callback("teken_subr_cons25_set_graphic_rendition", args)
			return true
		end,
	['F'] = function() -- CPL: Cursor Previous Line
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_previous_line", args)
			return true
		end,
	['G'] = function() -- HPA: Horizontal Position Absolute
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_horizontal_position_absolute", args)
			return true
		end,
	['z'] = function() -- C25VTSW: Cons25 switch virtual terminal
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 0)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cons25_switch_virtual_terminal", args)
			return true
		end,
	['H'] = function() -- CUP: Cursor Position
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			if t.t_curnum < 2 or t.t_nums[2] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[2])
			end
			teken_callback("teken_subr_cursor_position", args)
			return true
		end,
	['I'] = function() -- CHT: Cursor Forward Tabulation
			local args = {t}
			if t.t_curnum < 1 or t.t_nums[1] == 0 then
				table.insert(args, 1)
			else
				table.insert(args, t.t_nums[1])
			end
			teken_callback("teken_subr_cursor_forward_tabulation", args)
			return true
		end,
	['='] = function()
			teken_state_switch(t, teken_state_8)
			return false
		end,
	['>'] = function()
			teken_state_switch(t, teken_state_3)
			return false
		end,
	['?'] = function()
			teken_state_switch(t, teken_state_5)
			return false
		end,
	}
	local f = switch_table[c]
	if f then
		if not f() then return end
	else
		teken_printf(string.format("Unsupported sequence in teken_state_2: %q\n", c))
		
	end

	teken_state_switch(t, teken_state_init);
end
