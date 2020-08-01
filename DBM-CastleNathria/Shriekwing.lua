local mod	= DBM:NewMod(2393, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164406)
mod:SetEncounterID(2398)
mod:SetZone()
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20200801000000)--2020, 8, 01
mod:SetMinSyncRevision(20200801000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328857 328921 340047 330711",
	"SPELL_CAST_SUCCESS 336337 340322 328857",
	"SPELL_AURA_APPLIED 328897 329370 336338 336235",
	"SPELL_AURA_APPLIED_DOSE 328897",
	"SPELL_AURA_REMOVED 329370 328921 336338 336235 328897",
	"SPELL_AURA_REMOVED_DOSE 328897",
	"SPELL_PERIODIC_DAMAGE 340324",
	"SPELL_PERIODIC_MISSED 340324",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, icons for Sanguine curse? depends on how many get it and if it still exists
--[[
(ability.id = 328857 or ability.id = 328921 or ability.id = 340047 or ability.id = 330711) and type = "begincast"
 or (ability.id = 336337 or ability.id = 340322) and type = "cast"
 or ability.id = 328921 and type = "removebuff"
--]]
--Stage One - Thirst for Blood
local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnSanguineFeast							= mod:NewSpellAnnounce(340322, 2)
local warnSanguineCurse							= mod:NewTargetNoFilterAnnounce(336338, 3, nil, "RemoveCurse")
local warnDarkDescent							= mod:NewTargetAnnounce(336235, 3)
--Stage Two - Terror of Castle Nathria
local warnDeadlyDescent							= mod:NewTargetNoFilterAnnounce(329370, 4)
local warnBloodgorgeOver						= mod:NewEndAnnounce(328921, 1)
local warnSonarShriek							= mod:NewCastAnnounce(340047, 2)

--Stage One - Thirst for Blood
local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, nil, nil, 1, 2)
local specWarnExsanguinatingBiteOther			= mod:NewSpecialWarningTaunt(328857, nil, nil, nil, 1, 2)
local specWarnDarkDescent						= mod:NewSpecialWarningMoveAway(336235, nil, nil, nil, 1, 2)
local yellDarkDescent							= mod:NewYell(336235)
local yellDarkDescentFades						= mod:NewShortFadesYell(336235)
local specWarnSanguineCurse						= mod:NewSpecialWarningMoveAway(336338, nil, nil, nil, 1, 2, 4)
local yellSanguineCurse							= mod:NewYell(336338)
local yellSanguineCurseFades					= mod:NewShortFadesYell(336338)
local specWarnEarsplittingShriek				= mod:NewSpecialWarningMoveTo(330711, nil, nil, nil, 1, 2)
--Stage Two - Terror of Castle Nathria
local specWarnBloodgorge						= mod:NewSpecialWarningSpell(328921, nil, nil, nil, 2, 2)
local specWarnDeadlyDescent						= mod:NewSpecialWarningYou(329370, nil, nil, nil, 1, 2)--1 because you can't do anything about it
local yellDeadlyDescent							= mod:NewYell(329370)
--local yellDeadlyDescentFades					= mod:NewShortFadesYell(329370)
local specWarnDeadlyDescentNear					= mod:NewSpecialWarningClose(329370, nil, nil, nil, 3, 2)--3 because you NEED to get away from them highest priority
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--Stage One - Thirst for Blood
--mod:AddTimerLine(BOSS)
local timerExsanguinatingBiteCD					= mod:NewCDTimer(10, 328857, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--10-22.9 (too varaible for a countdown by default)
local timerSanguineFeastCD						= mod:NewCDTimer(10.2, 340322, nil, nil, nil, 2)--10.2-19.7
local timerDarkDescentCD						= mod:NewCDTimer(42.7, 336235, nil, nil, nil, 3, nil, nil, nil, 1, 3)--Seems to be 42.7 without a hitch
local timerEarsplittingShriekCD					= mod:NewCDTimer(44.5, 330711, nil, nil, nil, 2)--44.5-47.1
local timerSanguineCurseCD						= mod:NewAITimer(44.3, 336337, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)--Mythic?
--Stage Two - Terror of Castle Nathria
--local timerBloodgorge							= mod:NewBuffActiveTimer(47.5, 328921, nil, nil, nil, 6)--43.4-47.5, more to it than this? or just fact blizzards energy code always proves to be dogshit
local timerSonarShriekCD						= mod:NewCDTimer(7.3, 340047, nil, nil, nil, 3)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 329370)
mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnDarkDescent", 336235, true, false, {1})
mod:AddSetIconOption("SetIconOnSanguineCurse", 336338, true, false, {2, 3, 4, 5, 6, 7, 8})
--mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

local ExsanguinatedStacks = {}
local playerDebuff = false
mod.vb.curseIcon = 2

function mod:OnCombatStart(delay)
	table.wipe(ExsanguinatedStacks)
	playerDebuff = false
	self.vb.curseIcon = 2
	timerExsanguinatingBiteCD:Start(6.7-delay)
	timerSanguineFeastCD:Start(10.7-delay)
	timerEarsplittingShriekCD:Start(20.5-delay)
	timerDarkDescentCD:Start(42.6-delay)
	if self:IsMythic() then
		timerSanguineCurseCD:Start(1-delay)--Likely now mythic only
	end
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
		timerSanguineFeastCD:Stop()
		timerEarsplittingShriekCD:Stop()
		timerDarkDescentCD:Stop()
		timerSanguineCurseCD:Stop()
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
	if spellId == 336337 then
		self.vb.curseIcon = 2
		timerSanguineCurseCD:Start()
	elseif spellId == 340322 then
		warnSanguineFeast:Show()
		timerSanguineFeastCD:Start()
	elseif spellId == 328857 then
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
	elseif spellId == 336338 then
		warnSanguineCurse:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSanguineCurse:Show()
			specWarnSanguineCurse:Play("runout")
			yellSanguineCurse:Yell()
			yellSanguineCurseFades:Countdown(spellId)
		end
		if self.Options.SetIconOnSanguineCurse then
			self:SetIcon(args.destName, self.vb.curseIcon)
		end
		self.vb.curseIcon = self.vb.curseIcon + 1
	elseif spellId == 336235 then
		DBM:AddMsg("If you see this message, alert DBM author to notify Dark Descent is now in combat log")
--		if args:IsPlayer() then
--			specWarnDarkDescent:Show()
--			specWarnDarkDescent:Play("runout")
--			yellDarkDescent:Yell()
--			yellDarkDescentFades:Countdown(spellId)
--		else
--			warnDarkDescent:Show(args.destName)
--		end
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
		timerSanguineFeastCD:Start(10.9)
		timerEarsplittingShriekCD:Start(20.6)
		timerDarkDescentCD:Start(41.5)
		if self:IsMythic() then
			timerSanguineCurseCD:Start(2)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 336338 then
		if args:IsPlayer() then
			yellSanguineCurseFades:Cancel()
		end
		if self.Options.SetIconOnSanguineCurse then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 336235 then
		if args:IsPlayer() then
			yellDarkDescentFades:Cancel()
		end
	elseif spellId == 328897 then
		ExsanguinatedStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
		if args:IsPlayer() then
			playerDebuff = false
		end
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
	--For good measure, not sure if right spellId of debuff so using spellname lookup instead
	local spellName = DBM:GetSpellInfo(336235)
	function mod:UNIT_AURA_UNFILTERED(uId)
		local hasDebuff = DBM:UnitDebuff(uId, spellName)
		if hasDebuff then
			local name = DBM:GetUnitFullName(uId)
			if UnitIsUnit(uId, "player") then
				specWarnDarkDescent:Show()
				specWarnDarkDescent:Play("runout")
				yellDarkDescent:Yell()
				yellDarkDescentFades:Countdown(8)
			else
				warnDarkDescent:Show(name)
			end
			if self.Options.SetIconOnDarkDescent then
				self:SetIcon(name, 1, 8)
			end
			self:UnregisterShortTermEvents()
		end
	end
	--"<41.31 17:08:57> [UNIT_SPELLCAST_SUCCEEDED] Shriekwing(Scottbrex) -Dark Descent- [[boss1:Cast-3-2084-2296-23306-336233-0025248867:336233]]", -- [2028]
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if spellId == 336233 then--Dark Descent
			timerDarkDescentCD:Start()
			self:RegisterShortTermEvents(
				"UNIT_AURA_UNFILTERED"
			)
		end
	end
end
