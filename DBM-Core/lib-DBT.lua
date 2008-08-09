------------------------
-- Deadly Bar Timers ---
------------------------
local version = 0.1

if DBT and DBT.Version >= version then
	return
end

DBT = {}
DBT.Version = version

local dbt = {}

function dbt:TestOnChange()
end

local options = {
	TestOptionString = {
		type = "string",
		default = "foo"
	},
	
	TestOptionNumber = {
		type = "number",
		default = 5,
		onChange = dbt.TestOnChange
	},

	TestOptionCheckFunc = {
		checkFunc = function(obj, option, value)
			ChatFrame1:AddMessage(("%s %s %s"):format(tostring(obj), tostring(option), tostring(value)))
			if value == "testReject" then
				return false, "test error message"
			else
				return true
			end
		end,
		default = "foo"
	}	
}

function dbt:SetOption(option, value)
	if not options[option] then
		error(("Invalid option: %s"):format(tostring(option)), 1)
	elseif options[option].type and type(value) ~= options[option].type then
		error(("The option %s requires a %s value. (tried to assign a %s value)"):format(tostring(option), tostring(options[option].type), tostring(type(value))), 1)
	elseif options[option].checkFunc then
		local ok, errMsg = options[option].checkFunc(self, option, value)
		if not ok then
			error(("Error while setting option %s to %s: %s"):format(tostring(option), tostring(value), tostring(errMsg)), 1)
		end
	end
	self.Options[option] = value
	if options[option].onChange then
		options[option].onChange(self)
	end
end

function DBT:New()
	return setmetatable(
		{
			Options = setmetatable({}, {
				__index = function(k)
					if options[k] then
						return options[k].default
					else
						return nil
					end
				end
			}),
		},
		{
			__index = dbt
		}
	)
end
