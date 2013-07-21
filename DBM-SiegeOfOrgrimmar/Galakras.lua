local mod	= DBM:NewMod(868, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72249)
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

--Stage 1: Clear the Landing
----Nothing in EJ so can't drycode this
--Stage 2: Bring Her Down!
----Master Cannoneer Dragryn
local warnMuzzleSpray				= mod:NewSpellAnnounce(147824, 3)--Wowhead data: 147825 activates a periodicly trigger (147823) which triggers 147824 as secondary effect
----Lieutenant General Krugruk
local warnArcingSmash				= mod:NewSpellAnnounce(147688, 3)
----High Enforcer Thranok
local warnCrushersCall				= mod:NewCastAnnounce(146769, 3)
local warnSkullCracker				= mod:NewCastAnnounce(146848, 4)
----Korgra the Snake
local warnPoisonTippedBlades		= mod:NewStackAnnounce(146902, 2, nil, mod:IsTank())
----Foot Soldiers
------Nothing in EJ so can't drycode this
--Phase 3: Galakras,The Last of His Progeny
local warnFlamesofGalakrondTarget	= mod:NewTargetAnnounce(147068, 4)

--Stage 1: Clear the Landing
----Nothing in EJ so can't drycode this
--Stage 2: Bring Her Down!
----Master Cannoneer Dragryn
local specWarnMuzzleSpray			= mod:NewSpecialWarningSpell(147824, nil, nil, nil, 2)
----Lieutenant General Krugruk
local specWarnArcingSmash			= mod:NewSpecialWarningSpell(147688, nil, nil, nil, 2)
----High Enforcer Thranok
local specWarnCrushersCall			= mod:NewSpecialWarningSpell(146769, false, nil, nil, 2)--optional pre warning for the grip soon. although melee/tank probably don't really care and ranged are 50/50
local specWarnSkullCracker			= mod:NewSpecialWarningRun(146848, nil, nil, nil, 3)--TODO, only warn the ranged who were gripped in by crushers call, instead of all of them
----Korgra the Snake
local specWarnPoisonCloud			= mod:NewSpecialWarningMove(147705)
----Foot Soldiers
------Nothing in EJ so can't drycode this
--Phase 3: Galakras,The Last of His Progeny
local specWarnFlamesofGalakrond		= mod:NewSpecialWarningSpell(147029, nil, nil, nil, 2)
local specWarnFlamesofGalakrondYou	= mod:NewSpecialWarningYou(147068)
local yellFlamesofGalakrond			= mod:NewYell(147068)

--Stage 1: Clear the Landing
----Nothing in EJ so can't drycode this
--Stage 2: Bring Her Down!
----Master Cannoneer Dragryn

----Lieutenant General Krugruk

----High Enforcer Thranok

----Korgra the Snake
local timerPoisontippedBlades		= mod:NewTargetTimer(15, 146902, nil, mod:IsTank() or mod:IsHealer())
----Foot Soldiers
------Nothing in EJ so can't drycode this
--Phase 3: Galakras,The Last of His Progeny
local timerFlamesofGalakrond		= mod:NewTargetTimer(5, 147068)
--local timerFlamesofGalakrondCD		= mod:NewCDTimer(50, 147029)

mod:AddBoolOption("FixateIcon", true)

function mod:ArcingSmashTarget(targetname, uId)
	if not targetname then
		print("DBM DEBUG: ArcingSmashTarget Scan failed")
		return
	else
		print("DBM DEBUG: ArcingSmashTarget scan returned "..targetname)
	end
--[[	if self:IsTanking(uId) then--Never target tanks, so if target is tank, that means scanning failed.
		scanFailed = true
		specWarnFoulStream:Show()
	else
		warnFoulStream:Show(targetname)
		timerFoulStreamCD:Start()
		if targetname == UnitName("player") then
			specWarnFoulStreamYou:Show()
			yellFoulStream:Yell()
		else
			if checkTankDistance(71859) then
				specWarnFoulStream:Show()
			end
		end
	end--]]
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 147825 then--Might be an applied event instead
		warnMuzzleSpray:Show()
		specWarnMuzzleSpray:Show()
	elseif args.spellId == 147688 then--Might be an applied event instead
		self:BossTargetScanner(args.sourceGUID, "ArcingSmashTarget", 0.025, 12)--GUID is temp, til have CID instead, although guess doesn't matter
		warnArcingSmash:Show()
		specWarnArcingSmash:Show()
	elseif args.spellId == 146769 then
		warnCrushersCall:Show()
		specWarnCrushersCall:Show()
	elseif args.spellId == 146848 then
		warnSkullCracker:Show()
		specWarnSkullCracker:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 146902 then
		local amount = args.amount or 1
		if amount % 4 == 0 or amount >= 12 then--Guesswork, this is one of those rapid stacking ones
			warnPoisonTippedBlades:Show(args.destName, amount)
		end
		timerPoisonTippedBlades:Start(args.destName)
--[[		if amount >= 12 then
			if args:IsPlayer() then
				specWarnPoisonTippedBlades:Show(args.amount)
			else
				specWarnPoisonTippedBladesOther:Show(args.destName)
			end
		end--]]
	elseif args.spellId == 147068 then
		warnFlamesofGalakrondTarget:Show(args.destName)
		timerFlamesofGalakrond:Start(args.destName)
		--timerFlamesofGalakrondCD:Start()
		if args:IsPlayer() then
			specWarnFlamesofGalakrondYou:Show()
			yellFlamesofGalakrond:Yell()
		else
			specWarnFlamesofGalakrond:Show()
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 146902 then
		timerPoisonTippedBlades:Cancel(args.destName)
	elseif args.spellId == 147068 then
		timerFlamesofGalakrond:Cancel(args.destName)
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 147705 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnPoisonCloud:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
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
