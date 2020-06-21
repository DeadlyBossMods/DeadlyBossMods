local mod	= DBM:NewMod(2428, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(157602)
mod:SetEncounterID(2383)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 334522 329758 334266 329455 329774",
	"SPELL_CAST_SUCCESS 329298",
	"SPELL_AURA_APPLIED 329298 334755 329725 334228 332295",
	"SPELL_AURA_APPLIED_DOSE 334755 332295",
	"SPELL_AURA_REMOVED 329298 334755 334228",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"RAID_BOSS_WHISPER"
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine tune icons for Miasma when number of affected targets is known
--TODO, if Gluttonous Miasma has shorter than a 24 second cd, the current icon code will break if any players die
--TODO, fine tune stacks for essence sap
--TODO, better way to detect expunge, 6 second debuff or 5 second cast? which comes first?
--TODO, detect volatile ejection targets? probably uses RAID_BOSS_WHISPER, it's drycoded but may have wrong spellId
--TODO, is desolate a mechanic just to have more to heal? or a failure mechanic like "no tank in melee range" one
local warnGluttonousMiasma						= mod:NewTargetNoFilterAnnounce(329298, 4)
local warnVolatileEjection						= mod:NewTargetNoFilterAnnounce(334266, 4)

local specWarnGluttonousMiasma					= mod:NewSpecialWarningYouPos(329298, nil, nil, nil, 1, 2)
local yellGluttonousMiasma						= mod:NewPosYell(329298)
local specWarnEssenceSap						= mod:NewSpecialWarningStack(334755, nil, 5, nil, nil, 1, 6)--Mythic
local specWarnConsume							= mod:NewSpecialWarningRun(334522, nil, nil, nil, 4, 2)
local specWarnExpunge							= mod:NewSpecialWarningMoveAway(329725, nil, nil, nil, 1, 2)
local specWarnVolatileEjection					= mod:NewSpecialWarningYou(334266, nil, nil, nil, 1, 2)
local yellVolatileEjection						= mod:NewPosYell(334266)
local specWarnGrowingHunger						= mod:NewSpecialWarningCount(332295, nil, DBM_CORE_L.AUTO_SPEC_WARN_OPTIONS.stack:format(12, 332295), nil, 1, 2)
local specWarnGrowingHungerOther				= mod:NewSpecialWarningTaunt(332295, nil, nil, nil, 1, 2)
local specWarnOverwhelm							= mod:NewSpecialWarningDefensive(329774, "Tank", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerGluttonousMiasmaCD					= mod:NewAITimer(44.3, 329298, nil, nil, nil, 3)
local timerConsumeCD							= mod:NewAITimer(44.3, 334522, nil, nil, nil, 2)
local timerExpungeCD							= mod:NewAITimer(44.3, 329725, nil, nil, nil, 3)
local timerVolatileEjectionCD					= mod:NewAITimer(44.3, 334266, nil, nil, nil, 3)
local timerDesolateCD							= mod:NewAITimer(44.3, 329455, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerOverwhelmCD							= mod:NewAITimer(16.6, 329774, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
mod:AddSetIconOption("SetIconOnGluttonousMiasma", 329298, true, false, {1, 2, 3})
--mod:AddSetIconOption("SetIconOnVolatileEjection", 334266, true, false, {6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)
mod:AddInfoFrameOption(334755, true)
mod:AddBoolOption("SortDesc", false)
mod:AddBoolOption("ShowTimeNotStacks", false)

local GluttonousTargets = {}
local essenceSapStacks = {}
local playerEssenceSap, playerVolatile = false, false

local updateInfoFrame
do
	local twipe, tsort = table.wipe, table.sort
	local lines = {}
	local tempLines = {}
	local tempLinesSorted = {}
	local sortedLines = {}
	local function sortFuncAsc(a, b) return tempLines[a] < tempLines[b] end
	local function sortFuncDesc(a, b) return tempLines[a] > tempLines[b] end
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(tempLines)
		twipe(tempLinesSorted)
		twipe(sortedLines)
		--Player Personal Checks at the top
		if playerEssenceSap then
			local spellName, _, currentStack, _, _, expireTime = DBM:UnitDebuff("player", 334755)
			if spellName and currentStack and expireTime then
				local remaining = expireTime-GetTime()
				addLine(spellName.." ("..currentStack..")", math.floor(remaining))
			end
		end
		if playerVolatile then
			local spellName2, _, _, _, _, expireTime2 = DBM:UnitDebuff("player", 334228)
			if spellName2 and expireTime2 then
				local remaining2 = expireTime2-GetTime()
				addLine(spellName2, math.floor(remaining2))
			end
		end
		--Add entire raids Essence Sap players on Mythic
		if mod:IsMythic() then
			if mod.Options.ShowTimeNotStacks then
				--Higher Performance check that scans all debuff remaining times
				for uId in DBM:GetGroupMembers() do
					if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) then--Exclude tanks and dead
						local unitName = DBM:GetUnitFullName(uId)
						local spellName3, _, _, _, _, expireTime3 = DBM:UnitDebuff(uId, 334755)
						if spellName3 and expireTime3 then
							local remaining3 = expireTime3-GetTime()
							tempLines[unitName] = math.floor(remaining3)
							tempLinesSorted[#tempLinesSorted + 1] = unitName
						else
							tempLines[unitName] = 0
							tempLinesSorted[#tempLinesSorted + 1] = unitName
						end
					end
				end
			else
				--More performance friendly check that just returns all player stacks (the default option)
				for uId in DBM:GetGroupMembers() do
					if not (UnitGroupRolesAssigned(uId) == "TANK" or GetPartyAssignment("MAINTANK", uId, 1) or UnitIsDeadOrGhost(uId)) then--Exclude tanks and dead
						local unitName = DBM:GetUnitFullName(uId)
						tempLines[unitName] = essenceSapStacks[unitName] or 0
						tempLinesSorted[#tempLinesSorted + 1] = unitName
					end
				end
			end
			--Sort debuffs, then inject into regular table
			if mod.Options.SortDesc then
				tsort(tempLinesSorted, sortFuncDesc)
			else
				tsort(tempLinesSorted, sortFuncAsc)
			end
			for _, name in ipairs(tempLinesSorted) do
				addLine(name, tempLines[name])
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	playerEssenceSap = false
	table.wipe(GluttonousTargets)
	table.wipe(essenceSapStacks)
	timerGluttonousMiasmaCD:Start(1-delay)
	timerConsumeCD:Start(1-delay)
	timerExpungeCD:Start(1-delay)
	timerVolatileEjectionCD:Start(1-delay)
	timerOverwhelmCD:Start(1-delay)
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
	if self:IsMythic() then
		for uId in DBM:GetGroupMembers() do
			local unitName = DBM:GetUnitFullName(uId)
			essenceSapStacks[unitName] = 0
		end
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(22, "function", updateInfoFrame, false, false)
	end
end

function mod:OnTimerRecovery()
	for uId in DBM:GetGroupMembers() do
		local unitName = DBM:GetUnitFullName(uId)
		if self:IsMythic() then
			local _, _, currentStack = DBM:UnitDebuff(uId, 329298)
			essenceSapStacks[unitName] = currentStack or 0
			if UnitIsUnit(uId, "player") and currentStack then
				playerEssenceSap = true
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(OVERVIEW)
				DBM.InfoFrame:Show(22, "function", updateInfoFrame, false, false)
			end
		end
		if DBM:UnitDebuff(uId, 329298) then
			if not tContains(GluttonousTargets, unitName) then
				table.insert(GluttonousTargets, unitName)
			end
		end
	end
	if DBM:UnitDebuff("player", 334228) then
		playerVolatile = true
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 334522 then
		specWarnConsume:Show()
		specWarnConsume:Play("justrun")
		timerConsumeCD:Start()
	elseif spellId == 329758 then
		timerExpungeCD:Start()
	elseif spellId == 334266 then
		--TODO, if not target, warn to avoid those who are
		timerVolatileEjectionCD:Start()
	elseif spellId == 329455 then
		timerDesolateCD:Start()
	elseif spellId == 329774 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnOverwhelm:Show()
			specWarnOverwhelm:Play("defensive")
		end
		timerOverwhelmCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 329298 and self:AntiSpam(5, 1) then
		timerGluttonousMiasmaCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 329298 then
		if not tContains(GluttonousTargets, args.destName) then
			table.insert(GluttonousTargets, args.destName)
		end
		local icon = #GluttonousTargets
		if args:IsPlayer() then
			specWarnGluttonousMiasma:Show(self:IconNumToTexture(icon))
			specWarnGluttonousMiasma:Play("mm"..icon)--or "targetyou"
			yellGluttonousMiasma:Yell(icon, icon, icon)
		else
			warnGluttonousMiasma:CombinedShow(0.3, args.destName)
		end
		if self.Options.SetIconOnGluttonousMiasma then
			self:SetIcon(args.destName, icon)
		end
	elseif spellId == 334755 then
		local amount = args.amount or 1
		essenceSapStacks[args.destName] = amount
		if args:IsPlayer() then
			if not playerEssenceSap then
				playerEssenceSap = true
			end
			if amount >= 5 then
				specWarnEssenceSap:Show(amount)
				specWarnEssenceSap:Play("stackhigh")
			end
		end
	elseif spellId == 329725 then
		if args:IsPlayer() then
			specWarnExpunge:Show()
			specWarnExpunge:Play("scatter")
		end
	elseif spellId == 334228 then
		if args:IsPlayer() then
			playerVolatile = true
		end
	elseif spellId == 332295 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(4, 2) then
			if self:IsTanking("player", "boss1", nil, true) then
				specWarnGrowingHunger:Show(amount)
				specWarnGrowingHunger:Play("changemt")
			else
				specWarnGrowingHungerOther:Show(args.destName)
				specWarnGrowingHungerOther:Play("tauntboss")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329298 then
		tDeleteItem(GluttonousTargets, args.destName)
	elseif spellId == 334755 then
		essenceSapStacks[args.destName] = 0
		if args:IsPlayer() then
			playerEssenceSap = false
		end
	elseif spellId == 334228 then
		if args:IsPlayer() then
			playerVolatile = false
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("334266") then
		specWarnVolatileEjection:Show()
		specWarnVolatileEjection:Play("targetyou")
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("334266") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			warnVolatileEjection:CombinedShow(0.75, targetName)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
