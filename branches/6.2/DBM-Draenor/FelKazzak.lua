--local mod	= DBM:NewMod(1234, "DBM-Draenor", nil, 557)--Not yet in journal, needs journalID in whatever build they add his ID in
local mod	= DBM:NewMod("FelKazzak", "DBM-Draenor")--Temp
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 13152 $"):sub(12, -3))
mod:SetCreatureID(94015)
mod:SetEncounterID(1801)
mod:SetReCombatTime(20)
mod:SetZone()

mod:RegisterCombat("combat")--no yell
--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_ABSORBED"
)

local warnSavageVines				= mod:NewTargetAnnounce(176004, 2)

local specWarnSavageVines			= mod:NewSpecialWarningYou(176004)
local yellSavageVines				= mod:NewYell(176004)

local timerGrowUntamedMandragoraCD	= mod:NewCDTimer(30, 176013)

local voiceColossalBlow				= mod:NewVoice(175973)

--mod:AddReadyCheckOption(37462, false)
--mod:AddRangeFrameOption(8, 175979)

local UnitDebuff = UnitDebuff
local debuffName = GetSpellInfo(176004)
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, debuffName)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then

--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175973 then
		specWarnColossalBlow:Show()
		--timerColossalBlow:Start()
		voiceColossalBlow:Play("shockwave")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 176013 then
		specWarnGrowUntamedMandragora:Show()
		timerGrowUntamedMandragoraCD:Start()
		voiceMandragora:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 176004 then
		local targetName = args.destName
		warnSavageVines:CombinedShow(0.5, targetName)
		if args:IsPlayer() then
			specWarnSavageVines:Show()
			yellSavageVines:Yell()
		else
			if self:CheckNearby(8, targetName) then
				specWarnSavageVinesNear:Show(targetName)
			end
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", debuffName) then
				DBM.RangeCheck:Show(8, nil)
			else
				DBM.RangeCheck:Show(8, debuffFilter, nil, nil, nil, 8)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID)-- only listen personal Noxious Spit event
	if destGUID ~= UnitGUID("player") then return end
	if self:AntiSpam(2, 1) then
		specWarnNoxiousSpit:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]