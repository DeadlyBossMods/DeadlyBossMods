local mod	= DBM:NewMod("Conclave", "DBM-ThroneFourWinds", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(45870, 45871, 45872)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnPermafrost		= mod:NewSpellAnnounce(86082, 3)
local warnSleetStorm		= mod:NewSpellAnnounce(84644, 3)
local warnNurture		= mod:NewSpellAnnounce(85422, 3)
local warnSoothingBreeze	= mod:NewSpellAnnounce(86207, 3)	-- using a spellID here with a better description of the spell
local warnZephyr		= mod:NewSpellAnnounce(84638, 3)
local warnSummonTornados	= mod:NewSpellAnnounce(86192, 3)
local warnSlicingGale		= mod:NewSpellAnnounce(93058, 3)
local warnWindBlast		= mod:NewSpellAnnounce(86193, 3)
local warnHurricane		= mod:NewSpellAnnounce(84643, 3)

local timerPermafrost		= mod:NewCastTimer(2.5, 86082)
local timerSleetStorm		= mod:NewBuffActiveTimer(15, 86367)
local timerSleetStormCD		= mod:NewCDTimer(112, 84638)
local timerNurture		= mod:NewCDTimer(112, 85422)
local timerWindChill		= mod:NewNextTimer(10.5, 84645)
local timerZephyr		= mod:NewBuffActiveTimer(15, 84651)
local timerSlicingGale		= mod:NewTargetTimer(30, 93058)
local timerWindBlast		= mod:NewBuffActiveTimer(10, 86193)		-- Cooldown: 1st->2nd = 22sec || 2nd->3rd = 60sec || 3rd->4th = 60sec ?
local timerWindBlastCD		= mod:NewCDTimer(60, 86193)
local timerHurricane		= mod:NewCDTimer(112, 84643)

-- Nurture, Sleet Storm and Hurricane are on the same CD and are used simultanously --> Might make 1 timer with the text "BIG SPECIAL ABBILITY!" ? :P

local windBlastCounter
function mod:OnCombatStart(delay)
	windBlastCounter = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93057, 93058) then
		timerSlicingGale:Start(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86205) then
		warnSoothingBreeze:Show()
	elseif args:IsSpellID(96192) then
		warnSummonTornados:Show()
	elseif args:IsSpellID(86182, 93056, 93057, 93058) then		-- 86182 confirmed (normal10)
		warnSlicingGale:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(85422) then
		warnNurture:Show()
		timerNurture:Start()
	elseif args:IsSpellID(84644, 93135, 93136, 93137) then		-- 84644 confirmed (normal10)
		warnSleetStorm:Show()
		timerSleetStorm:Start()
		timerSleetStormCD:Start()
	elseif args:IsSpellID(84638, 93119, 93118, 93117) then		-- 84638 confirmed (normal10)
		warnZephyr:Show()
		timerZephyr:Start()
	elseif args:IsSpellID(84645) then
		timerWindChill:Start()
	elseif args:IsSpellID(86193) then
		windBlastCounter = windBlastCounter + 1
		warnWindBlast:Show()
		timerWindBlast:Start()
		if windBlastCounter == 1 then
			timerWindBlastCD:Start(82)
		else
			timerWindBlastCD:Start()
		end
	elseif args:IsSpellID(84643) then
		warnHurricane:Show()
		timerHurricane:Start()
	end
end