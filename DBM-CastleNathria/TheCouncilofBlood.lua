local mod	= DBM:NewMod(2426, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166971, 166969, 166970)--Castellan Niklaus, Baroness Frieda, Lord Stavros
mod:SetEncounterID(2412)
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20201028000000)--2020, 10, 28
mod:SetMinSyncRevision(20201028000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 330965 330978 327497 327052 346690 337110 346657 346681 346303 346790",
	"SPELL_CAST_SUCCESS 346692 331634 330959 346657 346303",
	"SPELL_AURA_APPLIED 330967 331636 331637 332535 346694 347350 346690",
	"SPELL_AURA_APPLIED_DOSE 332535 346690 347350",
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
(ability.id = 330965 or ability.id = 330978 or ability.id = 327497 or ability.id = 327052 or ability.id = 337110 or ability.id = 346657 or ability.id = 346681) and type = "begincast"
 or (ability.id = 346692 or ability.id = 331634) and type = "cast"
 or ability.id = 332535 or ability.id = 330959
 or (ability.id = 330964 or ability.id = 335773) and type = "cast"
 or (target.id = 166971 or target.id = 166969 or target.id = 166970) and type = "death"
 --]]
--Castellan Niklaus
local warnDualistsRiposte						= mod:NewStackAnnounce(346690, 2, nil, "Tank|Healer")
local warnDutifulAttendant						= mod:NewSpellAnnounce(346692, 2)
local warnDredgerServants						= mod:NewSpellAnnounce(330978, 2)--One boss dead
----Adds
local warnCastellansCadre						= mod:NewSpellAnnounce(330965, 2)--Two bosses dead
local warnFixate								= mod:NewTargetAnnounce(330967, 3)--Two bosses dead
local warnSintouchedBlade						= mod:NewSpellAnnounce(346790, 4)
--Baroness Frieda
local warnDreadboltVolley						= mod:NewCastAnnounce(337110, 2)
--local warnScarletLetter							= mod:NewTargetNoFilterAnnounce(331706, 3)--One boss dead
--local warnUnstoppableCharge						= mod:NewSpellAnnounce(334948, 4)--Two bosses dead
--Lord Stavros
local warnDarkRecital							= mod:NewTargetNoFilterAnnounce(331634, 3)
local warnDancingFools							= mod:NewSpellAnnounce(330964, 2)--Two bosses dead
--Intermission
local warnDanceOver								= mod:NewEndAnnounce(330959, 2)
local warnDancingFever							= mod:NewSpellAnnounce(347350, 4)

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
local specWarnDanseMacabre						= mod:NewSpecialWarningSpell(331005, nil, nil, nil, 3, 2)
local yellDancingFever							= mod:NewYell(347350, nil, false)--Off by default do to potential to spam when spread, going to dry run nameplate auras for this

--Castellan Niklaus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22147))--2 baseline abilities
local timerDualistsRiposteCD					= mod:NewAITimer(22, 346690, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerDutifulAttendantCD					= mod:NewAITimer(18.2, 346692, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)--Used after death on Mythic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22201))--One is dead
local timerDredgerServantsCD					= mod:NewAITimer(32.9, 330978, nil, nil, nil, 1)--32-37
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22199))--Two are dead
local timerCastellansCadreCD					= mod:NewAITimer(26.7, 330965, nil, nil, nil, 1)
--local timerSintouchedBladeCD						= mod:NewNextCountTimer(12.1, 308872, nil, nil, nil, 5)
--Baroness Frieda
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22148))--2 baseline abilities
local timerDrainEssenceCD						= mod:NewCDTimer(22, 327052, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerDreadboltVolleyCD					= mod:NewAITimer(22, 337110, nil, nil, nil, 2, nil, DBM_CORE_L.MAGIC_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22202))--One is dead
local timerPridefulEruptionCD					= mod:NewAITimer(30.5, 346657, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22205))--Two are dead
local timerSoulSpikesCD							= mod:NewAITimer(19.4, 346681, nil, nil, nil, 3)
--Lord Stavros
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22149))--2 baseline abilities
local timerEvasiveLungeCD						= mod:NewCDTimer(14.6, 327497, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--14.6-17.1
local timerDarkRecitalCD						= mod:NewCDTimer(21.9, 331634, nil, nil, nil, 3)--Continues on Mythic after death instead of gaining new ability
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22203))--One is dead
local timerWaltzofBloodCD						= mod:NewCDTimer(21.8, 327616, nil, nil, nil, 3)--21.8-23.5
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22206))--Two are dead
local timerDancingFoolsCD						= mod:NewCDTimer(30.3, 330964, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 346657)
mod:AddInfoFrameOption(347350, true)
--mod:AddSetIconOption("SetIconOnMuttering", 310358, true, false, {2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnFixate", 330967)
mod:AddNamePlateOption("NPAuraOnShield", 346694)
mod:AddNamePlateOption("NPAuraOnUproar", 346303)

mod.vb.phase = 1
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
	table.wipe(darkRecitalTargets)
	table.wipe(castsPerGUID)
	table.wipe(FeverStacks)
	--Castellan Niklaus
	timerDualistsRiposteCD:Start(1-delay)
	timerDutifulAttendantCD:Start(1-delay)
	--Baroness Frieda
	timerDrainEssenceCD:Start(6.9-delay)
	timerDreadboltVolleyCD:Start(1-delay)
	--Lord Stavros
	timerEvasiveLungeCD:Start(10.6-delay)
	timerWaltzofBloodCD:Start(16.6-delay)
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnUproar then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
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
		timerDredgerServantsCD:Start()
	elseif spellId == 327497 then
		specWarnEvasiveLunge:Show()
		specWarnEvasiveLunge:Play("chargemove")
		timerEvasiveLungeCD:Start()
	elseif spellId == 327052 then
		timerDrainEssenceCD:Start()
	elseif spellId == 346690 then
		timerDualistsRiposteCD:Start()
	elseif spellId == 337110 then
		warnDreadboltVolley:Show()
		timerDreadboltVolleyCD:Start()
	elseif spellId == 346657 then
		specWarnPridefulEruption:Show()
		specWarnPridefulEruption:Play("scatter")
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 346692 then
		warnDutifulAttendant:Show()
		timerDutifulAttendantCD:Start()
	elseif spellId == 331634 then
		if args:GetSrcCreatureID() == 166970 then--Main boss
			timerDarkRecitalCD:Start(21.9)
		else
			timerDarkRecitalCD:Start(36.8)
			timerDarkRecitalCD:UpdateInline(DBM_CORE_L.MYTHIC_ICON)
		end
	elseif spellId == 330959 and self:AntiSpam(10, 1) then
		specWarnDanseMacabre:Show()
		specWarnDanseMacabre:Play("specialsoon")
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
	elseif spellId == 332535 then--Anima Infusion
		if self:AntiSpam(30, spellId) then
			--Bump phase and stop all timers since regardless of kills, phase changes reset anyone that's still up
			self.vb.phase = self.vb.phase + 1
		end
		local cid = self:GetCIDFromGUID(args.destGUID)
		--As of last test, abilities don't reset when empowerment gains, only new ability starts
		--This is subject to change like anything, so commented timers won't be deleted until end of beta, to be certain
		if self.vb.phase == 3 then--Two Dead
			if cid == 166971 then--Castellan Niklaus
				--timerDualistsRiposteCD:Stop()
				--timerDutifulAttendantCD:Stop()
				--timerDualistsRiposteCD:Start(3)
				--timerDutifulAttendantCD:Start(3)
				timerCastellansCadreCD:Start(3)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerDreadboltVolleyCD:Stop()
				--timerPridefulEruptionCD:Stop()
				--timerDrainEssenceCD:Start(3)
				--timerDreadboltVolleyCD:Start(3)
				--timerPridefulEruptionCD:Start(3)--START
				timerSoulSpikesCD:Start(3)
			elseif cid == 166970 then--Lord Stavros
				--timerEvasiveLungeCD:Stop()
				timerWaltzofBloodCD:Stop()--Replaced by dancing fools it seems
				--timerDarkRecitalCD:Stop()
				--timerEvasiveLungeCD:Start(3)
				--timerWaltzofBloodCD:Start(3)--Intended to be replaced by dancing fools?
				--timerDarkRecitalCD:Start(3)
				timerDancingFoolsCD:Start(5)
			end
		elseif self.vb.phase == 2 then--One Dead
			if cid == 166971 then--Castellan Niklaus
				--timerDualistsRiposteCD:Stop()
				--timerDutifulAttendantCD:Stop()
				--timerDualistsRiposteCD:Start(2)
				--timerDutifulAttendantCD:Start(2)
				timerDredgerServantsCD:Start(2)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerDreadboltVolleyCD:Stop()
				--timerDrainEssenceCD:Start(2)
				--timerDreadboltVolleyCD:Start(2)
				timerPridefulEruptionCD:Start(2)
			elseif cid == 166970 then--Lord Stavros
				--timerEvasiveLungeCD:Stop()
				--timerWaltzofBloodCD:Stop()
				--timerEvasiveLungeCD:Start(2)
				--timerWaltzofBloodCD:Start(2)
				timerDarkRecitalCD:Start(5.4)--SUCCESS (5.4-6.2)
			end
		end
	elseif spellId == 346694 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 347350 then
		if args:IsPlayer() then
			yellDancingFever:Countdown(spellId)
		end
		local amount = args.amount or 1
		FeverStacks[args.destName] = amount
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
		if args:IsPlayer() then
			yellDancingFever:Cancel()
		end
		FeverStacks[args.destName] = nil
		if self.Options.InfoFrame then
			if #FeverStacks > 0 then
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
		timerDualistsRiposteCD:Stop()
		timerDutifulAttendantCD:Stop()
		timerDredgerServantsCD:Stop()
		if self:IsMythic() then
			timerDutifulAttendantCD:Start(4)
		end
	elseif cid == 166969 then--Baroness Frieda
		timerDrainEssenceCD:Stop()
		timerDreadboltVolleyCD:Stop()
		timerPridefulEruptionCD:Stop()
		if self:IsMythic() then
			timerDreadboltVolleyCD:Start(4)
		end
	elseif cid == 166970 then--Lord Stavros
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		timerDancingFoolsCD:Stop()
		if self:IsMythic() then
			timerDarkRecitalCD:Start(6.8)--SUCCESS
		end
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
	if spellId == 327724 then--Waltz of Blood
		specWarnWaltzofBlood:Show()
		specWarnWaltzofBlood:Play("watchstep")
		timerWaltzofBloodCD:Start(21.8)
	elseif spellId == 330964 then--Dancing Fools
		warnDancingFools:Show()
		timerDancingFoolsCD:Start(30.7)
	end
end
