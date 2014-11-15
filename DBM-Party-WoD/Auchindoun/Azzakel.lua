local mod	= DBM:NewMod(1216, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75927)
mod:SetEncounterID(1678)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 153392 153234",
	"SPELL_AURA_REMOVED 153392 153764",
	"SPELL_CAST_START 153764 154221",
	"SPELL_PERIODIC_DAMAGE 153616 153726",
	"SPELL_PERIODIC_MISSED 153616 153726",
	"SPELL_SUMMON 164081",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnCurtainOfFlame			= mod:NewTargetAnnounce(153396, 4)
local warnFelLash					= mod:NewTargetAnnounce(153234, 2)
local warnClawsOfArgus				= mod:NewSpellAnnounce(153764, 3)
local warnSummonFelguard			= mod:NewSpellAnnounce(164081, 3, 56285, not mod:IsHealer())
local warnFelblast					= mod:NewCastAnnounce(154221, 3, nil, nil, not mod:IsHealer())--Spammy but still important. May improve by checking if interrupt spells on CD, if are, don't show warning, else, spam warning because interrupt SHOULD be on CD
local warnFelPool					= mod:NewSpellAnnounce(153616, 1)

local specWarnCurtainOfFlame		= mod:NewSpecialWarningMoveAway(153396)
local specWarnCurtainOfFlameNear	= mod:NewSpecialWarningClose(153396)
local yellWarnCurtainOfFlame		= mod:NewYell(153396)
local specWarnFelLash				= mod:NewSpecialWarningYou(153234, mod:IsTank())
local specWarnClawsOfArgus			= mod:NewSpecialWarningSpell(153764)
local specWarnClawsOfArgusEnd		= mod:NewSpecialWarningEnd(153764)
local specWarnSummonFelguard		= mod:NewSpecialWarningSwitch(164081, mod:IsTank())
local specWarnFelblast				= mod:NewSpecialWarningInterrupt(154221, not mod:IsHealer())--Spammy but still important. May improve by checking if interrupt spells on CD, if are, don't show warning, else, spam warning because interrupt SHOULD be on CD
local specWarnFelPool				= mod:NewSpecialWarningMove(153616)
local specWarnFelSpark				= mod:NewSpecialWarningMove(153726)

local timerCurtainOfFlameCD			= mod:NewNextTimer(20, 153396)--20sec cd but can be massively delayed by adds phases
local timerFelLash					= mod:NewTargetTimer(7.5, 153234)
local timerClawsOfArgus				= mod:NewBuffActiveTimer(18, 153764)
local timerClawsOfArgusCD			= mod:NewNextTimer(70, 153764)

mod:AddRangeFrameOption(5, 153396)

mod.vb.debuffCount = 0
mod.vb.firstFlameDone = false
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
	self.vb.firstFlameDone = false
	timerCurtainOfFlameCD:Start(15.5-delay)
	timerClawsOfArgusCD:Start(32-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 153396 and timerClawsOfArgusCD:GetTime() < 40 and self.vb.firstFlameDone then--if claws of argus is less than 20 seconds away, don't start CurtainOfFlame timer
		timerCurtainOfFlameCD:Start()--Start CD off success, not applied, so spreads don't mess with CD bar
	end
	if not self.vb.firstFlameDone then
		self.vb.firstFlameDone = true
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 153392 then
		self.vb.debuffCount = self.vb.debuffCount + 1
		local targetname = args.destName
		warnCurtainOfFlame:CombinedShow(0.5, targetname)
		if args:IsPlayer() then
			specWarnCurtainOfFlame:Show()
			yellWarnCurtainOfFlame:Yell()
		else
			if self:CheckNearby(5, targetname) then
				specWarnCurtainOfFlameNear:Show(targetname)
			end
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", curtainDebuff) then--You have debuff, show everyone
				DBM.RangeCheck:Show(5, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(5, debuffFilter)
			end
		end
	elseif spellId == 153234 then
		warnFelLash:Show(args.destName)
		timerFelLash:Start(args.destName)
		if args:IsPlayer() then
			specWarnFelLash:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 153392 then
		self.vb.debuffCount = self.vb.debuffCount - 1
		if self.Options.RangeFrame and self.vb.debuffCount == 0 then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 153764 then--Claws of Argus ending
		specWarnClawsOfArgusEnd:Show()
		timerCurtainOfFlameCD:Start(6.5)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153764 then
		warnClawsOfArgus:Show()
		specWarnClawsOfArgus:Show()
		timerClawsOfArgus:Start()
		timerClawsOfArgusCD:Start()
	elseif spellId == 154221 then
		warnFelblast:Show()
		specWarnFelblast:Show(args.sourceName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 153616 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelPool:Show()
	elseif spellId == 153726 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnFelSpark:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_SUMMON(args)
	if args.spellId == 164081 then
		warnSummonFelguard:Show()
		specWarnSummonFelguard:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 153500 then
		warnFelPool:Show()
	end
end
