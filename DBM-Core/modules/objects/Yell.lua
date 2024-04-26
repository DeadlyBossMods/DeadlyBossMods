---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

local DBMScheduler = private:GetModule("DBMScheduler")
local stringUtils = private:GetPrototype("StringUtils")

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class Announce
local announcePrototype = private:GetPrototype("Announce")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

---@class Yell
local yellPrototype = private:GetPrototype("Yell")
local mt = {__index = yellPrototype}
local voidForm = DBM:GetSpellName(194249)

local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
	if not spellId and not yellText then
		error("NewYell: you must provide either spellId or yellText", 2)
	end
	local optionVersion
	if type(optionName) == "number" then
		optionVersion = optionName
		optionName = nil
	end
	local displayText
	if not yellText then
		if type(spellId) == "string" and spellId:match("ej%d+") then--Old Format Journal
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(string.sub(spellId, 3)) or CL.UNKNOWN)
		elseif type(spellId) == "number" then
			if spellId < 0 then--New format Journal
				spellId = -spellId
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(spellId) or CL.UNKNOWN)
			else
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellName(spellId) or CL.UNKNOWN)
			end
		else
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(CL.UNKNOWN)
		end
	end
	--Passed spellid as yellText.
	--Auto localize spelltext using yellText instead
	if yellText and type(yellText) == "number" then
		displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellName(yellText) or CL.UNKNOWN)
	end
	---@class Yell
	local obj = setmetatable(
		{
			spellId = spellId,
			text = displayText or yellText,
			mod = self,
			chatType = chatType,
			yellType = yellType
		},
		mt
	)
	if optionName then
		obj.option = optionName
		self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
	elseif optionName ~= false then
		obj.option = "Yell" .. (spellId or yellText) .. (yellType ~= "yell" and yellType or "") .. (optionVersion or "")
		self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
		self.localization.options[obj.option] = L.AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
	end
	return obj
end

--Standard "Yell" object that will use SAY/YELL based on what's defined in the object (Defaulting to SAY if nil)
--I realize object being :Yell is counter intuitive to default being "SAY" but for many years the default was YELL and it's too many years of mods to change now
function yellPrototype:Yell(...)
	if not IsInInstance() then--as of 8.2.5+, forbidden in outdoor world
		DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
		return
	end
	if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and (not private.isRetail or DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay) then return end
	if not self.option or self.mod.Options[self.option] then
		if self.yellType == "combo" then
			SendChatMessage(stringUtils.pformat(self.text, ...), self.chatType or "YELL")
		else
			SendChatMessage(stringUtils.pformat(self.text, ...), self.chatType or "SAY")
		end
	end
end
yellPrototype.Show = yellPrototype.Yell

--Force override to use say message, even when object defines "YELL"
function yellPrototype:Say(...)
	if not IsInInstance() then--as of 8.2.5+, forbidden in outdoor world
		DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
		return
	end
	if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and (not private.isRetail or DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay) then return end
	if not self.option or self.mod.Options[self.option] then
		SendChatMessage(stringUtils.pformat(self.text, ...), "SAY")
	end
end

function yellPrototype:Schedule(t, ...)
	return DBMScheduler:Schedule(t, self.Yell, self.mod, self, ...)
end

--Standard schedule object to schedule a say/yell based on what's defined in object
function yellPrototype:Countdown(time, numAnnounces, ...)
	if time > 60 then--It's a spellID not a time
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
		if expireTime then
			local remaining = expireTime - GetTime()
			DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
		end
	else
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
	end
end

--Scheduled Force override to use SAY message, even when object defines "YELL"
function yellPrototype:CountdownSay(time, numAnnounces, ...)
	if time > 60 then--It's a spellID not a time
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
		if expireTime then
			local remaining = expireTime - GetTime()
			DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Say, self.mod, self, ...)
		end
	else
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Say, self.mod, self, ...)
	end
end

function yellPrototype:Cancel(...)
	return DBMScheduler:Unschedule(self.Yell, self.mod, self, ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewYell(...)
	return newYell(self, "yell", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewShortYell(...)
	return newYell(self, "shortyell", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewCountYell(...)
	return newYell(self, "count", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewFadesYell(...)
	return newYell(self, "fade", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewShortFadesYell(...)
	return newYell(self, "shortfade", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewIconFadesYell(...)
	return newYell(self, "iconfade", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewPosYell(...)
	return newYell(self, "position", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewShortPosYell(...)
	return newYell(self, "shortposition", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewComboYell(...)
	return newYell(self, "combo", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewPlayerRepeatYell(...)
	return newYell(self, "repeatplayer", ...)
end

---@overload fun(self: DBMMod, spellId, yellText, optionDefault: SpecFlags|boolean?, optionName, chatType): Yell
function bossModPrototype:NewIconRepeatYell(...)
	return newYell(self, "repeaticon", ...)
end
