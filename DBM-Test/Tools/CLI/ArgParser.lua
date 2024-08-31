local mod = {}

function mod:Parse(...)
	local args = {}
	local currentKey
	for i = 1, select("#", ...) do
		local arg = select(i, ...)
		if arg:match("^%-%-") then
			if currentKey then
				args[currentKey] = true
			end
			currentKey = arg:match("^%-%-(.*)")
		elseif currentKey then
			if currentKey == "start" or currentKey == "end" then -- FIXME: should use some kind of API to define the type of a given parameter
				arg = tonumber(arg)
			end
			args[currentKey] = arg
			currentKey = nil
		else
			args[#args + 1] = arg
		end
	end
	if currentKey then -- flag without args at the end
		args[currentKey] = true
	end
	return args
end

return mod
