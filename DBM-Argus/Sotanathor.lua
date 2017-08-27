local mod	= DBM:NewMod(2014, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124555)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247698 247410",
	"SPELL_CAST_SUCCESS 247437",
	"SPELL_AURA_APPLIED 247444 247437",
--	"SPELL_AURA_REMOVED 247437",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--More than one stack of 247444?
--TODO, see if Cavitation is in combat log. It wasn't on zakuun so assume this copy and paste is literal copy and paste on their end
local warnSeedofDestruction		= mod:NewTargetAnnounce(247437, 4)

local specSilence				= mod:NewSpecialWarningSpell(247698, nil, nil, nil, 2, 2)
local specWarnSoulCleave		= mod:NewSpecialWarningSpell(247410, "Melee", nil, nil, 1, 5)
local specWarnClovenSoul		= mod:NewSpecialWarningTaunt(247444, nil, nil, nil, 1, 5)

local specWarnWakeofDestruction	= mod:NewSpecialWarningSpell(247432, nil, nil, nil, 2, 2)--Used for both warnings that trigger it
local specWarnSeedofDestruction	= mod:NewSpecialWarningYou(247437, nil, nil, nil, 3, 4)
local yellSeedsofDestruction	= mod:NewYell(247437)

local timerSilenceCD			= mod:NewAITimer(13.4, 247698, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerSoulCleaveCD			= mod:NewAITimer(40, 247410, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCavitationCD			= mod:NewAITimer(40, 181461, nil, nil, nil, 2)
local timerSeedsofDestructionCD	= mod:NewAITimer(14.5, 247437, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

local voiceSilence				= mod:NewVoice(247698)--specialsoon for now, silencesoon later
local voiceSoulCleave			= mod:NewVoice(247410, "Melee")--179406 (soul cleave)
local voiceClovenSoul			= mod:NewVoice(247444)--tauntboss
local voiceWakeofDestruction	= mod:NewVoice(247432)--watchwave
local voiceSeedsofDestruction	= mod:NewVoice(247437)--Runout

--mod:AddReadyCheckOption(43193, false)
--mod:AddRangeFrameOption(10, 217877)

local function warnWake(self)
	if self:AntiSpam(3, 1) then
		specWarnWakeofDestruction:Show()
		voiceWakeofDestruction:Play("watchwave")
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247698 then
		specSilence:Show()
		voiceSilence:Play("specialsoon")
		timerSilenceCD:Start()
	elseif spellId == 247410 then
		specWarnSoulCleave:Show()
		voiceSoulCleave:Play("179406")
		timerSoulCleaveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247437 then
		timerSeedsofDestructionCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247444 then
		if not args:IsPlayer() and not UnitDebuff("player", args.spellName) then
			specWarnClovenSoul:Show(args.destName)
			voiceClovenSoul:Play("tauntboss")
		end
	elseif spellId == 247437 then
		warnSeedofDestruction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSeedofDestruction:Show()
			voiceSeedsofDestruction:Play("runout")
			yellSeedsofDestruction:Yell()
		end
		if self:AntiSpam(5, 2) then
			self:Schedule(3.5, warnWake, self)
		end
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 247437 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 217907 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 247415 and self:AntiSpam(3, 3) then--Sometimes does NOT show in combat log, this is only accurate way
		if self:AntiSpam(5, 2) then
			warnWake(self)
		end
		timerCavitationCD:Start()
	end
end
