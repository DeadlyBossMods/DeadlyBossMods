local mod	= DBM:NewMod(1702, "DBM-Party-Legion", 9, 777)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102431)
mod:SetEncounterID(1855)
mod:SetZone()

mod.imaspecialsnowflake = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 202779 202792 202804",
	"SPELL_AURA_REMOVED 202792",
	"SPELL_CAST_START 203381"
)

--TODO: Maybe GTFO for blood puddles
--TODO, voice warnings for the feeding. maybe some were made for original lana fight in wrath? Doubt it, VEM came in cata/mists
local warnEssenceoftheBloodQueen	= mod:NewTargetAnnounce(202779, 2)
local warnBloodthirst				= mod:NewTargetAnnounce(202792, 3)
local warnMindControlled			= mod:NewTargetAnnounce(202804, 4)
local warnCallBlood					= mod:NewSpellAnnounce(203381, 2)

local specWarnEssenceoftheBloodQueen= mod:NewSpecialWarningYou(202779)
local specWarnBloodthirst			= mod:NewSpecialWarningYou(202792, nil, nil, nil, 3)
local yellBloodThirst				= mod:NewFadesYell(202792)

local timerHunger					= mod:NewBuffFadesTimer(20, 202792, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerBloodCallCD				= mod:NewNextTimer(30, 203381, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)

--local voiceCurtainOfFlame			= mod:NewVoice(153392)

function mod:OnCombatStart(delay)
	if not self:IsNormal() then
		timerBloodCallCD:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203381 then
		warnCallBlood:Show()
		timerBloodCallCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 202779 then
		if args:IsPlayer() then
			specWarnEssenceoftheBloodQueen:Show()
		else
			warnEssenceoftheBloodQueen:Show(args.destName)
		end
	elseif spellId == 202792 then
		if args:IsPlayer() then
			specWarnBloodthirst:Show()
			timerHunger:Start()
			yellBloodThirst:Schedule(9, 1)
			yellBloodThirst:Schedule(8, 2)
			yellBloodThirst:Schedule(7, 3)
			yellBloodThirst:Schedule(5, 5)
		else
			warnBloodthirst:Show(args.destName)
		end
	elseif spellId == 202804 then
		warnMindControlled:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 202792 and args:IsPlayer() then
		timerHunger:Cancel()
		yellBloodThirst:Cancel()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153616 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then

	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153500 then

	end
end
--]]