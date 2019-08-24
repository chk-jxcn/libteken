require "teken_state"

local bnot = bit.bnot
local band, bor, bxor = bit.band, bit.bor, bit.bxor
local lshift, rshift, rol = bit.lshift, bit.rshift, bit.rol

local function pt(t)
	local s = "{"
	if type(t) ~= 'table' then
		return tostring(t)
	end
	for k, v in pairs(t) do
		if type(v) == 'table' then
			s = s .. pt(v) .. ","
		else
			s = s .. tostring(v) .. ","
		end
	end
	s = string.gsub(s, ",$", "")
	return s .. "}"
end

function teken_init()
	return {
		t_nextstate = teken_state_init,
		t_stateflags = {TS_INSTRING = false};
		t_utf8_left = 0;
		t_utf8_partial = '';
		t_nums = {},
		t_curnum = 1,
	}
end

function teken_input(t, s)
	local len = string.len(s)
	local regular_chars = {}
	for i=1,len do
		local c = string.sub(s, i, i)
		local reg_c = teken_input_byte(t, c)
		if type(reg_c) == 'string' then
			table.insert(regular_chars, teken_input_byte(t, c))
		end
	end
	return table.concat(regular_chars, '')
end

function teken_input_byte(t, c)
	local byte = string.byte(c)
	if band(byte, 0x80) == 0x00 then
		t.t_utf8_left = 0
		return teken_input_char(t, c)
	elseif band(byte, 0xe0) == 0xc0 then
		t.t_utf8_left = 1
		t.t_utf8_partial = t.t_utf8_partial .. c
	elseif band(byte, 0xf0) == 0xe0 then
		t.t_utf8_left = 2
		t.t_utf8_partial = t.t_utf8_partial .. c
	elseif band(byte, 0xf8) == 0xf0 then
		t.t_utf8_left = 3
		t.t_utf8_partial = t.t_utf8_partial .. c
	elseif band(byte, 0xc0) == 0x80 then
		if t.t_utf8_left == 0 then return end
		t.t_utf8_left = t.t_utf8_left - 1
		if t.t_utf8_left == 0 then
			return t.t_utf8_partial
		end
	end
end

function teken_input_char(t, c)
	if t.t_stateflags.TS_INSTRING then
		if c == '\027' then
			t.t_stateflags.TS_INSTRING = false
		elseif c == '\007' then
			t.t_stateflags.TS_INSTRING = false
			return
		else
			return
		end
	end

	if c == "\000" or string.match(c, "[\007\008\011\012\013\014\015]") then
		return 
	end
	return t.t_nextstate(t, c)
end

function teken_state_switch(t, s)
	t.t_nextstate = s
	t.t_curnum = 0
	t.t_stateflags.TS_FIRSTDIGIT = true
end


function teken_state_numbers(t, c)
	if c >= '0' and c<= '9' then
		if t.t_stateflags.TS_FIRSTDIGIT then
			t.t_stateflags.TS_FIRSTDIGIT = false
			t.t_nums[t.t_curnum] = tonumber(c)
		elseif t.t_nums[t.t_curnum] < 40000000 then
			t.t_nums[t.t_curnum] = t.t_nums[t.t_curnum] * 10 + tonumber(c) 
		end
		return true
	elseif c == ';' then
		if t.t_stateflags.TS_FIRSTDIGIT then
			t.t_nums[t.t_curnum] = 0
		end
		t.t_curnum = t.t_curnum + 1
		if t.t_curnum == T_NUMSIZE then
			teken_state_switch(t, teken_state_init)
			return true
		end
		t.t_stateflags.TS_FIRSTDIGIT = true
		return true
	else
		if t.t_stateflags.TS_FIRSTDIGIT and t.t_curnum > 0 then
			t.t_nums[t.t_curnum] = 0
			t.t_curnum = t.t_curnum + 1
		elseif not t.t_stateflags.TS_FIRSTDIGIT then
			t.t_curnum = t.t_curnum + 1
		end
	end
	return false
end

function teken_subr_regular_character(t, c)
	return c
end

function teken_printf(s)
	print(s)
end

teken_subr = {
	["teken_subr_operating_system_command"] = 
		function (t)
			t.t_stateflags.TS_INSTRING = true
		end,
	["teken_subr_device_control_string"] =
		function (t)
			t.t_stateflags.TS_INSTRING = true
		end,
	}
							

function teken_callback(func, args)
	--[[
	io.stdout:write(func .. "(t, ")
	io.stdout:write(pt(args[2]) .. ", ")
	io.stdout:write(pt(args[3]))
	print ")"
	--]]
	local f = teken_subr[func]
	if f then
		f(unpack(args))
	end
end

