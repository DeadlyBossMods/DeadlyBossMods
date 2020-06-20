local mod	= DBM:NewMod("FreeholdTrash", "DBM-Party-BfA", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 257732 257397 257899 257736 258777 257784 257756 274860 257426 274383 258199 272402 257870",
	"SPELL_AURA_APPLIED 257274 257476 258323 257739 257908"
--	"SPELL_CAST_SUCCESS"
)

--TODO, poision Strikes dispel/stack warning?
--TODO, warning for earth shaker?
local warnDuelistDash					= mod:NewTargetNoFilterAnnounce(274400, 4)
local warnRatTrap						= mod:NewCastAnnounce(274383, 2)
local warnRicochetingThrow				= mod:NewTargetAnnounce(272402, 2)

local yellRicochetingThrow				= mod:NewYell(272402)
local yellDuelistDash					= mod:NewYell(274400)
local specWarnOiledBladeSelf			= mod:NewSpecialWarningDefensive(257908, nil, nil, nil, 1, 2)
local specWarnBrutalBackhand			= mod:NewSpecialWarningDodge(257426, nil, nil, nil, 1, 2)
local specWarnShatteringToss			= mod:NewSpecialWarningSpell(274860, "Tank", nil, nil, 1, 2)
local specWarnGoinBan					= mod:NewSpecialWarningRun(257756, "Melee", nil, nil, 4, 2)
local specWarnBladeBarrage				= mod:NewSpecialWarningRun(257870, "Melee", nil, nil, 4, 2)
local specWarnGroundShatter				= mod:NewSpecialWarningRun(258199, "Melee", nil, nil, 4, 2)
local specWarnBlindRagePlayer			= mod:NewSpecialWarningRun(257739, nil, nil, nil, 4, 2)
local specWarnHealingBalm				= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
local specWarnPainfulMotivation			= mod:NewSpecialWarningInterrupt(257899, "HasInterrupt", nil, nil, 1, 2)
local specWarnThunderingSquall			= mod:NewSpecialWarningInterrupt(257736, "HasInterrupt", nil, nil, 1, 2)
local specWarnSeaSpout					= mod:NewSpecialWarningInterrupt(258779, "HasInterrupt", nil, nil, 1, 2)--258777 has no tooltip yet so using damage ID for now
local specWarnFrostBlast				= mod:NewSpecialWarningInterrupt(257784, "HasInterrupt", nil, nil, 1, 2)--Might prune or disable by default if it conflicts with higher priority interrupts in area
local specWarnShatteringBellowKick		= mod:NewSpecialWarningInterrupt(257732, "HasInterrupt", nil, nil, 1, 2)
local specWarnShatteringBellow			= mod:NewSpecialWarningCast(257732, "SpellCaster", nil, nil, 1, 2)
local specWarnBestialWrath				= mod:NewSpecialWarningDispel(257476, "RemoveEnrage", nil, 2, 1, 2)
local specWarnBlindRage					= mod:NewSpecialWarningDispel(257739, "RemoveEnrage", nil, 2, 1, 2)
local specWarnInfectedWound				= mod:NewSpecialWarningDispel(258323, "RemoveDisease", nil, nil, 1, 2)
local specWarnOiledBlade				= mod:NewSpecialWarningDispel(257908, "Healer", nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

function mod:RicochetingTarget(targetname)
	if not targetname then return end
	warnRicochetingThrow:Show(targetname)
	if targetname == UnitName("player") then
		yellRicochetingThrow:Yell()
	end
end

function mod:DashTarget(targetname)
	if not targetname then return end
	warnDuelistDash:Show(targetname)
	if targetname == UnitName("player") then
		yellDuelistDash:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHealingBalm:Show(args.sourceName)
		specWarnHealingBalm:Play("kickcast")
	elseif spellId == 257899 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPainfulMotivation:Show(args.sourceName)
		specWarnPainfulMotivation:Play("kickcast")
	elseif spellId == 257736 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnThunderingSquall:Show(args.sourceName)
		specWarnThunderingSquall:Play("kickcast")
	elseif spellId == 258777 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSeaSpout:Show(args.sourceName)
		specWarnSeaSpout:Play("kickcast")
	elseif spellId == 257784 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnFrostBlast:Show(args.sourceName)
		specWarnFrostBlast:Play("kickcast")
	elseif spellId == 257732 then
		--Can interrupt and interrupt warning enabled, show that
		if self:CheckInterruptFilter(args.sourceGUID, false, true) and self.Options.SpecWarn257732interrupt then
			specWarnShatteringBellowKick:Show(args.sourceName)
			specWarnShatteringBellowKick:Play("kickcast")
		elseif self:AntiSpam(3, 1) then--Else, can't interrupt or interrupt warning is disabled and user is a caster, warn to stop casting.
			specWarnShatteringBellow:Show()
			specWarnShatteringBellow:Play("stopcast")
		end
	elseif spellId == 257756 and self:AntiSpam(5, 3) then
		specWarnGoinBan:Show()
		specWarnGoinBan:Play("justrun")
	elseif spellId == 257870 and self:AntiSpam(5, 3) then
		specWarnBladeBarrage:Show()
		specWarnBladeBarrage:Play("justrun")
	elseif spellId == 274860 and self:AntiSpam(3, 4) then
		specWarnShatteringToss:Show()
		specWarnShatteringToss:Play("carefly")--"toss coming" would be better but i can't remember media file
	elseif spellId == 257426 and self:AntiSpam(3, 5) then
		specWarnBrutalBackhand:Show()
		specWarnBrutalBackhand:Play("shockwave")
	elseif spellId == 274400 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "DashTarget", 0.1, 8)
	elseif spellId == 274383 and self:AntiSpam(3, 9) then
		warnRatTrap:Show()
	elseif spellId == 258199 and self:AntiSpam(3, 3) then
		specWarnGroundShatter:Show()
		specWarnGroundShatter:Play("justrun")
	elseif spellId == 272402 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257274 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 257476 and self:AntiSpam(3, 6) then
		specWarnBestialWrath:Show(args.destName)
		specWarnBestialWrath:Play("helpdispel")
	elseif spellId == 257739 and self:AntiSpam(3, 10) then
		--If it can be dispelled by affected player, no reason to tell them to run away, dispel is priority
		if self.Options.SpecWarn257739dispel then
			specWarnBlindRage:Show(args.destName)
			specWarnBlindRage:Play("helpdispel")
		elseif args:IsPlayer() then
			specWarnBlindRagePlayer:Show()
			specWarnBlindRagePlayer:Play("justrun")
		end
	elseif spellId == 257908 and args:IsDestTypePlayer() and self:AntiSpam(3, 12) then
		--If tank can dispel self, no reason to tell tank to defensive through it, dispel is priority
		if self.Options.SpecWarn257908dispel and self:CheckDispelFilter() then
			specWarnOiledBlade:Show(args.destName)
			specWarnOiledBlade:Play("helpdispel")
		elseif args:IsPlayer() then
			specWarnOiledBladeSelf:Show()
			specWarnOiledBladeSelf:Play("defensive")
		end
	elseif spellId == 258323 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 7) then
		specWarnInfectedWound:Show(args.destName)
		specWarnInfectedWound:Play("helpdispel")
	end
end
