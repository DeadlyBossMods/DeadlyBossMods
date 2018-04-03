local mod	= DBM:NewMod(2014, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124555)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247698 247410",
	"SPELL_CAST_SUCCESS 247437 124555",
	"SPELL_AURA_APPLIED 247444 247437"
)

local warnSeedofDestruction		= mod:NewTargetAnnounce(247437, 4)

local specSilence				= mod:NewSpecialWarningSpell(247698, nil, nil, nil, 2, 2)
local specWarnSoulCleave		= mod:NewSpecialWarningSpell(247410, "Melee", nil, nil, 1, 5)
local specWarnClovenSoul		= mod:NewSpecialWarningTaunt(247444, nil, nil, nil, 1, 5)

local specWarnWakeofDestruction	= mod:NewSpecialWarningSpell(247432, nil, nil, nil, 2, 2)--Used for both warnings that trigger it
local specWarnSeedofDestruction	= mod:NewSpecialWarningYou(247437, nil, nil, nil, 3, 4)
local yellSeedsofDestruction	= mod:NewYell(247437)

local timerSilenceCD			= mod:NewCDTimer(24.4, 247698, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerSoulCleaveCD			= mod:NewCDTimer(25.5, 247410, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerCavitationCD			= mod:NewCDTimer(26.7, 181461, nil, nil, nil, 2)
local timerSeedsofDestructionCD	= mod:NewCDTimer(17.0, 247437, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)

mod:AddReadyCheckOption(49197, false)

local function warnWake(self)
	if self:AntiSpam(3, 1) then
		specWarnWakeofDestruction:Show()
		specWarnWakeofDestruction:Play("watchwave")
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247698 then
		specSilence:Show()
		specSilence:Play("specialsoon")
		timerSilenceCD:Start()
	elseif spellId == 247410 then
		specWarnSoulCleave:Show()
		specWarnSoulCleave:Play("179406")
		timerSoulCleaveCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247437 then
		timerSeedsofDestructionCD:Start()
	elseif spellId == 124555 then
		if self:AntiSpam(5, 2) then
			warnWake(self)
		end
		timerCavitationCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247444 then
		if not args:IsPlayer() and not UnitDebuff("player", args.spellName) then
			specWarnClovenSoul:Show(args.destName)
			specWarnSoulCleave:Play("tauntboss")
		end
	elseif spellId == 247437 then
		warnSeedofDestruction:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSeedofDestruction:Show()
			specWarnSeedofDestruction:Play("runout")
			yellSeedsofDestruction:Yell()
		end
		if self:AntiSpam(5, 2) then
			self:Schedule(3.5, warnWake, self)
		end
	end
end
