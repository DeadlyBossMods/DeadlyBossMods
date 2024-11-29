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

local playerName = UnitName("player")

---@diagnostic disable: inject-field
local frame = CreateFrame("Frame", "DBMSpecialWarning", UIParent)
local font1 = frame:CreateFontString("DBMSpecialWarning1", "OVERLAY", "ZoneTextFont")
font1:SetWidth(1024)
font1:SetHeight(0)
font1:SetPoint("TOP", 0, 0)
local font2 = frame:CreateFontString("DBMSpecialWarning2", "OVERLAY", "ZoneTextFont")
font2:SetWidth(1024)
font2:SetHeight(0)
font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
frame:SetMovable(true)
frame:SetWidth(1)
frame:SetHeight(1)
frame:SetFrameStrata("HIGH")
frame:SetClampedToScreen(true)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

local font1elapsed, font2elapsed, moving

local function fontHide1()
	local duration = DBM.Options.SpecialWarningDuration2
	if font1elapsed > duration * 1.3 then
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
	local duration = DBM.Options.SpecialWarningDuration2
	if font2elapsed > duration * 1.3 then
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

function DBM:UpdateSpecialWarningOptions()
	frame:ClearAllPoints()
	local font = self.Options.SpecialWarningFont == "standardFont" and private.standardFont or self.Options.SpecialWarningFont
	frame:SetPoint(self.Options.SpecialWarningPoint, UIParent, self.Options.SpecialWarningPoint, self.Options.SpecialWarningX, self.Options.SpecialWarningY)
	font1:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
	font2:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
	font1:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
	font2:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
	if self.Options.SpecialWarningFontShadow then
		font1:SetShadowOffset(1, -1)
		font2:SetShadowOffset(1, -1)
	else
		font1:SetShadowOffset(0, 0)
		font2:SetShadowOffset(0, 0)
	end
end

function DBM:AddSpecialWarning(text, force, specWarnObject)
	local added = false
	if not frame.font1ticker then
		font1elapsed = 0
		font1.lastUpdate = GetTime()
		font1:SetText(text)
		font1:Show()
		added = true
		frame.font1ticker = frame.font1ticker or C_Timer.NewTicker(0.05, fontHide1)
	elseif not frame.font2ticker or force then
		font2elapsed = 0
		font2.lastUpdate = GetTime()
		font2:SetText(text)
		font2:Show()
		added = true
		frame.font2ticker = frame.font2ticker or C_Timer.NewTicker(0.05, fontHide2)
	end
	if not added then
		local prevText1 = font2:GetText()
		font1:SetText(prevText1)
		font1elapsed = font2elapsed
		self:AddSpecialWarning(text, true, specWarnObject)
	else
		test:Trace(specWarnObject and specWarnObject.mod or self, "ShowSpecialWarning", specWarnObject, text)
	end
end

local anchorFrame
local function moveEnd(self)
	moving = false
	anchorFrame:Hide()
	font1elapsed = self.Options.SpecialWarningDuration2
	font2elapsed = self.Options.SpecialWarningDuration2
	frame:SetFrameStrata("HIGH")
	self:Unschedule(moveEnd)
	DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
end

function DBM:MoveSpecialWarning()
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
			DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
		end)
		anchorFrame:SetScript("OnDragStop", function()
			frame:StopMovingOrSizing()
			local point, _, _, xOfs, yOfs = frame:GetPoint(1)
			self.Options.SpecialWarningPoint = point
			self.Options.SpecialWarningX = xOfs
			self.Options.SpecialWarningY = yOfs
			self:Schedule(15, moveEnd, self)
			DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, private.isRetail and 237538 or 136106)
		end)
	end
	if anchorFrame:IsShown() then
		moveEnd(self)
	else
		moving = true
		anchorFrame:Show()
		self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
		self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
		self:Schedule(15, moveEnd, self)
		DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, private.isRetail and 237538 or 136106)
		frame:Show()
		frame:SetFrameStrata("TOOLTIP")
		frame:SetAlpha(1)
	end
end

---@class SpecialWarning
local specialWarningPrototype = private:GetPrototype("SpecialWarning")
local mt = {__index = specialWarningPrototype}

local function classColoringFunction(cap)
	cap = cap:sub(2, -2)
	local noStrip = cap:match("noStrip ")
	if not noStrip then
		local name = cap
		local playerClass, playerIcon = DBM:GetRaidClass(name)
		if playerClass ~= "UNKNOWN" then
			cap = DBM:GetShortServerName(cap)--Only run strip code on valid player classes
			if DBM.Options.SWarnClassColor then
				local playerColor = RAID_CLASS_COLORS[playerClass]
				if playerColor then
					if playerIcon > 0 and playerIcon <= 8 then
						cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					else
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					end
				end
			end
		end
	else
		cap = cap:sub(9)
	end
	return cap
end

local textureCode = " |T%s:12:12|t "

local specInstructionalRemapTable = {
	["dispel"] = "target",
	["interrupt"] = "spell",
	["interruptcount"] = "count",
	["defensive"] = "spell",
	["taunt"] = "target",
	["soak"] = "spell",
	["soakcount"] = "count",
	["soakpos"] = "spell",
	["switch"] = "spell",
	["switchcustom"] = "spell",
	["switchcount"] = "count",
--		["adds"] = "spell",
--		["addscount"] = "spell",
--		["addscustom"] = "spell",
	["targetchange"] = "target",
	["gtfo"] = "spell",
	["bait"] = "soon",
	["youpos"] = "you",
	["youposcount"] = "youcount",
	["move"] = "spell",
	["keepmove"] = "spell",
	["stopmove"] = "spell",
	["dodge"] = "spell",
	["dodgecount"] = "count",
	["dodgeloc"] = "spell",
	["moveaway"] = "spell",
	["moveawaycount"] = "count",
	["moveawaytarget"] = "spell",
	["moveto"] = "spell",
	["jump"] = "spell",
	["run"] = "spell",
	["runcount"] = "spell",
	["cast"] = "spell",
	["lookaway"] = "spell",
	["reflect"] = "target",
}

local function setText(announceType, spellId, stacks, customName, alternateSpellId)
	local text, spellName
	if customName then
		spellName = customName
	else
		spellName = DBM:ParseSpellName(alternateSpellId or spellId, announceType) or CL.UNKNOWN
	end
	if announceType == "prewarn" then
		if type(stacks) == "string" then
			text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
		else
			text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(stacks or 5)))
		end
	else
		if DBM.Options.SpamSpecInformationalOnly then
			local remapType = specInstructionalRemapTable[announceType]
			if remapType then
				local newType = remapType
				text = L.AUTO_SPEC_WARN_TEXTS[newType]:format(spellName)
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
			end
		else
			text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		end
	end
	--Automatically register alternate spellnames when detecting their use here
	if spellId and (customName or alternateSpellId) then
		DBM:RegisterAltSpellName(spellId, customName or spellName)
	end
	return text, spellName
end

function specialWarningPrototype:SetText(customName)
	local text, spellName = setText(self.announceType, self.spellId, self.stacks, customName)
	self.text = text
	self.spellName = spellName
end

---Not to be confused with SetText, which only sets the text of object.
---<br>This changes actual ID so announce callback also swaps ID for WAs
---@param altSpellId string|number
function specialWarningPrototype:UpdateKey(altSpellId)
	self.spellId = altSpellId
	self.icon = DBM:ParseSpellIcon(altSpellId, self.announceType, self.icon)
	if self.announceType then
		--Regenerate auto localized text if it's an auto localized alert
		local text, spellName = setText(self.announceType, self.spellId, self.stacks)
		self.text = text
		self.spellName = spellName
	else--Just regenerating spellName not message text because it's likely a custom text object such as NewSpecialWarning
		self.spellName = DBM:ParseSpellName(altSpellId)
	end
end

---@param self SpecialWarning
---@param soundId number?
---@param isNote boolean?
---@return boolean
local function canVoiceReplace(self, soundId, isNote)
	if isNote then--Sound ID 5 is Notes feature, this is always allowed to play
		return false
	end
	if private.voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" then
		return false
	end
	soundId = soundId or self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
	local isVoicePackUsed
	if type(soundId) == "number" and soundId < 5 then--Value 1-4 are SW1 defaults, otherwise it's file data ID and handled by Custom
		isVoicePackUsed = DBM.Options.VPReplacesSADefault
	end
	return isVoicePackUsed
end

local specTypeFilterTable = {
	["dispel"] = "dispel",
	["interrupt"] = "interrupt",
	["interruptcount"] = "interrupt",
	["defensive"] = "defensive",
	["taunt"] = "taunt",
	["soak"] = "soak",
	["soakcount"] = "soak",
	["soakpos"] = "soak",
	["stack"] = "stack",
	["switch"] = "switch",
	["switchcount"] = "switch",
	["switchcustom"] = "switch",
	["adds"] = "switch",
	["addscount"] = "switch",
	["addscustom"] = "switch",
	["targetchange"] = "switch",
	["gtfo"] = "gtfo",
}

---@class SpecAnnounce0: SpecialWarning
---@field Show fun(self: SpecAnnounce0)
---@class SpecAnnounce1num: SpecialWarning
---@field Show fun(self: SpecAnnounce1num, arg1: number)
---@class SpecAnnounce1str: SpecialWarning
---@field Show fun(self: SpecAnnounce1str, arg1: string)
---@class SpecAnnounce1Annoying: SpecialWarning
---@field Show fun(self: SpecAnnounce1Annoying, arg1: string|unknown|nil)
---@class SpecAnnounce2strnum: SpecialWarning
---@field Show fun(self: SpecAnnounce2strnum, arg1: string, arg2: number)
---@class SpecAnnounce2numstr: SpecialWarning
---@field Show fun(self: SpecAnnounce2numstr, arg1: number, arg2: string)

function specialWarningPrototype:Show(...)
	--Check if option for this warning is even enabled
	if (not self.option or self.mod.Options[self.option]) and not moving and frame then
		--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
		if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
		--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
		if self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 and (self.mod:IsEasyDungeon() or DBM:IsTrivial()) then return end
		--We also check if person has the role filter turned on (typical for highest end raiders who don't want as much handholding from DBM)
		local filterType = specTypeFilterTable[self.announceType]
		if filterType then
			if DBM.Options["SpamSpecRole" .. filterType] then return end
		end
		--Lastly, we check if it's a tank warning and filter if not in tank spec. This is done because tank warnings on by default and handled fluidly by spec, not option setting
		if self.announceType == "taunt" and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
		local argTable = {...}
		-- add a default parameter for move away warnings
		if self.announceType == "gtfo" then
			if DBM:UnitBuff("player", 27827) then return end--Don't tell a priest in spirit of redemption form to GTFO, they can't, and they don't take damage from it anyhow
			if #argTable == 0 then
				argTable[1] = L.BAD
			end
		end
		if #self.combinedtext > 0 then
			--Throttle spam.
			if DBM.Options.SWarningAlphabetical then
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
		--Grab count for both the callback and the notes feature
		local announceCount
		if self.announceType and self.announceType:find("count") then
			if self.announceType == "interruptcount" then
				announceCount = argTable[2]--Count should be second arg in table
			else
				announceCount = argTable[1]--Count should be first arg in table
			end
			if type(announceCount) == "string" then
				--Probably a hypehnated double count like inferno slice or marked for death
				--This is pretty atypical in newer content cause it's a bit hacky
				local mainCount = string.split("-", announceCount)
				announceCount = tonumber(mainCount)
			end
		end
		local message = stringUtils.pformat(self.text, unpack(argTable))
		local text = ("%s%s%s"):format(
			(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or "",
			message,
			(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or ""
		)
		local noteHasName = nil
		if self.option then
			local noteText = self.mod.Options[self.option .. "SWNote"]
			if noteText and type(noteText) == "string" and noteText ~= "" then--Filter false bool and empty strings
				if announceCount then--Counts support different note for EACH count
					local notesTable = {string.split("/", noteText)}
					noteText = notesTable[announceCount]
					if noteText and type(noteText) == "string" and noteText ~= "" then--Refilter after string split to make sure a note for this count exists
						local hasPlayerName = noteText:find(playerName)
						if DBM.Options.SWarnNameInNote and hasPlayerName then
							noteHasName = 5
						end
						--Terminate special warning, it's an interrupt count warning without player name and filter enabled
						if (self.announceType == "interruptcount") and DBM.Options.FilterInterruptNoteName and not hasPlayerName then return end
						noteText = " (" .. noteText .. ")"
						text = text .. noteText
					end
				else--Non count warnings will have one note, period
					if DBM.Options.SWarnNameInNote and noteText:find(playerName) then
						noteHasName = 5
					end
					if self.announceType and not self.announceType:find("switch") then
						noteText = noteText:gsub(">.-<", classColoringFunction)--Class color note text before combining with warning text.
					end
					noteText = " (" .. noteText .. ")"
					text = text .. noteText
				end
			end
		end
		--Text is disabled, suresss text from screen and chat frame
		if not DBM.Options.DontShowSpecialWarningText then
			--No stripping on switch warnings, ever. They will NEVER have player name, but often have adds with "-" in name
			if self.announceType and not self.announceType:find("switch") then
				text = text:gsub(">.-<", classColoringFunction)
			end
			DBM:AddSpecialWarning(text, nil, self)
			if DBM.Options.ShowSWarningsInChat then
				local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
				self.mod:AddMsg(colorCode .. "[" .. L.MOVE_SPECIAL_WARNING_TEXT .. "] " .. text .. "|r", nil)
			end
		end
		self.combinedcount = 0
		self.combinedtext = {}
		if not UnitIsDeadOrGhost("player") then
			if noteHasName then
				if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options.SpecialWarningFlash5 then--Not included in above if statement on purpose. we don't want to trigger else rule if noteHasName is true but SpecialWarningFlash5 is false
					local repeatCount = DBM.Options.SpecialWarningFlashCount5 or 1
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol5[1], DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3], DBM.Options.SpecialWarningFlashDura5, DBM.Options.SpecialWarningFlashAlph5, repeatCount - 1)
				end
				if not DBM.Options.DontDoSpecialWarningVibrate and DBM.Options.SpecialWarningVibrate5 then
					DBM:VibrateController()
				end
			else
				local number = self.flash
				if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options["SpecialWarningFlash" .. number] then
					local repeatCount = DBM.Options["SpecialWarningFlashCount" .. number] or 1
					local flashcolor = DBM.Options["SpecialWarningFlashCol" .. number]
					DBM.Flash:Show(flashcolor[1], flashcolor[2], flashcolor[3], DBM.Options["SpecialWarningFlashDura" .. number], DBM.Options["SpecialWarningFlashAlph" .. number], repeatCount - 1)
				end
				if not DBM.Options.DontDoSpecialWarningVibrate and DBM.Options["SpecialWarningVibrate" .. number] then
					DBM:VibrateController()
				end
			end
		end
		--Text: Full message text
		--Icon: Texture path/id for icon
		--Type: Announce type
		----Types: spell, ends, fades, soon, bait, dispel, interrupt, interruptcount, you, youcount, youpos, soakpos, target, targetcount, defensive, taunt, close, move, keepmove, stopmove,
		----gtfo, dodge, dodgecount, dodgeloc, moveaway, moveawaycount, moveto, soak, jump, run, cast, lookaway, reflect, count, sooncount, stack, switch, switchcount, adds, addscount, addscustom, targetchange, prewarn
		------General Target Messages (but since it's a special warning, it applies to you in some way): target, targetcount
		------Fight Changes (Stages, adds, boss buff/debuff, etc): adds, addscount, addscustom, targetchange, switch, switchcount, ends
		------General (can really apply to anything): spell, count, soon, sooncount, prewarn
		------Personal/Role (Applies to you, or your job): Everything Else
		--SpellId: Raw spell or encounter journal Id if available.
		--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
		--boolean: Whether or not this warning is a special warning (higher priority). BW would call this "emphasized"
		--announceCount: If it's a count announce, this will provide access to the number value of that count. This, along with spellId should be used instead of message text scanning for most weak auras that need to target specific count casts
		DBM:FireEvent("DBM_Announce", text, self.icon, self.type, self.spellId, self.mod.id, true, announceCount)
		if self.sound and not DBM.Options.DontPlaySpecialWarningSound and (not self.option or self.mod.Options[self.option .. "SWSound"] ~= "None") then
			local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
			if noteHasName and type(soundId) == "number" then soundId = noteHasName end--Change number to 5 if it's not a custom sound, else, do nothing with it
			if self.hasVoice and canVoiceReplace(self, soundId, noteHasName and true) and self.hasVoice <= private.swFilterDisabled then return end
			DBM:PlaySpecialWarningSound(soundId or 1)
		end
	else
		self.combinedcount = 0
		self.combinedtext = {}
	end
end

---Object that's used when precision isn't possible (number of targets variable or unknown
---@param delay number
---@param ... any
function specialWarningPrototype:CombinedShow(delay, ...)
	--Check if option for this warning is even enabled
	if self.option and not self.mod.Options[self.option] then return end
	--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
	if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
	--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
	if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
	local argTable = {...}
	for i = 1, #argTable do
		if type(argTable[i]) == "string" then
			if #self.combinedtext < 6 then--Throttle spam. We may not need more than 5 targets..
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
function specialWarningPrototype:PreciseShow(maxTotal, ...)
	test:Trace(self.mod, "CombinedWarningPreciseShow", self, maxTotal)
	--Check if option for this warning is even enabled
	if self.option and not self.mod.Options[self.option] then return end
	--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
	if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
	--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
	if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
	local argTable = {...}
	for i = 1, #argTable do
		if type(argTable[i]) == "string" then
			if #self.combinedtext < 6 then--Throttle spam. We may not need more than 5 targets..
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
	if (maxTotal == #self.combinedtext) or (viableTotal == #self.combinedtext) then--All targets gathered, show immediately
		self:Show(...)--Does this need self or mod? will it have this bug? https://github.com/DeadlyBossMods/DBM-Unified/issues/153
		test:Trace(self.mod, "CombinedWarningPreciseShowSuccess", self, maxTotal)
	else--And even still, use scheduling backup in case counts still fail
		local id = DBMScheduler:Schedule(1.2, self.Show, self.mod, self, ...)
		test:Trace(self.mod, "SchedulerHideFromTraceIfUnscheduled", id)
		test:Trace(self.mod, "SetScheduleMethodName", id, self, "PreciseShow", maxTotal, ...)
	end
end

---Used as a lazy antispam. Does NOT combine. Use CombinedShow for that
---@param delay number?
---@param ... any
function specialWarningPrototype:DelayedShow(delay, ...)
	DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
	local id = DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	test:Trace(self.mod, "SchedulerHideFromTraceIfUnscheduled", id)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "DelayedShow", ...)
end

---@param t number
---@param ... any
function specialWarningPrototype:Schedule(t, ...)
	local id = DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "Schedule", ...)
	return id
end

---@param time number
---@param numAnnounces number?
---@param ... any
function specialWarningPrototype:Countdown(time, numAnnounces, ...)
	DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
end

function specialWarningPrototype:Cancel(_, ...) -- t, ...
	return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
end

--Several voice lines still need generic alternatives that don't feel "instructional"
local specInstructionalRemapVoiceTable = {
--		["dispel"] = "target",
--		["interrupt"] = "spell",
--		["interruptcount"] = "count",
--		["defensive"] = "spell",
	["taunt"] = "changemt",--Remaps sound to say a swap is happening, rather than telling you to taunt boss
--		["soak"] = "spell",
--		["soakcount"] = "count",
--		["soakpos"] = "spell",
--		["switch"] = "spell",
--		["switchcount"] = "count",
	["adds"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
	["addscount"] = "mobsoon",
	["addscustom"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
--		["targetchange"] = "target",
--		["gtfo"] = "spell",
--		["bait"] = "soon",
	["you"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
	["youpos"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
	["youposcount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["move"] = "spell",
--		["keepmove"] = "spell",
--		["stopmove"] = "spell",
--		["dodge"] = "spell",
--		["dodgecount"] = "count",
--		["dodgeloc"] = "spell",
	["moveaway"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
	["moveawaycount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["moveto"] = "spell",
--		["jump"] = "spell",
--		["run"] = "spell",
--		["runcount"] = "spell",
--		["cast"] = "spell",
--		["lookaway"] = "spell",
--		["reflect"] = "target",
}

---@param name VPSound?
---@param customPath? string|number
function specialWarningPrototype:Play(name, customPath)
	local voice = DBM.Options.ChosenVoicePack2
	local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
	if not canVoiceReplace(self, soundId) then return end
	if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
	local filterType = specTypeFilterTable[self.announceType]
	if filterType then
		--Filtered warning, filtered voice
		if DBM.Options["SpamSpecRole" .. filterType] then return end
	elseif DBM.Options.SpamSpecInformationalOnly then
		local remapType = specInstructionalRemapVoiceTable[self.announceType]
		if remapType then
			--Instructional disabled, remap to a less instructional voice line
			name = remapType
		end
	end
	if ((not self.option or self.mod.Options[self.option])) and self.hasVoice <= private.swFilterDisabled then
		--Filter tank specific voice alerts for non tanks if tank filter enabled
		if (name == "changemt" or name == "tauntboss") and not self.mod:IsTank() then return end
		--Mute VP if SW sound is set to None in the boss mod.
		if soundId == "None" then return end
		local path = customPath or ("Interface\\AddOns\\DBM-VP" .. voice .. "\\" .. name .. ".ogg")
		DBM:PlaySoundFile(path)
	end
end

---@param t number
---@param name VPSound?
---@param customPath? string|number
function specialWarningPrototype:ScheduleVoice(t, name, customPath)
	if not canVoiceReplace(self) then return end
	DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
	local id = DBMScheduler:Schedule(t, self.Play, self.mod, self, name, customPath)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "ScheduleVoice", name, customPath)
	return id
end

---Object Permits scheduling voice multiple times for same object
---@param t number
---@param name VPSound?
---@param customPath? string|number
function specialWarningPrototype:ScheduleVoiceOverLap(t, name, customPath)
	if not canVoiceReplace(self) then return end
	local id = DBMScheduler:Schedule(t, self.Play, self.mod, self, name, customPath)
	test:Trace(self.mod, "SetScheduleMethodName", id, self, "ScheduleVoiceOverLap", name, customPath)
	return id
end

function specialWarningPrototype:CancelVoice(...)
	if not canVoiceReplace(self) then return end
	return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
end

---old constructor (no auto-localize)
---@param text string
---@param optionDefault SpecFlags|boolean?
---@param optionName string|boolean? String for custom option name. Using false hides option completely
---@param optionVersion any optional: has to be number, but luaLS has a fit if we tell it that
---@param runSound number? 1 = Personal, 2 = Everyone, 3 = Very Important, 4 = Run Away
---@param hasVoice boolean|number? Voice pack version required for used sound file.
---@param difficulty number? Raid Difficulty index used for displaying difficulty icon next to option
---@param icon number|string? Use number for spellId, -number for journalID, number as string for textureID
---@param spellID string|number? Used to define a spellID used for GroupSpells and WeakAura key
---@param waCustomName any? Used to show custom name/text for Spell header (usually used when a made up SpellID is used)
function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty, icon, spellID, waCustomName)
	if not text then
		error("NewSpecialWarning: you must provide special warning text", 2)
	end
	if type(text) == "string" and text:match("OptionVersion") then
		error("NewSpecialWarning: you must provide remove optionversion hack for " .. optionDefault)
	end
	runSound = runSound or 1
	if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
		hasVoice = 2
	end
	icon = DBM:ParseSpellIcon(icon)
	---@class SpecialWarning
	local obj = setmetatable(
		{
			objClass = "SpecialWarning",
			text = self.localization.warnings[text],
			combinedtext = {},
			combinedcount = 0,
			mod = self,
			sound = runSound > 0,
			flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
			hasVoice = hasVoice,
			difficulty = difficulty,
			spellId = spellID,--For WeakAuras / other callbacks
			icon = icon,
		},
		mt
	)
	test:Trace(self, "NewSpecialWarning", obj, "untyped")
	local optionId = optionName or optionName ~= false and text
	if optionId then
		obj.voiceOptionId = hasVoice and "Voice" .. optionId or nil
		obj.option = optionId .. (optionVersion or "")
		self:AddSpecialWarningOption(obj.option, optionDefault, runSound, "announce", spellID, nil, waCustomName)
	end
	tinsert(self.specwarns, obj)
	return obj
end

---@param self DBMMod
---@return SpecialWarning|SpecAnnounce0
local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
	if not spellId then
		error("newSpecialWarning: you must provide spellId", 2)
	end
	if runSound == true then
		runSound = 2
	elseif not runSound then
		runSound = 1
	end
	if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
		hasVoice = 2
	end
	local alternateSpellId, alternateName
	--Hack to allow using alternat spellids for short names without adding a ton of extra nils
	if type(optionName) == "number" then
		if DBM.Options.SpecialWarningShortText then
			alternateSpellId = optionName
		end
		optionName = nil
	end
	--Hack to allow using alternat custom text for short names without adding a ton of extra nils
	if type(optionVersion) == "string" then
		if DBM.Options.SpecialWarningShortText then
			alternateName = optionVersion
		end
		optionVersion = nil
	end
	local text, spellName = setText(announceType, spellId, stacks, alternateName, alternateSpellId)
	local icon = DBM:ParseSpellIcon(spellId)
	---@class SpecialWarning
	local obj = setmetatable( -- todo: fix duplicate code
		{
			objClass = "SpecialWarning",
			text = text,
			combinedtext = {},
			combinedcount = 0,
			announceType = announceType,
			mod = self,
			sound = runSound > 0,
			flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
			hasVoice = hasVoice,
			difficulty = difficulty,
			type = announceType,
			spellId = spellId,
			spellName = spellName,
			stacks = stacks,
			icon = icon,
		},
		mt
	)
	test:Trace(self, "NewSpecialWarning", obj, announceType)
	if optionName then
		obj.option = optionName
	elseif optionName ~= false then
		local difficultyIcon = ""
		if difficulty then
			--1 LFR, 2 Normal, 3 Heroic, 4 Mythic
			--Likely 1 and 2 will never be used, but being prototyped just in case
			local path = private.isRetail and "EncounterJournal" or "AddOns\\DBM-Core\\textures"
			if difficulty == 3 then
				difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:102:118:7:27|t"
			elseif difficulty == 4 then
				difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:133:153:40:58|t"
			end
		end
		obj.option = "SpecWarn" .. spellId .. announceType .. (optionVersion or "")
		if announceType == "stack" then
			self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
		elseif announceType == "prewarn" then
			self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
		else
			self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
		end
	end
	if obj.option then
		self:AddSpecialWarningOption(obj.option, optionDefault, runSound, "announce", spellId, announceType)
	end
	obj.voiceOptionId = hasVoice and "Voice" .. spellId or nil
	tinsert(self.specwarns, obj)
	return obj
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningSpell(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "spell", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningEnd(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "ends", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningFades(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "fades", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningSoon(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "soon", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningBait(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "bait", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningDispel(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "dispel", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningInterrupt(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "interrupt", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce2strnum
function bossModPrototype:NewSpecialWarningInterruptCount(spellId, optionDefault, ...)
	---@type SpecAnnounce2strnum
	return newSpecialWarning(self, "interruptcount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningYou(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "you", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningYouCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "youcount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningYouPos(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "youpos", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce2numstr
function bossModPrototype:NewSpecialWarningYouPosCount(spellId, optionDefault, ...)
	---@type SpecAnnounce2numstr
	return newSpecialWarning(self, "youposcount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningSoakPos(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "soakpos", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningTarget(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "target", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningLink(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "link", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce2numstr
function bossModPrototype:NewSpecialWarningTargetCount(spellId, optionDefault, ...)
	---@type SpecAnnounce2numstr
	return newSpecialWarning(self, "targetcount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningDefensive(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "defensive", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningTaunt(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "taunt", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningClose(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "close", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningMove(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "move", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningKeepMove(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "keepmove", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningStopMove(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "stopmove", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecialWarning
function bossModPrototype:NewSpecialWarningGTFO(spellId, optionDefault, ...)
	return newSpecialWarning(self, "gtfo", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningDodge(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "dodge", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningDodgeCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "dodgecount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningDodgeLoc(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "dodgeloc", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningMoveAway(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "moveaway", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningMoveAwayCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "moveawaycount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningMoveAwayTarget(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "moveawaytarget", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1Annoying
function bossModPrototype:NewSpecialWarningMoveTo(spellId, optionDefault, ...)
	---@type SpecAnnounce1Annoying
	return newSpecialWarning(self, "moveto", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningSoak(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "soak", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningSoakCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "soakcount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningJump(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "jump", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningRun(spellId, optionDefault, optionName, optionVersion, runSound, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "run", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningRunCount(spellId, optionDefault, optionName, optionVersion, runSound, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "runcount", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningCast(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "cast", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningLookAway(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "lookaway", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningReflect(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "reflect", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "count", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningSoonCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "sooncount", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, stacks: number, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningStack(spellId, optionDefault, stacks, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "stack", spellId, stacks, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningSwitch(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "switch", spellId, nil, optionDefault, ...)
end

---Switch object that has string for count
---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningSwitchCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "switchcount", spellId, nil, optionDefault, ...)
end

---Switch object that has string for extra info (like target)
---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningSwitchCustom(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "switchcustom", spellId, nil, optionDefault, ...)
end

---Generic alert for incoming adds without context
---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningAdds(spellId, optionDefault, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "adds", spellId, nil, optionDefault, ...)
end

---Generic alert for incoming adds without context, but with count
---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1num
function bossModPrototype:NewSpecialWarningAddsCount(spellId, optionDefault, ...)
	---@type SpecAnnounce1num
	return newSpecialWarning(self, "addscount", spellId, nil, optionDefault, ...)
end

---Generic alert for incoming adds, but with custom text
---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningAddsCustom(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "addscustom", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce1str
function bossModPrototype:NewSpecialWarningTargetChange(spellId, optionDefault, ...)
	---@type SpecAnnounce1str
	return newSpecialWarning(self, "targetchange", spellId, nil, optionDefault, ...)
end

---@overload fun(self: DBMMod, spellId: number|string, optionDefault: SpecFlags|boolean?, time: number, optionName: number|string|boolean?, optionVersion: number|string?, runSound: number|boolean?, hasVoice: number?, difficulty: number?): SpecAnnounce0
function bossModPrototype:NewSpecialWarningPreWarn(spellId, optionDefault, time, ...)
	---@type SpecAnnounce0
	return newSpecialWarning(self, "prewarn", spellId, time, optionDefault, ...)
end

---@param number number
---@param forceVoice string?
---@param forcePath string?
function DBM:PlayCountSound(number, forceVoice, forcePath)
	if number > 10 then return end
	local voice
	if forceVoice then--For options example
		voice = forceVoice
	else
		voice = self.Options.CountdownVoice
	end
	local path
	local maxCount = 5
	if forcePath then
		path = forcePath
	else
		for _, count in pairs(DBM:GetCountSounds()) do
			if count.value == voice then
				path = count.path
				maxCount = count.max
				break
			end
		end
	end
	if not path or (number > maxCount) then return end
	self:PlaySoundFile(path .. number .. ".ogg")
end

---@param soundId number|string
---@param force boolean?
function DBM:PlaySpecialWarningSound(soundId, force)
	local sound
	if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then
		sound = self.Options.RaidWarningSound
	else
		sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
	end
	self:PlaySoundFile(sound, nil, true)
end

local function testWarningEnd()
	frame:SetFrameStrata("HIGH")
end

---@param text string?
---@param number number?
---@param noSound boolean?
---@param force boolean?
function DBM:ShowTestSpecialWarning(text, number, noSound, force)
	if moving then
		return
	end
	self:AddSpecialWarning(text or L.MOVE_SPECIAL_WARNING_TEXT)
	frame:SetFrameStrata("TOOLTIP")
	self:Unschedule(testWarningEnd)
	self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, testWarningEnd)
	if number and not noSound then
		self:PlaySpecialWarningSound(number, force)
	end
	if number then
		if self.Options["SpecialWarningFlash" .. number] then
			if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then return end--No flash if trivial
			local flashColor = self.Options["SpecialWarningFlashCol" .. number]
			local repeatCount = self.Options["SpecialWarningFlashCount" .. number] or 1
			self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura" .. number], self.Options["SpecialWarningFlashAlph" .. number], repeatCount - 1)
		end
		if not self.Options.DontDoSpecialWarningVibrate and self.Options["SpecialWarningVibrate" .. number] then
			self:VibrateController()
		end
	end
end
