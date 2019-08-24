require "teken"
require "teken_state"

local t = teken_init()
local f  = io.open(arg[1], "rb")

local out = io.open("out.txt", "w+")
repeat
	local s  = f:read(5)
	if not s then break end
	out:write(teken_input(t,s))
until nil

f:close()
out:close()



