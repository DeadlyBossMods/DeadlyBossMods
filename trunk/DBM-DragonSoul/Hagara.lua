local mod	= DBM:NewMod(317, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55689)
mod:SetModelID(39318)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnTempest			= mod:NewCastAnnounce(109552, 4)
local warnLightningStorm	= mod:NewSpellAnnounce(105465, 4)
local warnAssault			= mod:NewSpellAnnounce(107851, 4, nil, mod:IsHealer() or mod:IsTank())
local warnShatteringIce		= mod:NewTargetAnnounce(105289, 3, nil, mod:IsHealer())--3 second cast, give a healer a heads up of who's about to be kicked in the face.
local warnFrostTombCast		= mod:NewAnnounce("warnFrostTombCast", 4, 104448)--Can't use a generic, cause it's an 8 second cast even though it says 1second in tooltip.
local warnFrostTomb			= mod:NewTargetAnnounce(104451, 4)
local warnIceLance			= mod:NewTargetAnnounce(105269, 3)

local specWarnFrostTombCast	= mod:NewSpecialWarningSpell(104448, nil, nil, nil, true)
local specWarnTempest		= mod:NewSpecialWarningSpell(109552, nil, nil, nil, true)
local specWarnLightingStorm	= mod:NewSpecialWarningSpell(105465, nil, nil, nil, true)
local specWarnAssault		= mod:NewSpecialWarningSpell(107851, mod:IsTank())
local specWarnFrostTomb		= mod:NewSpecialWarningYou(104451)

local timerFrostTomb		= mod:NewCastTimer(8, 104448)
local timerFrostTombCD		= mod:NewNextTimer(20, 104451)
local timerIceLanceCD		= mod:NewCDTimer(12, 105269)
local timerSpecialCD		= mod:NewTimer(62, "TimerSpecial", "Interface\\Icons\\Spell_Nature_WispSplode")
local timerTempestCD		= mod:NewCDTimer(62, 105256)
local timerLightningStormCD	= mod:NewCDTimer(62, 105465)
local timerAssault			= mod:NewBuffActiveTimer(5, 107851, nil, mod:IsTank() or mod:IsTank())
local timerAssaultCD		= mod:NewCDTimer(15.5, 107851, nil, mod:IsTank() or mod:IsTank())

--local soundFrostTomb		= mod:NewSound(104451)--Needed?

mod:AddBoolOption("RangeFrame")--Ice lance spreading. May make it more dynamic later but for now i need to see the fight in realtime before i can do any more guessing off mailed in combat logs.
mod:AddBoolOption("SetIconOnFrostTomb", true)
mod:AddBoolOption("AnnounceFrostTombIcons", false)

local lanceTargets = {}
local tombTargets = {}
local tombIconTargets = {}
--local playerTombed = false

function mod:ShatteredIceTarget()
	local targetname = self:GetBossTarget(55689)
	if not targetname then return end
	warnShatteringIce:Show(targetname)
end

function mod:OnCombatStart(delay)
	table.wipe(lanceTargets)
	table.wipe(tombIconTargets)
	table.wipe(tombTargets)
	timerAssaultCD:Start(4-delay)
	timerIceLanceCD:Start(-delay)
--	timerFrostTombCD:Start(16-delay)--No longer cast on engage? most recent log she only casts it after specials now and not after pull
	timerSpecialCD:Start(30-delay)
--	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function warnLanceTargets()
	warnIceLance:Show(table.concat(lanceTargets, "<, >"))
	table.wipe(lanceTargets)
end

local function ClearTombTargets()
	table.wipe(tombIconTargets)
--[[	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end--]]
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
--[[	if mod.Options.RangeFrame then
		if not playerTombed then
			DBM.RangeCheck:Show(10, GetRaidTargetIndex)
		else
			DBM.RangeCheck:Show(10)
		end
	end--]]
	warnFrostTomb:Show(table.concat(tombTargets, "<, >"))
	table.wipe(tombTargets)
--	playertombed = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104451) then--104451 25 man normal confirmed.
		tombTargets[#tombTargets + 1] = args.destName
		if args:IsPlayer() then
--			playerTombed = true
			specWarnFrostTomb:Show()
--			soundFrostTomb:Play("Sound\\Creature\\Illidan\\BLACK_Illidan_04.wav")
		end
		if self.Options.SetIconOnFrostTomb then
			table.insert(tombIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetTombIcons")
			--know 25 normal is 5, the rest are just guessed based on similar mechanic off Sindragosa
			if (self:IsDifficulty("normal25") and #tombIconTargets >= 5) or (self:IsDifficulty("heroic25") and #tombIconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombIconTargets >= 2) then
				self:SetTombIcons()--Sort and fire as early as possible once we have all targets.
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
	elseif args:IsSpellID(107851, 110900) then--107851 10/25 man normal confirmed. 110900 is lfr25 difficulty.
		warnAssault:Show()
		timerAssault:Start()
		timerAssaultCD:Start()
	elseif args:IsSpellID(105269) then--105269 10 man normal confirmed.
		lanceTargets[#lanceTargets + 1] = args.destName
		self:Unschedule(warnLanceTargets)
		self:Schedule(0.5, warnLanceTargets)--Maybe adjust timing to allow for more combining of people failing at spreading?
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104451) and self.Options.SetIconOnFrostTomb then--104451 10/25 man normal confirmed.
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(105256, 109552, 109553, 109554) then--Tempest
		timerIceLanceCD:Start()
		timerFrostTombCD:Start()
		timerAssaultCD:Start(20)
		timerLightningStormCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)
		end
	elseif args:IsSpellID(105409, 109560, 109561, 109562) then--Water Shield
		timerIceLanceCD:Start()
		if not self:IsDifficulty("lfr25") then--Not used in LFR?
			timerFrostTombCD:Start()
		end
		timerAssaultCD:Start(20)
		timerTempestCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(104448) then
		warnFrostTombCast:Show()
		specWarnFrostTombCast:Show()
		timerFrostTomb:Start()
	elseif args:IsSpellID(105256, 109552, 109553, 109554) then--109552 25man normal confirmed, rest wowhead drycodes
		timerAssaultCD:Cancel()
		warnTempest:Show()
		specWarnTempest:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(105409, 109560, 109561, 109562) then--Water Shield
		timerAssaultCD:Cancel()
		warnLightningStorm:Show()
		specWarnLightingStorm:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(105289, 108567) then--105289 10/25 man normal confirmed.
		self:ScheduleMethod(0.2, "ShatteredIceTarget")
	end
end
