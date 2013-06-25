local mod	= DBM:NewMod(856, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71859, 71858)--haromm, Kardris
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

--Dogs
local warnRend						= mod:NewStackAnnounce(144304, 2)--Dont have an idea of frequently yet so just a general anounce for now. tank warnings later

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--90%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--80%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--70%
--local warnRustedIronTotem			= mod:NewSpellAnnounce(144290, 3)--Heroic

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewTargetAnnounce(144215, 2)--Not tank flagged, but probably tank debuff, leaving for everyone just in case though. this plus FrostStorm Bolt= one dead MF
local warnToxicMists				= mod:NewTargetAnnounce(144089, 3)
local warnFoulStream				= mod:NewSpellAnnounce(144090, 3)--Check if targetscanning will work here (or if spell itself has a target emote or something)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 4)
--Wavebinder Kardris
local warnFrostStormBolt			= mod:NewSpellAnnounce(144214, 2)--Who is this cast on? random people or active tank?
local warnToxicStorm				= mod:NewTargetAnnounce(144005, 3)
local warnFoulGeyser				= mod:NewSpellAnnounce(143990, 4)--This may be cast on an actual target player instead of location, as such some changes will be needed
local warnFallingAsh				= mod:NewSpellAnnounce(143973, 3)

--Earthbreaker Haromm
local specWarnFroststormStrike		= mod:NewSpecialWarningSpell(144215, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnFoulStream			= mod:NewSpecialWarningSpell(144090)
local specWarnAshenWall				= mod:NewSpecialWarningSpell(144070, nil, nil, nil, 2)
--Wavebinder Kardris
local specWarnFrostStormBolt		= mod:NewSpecialWarningSpell(144214, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnToxicStorm			= mod:NewSpecialWarningSpell(144005, mod:IsMelee())
local specWarnFoulGeyser			= mod:NewSpecialWarningSpell(143990)
local specWarnFallingAsh			= mod:NewSpecialWarningSpell(143973, nil, nil, nil, 2)--Seems like an everyone waring.

--Earthbreaker Haromm
local timerFroststormStrikeCD		= mod:NewNextTimer(6, 144215, nil, mod:IsTank())
local timerToxicMistsCD				= mod:NewNextTimer(30, 144089)
local timerFoulStreamCD				= mod:NewNextTimer(32.5, 144090)
local timerAshenWallCD				= mod:NewNextTimer(32.5, 144070)
--Wavebinder Kardris
local timerFrostStormBoltCD			= mod:NewNextTimer(7.2, 144214)
local timerToxicStormCD				= mod:NewNextTimer(30, 144005)
local timerFoulGeyserCD				= mod:NewNextTimer(32.5, 143990)
local timerFallingAshCD				= mod:NewNextTimer(32.5, 143973)

local countdownFoulGeyser			= mod:NewCountdown(32.5, 143990)
local countdownAshenWall			= mod:NewCountdown(32.5, 144070, nil, nil, nil, nil, true)

mod:AddBoolOption("RangeFrame")--This is more or less for foul geyser and foul stream splash damage
mod:AddBoolOption("SetIconOnToxicMists", false)

local toxicMistsTargets = {}
local toxicMistsTargetsIcons = {}

local function warnToxicMistTargets()
	warnToxicMists:Show(table.concat(toxicMistsTargets, "<, >"))
	timerToxicMistsCD:Start()
	table.wipe(toxicMistsTargets)
end

local function ClearToxicMistTargets()
	table.wipe(toxicMistsTargetsIcons)
end

--Auto detection of "tank them apart" strategy. if you keep them > 40 yards apart like we did, abilities other casts do not concern you.
local function checkTankDistance(cid)
	local _, uId = mod:GetBossTarget(cid)
	if uId then--Now we know who is tanking that boss
		local x, y = GetPlayerMapPosition(uId)
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition(uId)
		end
		local inRange = DBM.RangeCheck:GetDistance("player", x, y)--We check how far we are from the tank who has that boss
		if (inRange and inRange < 40) or (x == 0 and y == 0) then--You are near the person tanking boss
			return true
		end
	end
	return false
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

function mod:OnCombatStart(delay)
	table.wipe(toxicMistsTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144214 and args.sourceName == UnitName("target") then
		warnFrostStormBolt:Show()
		specWarnFrostStormBolt:Show()
		timerFrostStormBoltCD:Start()
	elseif args.spellId == 144005 then
		warnToxicStorm:Show()
		timerToxicStormCD:Start()
		if checkTankDistance(args:GetSrcCreatureID()) then
			specWarnToxicStorm:Show()
		end
	elseif args.spellId == 144090 then
		warnFoulStream:Show()
		timerFoulStreamCD:Start()
		if checkTankDistance(args:GetSrcCreatureID()) then
			specWarnFoulStream:Show()
		end
	elseif args.spellId == 143990 then
		warnFoulGeyser:Show()
		timerFoulGeyserCD:Start()
		if checkTankDistance(args:GetSrcCreatureID()) then
			specWarnFoulGeyser:Show()
			countdownFoulGeyser:Start()
		end
	elseif args.spellId == 144070 then
		warnAshenWall:Show()
		timerAshenWallCD:Start()
		if checkTankDistance(args:GetSrcCreatureID()) then--Now we know who is tanking that boss
			specWarnAshenWall:Show()--Give special warning cause this ability concerns you
		end
	elseif args.spellId == 143973 then
		warnFallingAsh:Show()
		timerFallingAshCD:Start()
		if checkTankDistance(args:GetSrcCreatureID()) then--Now we know who is tanking that boss
			specWarnFallingAsh:Show()--Give special warning cause this ability concerns you
		end
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
	elseif args.spellId == 144215 and args.sourceName == UnitName("target") then
		warnFroststormStrike:Show()
		specWarnFroststormStrike:Schedule(4)--Instant cast, but since it's a 6 second NEXT timer, we can fake a cast and make this special warning a cast warning for tanks to time active mitigation
		timerFroststormStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif args.spellId == 144089 and not args:IsDestTypeHostile() then
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
	end
end
