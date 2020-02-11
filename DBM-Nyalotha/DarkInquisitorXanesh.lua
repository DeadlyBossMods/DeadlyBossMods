local mod	= DBM:NewMod(2377, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(156575)
mod:SetEncounterID(2328)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20200128000000)--2020, 1, 28
mod:SetMinSyncRevision(20200128000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 312336 316211",
	"SPELL_CAST_SUCCESS 311551 306319 306208",
	"SPELL_AURA_APPLIED 312406 314179 306311 311551",
	"SPELL_AURA_APPLIED_DOSE 311551",
	"SPELL_AURA_REMOVED 312406",
	"SPELL_PERIODIC_DAMAGE 305575",
	"SPELL_PERIODIC_MISSED 305575",
	"CHAT_MSG_MONSTER_YELL"
--	"UNIT_DIED"
)

--TODO, add https://ptr.wowhead.com/spell=313198/void-touched when it's put in combat log
--[[
(ability.id = 312336 or ability.id = 316211) and type = "begincast"
 or (ability.id = 311551 or ability.id = 306319 or ability.id = 306208) and type = "cast"
--]]
local warnAbyssalStrike						= mod:NewStackAnnounce(311551, 2, nil, "Tank")
local warnVoidRitual						= mod:NewCountAnnounce(312336, 2)--Fallback if specwarn is disabled
local warnFanaticism						= mod:NewTargetNoFilterAnnounce(314179, 3, nil, "Tank|Healer")
local warnSummonRitualObelisk				= mod:NewCountAnnounce(306495, 2)
local warnSoulFlay							= mod:NewTargetAnnounce(306311, 2)

local specWarnVoidRitual					= mod:NewSpecialWarningCount(312336, false, nil, nil, 1, 2)--Option in, since only certain players may be assigned
local specWarnAbyssalStrike					= mod:NewSpecialWarningStack(311551, nil, 2, nil, nil, 1, 6)
local specWarnAbyssalStrikeTaunt			= mod:NewSpecialWarningTaunt(311551, nil, nil, nil, 1, 2)
local specWarnSoulFlay						= mod:NewSpecialWarningRun(306311, nil, nil, nil, 4, 2)
local specWarnTorment						= mod:NewSpecialWarningDodgeCount(306208, nil, nil, nil, 2, 2)
local specWarnTerrorWave					= mod:NewSpecialWarningInterruptCount(316211, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

local timerAbyssalStrikeCD					= mod:NewCDTimer(40, 311551, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--42.9-47
local timerVoidRitualCD						= mod:NewNextCountTimer(79.7, 312336, nil, nil, nil, 5, nil, nil, nil, 1, 4)
local timerSoulFlayCD						= mod:NewCDTimer(57, 306319, nil, nil, nil, 3)--57 but will spell queue behind other spells
local timerTormentCD						= mod:NewNextCountTimer(46.5, 306208, nil, nil, nil, 3, nil, nil, nil, 3, 4)

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(312406, true)
mod:AddSetIconOption("SetIconOnVoidWoken2", 312406, false, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnAdds", "ej21227", true, true, {4, 5, 6, 7, 8})
mod:AddMiscLine(DBM_CORE_OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("InterruptBehavior", {"Four", "Five", "Six", "NoReset"}, "Four", "misc")

mod.vb.ritualCount = 0
mod.vb.obeliskCount = 0
mod.vb.tormentCount = 0
mod.vb.addIcon = 8
mod.vb.interruptBehavior = "Four"
local voidWokenTargets = {}
local castsPerGUID = {}

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
		--Void Woken Targets
		if #voidWokenTargets > 0 then
			addLine("---"..voidWoken.."---")
			for i=1, #voidWokenTargets do
				local name = voidWokenTargets[i]
				local uId = DBM:GetRaidUnitId(name)
				if uId then
					local _, _, _, _, _, voidExpireTime = DBM:UnitDebuff(uId, 312406)
					if voidExpireTime then
						local voidRemaining = voidExpireTime-GetTime()
						local _, _, doomCount, _, _, doomExpireTime = DBM:UnitDebuff(uId, 314298)
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
	self.vb.tormentCount = 0
	self.vb.addIcon = 8
	self.vb.interruptBehavior = self.Options.InterruptBehavior--Default it to whatever user has it set to, until group leader overrides it
	table.wipe(voidWokenTargets)
	table.wipe(castsPerGUID)
	timerAbyssalStrikeCD:Start(30-delay)--START
	if self:IsMythic() then
		timerVoidRitualCD:Start(18.1-delay, 1)
		timerSoulFlayCD:Start(24.9-delay)--SUCCESS
		timerTormentCD:Start(49.6, 1)
	else
		timerSoulFlayCD:Start(18.5-delay)--SUCCESS
		timerTormentCD:Start(20.3, 1)
		timerVoidRitualCD:Start(61.8-delay, 1)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
	berserkTimer:Start(900-delay)
	if UnitIsGroupLeader("player") and not self:IsLFR() then
		if self.Options.InterruptBehavior == "Four" then
			self:SendSync("Four")
		elseif self.Options.InterruptBehavior == "Five" then
			self:SendSync("Five")
		elseif self.Options.InterruptBehavior == "Six" then
			self:SendSync("Six")
		elseif self.Options.InterruptBehavior == "NoReset" then
			self:SendSync("NoReset")
		end
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 312336 then
		self.vb.ritualCount = self.vb.ritualCount + 1
		self.vb.addIcon = 8
		if self.Options.SpecWarn312336count then
			specWarnVoidRitual:Show(self.vb.ritualCount)
			specWarnVoidRitual:Play("specialsoon")
		else
			warnVoidRitual:Show(self.vb.ritualCount)
		end
		timerVoidRitualCD:Start(94.7, self.vb.ritualCount+1)
	elseif spellId == 316211 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds and self.vb.addIcon > 3 then--Only use up to 5 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12)
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		if (self.vb.interruptBehavior == "Four" and castsPerGUID[args.sourceGUID] == 4) or (self.vb.interruptBehavior == "Five" and castsPerGUID[args.sourceGUID] == 5) or (self.vb.interruptBehavior == "Six" and castsPerGUID[args.sourceGUID] == 6) then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnTerrorWave:Show(args.sourceName, count)
			if count == 1 then
				specWarnTerrorWave:Play("kick1r")
			elseif count == 2 then
				specWarnTerrorWave:Play("kick2r")
			elseif count == 3 then
				specWarnTerrorWave:Play("kick3r")
			elseif count == 4 then
				specWarnTerrorWave:Play("kick4r")
			elseif count == 5 then
				specWarnTerrorWave:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnTerrorWave:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 311551 then
		timerAbyssalStrikeCD:Start(self:IsMythic() and 20.6 or 40.5)
	elseif spellId == 306319 then
		timerSoulFlayCD:Start(57)
	elseif spellId == 306208 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		specWarnTorment:Show(self.vb.tormentCount)
		specWarnTorment:Play("watchstep")
		if self:IsMythic() then
			if self.vb.tormentCount % 2 == 0 then
				timerTormentCD:Start(63.4, self.vb.tormentCount+1)--63.4-65
			else
				timerTormentCD:Start(30.0, self.vb.tormentCount+1)--30-31
			end
		else
			if self.vb.tormentCount == 1 then
				timerTormentCD:Start(76.1, 2)
			else
				if self.vb.tormentCount % 2 == 0 then
					timerTormentCD:Start(30.3, self.vb.tormentCount+1)
				else
					timerTormentCD:Start(64.1, self.vb.tormentCount+1)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 312406 then
		if not tContains(voidWokenTargets, args.destName) then
			table.insert(voidWokenTargets, args.destName)
		end
		if self.Options.SetIconOnVoidWoken2 then
			self:SetIcon(args.destName, #voidWokenTargets)
		end
	elseif spellId == 314179 then
		warnFanaticism:Show(args.destName)
	elseif spellId == 311551 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnAbyssalStrike:Show(amount)
				specWarnAbyssalStrike:Play("stackhigh")
			end
		else
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
			local remaining
			if expireTime then
				remaining = expireTime-GetTime()
			end
			local timer = self:IsMythic() and 20.6 or 40.5
			if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < timer) then
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
		if self.Options.SetIconOnVoidWoken2 then
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
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 162432 then
		--castsPerGUID[args.destGUID] = nil
	end
end
--]]

function mod:OnSync(msg)
	if self:IsLFR() then return end
	if msg == "Four" then
		self.vb.interruptBehavior = "Four"
	elseif msg == "Five" then
		self.vb.interruptBehavior = "Five"
	elseif msg == "Six" then
		self.vb.interruptBehavior = "Six"
	elseif msg == "NoReset" then
		self.vb.interruptBehavior = "NoReset"
	end
end
