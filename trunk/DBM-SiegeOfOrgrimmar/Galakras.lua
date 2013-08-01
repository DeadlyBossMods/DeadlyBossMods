local mod	= DBM:NewMod(868, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72311, 72560, 72249)--Boss needs to engage off Varian/Lor'themar, not the boss. I include the boss too so we don't detect a win off losing varian. :)
mod:SetMainBossID(72249)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Stage 1: Clear the Landing/Bring Her Down!
----TODO, don't want this mod to register events in entire zone so it can warn for prelude trash.
----I'll put duplicate eevnts in trash mod instead since trash mod will be disabled during encounters
local warnWarBanner					= mod:NewSpellAnnounce(147328, 3)
local warnFracture					= mod:NewTargetAnnounce(146899, 3)--TODO: see if target scanning works with one of earlier events
local warnChainHeal					= mod:NewCastAnnounce(146757, 4)
----Master Cannoneer Dragryn
local warnMuzzleSpray				= mod:NewSpellAnnounce(147824, 3)--Wowhead data: 147825 activates a periodicly trigger (147823) which triggers 147824 as secondary effect
----Lieutenant General Krugruk
local warnArcingSmash				= mod:NewSpellAnnounce(147688, 3)
----High Enforcer Thranok
local warnCrushersCall				= mod:NewCastAnnounce(146769, 3)
local warnSkullCracker				= mod:NewCastAnnounce(146848, 4)
----Korgra the Snake
local warnPoisonTippedBlades		= mod:NewStackAnnounce(146902, 2, nil, mod:IsTank())
--Phase 3: Galakras,The Last of His Progeny
local warnFlamesofGalakrondTarget	= mod:NewTargetAnnounce(147068, 4)

--Stage 1: Clear the Landing/Bring Her Down!
local specWarnWarBanner				= mod:NewSpecialWarningSwitch(147328, not mod:IsHealer())
local specWarnFractureYou			= mod:NewSpecialWarningYou(146899)
local yellFracture					= mod:NewYell(146899)
local specWarnFracture				= mod:NewSpecialWarningTarget(146899, mod:IsHealer())
local specWarnChainheal				= mod:NewSpecialWarningInterrupt(146757)
local specWarnFlameArrow			= mod:NewSpecialWarningMove(146764)
----Master Cannoneer Dragryn
local specWarnMuzzleSpray			= mod:NewSpecialWarningSpell(147824, nil, nil, nil, 2)
----Lieutenant General Krugruk
local specWarnArcingSmash			= mod:NewSpecialWarningSpell(147688, nil, nil, nil, 2)
----High Enforcer Thranok
local specWarnCrushersCall			= mod:NewSpecialWarningSpell(146769, false, nil, nil, 2)--optional pre warning for the grip soon. although melee/tank probably don't really care and ranged are 50/50
local specWarnSkullCracker			= mod:NewSpecialWarningRun(146848, nil, nil, nil, 3)--TODO, only warn the ranged who were gripped in by crushers call, instead of all of them
----Korgra the Snake
local specWarnPoisonCloud			= mod:NewSpecialWarningMove(147705)
--Phase 3: Galakras,The Last of His Progeny
local specWarnFlamesofGalakrond		= mod:NewSpecialWarningSpell(147029, nil, nil, nil, 2)
local specWarnFlamesofGalakrondYou	= mod:NewSpecialWarningYou(147068)
local yellFlamesofGalakrond			= mod:NewYell(147068)

--Stage 1: Clear the Landing/Bring Her Down!
----Nothing in EJ so can't drycode this
local timerDemolisherCD				= mod:NewTimer(20, "timerDemolisherCD", 116040)--EJ is just not complete yet, shouldn't need localizing
----Master Cannoneer Dragryn

----Lieutenant General Krugruk

----High Enforcer Thranok

----Korgra the Snake
local timerPoisontippedBlades		= mod:NewTargetTimer(15, 146902, nil, mod:IsTank() or mod:IsHealer())
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
	elseif args.spellId == 146757 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainheal:Show(source)
		end
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
	elseif args.spellId == 147328 then
		warnWarBanner:Show()
		specWarnWarBanner:Show()
	elseif args.spellId == 146899 then
		warnFracture:Show(args.destName)
		if args:IsPlayer() then
			specWarnFractureYou:Show()
			yellFracture:Yell()
		else
			specWarnFracture:Show(args.destName)
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

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 146764 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnFlameArrow:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 72249 then--Main Boss ID
		DBM:EndCombat(self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:116040") then--Not a mistake, it emotes epiccenter (maybe a bug?)
		
	elseif msg == L.tower or msg:find(L.tower) then
		timerDemolisherCD:Start()
	end
end
