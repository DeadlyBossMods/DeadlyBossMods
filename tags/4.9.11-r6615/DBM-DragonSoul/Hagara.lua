if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

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
local warnAssault			= mod:NewSpellAnnounce(107851, 4, nil, mod:IsHealer() or mod:IsTank())
local warnShatteringIce		= mod:NewTargetAnnounce(105289, 3, nil, mod:IsHealer())--3 second cast, give a healer a heads up of who's about to be kicked in the face.
local warnFrostTomb			= mod:NewTargetAnnounce(104451, 4)

local specWarnTempest		= mod:NewSpecialWarningSpell(109552, nil, nil, nil, true)
local specWarnAssault		= mod:NewSpecialWarningSpell(107851, mod:IsTank())
local specWarnFrostTomb		= mod:NewSpecialWarningYou(104451)

local timerAssault			= mod:NewBuffActiveTimer(5, 107851, nil, mod:IsTank() or mod:IsTank())
local timerAssaultCD		= mod:NewCDTimer(15.5, 107851, nil, mod:IsTank() or mod:IsTank())

--local soundFrostTomb		= mod:NewSound(104451)--Needed?

mod:AddBoolOption("SetIconOnFrostTomb", true)
mod:AddBoolOption("AnnounceFrostTombIcons", false)
--mod:AddBoolOption("RangeFrame")--Needed?

local tombTargets = {}
local tombIconTargets = {}
--local playerTombed = false

function mod:ShatteredIceTarget()
	local targetname = self:GetBossTarget(55689)
	if not targetname then return end
	warnShatteringIce:Show(targetname)
end

function mod:OnCombatStart(delay)
	timerAssaultCD(4-delay)--Consistent?
--	berserkTimer:Start(-delay)
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
		self:Unschedule(warnBeaconTargets)
		if (self:IsDifficulty("normal25") and #tombTargets >= 5) or (self:IsDifficulty("heroic25") and #tombTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombTargets >= 2) then
			warnTombTargets()
		else
			self:Schedule(0.3, warnTombTargets)
		end
	elseif args:IsSpellID(107851) then--107851 25 man normal confirmed.
		warnAssault:Show()
		timerAssault:Start()
		timerAssaultCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104451) and self.Options.SetIconOnFrostTomb then--104451 25 man normal confirmed.
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(105256, 109552, 109553, 109554) then--109552 25man normal confirmed, rest wowhead drycodes
		timerAssaultCD:Cancel()
		warnTempest:Show()
		specWarnTempest:Show()
	elseif args:IsSpellID(105289, 108567) then--105289 25 man normal confirmed.
		self:ScheduleMethod(0.2, "ShatteredIceTarget")
	end
end
