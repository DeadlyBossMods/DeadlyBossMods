local mod	= DBM:NewMod(2109, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(139904)
mod:SetEncounterID(2105)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 256493",
	"SPELL_AURA_APPLIED_DOSE 256493",
	"SPELL_AURA_REFRESH 256493",
	"SPELL_CAST_START 262347 269493 257337 271784 271903"
)

--Change Static Pulse to dodge warning if it's dodgable by all parties
--New voice, "Gather Item"?
local warnFootbombLauncher			= mod:NewSpellAnnounce(269493, 2)
local warnCoinMagnet				= mod:NewSpellAnnounce(271903, 2)

local specWarnStaticPulse			= mod:NewSpecialWarningSpell(262347, nil, nil, nil, 2, 2)
local specWarnShockingClaw			= mod:NewSpecialWarningDodge(257337, nil, nil, nil, 2, 2)
local specWarnThrowCoins			= mod:NewSpecialWarningMove(271784, "Tank", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

local timerStaticPulseCD			= mod:NewAITimer(13, 262347, nil, nil, nil, 2)
local timerFootbombLauncherCD		= mod:NewAITimer(13, 269493, nil, nil, nil, 5)
local timerBlazingAzeriteCD			= mod:NewBuffFadesTimer(15, 256493, nil, nil, nil, 5)
local timerShockingClawCD			= mod:NewAITimer(13, 257337, nil, nil, nil, 3)
local timerThrowCoinsCD				= mod:NewAITimer(13, 271784, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON..DBM_CORE_TANK_ICON)

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerStaticPulseCD:Start(1-delay)
	timerFootbombLauncherCD:Start(1-delay)
	timerShockingClawCD:Start(1-delay)
	if not self:IsNormal() then
		timerThrowCoinsCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 256493 then--270882 for players?
		timerBlazingAzeriteCD:Stop()
		timerBlazingAzeriteCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 262347 then
		specWarnStaticPulse:Show()
		specWarnStaticPulse:Play("carefly")
		timerStaticPulseCD:Start()
	elseif spellId == 269493 then
		warnFootbombLauncher:Show()
		timerFootbombLauncherCD:Start()
	elseif spellId == 257337 then
		specWarnShockingClaw:Show()
		specWarnShockingClaw:Play("shockwave")
		timerShockingClawCD:Start()
	elseif spellId == 271784 and self:AntiSpam(5, 1) then
		specWarnThrowCoins:Show()
		specWarnThrowCoins:Play("moveboss")
		timerThrowCoinsCD:Start()
	elseif spellId == 271903 then
		warnCoinMagnet:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
