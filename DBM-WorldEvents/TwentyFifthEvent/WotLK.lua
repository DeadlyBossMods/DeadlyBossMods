local mod	= DBM:NewMod("WrathEvent", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(36597)
mod:SetEncounterID(2321)
mod:SetModelID(30721)--Lich King
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetWipeTime(30)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68981 72259 72262 70498 72762",
	"SPELL_CAST_SUCCESS 69200",
	"SPELL_AURA_APPLIED 72754 67574 66012",
	"SPELL_DAMAGE 68983",
	"SPELL_MISSED 68983"
)

--TODO, switch defile to even faster UNIT_TARGET scanner if boss unitIDs check out from transcriptor
--Anub
local warnPursue			= mod:NewTargetNoFilterAnnounce(67574, 4)
local warnFreezingSlash		= mod:NewTargetNoFilterAnnounce(66012, 2, nil, "Tank|Healer")
--Lich King
local warnRemorselessWinter = mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetNoFilterAnnounce(69200, 3) --Transition Add
local warnDefileCast		= mod:NewTargetNoFilterAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3, 71844) --Phase 2 Add
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add

--Anub
local specWarnPursue		= mod:NewSpecialWarningRun(67574, nil, nil, nil, 4, 2)
--Lich King
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
local specWarnDefileCast	= mod:NewSpecialWarningMoveAway(72762, nil, nil, nil, 3, 2) --Phase 2+ Ability
local yellDefile			= mod:NewYell(72762)
local specWarnDefileNear	= mod:NewSpecialWarningClose(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnGTFO			= mod:NewSpecialWarningGTFO(72762, nil, nil, nil, 1, 8) --Phase 2+ Ability

--local timerDefileCD		= mod:NewNextTimer(32.5, 72762, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 5)

--function mod:OnCombatStart(delay)

--end

--function mod:OnCombatEnd()

--end

function mod:DefileTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		yellDefile:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show(targetname)
			else
				warnDefileCast:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 72259) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		--timerDefileCD:Stop()
	elseif args.spellId == 72262 then -- Quake (phase transition end)
		warnQuake:Show()
	elseif args.spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
	elseif args.spellId == 72762 then -- Defile
		self:BossTargetScanner(args.sourceGUID, "DefileTarget", 0.02, 15)
		--timerDefileCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 69200 then -- Raging Spirit
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72754 and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif args.spellId == 67574 then
		if args:IsPlayer() then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
			specWarnPursue:ScheduleVoice(1.5, "keepmove")
		else
			warnPursue:Show(args.destName)
		end
	elseif args.spellId == 66012 then
		warnFreezingSlash:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 68983 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
