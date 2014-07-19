local mod	= DBM:NewMod(1216, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75927)
mod:SetEncounterID(1678)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 153396",
	"SPELL_AURA_REMOVED 153396 153764",
	"SPELL_CAST_START 153764 154221",
	"SPELL_SUMMON 164081"
)

local warnCurtainOfFlame			= mod:NewTargetAnnounce(153396, 4)
local warnClawsOfArgus				= mod:NewSpellAnnounce(153764, 3)
local warnFelblast					= mod:NewCastAnnounce(154221, 3, nil, not mod:IsHealer())--Spammy but still important. May improve by checking if interrupt spells on CD, if are, don't show warning, else, spam warning because interrupt SHOULD be on CD
local warnSummonFelguard			= mod:NewSpellAnnounce(164081, 3, 56285, not mod:IsHealer())

local specWarnCurtainOfFlame		= mod:NewSpecialWarningYou(153396)
local specWarnCurtainOfFlameNear	= mod:NewSpecialWarningClose(153396, mod:IsDps())
local specWarnClawsOfArgus			= mod:NewSpecialWarningSpell(153764)
local specWarnSummonFelguard		= mod:NewSpecialWarningSwitch(164081, mod:IsTank())
local specWarnFelblast				= mod:NewSpecialWarningInterrupt(154221, not mod:IsHealer())--Spammy but still important. May improve by checking if interrupt spells on CD, if are, don't show warning, else, spam warning because interrupt SHOULD be on CD

local timerCurtainOfFlameCD			= mod:NewNextTimer(20, 153396)--20sec cd but can be massively delayed by adds phases
local timerClawsOfArgusCD			= mod:NewNextTimer(60, 153764)

mod.vb.debuffCount = 0
local curtainDebuff = GetSpellInfo(153396)
local UnitDebuff = UnitDebuff
local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, curtainDebuff)
	end
end

function mod:OnCombatStart(delay)
	self.vb.debuffCount = 0
	timerCurtainOfFlameCD:Start(15-delay)
	timerClawsOfArgusCD:Start(27-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 153396 and timerClawsOfArgusCD:GetTime() > 40 then--if claws of argus is less than 20 seconds away, don't start CurtainOfFlame timer
		timerCurtainOfFlameCD:Start()--Start CD off success, not applied, so spreads don't mess with CD bar
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 153396 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		warnCurtainOfFlame:CombinedShow(0.5, args.destName)
		if self.Options.RangeFrame then
			if UnitDebuff("player", curtainDebuff) then--You have debuff, show everyone
				DBM.RangeCheck:Show(5, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(5, debuffFilter)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 153396 then
		self.vb.debuffCount = self.vb.debuffCount - 1
		if self.Options.RangeFrame and self.vb.debuffCount == 0 then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 153764 then--Claws of Argus ending
		timerCurtainOfFlameCD:Start(7)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153764 then
		warnClawsOfArgus:Show()
		specWarnClawsOfArgus:Show()
		timerClawsOfArgusCD:Start()
	elseif spellId == 154221 then
		warnFelblast:Show()
		specWarnFelblast:Show(args.sourceName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 164081 then
		warnSummonFelguard:Show()
		specWarnSummonFelguard:Show()
	end
end
