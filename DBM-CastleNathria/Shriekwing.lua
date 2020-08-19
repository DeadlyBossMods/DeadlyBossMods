local mod	= DBM:NewMod(2393, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164406)
mod:SetEncounterID(2398)
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20200815000000)--2020, 8, 15
mod:SetMinSyncRevision(20200815000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328857 328921 340047 330711",
	"SPELL_CAST_SUCCESS 328857",
	"SPELL_AURA_APPLIED 328897 329370 342077 341684",
	"SPELL_AURA_APPLIED_DOSE 328897",
	"SPELL_AURA_REMOVED 329370 328921 342077 328897",
	"SPELL_AURA_REMOVED_DOSE 328897",
	"SPELL_PERIODIC_DAMAGE 340324",
	"SPELL_PERIODIC_MISSED 340324",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, need fresh transcriptor log to verify icon resetting/timer event for Scent for Blood
--TODO, icons or auras for 341684?
--[[
(ability.id = 328857 or ability.id = 328921 or ability.id = 340047 or ability.id = 330711) and type = "begincast"
 or (ability.id = 342074) and type = "cast"
 or ability.id = 328921 and type = "removebuff"
--]]
--Stage One - Thirst for Blood
local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnScentofBlood							= mod:NewTargetAnnounce(342077, 3)
--Stage Two - Terror of Castle Nathria
local warnDeadlyDescent							= mod:NewTargetNoFilterAnnounce(329370, 4)
local warnBloodgorgeOver						= mod:NewEndAnnounce(328921, 1)
local warnSonarShriek							= mod:NewCastAnnounce(340047, 2)
local warnBloodLantern							= mod:NewTargetNoFilterAnnounce(341684, 2)--Mythic

--Stage One - Thirst for Blood
local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
local specWarnExsanguinatingBiteOther			= mod:NewSpecialWarningTaunt(328857, nil, nil, nil, 1, 2)
local specWarnScentofBlood						= mod:NewSpecialWarningMoveAway(342077, nil, nil, nil, 1, 2)
local yellScentofBlood							= mod:NewYell(342077)
local yellScentofBloodFades						= mod:NewShortFadesYell(342077)
local specWarnEarsplittingShriek				= mod:NewSpecialWarningMoveTo(330711, nil, nil, nil, 1, 2)
--Stage Two - Terror of Castle Nathria
local specWarnBloodgorge						= mod:NewSpecialWarningSpell(328921, nil, nil, nil, 2, 2)
local specWarnDeadlyDescent						= mod:NewSpecialWarningYou(329370, nil, nil, nil, 1, 2)--1 because you can't do anything about it
local yellDeadlyDescent							= mod:NewYell(329370)
--local yellDeadlyDescentFades					= mod:NewShortFadesYell(329370)--Re-enable if made 4 seconds again, but as 2 seconds this is useless
local specWarnDeadlyDescentNear					= mod:NewSpecialWarningClose(329370, nil, nil, nil, 3, 2)--3 because you NEED to get away from them highest priority
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--Stage One - Thirst for Blood
--mod:AddTimerLine(BOSS)
local timerExsanguinatingBiteCD					= mod:NewCDTimer(10, 328857, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--10-22.9 (too varaible for a countdown by default)
local timerScentofBloodCD						= mod:NewCDTimer(42.6, 342077, nil, nil, nil, 3, nil, nil, nil, 1, 3)--Seems to be 42.7 without a hitch
local timerEarsplittingShriekCD					= mod:NewCDTimer(44.5, 330711, nil, nil, nil, 2)--44.5-47.1
--Stage Two - Terror of Castle Nathria
--local timerBloodgorge							= mod:NewBuffActiveTimer(47.5, 328921, nil, nil, nil, 6)--43.4-47.5, more to it than this? or just fact blizzards energy code always proves to be dogshit
local timerSonarShriekCD						= mod:NewCDTimer(7.3, 340047, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 329370)
mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnScentofBlood", 342077, true, false, {1, 2})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

local ExsanguinatedStacks = {}
local playerDebuff = false
mod.vb.scentIcon = 1

function mod:OnCombatStart(delay)
	table.wipe(ExsanguinatedStacks)
	playerDebuff = false
	self.vb.scentIcon = 1
	timerExsanguinatingBiteCD:Start(6.7-delay)
	timerScentofBloodCD:Start(19.2-delay)
	timerEarsplittingShriekCD:Start(20.5-delay)
--	if self:IsMythic() then

--	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.NPAuraOnVolatileCorruption then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328857 then
		if self:IsTanking("player", "boss1", nil, true) and self:AntiSpam(3, 1) then
			specWarnExsanguinatingBite:Show()
			specWarnExsanguinatingBite:Play("defensive")
		end
		timerExsanguinatingBiteCD:Start()
	elseif spellId == 328921 then
		specWarnBloodgorge:Show()
		specWarnBloodgorge:Play("phasechange")
		timerExsanguinatingBiteCD:Stop()
		timerEarsplittingShriekCD:Stop()
		timerScentofBloodCD:Stop()
		timerSonarShriekCD:Start(19.4)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 340047 then
		warnSonarShriek:Show()
		timerSonarShriekCD:Start()
	elseif spellId == 330711 then
		specWarnEarsplittingShriek:Show(DBM_CORE_L.BREAK_LOS)
		specWarnEarsplittingShriek:Play("findshelter")
		timerEarsplittingShriekCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 328857 then
		if not args:IsPlayer() then
			specWarnExsanguinatingBiteOther:Show(args.destName)
			specWarnExsanguinatingBiteOther:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328897 then
		local amount = args.amount or 1
		ExsanguinatedStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
		if args:IsPlayer() then
			playerDebuff = true
			if (amount % 3 == 0) and self:AntiSpam(3, 1) then
				--Shared antispam with tank defensive warning, just to avoid tank feeling spammed, especially since this could also trigger twice in a single bite
				specWarnExsanguinated:Show(amount)
				specWarnExsanguinated:Play("stackhigh")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				warnExsanguinated:Show(args.destName, amount)
			end
		end
	elseif spellId == 329370 then
		if args:IsPlayer() then
			specWarnDeadlyDescent:Show()
			specWarnDeadlyDescent:Play("targetyou")
			yellDeadlyDescent:Yell()
--			yellDeadlyDescentFades:Countdown(spellId)
		elseif self:CheckNearby(12, args.destName) then
			specWarnDeadlyDescentNear:CombinedShow(0.3, args.destName)
			specWarnDeadlyDescentNear:ScheduleVoice(0.3, "runaway")
		else
			warnDeadlyDescent:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 342077 then
		warnScentofBlood:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnScentofBlood:Show()
			specWarnScentofBlood:Play("runout")
			yellScentofBlood:Yell()
			yellScentofBloodFades:Countdown(spellId)
		end
		if self.Options.SetIconOnScentofBlood then
			self:SetIcon(args.destName, self.vb.scentIcon)
		end
		self.vb.scentIcon = self.vb.scentIcon + 1
	elseif spellId == 341684 then
		warnBloodLantern:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 329370 then
--		if args:IsPlayer() then
--			yellDeadlyDescentFades:Cancel()
--		end
	elseif spellId == 328921 then--Bloodgorge removed
		timerSonarShriekCD:Stop()
		warnBloodgorgeOver:Show()
		--Looks same as pull timers
		timerExsanguinatingBiteCD:Start(6)
		timerScentofBloodCD:Start(18.3)
		timerEarsplittingShriekCD:Start(20.6)
--		if self:IsMythic() then

--		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 342077 then
		if args:IsPlayer() then
			yellScentofBloodFades:Cancel()
		end
	elseif spellId == 328897 then
		ExsanguinatedStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
		if args:IsPlayer() then
			playerDebuff = false
		end
--	elseif spellId == 341684 then

	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 328897 then
		ExsanguinatedStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

do
--[[
	--For good measure, not sure if right spellId of debuff so using spellname lookup instead
	local spellName = DBM:GetSpellInfo(342077)
	function mod:UNIT_AURA_UNFILTERED(uId)
		local hasDebuff = DBM:UnitDebuff(uId, spellName)
		if hasDebuff then
			local name = DBM:GetUnitFullName(uId)
			if UnitIsUnit(uId, "player") then
				specWarnScentofBlood:Show()
				specWarnScentofBlood:Play("runout")
				yellScentofBlood:Yell()
				yellScentofBloodFades:Countdown(8)
			else
				warnScentofBlood:Show(name)
			end
			if self.Options.SetIconOnScentofBlood then
				self:SetIcon(name, 1, 8)
			end
			self:UnregisterShortTermEvents()
		end
	end--]]

	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if spellId == 342074 then--Dark Descent
			self.vb.scentIcon = 1
			timerScentofBloodCD:Start()
			--self:RegisterShortTermEvents(
			--	"UNIT_AURA_UNFILTERED"
			--)
		end
	end
end
