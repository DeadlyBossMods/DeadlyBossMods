local mod	= DBM:NewMod(1836, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114462)
mod:SetEncounterID(1964)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 227267",
	"SPELL_AURA_APPLIED 227254",
	"SPELL_AURA_REMOVED 227254",
	"SPELL_PERIODIC_DAMAGE 227465",
	"SPELL_PERIODIC_MISSED 227465"
)

--TODO, figure out which one is cast ID for discharge and whether it needs a timer/announce or not
--TODO, assess other needs
local warnAdds						= mod:NewSpellAnnounce(227267, 2)--if not cast too often make special warning?
local warnEvo						= mod:NewSpellAnnounce(227254, 1)
local warnEvoOver					= mod:NewEndAnnounce(227254, 2)

local specWarnPowerDischarge		= mod:NewSpecialWarningMove(227465, nil, nil, nil, 1, 2)

local timerSummonAddCD				= mod:NewAITimer(40, 227267, nil, nil, nil, 1)
local timerEvoCD					= mod:NewAITimer(40, 227254, nil, nil, nil, 6)
local timerEvo						= mod:NewBuffActiveTimer(20, 227254, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)

local voicePowerDischarge			= mod:NewVoice(227465)--runaway

function mod:OnCombatStart(delay)
	timerSummonAddCD:Start(1-delay)
	timerEvoCD:Start(1-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 227267 then
		warnAdds:Show()
		timerSummonAddCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227254 then
		timerSummonAddCD:Stop()
		warnEvo:Show()
		timerEvo:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227254 then
		warnEvoOver:Show()
		timerSummonAddCD:Start(2)
		timerEvoCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227465 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnPowerDischarge:Show()
		voicePowerDischarge:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 103695 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 206341 then
	
	end
end
--]]
