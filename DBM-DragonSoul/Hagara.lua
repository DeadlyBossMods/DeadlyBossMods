local mod	= DBM:NewMod(317, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55689)
mod:SetModelID(39318)
mod:SetZone()
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnAssault			= mod:NewCountAnnounce(107851, 4, nil, mod:IsHealer() or mod:IsTank())
local warnShatteringIce		= mod:NewTargetAnnounce(105289, 3, nil, mod:IsHealer())--3 second cast, give a healer a heads up of who's about to be kicked in the face.
local warnIceLance			= mod:NewTargetAnnounce(105269, 3)
local warnFrostTombCast		= mod:NewAnnounce("warnFrostTombCast", 4, 104448)--Can't use a generic, cause it's an 8 second cast even though it says 1second in tooltip.
local warnFrostTomb			= mod:NewTargetAnnounce(104451, 4)
local warnTempest			= mod:NewSpellAnnounce(109552, 4)
local warnLightningStorm	= mod:NewSpellAnnounce(105465, 4)
local warnFrostflake		= mod:NewTargetAnnounce(109325, 3, nil, mod:IsHealer())--Spammy, only a dispeller really needs to know this, probably a healer assigned to managing it.
local warnStormPillars		= mod:NewSpellAnnounce(109557, 3, nil, false)--Spammy, off by default (since we can't get a target anyways.
local warnPillars			= mod:NewAnnounce("WarnPillars", 2, 105311)

local specWarnAssault		= mod:NewSpecialWarningSpell(107851, mod:IsTank())
local specWarnShattering	= mod:NewSpecialWarningYou(105289, false)
local specWarnIceLance		= mod:NewSpecialWarningStack(107061, nil, 3)
local specWarnFrostTombCast	= mod:NewSpecialWarningSpell(104448, nil, nil, nil, true)
local specWarnTempest		= mod:NewSpecialWarningSpell(109552, nil, nil, nil, true)
local specWarnLightingStorm	= mod:NewSpecialWarningSpell(105465, nil, nil, nil, true)
local specWarnWatery		= mod:NewSpecialWarningMove(110317)
local specWarnFrostflake	= mod:NewSpecialWarningYou(109325)
local yellFrostflake		= mod:NewYell(109325)

local timerAssault			= mod:NewBuffActiveTimer(5, 107851, nil, mod:IsTank() or mod:IsHealer())
local timerAssaultCD		= mod:NewCDCountTimer(15.5, 107851, nil, mod:IsTank() or mod:IsHealer())
local timerShatteringCD		= mod:NewCDTimer(10.5, 105289)--every 10.5-15 seconds
local timerIceLance			= mod:NewBuffActiveTimer(15, 105269)
local timerIceLanceCD		= mod:NewNextTimer(30, 105269)
local timerFrostTomb		= mod:NewCastTimer(8, 104448)
local timerFrostTombCD		= mod:NewNextTimer(20, 104451)
local timerSpecialCD		= mod:NewTimer(62, "TimerSpecial", "Interface\\Icons\\Spell_Nature_WispSplode")
local timerTempestCD		= mod:NewNextTimer(62, 105256)
local timerLightningStormCD	= mod:NewNextTimer(62, 105465)
local timerFrostFlakeCD		= mod:NewNextTimer(5, 109325)--^
local timerStormPillarCD	= mod:NewNextTimer(5, 109557)--Both of these are just spammed every 5 seconds on new targets.
local timerFeedback			= mod:NewBuffActiveTimer(15, 108934)

local berserkTimer			= mod:NewBerserkTimer(480)

local countdownSpecial		= mod:NewCountdown(62, 105256, true, L.SpecialCount)

mod:AddBoolOption("RangeFrame")--Ice lance spreading in ice phases, and lighting linking in lighting phases (with reverse intent, staying within 10 yards, not out of 10 yards)
mod:AddBoolOption("SetIconOnFrostflake", false)--You can use an icon if you want, but this is cast on a new target every 5 seconds, often times on 25 man 2-3 have it at same time while finding a good place to drop it.
mod:AddBoolOption("SetIconOnFrostTomb", true)
mod:AddBoolOption("AnnounceFrostTombIcons", false)
mod:AddBoolOption("SetBubbles", true)--because chat bubble hides Ice Tomb target indication if bubbles are on.

local lanceTargets = {}
local tombTargets = {}
local tombIconTargets = {}
local firstPhase = true
local iceFired = false
local assaultCount = 0
local pillarsRemaining = 4
local frostPillar = EJ_GetSectionInfo(4069)
local lightningPillar = EJ_GetSectionInfo(3919)
local CVAR = false

function mod:ShatteredIceTarget()
	local targetname = self:GetBossTarget(55689)
	if not targetname then return end
	warnShatteringIce:Show(targetname)
	timerShatteringCD:Start()
	if UnitName("player") == targetname then
		specWarnShattering:Show()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(lanceTargets)
	table.wipe(tombIconTargets)
	table.wipe(tombTargets)
	firstPhase = true
	iceFired = false
	assaultCount = 0
	timerAssaultCD:Start(4-delay, 1)
	timerIceLanceCD:Start(10-delay)
	timerSpecialCD:Start(30-delay)
	countdownSpecial:Start(30-delay)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Show(3)
	end
end

function mod:OnCombatEnd()
	firstPhase = true
	if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
		SetCVar("chatBubbles", 1)
		CVAR = false
	end
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Hide()
	end
end

local function warnLanceTargets()
	warnIceLance:Show(table.concat(lanceTargets, "<, >"))
	timerIceLance:Start()
	if not firstPhase and not iceFired then
		timerIceLanceCD:Start()
	end
	iceFired = true
	table.wipe(lanceTargets)
end

local function ClearTombTargets()
	table.wipe(tombIconTargets)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetTombIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(tombIconTargets, sort_by_group)
			local tombIcons = 8
			for i, v in ipairs(tombIconTargets) do
				if self.Options.AnnounceFrostTombIcons and IsRaidLeader() then
					SendChatMessage(L.TombIconSet:format(tombIcons, UnitName(v)), "RAID")
				end
				self:SetIcon(UnitName(v), tombIcons)
				tombIcons = tombIcons - 1
			end
			self:Schedule(8, ClearTombTargets)
		end
	end
end

local function warnTombTargets()
	warnFrostTomb:Show(table.concat(tombTargets, "<, >"))
	table.wipe(tombTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104451) then
		tombTargets[#tombTargets + 1] = args.destName
		if self.Options.SetIconOnFrostTomb then
			table.insert(tombIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetTombIcons")
			if (self:IsDifficulty("normal25") and #tombIconTargets >= 5) or (self:IsDifficulty("heroic25") and #tombIconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombIconTargets >= 2) then
				self:SetTombIcons()
			else
				if self:LatencyCheck() then--Icon sorting is still sensitive and should not be done by laggy members that don't have all targets.
					self:ScheduleMethod(0.3, "SetTombIcons")
				end
			end
		end
		self:Unschedule(warnTombTargets)
		if (self:IsDifficulty("normal25") and #tombTargets >= 5) or (self:IsDifficulty("heroic25") and #tombTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombTargets >= 2) then
			warnTombTargets()
		else
			self:Schedule(0.3, warnTombTargets)
		end
	elseif args:IsSpellID(107851, 110898, 110899, 110900) then
		assaultCount = assaultCount + 1
		warnAssault:Show(assaultCount)
		specWarnAssault:Show()
		timerAssault:Start()
		if (firstPhase and assaultCount < 2) or (not firstPhase and assaultCount < 3) then
			timerAssaultCD:Start(nil, assaultCount+1)
		end
	elseif args:IsSpellID(110317) and args:IsPlayer() then
		specWarnWatery:Show()
	elseif args:IsSpellID(109325) then
		warnFrostflake:Show(args.destName)
		timerFrostFlakeCD:Start()
		if args:IsPlayer() then
			specWarnFrostflake:Show()
			yellFrostflake:Yell()
		end
		if self.Options.SetIconOnFrostflake then
			self:SetIcon(args.destName, 3)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(105316, 107061, 107062, 107063) then
		if ((self:IsDifficulty("lfr25") and args.amount % 6 == 0) or (not self:IsDifficulty("lfr25") and args.amount % 3 == 0)) and args:IsPlayer() then--Warn every 3 stacks (6 stacks in LFR), don't want to spam TOO much.
			specWarnIceLance:Show(args.amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104451) and self.Options.SetIconOnFrostTomb then
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(105256, 109552, 109553, 109554) then--Tempest
		timerFrostFlakeCD:Cancel()
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		timerLightningStormCD:Start()
		countdownSpecial:Start(62)
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			CVAR = true
			SetCVar("chatBubbles", 0)
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Show(3)
		end
	elseif args:IsSpellID(105409, 109560, 109561, 109562) then--Water Shield
		timerStormPillarCD:Cancel()
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		timerTempestCD:Start()
		countdownSpecial:Start(62)
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			CVAR = true
			SetCVar("chatBubbles", 0)
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Show(3)
		end
	elseif args:IsSpellID(105311) then--Frost defeated.
		pillarsRemaining = pillarsRemaining - 1
		warnPillars:Show(frostPillar, pillarsRemaining)
	elseif args:IsSpellID(105482) then--Lighting defeated.
		pillarsRemaining = pillarsRemaining - 1
		warnPillars:Show(lightningPillar, pillarsRemaining)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(104448) then
		warnFrostTombCast:Show(args.spellName)
		specWarnFrostTombCast:Show()
		timerFrostTomb:Start()
	elseif args:IsSpellID(105256, 109552, 109553, 109554) then--Tempest
		pillarsRemaining = 4
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		warnTempest:Show()
		specWarnTempest:Show()
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(105409, 109560, 109561, 109562) then--Water Shield
		if self:IsDifficulty("heroic10") then
			pillarsRemaining = 8
		else
			pillarsRemaining = 4
		end
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		warnLightningStorm:Show()
		specWarnLightingStorm:Show()
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Show(10)
		end
	elseif args:IsSpellID(105289, 108567, 110887, 110888) then
		self:ScheduleMethod(0.2, "ShatteredIceTarget")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(109557) then
		warnStormPillars:Show()
		timerStormPillarCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(105297) then
		lanceTargets[#lanceTargets + 1] = args.sourceName
		self:Unschedule(warnLanceTargets)
		self:Schedule(0.5, warnLanceTargets)
	end
end