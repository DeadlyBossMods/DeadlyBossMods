local mod	= DBM:NewMod(2199, "DBM-Azeroth-BfA", 1, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(136385)
--mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 274839 274829 274832"
)

--TODO, see if can detect gale force teleport target
local warnGaleForce					= mod:NewTargetAnnounce(274829, 3)

local specWarnAzurethosFury			= mod:NewSpecialWarningDodge(274839, nil, nil, nil, 2, 2)
local specWarnGaleForce				= mod:NewSpecialWarningDodge(274829, nil, nil, nil, 2, 2)
local specWarnWingBuffet			= mod:NewSpecialWarningDodge(274832, nil, nil, nil, 1, 2)

local timerAzurethosFuryCD			= mod:NewCDTimer(46.8, 274839, nil, nil, nil, 2)

function mod:GaleForce(targetname)
	if not targetname then return end
	warnGaleForce:Show(targetname)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 274839 then
		specWarnAzurethosFury:Show()
		specWarnAzurethosFury:Play("watchstep")
		timerAzurethosFuryCD:Start()
	elseif spellId == 274829 then
		specWarnGaleForce:Show()
		specWarnGaleForce:Play("shockwave")
		self:BossTargetScanner(args.sourceGUID, "GaleForce", 0.05, 1)--One check, boss is already looking at target at time of start, and stops looking at target almost immediately, we need target boss has soon as cast starts
	elseif spellId == 274832 then
		specWarnWingBuffet:Show()
		specWarnWingBuffet:Play("shockwave")
	end
end
