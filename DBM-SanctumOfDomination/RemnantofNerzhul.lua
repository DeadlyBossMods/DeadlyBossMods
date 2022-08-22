local mod	= DBM:NewMod(2444, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175729)
mod:SetEncounterID(2432)
mod:SetUsedIcons(1, 2, 3, 4, 7, 8)
mod:SetHotfixNoticeRev(20210831000000)--2021-08-31
mod:SetMinSyncRevision(20210831000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 355123 351066 351067 351073 350469 350894",--350096 350691 350518
	"SPELL_CAST_SUCCESS 351066 351067 351073",
	"SPELL_SUMMON 349908",
	"SPELL_AURA_APPLIED 355790 350469 349890 355790",--350097
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 355790 350469 355790",--350097
	"SPELL_PERIODIC_DAMAGE 350489",
	"SPELL_PERIODIC_MISSED 350489"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Verify dynamic timer update code that should hopefully make timers a bit more useful
--TODO, Orb of Torment's Unrelenting Torment cast removed? Same with Burst of Agony?
--[[
(ability.id = 349889 or ability.id = 355123 or ability.id = 351066 or ability.id = 351067 or ability.id = 351073 or ability.id = 350469 or ability.id = 350894) and type = "begincast"
 or (ability.id = 351066 or ability.id = 351067 or ability.id = 351073) and type = "cast"
 or ability.id = 349908
 or (ability.id = 350694 or ability.id = 349891 or ability.id = 355166) and type = "begincast"
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
local warnOrbofTorment							= mod:NewCountAnnounce(349908, 2)
local warnOrbEternalTorment						= mod:NewFadesAnnounce(355790, 1)
--local warnUnrelentingTorment					= mod:NewCountAnnounce(350518, 4)
local warnMalevolence							= mod:NewTargetNoFilterAnnounce(350469, 3)
local warnShatter								= mod:NewCountAnnounce(351066, 1)

local specWarnMalevolence						= mod:NewSpecialWarningYouPos(350469, nil, nil, nil, 1, 2)
local yellMalevolence							= mod:NewShortPosYell(350469)
local yellMalevolenceFades						= mod:NewIconFadesYell(350469)
local specWarnSufferingTank						= mod:NewSpecialWarningMoveTo(350894, nil, nil, nil, 1, 2)--Tank Warning
local specWarnSuffering							= mod:NewSpecialWarningYou(350894, nil, nil, nil, 1, 2)--Non Tank warning
local yellSuffering								= mod:NewYell(350894, nil, false)--Not as useful as fades
local yellSufferingFades						= mod:NewFadesYell(350894)
local specWarnSufferingSwap						= mod:NewSpecialWarningTaunt(350894, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(350489, nil, nil, nil, 1, 8)
local specWarnGraspofMalice						= mod:NewSpecialWarningDodge(355123, nil, nil, nil, 2, 2)--Malicious Gauntlet
--local specWarnAgony							= mod:NewSpecialWarningMoveAway(350097, nil, nil, nil, 1, 2)
--local yellAgony								= mod:NewYell(350097)
--local yellAgonyFades							= mod:NewFadesYell(350097)

local timerOrbofTormentCD						= mod:NewCDCountTimer(35, 349908, nil, nil, nil, 1, nil, nil, true)
local timerMalevolenceCD						= mod:NewCDCountTimer(31.3, 350469, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON, true)--Rattlecage of Agony 31.7--49.7
local timerSufferingCD							= mod:NewCDTimer(24.4, 350894, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON, true, mod:IsTank() and 2, 3)
local timerGraspofMaliceCD						= mod:NewCDTimer(20.7, 355123, nil, nil, nil, 3, nil, nil, true)--Malicious Gauntlet (22 possibly the min time now?)
--local timerBurstofAgonyCD						= mod:NewAITimer(23, 350096, nil, nil, nil, 3)

local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(349890, true)
mod:AddSetIconOption("SetIconOnMalevolence", 350469, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnOrbs", 321226, true, true, {7, 6, 5, 4})
mod:AddNamePlateOption("NPAuraOnOrbEternalTorment", 355790)

mod.vb.orbCount = 0
mod.vb.iconCount = 7
mod.vb.unrelentingCount = 0
mod.vb.malevolenceCount = 0
mod.vb.malevolenceIcon = 1
mod.vb.shatterCount = 0

--Suffering triggers 12.2 ICD
--Malevolence triggers 4.9 ICD
--Grasp triggers 3-3.5 ICD
--Orb triggers 3-3.5 ICD
--Shatter triggers it's own ICDs handled in shatter/phase change code
--Spell queue priority: Suffering, Malevolence, Orb, Grasp
local function updateAllTimers(self, ICD)
	DBM:Debug("updateAllTimers running", 2)
	local nextCast = 0
	if timerSufferingCD:GetRemaining() < ICD then
		local elapsed, total = timerSufferingCD:GetTime()
		local extend = ICD - (total-elapsed)
		DBM:Debug("timerSufferingCD extended by: "..extend, 2)
--		timerSufferingCD:Stop()
		timerSufferingCD:Update(elapsed, total+extend)
		if DBM.Options.DebugMode then--Only one that's still debug only mode for now
			nextCast = 1--While suffering top of queue priority, it's also not a "next" timer so can't trust enabling this right now
		end
	end
	if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < ICD then
		local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
		local extend = ICD - (total-elapsed)
		if nextCast == 1 then--Previous spells in queue priority are head of it in line, auto adjust
			extend = extend + 12.2
			DBM:Debug("timerMalevolenceCD extended by: "..extend.." plus 12.2 for Suffering", 2)
		else
			DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--			if DBM.Options.DebugMode then
				nextCast = 2--Should be trustworthy enough to enable for masses
--			end
		end
--		timerMalevolenceCD:Stop()
		timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
	end
	if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < ICD then
		local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
		local extend = ICD - (total-elapsed)
		if nextCast == 1 then--Previous spells in queue priority are head of it in line, auto adjust
			extend = extend + 12.2
			DBM:Debug("timerOrbofTormentCD extended by: "..extend.." plus 12.2 for Suffering", 2)
		elseif nextCast == 2 then
			extend = extend + 4.9
			DBM:Debug("timerOrbofTormentCD extended by: "..extend.." plus 4.9 for Malevolence", 2)
		else
			DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--			if DBM.Options.DebugMode then
				nextCast = 3--Should be trustworthy enough to enable for masses
--			end
		end
--		timerOrbofTormentCD:Stop()
		timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
	end
	if timerGraspofMaliceCD:GetRemaining() < ICD then
		local elapsed, total = timerGraspofMaliceCD:GetTime()
		local extend = ICD - (total-elapsed)
		if nextCast == 1 then--Previous spells in queue priority are head of it in line, auto adjust
			extend = extend + 12.2
			DBM:Debug("timerGraspofMaliceCD extended by: "..extend.." plus 12.2 for Suffering", 2)
		elseif nextCast == 2 then
			extend = extend + 4.9
			DBM:Debug("timerGraspofMaliceCD extended by: "..extend.." plus 4.9 for Malevolence", 2)
		elseif nextCast == 3 then
			extend = extend + 3.5
			DBM:Debug("timerGraspofMaliceCD extended by: "..extend.." plus 3.5 for Orb", 2)
		else
			DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
		end
--		timerGraspofMaliceCD:Stop()
		timerGraspofMaliceCD:Update(elapsed, total+extend)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.orbCount = 0
	self.vb.iconCount = 7
	self.vb.unrelentingCount = 0
	self.vb.malevolenceCount = 0
	self.vb.shatterCount = 0
	timerOrbofTormentCD:Start(10.8-delay, 1)
	timerSufferingCD:Start(18.1-delay)
	timerMalevolenceCD:Start(29.7, 1)--29-34
	timerGraspofMaliceCD:Start(38)
	berserkTimer:Start(-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnOrbEternalTorment then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnOrbEternalTorment then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 350894 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSufferingTank:Show(DBM_COMMON_L.ORB)
			specWarnSufferingTank:Play("targetyou")--or orbrun.ogg?
			yellSuffering:Yell()
			yellSufferingFades:Countdown(3)
		end
		timerSufferingCD:Start(self:IsMythic() and 17.3 or 19.3)--17s are SUPER rare. Requires perfect alignment.
		updateAllTimers(self, 12.2)
	elseif spellId == 355123 then
		specWarnGraspofMalice:Show()
		specWarnGraspofMalice:Play("watchstep")
		timerGraspofMaliceCD:Start()
		updateAllTimers(self, 3.5)
--	elseif spellId == 350096 or spellId == 350691 then--Mythic/Heroic likely and normal/LFR likely
--		timerBurstofAgonyCD:Start()
	elseif spellId == 351066 or spellId == 351067 or spellId == 351073 then--Shatter (Helm of Suffering, Malicious Gauntlets, Rattlecage of Agony)
		self.vb.shatterCount = self.vb.shatterCount + 1
		warnShatter:Show(self.vb.shatterCount)
	elseif spellId == 350469 then
		self.vb.malevolenceIcon = 1
		self.vb.malevolenceCount = self.vb.malevolenceCount + 1
		timerMalevolenceCD:Start(nil, self.vb.malevolenceCount+1)
		updateAllTimers(self, 4.9)
--	elseif spellId == 350518 then
--		self.vb.unrelentingCount = self.vb.unrelentingCount + 1
--		warnUnrelentingTorment:Show(self.vb.unrelentingCount)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 351066 or spellId == 351067 or spellId == 351073 then--Shatter (Helm of Suffering, Malicious Gauntlets, Rattlecage of Agony)
		self:SetStage(0)
		self.vb.shatterCount = self.vb.shatterCount + 1
		warnShatter:Show(self.vb.shatterCount)
		--Doing any of below might not be answer, it might be a simmple of running updateAllTimers() with about a 8.5 ICD
		--followed by hardcoding spell queue priority in update function
		--Then letting spell queue take over
		if self:IsMythic() then
			if self.vb.phase == 2 then--First shatter
				--If time is less than 8.5, it's extended to 8.5, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 8.5 then
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 8.5 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
				end
				--If time is less than 12.1, it's extended to 12.1 (may need fine tuning since hard to find log it's not affected by suffering or Malev delay)
				if timerGraspofMaliceCD:GetRemaining() < 12.1 then--It's typically 37, 47 or 52 depending on spell queue overlap with push timing
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 12.1 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
				end
				--Malevolence has 15.9 if grasp ICD was activated
				if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 15.9 then--Will be pushed to 20.8 or 29 if suffering is cast after grasp
					local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
					local extend = 15.9 - (total-elapsed)
					DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--					timerMalevolenceCD:Stop()
					timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
				end
			elseif self.vb.phase == 3 then--Second Shatter
				--If time is less than 8.3, it's extended to 8.5, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 8.5 then
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 8.3 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
					--Malevolence has 19.6 if grasp ICD was activated but will also likely be pushed to 32.3 if suffering is cast
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 19.6 then
						local elapsed2, total2 = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend2 = 19.6 - (total2-elapsed2)
						DBM:Debug("timerMalevolenceCD extended by: "..extend2, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed2, total2+extend2, self.vb.malevolenceCount+1)
					end
				else--If orbs aren't first at 8.3 then bombs will be
					--Malevolence has 8.3 if grasp ICD was activated
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 8.3 then
						local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend = 8.3 - (total-elapsed)
						DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
					end
				end
				--If time is less than 51.7, it's extended to 51.7 (may need fine tuning/shortening since this one gets into spell queue hell most pulls)
				if timerGraspofMaliceCD:GetRemaining() < 51.7 then--It's typically 37, 47 or 52 depending on spell queue overlap with push timing
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 51.7 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
				end
			else--4 Third Shatter
				--If time is less than 9.6, it's extended to 9.6, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 9.6 then
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 9.6 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
					--Malevolence has 19.6 if grasp ICD was activated but will also likely be pushed to 32.3 if suffering is cast
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 19.6 then
						local elapsed2, total2 = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend2 = 19.6 - (total2-elapsed2)
						DBM:Debug("timerMalevolenceCD extended by: "..extend2, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed2, total2+extend2, self.vb.malevolenceCount+1)
					end
				else--If orbs aren't first at 9.6 then bombs will be
					--Malevolence has 9.6 if grasp ICD was activated
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 9.6 then
						local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend = 9.6 - (total-elapsed)
						DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
					end
				end
				--If time is less than 44.2, it's extended to 44.2 (may need fine tuning since hard to find log it's not affected by suffering or Malev delay)
				if timerGraspofMaliceCD:GetRemaining() < 44.2 then--It's typically 37, 47 or 52 depending on spell queue overlap with push timing
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 44.2 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
				end
			end
		else
			--TODO, Suffering isn't done yet, but to be honest it's lower timer and higher priority in spell queue makes it not as important
			if self.vb.phase == 2 then--First shatter
				--If time is less than 10.8, it's extended to 10.8
				if timerGraspofMaliceCD:GetRemaining() < 10.8 then
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 10.8 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
					--Malevolence has 18.3 if grasp ICD was activated
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 18.3 then
						local elapsed2, total2 = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend2 = 18.3 - (total2-elapsed2)
						DBM:Debug("timerMalevolenceCD extended by: "..extend2, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed2, total2+extend2, self.vb.malevolenceCount+1)
					end
				else--
					--Malevolence 8.3 if grasp ICD wasn't activated
					if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 8.3 then
						local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
						local extend = 8.3 - (total-elapsed)
						DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--						timerMalevolenceCD:Stop()
						timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
					end
				end
				--If time is less than 24.1, it's extended to 24.1, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 24.1 then--Often delayed by suffering spell queue
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 24.1 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
				end
			elseif self.vb.phase == 3 then--Second Shatter
				--Malevolence 8.3 if grasp ICD wasn't activated
				--This is still missing delay conditional if suffering is expected before it
				--But the updateAllTimers will handle it either way
				if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 8.3 then
					local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
					local extend = 8.3 - (total-elapsed)
					DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--					timerMalevolenceCD:Stop()
					timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
				end
				--If time is less than 25, it's extended to 25, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 25 then
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 25 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
				end
				--If time is less than 37.8, it's extended to 36.4 (may need fine tuning since hard to find log it's not affected by suffering or Malev delay)
				if timerGraspofMaliceCD:GetRemaining() < 36.4 then--It's typically 37, 47 or 52 depending on spell queue overlap with push timing
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 36.4 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
				end
			else--4 Third Shatter
				--If time is less than 22.9, it's extended to 25, if time is greater then CD from previous stage carries over
				if timerOrbofTormentCD:GetRemaining(self.vb.orbCount+1) < 22.9 then
					local elapsed, total = timerOrbofTormentCD:GetTime(self.vb.orbCount+1)
					local extend = 22.9 - (total-elapsed)
					DBM:Debug("timerOrbofTormentCD extended by: "..extend, 2)
--					timerOrbofTormentCD:Stop()
					timerOrbofTormentCD:Update(elapsed, total+extend, self.vb.orbCount+1)
				end
				--Malevolence 26.5 if grasp ICD wasn't activated
				if timerMalevolenceCD:GetRemaining(self.vb.malevolenceCount+1) < 26.5 then
					local elapsed, total = timerMalevolenceCD:GetTime(self.vb.malevolenceCount+1)
					local extend = 26.5 - (total-elapsed)
					DBM:Debug("timerMalevolenceCD extended by: "..extend, 2)
--					timerMalevolenceCD:Stop()
					timerMalevolenceCD:Update(elapsed, total+extend, self.vb.malevolenceCount+1)
				end
				--If time is less than 44.8, it's extended to 44.8 (may need fine tuning since hard to find log it's not affected by suffering or Malev delay)
				if timerGraspofMaliceCD:GetRemaining() < 44.8 then
					local elapsed, total = timerGraspofMaliceCD:GetTime()
					local extend = 44.8 - (total-elapsed)
					DBM:Debug("timerGraspofMaliceCD extended by: "..extend, 2)
--					timerGraspofMaliceCD:Stop()
					timerGraspofMaliceCD:Update(elapsed, total+extend)
				end
			end
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 349908 then
		if self:AntiSpam(5, 1) then
			self.vb.iconCount = 7
			self.vb.orbCount = self.vb.orbCount + 1
			warnOrbofTorment:Show(self.vb.orbCount)
			timerOrbofTormentCD:Start(29.4, self.vb.orbCount+1)
			updateAllTimers(self, 3.5)
		end
		if self.Options.SetIconOnOrbs then
			self:ScanForMobs(args.destGUID, 2, self.vb.iconCount, 1, nil, 12, "SetIconOnOrbs")
		end
		self.vb.iconCount = self.vb.iconCount - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 355790 then
		if self.Options.NPAuraOnOrbEternalTorment then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 20)
		end
	elseif spellId == 350469 then
		local icon = self.vb.malevolenceIcon
		if self.Options.SetIconOnMalevolence then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMalevolence:Show(self:IconNumToTexture(icon))
			specWarnMalevolence:Play("mm"..icon)
			yellMalevolence:Yell(icon, icon)
			yellMalevolenceFades:Countdown(spellId, nil, icon)
		end
		warnMalevolence:CombinedShow(0.3, args.destName)
		self.vb.malevolenceIcon = self.vb.malevolenceIcon + 1
	elseif spellId == 349890 then
		if args:IsPlayer() then
			specWarnSuffering:Show()
			specWarnSuffering:Play("targetyou")
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				specWarnSufferingSwap:Show(args.destName)
				specWarnSufferingSwap:Play("tauntboss")
			end
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 355790 then
		if self.Options.NPAuraOnOrbEternalTorment then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
		if self:AntiSpam(3, 2) then
			warnOrbEternalTorment:Show()
		end
	elseif spellId == 350469 then
		if args:IsPlayer() then
			yellMalevolenceFades:Cancel()
		end
		if self.Options.SetIconOnMalevolence then
			self:SetIcon(args.destName, 0)
		end
--	elseif spellId == 350097 then
--		if args:IsPlayer() then
--			yellAgonyFades:Cancel()
--		end
--	elseif spellId == 350894 then
--		if args:IsPlayer() then
--			yellSufferingFades:Cancel()
--		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 350489 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177289 then--https://ptr.wowhead.com/npc=177289/rattlecage-of-agony

	elseif cid == 177268 then--https://ptr.wowhead.com/npc=177268/helm-of-suffering

	elseif cid == 177287 then--https://ptr.wowhead.com/npc=177287/malicious-gauntlet

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 350676 then--Orb of Torment
--		self.vb.iconCount = 7
--		self.vb.orbCount = self.vb.orbCount + 1
--		warnOrbofTorment:Show(self.vb.orbCount)
--		timerOrbofTormentCD:Start(35, self.vb.orbCount+1)
	end
end
--]]
