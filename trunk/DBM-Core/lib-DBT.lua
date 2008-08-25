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

function dbt:TestOnChange(new, old)
	DBM:AddMsg(("Testchange: %d --> %d"):format(old, new))
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
	local oldValue = self.options[option]
	self.options[option] = value
	if options[option].onChange then
		options[option].onChange(self, value, oldValue)
	end
end

do
	local mt = {__index = dbt}
	local optionMT = {
		__index = function(t, k)
			if options[k] then
				return options[k].default
			else
				return nil
			end
		end
	}
	function DBT:New()
		local obj = setmetatable(
			{
				options = setmetatable({}, optionMT),
				mainAnchor = CreateFrame("Frame"),
				secAnchor = CreateFrame("Frame"),
				mainFirstBar = nil,
				mainLastBar = nil,
				secFirstBar = nil,
				secLastBar = nil,
			},
			mt
		)
		obj.mainAnchor:SetHeight(1)
		obj.mainAnchor:SetWidth(1)
		obj.mainAnchor:SetPoint("CENTER", 0, 0)
		obj.mainAnchor:SetClampedToScreen(true)
		obj.mainAnchor:SetMovable(true)
		obj.mainAnchor:Show()
		return obj
	end
end

local fCounter = 1
local barPrototype = {}
local unusedBars = {}

do
	local function createBarFrame()
		local frame
		if unusedBars[#unusedBars] then
			frame = unusedBars[#unusedBars]
			unusedBars[#unusedBars] = nil
		else
			frame = CreateFrame("Frame", "DBT_Bar_"..fCounter, nil, "DBTBarTemplate")
			fCounter = fCounter + 1
		end
		return frame
	end	
	local mt = {__index = barPrototype}
	
	function dbt:CreateBar(timer, id)
		local newBar = setmetatable(
			{
				prev = self.mainLastBar,
				next = nil,
				data = {
					frame = createBarFrame(),
					id = id,
					timer = timer,
					totalTime = timer,
					owner = self
				}
			}, 
			mt
		)
		if self.mainLastBar then
			self.mainLastBar.next = newBar
		end
		self.mainLastBar = newBar
		self.mainFirstBar = self.mainFirstBar or newBar	
		
		newBar.data.frame.obj = newBar
		self:ApplyStyle(newBar)
		newBar:Update(0)
		return newBar
	end
end

function dbt:ApplyStyle(bar)
	local frame = bar.data.frame
	frame:SetParent(self.mainAnchor)
	frame:ClearAllPoints()
	frame:SetPoint("TOP", 0, 0)
	frame:Show()
end

function barPrototype:Update(elapsed)
	local bar = getglobal(self.data.frame:GetName().."Bar")
	self.data.timer = self.data.timer - elapsed
	if self.data.timer <= 0 then
		self:Cancel()
	else
		bar:SetValue(self.data.timer/self.data.totalTime)
--		spark:ClearAllPoints()
--		spark:SetPoint("CENTER", bar, "LEFT", ((bar:GetValue() / 60) * bar:GetWidth()), 0)
--		spark:Show()
	end
end

function barPrototype:Cancel()
	DBM:AddMsg("Cancel")
end
