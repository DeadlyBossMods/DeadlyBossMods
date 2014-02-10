local mod	= DBM:NewMod(856, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71859, 71858)--haromm, Kardris
mod:SetEncounterID(1606)
mod:SetZone()
mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144005 144090 143990 144070 143973 144330 144328",
	"SPELL_CAST_SUCCESS 144288 144289 144290 144291 143990",
	"SPELL_AURA_APPLIED 144304 144089 144330 144215",
	"SPELL_AURA_APPLIED_DOSE 144304 144215",
	"SPELL_AURA_REMOVED 144089 144215 144330"
)

--Dogs
local warnRend						= mod:NewStackAnnounce("OptionVersion2", 144304, 2, nil, mod:IsTank() or mod:IsHealer())

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--85%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--65%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--45%
local warnRustedIronTotem			= mod:NewSpellAnnounce(144291, 3)--Heroic (95%)

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewStackAnnounce("OptionVersion2", 144215, 2, nil, mod:IsTank() or mod:IsHealer())
local warnToxicMists				= mod:NewTargetAnnounce("OptionVersion2", 144089, 2, nil, false)
local warnFoulStream				= mod:NewTargetAnnounce(144090, 4)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 4)
local warnIronTomb					= mod:NewSpellAnnounce(144328, 3)
--Wavebinder Kardris
local warnToxicStorm				= mod:NewTargetAnnounce(144005, 2)
local warnFoulGeyser				= mod:NewTargetAnnounce(143990, 4)
local warnFallingAsh				= mod:NewCastAnnounce(143973, 4, 17)
local warnIronPrison				= mod:NewTargetAnnounce(144330, 3)

--Earthbreaker Haromm
local specWarnFroststormStrike		= mod:NewSpecialWarningStack(144215, mod:IsTank(), 5)
local specWarnFroststormStrikeOther	= mod:NewSpecialWarningTarget(144215, mod:IsTank())
local specWarnFoulStreamYou			= mod:NewSpecialWarningYou(144090)
local yellFoulStream				= mod:NewYell(144090)
local specWarnFoulStream			= mod:NewSpecialWarningSpell(144090, nil, nil, nil, 2)
local specWarnAshenWall				= mod:NewSpecialWarningSpell(144070, nil, nil, nil, 2)
local specWarnIronTomb				= mod:NewSpecialWarningSpell(144328, nil, nil, nil, 2)
--Wavebinder Kardris
local specWarnToxicStorm			= mod:NewSpecialWarningYou(144017)--Spellid changed to force an option default reset. melee default was for ptr version that always targeted tank
local specWarnToxicStormNear		= mod:NewSpecialWarningClose(144005)
local yellToxicStorm				= mod:NewYell(144005)
local specWarnFoulGeyser			= mod:NewSpecialWarningSpell(143990)--Hard one to perfect. melee need to treat it as a move away, ranged as a switch. Can't really say both in the same message but I don't want to split it into two
local yellFoulGeyser				= mod:NewYell(143990)
local specWarnFallingAsh			= mod:NewSpecialWarningPreWarn(143973, nil, 3, nil, 2)
local specWarnIronPrison			= mod:NewSpecialWarningPreWarn(144330, nil, 4)--If this generic isn't too clear i'll localize it. this is warning that it's about to expire not that it's just been applied
local yellIronPrisonFades			= mod:NewYell(144330, L.PrisonYell, false)--Off by default since it's an atypical yell (it's not used for avoiding person it's used to get healer attention to person)

--Earthbreaker Haromm
local timerFroststormStrike			= mod:NewTargetTimer(30, 144215, nil, mod:IsTank())
local timerToxicMistsCD				= mod:NewCDTimer("OptionVersion2", 32, 144089, nil, false)--Pretty much a next timers unless boss is casting something else
local timerFoulStreamCD				= mod:NewCDTimer(32.5, 144090)--Pretty much a next timers unless boss is casting something else
local timerAshenWallCD				= mod:NewCDTimer(32.5, 144070)--Pretty much a next timers unless boss is casting something else
local timerIronTombCD				= mod:NewCDTimer(31.5, 144328)--Pretty much a next timers unless boss is casting something else
--Wavebinder Kardris
local timerToxicStormCD				= mod:NewCDTimer(32, 144005)--Pretty much a next timers unless boss is casting something else
local timerFoulGeyserCD				= mod:NewCDTimer(32.5, 143990)--Pretty much a next timers unless boss is casting something else
local timerFallingAsh				= mod:NewCastTimer(17, 143973)
local timerFallingAshCD				= mod:NewCDCountTimer(32.5, 143973)--Pretty much a next timers unless boss is casting something else
local timerIronPrison				= mod:NewTargetTimer(60, 144330, nil, mod:IsHealer())
local timerIronPrisonCD				= mod:NewCDTimer(31.5, 144330)--Pretty much a next timers unless boss is casting something else
local timerIronPrisonSelf			= mod:NewBuffFadesTimer(60, 144330)

local countdownFoulGeyser			= mod:NewCountdown("OptionVersion2", 32.5, 143990, mod:IsTank() or mod:IsRangedDps())
local countdownFallingAsh			= mod:NewCountdown("Alt15", 143973)

local berserkCD						= mod:NewCDTimer(540, 26662)

mod:AddRangeFrameOption(4, 143990)--This is more or less for foul geyser and foul stream splash damage
mod:AddSetIconOption("SetIconOnToxicMists", 144089, false)
mod:AddSetIconOption("SetIconOnFoulStream", 144090, false)

--Upvales, don't need variables
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local playerName = UnitName("player")
--Important, needs recover
mod.vb.ashCount = 0
--Doesn't need recovery
local showPrison = false
local showMist = false
local function clearCheckTankDistanceThrottle(spellId)
	if spellId == 144089 then
		showMist = false
	else
		showPrison = false
	end
end

function mod:FoulStreamTarget(targetname, uId)
	if not targetname then return end
	if self:IsTanking(uId) then--Never target tanks, so if target is tank, that means scanning failed.
		specWarnFoulStream:Show()
	else
		warnFoulStream:Show(targetname)
		timerFoulStreamCD:Start()
		if targetname == UnitName("player") then
			specWarnFoulStreamYou:Show()
			yellFoulStream:Yell()
		else
			specWarnFoulStream:Show()
		end
		if self.Options.SetIconOnFoulStream then
			self:SetIcon(args.destName, 8, 4)
		end
	end
end

function mod:ToxicStormTarget(targetname, uId)
	if not targetname then return end
	warnToxicStorm:Show(targetname)
	if targetname == UnitName("player") then
		specWarnToxicStorm:Show()
		yellToxicStorm:Yell()
	elseif self:CheckNearby(8, targetname) then
		specWarnToxicStormNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.ashCount = 0
	berserkCD:Start()
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144005 and self:CheckTankDistance(args.sourceGUID, 50) then
		self:BossTargetScanner(71858, "ToxicStormTarget", 0.05, 16)
		timerToxicStormCD:Start()
	elseif spellId == 144090 and self:CheckTankDistance(args.sourceGUID, 50) then
		self:BossTargetScanner(71859, "FoulStreamTarget", 0.05, 16)
	elseif spellId == 143990 and self:CheckTankDistance(args.sourceGUID, 50) then
		timerFoulGeyserCD:Start()
		specWarnFoulGeyser:Show()
		countdownFoulGeyser:Start()
	elseif spellId == 144070 and self:CheckTankDistance(args.sourceGUID, 30) then
		warnAshenWall:Show()
		timerAshenWallCD:Start()
		specWarnAshenWall:Show()
	elseif spellId == 143973 then--No filter, damages entire raid. / In split strat, this sometimes goes out of combatlog range. So use sync.
		self:SendSync("FallingAsh")
	elseif spellId == 144330 and self:CheckTankDistance(args.sourceGUID, 50) then
		timerIronPrisonCD:Start()
	elseif spellId == 144328 and self:CheckTankDistance(args.sourceGUID, 50) then
		warnIronTomb:Show()
		timerIronTombCD:Start()
		specWarnIronTomb:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 144288 and self:AntiSpam(2, 1) then
		warnPoisonmistTotem:Show()
	elseif spellId == 144289 and self:AntiSpam(2, 1) then
		warnFoulstreamTotem:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif spellId == 144290 and self:AntiSpam(2, 1) then
		warnAshflareTotem:Show()
	elseif spellId == 144291 and self:AntiSpam(2, 1) then
		warnRustedIronTotem:Show()
	elseif spellId == 143990 then
		if self:CheckTankDistance(args.sourceGUID, 50) then
			warnFoulGeyser:Show(args.destName)
		end
		if args:IsPlayer() then
			yellFoulGeyser:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif spellId == 144089 then
		--Filter warnings only
		if self:CheckTankDistance(args.sourceGUID, 50) and self:AntiSpam(2, 2) then
			showMist = true
			self:Schedule(2, clearCheckTankDistanceThrottle, spellId)
		end
		if showMist then
			warnToxicMists:CombinedShow(0.5, args.destName)
			timerToxicMistsCD:DelayedStart(0.5)
		end
		--Not filter icons, in case the only person with assist/icons enabled is far away.
		if self.Options.SetIconOnToxicMists and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			self:SetSortedIcon(0.5, args.destName, 1)
		end
	elseif spellId == 144330 then
		if self:CheckTankDistance(args.sourceGUID, 50) and self:AntiSpam(2, 3) then
			showPrison = true
			self:Schedule(2, clearCheckTankDistanceThrottle, spellId)
		end
		if showPrison then
			warnIronPrison:CombinedShow(0.5, args.destName)
			timerIronPrison:Start(args.destName)
		end
		if args:IsPlayer() then
			specWarnIronPrison:Schedule(56)
			timerIronPrisonSelf:Start()
			yellIronPrisonFades:Schedule(59, playerName, 1)
			yellIronPrisonFades:Schedule(58, playerName, 2)
			yellIronPrisonFades:Schedule(57, playerName, 3)
			yellIronPrisonFades:Schedule(56, playerName, 4)
			yellIronPrisonFades:Schedule(55, playerName, 5)
		end
	elseif spellId == 144215 then
		local amount = args.amount or 1
		timerFroststormStrike:Start(args.destName)
		if amount % 2 == 0 or amount >= 5 then
			warnFroststormStrike:Show(args.destName, amount)
		end
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnFroststormStrike:Show(amount)
			else
				specWarnFroststormStrikeOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
	elseif spellId == 144330 then
		timerIronPrison:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnIronPrison:Cancel()
			yellIronPrisonFades:Cancel()
			timerIronPrisonSelf:Cancel()
		end
	end
end

function mod:OnSync(msg)
	if msg == "FallingAsh" then
		self.vb.ashCount = self.vb.ashCount + 1
		warnFallingAsh:Show()
		timerFallingAsh:Start()
		if self:IsDifficulty("heroic10", "heroic25") then--On heroic, base spell 1 second cast, not 2.
			timerFallingAshCD:Start(16, self.vb.ashCount+1)
			specWarnFallingAsh:Schedule(13)--Give special warning 3 seconds before happens, not cast
			countdownFallingAsh:Start(16)
		else
			timerFallingAshCD:Start(nil, self.vb.ashCount+1)
			specWarnFallingAsh:Schedule(14)--Give special warning 3 seconds before happens, not cast
			countdownFallingAsh:Start(17)
		end
	end
end
