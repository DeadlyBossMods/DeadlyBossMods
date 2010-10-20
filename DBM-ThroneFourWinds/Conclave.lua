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

--local warnPermafrost		= mod:NewSpellAnnounce()    spellID unknown
local warnSleetStorm		= mod:NewSpellAnnounce(86367, 3)
local warnNurture		= mod:NewSpellAnnounce(85422, 3)
local warnSoothingBreeze	= mod:NewSpellAnnounce(86207, 3)	-- spell ID?
local warnZephyr		= mod:NewSpellAnnounce(84651, 3)
local warnSummonTornados	= mod:NewSpellAnnounce(86192, 3)
local warnSlicingGale		= mod:NewSpellAnnounce(93058, 3)

--local timerPermafrost		= mod:NewCastTimer(2.5, id)
local timerSleetStorm		= mod:NewBuffActiveTimer(15, 86367)
local timerZephyr		= mod:NewBuffActiveTimer(15, 84651)
local timerSlicingGale		= mod:NewTargetTimer(30, 93058)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(93057, 93058) then
		timerSlicingGale:Start(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(85422) then
		warnNurture:Show()
	elseif args:IsSpellID(86205) then	-- spellID?
		warnSoothingBreeze:Show()
	elseif args:IsSpellID(96192) then
		warnSummonTornados:Show()
	elseif args:IsSpellID(86182, 93056, 93057, 93058) then
		warnSlicingGale:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(86367, 93135, 93136, 93137) then
		warnSleetStorm:Show()
		timerSleetStorm:Start()
	elseif args:IsSpellID(84651, 84638, 93119, 93118) or args:IsSpellID(93117) then
		warnZephyr:Show()
		timerZephyr:Start()
	end
end