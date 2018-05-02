local mod	= DBM:NewMod(1981, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124874)
mod:SetEncounterID(2067)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 244751 248736",
	"SPELL_CAST_SUCCESS 246324",
	"SPELL_AURA_APPLIED 248804",
	"SPELL_AURA_REMOVED 248804",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, power gain rate consistent?
--TODO, special warning to switch to tentacles once know for sure how to tell empowered apart from non empowered?
--TODO, More work on guard timers, with an english log that's actually captured properly (stared and stopped between pulls)
local warnEternalTwilight				= mod:NewCastAnnounce(248736, 4)
local warnAddsLeft						= mod:NewAddsLeftAnnounce("ej16424", 2)
local warnTentacles						= mod:NewSpellAnnounce(244769, 2)

local specWarnHowlingDark				= mod:NewSpecialWarningInterrupt(244751, "HasInterrupt", nil, nil, 1, 2)
local specWarnEntropicForce				= mod:NewSpecialWarningSpell(246324, nil, nil, nil, 1, 2)
local specWarnAdds						= mod:NewSpecialWarningAdds(249336, "-Healer", nil, nil, 1, 2)

local timerUmbralTentaclesCD			= mod:NewCDTimer(30.4, 244769, nil, nil, nil, 1)
local timerHowlingDarkCD				= mod:NewCDTimer(28.0, 244751, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerEntropicForceCD				= mod:NewCDTimer(28.0, 246324, nil, nil, nil, 2)--28-38
local timerEternalTwilight				= mod:NewCastTimer(10, 248736, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerAddsCD						= mod:NewAddsTimer(61.9, 249336, nil, "-Healer")

local countdownEternalTwilight			= mod:NewCountdown("AltTwo10", 248736)

mod.vb.guardsActive = 0

function mod:OnCombatStart(delay)
	self.vb.guardsActive = 0
	timerUmbralTentaclesCD:Start(11.8-delay)
	timerHowlingDarkCD:Start(15.5-delay)
	timerEntropicForceCD:Start(35-delay)
	if self:IsHard() then
		timerAddsCD:Start(53-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 244751 then
		timerHowlingDarkCD:Start()
		specWarnHowlingDark:Show(args.sourceName)
		specWarnHowlingDark:Play("kickcast")
	elseif spellId == 248736 and self:AntiSpam(3, 1) then
		warnEternalTwilight:Show()
		timerEternalTwilight:Start()
		countdownEternalTwilight:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 246324 then
		specWarnEntropicForce:Show()
		specWarnEntropicForce:Play("keepmove")
		timerEntropicForceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 248804 then
		self.vb.guardsActive = self.vb.guardsActive + 1
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 248804 then
		self.vb.guardsActive = self.vb.guardsActive - 1
		if self.vb.guardsActive >= 1 then
			warnAddsLeft:Show(self.vb.guardsActive)
		--else
			--Start timer for next guard here if more accurate
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 245038 then
		warnTentacles:Show()
		timerUmbralTentaclesCD:Start()
	elseif spellId == 249336 then--or 249335
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		timerAddsCD:Start()
	end
end
