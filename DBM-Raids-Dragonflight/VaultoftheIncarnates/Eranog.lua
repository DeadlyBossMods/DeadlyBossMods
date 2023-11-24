local mod	= DBM:NewMod(2480, "DBM-Raids-Dragonflight", 3, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(184972)
mod:SetEncounterID(2587)
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20221215000000)
mod:SetMinSyncRevision(20221215000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 370307 390715 394917 370615 396023 396040",
	"SPELL_CAST_SUCCESS 394917 396022",
	"SPELL_AURA_APPLIED 370597 371562 390715 394906 396094",
	"SPELL_AURA_APPLIED_DOSE 394906",
	"SPELL_AURA_REMOVED 370597 371562 390715 396094 370307",
	"SPELL_PERIODIC_DAMAGE 370648",
	"SPELL_PERIODIC_MISSED 370648",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 370307 or ability.id = 390715 or ability.id = 394917 or ability.id = 370615 or ability.id = 396023) and type = "begincast"
 or (ability.id = 396022 or ability.id = 394917) and type = "cast"
 or ability.id = 370307 and type = "removebuff"
 or ability.id = 390715 and type = "applydebuff"
--]]
--Stage One: Army of Talon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnFlamerift								= mod:NewTargetNoFilterAnnounce(390715, 2)
local warnBurningWound							= mod:NewStackAnnounce(394906, 2, nil, "Tank|Healer")

local specWarnFlamerift							= mod:NewSpecialWarningMoveAway(390715, nil, nil, nil, 1, 2)
local yellFlamerift								= mod:NewShortYell(390715)
local yellFlameriftFades						= mod:NewShortFadesYell(390715)
local specWarnGreaterFlamerift					= mod:NewSpecialWarningTaunt(396094, nil, nil, nil, 1, 2)
local specWarnMoltenCleave						= mod:NewSpecialWarningDodgeCount(370615, nil, nil, nil, 2, 2)
local specWarnBurningWound						= mod:NewSpecialWarningStack(394906, nil, 6, nil, nil, 1, 6)
local specWarnBurningWoundTaunt					= mod:NewSpecialWarningTaunt(394906, false, nil, 2, 1, 2)
local specWarnIncineratingRoar					= mod:NewSpecialWarningCount(396023, nil, nil, nil, 2, 2)
local specWarnMoltenSpikes						= mod:NewSpecialWarningDodgeCount(396022, nil, nil, nil, 2, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerMoltenCleaveCD						= mod:NewCDCountTimer(29.9, 370615, nil, nil, nil, 3)
local timerFlameriftCD							= mod:NewCDCountTimer(28.9, 390715, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerIncineratingRoarCD					= mod:NewCDCountTimer(23.9, 396023, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerMoltenSpikesCD						= mod:NewCDCountTimer(21.4, 396022, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
mod:GroupSpells(390715, 396094)
---Frenzied Tarasek
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26005))
local warnKillOrder								= mod:NewTargetAnnounce(370597, 3)

local specWarnKillOrder							= mod:NewSpecialWarningYou(370597, nil, nil, nil, 1, 2)

mod:AddNamePlateOption("NPAuraOnKillOrder", 370597, true)
mod:AddNamePlateOption("NPAuraOnRampage", 371562, true)
--Flamescale Captain (Mythic)
mod:AddTimerLine(DBM:GetSpellInfo(396039))
local warnLeapingFlames							= mod:NewSpellAnnounce(394917, 3)

local specWarnPyroBlast							= mod:NewSpecialWarningInterruptCount(396040, "HasInterrupt", nil, nil, 1, 2)

local timerLeapingFlamesCD						= mod:NewCDTimer(30.2, 394917, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)

mod:AddSetIconOption("SetIconOnCaptain", 396039, true, 5, {8})
--Stage Two: Army of Flame
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26004))
local specWarnCollapsingArmy					= mod:NewSpecialWarningCount(370307, nil, nil, nil, 3, 2)

local timerCollapsingArmyCD						= mod:NewCDCountTimer(94, 370307, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod.vb.armyCount = 0
mod.vb.cleaveCount = 0
mod.vb.riftCount = 0
mod.vb.roarCount = 0
mod.vb.spikesCount = 0
local castsPerGUID = {}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.armyCount = 0
	self.vb.cleaveCount = 0
	self.vb.riftCount = 0
	self.vb.roarCount = 0
	self.vb.spikesCount = 0
	timerIncineratingRoarCD:Start(9.8-delay, 1)
	timerFlameriftCD:Start(13.9-delay, 1)
	timerMoltenCleaveCD:Start(37.9-delay, 1)
	if self:IsHard() then
		timerMoltenSpikesCD:Start(21.8-delay, 1)
	end
	timerCollapsingArmyCD:Start(91.7-delay, 1)
	if self.Options.NPAuraOnKillOrder or self.Options.NPAuraOnRampage then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnKillOrder or self.Options.NPAuraOnRampage then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 370307 then
		self.vb.armyCount = self.vb.armyCount + 1
		specWarnCollapsingArmy:Show(self.vb.armyCount)
		specWarnCollapsingArmy:Play("specialsoon")
		timerFlameriftCD:Stop()
		timerMoltenCleaveCD:Stop()
		timerIncineratingRoarCD:Stop()
		timerMoltenSpikesCD:Stop()
	elseif spellId == 390715 then
		self.vb.riftCount = self.vb.riftCount + 1
		if self.vb.riftCount < 3 then--Cast 3x per rotation
			timerFlameriftCD:Start(nil, self.vb.riftCount+1)
		end
	elseif spellId == 394917 then
		warnLeapingFlames:Show()
	elseif spellId == 370615 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		specWarnMoltenCleave:Show(self.vb.cleaveCount)
		specWarnMoltenCleave:Play("shockwave")
		if self.vb.cleaveCount == 1 then--Only 2x per rotation
			timerMoltenCleaveCD:Start(nil, 2)
		end
	elseif spellId == 396023 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnIncineratingRoar:Show(self.vb.roarCount)
		specWarnIncineratingRoar:Play("aesoon")
		if self.vb.roarCount < 4 then--4 per rotation
			timerIncineratingRoarCD:Start(nil, self.vb.roarCount+1)
		end
	elseif spellId == 396040 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnCaptain then
				self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnCaptain")
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnPyroBlast:Show(args.sourceName, count)
			if count < 6 then
				specWarnPyroBlast:Play("kick"..count.."r")
			else
				specWarnPyroBlast:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then--success used to start timer and update count due to stutter step recasts
		timerLeapingFlamesCD:Start(nil, args.sourceGUID)
	elseif spellId == 396022 then
		self.vb.spikesCount = self.vb.spikesCount + 1
		specWarnMoltenSpikes:Show(self.vb.spikesCount)
		specWarnMoltenSpikes:Play(self.vb.spikesCount)
		if self.vb.spikesCount < 3 then
			timerMoltenSpikesCD:Start(nil, self.vb.spikesCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 370597 then
		warnKillOrder:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnKillOrder:Show()
			specWarnKillOrder:Play("targetyou")
			if self.Options.NPAuraOnKillOrder then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 390715 or spellId == 396094 then
		if args:IsPlayer() then
			specWarnFlamerift:Show()
			specWarnFlamerift:Play("range5")
			yellFlamerift:Yell()
			yellFlameriftFades:Countdown(spellId)
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnGreaterFlamerift:Show(args.destName)
				specWarnGreaterFlamerift:Play("tauntboss")
			end
		end
		warnFlamerift:CombinedShow(0.5, args.destName)
	elseif spellId == 394906 then
		local amount = args.amount or 1
		if amount >= 3 and self:AntiSpam(3, 1) then
			if amount >= 6 then
				if args:IsPlayer() then
					specWarnBurningWound:Show(amount)
					specWarnBurningWound:Play("stackhigh")
				else
					if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
						specWarnBurningWoundTaunt:Show(args.destName)
						specWarnBurningWoundTaunt:Play("tauntboss")
					else
						warnBurningWound:Show(args.destName, amount)
					end
				end
			else
				warnBurningWound:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 370597 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnKillOrder then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 371562 then
		if self.Options.NPAuraOnRampage then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 390715 or spellId == 396094 then
		if args:IsPlayer() then
			yellFlameriftFades:Cancel()
		end
	elseif spellId == 370307 then--Army ending
		self.vb.roarCount = 0
		self.vb.cleaveCount = 0
		self.vb.riftCount = 0
		self.vb.spikesCount = 0
		timerIncineratingRoarCD:Start(10, 1)
		timerFlameriftCD:Start(13.9, 1)
		timerMoltenCleaveCD:Start(38, 1)
		if self:IsHard() then
			timerMoltenSpikesCD:Start(22, 1)
		end
		timerCollapsingArmyCD:Start(93, self.vb.armyCount+1)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then--Flamescale Captain
		castsPerGUID[args.destGUID] = nil
		timerLeapingFlamesCD:Stop(args.destGUID)
	end
end
