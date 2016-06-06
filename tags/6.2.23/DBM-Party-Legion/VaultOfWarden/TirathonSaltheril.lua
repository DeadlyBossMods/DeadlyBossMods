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
	"SPELL_DAMAGE 202919",
	"SPELL_MISSED 202919"
)

--TODO, timers possibly. Right now it's up in hair and possibly all health based. No timer matched between multiple pulls
--[[
			["SPELL_CAST_START"] = {
				["197250-Turn Kick"] = "pull:8.8, 35.2, 24.3, 24.3",
				["197251-Knockdown Kick"] = "pull:8.3, 35.3, 24.1, 24.3",
				["213583-Deepening Shadows"] = "pull:10.7, 35.2, 31.5",
				["206459-Shadow Strike"] = "pull:21.6, 1.1, 0.7, 1.7",
			},
--]]
local specWarnDarkStrikes			= mod:NewSpecialWarningDefensive(204151, "Tank", nil, nil, 3, 2)
local specWarnFuriousBlast			= mod:NewSpecialWarningInterrupt(191823, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelMortar				= mod:NewSpecialWarningDodge(202913, nil, nil, nil, 2, 2)
local specWarnFelMortarGTFO			= mod:NewSpecialWarningMove(202919, nil, nil, nil, 1, 2)

local timerDarkStrikes				= mod:NewBuffActiveTimer(11, 191941, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--tooltip says 15 but every log was 10-11

local voiceDarkStrikes				= mod:NewVoice(204151, "Tank")--defensive
local voiceFuriousBlast				= mod:NewVoice(191823, "HasInterrupt")--kickcast
local voiceFelMortar				= mod:NewVoice(202913)--watchstep
local voiceFelMortarGTFO			= mod:NewVoice(202919)--runaway

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

do
	local playerGUID = UnitGUID("player")
	function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
		if spellId == 202919 and destGUID == playerGUID and self:AntiSpam(2, 2) then
			specWarnFelMortarGTFO:Show()
			voiceFelMortarGTFO:Play("runaway")
		end
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE
end
