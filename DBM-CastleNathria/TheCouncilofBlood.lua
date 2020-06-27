local mod	= DBM:NewMod(2426, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166971, 166969, 166970)--Castellan Niklaus, Baroness Frieda, Lord Stavros
mod:SetEncounterID(2412)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328334 330963 330965 330978 327497 331634",
	"SPELL_CAST_SUCCESS 327828 327052 331706 330964",
	"SPELL_AURA_APPLIED 327828 330967 327773 331706 331637 327616 331918 332538 332535",
	"SPELL_AURA_APPLIED_DOSE 327773",
	"SPELL_AURA_REMOVED 330967 331706 331637",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1 boss2 boss3",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, this encounter has a lot of parallels with Talarn, its likely to use same globalTimer mechanic for abilities I'd bet.
--TODO, probably fix phase change triggers with right spell ID/event
--TODO, upgrade Cadre to special warning for melee/everyone based on where they spawn?
--TODO, Section 20?
--TODO, tune the tank stack warning for drain essence
--TODO, find spawn trigger for Anima Fountain, maybe add a GTFO for it if it works way i think it does
--TODO, not sure how scarlet letter works to propertly handle warnings yet
--TODO, figure out how Evasive Lunge works so tanks goal for aiming it is more clear
--TODO, cleaner event for Valtz of Blood
--TODO, is dark recital overdone? need to know if more than two pairs, if so then code is fine, if it's always one pair, it's overdone
--TODO, dance helper?
--TODO, Handling of boss timers with dance. Do they pause where they are? do they stop, and start with fixed values after dance is over? I suspect Kingaroth mechanic of pausing/resuming but with min thresholds if under x time
--Castellan Niklaus
local warnTacticalAdvance						= mod:NewTargetNoFilterAnnounce(328334, 3)
local warnUnyieldingGuard						= mod:NewTargetNoFilterAnnounce(327828, 2, nil, false)--I suspect boss just does this non stop
local warnUnstoppableCharge						= mod:NewTargetNoFilterAnnounce(330963, 4)--One boss dead
local warnCastellansCadre						= mod:NewSpellAnnounce(330965, 2)--Two bosses dead
local warnFixate								= mod:NewTargetAnnounce(330967, 3)--Two bosses dead
--Baroness Frieda
local warnDrainEssence							= mod:NewStackAnnounce(327773, 2, nil, "Tank|Healer")
local warnScarletLetter							= mod:NewTargetNoFilterAnnounce(331706, 3)--One boss dead
local warnDredgerServants						= mod:NewSpellAnnounce(330978, 2)--Two bosses dead
--Lord Stavros
local warnDarkRecital							= mod:NewTargetNoFilterAnnounce(331634, 3)
local warnDancingFools							= mod:NewSpellAnnounce(330964, 2)--Two bosses dead

--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(327475, nil, nil, nil, 1, 8)
--Castellan Niklaus
local specWarnTacticalAdvance					= mod:NewSpecialWarningYou(328334, nil, nil, nil, 1, 2)
local yellTacticalAdvance						= mod:NewYell(328334)
local specWarnUnstoppableCharge					= mod:NewSpecialWarningYou(330963, nil, nil, nil, 1, 2)--One boss dead
local yellUnstoppableCharge						= mod:NewYell(330963, nil, nil, nil, "YELL")--One boss dead
local specWarnUnstoppableChargeTarget			= mod:NewSpecialWarningTarget(330963, "Melee", nil, nil, 1, 2)--One boss dead. Melee should be enough to help soak it
local specWarnFixate							= mod:NewSpecialWarningRun(330967, nil, nil, nil, 4, 2)--Two bosses dead
--local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
--Baroness Frieda
local specWarnDrainEssence						= mod:NewSpecialWarningStack(327773, nil, 25, nil, nil, 1, 6)
local specWarnDrainEssenceTaunt					= mod:NewSpecialWarningTaunt(327773, nil, nil, nil, 1, 2)
local specWarnScarletLetter						= mod:NewSpecialWarningYou(331706, nil, nil, nil, 1, 2)--One boss dead
local yellScarletLetter							= mod:NewYell(331706)--One boss dead
local yellScarletLetterFades					= mod:NewShortFadesYell(331706)--One boss dead
--Lord Stavros
local specWarnEvasiveLunge						= mod:NewSpecialWarningSpell(327497, "Tank", nil, nil, 1, 2)
local specWarnWaltzofBlood						= mod:NewSpecialWarningDodge(327616, nil, nil, nil, 2, 2)
local specWarnDarkRecital						= mod:NewSpecialWarningMoveTo(331634, nil, nil, nil, 1, 2)--One boss dead
local yellDarkRecital							= mod:NewShortYell(331634)--One boss dead
local yellDarkRecitalRepeater					= mod:NewIconRepeatYell(331634, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--One boss dead (TODO, remove custom yell text if less than 16 targets)
--Intermission
local specWarnDanseMacabre						= mod:NewSpecialWarningSpell(331005, nil, nil, nil, 3, 2)

--Castellan Niklaus
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22147))
local timerTacticalAdvanceCD					= mod:NewAITimer(44.3, 328334, nil, nil, nil, 3)
local timerUnyieldingGuardCD					= mod:NewAITimer(44.3, 327828, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22201))
local timerUnstoppableChargeCD					= mod:NewAITimer(44.3, 330963, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22199))
local timerCastellansCadreCD					= mod:NewAITimer(44.3, 330965, nil, nil, nil, 1)
--Baroness Frieda
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22148))
local timerDrainEssenceCD						= mod:NewAITimer(16.6, 327052, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--, nil, 2, 3
--local timerAnimaFountainCD					= mod:NewAITimer(44.3, 327475, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22202))
local timerScarletLetterCD						= mod:NewAITimer(44.3, 331706, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22205))
local timerDredgerServantsCD					= mod:NewAITimer(44.3, 330978, nil, nil, nil, 1)
--Lord Stavros
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22149))
local timerEvasiveLungeCD						= mod:NewAITimer(16.6, 327497, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerWaltzofBloodCD						= mod:NewAITimer(44.3, 327616, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22203))
local timerDarkRecitalCD						= mod:NewAITimer(44.3, 331634, nil, nil, nil, 3)
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22206))
local timerDancingFoolsCD						= mod:NewAITimer(44.3, 330964, nil, nil, nil, 1)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
--mod:AddSetIconOption("SetIconOnMuttering", 310358, true, false, {2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnFixate", 330967)

mod.vb.phase = 1
--mod.vb.globalTimer = 35
local darkRecitalTargets = {}

function mod:TacticalAdvanceTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnTacticalAdvance:Show()
			specWarnTacticalAdvance:Play("targetyou")
			yellTacticalAdvance:Yell()
		else
			warnTacticalAdvance:Show(targetname)
		end
	end
end

function mod:UnstoppableChargeTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnUnstoppableCharge:Show()
			specWarnUnstoppableCharge:Play("targetyou")
			yellTacticalAdvance:Yell()
		elseif self.Options.SpecWarn330963target then
			specWarnUnstoppableChargeTarget:Show(targetname)
			specWarnUnstoppableChargeTarget:Play("gathershare")
		else
			warnUnstoppableCharge:Show(targetname)
		end
	end
end

local function warndarkRecitalTargets(self)
	--if not self:IsMythic() then
		warnDarkRecital:Show(table.concat(darkRecitalTargets, "<, >"))
	--end
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
	timerTacticalAdvanceCD:Start(1-delay)
	timerUnyieldingGuardCD:Start(1-delay)
	--Baroness Frieda
	timerDrainEssenceCD:Start(1-delay)
	--timerAnimaFountainCD:Start(1-delay)
	--Lord Stavros
	timerEvasiveLungeCD:Start(1-delay)
	timerWaltzofBloodCD:Start(1-delay)
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328334 then
		timerTacticalAdvanceCD:Start()
		--self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "TacticalAdvanceTarget", 0.1, 12, true)--, nil, nil, nil, true (if tank filter needed)
	elseif spellId == 330963 then
		timerUnstoppableChargeCD:Start()
		--self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "UnstoppableChargeTarget", 0.1, 12, true)
	elseif spellId == 330965 then
		warnCastellansCadre:Show()
		timerCastellansCadreCD:Start()
	elseif spellId == 330978 then
		warnDredgerServants:Show()
		timerDredgerServantsCD:Start()
	elseif spellId == 327497 then
		specWarnEvasiveLunge:Show()
		specWarnEvasiveLunge:Play("specialsoon")
		timerEvasiveLungeCD:Start()
	elseif spellId == 331634 then
		timerDarkRecitalCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 327828 then
		timerUnyieldingGuardCD:Start()
	elseif spellId == 327052 then
		timerDrainEssenceCD:Start()
	elseif spellId == 331706 then
		timerScarletLetterCD:Start()
	elseif spellId == 330964 then
		warnDancingFools:Show()
		timerDancingFoolsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 327828 then
		warnUnyieldingGuard:Show(args.destName)
	elseif spellId == 330967 then
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
	elseif spellId == 331637 then
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
			end
		end
		if args:IsPlayer() then
			yellDarkRecital:Yell()
		end
	elseif spellId == 327616 and self:AntiSpam(5, 1) then
		specWarnWaltzofBlood:Show()
		specWarnWaltzofBlood:Play("watchstep")
		timerWaltzofBloodCD:Start()
	elseif spellId == 331918 or spellId == 332538 or spellId == 332535 then--Anima Infusion (probably totally wrong)
		if self:AntiSpam(30, spellId) then
			--Bump phase and stop all timers since regardless of kills, phase changes reset anyone that's still up
			self.vb.phase = self.vb.phase + 1
			--self.vb.bossLeft = self.vb.bossLeft - 1--Fix bosses defeated statistic on wipes in phase 2 and phase 3 (if UNIT_DIED doesn't fire)
			--[[if self.vb.phase == 2 then
				self.vb.globalTimer = 55
			else
				self.vb.globalTimer = 35
			end--]]
		end
		local cid = self:GetCIDFromGUID(args.destGUID)
		if self.vb.phase == 3 then--Two Dead
			if cid == 166971 then--Castellan Niklaus
				--timerTacticalAdvanceCD:Stop()
				--timerUnyieldingGuardCD:Stop()
				--timerUnstoppableChargeCD:Stop()
				--timerTacticalAdvanceCD:Start(3)
				--timerUnyieldingGuardCD:Start(3)
				--timerUnstoppableChargeCD:Start(3)
				timerCastellansCadreCD:Start(3)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerAnimaFountainCD:Stop()
				--timerScarletLetterCD:Stop()
				--timerDrainEssenceCD:Start(3)
				--timerAnimaFountainCD:Start(3)
				--timerScarletLetterCD:Start(3)
				timerDredgerServantsCD:Start(3)
			elseif cid == 166970 then--Lord Stavros
				--timerEvasiveLungeCD:Stop()
				--timerWaltzofBloodCD:Stop()
				--timerDarkRecitalCD:Stop()
				--timerEvasiveLungeCD:Start(3)
				--timerWaltzofBloodCD:Start(3)
				--timerDarkRecitalCD:Start(3)
				timerDancingFoolsCD:Start(3)
			end
		elseif self.vb.phase == 2 then--One Dead
			if cid == 166971 then--Castellan Niklaus
				--timerTacticalAdvanceCD:Stop()
				--timerUnyieldingGuardCD:Stop()
				--timerTacticalAdvanceCD:Start(2)
				--timerUnyieldingGuardCD:Start(2)
				timerUnstoppableChargeCD:Start(2)
			elseif cid == 166969 then--Baroness Frieda
				--timerDrainEssenceCD:Stop()
				--timerAnimaFountainCD:Stop()
				--timerDrainEssenceCD:Start(2)
				--timerAnimaFountainCD:Start(2)
				timerScarletLetterCD:Start(2)
			elseif cid == 166970 then--Lord Stavros
				--timerEvasiveLungeCD:Stop()
				--timerWaltzofBloodCD:Stop()
				--timerEvasiveLungeCD:Start(2)
				--timerWaltzofBloodCD:Start(2)
				timerDarkRecitalCD:Start(2)
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
	elseif spellId == 331706 then
		if args:IsPlayer() then
			yellScarletLetterFades:Cancel()
		end
	elseif spellId == 331637 then
		if args:IsPlayer() then
			self:Unschedule(darkRecitalYellRepeater)
		end
	end
end

--https://shadowlands.wowhead.com/npc=169925/begrudging-waiter
--https://shadowlands.wowhead.com/npc=168406/waltzing-venthyr
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 166971 then--Castellan Niklaus
		timerTacticalAdvanceCD:Stop()
		timerUnyieldingGuardCD:Stop()
		timerUnstoppableChargeCD:Stop()
	elseif cid == 166969 then--Baroness Frieda
		timerDrainEssenceCD:Stop()
		--timerAnimaFountainCD:Stop()
	elseif cid == 166970 then--Lord Stavros
		timerEvasiveLungeCD:Stop()
		timerWaltzofBloodCD:Stop()
		timerDarkRecitalCD:Stop()
		timerDancingFoolsCD:Stop()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 328334 then--Tactical Advance
		self:BossUnitTargetScanner(uId, "TacticalAdvanceTarget", 2.5)
	elseif spellId == 330963 then--Unstoppable Charge
		self:BossUnitTargetScanner(uId, "UnstoppableChargeTarget", 2.5)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 328500 or spellId == 319306) and self:AntiSpam(5, 3) then--Danse Macabre or Summon Macabre
		specWarnDanseMacabre:Show()
		specWarnDanseMacabre:Play("specialsoon")
	end
end
