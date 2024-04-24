---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L

---@class EnrageTimer
local enragePrototype = private:GetPrototype("EnrageTimer")

---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local mt = {__index = enragePrototype}

function enragePrototype:Start(timer)
	--User only has timer object exposed in mod options, check that here to also prevent the warnings.
	if not self.owner.Options.timer_berserk then return end
	timer = timer or self.timer or 600
	timer = timer <= 0 and self.timer - abs(timer) or timer
	self.bar:SetTimer(timer)
	self.bar:Start()
	if not DBM.Options.ShowBerserkWarnings then return end
	if self.warning1 then
		if timer > 660 then self.warning1:Schedule(timer - 600, 10, L.MIN) end
		if timer > 300 then self.warning1:Schedule(timer - 300, 5, L.MIN) end
		if timer > 180 then self.warning2:Schedule(timer - 180, 3, L.MIN) end
	end
	if self.warning2 then
		if timer > 60 then self.warning2:Schedule(timer - 60, 1, L.MIN) end
		if timer > 30 then self.warning2:Schedule(timer - 30, 30, L.SEC) end
		if timer > 10 then self.warning2:Schedule(timer - 10, 10, L.SEC) end
	end
end

function enragePrototype:Schedule(t)
	return self.owner:Schedule(t, self.Start, self)
end

function enragePrototype:Cancel()
	self.owner:Unschedule(self.Start, self)
	if self.warning1 then
		self.warning1:Cancel()
	end
	if self.warning2 then
		self.warning2:Cancel()
	end
	self.bar:Stop()
end
enragePrototype.Stop = enragePrototype.Cancel

function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
	timer = timer or 600
	local warning1 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 1, nil, nil, false)
	local warning2 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 4, nil, nil, false)
	--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
	local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "berserk")
	---@class EnrageTimer
	local obj = setmetatable(
		{
			warning1 = warning1,
			warning2 = warning2,
			bar = bar,
			timer = timer,
			owner = self
		},
		mt
	)
	return obj
end
