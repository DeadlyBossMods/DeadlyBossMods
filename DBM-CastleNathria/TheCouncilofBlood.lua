local mod	= DBM:NewMod(2426, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166971, 166969, 166970)--Castellan Niklaus, Baroness Frieda, Lord Stavros
mod:SetEncounterID(2412)
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8)
mod:SetHotfixNoticeRev(20201107000000)--2020, 11, 07
mod:SetMinSyncRevision(20201107000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 330965 330978 327497 346654 346690 337110 346657 346681 346303 346790 346698 346800",
	"SPELL_CAST_SUCCESS 331634 330959 346657 346303",
	"SPELL_AURA_APPLIED 330967 331636 331637 332535 346694 347350 346690 346709",
	"SPELL_AURA_APPLIED_DOSE 332535 346690",
	"SPELL_AURA_REMOVED 330967 331636 331637 346694 330959 347350",
	"SPELL_AURA_REMOVED_DOSE 347350",
	"SPELL_PERIODIC_DAMAGE 346945",
	"SPELL_PERIODIC_MISSED 346945",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, upgrade Dreadbolt volley to special warning if important enough
--TODO, who do soul spikes target? can they be target scanned? should it warn?
--TODO, upgrade Cadre to special warning for melee/everyone based on where they spawn?
--TODO, tune the tank stack warning for drain essence
--TODO, dance helper?
--TODO, Soul Spikes mid spikes swap, similar to the mid combo swap of Zek'vhoz?
--TODO, Handling of boss timers with dance. Currently they just mass queue up and don't reset, pause or anything, resulting in bosses chaining abilities after dance.
--		As such, keep an eye on this changing, if it doesn't, just add "keep" to all timers to show they are all queued up. if it changes, update timers to either reset, or pause
--[[
(ability.id = 330965 or ability.id = 330978 or ability.id = 327497 or ability.id = 346654 or ability.id = 337110 or ability.id = 346657 or ability.id = 346681 or ability.id = 346698 or ability.id = 346690 or ability.id = 346800) and type = "begincast"
 or (ability.id = 331634) and type = "cast"
 or ability.id = 332535 or ability.id = 330959 or ability.id = 332538 or abiity.id = 331918 or ability.id = 346709
 or (ability.id = 330964 or ability.id = 335773) and type = "cast"
 or (target.id = 166971 or target.id = 166969 or target.id = 166970) and type = "death"
 --]]
--Castellan Niklaus
local warnDualistsRiposte						= mod:NewStackAnnounce(346690, 2, nil, "Tank|Healer")
local warnDutifulAttendant						= mod:NewSpellAnnounce(346698, 2)
local warnDredgerServants						= mod:NewSpellAnnounce(330978, 2)--One boss dead
----Adds
local warnCastellansCadre						= mod:NewSpellAnnounce(330965, 2)--Two bosses dead
local warnFixate								= mod:NewTargetAnnounce(330967, 3)--Two bosses dead
local warnSintouchedBlade						= mod:NewSpellAnnounce(346790, 4)
--Baroness Frieda
local warnDreadboltVolley						= mod:NewCountAnnounce(337110, 2)
--local warnScarletLetter							= mod:NewTargetNoFilterAnnounce(331706, 3)--One boss dead
--local warnUnstoppableCharge						= mod:NewSpellAnnounce(334948, 4)--Two bosses dead
--Lord Stavros
local warnDarkRecital							= mod:NewTargetNoFilterAnnounce(331634, 3)
local warnDancingFools							= mod:NewSpellAnnounce(330964, 2)--Two bosses dead
--Intermission
local warnDanceOver								= mod:NewEndAnnounce(330959, 2)
local warnDancingFever							= mod:NewTargetNoFilterAnnounce(347350, 4)

--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(346945, nil, nil, nil, 1, 8)
--Castellan Niklaus
local specWarnDualistsRiposte					= mod:NewSpecialWarningStack(346690, nil, 2, nil, nil, 1, 2)
local specWarnDualistsRiposteTaunt				= mod:NewSpecialWarningTaunt(346690, nil, nil, nil, 1, 2)
local specWarnFixate							= mod:NewSpecialWarningRun(330967, nil, nil, nil, 4, 2)--Two bosses dead
----Mythic
--local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
--Baroness Frieda
local specWarnPridefulEruption					= mod:NewSpecialWarningMoveAway(346657, nil, nil, nil, 2, 2)--One boss dead
--Lord Stavros
local specWarnEvasiveLunge						= mod:NewSpecialWarningDodge(327497, nil, nil, nil, 2, 2)
local specWarnDarkRecital						= mod:NewSpecialWarningMoveTo(331634, nil, nil, nil, 1, 2)--One boss dead
local yellDarkRecitalRepeater					= mod:NewIconRepeatYell(331634, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--One boss dead
local specWarnWaltzofBlood						= mod:NewSpecialWarningDodge(327616, nil, nil, nil, 2, 2)
--Intermission
local specWarnDanseMacabre						= mod:NewSpecialWarningSpell(328495, nil, nil, nil, 3, 2)
local yellDancingFever							= mod:NewYell(347350, nil, false)--Off by default do to potential to spam when spread, going to dry run nameplate auras for this

--Castellan Niklaus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22147))--2 baseline abilities
local timerDualistsRiposteCD					= mod:NewCDTimer(18.7, 346690, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerDutifulAttendantCD					= mod:NewCDTimer(44.9, 346698, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)--Used after death on Mythic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22201))--One is dead
local timerDredgerServantsCD					= mod:NewCDTimer(44.3, 330978, nil, nil, nil, 1)--Iffy on verification
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22199))--Two are dead
local timerCastellansCadreCD					= mod:NewAITimer(26.7, 330965, nil, nil, nil, 1)
--local timerSintouchedBladeCD						= mod:NewNextCountTimer(12.1, 308872, nil, nil, nil, 5)
--Baroness Frieda
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22148))--2 baseline abilities
local timerDrainEssenceCD						= mod:NewCDTimer(22.5, 346654, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerDreadboltVolleyCD					= mod:NewCDTimer(20, 337110, nil, nil, nil, 2, nil, DBM_CORE_L.MAGIC_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22202))--One is dead
local timerPridefulEruptionCD					= mod:NewCDTimer(25, 346657, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22945))--Two are dead
local timerSoulSpikesCD							= mod:NewAITimer(19.4, 346681, nil, nil, nil, 3)
--Lord Stavros
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22149))--2 baseline abilities
local timerEvasiveLungeCD						= mod:NewCDTimer(18.7, 327497, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--14.6-17.1
local timerDarkRecitalCD						= mod:NewCDTimer(45, 331634, nil, nil, nil, 3)--Continues on Mythic after death instead of gaining new ability
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22203))--One is dead
local timerWaltzofBloodCD						= mod:NewCDTimer(21.8, 327616, nil, nil, nil, 3)--21.8-23.5
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22206))--Two are dead
local timerDancingFoolsCD						= mod:NewCDTimer(30.3, 330964, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 346657)
mod:AddInfoFrameOption(347350, true)
mod:AddSetIconOption("SetIconOnDancingFools", 346826, true, false, {8})
mod:AddNamePlateOption("NPAuraOnFixate", 330967)
mod:AddNamePlateOption("NPAuraOnShield", 346694)
mod:AddNamePlateOption("NPAuraOnUproar", 346303)

mod.vb.phase = 1
mod.vb.feversActive = 0
mod.vb.volleyCast = 0
mod.vb.nikDead = false
mod.vb.friedaDead = false
mod.vb.stavrosDead = false
local darkRecitalTargets = {}
local playerName = UnitName("player")
local castsPerGUID = {}
local FeverStacks = {}

local function warndarkRecitalTargets(self)
	warnDarkRecital:Show(table.concat(darkRecitalTargets, "<, >"))
	table.wipe(darkRecitalTargets)
end

local function darkRecitalYellRepeater(self, text, runTimes)
	yellDarkRecitalRepeater:Yell(text)
--	runTimes = runTimes + 1
--	if runTimes < 4 then--If they fix visual bugs, enable this restriction
		self:Schedule(2, darkRecitalYellRepeater, self, text, runTimes)
--	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.feversActive = 0
	self.vb.volleyCast = 1
	self.vb.nikDead = false
	self.vb.friedaDead = false
	self.vb.stavrosDead = false
	table.wipe(darkRecitalTargets)
	table.wipe(castsPerGUID)
	table.wipe(FeverStacks)
	--Castellan Niklaus
	timerDutifulAttendantCD:Start(6.5-delay)
	timerDualistsRiposteCD:Start(16.5-delay)
	--Baroness Frieda
	timerDreadboltVolleyCD:Start(5-delay)
	timerDrainEssenceCD:Start(13.6-delay)
	--Lord Stavros
	timerEvasiveLungeCD:Start(10.6-delay)
	timerDarkRecitalCD:Start(22.9-delay)
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnUproar then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnUproar then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 330965 then
		warnCastellansCadre:Show()
		timerCastellansCadreCD:Start()
	elseif spellId == 330978 then
		warnDredgerServants:Show()
		timerDredgerServantsCD:Start(self.vb.phase == 2 and 44.3 or 44.3)--44.3 Phase 2, Phase 3 unknown so marked same for now just to trigger timer debug
	elseif spellId == 327497 then
		specWarnEvasiveLunge:Show()
		specWarnEvasiveLunge:Play("chargemove")
		timerEvasiveLungeCD:Start(self.vb.phase == 1 and 18.7 or self.vb.phase == 2 and 14.9 or 7.5)
	elseif spellId == 346654 then
		timerDrainEssenceCD:Start(self.vb.phase == 1 and 22.5 or self.vb.phase == 2 and 25 or 25)--Phase 3 unknown, phase 2 time used. Yes Phase 2 timer longer than phase 1
		timerDreadboltVolleyCD:Stop()
		timerDreadboltVolleyCD:Start(7)
	elseif spellId == 346690 then
		timerDualistsRiposteCD:Start(self.vb.phase == 1 and 18.7 or self.vb.phase == 2 and 14.9 or 7.5)
	elseif spellId == 337110 then--Cast in sets of 2 or 3
		if self:AntiSpam(12, 4) then
			self.vb.volleyCast = 0
		end
		self.vb.volleyCast = self.vb.volleyCast + 1
		warnDreadboltVolley:Show(self.vb.volleyCast)
		if args:GetSrcCreatureID() == 166969 then--Main boss
			local timer = self.vb.volleyCast == 3 and 12 or 4
			--Phase 2 always 12, phase 1 is 4 between 3 set then 12 til next set
			timerDreadboltVolleyCD:Start(self.vb.phase == 1 and timer or self.vb.phase == 2 and 12)
			timerDreadboltVolleyCD:UpdateInline(DBM_CORE_L.MYTHIC_ICON)
		else
			--When dead, it's set of 3, 3.5 apart then 30 or 35 between sets, based on which phase it is
			local timer = self.vb.phase == 2 and 35 or 30
			timerDreadboltVolleyCD:Start(self.vb.volleyCast == 3 and timer or 3.25)
		end
	elseif spellId == 346657 then
		specWarnPridefulEruption:Show()
		specWarnPridefulEruption:Play("scatter")
		timerPridefulEruptionCD:Start(self.vb.phase == 2 and 25 or 25)--Phase 3 unknown
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellId == 346681 then
		timerSoulSpikesCD:Start()
	elseif spellId == 346303 then
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 15)
		end
	elseif spellId == 346790 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
--		local addnumber, count = self.vb.darkManifestationCount, castsPerGUID[args.sourceGUID]
		local count = castsPerGUID[args.sourceGUID]
		warnSintouchedBlade:Show(count)--addnumber.."-"..
--		timerSintouchedBladeCD:Start(12.1, count+1, args.sourceGUID)
	elseif spellId == 346698 then
		warnDutifulAttendant:Show()
		if args:GetSrcCreatureID() == 166971 then--Main boss
			timerDutifulAttendantCD:Start(44.9)
		else
			timerDutifulAttendantCD:Start(self.vb.phase == 2 and 44.9 or 36.2)--This might also be true of regular boss too
			timerDutifulAttendantCD:UpdateInline(DBM_CORE_L.MYTHIC_ICON)
		end
	elseif spellId == 346800 then
		specWarnWaltzofBlood:Show()
		specWarnWaltzofBlood:Play("watchstep")
		timerWaltzofBloodCD:Start(59.6)--Same in P2 and P3
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 331634 then
		if args:GetSrcCreatureID() == 166970 then--Main boss
			timerDarkRecitalCD:Start(self.vb.phase == 1 and 45 or self.vb.phase == 2 and 60 or 30)
		else
			timerDarkRecitalCD:Start(43.9)--Unknown if P3 is same, but 43.9 confirmed for P2
			timerDarkRecitalCD:UpdateInline(DBM_CORE_L.MYTHIC_ICON)
		end
	elseif spellId == 330959 and self:AntiSpam(10, 1) then
		specWarnDanseMacabre:Show()
		specWarnDanseMacabre:Play("specialsoon")
		--Automatic timer extending.
		--After many rounds of testing blizzard finally listened to feedback and suspends active CD timers during dance
		--Castellan Niklaus
		if not self.vb.nikDead then
			timerDutifulAttendantCD:AddTime(40)--Alive and dead ability
			timerDualistsRiposteCD:AddTime(40)
			if self.vb.phase >= 2 then--1 Dead
				timerDredgerServantsCD:AddTime(40)
			end
			if self.vb.phase >= 3 then--1 Dead
				timerCastellansCadreCD:AddTime(40)
			end
		else
			if self:IsMythic() then
				timerDutifulAttendantCD:AddTime(40)
			end
		end
		--Baroness Frieda
		if not self.vb.friedaDead then
			timerDreadboltVolleyCD:AddTime(40)
			timerDrainEssenceCD:AddTime(40)
			if self.vb.phase >= 2 then--1 Dead
				timerSoulSpikesCD:AddTime(40)
			end
			if self.vb.phase >= 3 then--1 Dead
				timerSoulSpikesCD:AddTime(40)
			end
		else
			if self:IsMythic() then
				timerDreadboltVolleyCD:AddTime(40)
			end
		end
		--Lord Stavros
		if not self.vb.stavrosDead then
			timerDarkRecitalCD:AddTime(40)
			timerEvasiveLungeCD:AddTime(40)
			if self.vb.phase >= 2 then--1 Dead
				timerWaltzofBloodCD:AddTime(40)
			end
			if self.vb.phase >= 3 then--1 Dead
				timerDancingFoolsCD:AddTime(40)
			end
		else
			if self:IsMythic() then
				timerDarkRecitalCD:AddTime(40)
			end
		end
	elseif spellId == 346657 then

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 346303 then
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 330967 then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 12)
			end
		end
	elseif spellId == 346690 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnDualistsRiposte:Show(amount)
				specWarnDualistsRiposte:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnDualistsRiposteTaunt:Show(args.destName)
					specWarnDualistsRiposteTaunt:Play("tauntboss")
				else
					warnDualistsRiposte:Show(args.destName, amount)
				end
			end
		else
			warnDualistsRiposte:Show(args.destName, amount)
		end
	elseif spellId == 331636 or spellId == 331637 then
		--Pair offs actually work by 331636 paired with 331637 in each set, but combat log order also works
		darkRecitalTargets[#darkRecitalTargets + 1] = args.destName
		self:Unschedule(warndarkRecitalTargets)
		self:Schedule(0.3, warndarkRecitalTargets, self)
		local icon
		if #darkRecitalTargets % 2 == 0 then
			icon = #darkRecitalTargets / 2--Generate icon on the evens, because then we can divide it by 2 to assign raid icon to that pair
			local playerIsInPair = false
			--TODO, REMOVE me if entire raid doesn't get it on mythic (they probably don't)
			if icon == 9 then
				icon = "(°,,°)"
			elseif icon == 10 then
				icon = "(•_•)"
			end
			if darkRecitalTargets[#darkRecitalTargets-1] == UnitName("player") then
				specWarnDarkRecital:Show(darkRecitalTargets[#darkRecitalTargets])
				specWarnDarkRecital:Play("gather")
				playerIsInPair = true
			elseif darkRecitalTargets[#darkRecitalTargets] == UnitName("player") then
				specWarnDarkRecital:Show(darkRecitalTargets[#darkRecitalTargets-1])
				specWarnDarkRecital:Play("gather")
				playerIsInPair = true
			end
			if playerIsInPair then--Only repeat yell on mythic and mythic+
				self:Unschedule(darkRecitalYellRepeater)
				if type(icon) == "number" then icon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "") end
				self:Schedule(2, darkRecitalYellRepeater, self, icon, 0)
				yellDarkRecitalRepeater:Yell(icon)
			end
		end
	elseif (spellId == 332535 or spellId == 346709) and self:AntiSpam(30, spellId) then--Infused/Empowered
		--Bump phase and stop all timers since regardless of kills, phase changes reset anyone that's still up
--		self.vb.phase = self.vb.phase + 1
		local cid = self:GetCIDFromGUID(args.destGUID)
		--As of last test, abilities don't reset when empowerment gains, only new ability starts
		--This is subject to change like anything, so commented timers won't be deleted until end of beta, to be certain
		if spellId == 346709 then--Two Dead
			self.vb.phase = 3
			--Castellan Niklaus
			timerDualistsRiposteCD:Stop()
			timerDutifulAttendantCD:Stop()
			if self.vb.nikDead then
				if self:IsMythic() then
					timerDutifulAttendantCD:Start(19.1)--Confirmed
				end
			else
				--timerDualistsRiposteCD:Start(8.2)--Unknown
				--timerDutifulAttendantCD:Start(34.4)--Unknown
				timerCastellansCadreCD:Start(3)--Unknown, Still an AI timer
			end
			--Baroness Frieda
			timerDrainEssenceCD:Stop()
			timerDreadboltVolleyCD:Stop()
			timerPridefulEruptionCD:Stop()
			if self.vb.friedaDead then
				if self:IsMythic() then
					timerDreadboltVolleyCD:Start(38.2)--Confirmed
				end
			else
				--timerDreadboltVolleyCD:Start(38.2)--Unknown
				timerSoulSpikesCD:Start(3)--Unnkown, using AI timer
				--timerDrainEssenceCD:Start(3)
				--timerPridefulEruptionCD:Start(3)--Unknown
			end
			--Lord Stavros
			timerEvasiveLungeCD:Stop()
			timerWaltzofBloodCD:Stop()
			timerDarkRecitalCD:Stop()
			if self.vb.stavrosDead then
				if self:IsMythic() then
					--timerDarkRecitalCD:Start(5)--Unknown
				end
			else
				timerDarkRecitalCD:Start(5)
				timerEvasiveLungeCD:Start(7)
				timerDancingFoolsCD:Start(25.7)
				timerWaltzofBloodCD:Start(54.4)--START
			end
		else--One Dead (332535)
			self.vb.phase = 2
			--Castellan Niklaus
			timerDualistsRiposteCD:Stop()
			timerDutifulAttendantCD:Stop()
			if self.vb.nikDead then
				if self:IsMythic() then
					--timerDutifulAttendantCD:Start(34.4)--Unknown
				end
			else
				timerDualistsRiposteCD:Start(8.2)
				timerDredgerServantsCD:Start(12)
				timerDutifulAttendantCD:Start(34.4)
			end
			--Baroness Frieda
			timerDrainEssenceCD:Stop()
			timerDreadboltVolleyCD:Stop()
			if self.vb.friedaDead then
				if self:IsMythic() then
					timerDreadboltVolleyCD:Start(17.2)
				end
			else
				timerDrainEssenceCD:Start(5.7)
				timerDreadboltVolleyCD:Start(1.3)--Used like 1 second after
				timerPridefulEruptionCD:Start(18.2)
			end
			--Lord Stavros
			timerEvasiveLungeCD:Stop()
			timerDarkRecitalCD:Stop()
			if self.vb.stavrosDead then
				if self:IsMythic() then
					timerDarkRecitalCD:Start(26.6)
				end
			else
				timerDarkRecitalCD:Start(6)
				timerEvasiveLungeCD:Start(6.9)
				timerWaltzofBloodCD:Start(27)--START
			end
		end
	elseif spellId == 346694 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 347350 then
		self.vb.feversActive = self.vb.feversActive + 1
		warnDancingFever:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			yellDancingFever:Countdown(spellId)
		end
		FeverStacks[args.destName] = 3
		if self.Options.InfoFrame then
			if not DBM.Infoframe:IsShown() then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(20, "table", FeverStacks, 1)
			else
				DBM.InfoFrame:UpdateTable(FeverStacks)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 330967 and args:IsPlayer() then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 331636 or spellId == 331637 then
		if args:IsPlayer() then
			self:Unschedule(darkRecitalYellRepeater)
		end
	elseif spellId == 346694 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 330959 and self:AntiSpam(10, 2) then
		warnDanceOver:Show()
		--TODO, timer correction if blizzard changes how they work
	elseif spellId == 347350 then
		self.vb.feversActive = self.vb.feversActive - 1
		if args:IsPlayer() then
			yellDancingFever:Cancel()
		end
		FeverStacks[args.destName] = nil
		if self.Options.InfoFrame then
			if self.vb.feversActive > 0 then
				DBM.InfoFrame:UpdateTable(FeverStacks)
			else
				DBM.InfoFrame:Hide()
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 347350 then
		FeverStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(FeverStacks)
		end
	end
end

--https://shadowlands.wowhead.com/npc=169925/begrudging-waiter
--https://shadowlands.wowhead.com/npc=168406/waltzing-venthyr
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 166971 then--Castellan Niklaus
		self.vb.nikDead = true
		timerDualistsRiposteCD:Stop()
		timerDutifulAttendantCD:Stop()
		timerDredgerServantsCD:Stop()
	elseif cid == 166969 then--Baroness Frieda
		self.vb.friedaDead = true
		timerDrainEssenceCD:Stop()
		timerDreadboltVolleyCD:Stop()
		timerPridefulEruptionCD:Stop()
	elseif cid == 166970 then--Lord Stavros
		self.vb.stavrosDead = true
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		timerDancingFoolsCD:Stop()
	elseif cid == 168406 then--Waltzing Venthyr
		if self.Options.NPAuraOnUproar then
			DBM.Nameplate:Hide(true, args.destGUID, 346303)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 346945 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 346826 then--Dancing Fools
		warnDancingFools:Show()
		timerDancingFoolsCD:Start(30.7)
		if self.Options.SetIconOnDancingFools then
			self:RegisterShortTermEvents(
				"NAME_PLATE_UNIT_ADDED",
				"FORBIDDEN_NAME_PLATE_UNIT_ADDED"
			)
		end
	end
end

--This assumes the real one is only one with nameplate. Based on video it appears so
--But that doesn't mean other units don't have nameplates that blizzard just adjusted z axis on so it's off the screen.
function mod:NAME_PLATE_UNIT_ADDED(unit)
	if unit then
		local guid = UnitGUID(unit)
		if not guid then return end
		local cid = self:GetCIDFromGUID(guid)
		if cid == 176026 then
			if not GetRaidTargetIndex(unit) then
				SetRaidTarget(unit, 8)
			end
			self:UnregisterShortTermEvents()
		end
	end
end
mod.FORBIDDEN_NAME_PLATE_UNIT_ADDED = mod.NAME_PLATE_UNIT_ADDED
