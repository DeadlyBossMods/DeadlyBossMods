local mod	= DBM:NewMod(1291, "DBM-Draenor", nil, 557)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(81252)
mod:SetReCombatTime(20)
mod:SetZone()
mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 175791",
	"SPELL_AURA_APPLIED 175827"
)

--Gigasmash not in combatlog. Has unit event but spammed pretty often anyways, not worth having, especially with target requirement for it to work.
local warnColossalSlam			= mod:NewSpellAnnounce(175791, 4)--No target scanning. target is either nil or tank.
local warnCallofEarth			= mod:NewSpellAnnounce(175827, 2)

local specWarnColossalSlam		= mod:NewSpecialWarningSpell(175791, nil, nil, nil, 2)
local specWarnCallofEarth		= mod:NewSpecialWarningSpell(175827)

local timerColossalSlamCD		= mod:NewCDTimer(16, 175791)--16-35 second variation? Then again was a bad pull with no tank, boss running loose so may have affected timer
local timerCallofEarthCD		= mod:NewCDTimer(90, 175827)

local voiceColossalSlam			= mod:NewVoice(175791)

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
--[[	if yellTriggered then

	end--]]
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 175791 then
		warnColossalSlam:Show()
		specWarnColossalSlam:Show()
		timerColossalSlamCD:Start()
		voiceColossalSlam:Play("shockwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 175827 then
		warnCallofEarth:Show()
		specWarnCallofEarth:Show()
		timerCallofEarthCD:Start()
	end
end
