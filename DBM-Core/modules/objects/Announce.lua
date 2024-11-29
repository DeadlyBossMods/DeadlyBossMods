---@class DBMCoreNamespace
local private = select(2, ...)

local L = DBM_CORE_L
local CL = DBM_COMMON_L

local DBMScheduler = private:GetModule("DBMScheduler")
local stringUtils = private:GetPrototype("StringUtils")
local checkEntry = private:GetPrototype("TableUtils").checkEntry

---@class DBM
local DBM = private:GetPrototype("DBM")
---@class Announce
local announcePrototype = private:GetPrototype("Announce")
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")

local test = private:GetPrototype("DBMTest")

local mt = {__index = announcePrototype}

---@diagnostic disable: inject-field
local frame = CreateFrame("Frame", "DBMWarning", UIParent)
local font1u = CreateFrame("Frame", "DBMWarning1Updater", UIParent)
local font2u = CreateFrame("Frame", "DBMWarning2Updater", UIParent)
local font3u = CreateFrame("Frame", "DBMWarning3Updater", UIParent)
local font1 = frame:CreateFontString("DBMWarning1", "OVERLAY", "GameFontNormal")
font1:SetWidth(1024)
font1:SetHeight(0)
font1:SetPoint("TOP", 0, 0)
local font2 = frame:CreateFontString("DBMWarning2", "OVERLAY", "GameFontNormal")
font2:SetWidth(1024)
font2:SetHeight(0)
font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
local font3 = frame:CreateFontString("DBMWarning3", "OVERLAY", "GameFontNormal")
font3:SetWidth(1024)
font3:SetHeight(0)
font3:SetPoint("TOP", font2, "BOTTOM", 0, 0)
frame:SetMovable(true)
frame:SetWidth(1)
frame:SetHeight(1)
frame:SetFrameStrata("HIGH")
frame:SetClampedToScreen(true)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 300)
font1u:Hide()
font2u:Hide()
font3u:Hide()

local font1elapsed, font2elapsed, font3elapsed

local function fontHide1()
	local duration = DBM.Options.WarningDuration2
	if font1elapsed > duration * 1.3 then
		font1u:Hide()
		font1:Hide()
		if frame.font1ticker then
			frame.font1ticker:Cancel()
			frame.font1ticker = nil
		end
	elseif font1elapsed > duration then
		font1elapsed = font1elapsed + 0.05
		local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
		font1:SetAlpha(alpha > 0 and alpha or 0)
	else
		font1elapsed = font1elapsed + 0.05
		font1:SetAlpha(1)
	end
end

local function fontHide2()
	local duration = DBM.Options.WarningDuration2
	if font2elapsed > duration * 1.3 then
		font2u:Hide()
		font2:Hide()
		if frame.font2ticker then
			frame.font2ticker:Cancel()
			frame.font2ticker = nil
		end
	elseif font2elapsed > duration then
		font2elapsed = font2elapsed + 0.05
		local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
		font2:SetAlpha(alpha > 0 and alpha or 0)
	else
		font2elapsed = font2elapsed + 0.05
		font2:SetAlpha(1)
	end
end

local function fontHide3()
	local duration = DBM.Options.WarningDuration2
	if font3elapsed > duration * 1.3 then
		font3u:Hide()
		font3:Hide()
		if frame.font3ticker then
			frame.font3ticker:Cancel()
			frame.font3ticker = nil
		end
	elseif font3elapsed > duration then
		font3elapsed = font3elapsed + 0.05
		local alpha = 1 - (font3elapsed - duration) / (duration * 0.3)
		font3:SetAlpha(alpha > 0 and alpha or 0)
	else
		font3elapsed = font3elapsed + 0.05
		font3:SetAlpha(1)
	end
end

font1u:SetScript("OnUpdate", function(self)
	local diff = GetTime() - font1.lastUpdate
	local origSize = DBM.Options.WarningFontSize
	if diff > 0.4 then
		font1:SetTextHeight(origSize)
		self:Hide()
	elseif diff > 0.2 then
		font1:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
	else
		font1:SetTextHeight(origSize * (1 + diff * 2.5))
	end
end)

font2u:SetScript("OnUpdate", function(self)
	local diff = GetTime() - font2.lastUpdate
	local origSize = DBM.Options.WarningFontSize
	if diff > 0.4 then
		font2:SetTextHeight(origSize)
		self:Hide()
	elseif diff > 0.2 then
		font2:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
	else
		font2:SetTextHeight(origSize * (1 + diff * 2.5))
	end
end)

font3u:SetScript("OnUpdate", function(self)
	local diff = GetTime() - font3.lastUpdate
	local origSize = DBM.Options.WarningFontSize
	if diff > 0.4 then
		font3:SetTextHeight(origSize)
		self:Hide()
	elseif diff > 0.2 then
		font3:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
	else
		font3:SetTextHeight(origSize * (1 + diff * 2.5))
	end
end)

function DBM:UpdateWarningOptions()
	frame:ClearAllPoints()
	frame:SetPoint(self.Options.WarningPoint, UIParent, self.Options.WarningPoint, self.Options.WarningX, self.Options.WarningY)
	local font = self.Options.WarningFont == "standardFont" and private.standardFont or self.Options.WarningFont
	font1:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
	font2:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
	font3:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
	if self.Options.WarningFontShadow then
		font1:SetShadowOffset(1, -1)
		font2:SetShadowOffset(1, -1)
		font3:SetShadowOffset(1, -1)
	else
		font1:SetShadowOffset(0, 0)
		font2:SetShadowOffset(0, 0)
		font3:SetShadowOffset(0, 0)
	end
end

function DBM:AddWarning(text, force, announceObject)
	local added = false
	if not frame.font1ticker then
		font1elapsed = 0
		font1.lastUpdate = GetTime()
		font1:SetText(text)
		font1:Show()
		font1u:Show()
		added = true
		frame.font1ticker = frame.font1ticker or C_Timer.NewTicker(0.05, fontHide1)
	elseif not frame.font2ticker then
		font2elapsed = 0
		font2.lastUpdate = GetTime()
		font2:SetText(text)
		font2:Show()
		font2u:Show()
		added = true
		frame.font2ticker = frame.font2ticker or C_Timer.NewTicker(0.05, fontHide2)
	elseif not frame.font3ticker or force then
		font3elapsed = 0
		font3.lastUpdate = GetTime()
		font3:SetText(text)
		font3:Show()
		font3u:Show()
		fontHide3()
		added = true
		frame.font3ticker = frame.font3ticker or C_Timer.NewTicker(0.05, fontHide3)
	end
	if not added then
		local prevText1 = font2:GetText()
		local prevText2 = font3:GetText()
		font1:SetText(prevText1)
		font1elapsed = font2elapsed
		font2:SetText(prevText2)
		font2elapsed = font3elapsed
		self:AddWarning(text, true, announceObject)
	else
		test:Trace(announceObject and announceObject.mod or self, "ShowAnnounce", announceObject, text)
	end
end

do
	local anchorFrame
	local function moveEnd(self)
		anchorFrame:Hide()
		if anchorFrame.ticker then
			anchorFrame.ticker:Cancel()
			anchorFrame.ticker = nil
		end
		font1elapsed = self.Options.WarningDuration2
		font2elapsed = self.Options.WarningDuration2
		font3elapsed = self.Options.WarningDuration2
		frame:SetFrameStrata("HIGH")
		self:Unschedule(moveEnd)
		DBT:CancelBar(L.MOVE_WARNING_BAR)
	end

	function DBM:MoveWarning()
		if not anchorFrame then
			anchorFrame = CreateFrame("Frame", nil, frame)
			anchorFrame:SetWidth(32)
			anchorFrame:SetHeight(32)
			anchorFrame:EnableMouse(true)
			anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
			anchorFrame:RegisterForDrag("LeftButton")
			anchorFrame:SetClampedToScreen(true)
			anchorFrame:Hide()
			local texture = anchorFrame:CreateTexture()
			texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
			texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
			texture:SetWidth(32)
			texture:SetHeight(32)
			anchorFrame:SetScript("OnDragStart", function()
				frame:StartMoving()
				self:Unschedule(moveEnd)
				DBT:CancelBar(L.MOVE_WARNING_BAR)
			end)
			anchorFrame:SetScript("OnDragStop", function()
				frame:StopMovingOrSizing()
				local point, _, _, xOfs, yOfs = frame:GetPoint(1)
				self.Options.WarningPoint = point
				self.Options.WarningX = xOfs
				self.Options.WarningY = yOfs
				self:Schedule(15, moveEnd, self)
				DBT:CreateBar(15, L.MOVE_WARNING_BAR, private.isRetail and 237538 or 136106)
			end)
		end
		if anchorFrame:IsShown() then
			moveEnd(self)
		else
			anchorFrame:Show()
			anchorFrame.ticker = anchorFrame.ticker or C_Timer.NewTicker(5, function() self:AddWarning(L.MOVE_WARNING_MESSAGE) end)
			self:AddWarning(L.MOVE_WARNING_MESSAGE)
			self:Schedule(15, moveEnd, self)
			DBT:CreateBar(15, L.MOVE_WARNING_BAR, private.isRetail and 237538 or 136106)
			frame:Show()
			frame:SetFrameStrata("TOOLTIP")
			frame:SetAlpha(1)
		end
	end
end

local textureCode = " |T%s:12:12|t "
local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?


-- TODO: is there a good reason that this is a weak table?
local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

local function setText(announceType, spellId, castTime, preWarnTime, customName, alternateSpellId)
	local spellName
	if customName then
		spellName = customName
	else
		spellName = DBM:ParseSpellName(alternateSpellId or spellId, announceType) or CL.UNKNOWN
	end
	local text
	if announceType == "cast" then
		local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
		local timer = (select(4, DBM:GetSpellInfo(spellId)) or 1000) / spellHaste
		text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
	elseif announceType == "prewarn" then
		if type(preWarnTime) == "string" then
			error("preWarnTime is string. Notify DBM Authors")
		else
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(preWarnTime or 5)))
		end
	elseif announceType == "stage" or announceType == "prestage" then
		text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
	elseif announceType == "stagechange" then
		text = L.AUTO_ANNOUNCE_TEXTS.spell
	else
		text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
	end
	--Automatically register alternate spellnames when detecting their use here
	if spellId and (customName or alternateSpellId) then
		DBM:RegisterAltSpellName(spellId, customName or spellName)
	end
	return text, spellName
end

function announcePrototype:SetText(customName)
	local text, spellName = setText(self.announceType, self.spellId, self.castTime, self.preWarnTime, customName)
	self.text = text
	self.spellName = spellName
end

---Not to be confused with SetText, which only sets the text of object.
---<br>This changes actual ID so announce callback also swaps ID for WAs
---@param altSpellId string|number
function announcePrototype:UpdateKey(altSpellId)
	self.spellId = altSpellId
	self.icon = DBM:ParseSpellIcon(altSpellId, self.announceType, self.icon)
	if self.announceType then
		--Regenerate auto localized text if it's an auto localized alert
		local text, spellName = setText(self.announceType, self.spellId, self.castTime, self.preWarnTime)
		self.text = text
		self.spellName = spellName
	else--Just regenerating spellName not message text because it's likely a custom text object such as NewSpecialWarning
		self.spellName = DBM:ParseSpellName(altSpellId)
	end
end

---Function used for changing warning color on fly when used for multiple warning priorities
---@param color number 1 = Positive Message, 2 = Normal Message, 3 - Higher Priority, 4 - Highest Priority
function announcePrototype:UpdateColor(color)
	self.color = DBM.Options.WarningColors[color or 1]
end

---@class Announce0: Announce
---@field Show fun(self: Announce0)
---@class Announce1: Announce
---@field Show fun(self: Announce1, arg1: string|number)
---@class Announce1Num: Announce
---@field Show fun(self: Announce1Num, arg1: number)
---@class Announce2: Announce
---@field Show fun(self: Announce2, arg1: string|number, arg2: string|number)
---@class Announce2StrNum: Announce
---@field Show fun(self: Announce2StrNum, arg1: string|number, arg2: number)
---@class Announce2NumStr: Announce
---@field Show fun(self: Announce2NumStr, arg1: number, arg2: string|number)


-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
	if not self.option or self.mod.Options[self.option] then
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
		if #self.combinedtext > 0 then
			--Throttle spam.
			if DBM.Options.WarningAlphabetical then
				table.sort(self.combinedtext)
			end
			local combinedText = table.concat(self.combinedtext, "<, >")
			if self.combinedcount == 1 then
				combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS
			elseif self.combinedcount > 1 then
				combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
			end
			--Process
			for i = 1, #argTable do
				if type(argTable[i]) == "string" then
					argTable[i] = combinedText
				end
			end
		end
		local announceCount
		if self.announceType and (self.announceType == "count" or self.announceType == "targetcount" or self.announceType == "sooncount" or self.announceType == "incomingcount") then--Don't use find "count" here, it'll match countdown
			--Stage triggers don't pass count, but they do not need to, there is a stage callback and trigger option in WA that should be used
			if type(argTable[1]) == "number" then
				announceCount = argTable[1]
			end
		end
		local message = stringUtils.pformat(self.text, unpack(argTable))
		local text = ("%s%s%s|r%s"):format(
			(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
			colorCode,
			message,
			(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
		)
		self.combinedcount = 0
		self.combinedtext = {}
		if not cachedColorFunctions[self.color] then
			local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
			cachedColorFunctions[color] = function(cap)
				cap = cap:sub(2, -2)
				local noStrip = cap:match("noStrip ")
				if not noStrip then
					local name = cap
					local playerClass, playerIcon = DBM:GetRaidClass(name)
					if playerClass ~= "UNKNOWN" then
						cap = DBM:GetShortServerName(cap)--Only run realm strip function if class color was valid (IE it's an actual playername)
					end
					local playerColor = RAID_CLASS_COLORS[playerClass] or color
					if playerColor then
						if playerIcon > 0 and playerIcon <= 8 then
							cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
						else
							cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
						end
					end
				else
					cap = cap:sub(9)
				end
				return cap
			end
		end
		text = text:gsub(">.-<", cachedColorFunctions[self.color])
		DBM:AddWarning(text, nil, self)
		if DBM.Options.ShowWarningsInChat then
			if not DBM.Options.WarningIconChat then
				text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
			end
			self.mod:AddMsg(text, nil)
		end
		--Message: Full message text
		--Icon: Texture path/id for icon
		--Type: Announce type
		----Types: you, target, targetcount, targetsource, spell, ends, endtarget, fades, adds, count, stack, cast, soon, sooncount, prewarn, bait, stage, stagechange, prestage, moveto
		------Personal/Role (Applies to you, or your job): you, stack, bait, moveto, fades
		------General Target Messages (informative, doesn't usually apply to you): target, targetsource, targetcount
		------Fight Changes (Stages, adds, boss buff/debuff, etc): stage, stagechange, prestage, adds, ends, endtarget
		------General (can really apply to anything): spell, count, soon, sooncount, prewarn
		--SpellId: Raw spell or encounter journal Id if available.
		--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
		--boolean: Whether or not this warning is a special warning (higher priority). BW would call this "emphasized"
		--announceCount: If it's a count announce, this will provide access to the number value of that count. This, along with spellId should be used instead of message text scanning for most weak auras that need to target specific count casts
		DBM:FireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false, announceCount)
		if self.sound > 0 then--0 means muted, 1 means no voice pack support, 2 means voice pack version/support
			if self.sound > 1 and DBM.Options.ChosenVoicePack2 ~= "None" and DBM.Options.VPReplacesAnnounce and not private.voiceSessionDisabled and self.sound <= private.swFilterDisabled then return end
			if not self.option or self.mod.Options[self.option .. "SWSound"] ~= "None" then
				DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)--Validate true
			end
		end
	else
		self.combinedcount = 0
		self.combinedtext = {}
	end
end

---Object that's used when precision isn't possible (number of targets variable or unknown)
---@param delay number
---@param ... any
function announcePrototype:CombinedShow(delay, ...)
	if self.option and not self.mod.Options[self.option] then return end
	if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
	if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
	local argTable = {...}
	for i = 1, #argTable do
		if type(argTable[i]) == "string" then
			if #self.combinedtext < 7 then--Throttle spam. We may not need more than 6 targets..
				if not checkEntry(self.combinedtext, argTable[i]) then
					self.combinedtext[#self.combinedtext + 1] = argTable[i]
				end
			else
				self.combinedcount = self.combinedcount + 1
			end
		end
	end
	DBMScheduler:Unschedule(self.Show, self.mod, self)
	local id = DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	test:Trace(self.mod, "SchedulerHideFromTraceIfUnscheduled", id)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "CombinedShow", ...)
end

---New object that allows defining count instead of scheduling for more efficient and immediate warnings when precise count is known
---@param maxTotal number
---@param ... any
function announcePrototype:PreciseShow(maxTotal, ...)
	test:Trace(self.mod, "CombinedWarningPreciseShow", self, maxTotal)
	if self.option and not self.mod.Options[self.option] then return end
	if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
	if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
	local argTable = {...}
	for i = 1, #argTable do
		if type(argTable[i]) == "string" then
			if #self.combinedtext < 7 then--Throttle spam. We may not need more than 6 targets..
				if not checkEntry(self.combinedtext, argTable[i]) then
					self.combinedtext[#self.combinedtext + 1] = argTable[i]
				end
			else
				self.combinedcount = self.combinedcount + 1
			end
		end
	end
	DBMScheduler:Unschedule(self.Show, self.mod, self)
	local viableTotal = DBM:NumRealAlivePlayers()
	if (maxTotal <= #self.combinedtext + self.combinedcount) or (viableTotal <= #self.combinedtext + self.combinedcount) then--All targets gathered, show immediately
		self:Show(...)--Does this need self or mod? will it have this bug? https://github.com/DeadlyBossMods/DBM-Unified/issues/153
		test:Trace(self.mod, "CombinedWarningPreciseShowSuccess", self, maxTotal)
	else--And even still, use scheduling backup in case counts still fail
		local id = DBMScheduler:Schedule(1.2, self.Show, self.mod, self, ...)
		test:Trace(self.mod, "SchedulerHideFromTraceIfUnscheduled", id, maxTotal)
		test:Trace(self.mod, "SetScheduleMethodName", id, self, "PreciseShow", maxTotal, ...)
	end
end

---@param t number
---@param ... any
function announcePrototype:Schedule(t, ...)
	local id = DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "Schedule", ...)
	return id
end

---@param time number?
---@param numAnnounces number?
---@param ... any
function announcePrototype:Countdown(time, numAnnounces, ...)
	DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
end

function announcePrototype:Cancel(...)
	return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
end

---@param name VPSound?
---@param customPath? string|number
function announcePrototype:Play(name, customPath)
	local voice = DBM.Options.ChosenVoicePack2
	if private.voiceSessionDisabled or voice == "None" or not DBM.Options.VPReplacesAnnounce then return end
	if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
	if (not DBM.Options.DontShowBossAnnounces and (not self.option or self.mod.Options[self.option])) and self.sound <= private.swFilterDisabled then
		--Filter tank specific voice alerts for non tanks if tank filter enabled
		if (name == "changemt" or name == "tauntboss") and not self.mod:IsTank() then return end
		local path = customPath or ("Interface\\AddOns\\DBM-VP" .. voice .. "\\" .. name .. ".ogg")
		DBM:PlaySoundFile(path)
	end
end

---@param t number
---@param name VPSound?
---@param customPath? string|number
function announcePrototype:ScheduleVoice(t, name, customPath)
	if private.voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
	DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
	local id = DBMScheduler:Schedule(t, self.Play, self.mod, self, name, customPath)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "ScheduleVoice", name, customPath)
	return id
end

---Object Permits scheduling voice multiple times for same object
---@param t number
---@param name VPSound?
---@param customPath? string|number
function announcePrototype:ScheduleVoiceOverLap(t, name, customPath)
	if private.voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
	local id = DBMScheduler:Schedule(t, self.Play, self.mod, self, name, customPath)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "ScheduleVoiceOverLap", name, customPath)
	return id
end

function announcePrototype:CancelVoice(...)
	if private.voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
	return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
end

---old constructor (no auto-localize)
---@param text string
---@param color number? 1 = Positive Message, 2 = Normal Message, 3 - Higher Priority, 4 - Highest Priority
---@param icon number|string? Use number for spellId, -number for journalID, number as string for textureID
---@param optionDefault SpecFlags|boolean?
---@param optionName string|boolean? String for custom option name. Using false hides option completely
---@param soundOption number|boolean? 0 = No Sound, 1 = Sound with no voice pack support, >=2 = Voice pack version/support
---@param spellID number|string? Used to define a spellID used for GroupSpells and WeakAura key
---@param waCustomName any? Used to show custom name/text for Spell header (usually used when a made up SpellID is used)
function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, soundOption, spellID, waCustomName)
	if not text then
		error("NewAnnounce: you must provide announce text", 2)
	end
	if type(text) == "number" then
		DBM:Debug("|cffff0000NewAnnounce: Non auto localized text cannot be numbers, fix this for |r" .. text)
	end
	if type(optionName) == "number" then
		DBM:Debug("|cffff0000NewAnnounce: Non auto localized optionNames cannot be numbers, fix this for |r" .. text)
		optionName = nil
	end
	if soundOption and type(soundOption) == "boolean" then
		soundOption = 0--No Sound
	end
	icon = DBM:ParseSpellIcon(icon)
	---@class Announce
	local obj = setmetatable(
		{
			objClass = "Announce",
			text = self.localization.warnings[text],
			combinedtext = {},
			combinedcount = 0,
			color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
			sound = soundOption or 1,
			mod = self,
			icon = icon,
			spellId = spellID,--For WeakAuras / other callbacks
		},
		mt
	)
	test:Trace(self, "NewAnnounce", obj, "untyped")
	if optionName then
		obj.option = optionName
		self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID, nil, waCustomName)
	elseif optionName ~= false then
		obj.option = text
		self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID, nil, waCustomName)
	end
	tinsert(self.announces, obj)
	return obj
end

-- new constructor (partially auto-localized warnings and options, yay!)
---@return Announce|Announce0|Announce1|Announce2
local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
	if not spellId then
		error("newAnnounce: you must provide spellId", 2)
	end
	local optionVersion, alternateSpellId, alternateSpellName
	if type(optionName) == "number" then
		if optionName > 10 then--Being used as spell name shortening
			if DBM.Options.WarningShortText then
				alternateSpellId = optionName
			end
		else--Being used as option version
			optionVersion = optionName
		end
		optionName = nil
	end
	--Ugly that only saves having to use 3 extra nils for Custom Name
	--Eventually all these hacks will go away if these objects ever get rewritten
	if type(preWarnTime) == "string" then
		if DBM.Options.WarningShortText then
			alternateSpellName = preWarnTime
		end
		preWarnTime = nil
	end
	if soundOption and type(soundOption) == "boolean" then
		soundOption = 0--No Sound
	end
	local text, spellName = setText(announceType, spellId, castTime, preWarnTime, alternateSpellName, alternateSpellId)
	icon = DBM:ParseSpellIcon(icon or spellId)
	---@class Announce
	local obj = setmetatable( -- todo: fix duplicate code
		{
			objClass = "Announce",
			text = text,
			combinedtext = {},
			combinedcount = 0,
			announceType = announceType,
			color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
			mod = self,
			icon = icon,
			sound = soundOption or 1,
			type = announceType,
			spellId = spellId,
			spellName = spellName,
			noFilter = noFilter,
			castTime = castTime,
			preWarnTime = preWarnTime,
		},
		mt
	)
	test:Trace(self, "NewAnnounce", obj, announceType)
	if optionName then
		obj.option = optionName
		self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellId, announceType)
	elseif optionName ~= false then
		obj.option = "announce" .. spellId .. announceType .. (optionVersion or "")
		self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellId, announceType)
		if noFilter and announceType == "target" then
			self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS["targetNF"]:format(spellId)
		else
			self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId)
		end
	end
	tinsert(self.announces, obj)
	return obj
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewYouAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "you", spellId, color or 1, ...)
end

---@param spellId number|string
---@param color number?
---@param icon number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param castTime number?
---@param preWarnTime number|string?
---@param soundOption number|boolean?
function bossModPrototype:NewTargetNoFilterAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
	---@type Announce1
	return newAnnounce(self, "target", spellId, color or 3, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, true)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1
function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
	---@type Announce1
	return newAnnounce(self, "target", spellId, color or 3, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce2
function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
	---@type Announce2
	return newAnnounce(self, "targetsource", spellId, color or 3, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce2NumStr
function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
	---@type Announce2NumStr
	return newAnnounce(self, "targetcount", spellId, color or 3, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "spell", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1
function bossModPrototype:NewSpellSourceAnnounce(spellId, color, ...)
	---@type Announce1
	return newAnnounce(self, "spellsource", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewIncomingAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "incoming", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1Num
function bossModPrototype:NewIncomingCountAnnounce(spellId, color, ...)
	---@type Announce1Num
	return newAnnounce(self, "incomingcount", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewEndAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "ends", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1
function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
	---@type Announce1
	return newAnnounce(self, "endtarget", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "fades", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1Num
function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
	---@type Announce1Num
	return newAnnounce(self, "addsleft", spellId, color or 3, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1Num
function bossModPrototype:NewCountAnnounce(spellId, color, ...)
	---@type Announce1Num
	return newAnnounce(self, "count", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce2StrNum
function bossModPrototype:NewStackAnnounce(spellId, color, ...)
	---@type Announce2StrNum
	return newAnnounce(self, "stack", spellId, color or 2, ...)
end

---@param spellId number|string
---@param castTime number?
---@param color number?
---@param icon number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param soundOption number|boolean?
function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, _, soundOption) -- spellId, color, castTime, icon, optionDefault, optionName, noArg, soundOption
	---@type Announce0
	return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, soundOption)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "soon", spellId, color or 2, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1Num
function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
	---@type Announce1Num
	return newAnnounce(self, "sooncount", spellId, color or 2, ...)
end

---This object disables sounds, it's almost always used in combation with a countdown timer. Even if not a countdown, its a text only spam not a sound spam
---@param spellId number|string
---@param castTime number?
---@param preWarnTime number|string?
---@param color number?
---@param icon number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param noFilter boolean?
function bossModPrototype:NewCountdownAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, _, noFilter) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
	---@type Announce1Num
	return newAnnounce(self, "countdown", spellId, color or 4, icon, optionDefault, optionName, castTime, preWarnTime, 0, noFilter)
end

---@param spellId number|string
---@param time number
---@param color number?
---@param icon number|string?
---@param optionDefault SpecFlags|boolean?
---@param optionName string|number|boolean?
---@param soundOption number|boolean?
function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, _, soundOption) -- spellId, time, color, icon, optionDefault, optionName, noArg, soundOption
	---@type Announce0
	return newAnnounce(self, "prewarn", spellId, color or 2, icon, optionDefault, optionName, nil, time, soundOption)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewBaitAnnounce(spellId, color, ...)
	---@type Announce0
	return newAnnounce(self, "bait", spellId, color or 3, ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewPhaseAnnounce(stage, color, icon, ...)
	---@type Announce0
	return newAnnounce(self, "stage", stage, color or 2, icon or "136116", ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1
function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
	---@type Announce1
	return newAnnounce(self, "stagechange", 0, color or 2, icon or "136116", ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce0
function bossModPrototype:NewPrePhaseAnnounce(stage, color, icon, ...)
	---@type Announce0
	return newAnnounce(self, "prestage", stage, color or 2, icon or "136116", ...)
end

---@overload fun(self, spellId: number|string, color: number?, icon: number|string?, optionDefault: SpecFlags|boolean?, optionName: string|number|boolean?, castTime: number?, preWarnTime: number|string?, soundOption: number|boolean?, noFilter: boolean?): Announce1
function bossModPrototype:NewMoveToAnnounce(spellId, color, ...)
	---@type Announce1
	return newAnnounce(self, "moveto", spellId, color or 3, ...)
end
