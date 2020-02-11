local mod	= DBM:NewMod(2109, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(129214)
mod:SetEncounterID(2105)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 256493",
	"SPELL_AURA_APPLIED_DOSE 256493",
	"SPELL_AURA_REFRESH 256493",
	"SPELL_CAST_START 262347 257337 271903",
	"SPELL_CAST_SUCCESS 269493",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Change Static Pulse to dodge warning if it's dodgable by all parties
--New voice, "Gather Item"?
local warnFootbombLauncher			= mod:NewSpellAnnounce(269493, 2)
local warnCoinMagnet				= mod:NewSpellAnnounce(271903, 2)

local specWarnStaticPulse			= mod:NewSpecialWarningSpell(262347, nil, nil, nil, 2, 2)
local specWarnShockingClaw			= mod:NewSpecialWarningDodge(257337, nil, nil, nil, 2, 2)
local specWarnThrowCoins			= mod:NewSpecialWarningMove(271784, "Tank", nil, nil, 1, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerStaticPulseCD			= mod:NewCDTimer(23.1, 262347, nil, nil, nil, 2)
local timerFootbombLauncherCD		= mod:NewCDTimer(36.5, 269493, nil, nil, nil, 5)
local timerBlazingAzeriteCD			= mod:NewBuffFadesTimer(15, 256493, nil, nil, nil, 5)
local timerShockingClawCD			= mod:NewAITimer(13, 257337, nil, nil, nil, 3)--14.3, 41.3 (not enough timer data, leaving AI for now)
local timerThrowCoinsCD				= mod:NewCDTimer(17.4, 271784, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON..DBM_CORE_TANK_ICON)--18.8, 17.4, 25.5, 25.5


mod.vb.coinCast = 0

function mod:OnCombatStart(delay)
	self.vb.coinCast = 0
	timerStaticPulseCD:Start(5.7-delay)
	timerFootbombLauncherCD:Start(9.4-delay)
	timerShockingClawCD:Start(1-delay)--14.3
	if not self:IsNormal() then
		timerThrowCoinsCD:Start(18-delay)
	end
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
	elseif spellId == 257337 then
		specWarnShockingClaw:Show()
		specWarnShockingClaw:Play("shockwave")
		timerShockingClawCD:Start()
	elseif spellId == 271903 then
		warnCoinMagnet:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 269493 then
		warnFootbombLauncher:Show()
		timerFootbombLauncherCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 271859 then--Pay to Win
		self.vb.coinCast = self.vb.coinCast + 1
		specWarnThrowCoins:Show()
		specWarnThrowCoins:Play("moveboss")
		if self.vb.coinCast == 1 then
			timerThrowCoinsCD:Start(17)
		else
			timerThrowCoinsCD:Start(25)
		end
	end
end
