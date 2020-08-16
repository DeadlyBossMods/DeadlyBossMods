local mod	= DBM:NewMod(2426, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166971, 166969, 166970)--Castellan Niklaus, Baroness Frieda, Lord Stavros
mod:SetEncounterID(2412)
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328334 334948 330965 330978 327497 327052",
	"SPELL_CAST_SUCCESS 335777 331704 331634 330959 334948",
	"SPELL_AURA_APPLIED 330967 327773 331706 331636 331637 332535 335775 342457 342861 342456",
	"SPELL_AURA_APPLIED_DOSE 327773 332535",
	"SPELL_AURA_REMOVED 330967 331706 331636 331637 335775 330959 342457 342861 342456",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, upgrade Cadre to special warning for melee/everyone based on where they spawn?
--TODO, tune the tank stack warning for drain essence
--TODO, dance helper?
--TODO, refine dancing fever, it was a last minute hotfix after all
--TODO, refine dark recital with nameplate auras instead, and have icons off by default?
--TODO, Handling of boss timers with dance. Currently they just mass queue up and don't reset, pause or anything, resulting in bosses chaining abilities after dance.
--		As such, keep an eye on this changing, if it doesn't, just add "keep" to all timers to show they are all queued up. if it changes, update timers to either reset, or pause
--[[
(ability.id = 328334 or ability.id = 334948 or ability.id = 330965 or ability.id = 330978 or ability.id = 327497 or ability.id = 327052 or ability.id = 327465) and type = "begincast"
 or (ability.id = 335777 or ability.id = 331704 or ability.id = 331634 or ability.id = 334948) and type = "cast"
 or ability.id = 332535 or ability.id = 330959
 or (ability.id = 330964 or ability.id = 335773) and type = "cast"
 or (target.id = 166971 or target.id = 166969 or target.id = 166970) and type = "death"
 --]]
--Castellan Niklaus
local warnTacticalAdvance						= mod:NewTargetAnnounce(328334, 3)--Cast every 4 seconds, this is definitely staying a filtered target warning
local warnUnyieldingShield						= mod:NewSpellAnnounce(335777, 2)--I suspect boss just does this non stop
local warnUnstoppableCharge						= mod:NewSpellAnnounce(334948, 4)--One boss dead
local warnCastellansCadre						= mod:NewSpellAnnounce(330965, 2)--Two bosses dead
local warnFixate								= mod:NewTargetAnnounce(330967, 3)--Two bosses dead
--Baroness Frieda
local warnDrainEssence							= mod:NewStackAnnounce(327773, 2, nil, "Tank|Healer")
local warnScarletLetter							= mod:NewTargetNoFilterAnnounce(331706, 3)--One boss dead
local warnDredgerServants						= mod:NewSpellAnnounce(330978, 2)--Two bosses dead
--Lord Stavros
local warnDarkRecital							= mod:NewTargetNoFilterAnnounce(331634, 3)
local warnDancingFools							= mod:NewSpellAnnounce(330964, 2)--Two bosses dead
--Intermission
local warnDanceOver								= mod:NewEndAnnounce(330959, 2)
local warnDancingFever							= mod:NewTargetAnnounce(342457, 3)

--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(327475, nil, nil, nil, 1, 8)
--Castellan Niklaus
local specWarnTacticalAdvance					= mod:NewSpecialWarningYou(328334, nil, nil, nil, 1, 2)
local yellTacticalAdvance						= mod:NewYell(328334)
local specWarnUnstoppableCharge					= mod:NewSpecialWarningYou(334948, nil, nil, nil, 1, 2)--One boss dead
local yellUnstoppableCharge						= mod:NewYell(334948, nil, nil, nil, "YELL")--One boss dead
local specWarnUnstoppableChargeTarget			= mod:NewSpecialWarningSpell(334948, false, nil, nil, 1, 2)--One boss dead. Opt in for special warning
local specWarnFixate							= mod:NewSpecialWarningRun(330967, nil, nil, nil, 4, 2)--Two bosses dead
--local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
--Baroness Frieda
local specWarnDrainEssence						= mod:NewSpecialWarningStack(327773, nil, 25, nil, nil, 1, 6)
local specWarnDrainEssenceTaunt					= mod:NewSpecialWarningTaunt(327773, nil, nil, nil, 1, 2)
local specWarnAnimaFountain						= mod:NewSpecialWarningDodge(327475, nil, nil, nil, 2, 2)
local specWarnScarletLetter						= mod:NewSpecialWarningYou(331706, nil, nil, nil, 1, 2)--One boss dead
local yellScarletLetter							= mod:NewYell(331706)--One boss dead
local yellScarletLetterFades					= mod:NewShortFadesYell(331706)--One boss dead
--Lord Stavros
local specWarnEvasiveLunge						= mod:NewSpecialWarningSpell(327497, "Tank", nil, nil, 1, 2)
local specWarnWaltzofBlood						= mod:NewSpecialWarningDodge(327616, nil, nil, nil, 2, 2)
local specWarnDarkRecital						= mod:NewSpecialWarningMoveTo(331634, nil, nil, nil, 1, 2)--One boss dead
local yellDarkRecitalRepeater					= mod:NewIconRepeatYell(331634, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--One boss dead (TODO, remove custom yell text if less than 16 targets)
--Intermission
local specWarnDanseMacabre						= mod:NewSpecialWarningSpell(331005, nil, nil, nil, 3, 2)
local specWarnDancingFever						= mod:NewSpecialWarningMoveAway(342457, nil, nil, nil, 1, 2, 4)
local yellDancingFever							= mod:NewYell(342457, nil, false)--Off by default do to potential to spam when spread, going to dry run nameplate auras for this

--Castellan Niklaus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22147))
local timerTacticalAdvanceCD					= mod:NewCDTimer(4, 328334, nil, nil, nil, 3)--Continues on Mythic after death
local timerUnyieldingShieldCD					= mod:NewCDTimer(18.2, 335777, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22201))
local timerUnstoppableChargeCD					= mod:NewCDTimer(15.9, 334948, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22199))
local timerCastellansCadreCD					= mod:NewCDTimer(27.1, 330965, nil, nil, nil, 1)
--Baroness Frieda
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22148))
local timerDrainEssenceCD						= mod:NewCDTimer(22, 327052, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--, nil, 2, 3
local timerAnimaFountainCD						= mod:NewCDTimer(32.1, 327475, nil, nil, nil, 3)--Continues on Mythic after death
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22202))
local timerScarletLetterCD						= mod:NewCDTimer(30.5, 331706, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22205))
local timerDredgerServantsCD					= mod:NewCDTimer(32.9, 330978, nil, nil, nil, 1)--32-37
--Lord Stavros
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22149))
local timerEvasiveLungeCD						= mod:NewCDTimer(13.5, 327497, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--13.5-17.1
local timerWaltzofBloodCD						= mod:NewCDTimer(21.8, 327616, nil, nil, nil, 3)--21.8-23.5
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22203))
local timerDarkRecitalCD						= mod:NewCDTimer(22, 331634, nil, nil, nil, 3)--Continues on Mythic after death
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22206))
local timerDancingFoolsCD						= mod:NewCDTimer(30.7, 330964, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
--mod:AddSetIconOption("SetIconOnMuttering", 310358, true, false, {2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnFixate", 330967)
mod:AddNamePlateOption("NPAuraOnShield", 335775)
mod:AddNamePlateOption("NPAuraOnFever", 342457)

mod.vb.phase = 1
local darkRecitalTargets = {}

function mod:TacticalAdvanceTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(3, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnTacticalAdvance:Show()
			specWarnTacticalAdvance:Play("targetyou")
			yellTacticalAdvance:Yell()
		else
			warnTacticalAdvance:Show(targetname)
		end
	end
end

local function warndarkRecitalTargets(self)
	warnDarkRecital:Show(table.concat(darkRecitalTargets, "<, >"))
	table.wipe(darkRecitalTargets)
end

local function darkRecitalYellRepeater(self, text)
	yellDarkRecitalRepeater:Yell(text)
	self:Schedule(2, darkRecitalYellRepeater, self, text)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	table.wipe(darkRecitalTargets)
	--Castellan Niklaus
	timerTacticalAdvanceCD:Start(4.3-delay)
	timerUnyieldingShieldCD:Start(15.1-delay)
	--Baroness Frieda
	timerDrainEssenceCD:Start(6.9-delay)
	timerAnimaFountainCD:Start(15.5-delay)
	--Lord Stavros
	timerEvasiveLungeCD:Start(10.6-delay)
	timerWaltzofBloodCD:Start(16.6-delay)
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.NPAuraOnFever then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield or self.Options.NPAuraOnFever then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, self.Options.NPAuraOnFixate or self.Options.NPAuraOnShield, self.Options.NPAuraOnFever)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328334 then
--		if args:GetSrcCreatureID() == 166971 then--Main boss
			timerTacticalAdvanceCD:Start()
--		else
			--Probably used less often by after image? Just coding this so it can be applyed fast
--		end
	elseif spellId == 334948 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnUnstoppableCharge:Show()
			specWarnUnstoppableCharge:Play("targetyou")
			yellUnstoppableCharge:Yell()
		else
			if self.Options.SpecWarn334948target then
				specWarnUnstoppableChargeTarget:Show()
				specWarnUnstoppableChargeTarget:Play("gathershare")
			else
				warnUnstoppableCharge:Show()
			end
		end
	elseif spellId == 330965 then
		warnCastellansCadre:Show()
		timerCastellansCadreCD:Start()
	elseif spellId == 330978 then
		warnDredgerServants:Show()
		timerDredgerServantsCD:Start()
	elseif spellId == 327497 then
		specWarnEvasiveLunge:Show()
		specWarnEvasiveLunge:Play("shockwave")
		timerEvasiveLungeCD:Start()
	elseif spellId == 327052 then
		timerDrainEssenceCD:Start()
	elseif spellId == 327465 then
		specWarnAnimaFountain:Show()
		specWarnAnimaFountain:Play("watchstep")
--		if args:GetSrcCreatureID() == 166969 then--Main boss
			timerAnimaFountainCD:Start()
--		else
			--Probably used less often by after image? Just coding this so it can be applyed fast
--		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 335777 then
		warnUnyieldingShield:Show()
		timerUnyieldingShieldCD:Start()
	elseif spellId == 331704 then
		timerScarletLetterCD:Start()
	elseif spellId == 331634 then
--		if args:GetSrcCreatureID() == 166970 then--Main boss
			timerDarkRecitalCD:Start()
--		else
			--Probably used less often by after image? Just coding this so it can be applyed fast
--		end
	elseif spellId == 330959 and self:AntiSpam(10, 1) then
		specWarnDanseMacabre:Show()
		specWarnDanseMacabre:Play("specialsoon")
	elseif spellId == 334948 then
		timerUnstoppableChargeCD:Start()
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
	elseif spellId == 327773 then
		local amount = args.amount or 1
		if amount % 5 == 0 then
			if amount >= 25 then
				if args:IsPlayer() then
					specWarnDrainEssence:Show(amount)
					specWarnDrainEssence:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
						specWarnDrainEssenceTaunt:Show(args.destName)
						specWarnDrainEssenceTaunt:Play("tauntboss")
					else
						warnDrainEssence:Show(args.destName, amount)
					end
				end
			else
				warnDrainEssence:Show(args.destName, amount)
			end
		end
	elseif spellId == 331706 then
		if args:IsPlayer() then
			specWarnScarletLetter:Show()
			specWarnScarletLetter:Play("targetyou")
			yellScarletLetter:Yell()
			yellScarletLetterFades:Countdown(spellId)
		else
			warnScarletLetter:Show(args.destName)
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
				self:Schedule(2, darkRecitalYellRepeater, self, icon)
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
				--timerTacticalAdvanceCD:Stop()
				--timerUnyieldingShieldCD:Stop()
				--timerUnstoppableChargeCD:Stop()
				--timerTacticalAdvanceCD:Start(3)
				--timerUnyieldingShieldCD:Start(3)
				--timerUnstoppableChargeCD:Start(3)
				timerCastellansCadreCD:Start(5.1)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerAnimaFountainCD:Stop()
				--timerScarletLetterCD:Stop()
				--timerDrainEssenceCD:Start(3)
				--timerAnimaFountainCD:Start(3)
				--timerScarletLetterCD:Start(3)--SUCCESS
				timerDredgerServantsCD:Start(16.8)
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
				--timerTacticalAdvanceCD:Stop()
				--timerUnyieldingShieldCD:Stop()
				--timerTacticalAdvanceCD:Start(2)
				--timerUnyieldingShieldCD:Start(2)
				timerUnstoppableChargeCD:Start(6)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerAnimaFountainCD:Stop()
				--timerDrainEssenceCD:Start(2)
				--timerAnimaFountainCD:Start(2)
				timerScarletLetterCD:Start(5.5)--5.5-7.5
			elseif cid == 166970 then--Lord Stavros
				--timerEvasiveLungeCD:Stop()
				--timerWaltzofBloodCD:Stop()
				--timerEvasiveLungeCD:Start(2)
				--timerWaltzofBloodCD:Start(2)
				timerDarkRecitalCD:Start(5.4)--SUCCESS (5.4-6.2)
			end
		end
	elseif spellId == 335775 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 342457 or spellId == 342861 or spellId == 342456 then
		warnDancingFever:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnDancingFever:Show()
			specWarnDancingFever:Play("runout")
			yellDancingFever:Yell()
		end
		if self.Options.NPAuraOnFever then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 300)
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
	elseif spellId == 331706 then
		if args:IsPlayer() then
			yellScarletLetterFades:Cancel()
		end
	elseif spellId == 331637 then
		if args:IsPlayer() then
			self:Unschedule(darkRecitalYellRepeater)
		end
	elseif spellId == 335775 then
		if self.Options.NPAuraOnShield then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 330959 and self:AntiSpam(10, 2) then
		warnDanceOver:Show()
		--TODO, timer correction if blizzard changes how they work
	elseif spellId == 342457 or spellId == 342861 or spellId == 342456 then
		if self.Options.NPAuraOnFever then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

--https://shadowlands.wowhead.com/npc=169925/begrudging-waiter
--https://shadowlands.wowhead.com/npc=168406/waltzing-venthyr
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 166971 then--Castellan Niklaus
		timerTacticalAdvanceCD:Stop()
		timerUnyieldingShieldCD:Stop()
		timerUnstoppableChargeCD:Stop()
	elseif cid == 166969 then--Baroness Frieda
		timerDrainEssenceCD:Stop()
		timerAnimaFountainCD:Stop()
	elseif cid == 166970 then--Lord Stavros
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		timerDancingFoolsCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 327724 then--Waltz of Blood
		specWarnWaltzofBlood:Show()
		specWarnWaltzofBlood:Play("watchstep")
		timerWaltzofBloodCD:Start(21.8)
	elseif spellId == 330964 then--Dancing Fools
		warnDancingFools:Show()
		timerDancingFoolsCD:Start(30.7)
--	"<4.66 17:23:17> [UNIT_SPELLCAST_SUCCEEDED] Castellan Niklaus(Scottbrex) -Tactical Advance- [[boss1:Cast-3-2084-2296-29487-330961-0001233A45:330961]]", -- [60]
--	"<4.66 17:23:17> [UNIT_SPELLCAST_SUCCEEDED] Castellan Niklaus(Scottbrex) -Tactical Advance- [[boss1:Cast-3-2084-2296-29487-327832-0000A33A45:327832]]", -- [61]
--	"<4.69 17:23:17> [UNIT_SPELLCAST_START] Castellan Niklaus(Vampssou) - Tactical Advance - 2.5s [[boss1:Cast-3-2084-2296-29487-328334-0001A33A45:328334]]", -- [62]
	elseif spellId == 330961 then
--		self:BossUnitTargetScanner(uId, "TacticalAdvanceTarget", 2.5)
		--Scan very hard and very fast, and absolutely ignore tank
		local guid = UnitGUID(uId)
		self:BossTargetScanner(guid, "TacticalAdvanceTarget", 0.01, 12, true, nil, nil, nil, true)
	end
end
