local mod	= DBM:NewMod(2195, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetCreatureID(138967)
mod:SetEncounterID(2145)
mod:DisableESCombatDetection()--ES fires moment you throw out CC, so it can't be trusted for combatstart
mod:SetZone()
mod:SetUsedIcons(1, 2, 8)
mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 32

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 273316 273451 273350",
	"SPELL_CAST_SUCCESS 273365 271640 274358 274168 273889 274098 274119",
	"SPELL_AURA_APPLIED 273365 271640 273434 276093 273288 274358 274271 273432 276434 274195",
	"SPELL_AURA_APPLIED_DOSE 274358",
	"SPELL_AURA_REMOVED 273365 271640 276093 273288 274358 274271 273432 276434 274195",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, check Locus of Corruption trigger for bugs after adding unneeded antispam to fix an impossible bug
--TODO, minion of zul fixate detection?
--[[
(ability.id = 273889 or ability.id = 274098 or ability.id = 274119) and type = "begincast"
 or (ability.id = 274358 or ability.id = 274168 or ability.id = 273365 or ability.id = 271640 or ability.id = 273360) and type = "cast"
 or (ability.id = 273889 or ability.id = 274098 or ability.id = 274119) and type = "cast"
 or ability.id = 274271 and type = "applydebuff"
 or (ability.id = 273316 or ability.id = 273451) and type = "begincast"
--]]
--Stage One: The Forces of Blood
local warnPoolofDarkness				= mod:NewCountAnnounce(273361, 4)--Generic warning since you want to be aware of it but not emphesized unless you're an assigned soaker
local warnActiveDecay					= mod:NewTargetNoFilterAnnounce(276434, 1)
local warnDarkRevCount					= mod:NewCountAnnounce(273365, 3)
--Stage Two: Zul, Awakened
local warnPhase2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")
local warnDeathwish						= mod:NewCountAnnounce(274271, 3)

--Stage One: The Forces of Blood
local specWarnDarkRevolation			= mod:NewSpecialWarningYouPos(273365, nil, nil, nil, 1, 2)
local yellDarkRevolation				= mod:NewPosYell(273365)
local yellDarkRevolationFades			= mod:NewIconFadesYell(273365)
local specWarnPitofDespair				= mod:NewSpecialWarningDispel(273434, "RemoveCurse", nil, nil, 1, 2)
local specWarnPoolofDarkness			= mod:NewSpecialWarningCount(273361, false, nil, nil, 1, 2)--Special warning for assigned soakers to optionally enable
local specWarnCallofCrawgSoon			= mod:NewSoonCountAnnounce("ej18541", 2, 273889, "-Healer", nil, nil, nil, 2)
local specWarnCallofHexerSoon			= mod:NewSoonCountAnnounce("ej18540", 2, 273889, "-Healer", nil, nil, nil, 2)
local specWarnCallofCrusherSoon			= mod:NewSoonCountAnnounce("ej18539", 2, 273889, "-Healer", nil, nil, nil, 2)
local specWarnCallofCrawg				= mod:NewSpecialWarningSwitch("ej18541", "-Healer", nil, nil, 1, 2)
local specWarnCallofHexer				= mod:NewSpecialWarningSwitch("ej18540", "-Healer", nil, nil, 1, 2)
local specWarnCallofCrusher				= mod:NewSpecialWarningSwitch("ej18539", "-Healer", nil, nil, 1, 2)
local specWarnMinionofZul				= mod:NewSpecialWarningSwitch("ej18530", "MagicDispeller", nil, nil, 1, 2)
----Forces of Blood
local specWarnCongealBlood				= mod:NewSpecialWarningSwitch(273451, "Dps", nil, nil, 3, 2)
local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, false, nil, 4, 1, 2)--Spam cast, so opt in, not opt out
--Stage Two: Zul, Awakened
local specWarnRupturingBlood			= mod:NewSpecialWarningStack(274358, nil, 3, nil, nil, 1, 6)
local specWarnRupturingBloodTaunt		= mod:NewSpecialWarningTaunt(274358, nil, nil, nil, 1, 2)
local specWarnRupturingBloodEdge		= mod:NewSpecialWarningMoveTo(274358, nil, nil, nil, 1, 7)
local yellRupturingBloodFades			= mod:NewShortFadesYell(274358)
local specWarnDeathwish					= mod:NewSpecialWarningYou(274271, nil, nil, nil, 1, 2)
local yellDeathwish						= mod:NewYell(274271)
local specWarnDeathwishNear				= mod:NewSpecialWarningClose(274271, nil, nil, nil, 1, 2)

mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerDarkRevolationCD				= mod:NewCDCountTimer(55, 273365, nil, nil, nil, 3)--55-63 (might get delayed by other casts)
local timerPoolofDarknessCD				= mod:NewCDCountTimer(30.6, 273361, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerCallofCrawgCD				= mod:NewTimer(42.6, "timerCallofCrawgCD", 273889, nil, nil, 1, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerCallofHexerCD				= mod:NewTimer(62.1, "timerCallofHexerCD", 273889, nil, nil, 1, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerCallofCrusherCD				= mod:NewTimer(62.1, "timerCallofCrusherCD", 273889, nil, nil, 1, DBM_CORE_DAMAGE_ICON)--Spawn trigger
local timerAddIncoming					= mod:NewTimer(12, "timerAddIncoming", 273889, nil, nil, 1, DBM_CORE_DAMAGE_ICON)--Even if you push the boss before add appears, if this timer has started, add IS coming
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18538))
local timerBloodyCleaveCD				= mod:NewCDTimer(14.1, 273316, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCongealBloodCD				= mod:NewCDTimer(22.7, 273451, nil, "Dps", nil, 5, nil, DBM_CORE_DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18550))
local timerRupturingBloodCD				= mod:NewCDTimer(6.1, 274358, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerDeathwishCD					= mod:NewNextCountTimer(27.9, 274271, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON..DBM_CORE_MAGIC_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownDarkRevolation			= mod:NewCountdown(55, 273365, "-Tank")
local countdownPoolofDarkness			= mod:NewCountdown("Alt12", 273361, false, nil, 4)
--P2
local countdownDeathwish				= mod:NewCountdown(27.9, 274271, "-Tank")

mod:AddInfoFrameOption(274195, true)
mod:AddNamePlateOption("NPAuraOnPresence", 276093)
mod:AddNamePlateOption("NPAuraOnThrumming", 273288)
mod:AddNamePlateOption("NPAuraOnBoundbyShadow", 273432)
mod:AddNamePlateOption("NPAuraOnEngorgedBurst2", 276299, false)
mod:AddNamePlateOption("NPAuraOnDecayingFlesh", 276434)
mod:AddSetIconOption("SetIconOnDecay", 276434, true, true)
mod:AddSetIconOption("SetIconDarkRev", 273365, true)
mod:AddDropdownOption("TauntBehavior", {"TwoHardThreeEasy", "TwoAlways", "ThreeAlways"}, "TwoHardThreeEasy", "misc")

mod.vb.phase = 1
mod.vb.darkRevCount = 0
mod.vb.poolCount = 0
mod.vb.CrawgSpawnCount = 0
mod.vb.CrawgsActive = 0
mod.vb.HexerSpawnCount = 0
mod.vb.CrusherSpawnCount = 0
mod.vb.DarkRevIcon = 1
mod.vb.deathwishCount = 0
mod.vb.activeDecay = nil
local unitTracked = {}
local corruptedBloodTarget = {}

local updateInfoFrame
do
	local floor, tsort = math.floor, table.sort
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(tempLines)
		table.wipe(tempLinesSorted)
		table.wipe(sortedLines)
		--Boss Powers first
		for i = 1, 5 do
			local uId = "boss"..i
			--Primary Power
			local currentPower, maxPower = UnitPower(uId), UnitPowerMax(uId)
			if maxPower and maxPower ~= 0 then
				local adjustedPower = currentPower / maxPower * 100
				if adjustedPower >= 1 and adjustedPower ~= 100 then--Filter 100 power, to basically eliminate cced Adds
					addLine(UnitName(uId), currentPower)
				end
			end
		end
		if mod:IsMythic() then
			addLine(" ", " ")--Insert a blank entry to split the two debuffs
			--Corrupted Blood Stacks (UGLY code)
			for i=1, #corruptedBloodTarget do
				local name = corruptedBloodTarget[i]
				local uId = DBM:GetRaidUnitId(name)
				local spellName, _, count = DBM:UnitDebuff(uId, 274195)
				if spellName and count then
					local unitName = UnitName(uId)
					tempLines[unitName] = count
					tempLinesSorted[#tempLinesSorted + 1] = unitName
				end
			end
			--Sort debuffs by highest then inject into regular table
			tsort(tempLinesSorted, sortFuncDesc)
			for _, name in ipairs(tempLinesSorted) do
				addLine(name, tempLines[name])
			end
		end
		return lines, sortedLines
	end
end


function mod:OnCombatStart(delay)
	table.wipe(corruptedBloodTarget)
	self.vb.phase = 1
	self.vb.poolCount = 0
	self.vb.darkRevCount = 0
	self.vb.CrawgSpawnCount = 0
	self.vb.CrawgsActive = 4--4 on pull
	self.vb.HexerSpawnCount = 0
	self.vb.CrusherSpawnCount = 0
	self.vb.DarkRevIcon = 1
	self.vb.deathwishCount = 0
	self.vb.activeDecay = nil
	timerPoolofDarknessCD:Start(20.5-delay, 1)
	countdownPoolofDarkness:Start(20.5-delay)
	timerDarkRevolationCD:Start(30-delay, 1)
	countdownDarkRevolation:Start(30-delay)
	timerCallofCrawgCD:Start(34.9, 1)--35-45
	timerCallofHexerCD:Start(50.5, 1)--50.5-54
	timerCallofCrusherCD:Start(70, 1)--70-73
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	table.wipe(unitTracked)
	if self:IsMythic() then
		self:RegisterShortTermEvents(
			"UNIT_TARGET_UNFILTERED"
		)
	end
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming or self.Options.NPAuraOnBoundbyShadow or self.Options.NPAuraOnEngorgedBurst2 or self.Options.NPAuraOnDecayingFlesh then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
		if self.Options.NPAuraOnEngorgedBurst2 then
			self:RegisterOnUpdateHandler(function(self)
				for i = 1, 40 do
					local UnitID = "nameplate"..i
					local GUID = UnitGUID(UnitID)
					local cid = self:GetCIDFromGUID(GUID)
					if cid == 139059 then
						local unitPower = UnitPower(UnitID)
						if not unitTracked[GUID] then unitTracked[GUID] = "None" end
						if (unitPower < 30) then
							if unitTracked[GUID] ~= "Green" then
								unitTracked[GUID] = "Green"
								DBM.Nameplate:Show(true, GUID, 276299, 463281)
							end
						elseif (unitPower < 60) then
							if unitTracked[GUID] ~= "Yellow" then
								unitTracked[GUID] = "Yellow"
								DBM.Nameplate:Hide(true, GUID, 276299, 463281)
								DBM.Nameplate:Show(true, GUID, 276299, 460954)
							end
						elseif (unitPower < 90) then
							if unitTracked[GUID] ~= "Red" then
								unitTracked[GUID] = "Red"
								DBM.Nameplate:Hide(true, GUID, 276299, 460954)
								DBM.Nameplate:Show(true, GUID, 276299, 463282)
							end
						elseif (unitPower < 100) then
							if unitTracked[GUID] ~= "Critical" then
								unitTracked[GUID] = "Critical"
								DBM.Nameplate:Hide(true, GUID, 276299, 463282)
								DBM.Nameplate:Show(true, GUID, 276299, 237521)
							end
						end
					end
				end
			end, 1)
		end
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnThrumming or self.Options.NPAuraOnBoundbyShadow or self.Options.NPAuraOnEngorgedBurst2 or self.Options.NPAuraOnDecayingFlesh then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 273316 then--Tank Cleave
		timerBloodyCleaveCD:Start(13.4, args.sourceGUID)
	elseif spellId == 273451 and self:AntiSpam(8, 1) then
		specWarnCongealBlood:Show()
		specWarnCongealBlood:Play("targetchange")
		timerCongealBloodCD:Start(23, args.sourceGUID)
	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBloodshard:Show(args.sourceName)
		specWarnBloodshard:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 274358 then
		timerRupturingBloodCD:Start()
	elseif spellId == 274168 and self:AntiSpam(5, 2) then--Apparently requires antispam for something that fire ONCE in combat log, no idea why.
		self.vb.phase = 2
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerDarkRevolationCD:Stop()
		countdownDarkRevolation:Cancel()
		timerPoolofDarknessCD:Stop()
		countdownPoolofDarkness:Cancel()
		timerCallofCrawgCD:Stop()
		timerCallofHexerCD:Stop()
		timerCallofCrusherCD:Stop()
		timerRupturingBloodCD:Start(6.5)
		timerPoolofDarknessCD:Start(15, self.vb.poolCount+1)--Still used in P2
		countdownPoolofDarkness:Start(15)
		timerDeathwishCD:Start(23, 1)
		countdownDeathwish:Start(23)
	elseif spellId == 273365 or spellId == 271640 then--Two versions of debuff, one that spawns an add and one that does not (so probably LFR/normal version vs heroic/mythic version)
		self.vb.darkRevCount = self.vb.darkRevCount + 1
		warnDarkRevCount:Show(self.vb.darkRevCount)
		timerDarkRevolationCD:Start(55, self.vb.darkRevCount+1)
		countdownDarkRevolation:Start(55)
	elseif spellId == 273889 then--Bloodthirsty Crawg
		self.vb.CrawgSpawnCount = self.vb.CrawgSpawnCount + 1
		specWarnCallofCrawgSoon:Show(self.vb.CrawgSpawnCount)
		specWarnCallofCrawgSoon:Play("mobsoon")
		specWarnCallofCrawg:Schedule(12, self.vb.CrawgSpawnCount)
		specWarnCallofCrawg:ScheduleVoice(12, "killmob")
		if self:IsMythic() then
			timerCallofCrawgCD:Start(45.6, self.vb.CrawgSpawnCount+1)
		else
			timerCallofCrawgCD:Start(40.6, self.vb.CrawgSpawnCount+1)
		end
		timerAddIncoming:Start(12, L.Crawg)
		self.vb.CrawgsActive = self.vb.CrawgsActive + 4--4 in all difficulties?
		if self.Options.NPAuraOnEngorgedBurst2 and self.vb.CrawgsActive <= 4 then--This should only happen if previous count was 0, so re-enable scanner
			self:RegisterOnUpdateHandler(function(self)
				for i = 1, 40 do
					local UnitID = "nameplate"..i
					local GUID = UnitGUID(UnitID)
					local cid = self:GetCIDFromGUID(GUID)
					if cid == 139059 then
						local unitPower = UnitPower(UnitID)
						if not unitTracked[GUID] then unitTracked[GUID] = "None" end
						if (unitPower < 30) then
							if unitTracked[GUID] ~= "Green" then
								unitTracked[GUID] = "Green"
								DBM.Nameplate:Show(true, GUID, 276299, 463281)
							end
						elseif (unitPower < 60) then
							if unitTracked[GUID] ~= "Yellow" then
								unitTracked[GUID] = "Yellow"
								DBM.Nameplate:Hide(true, GUID, 276299, 463281)
								DBM.Nameplate:Show(true, GUID, 276299, 460954)
							end
						elseif (unitPower < 90) then
							if unitTracked[GUID] ~= "Red" then
								unitTracked[GUID] = "Red"
								DBM.Nameplate:Hide(true, GUID, 276299, 460954)
								DBM.Nameplate:Show(true, GUID, 276299, 463282)
							end
						elseif (unitPower < 100) then
							if unitTracked[GUID] ~= "Critical" then
								unitTracked[GUID] = "Critical"
								DBM.Nameplate:Hide(true, GUID, 276299, 463282)
								DBM.Nameplate:Show(true, GUID, 276299, 237521)
							end
						end
					end
				end
			end, 1)
		end
	elseif spellId == 274098 then--nazmani-bloodhexer
		self.vb.HexerSpawnCount = self.vb.HexerSpawnCount + 1
		specWarnCallofHexerSoon:Show(self.vb.HexerSpawnCount)
		specWarnCallofHexerSoon:Play("mobsoon")
		specWarnCallofHexer:Schedule(12, self.vb.HexerSpawnCount)
		specWarnCallofHexer:ScheduleVoice(12, "killmob")
		timerCallofHexerCD:Start(60.1, self.vb.HexerSpawnCount+1)
		timerAddIncoming:Start(12, L.Bloodhexer)
	elseif spellId == 274119 then--nazmani-crusher
		self.vb.CrusherSpawnCount = self.vb.CrusherSpawnCount + 1
		specWarnCallofCrusherSoon:Show(self.vb.CrusherSpawnCount)
		specWarnCallofCrusherSoon:Play("mobsoon")
		specWarnCallofCrusher:Schedule(12, self.vb.CrusherSpawnCount)
		specWarnCallofCrusher:ScheduleVoice(12, "killmob")
		timerCallofCrusherCD:Start(60.1, self.vb.CrusherSpawnCount+1)
		timerAddIncoming:Start(12, L.Crusher)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 274358 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			local tauntStack = 3
			if self:IsHard() and self.Options.TauntBehavior == "TwoHardThreeEasy" or self.Options.TauntBehavior == "TwoAlways" then
				tauntStack = 2
			end
			if amount >= tauntStack then
				if args:IsPlayer() then
					specWarnRupturingBlood:Show(amount)
					specWarnRupturingBlood:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnRupturingBloodTaunt:Show(args.destName)
						specWarnRupturingBloodTaunt:Play("tauntboss")
					else
						warnRupturingBlood:Show(args.destName, amount)
					end
				end
			else
				warnRupturingBlood:Show(args.destName, amount)
			end
		else--Not a tank
			--Make sure someone who's not a tank still gets a warning and told to go to edge of room
			--Non tanks won't wait til 3 stacks to tell tank to run out
			if args:IsPlayer() then
				specWarnRupturingBlood:Show(1)
				specWarnRupturingBlood:Play("stackhigh")
			end
		end
		if args:IsPlayer() then
			yellRupturingBloodFades:Cancel()
			yellRupturingBloodFades:Countdown(20)
			specWarnRupturingBloodEdge:Cancel()
			specWarnRupturingBloodEdge:Schedule(15, DBM_CORE_ROOM_EDGE)
			specWarnRupturingBloodEdge:CancelVoice()
			specWarnRupturingBloodEdge:ScheduleVoice(15, "runtoedge")
		end
	elseif spellId == 273365 or spellId == 271640 then--Two versions of debuff, one that spawns an add and one that does not (so probably LFR/normal version vs heroic/mythic version)
		local icon = self.vb.DarkRevIcon
		if args:IsPlayer() then
			specWarnDarkRevolation:Show(self:IconNumToTexture(icon))
			specWarnDarkRevolation:Play("mm"..icon)
			yellDarkRevolation:Yell(icon, icon, icon)
			yellDarkRevolationFades:Countdown(10, nil, icon)
		end
		if self.Options.SetIconDarkRev then
			self:SetIcon(args.destName, icon)
		end
		self.vb.DarkRevIcon = self.vb.DarkRevIcon + 1
		if self.vb.DarkRevIcon == 3 then
			self.vb.DarkRevIcon = 1
		end
	elseif spellId == 273434 and self:CheckDispelFilter() then
		specWarnPitofDespair:CombinedShow(0.3, args.destName)
		specWarnPitofDespair:CancelVoice()--Avoid spam
		specWarnPitofDespair:ScheduleVoice(0.3, "helpdispel")
	elseif spellId == 276093 then--Sanguine Presence
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 273288 then--Thrumming Pulse
		if self.Options.NPAuraOnThrumming then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 40)
		end
	elseif spellId == 273432 then--Bound by Shadow
		if self.Options.NPAuraOnBoundbyShadow then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 276434 then--Decaying Flesh
		self.vb.activeDecay = args.destGUID
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid ~= 139059 then--Minimize spam by just not announcing when it's on Crawgs
			warnActiveDecay:Show(args.destName)
		end
		if self.Options.NPAuraOnDecayingFlesh then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 12)
		end
	elseif spellId == 274271 then
		if args:IsPlayer() then
			specWarnDeathwish:Show()
			specWarnDeathwish:Play("targetyou")
			yellDeathwish:Yell()
		elseif self:CheckNearby(15, args.destName) and not DBM:UnitDebuff("player", spellId) then
			specWarnDeathwishNear:CombinedShow(0.3, args.destName)
			specWarnDeathwishNear:CancelVoice()--Avoid spam
			specWarnDeathwishNear:ScheduleVoice(0.3, "runaway")
		end
	elseif spellId == 274195 then
		if not tContains(corruptedBloodTarget, args.destName) then
			table.insert(corruptedBloodTarget, args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 273365 or spellId == 271640 then
		if args:IsPlayer() then
			yellDarkRevolationFades:Cancel()
		end
		if spellId == 273365 and self:AntiSpam(5, 3) then
			specWarnMinionofZul:Show()
			specWarnMinionofZul:Play("helpdispel")
		end
	elseif spellId == 276093 then--Sanguine Presence
		if self.Options.NPAuraOnPresence then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 273288 then--Thrumming Pulse
		if self.Options.NPAuraOnThrumming then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 273432 then--Bound by Shadow
		if self.Options.NPAuraOnBoundbyShadow then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 276434 then--Decaying Flesh
		if self.Options.NPAuraOnDecayingFlesh then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 274358 then
		if args:IsPlayer() then
			yellRupturingBloodFades:Cancel()
			specWarnRupturingBloodEdge:Cancel()
			specWarnRupturingBloodEdge:CancelVoice()
		end
	elseif spellId == 274195 then
		tDeleteItem(corruptedBloodTarget, args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 139185 then--minion-of-zul

	elseif cid == 139051 then--nazmani-crusher
		timerBloodyCleaveCD:Stop(args.destGUID)
	elseif cid == 139057 then--nazmani-bloodhexer
		timerCongealBloodCD:Stop(args.destGUID)
	elseif cid == 139059 then--Bloodthirsty Crawg
		DBM.Nameplate:Hide(true, args.destGUID)
		unitTracked[args.destGUID] = nil
		self.vb.CrawgsActive = self.vb.CrawgsActive - 1
		if self.vb.CrawgsActive == 0 then
			self:UnregisterOnUpdateHandler()--Kill scanner, no crawgs left
		end
	end
end

do
	local function TrySetTarget(self)
		if DBM:GetRaidRank() >= 1 then
			for uId in DBM:GetGroupMembers() do
				if UnitGUID(uId.."target") == self.vb.activeDecay then
					self.vb.activeDecay = nil
					local icon = GetRaidTargetIndex(uId)
					if not icon then
						SetRaidTarget(uId.."target", 8)
					end
				end
				if not (self.vb.activeDecay) then
					break
				end
			end
		end
	end

	function mod:UNIT_TARGET_UNFILTERED()
		if self.Options.SetIconOnDecay and self.vb.activeDecay then
			TrySetTarget(self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 274315 then--Deathwish
		self.vb.deathwishCount = self.vb.deathwishCount + 1
		warnDeathwish:Show(self.vb.deathwishCount)
		timerDeathwishCD:Start(27.9, self.vb.deathwishCount+1)
		countdownDeathwish:Start(27.9)
	elseif spellId == 273361 then--Pool of Darkness
		self.vb.poolCount = self.vb.poolCount + 1
		if self.Options.SpecWarn273361count then
			specWarnPoolofDarkness:Show(self.vb.poolCount)
			specWarnPoolofDarkness:Play("helpsoak")
		else
			warnPoolofDarkness:Show(self.vb.poolCount)
		end
		if self.vb.phase == 2 then
			timerPoolofDarknessCD:Start(15.5, self.vb.poolCount+1)
			countdownPoolofDarkness:Start(15.5)
		else
			timerPoolofDarknessCD:Start(30.5, self.vb.poolCount+1)
			countdownPoolofDarkness:Start(30.5)
		end
	end
end
