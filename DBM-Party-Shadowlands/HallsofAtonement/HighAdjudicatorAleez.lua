local mod	= DBM:NewMod(2411, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)
mod:SetEncounterID(2403)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 323650",
	"SPELL_AURA_REMOVED 323650",
	"SPELL_CAST_START 323552 323538 323597"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, DBM need to do anything for Vessel of Atonement? Maybe have fixate warning be MoveTo?
local warnSpecralProcession			= mod:NewCastAnnounce(323597, 3)
local warnFixate					= mod:NewTargetAnnounce(323650, 4)

local specWarnFixate				= mod:NewSpecialWarningYou(323650, nil, nil, nil, 3, 2)
local yellFixate					= mod:NewYell(323650)
local specWarnBoltofPower			= mod:NewSpecialWarningInterrupt(323538, false, nil, nil, 1, 2)
local specWarnVolleyofPower			= mod:NewSpecialWarningInterrupt(323552, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerVolleyofPowerCD				= mod:NewCDTimer(13, 323552, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerSpectralProcessionCD			= mod:NewCDTimer(15.8, 323597, nil, nil, nil, 1)

mod:AddNamePlateOption("NPAuraOnFixate", 323650, true)

function mod:OnCombatStart(delay)
	timerVolleyofPowerCD:Start(1-delay)
	timerSpectralProcessionCD:Start(1-delay)
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 323538 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBoltofPower:Show(args.sourceName)
			specWarnBoltofPower:Play("kickcast")
		end
	elseif spellId == 323552 then
		timerVolleyofPowerCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVolleyofPower:Show(args.sourceName)
			specWarnVolleyofPower:Play("kickcast")
		end
	elseif spellId == 323597 then
		warnSpecralProcession:Show()
		timerSpectralProcessionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 323650 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("targetyou")
				yellFixate:Yell()
			end
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 323650 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
