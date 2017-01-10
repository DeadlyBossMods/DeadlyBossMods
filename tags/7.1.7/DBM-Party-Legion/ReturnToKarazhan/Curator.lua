local mod	= DBM:NewMod(1836, "DBM-Party-Legion", 11, 860)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(114462)
mod:SetEncounterID(1964)
mod:SetZone()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(14922)
--mod.respawnTime = 30

mod.noNormal = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 234416",
	"SPELL_AURA_APPLIED 227254",
	"SPELL_AURA_REMOVED 227254",
	"SPELL_PERIODIC_DAMAGE 227465",
	"SPELL_PERIODIC_MISSED 227465",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnAdds						= mod:NewSpellAnnounce(227267, 2)--if not cast too often make special warning?
local warnEvo						= mod:NewSpellAnnounce(227254, 1)
local warnEvoOver					= mod:NewEndAnnounce(227254, 2)

local specWarnPowerDischarge		= mod:NewSpecialWarningMove(227465, nil, nil, nil, 1, 2)

local timerSummonAddCD				= mod:NewNextTimer(9.7, 227267, nil, nil, nil, 1)
local timerPowerDischargeCD			= mod:NewCDTimer(12.2, 227279, nil, nil, nil, 3)
local timerEvoCD					= mod:NewNextTimer(70, 227254, nil, nil, nil, 6)
local timerEvo						= mod:NewBuffActiveTimer(20, 227254, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(300)

local countdownEvo					= mod:NewCountdown(70, 227254)

local voicePowerDischarge			= mod:NewVoice(227465)--runaway

function mod:OnCombatStart(delay)
	timerSummonAddCD:Start(6-delay)
	timerPowerDischargeCD:Start(13.5)
	timerEvoCD:Start(68-delay)
	countdownEvo:Start(68)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 234416 then
		warnAdds:Show()
		timerSummonAddCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 227254 then
		timerSummonAddCD:Stop()
		timerPowerDischargeCD:Stop()
		warnEvo:Show()
		timerEvo:Start()
		countdownEvo:Start(20)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 227254 then
		warnEvoOver:Show()
		timerEvoCD:Start()
		countdownEvo:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 227465 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnPowerDischarge:Show()
		voicePowerDischarge:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227278 then
		timerPowerDischargeCD:Start()
	end
end

