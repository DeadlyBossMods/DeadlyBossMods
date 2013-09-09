local mod	= DBM:NewMod(856, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71859, 71858)--haromm, Kardris
mod:SetZone()
mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Dogs
local warnRend						= mod:NewStackAnnounce(144304, 2)

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--85%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--65%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--45%
local warnRustedIronTotem			= mod:NewSpellAnnounce(144291, 3)--Heroic (95%)

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewStackAnnounce(144215, 2, nil, mod:IsTank())
local warnToxicMists				= mod:NewTargetAnnounce(144089, 3)
local warnFoulStream				= mod:NewTargetAnnounce(144090, 3)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 4)
local warnIronTomb					= mod:NewSpellAnnounce(144328, 3)
--Wavebinder Kardris
local warnFrostStormBolt			= mod:NewSpellAnnounce(144214, 2, nil, mod:IsTank())
local warnToxicStorm				= mod:NewSpellAnnounce(144005, 3)
local warnFoulGeyser				= mod:NewTargetAnnounce(143990, 4)
local warnFallingAsh				= mod:NewSpellAnnounce(143973, 3)
local warnIronPrison				= mod:NewTargetAnnounce(144330, 3)

--Earthbreaker Haromm
local specWarnFroststormStrikeCast	= mod:NewSpecialWarningSpell(144215, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnFroststormStrike		= mod:NewSpecialWarningStack(144215, mod:IsTank(), 6)
local specWarnFroststormStrikeOther	= mod:NewSpecialWarningTarget(144215, mod:IsTank())
local specWarnFoulStreamYou			= mod:NewSpecialWarningYou(144090)
local yellFoulStream				= mod:NewYell(144090)
local specWarnFoulStream			= mod:NewSpecialWarningSpell(144090, nil, nil, nil, 2)
local specWarnAshenWall				= mod:NewSpecialWarningSpell(144070, nil, nil, nil, 2)
local specWarnIronTomb				= mod:NewSpecialWarningSpell(144328, nil, nil, nil, 2)
--Wavebinder Kardris
local specWarnFrostStormBolt		= mod:NewSpecialWarningSpell(144214, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnToxicStorm			= mod:NewSpecialWarningSpell(144005, mod:IsMelee())
local specWarnFoulGeyser			= mod:NewSpecialWarningSpell(143990)
local yellFoulGeyser				= mod:NewYell(143990)
local specWarnFallingAsh			= mod:NewSpecialWarningSpell(143973, nil, nil, nil, 2)--Seems like an everyone waring.
local specWarnIronPrison			= mod:NewSpecialWarningSoon(144330)--If this generic isn't too clear i'll localize it. this is warning that it's about to expire not that it's just been applied
local yellIronPrisonFades			= mod:NewYell(144330, L.PrisonYell, false)--Off by default since it's an atypical yell (it's not used for avoiding person it's used to get healer attention to person)

--Earthbreaker Haromm
local timerFroststormStrike			= mod:NewTargetTimer(30, 144215, nil, mod:IsTank())
local timerFroststormStrikeCD		= mod:NewCDTimer(6, 144215, nil, mod:IsTank())
local timerToxicMistsCD				= mod:NewCDTimer(32, 144089)--Pretty much a next timers unless boss is casting something else
local timerFoulStreamCD				= mod:NewCDTimer(32.5, 144090)--Pretty much a next timers unless boss is casting something else
local timerAshenWallCD				= mod:NewCDTimer(32.5, 144070)--Pretty much a next timers unless boss is casting something else
local timerIronTombCD				= mod:NewCDTimer(31.5, 144328)--Pretty much a next timers unless boss is casting something else
--Wavebinder Kardris
local timerFrostStormBoltCD			= mod:NewCDTimer(6.8, 144214, nil, mod:IsTank())
local timerToxicStormCD				= mod:NewCDTimer(32, 144005)--Pretty much a next timers unless boss is casting something else
local timerFoulGeyserCD				= mod:NewCDTimer(32.5, 143990)--Pretty much a next timers unless boss is casting something else
local timerFallingAshCD				= mod:NewCDTimer(32.5, 143973)--Pretty much a next timers unless boss is casting something else
local timerIronPrisonCD				= mod:NewCDTimer(31.5, 144330)--Pretty much a next timers unless boss is casting something else
local timerIronPrison				= mod:NewBuffFadesTimer(60, 144330)

local countdownFoulGeyser			= mod:NewCountdown(32.5, 143990)
local countdownAshenWall			= mod:NewCountdown(32.5, 144070, nil, nil, nil, nil, true)

local berserkTimer					= mod:NewBerserkTimer(540)

mod:AddBoolOption("RangeFrame")--This is more or less for foul geyser and foul stream splash damage
mod:AddBoolOption("SetIconOnToxicMists", false)

local toxicMistsTargets = {}
local toxicMistsTargetsIcons = {}
local ironPrisonTargets = {}
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local playerName = UnitName("player")

local function warnToxicMistTargets()
	warnToxicMists:Show(table.concat(toxicMistsTargets, "<, >"))
	timerToxicMistsCD:Start()
	table.wipe(toxicMistsTargets)
end

local function warnIronPrisonTargets()
	warnIronPrison:Show(table.concat(ironPrisonTargets, "<, >"))
	table.wipe(ironPrisonTargets)
end

local function ClearToxicMistTargets()
	table.wipe(toxicMistsTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetToxicIcons()
		table.sort(toxicMistsTargetsIcons, sort_by_group)
		local toxicIcon = 1
		for i, v in ipairs(toxicMistsTargetsIcons) do
			self:SetIcon(v, toxicIcon)
			toxicIcon = toxicIcon + 1
		end
		self:Schedule(1.5, ClearToxicMistTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
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
			if self:checkTankDistance(71859) then
				specWarnFoulStream:Show()
			end
		end
	end
end

function mod:ToxicStormTarget(targetname, uId)
	if not targetname then 
		print("DBM DEBUG: Target scanning Failed")
		return
	else
		print("DBM DEBUG: ToxicStormTarget returned "..targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(toxicMistsTargets)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144214 then
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				warnFrostStormBolt:Show()
				specWarnFrostStormBolt:Show()
				timerFrostStormBoltCD:Start()
			end
		end
	elseif args.spellId == 144005 then
		self:BossTargetScanner(71858, "ToxicStormTarget", 0.025, 12)
		warnToxicStorm:Show()
		timerToxicStormCD:Start()
		if self:checkTankDistance(args:GetSrcCreatureID()) then
			specWarnToxicStorm:Show()
		end
	elseif args.spellId == 144090 then
		self:BossTargetScanner(71859, "FoulStreamTarget", 0.025, 12)
	elseif args.spellId == 143990 then
		timerFoulGeyserCD:Start()
		if self:checkTankDistance(args:GetSrcCreatureID()) then
			specWarnFoulGeyser:Show()
			countdownFoulGeyser:Start()
		end
	elseif args.spellId == 144070 then
		warnAshenWall:Show()
		timerAshenWallCD:Start()
		if self:checkTankDistance(args:GetSrcCreatureID()) then--Now we know who is tanking that boss
			specWarnAshenWall:Show()--Give special warning cause this ability concerns you
		end
	elseif args.spellId == 143973 then
		warnFallingAsh:Show()
		timerFallingAshCD:Start()
		if self:checkTankDistance(args:GetSrcCreatureID()) then--Now we know who is tanking that boss
			specWarnFallingAsh:Show()--Give special warning cause this ability concerns you
		end
	elseif args.spellId == 144330 then
		warnIronPrison:Show()
		timerIronPrisonCD:Start()
	elseif args.spellId == 144328 then
		warnIronTomb:Show()
		timerIronTombCD:Start()
		specWarnIronTomb:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144288 and self:AntiSpam() then
		warnPoisonmistTotem:Show()
	elseif args.spellId == 144289 and self:AntiSpam() then
		warnFoulstreamTotem:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif args.spellId == 144290 and self:AntiSpam() then
		warnAshflareTotem:Show()
	elseif args.spellId == 144291 and self:AntiSpam() then
		warnRustedIronTotem:Show()
	elseif args.spellId == 144215 and args.sourceName == UnitName("target") then
		for i = 1, 2 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnFroststormStrikeCast:Schedule(4)
				timerFroststormStrikeCD:Start()
			end
		end
	elseif args.spellId == 143990 then
		warnFoulGeyser:Show(args.destName)
		if args:IsPlayer() then
			yellFoulGeyser:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif args.spellId == 144089 then
		toxicMistsTargets[#toxicMistsTargets + 1] = args.destName
		self:Unschedule(warnToxicMistTargets)
		self:Schedule(0.5, warnToxicMistTargets)
		if self.Options.SetIconOnToxicMists and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(toxicMistsTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetToxicIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetToxicIcons")
			end
		end
	elseif args.spellId == 144330 then
		ironPrisonTargets[#ironPrisonTargets + 1] = args.destName
		self:Unschedule(warnIronPrisonTargets)
		self:Schedule(0.5, warnIronPrisonTargets)
	elseif args.spellId == 144215 then
		local amount = args.amount or 1
		timerFroststormStrike:Start(args.destName)
		if amount % 2 == 0 then
			warnFroststormStrike:Show(args.destName, amount)
		end
		if amount >= 6 then
			if args:IsPlayer() then
				specWarnFroststormStrike:Show(amount)
			else
				specWarnFroststormStrikeOther:Show(args.destName)
			end
		end
	elseif args.spellId == 144330 and args:IsPlayer() then
		specWarnIronPrison:Schedule(5)
		timerIronPrison:Start()
		yellIronPrisonFades:Schedule(59, playerName, 1)
		yellIronPrisonFades:Schedule(58, playerName, 2)
		yellIronPrisonFades:Schedule(57, playerName, 3)
		yellIronPrisonFades:Schedule(56, playerName, 4)
		yellIronPrisonFades:Schedule(55, playerName, 5)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
	elseif args.spellId == 144330 and args:IsPlayer() then
		specWarnIronPrison:Cancel()
		yellIronPrisonFades:Cancel()
		timerIronPrison:Cancel()
	end
end
