local mod	= DBM:NewMod(2364, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156866)
mod:SetEncounterID(2331)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20191109000000)--2019, 11, 09
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 306734 306865 306819 306866 309858 310003 309985",
	"SPELL_CAST_SUCCESS 310019 306643 309858",
	"SPELL_SUMMON 306866",
	"SPELL_AURA_APPLIED 312750 306090 306168 306732 306733 312996 306257 306279 306654 306819 309860 309852 306207 306273 313077",
	"SPELL_AURA_APPLIED_DOSE 306819 309860",
	"SPELL_AURA_REMOVED 312750 306090 306168 306732 306733 312996 306257 306279 306654 306207 306273 313077",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss2 boss3 boss4 boss5",--if you have 4 adds up, you're doing shit wrong. Just in case
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine tune range checker with more robust checks, if mythic has more than 1 add spawn at a time
--TODO, fix charged bonds if non heroic difficulties use a diff spellId
--TODO, Crackle timer? at the moment add stutter casts it so coding it with success means only starting a 3 second timer. If stutter casting is fixed I might put the timer in at START event
--TODO, Remaining Mythic Phase abilities/timers drycode
--Stage 1: Gathering Power
----Vita
local warnVitaPhase							= mod:NewSpellAnnounce(306732, 2)
local warnUnstableVita						= mod:NewTargetNoFilterAnnounce(306257, 4)
----Void
local warnVoidPhase							= mod:NewSpellAnnounce(306733, 2)
local warnUnstableVoid						= mod:NewCountAnnounce(306634, 2)
local warnNullifyingStrike					= mod:NewStackAnnounce(306819, 2, nil, "Tank")
local warnVoidCollapse						= mod:NewTargetNoFilterAnnounce(306881, 4)
----Nightmare
local warnNightmarePhase					= mod:NewSpellAnnounce(312996, 2)
local warnUnstableNightmare					= mod:NewTargetNoFilterAnnounce(313077, 4)
--Stage 2: Unleashed Wrath
local warnPhase2							= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnDecimated							= mod:NewStackAnnounce(309860, 2, nil, "Tank")
local warnVoidEruption						= mod:NewCountAnnounce(310003, 2)
local warnChargedBonds						= mod:NewTargetAnnounce(310019, 2)

--Stage 1: Gathering Power
local specWarnCallEssence					= mod:NewSpecialWarningSpell(306091, "-Healer")
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)
----Vita
local specWarnUnstableVita					= mod:NewSpecialWarningYou(306257, nil, nil, nil, 3, 2)
local yellUnstableVita						= mod:NewYell(306257)
local yellUnstableVitaFades					= mod:NewShortFadesYell(306257)
local specWarnVitaVuln						= mod:NewSpecialWarningYou(306279, nil, nil, nil, 1, 2)
local specWarnTerminalStrike				= mod:NewSpecialWarningMoveTo(306734, nil, nil, nil, 3, 2)
local specWarnCallCracklingStalker			= mod:NewSpecialWarningSwitch(306865, "-Healer", nil, nil, 1, 2)
----Void
local specWarnVoidVuln						= mod:NewSpecialWarningYou(306654, nil, nil, nil, 1, 2)
local specWarnCallVoidHunter				= mod:NewSpecialWarningSwitch(306866, "-Healer", nil, nil, 1, 2)
local specWarnNullifyingStrike				= mod:NewSpecialWarningStack(306819, nil, 2, nil, nil, 1, 6)
local specWarnNullifyingStrikeTaunt			= mod:NewSpecialWarningStack(306819, nil, nil, nil, 1, 2)
------Void Hunter
local specWarnVoidCollapse					= mod:NewSpecialWarningYou(306881, nil, nil, nil, 3, 2)
local yellVoidCollapse						= mod:NewYell(306881, nil, nil, nil, "YELL")
local yellVoidCollapseFades					= mod:NewShortFadesYell(306881, nil, nil, nil, "YELL")
----Nightmare
local specWarnUnstableNightmare				= mod:NewSpecialWarningYou(313077, nil, nil, nil, 3, 2)
local yellUnstableNightmare					= mod:NewYell(313077)
local yellUnstableNightmareFades			= mod:NewShortFadesYell(313077)
--Stage 2: Unleashed Wrath
local specWarnDecimatingStrike				= mod:NewSpecialWarningDefensive(309858, nil, nil, nil, 1, 2)
local specWarnChargedBonds					= mod:NewSpecialWarningMoveAwayCount(310019, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway:format(310019), nil, 3, 2)
local yellChargedBonds						= mod:NewYell(310019)
local specWarnDecimated						= mod:NewSpecialWarningStack(309860, nil, 2, nil, nil, 1, 6)
local specWarnDecimatedTaunt				= mod:NewSpecialWarningTaunt(309860, nil, nil, nil, 1, 2)

--Stage 1: Gathering Power
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20527))
local timerCallEssenceCD					= mod:NewCDCountTimer(44.9, 306091, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON, nil, 1, 5)--44.9-46.3
----Vita
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20528))
local timerTerminalStrikeCD					= mod:NewCDTimer(18.1, 306734, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerCallCracklingStalkerCD			= mod:NewCDTimer(30.1, 306865, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerUnstableVita						= mod:NewTargetTimer(5, 306257, nil, nil, nil, 5)
------Vita Add
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(20546))
--local timerCrackleCD						= mod:NewCDTimer(4.8, 306874, nil, nil, nil, 3)
----Void
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20529))
local timerNullifyingStrikeCD				= mod:NewCDTimer(17.3, 306819, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerCallVoidHunterCD					= mod:NewCDTimer(30.1, 306866, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerUnstableVoidCD					= mod:NewNextCountTimer(5.9, 306634, nil, nil, nil, 5)
------Void Add
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20549))
local timerVoidCollapseCD					= mod:NewCDTimer(10.8, 306881, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
--Stage 2: Unleashed Wrath
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20853))
local timerDecimatingStrikeCD				= mod:NewCDTimer(9.6, 309858, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--9.6-13.3
local timerVoidEruptionCD					= mod:NewCDTimer(20.6, 310003, nil, nil, nil, 2)--20.6-23
local timerChargedBondsCD					= mod:NewCDTimer(10.8, 310019, nil, nil, nil, 3)--10.8-18.2
local timerGorgeEssenceCD					= mod:NewCDTimer(29.1, 309985, nil, nil, nil, 6)
--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 306874)
mod:AddInfoFrameOption(306257, true)
mod:AddSetIconOption("SetIconOnUnstableVita", 306257, true, false, {1, 2})
mod:AddSetIconOption("SetIconOnChargedBonds", 310019, true, false, {1, 2})
mod:AddSetIconOption("SetIconOnVoidCollapse", 306881, true, false, {3})
mod:AddSetIconOption("SetIconOnUnstableNightmare", 313077, true, false, {4, 5})
mod:AddNamePlateOption("NPAuraOnDraws", 312750)

mod.vb.callEssenceCount = 0
mod.vb.currentVita = nil
mod.vb.lastHighest = "Unknown"
mod.vb.unstableVoidCount = 0
mod.vb.voidEruptionCount = 0
mod.vb.currentNightmare = nil
mod.vb.lastLowest = "Unknown"
local playerHasVita, playerHasNightmare = false, false
local VitaVulnerableTargets = {}
local VoidVulnerableTargets = {}
local consumingVoid = DBM:GetSpellInfo(306645)
local ChargedBondsTargets = {}

local furthestPlayerScanner, closestPlayerScanner
do
	--upvalues, this will be called a lot
	local Ambiguate, IsItemInRange, CheckInteractDistance, GetBestMapForUnit = Ambiguate, IsItemInRange, CheckInteractDistance, C_Map.GetBestMapForUnit
	local UnitIsDeadOrGhost, UnitIsConnected, UnitIsUnit = UnitIsDeadOrGhost, UnitIsConnected, UnitIsUnit

	local entireRaidDistancetable = {}
	local function updateRaidDistanceTable(self)
		for uId in DBM:GetGroupMembers() do
			local playerMapId = GetBestMapForUnit("player") or 0
			local mapId = GetBestMapForUnit(uId) or 0
			--Covers all bases, exists, same map, not self, not dead, and not DCed
			if UnitExists(uId) and playerMapId == mapId and not UnitIsUnit(uId, "player") and not UnitIsDeadOrGhost(uId) and UnitIsConnected(uId) then
				if IsItemInRange(90175, uId) then entireRaidDistancetable[uId] = 4
				elseif IsItemInRange(37727, uId) then entireRaidDistancetable[uId] = 6
				elseif IsItemInRange(8149, uId) then entireRaidDistancetable[uId] = 8
				elseif CheckInteractDistance(uId, 3) then entireRaidDistancetable[uId] = 10
				elseif CheckInteractDistance(uId, 2) then entireRaidDistancetable[uId] = 11
				elseif IsItemInRange(32321, uId) then entireRaidDistancetable[uId] = 13
				elseif IsItemInRange(6450, uId) then entireRaidDistancetable[uId] = 18
				elseif IsItemInRange(21519, uId) then entireRaidDistancetable[uId] = 23
				elseif CheckInteractDistance(uId, 1) then entireRaidDistancetable[uId] = 30
				elseif IsItemInRange(1180, uId) then entireRaidDistancetable[uId] = 33
				elseif UnitInRange(uId) then entireRaidDistancetable[uId] = 43
				elseif IsItemInRange(32698, uId)  then entireRaidDistancetable[uId] = 48
				elseif IsItemInRange(116139, uId)  then entireRaidDistancetable[uId] = 53
				elseif IsItemInRange(32825, uId) then entireRaidDistancetable[uId] = 60
				elseif IsItemInRange(35278, uId) then entireRaidDistancetable[uId] = 80
				else entireRaidDistancetable[uId] = 81 end
			end
		end
	end
	furthestPlayerScanner = function(self)
		updateRaidDistanceTable()
		local highestDistance = 0
		--Go through entireRaidDistancetable and establish who is highest distance
		--If multiple are at that distance, only first name is taken. Do to limited distance APIs, this lacks 100% accuracy but should be accurate most of time
		for uId, range in pairs(entireRaidDistancetable) do
			if range > highestDistance then
				highestDistance = range
				self.vb.lastHighest = DBM:GetUnitFullName(uId)
			end
		end
		self:SendSync("VitaUpdate", self.vb.lastHighest)
		if playerHasVita then--As long as debuff present, keep looping
			self:Schedule(0.5, furthestPlayerScanner, self)
		elseif not playerHasNightmare then
			table.wipe(entireRaidDistancetable)
		end
	end
	closestPlayerScanner = function(self)
		updateRaidDistanceTable()
		local lowestDistance = 1000
		--Go through entireRaidDistancetable and establish who is closest distance
		--If multiple are at that distance, only first name is taken. Do to limited distance APIs, this lacks 100% accuracy but should be accurate most of time
		for uId, range in pairs(entireRaidDistancetable) do
			if range < lowestDistance then
				lowestDistance = range
				self.vb.lastLowest = DBM:GetUnitFullName(uId)
			end
		end
		self:SendSync("NightmareUpdate", self.vb.lastLowest)
		if playerHasNightmare then--As long as debuff present, keep looping
			self:Schedule(0.5, closestPlayerScanner, self)
		elseif not playerHasVita then
			table.wipe(entireRaidDistancetable)
		end
	end
	function mod:OnSync(msg, target)
		if msg == "VitaUpdate" and target then
			target = Ambiguate(target, "None")--in cross realm situations, an off realmer would send -realmname on units for units for our realm, we need to correct this
			self.vb.lastHighest = target
			if self.Options.SetIconOnUnstableVita then
				self:SetIcon(self.vb.lastHighest, 2, 5)
			end
		elseif msg == "NightmareUpdate" and target then
			target = Ambiguate(target, "None")--in cross realm situations, an off realmer would send -realmname on units for units for our realm, we need to correct this
			self.vb.lastClosest = target
			if self.Options.SetIconOnUnstableNightmare then
				self:SetIcon(self.vb.lastClosest, 5, 5)
			end
		end
	end
end

local updateInfoFrame
do
	local unstableVita, vitaVuln, voidVuln, unstableNightmare = DBM:GetSpellInfo(306257), DBM:GetSpellInfo(306279), DBM:GetSpellInfo(306654), DBM:GetSpellInfo(313077)
	local floor = math.floor
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Unstable Vita Tracker
		if mod.vb.currentVita then
			addLine(unstableVita, mod.vb.currentVita)
			addLine(L.Furthest, mod.vb.lastHighest)
		end
		--Unstable Nightmare Tracker
		if mod.vb.currentNightmare then
			addLine(unstableNightmare, mod.vb.currentNightmare)
			addLine(L.Closest, mod.vb.lastClosest)
		end
		--Vita Vulnerability
		if #VitaVulnerableTargets > 0 then
			addLine("---"..vitaVuln.."---")
			for i=1, #VitaVulnerableTargets do
				local name = VitaVulnerableTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, _, _, _, vitaVulnExpireTime = DBM:UnitDebuff(uId, 306279)
					if vitaVulnExpireTime then
						local vitaRemaining = vitaVulnExpireTime-GetTime()
						addLine(i.."*"..name, floor(vitaRemaining))
					end
				end
			end
		end
		--Void Vulnerability
		if #VoidVulnerableTargets > 0 then
			addLine("---"..voidVuln.."---")
			for i=1, #VoidVulnerableTargets do
				local name = VoidVulnerableTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, _, _, _, voidVulnExpireTime = DBM:UnitDebuff(uId, 306654)
					if voidVulnExpireTime then
						local voidRemaining = voidVulnExpireTime-GetTime()
						addLine(i.."*"..name, floor(voidRemaining))
					end
				end
			end
		end
		return lines, sortedLines
	end
end

local function warnChargedBondsTargets()
	warnChargedBonds:Show(table.concat(ChargedBondsTargets, "<, >"))
	table.wipe(ChargedBondsTargets)
end

function mod:CollapseTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidCollapse:Show()
		specWarnVoidCollapse:Play("targetyou")
		yellVoidCollapse:Yell()
		yellVoidCollapseFades:Countdown(3.5)
	else
		warnVoidCollapse:Show(targetname)
	end
	if self.Options.SetIconOnVoidCollapse then
		self:SetIcon(targetname, 3, 3.5)
	end
end

function mod:OnCombatStart(delay)
	self.vb.callEssenceCount = 0
	self.vb.currentVita = nil
	self.vb.lastHighest = "Unknown"
	self.vb.voidEruptionCount = 0
	self.vb.currentNightmare = nil
	self.vb.lastLowest = "Unknown"
	playerHasVita, playerHasNightmare = false, false
	table.wipe(VitaVulnerableTargets)
	table.wipe(VoidVulnerableTargets)
	table.wipe(ChargedBondsTargets)
	if self.Options.NPAuraOnDraws then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnDraws then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 306257) then
		playerHasVita = true
		furthestPlayerScanner(self)
	end
	if DBM:UnitDebuff("player", 313077) then
		playerHasNightmare = true
		closestPlayerScanner(self)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 306734 then
		timerTerminalStrikeCD:Start(18.1)
		if UnitDetailedThreatSituation("player", "boss1") then--We are highest threat target
			specWarnTerminalStrike:Show(consumingVoid)
			specWarnTerminalStrike:Play("findshelter")
		end
	elseif spellId == 306865 then
		specWarnCallCracklingStalker:Show()
		specWarnCallCracklingStalker:Play("bigmob")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(self:IsMythic() and 8 or 6)
		end
	elseif spellId == 306819 then
		timerNullifyingStrikeCD:Start(17.3)
	elseif spellId == 306866 then
		specWarnCallVoidHunter:Show()
		specWarnCallVoidHunter:Play("bigmob")
	elseif spellId == 306881 then
		warnVoidCollapse:Show()
	elseif spellId == 309858 then
		if UnitDetailedThreatSituation("player", "boss1") then--We are highest threat target
			specWarnDecimatingStrike:Show()
			specWarnDecimatingStrike:Play("defensive")
		end
		timerDecimatingStrikeCD:Start()
	elseif spellId == 310003 then
		self.vb.voidEruptionCount = self.vb.voidEruptionCount + 1
		warnVoidEruption:Show(self.vb.voidEruptionCount)
		timerVoidEruptionCD:Start()
	elseif spellId == 309985 then
		timerGorgeEssenceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 310019 then
		timerChargedBondsCD:Start()
	elseif spellId == 306643 then
		self.vb.unstableVoidCount = self.vb.unstableVoidCount + 1
		warnUnstableVoid:Show(self.vb.unstableVoidCount)
		if self.vb.unstableVoidCount < 5 then
			timerUnstableVoidCD:Start(5.9, self.vb.unstableVoidCount+1)
		end
	elseif spellId == 309858 then--Because he can stutter cast and restart cast, timer can't be reliable started in SPELL_CAST_START
		timerDecimatingStrikeCD:Start(8.1)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 306866 then--Call Void Hunter#
		timerVoidCollapseCD:Start(5, args.destGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 312750 or spellId == 306090 or spellId == 306168 then
		if self.Options.NPAuraOnDraws then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 60)
		end
	elseif spellId == 306732 then--Vita Empowered
		warnVitaPhase:Show()
		timerCallCracklingStalkerCD:Start(5.8)
		timerTerminalStrikeCD:Start(10.7)
	elseif spellId == 306733 then--Void Empowered
		warnVoidPhase:Show()
		self.vb.unstableVoidCount = 0
		timerUnstableVoidCD:Start(6, 1)
		timerCallVoidHunterCD:Start(7.1)
		timerNullifyingStrikeCD:Start(10.3)
	elseif spellId == 312996 then--Nightmare Empowered
		warnNightmarePhase:Show()
	elseif spellId == 306207 or spellId == 306273 then--Unstable Vita (Initial, hop)
		self.vb.currentVita = args.destName
		if args:IsPlayer() then
			playerHasVita = true
			furthestPlayerScanner(self)
			specWarnUnstableVita:Show()
			specWarnUnstableVita:Play("targetyou")
			yellUnstableVita:Yell()
			yellUnstableVitaFades:Countdown(spellId)
		else
			warnUnstableVita:Show(args.destName)
		end
		if self.Options.SetIconOnUnstableVita then
			self:SetIcon(args.destName, 1)
		end
		timerUnstableVita:Start(5, args.destName)
	elseif spellId == 313077 then--Unstable Nightmare
		self.vb.currentNightmare = args.destName
		if args:IsPlayer() then
			playerHasNightmare = true
			closestPlayerScanner(self)
			specWarnUnstableNightmare:Show()
			specWarnUnstableNightmare:Play("targetyou")
			yellUnstableNightmare:Yell()
			yellUnstableNightmareFades:Countdown(spellId)
		else
			warnUnstableNightmare:Show(args.destName)
		end
		if self.Options.SetIconOnUnstableNightmare then
			self:SetIcon(args.destName, 4)
		end
	elseif spellId == 306279 then
		if args:IsPlayer() then
			specWarnVitaVuln:Show()
			specWarnVitaVuln:Play("targetyou")
		end
		if not tContains(VitaVulnerableTargets, args.destName) then
			table.insert(VitaVulnerableTargets, args.destName)
		end
	elseif spellId == 306654 then
		if args:IsPlayer() then
			specWarnVoidVuln:Show()
			specWarnVoidVuln:Play("targetyou")
		end
		if not tContains(VoidVulnerableTargets, args.destName) then
			table.insert(VoidVulnerableTargets, args.destName)
		end
	elseif spellId == 306819 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnNullifyingStrike:Show(amount)
				specWarnNullifyingStrike:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnNullifyingStrikeTaunt:Show(args.destName)
					specWarnNullifyingStrikeTaunt:Play("tauntboss")
				else
					warnNullifyingStrike:Show(args.destName, amount)
				end
			end
		else
			warnNullifyingStrike:Show(args.destName, amount)
		end
	elseif spellId == 309860 then
		local amount = args.amount or 1
		if amount >= 2 then--2 or 3, depending on RNG of CD, the unit debuff check will handle if 2 isn't possible
			if args:IsPlayer() then
				specWarnDecimated:Show(amount)
				specWarnDecimated:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnDecimatedTaunt:Show(args.destName)
					specWarnDecimatedTaunt:Play("tauntboss")
				else
					warnDecimated:Show(args.destName, amount)
				end
			end
		else
			warnDecimated:Show(args.destName, amount)
		end
	elseif spellId == 309852 then--Ruin
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerDecimatingStrikeCD:Start(8.2)
		timerChargedBondsCD:Start(10.6)
		timerVoidEruptionCD:Start(14.5)
		timerGorgeEssenceCD:Start(25.5)
	elseif spellId == 310019 or spellId == 310022 then--310019 heroic confirmed, 310022 unknown, not used on heroic
		ChargedBondsTargets[#ChargedBondsTargets + 1] = args.destName
		self:Unschedule(warnChargedBondsTargets)
		if #ChargedBondsTargets == 2 then
			warnChargedBondsTargets()
			if ChargedBondsTargets[1] == UnitName("player") then
				specWarnChargedBonds:Show(ChargedBondsTargets[2])
			elseif ChargedBondsTargets[2] == UnitName("player") then
				specWarnChargedBonds:Show(ChargedBondsTargets[1])
			end
		else
			self:Schedule(0.3, warnChargedBondsTargets)
		end
		if self.Options.SetIconOnChargedBonds then
			self:SetIcon(args.destName, #ChargedBondsTargets)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 312750 or spellId == 306090 or spellId == 306168 then
		if self.Options.NPAuraOnDraws then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 306732 then--Vita Empowered
		timerTerminalStrikeCD:Stop()
		timerCallCracklingStalkerCD:Stop()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 306733 then--Void Empowered
		timerNullifyingStrikeCD:Stop()
		timerCallVoidHunterCD:Stop()
	elseif spellId == 312996 then--Nightmare Empowered

	elseif spellId == 306207 or spellId == 306273 then--Unstable Vita (Initial, hop)
		self.vb.currentVita = nil
		if args:IsPlayer() then
			playerHasVita = false
			self:Unschedule(furthestPlayerScanner)
			yellUnstableVitaFades:Cancel()
		end
		if self.Options.SetIconOnUnstableVita then
			self:SetIcon(args.destName, 0)
		end
		timerUnstableVita:Stop(args.destName)
	elseif spellId == 313077 then--Unstable Nightmare
		self.vb.currentNightmare = nil
		if args:IsPlayer() then
			playerHasNightmare = false
			self:Unschedule(closestPlayerScanner)
			yellUnstableNightmareFades:Cancel()
		end
		if self.Options.SetIconOnUnstableNightmare then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 306279 then
		tDeleteItem(VitaVulnerableTargets, args.destName)
	elseif spellId == 306654 then
		tDeleteItem(VoidVulnerableTargets, args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157366 then--void-hunter
		timerVoidCollapseCD:Stop(args.destGUID)
	elseif cid == 69872 then--crackling-stalker
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	--elseif cid == 160663 then--essence-of-nightmare

	--elseif cid == 156884 then--essence-of-vita

	--elseif cid == 156980 then--essence-of-void

	end
end

--306881 is in combat log, this is just faster and auto acquirs unit ID
--Absolute fastest auto target scan using UNIT_TARGET events
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 306881 then--Void Collapse
		self:BossUnitTargetScanner(uId, "CollapseTarget")
		timerVoidCollapseCD:Start(10.9, UnitGUID(uId))
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 306091 then--Materials of Destruction
		self.vb.callEssenceCount = self.vb.callEssenceCount + 1
		specWarnCallEssence:Show(self.vb.callEssenceCount)
		timerCallEssenceCD:Start(45, self.vb.callEssenceCount+1)
	end
end
