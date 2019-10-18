local mod	= DBM:NewMod(2364, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156866)
mod:SetEncounterID(2331)
mod:SetZone()
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 306734 306865 306819 306866 306881 309858 310003 309985",
	"SPELL_CAST_SUCCESS 310019",
	"SPELL_AURA_APPLIED 312750 306090 306168 306732 306733 312996 306257 306279 306654 306819 309860 309852",
	"SPELL_AURA_APPLIED_DOSE 306819 309860",
	"SPELL_AURA_REMOVED 312750 306090 306168 306732 306733 312996 306257 306279 306654",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine tune range checker when valid CID for Crackling Stalkers is known
--TODO, track void bounce count accurately
--TODO, tank swaps, or is 2nd tank just add bitch. I can't really see anything on main boss that requires swapping
--TODO, fine tune some warnings probably
--TODO, improve charged bonds when valid spellIds known
--Stage 1: Gathering Power
----Vita
local warnVitaPhase							= mod:NewSpellAnnounce(306732, 2)
local warnUnstableVita						= mod:NewTargetNoFilterAnnounce(306257, 4)
----Void
local warnVoidPhase							= mod:NewSpellAnnounce(306733, 2)
--local warnUnstableVoid					= mod:NewCountAnnounce(306634, 2)
local warnNullifyingStrike					= mod:NewStackAnnounce(306819, 2, nil, "Tank")
local warnVoidCollapse						= mod:NewCastAnnounce(306881, 2)
----Nightmare
local warnNightmarePhase					= mod:NewSpellAnnounce(312996, 2)
--Stage 2: Unleashed Wrath
local warnPhase2							= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnDecimated							= mod:NewStackAnnounce(309860, 2, nil, "Tank")
local warnVoidEruption						= mod:NewCountAnnounce(310003, 2)
local warnChargedBonds						= mod:NewTargetAnnounce(310019, 2)

--Stage 1: Gathering Power
local specWarnCallEssence					= mod:NewSpecialWarningSpell(139040, "-Healer")
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
--Stage 2: Unleashed Wrath
local specWarnDecimatingStrike				= mod:NewSpecialWarningDefensive(309858, nil, nil, nil, 1, 2)
local specWarnChargedBonds					= mod:NewSpecialWarningMoveAwayCount(310019, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway:format(310019), nil, 3, 2)
local yellChargedBonds						= mod:NewYell(310019)
--local specWarnDesensitizingSting			= mod:NewSpecialWarningStack(298156, nil, 9, nil, nil, 1, 6)

--mod:AddTimerLine(BOSS)
--Stage 1: Gathering Power
local timerCallEssenceCD					= mod:NewAITimer(15.5, 139040, nil, nil, nil, 1, nil, nil, nil, 1, 4)
----Vita
local timerTerminalStrikeCD					= mod:NewAITimer(5.3, 306734, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerCallCracklingStalkerCD			= mod:NewAITimer(30.1, 306865, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
----Void
local timerNullifyingStrikeCD				= mod:NewAITimer(5.3, 306819, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerCallVoidHunterCD					= mod:NewAITimer(30.1, 306866, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
--Stage 2: Unleashed Wrath
local timerDecimatingStrikeCD				= mod:NewAITimer(5.3, 309858, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)
local timerVoidEruptionCD					= mod:NewAITimer(15.5, 310003, nil, nil, nil, 2)
local timerChargedBondsCD					= mod:NewAITimer(15.5, 310019, nil, nil, nil, 3)
local timerGorgeEssenceCD					= mod:NewAITimer(15.5, 309985, nil, nil, nil, 6)
--local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 306874)
mod:AddInfoFrameOption(306257, true)
mod:AddSetIconOption("SetIconOnUnstableVita", 306257, true, false, {1, 2})
mod:AddSetIconOption("SetIconOnChargedBonds", 310019, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnDraws", 312750)

mod.vb.currentVita = nil
mod.vb.lastHighest = "Unknown"
mod.vb.unstableVoidCount = 0
mod.vb.voidEruptionCount = 0
local playerHasVita = false
local VitaVulnerableTargets = {}
local VoidVulnerableTargets = {}
local consumingVoid = DBM:GetSpellInfo(306645)
local ChargedBondsTargets = {}

local furthestPlayerScanner
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
		else
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
		end
	end
end

local updateInfoFrame
do
	local unstableVita, vitaVuln, voidVuln = DBM:GetSpellInfo(306257), DBM:GetSpellInfo(306279), DBM:GetSpellInfo(306654)
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
		--Vita Tracker
		if mod.vb.currentVita then
			addLine(unstableVita, mod.vb.currentVita)
			addLine(L.Furthest, mod.vb.lastHighest)
		end
		--Vita Vulnerability
		if #VitaVulnerableTargets > 0 then
			addLine("---"..vitaVuln.."---")
			for i=1, #VitaVulnerableTargets do
				local name = VitaVulnerableTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, _, _, _, vitaVulnExpireTime = DBM:UnitDebuff("player", 306279)
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
					local _, _, _, _, _, voidVulnExpireTime = DBM:UnitDebuff("player", 306654)
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

function mod:OnCombatStart(delay)
	self.vb.currentVita = nil
	self.vb.lastHighest = "Unknown"
	self.vb.voidEruptionCount = 0
	playerHasVita = false
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
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 306734 then
		timerTerminalStrikeCD:Start()
		if UnitDetailedThreatSituation("player", "boss1") then--We are highest threat target
			specWarnTerminalStrike:Show(consumingVoid)
			specWarnTerminalStrike:Play("findshelter")
		end
	elseif spellId == 306865 then
		specWarnCallCracklingStalker:Show()
		specWarnCallCracklingStalker:Play("bigmob")
		timerCallCracklingStalkerCD:Start()
	elseif spellId == 306819 then
		timerNullifyingStrikeCD:Start()
	elseif spellId == 306866 then
		specWarnCallVoidHunter:Show()
		specWarnCallVoidHunter:Play("bigmob")
		timerCallVoidHunterCD:Start()
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
		timerTerminalStrikeCD:Start(1)
		timerCallCracklingStalkerCD:Start(1)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(self:IsMythic() and 8 or 6)
		end
	elseif spellId == 306733 then--Void Empowered
		warnVoidPhase:Show()
		self.vb.unstableVoidCount = 0
		timerNullifyingStrikeCD:Start(1)
		timerCallVoidHunterCD:Start(1)
	elseif spellId == 312996 then--Nightmare Empowered
		warnNightmarePhase:Show()
	elseif spellId == 306257 then--Unstable Vita
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
		--[[if amount >= 2 then
			if args:IsPlayer() then
				specWarnSearingArmorStack:Show(amount)
				specWarnSearingArmorStack:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnSearingArmor:Show(args.destName)
					specWarnSearingArmor:Play("tauntboss")
				else
					warnNullifyingStrike:Show(args.destName, amount)
				end
			end
		else--]]
			warnNullifyingStrike:Show(args.destName, amount)
		--end
	elseif spellId == 309860 then
		local amount = args.amount or 1
		--[[if amount >= 2 then
			if args:IsPlayer() then
				specWarnSearingArmorStack:Show(amount)
				specWarnSearingArmorStack:Play("stackhigh")
			else
				--Don't show taunt warning if you're 3 tanking and aren't near the boss (this means you are the add tank)
				--Show taunt warning if you ARE near boss, or if number of alive tanks is less than 3
				if (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then--Can't taunt less you've dropped yours off, period.
					specWarnSearingArmor:Show(args.destName)
					specWarnSearingArmor:Play("tauntboss")
				else
					warnDecimated:Show(args.destName, amount)
				end
			end
		else--]]
			warnDecimated:Show(args.destName, amount)
		--end
	elseif spellId == 309852 then--Ruin
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerDecimatingStrikeCD:Start(2)
		timerVoidEruptionCD:Start(2)
		timerChargedBondsCD:Start(2)
		timerGorgeEssenceCD:Start(2)
	elseif spellId == 310019 or spellId == 310022 then
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

	elseif spellId == 306257 then--Unstable Vita
		self.vb.currentVita = nil
		if args:IsPlayer() then
			playerHasVita = false
			self:Unschedule(furthestPlayerScanner)
			yellUnstableVitaFades:Cancel()
		end
		if self.Options.SetIconOnUnstableVita then
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

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 160663 then--essence-of-nightmare

	elseif cid == 156884 then--essence-of-vita

	elseif cid == 156980 then--essence-of-void

	--elseif cid == 69872 then--crackling-stalker

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 139040 then--Call Essence
		specWarnCallEssence:Show()
		timerCallEssenceCD:Start()
	end
end
