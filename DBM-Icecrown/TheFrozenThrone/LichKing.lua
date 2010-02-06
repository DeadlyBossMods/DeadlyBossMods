local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID()
mod:RegisterCombat("yell", L.YellPull)--I will probably change pull method to "combat" if possible.
mod:SetMinCombatTime(60)--But logs don't show me when combat_regen_disabled event fire so for moment i have to use what i know

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"UNIT_HEALTH"
)

local isDiseaseDispeller = select(2, UnitClass("player")) == "PALADIN"
	    		 or select(2, UnitClass("player")) == "PRIEST"

local warnRemorselessWinter = mod:NewSpellAnnounce(68981)--Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262)--Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetAnnounce(69200)--Transition Add
local warnShamblingHorror	= mod:NewSpellAnnounce(70372)--Phase 1 Add
local warnDrudgeGhouls		= mod:NewSpellAnnounce(70358)--Phase 1 Add
local warnNecroticPlague	= mod:NewTargetAnnounce(70337)--Phase 1+ Ability
local warnInfest			= mod:NewSpellAnnounce(70541)--Phase 1+ Ability
local warnSoulreaper		= mod:NewSpellAnnounce(69409)--Phase 1+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037)--Phase 2 Add
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498)--Phase 3 Add
local warnHarvestSoul		= mod:NewTargetAnnounce(68980)--Phase 3 Ability

local specWarnSoulreaper	= mod:NewSpecialWarningYou(69409)--Phase 1+ Ability
local specWarnDefileCast	= mod:NewSpecialWarningSpell(72762)--Phase 2+ Ability
local specWarnDefile		= mod:NewSpecialWarningMove(72754)--Phase 2+ Ability
local specWarnHarvestSoul	= mod:NewSpecialWarningYou(68980)--Phase 1+ Ability
local specWarnInfest		= mod:NewSpecialWarningSpell(70541, false)--Phase 1+ Ability
local specWarnNecroticPlague= mod:NewSpecialWarningDispel(70337, isDiseaseDispeller)--Phase 1+ Ability

local timerCombatStart		= mod:NewTimer(56, "TimerCombatStart", 2457)
local timerSoulreaper	 	= mod:NewTargetTimer(5.1, 70372)
local timerHarvestSoul	 	= mod:NewTargetTimer(6, 68980)
local timerInfestCD			= mod:NewCDTimer(30, 70541)
local timerNecroticPlagueCD	= mod:NewCDTimer(30, 70337)
local timerDefileCD			= mod:NewCDTimer(30, 72762)
local timerShamblingHorror 	= mod:NewNextTimer(60, 70372)
local timerSummonValkyr 	= mod:NewNextTimer(50, 69037)
local timerVileSpirit 		= mod:NewNextTimer(30, 70498)

local phase	= 0

function mod:OnCombatStart(delay)
	phase = 0
	timerCombatStart:Start(-delay)
	self:ScheduleMethod(56, "NextPhase")
end


function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 74270, 74271, 74272) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerShamblingHorror:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()--Do these reset on phase transition? Assuming so for time being
		timerNecroticPlagueCD:Cancel()--Do these reset on phase transition? Assuming so for time being
		timerDefileCD:Cancel()--Do these reset on phase transition? Assuming so for time being
	elseif args:IsSpellID(72262) then -- Quake (phase transition end)
		warnQuake:Show()
		self:ScheduleMethod(1.5, "NextPhase")--Might need some tweaks
	elseif args:IsSpellID(70372) then -- Shambling Horror
		warnShamblingHorror:Show()
		timerShamblingHorror:Start()
	elseif args:IsSpellID(70358) then -- Drudge Ghouls
		warnShamblingHorror:Show()
		timerShamblingHorror:Start()
	elseif args:IsSpellID(70498) then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args:IsSpellID(70541, 73779, 73780, 73781) then -- Infest
		warnInfest:Show()
		specWarnInfest:Show()
		timerInfestCD:Start()
	elseif args:IsSpellID(72762, 73779, 73780, 73781) then -- Defile
		specWarnDefileCast:Show()
		timerDefileCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70337, 73912, 73913, 73914) then -- Necrotic Plague
		warnNecroticPlague:Show(args.destName)
		specWarnNecroticPlague:Show(args.destName)
		timerNecroticPlagueCD:Start()
	elseif args:IsSpellID(69409, 73797, 73798, 73799) then -- Soul reaper (MT debuff)
		warnSoulreaper:Show(args.destName)
		timerSoulreaper:Start(args.destName)
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
		end
	elseif args:IsSpellID(69200) then -- Raging Spirit
		warnRagingSpirit:Show(args.destName)
	elseif args:IsSpellID(68980, 74325, 74326, 74327) then -- Harvest Soul (not sure if this is right event for this, combat logs i saw never made it to phase 3)
		warnHarvestSoul:Show(args.destName)
		timerHarvestSoul:Start(args.destName)
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69037) then -- Summon Val'kyr
		warnSummonValkyr:Show()
		timerSummonValkyr:Start()
	end
end

do 
	local lastDefile = 0
	function mod:SPELL_DAMAGE(args)
		if args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and time() - lastDefile > 2 then		-- Defile, MOVE!
			specWarnDefile:Show()
			lastDefile = time()
		end
	end
end

function mod:NextPhase()--Might need some tweaks or may even replace it with monster yell instead but will avoid using locals if possible
	phase = phase + 1
	if phase == 1 then
		timerShamblingHorror:Start(20)--First add of phase timing might be off
		timerNecroticPlagueCD:Start()
	elseif phase == 2 then
		timerSummonValkyr:Start(22)--First add of phase timing might be off
	elseif phase == 3 then
		timerVileSpirit:Start(20)--First add of phase timing might be off
	end
end