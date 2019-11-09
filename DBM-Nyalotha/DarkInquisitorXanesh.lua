local mod	= DBM:NewMod(2377, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(160229)
mod:SetEncounterID(2328)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 312336",
	"SPELL_CAST_SUCCESS 311551 306319",
	"SPELL_AURA_APPLIED 312406 314179 306311",
	"SPELL_AURA_APPLIED_DOSE 311551",
	"SPELL_AURA_REMOVED 312406",
	"SPELL_PERIODIC_DAMAGE 305575",
	"SPELL_PERIODIC_MISSED 305575",
	"CHAT_MSG_MONSTER_YELL"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnAbyssalStrike						= mod:NewStackAnnounce(311551, 2, nil, "Tank")
local warnVoidRitual						= mod:NewCountAnnounce(312336, 2)--Fallback if specwarn is disabled
local warnFanaticism						= mod:NewTargetNoFilterAnnounce(314179, 3, nil, "Tank|Healer")
local warnSummonRitualObelisk				= mod:NewCountAnnounce(306495, 2)
local warnSoulFlay							= mod:NewTargetAnnounce(306311, 2)

local specWarnVoidRitual					= mod:NewSpecialWarningCount(312336, false, nil, nil, 1, 2)--Option in, since only certain players may be assigned
local specWarnAbyssalStrike					= mod:NewSpecialWarningStack(311551, nil, 1, nil, nil, 1, 6)
local specWarnAbyssalStrikeTaunt			= mod:NewSpecialWarningTaunt(311551, nil, nil, nil, 1, 2)
local specWarnSoulFlay						= mod:NewSpecialWarningRun(306311, nil, nil, nil, 4, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerAbyssalStrikeCD					= mod:NewCDTimer(42.9, 311551, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)--42.9-47
local timerVoidRitualCD						= mod:NewNextCountTimer(79.7, 312336, nil, nil, nil, 5, nil, nil, nil, 1, 4)
local timerSummonRitualObeliskCD			= mod:NewNextCountTimer(79.7, 306495, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerSoulFlayCD						= mod:NewCDTimer(46.7, 306319, nil, nil, nil, 3)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(312406, true)
mod:AddSetIconOption("SetIconOnVoidWoken", 312406, true, false, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnChaoticGrowth", 296914)

mod.vb.ritualCount = 0
mod.vb.obeliskCount = 0
local voidWokenTargets = {}

local updateInfoFrame
do
	local voidWoken = DBM:GetSpellInfo(312406)
	local floor = math.floor
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--TODO, personal https://ptr.wowhead.com/spell=313198/void-touched tracker, if it has an actual duration?
		--Void Woken Targets
		if #voidWokenTargets > 0 then
			addLine("---"..voidWoken.."---")
			for i=1, #voidWokenTargets do
				local name = voidWokenTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, _, _, _, voidExpireTime = DBM:UnitDebuff("player", 312406)
					local voidRemaining = voidExpireTime-GetTime()
					if voidRemaining then
						local _, _, doomCount, _, _, doomExpireTime = DBM:UnitDebuff("player", 314298)
						if doomCount and doomExpireTime then--Has Imminent Doom count, show count and doom remaining
							local doomRemaining = doomExpireTime-GetTime()
							addLine(i.."*"..name, doomCount.."("..floor(doomRemaining)..")-"..floor(voidRemaining))
						else--no Doom, just show void stuff
							addLine(i.."*"..name, floor(voidRemaining))
						end
					end
				end
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.ritualCount = 0
	self.vb.obeliskCount = 0
	table.wipe(voidWokenTargets)
	if self:IsHard() then
		timerSummonRitualObeliskCD:Start(12-delay, 1)
	end
	timerSoulFlayCD:Start(14-delay)--SUCCESS
	timerAbyssalStrikeCD:Start(33.4-delay)--SUCCESS
	timerVoidRitualCD:Start(52.9-delay, 1)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
--	if self.Options.NPAuraOnChaoticGrowth then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnChaoticGrowth then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--function mod:OnTimerRecovery()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 312336 then
		self.vb.ritualCount = self.vb.ritualCount + 1
		if self.Options.SpecWarn312336count then
			specWarnVoidRitual:Show(self.vb.ritualCount)
			specWarnVoidRitual:Play("specialsoon")
		else
			warnVoidRitual:Show(self.vb.ritualCount)
		end
		timerVoidRitualCD:Start(79.7, self.vb.ritualCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 311551 then
		timerAbyssalStrikeCD:Start()
	elseif spellId == 306319 then
		timerSoulFlayCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 312406 then
		if not tContains(voidWokenTargets, args.destName) then
			table.insert(voidWokenTargets, args.destName)
		end
		if self.Options.SetIconOnVoidWoken then
			self:SetIcon(args.destName, #voidWokenTargets)
		end
	elseif spellId == 314179 then
		warnFanaticism:Show(args.destName)
	elseif spellId == 311551 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			specWarnAbyssalStrike:Show(amount)
			specWarnAbyssalStrike:Play("stackhigh")
		else
			if not UnitIsDeadOrGhost("player") then
				specWarnAbyssalStrikeTaunt:Show(args.destName)
				specWarnAbyssalStrikeTaunt:Play("tauntboss")
			else
				warnAbyssalStrike:Show(args.destName, amount)
			end
		end
	elseif spellId == 306311 then
		warnSoulFlay:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSoulFlay:Show()
			specWarnSoulFlay:Play("justrun")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 312406 then
		tDeleteItem(voidWokenTargets, args.destName)
		if self.Options.SetIconOnVoidWoken then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 305575 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
	--"<185.26 22:54:22> [CHAT_MSG_MONSTER_YELL] Obelisks of shadow, rise!#Dark Inquisitor Xanesh###Dark Inquisitor Xanesh##0#0##0#920#nil#0#false#false#false#false", -- [1338]
	local bossName = DBM:EJ_GetSectionInfo(20786)
	function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
		if not self:IsInCombat() then return end
		--Boss only targets himself during a yell for Obelisk spawns, any other yells he targets a playername, azshara, or nobody
		if msg == L.ObeliskSpawn then--Localized backup only if simply scanning auto translated target doesn't work forever or in all locals
			self.vb.obeliskCount = self.vb.obeliskCount + 1
			warnSummonRitualObelisk:Show(self.vb.obeliskCount)
			timerSummonRitualObeliskCD:Start(80, self.vb.obeliskCount+1)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152311 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 298689 then--Absorb Fluids

	end
end
--]]
