local mod	= DBM:NewMod(869, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71865)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Stage 1: The True Horde
local warnDesecrate					= mod:NewSpellAnnounce(144748, 3)
local warnHellscreamsWarsong		= mod:NewSpellAnnounce(144821, 3)
local warnFireUnstableIronStar		= mod:NewSpellAnnounce(147047, 3)
--local warnKorkronWarbringer		= mod:NewSpellAnnounce("ej8292", 3)
--local warnFarseerWolfRider		= mod:NewSpellAnnounce("ej8294", 3)
local warnSiegeEngineer				= mod:NewSpellAnnounce("ej8298", 4)--Check for 143531 (Siege Engineer Controller Periodic) although don't get hopes up, it's flagged hidden aura. Also check for npc=71520 (Siege Engineer Helper Bunny <Engineer of Sieges>)
local warnChainHeal					= mod:NewSpellAnnounce(144583, 4)
local warnChainLightning			= mod:NewSpellAnnounce(144584, 3)
--Intermission: Realm of Y'Shaarj
local warnYShaarjsProtection		= mod:NewTargetAnnounce(144945, 2)
local warnAnnihilate				= mod:NewCastAnnounce(144969, 4)
--Stage Two: Power of Y'Shaarj
local warnWhirlingCorruption		= mod:NewSpellAnnounce(144985, 3)
local warnEmpWhirlingCorruption		= mod:NewSpellAnnounce(145037, 3)
local warnTouchOfYShaarj			= mod:NewTargetAnnounce(145071, 3)
local warnEmpTouchOfYShaarj			= mod:NewTargetAnnounce(145175, 3)
local warnEmpDesecrate				= mod:NewSpellAnnounce(144749, 3)
local warnGrippingDespair			= mod:NewStackAnnounce(145183, 2, nil, mod:IsTank())
local warnEmpGrippingDespair		= mod:NewStackAnnounce(145195, 3, nil, mod:IsTank())

--Stage 1: The True Horde
local specWarnDesecrate				= mod:NewSpecialWarningSpell(144748, nil, nil, nil, 2)
local specWarnHellscreamsWarsong	= mod:NewSpecialWarningSpell(144821, mod:IsTank() or mod:IsHealer())
local specWarnFireUnstableIronStar	= mod:NewSpecialWarningSpell(147047, nil, nil, nil, 2)
--local specWarnKorkronWarbringer	= mod:NewSpecialWarningSwitch("ej8292", not mod:IsHealer())
--local specWarnFarseerWolfRider	= mod:NewSpecialWarningSwitch("ej8294", not mod:IsHealer())
local specWarnSiegeEngineer			= mod:NewSpecialWarningSwitch("ej8298", mod:IsDps())
local specWarnChainHeal				= mod:NewSpecialWarningInterrupt(144583)
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(144584, false)
--Intermission: Realm of Y'Shaarj
local specWarnAnnihilate			= mod:NewSpecialWarningSpell(144969, nil, nil, nil, 3)
--Stage Two: Power of Y'Shaarj
local specWarnWhirlingCorruption	= mod:NewSpecialWarningRun(144985, mod:IsMelee())
local specWarnEmpWhirlingCorruption	= mod:NewSpecialWarningRun(145037, mod:IsMelee())
local specWarnEmpDesecrate			= mod:NewSpecialWarningSpell(144749, nil, nil, nil, 2)
--local specWarnGrippingDespair		= mod:NewSpecialWarningStack(145183, mod:IsTank(), 12)--Tank swaps don't really need empowered version of spec warnings, since empowered doen't really change anything.
--local specWarnGrippingDespairOther	= mod:NewSpecialWarningTarget(145183, mod:IsTank())

--Stage 1: A Cry in the Darkness
--local timerDesecrateCD			= mod:NewCDTimer(45, 144748)
--local timerHellscreamsWarsongCD	= mod:NewCDTimer(60, 144821, nil, mod:IsTank() or mod:IsHealer())
--local timerKorkronWarbringerCD	= mod:NewCDTimer(30, "ej8292")
--local timerFarseerWolfRiderCD		= mod:NewCDTimer(45, "ej8294")
--local timerSiegeEngineerCD		= mod:NewCDTimer(60, "ej8298")
local timerPowerIronStar			= mod:NewCastTimer(15, 144616)
--Intermission: Realm of Y'Shaarj
local timerYShaarjsProtection		= mod:NewCastTimer(60, 144985)
--Stage Two: Power of Y'Shaarj
--local timerWhirlingCorruptionCD	= mod:NewCDTimer(40, 144985)--One bar for both, "empowered" makes timer too long
--local timerTouchOfYShaarjCD		= mod:NewCDTimer(40, 145071)--^^
local timerGrippingDespair			= mod:NewTargetTimer(15, 145183, nil, mod:IsTank())

local touchOfYShaarjTargets = {}

local function warnTouchOfYShaarjTargets(empowered)
	if empowered then
		warnEmpTouchOfYShaarj:Show(table.concat(touchOfYShaarjTargets, "<, >"))
	else
		warnTouchOfYShaarj:Show(table.concat(touchOfYShaarjTargets, "<, >"))
	end
--	timerTouchOfYShaarjCD:Start()
	table.wipe(touchOfYShaarjTargets)
end

function mod:DesecrateTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: DesecrateTarget Scan failed")
		return
	else
		print("DBM DEBUG: DesecrateTarget Scan returned: "..targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(touchOfYShaarjTargets)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144821 then
		warnHellscreamsWarsong:Show()
		specWarnHellscreamsWarsong:Show()
	elseif args.spellId == 144583 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainHeal:Show(source)
		end
	elseif args.spellId == 144584 then
		local source = args.sourceName
		warnChainLightning:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainLightning:Show(source)
		end
	elseif args.spellId == 144969 then
		warnAnnihilate:Show()
		specWarnAnnihilate:Show()
	elseif args.spellId == 144985 then
		warnWhirlingCorruption:Show()
		specWarnWhirlingCorruption:Show()
		--timerWhirlingCorruptionCD:Start()
	elseif args.spellId == 145037 then
		warnEmpWhirlingCorruption:Show()
		specWarnEmpWhirlingCorruption:Show()
		--timerWhirlingCorruptionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144748 then
		self:BossTargetScanner(71865, "DesecrateTarget", 0.025, 12)
		warnDesecrate:Show()
		specWarnDesecrate:Show()
	elseif args.spellId == 144749 then
		self:BossTargetScanner(71865, "DesecrateTarget", 0.025, 12)
		warnEmpDesecrate:Show()
		specWarnEmpDesecrate:Show()
	elseif args.spellId == 147047 then
		warnFireUnstableIronStar:Show()
		specWarnFireUnstableIronStar:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144616 then--Power Iron Star
		warnSiegeEngineer:Show()--Possibly an earlier place to warn for engineer though, they shouldn't cast this instantly as they have to run from side first
		specWarnSiegeEngineer:Show()
		--timerSiegeEngineerCD:Start()
		timerPowerIronStar:Start(args.destGUID)
	elseif args.spellId == 144616 then--Intermission
		--Cancel timers and stuff
		warnYShaarjsProtection:Show(args.destName)
		timerYShaarjsProtection:Start()
	elseif args.spellId == 145071 then
		touchOfYShaarjTargets[#touchOfYShaarjTargets + 1] = args.destName
		self:Unschedule(warnTouchOfYShaarjTargets)
		self:Schedule(0.5, warnTouchOfYShaarjTargets)
	elseif args.spellId == 145175 then
		touchOfYShaarjTargets[#touchOfYShaarjTargets + 1] = args.destName
		self:Unschedule(warnTouchOfYShaarjTargets)
		self:Schedule(0.5, warnTouchOfYShaarjTargets, true)
	elseif args:IsSpellID(145183, 145195) then
		local amount = args.amount or 1
		if amount % 3 == 0 or amount >= 12 then--Guesswork, this is one of those rapid stacking ones
			if args.spellId == 145183 then
				warnGrippingDespair:Show(args.destName, amount)
			else
				warnEmpGrippingDespair:Show(args.destName, amount)
			end
		end
		timerGrippingDespair:Start(args.destName)
--[[		if amount >= 12 then
			if args:IsPlayer() then
				specWarnGrippingDespair:Show(args.amount)
			else
				specWarnGrippingDespairOther:Show(args.destName)
			end
		end--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144616 then
		timerPowerIronStar:Cancel(args.destGUID)
	elseif args.spellId == 144616 then--Intermission
		timerYShaarjsProtection:Cancel()
		--Start timers and stuff
	elseif args:IsSpellID(145183, 145195) then
		timerGrippingDespair:Cancel(args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
