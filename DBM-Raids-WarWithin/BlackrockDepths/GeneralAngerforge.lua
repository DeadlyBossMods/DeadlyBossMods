if DBM:GetTOC() < 110005 then return end
local mod	= DBM:NewMod(2668, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "lfr,normal,heroic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226316)
mod:SetEncounterID(3045)
--mod:SetUsedIcons(8, 7, 6)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 466107 466265 467415 464417 467464 466096 466086 466111 467505",
	"SPELL_CAST_SUCCESS 466254 467424",
	"SPELL_SUMMON 469955 467755 467622",
	"SPELL_AURA_APPLIED 464426 466107 464417 467607 466111 466258 467424",
	"SPELL_AURA_APPLIED_DOSE 466107",
	"SPELL_AURA_REMOVED 464426 464413 466234 466258",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, adjust frequency of tank stack alert?
--TODO, do boss timers start on engage or only phase 2 when shields go down
--TODO, use generic mole machine message instead? right now it's split into two sub warnings for add types coming out of them instead
--TODO, auto mark sappers or rogues?
--TODO, how many stacks for Crippling Dispel?
--TODO, verify timer type for artillery barrage as a nameplate and not envinronmental
--TODO, figure out right firing line event
--General Angerforge
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30828))
local warnShatterArmor						= mod:NewStackAnnounce(466107, 3)
local warnDarkIronBombs						= mod:NewSpellAnnounce(466265, 2)
local warnRogue								= mod:NewSpellAnnounce(-30832, 2, 469955)
local warnSapper							= mod:NewSpellAnnounce(-30833, 2, 467755)

local specWarnFireburstGrenade				= mod:NewSpecialWarningMoveTo(467415, nil, nil, nil, 1, 12)
--local yellHoneyMarinade					= mod:NewShortYell(438025)
--local yellHoneyMarinadeFades				= mod:NewShortFadesYell(438025)

local timerShatterArmorCD					= mod:NewAITimer(33, 466107, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK)--Boss version
local timerDarkIronBombsCD					= mod:NewAITimer(33, 466265, nil, nil, nil, 3)
local timerFireburstGrenadeCD				= mod:NewAITimer(33, 467415, nil, nil, nil, 3)

mod:AddNamePlateOption("NPOnCommandingAura", 464426)
--Harbinger of Flames
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30835))
--local warnWorldinFlames						= mod:NewAddsLeftAnnounce(464413, 2)
--Shadowforge Flame Keeper
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30836))
local warnTorchDropped						= mod:NewCountAnnounce(467607, 1)
local warnTorchCarried						= mod:NewTargetNoFilterAnnounce(467607, 2)

local specWarnKeepersFlameDispel			= mod:NewSpecialWarningDispel(464417, "RemoveMagic", nil, nil, 1, 2)
local specWarnRingsOfFire					= mod:NewSpecialWarningDodge(467464, nil, nil, nil, 2, 2)

--local timerKeepersFlameCD					= mod:NewCDPNPTimer(33, 464417, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
--local timerRingsOfFireCD					= mod:NewCDPNPTimer(33, 467464, nil, nil, nil, 3)

--mod:AddSetIconOption("SetIconOnBees", 438025, true, 5, {8, 7, 6})
--Anvilrage Officer
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30831))

--local timerShatterArmorCDNP				= mod:NewCDNPTimer(33, 466107, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK)--Add version
--Anvilrage Medic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30830))

local specWarnHeal							= mod:NewSpecialWarningInterruptCount(466096, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindBlast						= mod:NewSpecialWarningInterrupt(466086, "HasInterrupt", nil, nil, 1, 2)

--local timerHealCD							= mod:NewCDPNPTimer(33, 466096, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--local timerMindBlastCD					= mod:NewCDNPTimer(33, 466086, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--Anvilrage Rogue
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30832))
local warnStealthRemoved					= mod:NewFadesAnnounce(466234, 3)
local warnShadowstep						= mod:NewSpellAnnounce(466254, 2, nil, false)
local warnFixate							= mod:NewTargetAnnounce(466258, 2)

local specWarnCripplingDispel				= mod:NewSpecialWarningDispel(466111, "RemovePoison", nil, nil, 1, 2)
local specWarnFixate						= mod:NewSpecialWarningYou(466258, nil, nil, nil, 1, 2)

--local timerCripplingPoisonCD				= mod:NewCDNPTimer(33, 466111, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON)
--local timerShadowstepCD					= mod:NewCDNPTimer(33, 466254, nil, nil, nil, 3)

mod:AddNamePlateOption("NPOnFixate", 466258)
--Anvilrage Artillerist
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30777))
local warnArtilleryBarrage					= mod:NewSpellAnnounce(467424, 2)
local warnMortar							= mod:NewSpellAnnounce(467505, 2)

--local timerArtilleryBarrageCD				= mod:NewCDNPTimer(33, 467424, nil, nil, nil, 3)
--local timerMortarCD						= mod:NewCDNPTimer(33, 467505, nil, nil, nil, 3)
--Anvilrage Dragoon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30829))
local specWarnFiringLine					= mod:NewSpecialWarningDodge(467424, nil, nil, nil, 2, 2)

--local timerFiringLineCD					= mod:NewCDNPTimer(33, 467424, nil, nil, nil, 3)

local castsPerGUID = {}
--mod.vb.FlamesRemaining = 3
mod.vb.torchesDropped = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
--	self.vb.FlamesRemaining = 3
	self.vb.torchesDropped = 0
	self:SetStage(1)
	--Start boss timers that start here if applicable
	if self.Options.NPOnCommandingAura or self.Options.NPOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPOnCommandingAura or self.Options.NPOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 466107 then
		if args:GetSrcCreatureID() == 226316 then--Boss
			timerShatterArmorCD:Start(nil, args.sourceGUID)
		else--Adds
			--timerShatterArmorCDNP:Start(nil, args.sourceGUID)
		end
	elseif spellId == 466265 then
		warnDarkIronBombs:Show()
		timerDarkIronBombsCD:Start()
	elseif spellId == 467415 then
		specWarnFireburstGrenade:Show(DBM_COMMON_L.BREAK_LOS)
		specWarnFireburstGrenade:Play("breaklos")
		timerFireburstGrenadeCD:Start()
	elseif spellId == 464417 then
		--timerKeepersFlameCD:Start(nil, args.sourceGUID)
	elseif spellId == 467464 then
		specWarnRingsOfFire:Show()
		specWarnRingsOfFire:Play("watchstep")
		--timerRingsOfFireCD:Start(nil, args.sourceGUID)
	elseif spellId == 466096 then
		--timerHealCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnHeal:Show(args.sourceName, count)
			if count < 6 then
				specWarnHeal:Play("kick"..count.."r")
			else
				specWarnHeal:Play("kickcast")
			end
		end
	elseif spellId == 466086 then
		--timerMindBlastCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnMindBlast:Show(args.sourceName)
			specWarnMindBlast:Play("kickcast")
		end
	elseif spellId == 466111 then
--		timerCripplingPoisonCD:Start(nil, args.sourceGUID)
	elseif spellId == 467505 then
		warnMortar:Show()
		--timerMortarCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 466254 then
		warnShadowstep:Show()
		--timerShadowstepCD:Start(nil, args.sourceGUID)
	elseif spellId == 467424 then
		warnArtilleryBarrage:Show()
		--timerArtilleryBarrageCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 469955 then
		warnRogue:Show()
	elseif spellId == 467755 then
		warnSapper:Show()
	elseif spellId == 467622 then
		self.vb.torchesDropped = self.vb.torchesDropped + 1
		warnTorchDropped:Show(self.vb.torchesDropped)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 464426 then
		if self.Options.NPOnCommandingAura then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 466107 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnShatterArmor:Show(args.destName, amount)
		end
	elseif spellId == 464417 and self:CheckDispelFilter("magic") then
		specWarnKeepersFlameDispel:Show(args.destName)
		specWarnKeepersFlameDispel:Play("dispelboss")
	elseif spellId == 467607 then
		warnTorchCarried:Show(args.destName)
	elseif spellId == 466111 and self:CheckDispelFilter("poison") then
		specWarnCripplingDispel:Show(args.destName)
		specWarnCripplingDispel:Play("helpdispel")
	elseif spellId == 466258 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
			if self.Options.NPOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 467424 and self:AntiSpam(10, 1) then
		specWarnFiringLine:Show()
		specWarnFiringLine:Play("farfromline")
		--timerFiringLineCD:Start(nil, args.destGUID)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 464426 then
		if self.Options.NPOnCommandingAura then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 464413 then
		DBM:Debug("World in Flames Removed and logged")
		--self.vb.FlamesRemaining = self.vb.FlamesRemaining - 1
		--warnWorldinFlames:Show(self.vb.FlamesRemaining)
	elseif spellId == 466234 then
		warnStealthRemoved:Show()
	elseif spellId == 466258 then
		if args:IsPlayer() then
			if self.Options.NPOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 440141 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 231554 then--Shadowforge Flame Keeper
		--timerKeepersFlameCD:Stop(args.destGUID)
		--timerRingsOfFireCD:Stop(args.destGUID)
	elseif cid == 231555 or cid == 232247 then--Anvilrage Officer
		--timerShatterArmorCDNP:Stop(args.destGUID)
	elseif cid == 232246 or cid == 231561 then--Anvilrage Medic
		castsPerGUID[args.sourceGUID] = nil
		--timerHealCD:Stop(args.destGUID)
		--timerMindBlastCD:Stop(args.destGUID)
	elseif cid == 231563 or cid == 232252 then--Anvilrage Rogue
		--timerCripplingPoisonCD:Stop(args.destGUID)
		--timerShadowstepCD:Stop(args.destGUID)
	elseif cid == 232244 or cid == 233208 or cid == 231565 then--Anvilrage Artillerist
		--timerArtilleryBarrageCD:Stop(args.destGUID)
		--timerMortarCD:Stop(args.destGUID)
	elseif cid == 232245 or cid == 231562 or cid == 233205 then--Anvilrage Dragoon
		--timerFiringLineCD:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
