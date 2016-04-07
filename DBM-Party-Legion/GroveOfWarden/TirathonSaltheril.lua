local mod	= DBM:NewMod(1467, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(95885)
mod:SetEncounterID(1815)
mod:DisableESCombatDetection()--Remove if blizz fixes trash firing ENCOUNTER_START
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 191941",
	"SPELL_AURA_REMOVED 191941",
	"SPELL_CAST_START 204151 191823 191941 202913",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, timers possibly. Right now it's up in hair and possibly all health based. No timer matched between multiple pulls
--TODO, GTFO for standing in fire maybe?
local specWarnDarkStrikes			= mod:NewSpecialWarningDefensive(204151, "Tank", nil, nil, 3, 2)
local specWarnFuriousBlast			= mod:NewSpecialWarningInterrupt(191823, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelMortar				= mod:NewSpecialWarningDodge(202913, nil, nil, nil, 2, 2)

local timerDarkStrikes				= mod:NewBuffActiveTimer(11, 191941, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--tooltip says 15 but every log was 10-11

local voiceDarkStrikes				= mod:NewVoice(204151, "Tank")--defensive
local voiceFuriousBlast				= mod:NewVoice(191823, "HasInterrupt")--kickcast
local voiceFelMortar				= mod:NewVoice(202913)--watchstep

function mod:OnCombatStart(delay)

end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 191941 then
		timerDarkStrikes:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 191941 then
		timerDarkStrikes:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if (spellId == 204151 or spellId == 191941) and self:AntiSpam(3, 1) then--Why two Ids?
		specWarnDarkStrikes:Show()
		voiceDarkStrikes:Play("defensive")
	elseif spellId == 191823 then
		specWarnFuriousBlast:Show(args.sourceName)
		voiceFuriousBlast:Play("kickcast")
	elseif spellId == 202913 then
		specWarnFelMortar:Show()
		voiceFelMortar:Play("watchstep")
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153616 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then

	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153500 then

	end
end
--]]