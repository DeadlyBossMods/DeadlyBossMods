local mod	= DBM:NewMod(1207, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83894, 83892, 83893)--Dulhu 83894, Gola 83892, Telu
mod:SetEncounterID(1757)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 168082 168041 168105 168383",
	"SPELL_AURA_APPLIED 168105 168041 168520"
)

--maybe add CD timers if i care enough to check for briarskin and cancel them if it applies to a boss
local warnRevitalizingWaters		= mod:NewSpellAnnounce(168082, 4)--This is always followed instantly by Firestorm kick, so no reason to warn both.
local warnBriarskin					= mod:NewTargetAnnounce(168041, 4)
local warnRapidTides				= mod:NewTargetAnnounce(168105, 3)
local warnSlash						= mod:NewSpellAnnounce(168383, 3)
local warnShapersFortitude			= mod:NewTargetAnnounce(168520, 3)

local specWarnRevitalizingWaters	= mod:NewSpecialWarningInterrupt(168082, not mod:IsHealer())
local specWarnBriarskin				= mod:NewSpecialWarningInterrupt(168041, false)--if you have more than one interruptor, great. but off by default because we can't assume you can interrupt every bosses abilities. and heal takes priority
local specWarnBriarskinDispel		= mod:NewSpecialWarningDispel(168041, false)--Not as important as rapid Tides and to assume you have at least two dispellers is big assumption
local specWarnRapidTides			= mod:NewSpecialWarningInterrupt(168105, false)--if you have more than one interruptor, great. but off by default because we can't assume you can interrupt every bosses abilities. and heal takes priority
local specWarnRapidTidesDispel		= mod:NewSpecialWarningDispel(168105, mod:IsMagicDispeller())
local specWarnSlash					= mod:NewSpecialWarningSpell(168383, mod:IsMelee(), nil, nil, 2)--Because it's 8 yard cone in random direction.

local timerShapersFortitude			= mod:NewTargetTimer(15, 168520)

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168082 then
		warnRevitalizingWaters:Show()
		specWarnRevitalizingWaters:Show(args.sourceName)
	elseif spellId == 168041 then
		specWarnBriarskin:Show(args.sourceName)
	elseif spellId == 168105 then
		specWarnRapidTides:Show(args.sourceName)
	elseif spellId == 168105 then
		warnSlash:Show()
		specWarnSlash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 168105 then
		warnRapidTides:Show(args.destName)
		specWarnRapidTidesDispel:Show(args.destName)
	elseif spellId == 168041 then
		warnBriarskin:Show(args.destName)
		specWarnBriarskinDispel:Show(args.destName)
	elseif spellId == 168520 then
		warnShapersFortitude:Show(args.destName)
		timerShapersFortitude:Start(args.destName)
	end
end
