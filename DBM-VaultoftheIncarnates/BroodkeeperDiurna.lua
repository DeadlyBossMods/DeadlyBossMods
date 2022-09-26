local mod	= DBM:NewMod(2493, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(190245)
mod:SetEncounterID(2607)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 376073 375871 388716 375870 375716 376272 376257 375485 375575 375457 375653 375630 388918",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 375842 375889 375829 376073 376074 376077 376160 378782 390561 376272 375487 375475 375620 375879 380176",
	"SPELL_AURA_APPLIED_DOSE 375829 378782 376272 375475 375879",
	"SPELL_AURA_REMOVED 375809 375842 376073 376074 376077 376160 380176",
	"SPELL_PERIODIC_DAMAGE 390747",
	"SPELL_PERIODIC_MISSED 390747",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, spell summon on https://www.wowhead.com/beta/spell=375834/greatstaff-of-the-broodkeeper ? Can staff be marked? should it be?
--TODO, chat bubble players getting wildfire spread that are about to spread it again in 2 seconds?
--TODO, is Icy Shroud avoidable or it just a pure aoe thing?
--TODO, visit tank swaps when more data is known such strategies to the interaction with Fury extending debuffs, for now, basic debuff checks used (and may be enough)
--TODO, Primal Proto-Whelp fixate spellId?
--TODO, Nascent Proto-Dragon have no abilites?
--TODO, https://www.wowhead.com/beta/spell=392292/broodkeeping meaningful?
--TODO, https://www.wowhead.com/beta/spell=385630/summon-primalists the spawn trigger/interval of reinforcements?
--TODO, add https://www.wowhead.com/beta/spell=388644/vicious-thrust ? it's instant cast but maybe a timer? depends how many adds there are. omitting for now to avoid clutter
--TODO, some kind of auto marking of the priority adds (like mages that need interrupt rotations)
--TODO, further micro manage tank swaps for Borrowing Strike? depends on add count and spawn frequency, are they swapped or just killed off to reset stacks?
--TODO, what is range of tremors? does the mob turn while casting it? These answers affect warning defaults/filters, for now it's everyone
--TODO, is Cauterizing Flashflames deadly or need an emphasized warning? 20% of targets health can mean anyting, it depends how much health Dragonspawn have
--TODO, evalualte any needed antispams for multiple adds casting same spells
--TODO, accurate phase 2 detection. Maybe https://www.wowhead.com/beta/spell=392194/empower-greatstaff ?
--Stage One: The Primalist Clutch
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25119))
----Broodkeeper Diurna
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25120))
local warnBroodkeepersBond						= mod:NewFadesAnnounce(375809, 1)
local warnGreatstaffoftheBroodkeeperEnded		= mod:NewEndAnnounce(375842, 2)
local warnGreatstaffsWrath						= mod:NewTargetNoFilterAnnounce(375842, 2)
local warnClutchwatchersRage					= mod:NewStackAnnounce(375829, 2)
local warnRapidIncubation						= mod:NewSpellAnnounce(376073, 3)
local warnMortalWounds							= mod:NewStackAnnounce(378782, 2, nil, "Tank|Healer")
local warnDiurnasGaze							= mod:NewYouAnnounce(390561, 3)

local specWarnGreatstaffoftheBroodkeeper		= mod:NewSpecialWarningCount(375842, nil, nil, nil, 2, 2)
local specWarnGreatstaffsWrath					= mod:NewSpecialWarningYou(375889, nil, nil, nil, 1, 2)
local yellGreatstaffsWrath						= mod:NewYell(375889)
local specWarnWildfire							= mod:NewSpecialWarningDodge(375871, nil, nil, nil, 2, 2)
local specWarnIcyShroud							= mod:NewSpecialWarningCount(388716, nil, nil, nil, 2, 2)
local specWarnMortalStoneclaws					= mod:NewSpecialWarningDefensive(375870, nil, nil, nil, 1, 2)
local specWarnMortalWounds						= mod:NewSpecialWarningTaunt(378782, nil, nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerGreatstaffoftheBroodkeeperCD			= mod:NewAITimer(35, 375842, L.staff, nil, nil, 5)
local timerRapidIncubationCD					= mod:NewAITimer(35, 376073, nil, nil, nil, 1)
local timerWildfireCD							= mod:NewAITimer(35, 375871, nil, nil, nil, 3)
local timerIcyShroudCD							= mod:NewAITimer(35, 388716, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerMortalStoneclawsCD					= mod:NewAITimer(35, 375870, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddNamePlateOption("NPRapidIncubation", 376073, true)

mod:GroupSpells(375842, 375889)--Greatstaff spawn ith greatstaff wrath debuff
mod:GroupSpells(375870, 378782)--Mortal Claws with Mortal Wounds
----Primalist Reinforcements
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25129))
local warnBurrowingStrike						= mod:NewStackAnnounce(376272, 2, nil, "Tank|Healer")
local warnCauterizingFlashflames				= mod:NewCastAnnounce(375485, 4)
local warnFlameSentry							= mod:NewCastAnnounce(375575, 3)
local warnRendingBite							= mod:NewStackAnnounce(375475, 2, nil, "Tank|Healer")
local warnChillingTantrum						= mod:NewCastAnnounce(375457, 3)
local warnIonizingCharge						= mod:NewTargetAnnounce(375630, 3)

local specWarnPrimalistReinforcements			= mod:NewSpecialWarningCount(385618, "-Healer", nil, nil, 1, 2)
local specWarnIceBarrage						= mod:NewSpecialWarningInterruptCount(375716, "HasInterrupt", nil, nil, 1, 2)
local specWarnBurrowingStrike					= mod:NewSpecialWarningDefensive(376272, nil, nil, nil, 1, 2, 3)
local specWarnTremors							= mod:NewSpecialWarningDodge(376257, nil, nil, nil, 2, 2)
local specWarnIceBarrage						= mod:NewSpecialWarningDispel(375487, "MagicDispeller", nil, nil, 1, 2)
local specWarnRendingBite						= mod:NewSpecialWarningDefensive(375475, nil, nil, nil, 1, 2, 3)
local specWarnStaticJolt						= mod:NewSpecialWarningInterruptCount(375653, "HasInterrupt", nil, nil, 1, 2)
local specWarnIonizingCharge					= mod:NewSpecialWarningMoveAway(375630, nil, nil, nil, 1, 2)
local yellIonizingCharge						= mod:NewYell(375630)

local timerPrimalistReinforcementsCD			= mod:NewAITimer(35, 385618, nil, nil, nil, 1)--Temp spellid, it's not localized
local timerBurrowingStrikeCD					= mod:NewAITimer(35, 376272, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEROIC_ICON)
local timerTremorsCD							= mod:NewAITimer(35, 376257, nil, nil, nil, 3)
local timerCauterizingFlashflamesCD				= mod:NewAITimer(35, 375485, nil, "MagicDispeller", nil, 5)
local timerFlameSentryCD						= mod:NewAITimer(35, 375575, nil, nil, nil, 3)
local timerRendingBiteCD						= mod:NewAITimer(35, 375475, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEROIC_ICON)
local timerChillingTantrumCD					= mod:NewAITimer(35, 375457, nil, nil, nil, 3)
local timerIonizingChargeCD						= mod:NewAITimer(35, 375630, nil, nil, nil, 3)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnMages", "ej25144", true, true, {8, 7, 6})
mod:AddSetIconOption("SetIconOnStormbringers", "ej25139", true, true, {5, 4, 3})

mod:GroupSpells(375485, 375487)--Cauterizing Flashflames cast and dispel IDs
mod:GroupSpells(385618, "ej25144", "ej25139")--Icon Marking with general adds announce
--Stage Two: A Broodkeeper Scorned
mod:AddTimerLine(DBM:EJ_GetSectionInfo(25146))
local warnBroodkeepersFury						= mod:NewStackAnnounce(375879, 2)
local warnEGreatstaffoftheBroodkeeperEnded		= mod:NewEndAnnounce(380176, 2)
local warnEGreatstaffsWrath						= mod:NewTargetNoFilterAnnounce(380483, 2)

local specWarnEGreatstaffoftheBroodkeeper		= mod:NewSpecialWarningCount(380176, nil, nil, nil, 2, 2)
local specWarnEGreatstaffsWrath					= mod:NewSpecialWarningYou(380483, nil, nil, nil, 1, 2)
local yellEGreatstaffsWrath						= mod:NewYell(380483)
local specWarnFrozenShroud						= mod:NewSpecialWarningCount(388918, nil, nil, nil, 2, 2)

local timerEGreatstaffoftheBroodkeeperCD		= mod:NewAITimer(35, 380483, L.staff, nil, nil, 5)
local timerFrozenShroudCD						= mod:NewAITimer(35, 388918, nil, nil, nil, 2, nil, DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)

local castsPerGUID = {}
mod.vb.staffCount = 0
mod.vb.icyCount = 0
mod.vb.addsCount = 0
mod.vb.mageIcon = 8
mod.vb.StormbringerIcon = 6

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self:SetStage(1)
	self.vb.staffCount = 0
	self.vb.icyCount = 0
	self.vb.addsCount = 0
	self.vb.mageIcon = 8
	self.vb.StormbringerIcon = 6
	timerGreatstaffoftheBroodkeeperCD:Start(1-delay)
	timerRapidIncubationCD:Start(1-delay)
	timerWildfireCD:Start(1-delay)
	timerIcyShroudCD:Start(1-delay)
	timerPrimalistReinforcementsCD:Start(1-delay)
	timerMortalStoneclawsCD:Start(1-delay)
	if self.Options.NPRapidIncubation then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPRapidIncubation then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 376073 then
		warnRapidIncubation:Show()
		timerRapidIncubationCD:Start()
	elseif spellId == 375871 then
		specWarnWildfire:Show()
		specWarnWildfire:Play("watchstep")
		timerWildfireCD:Start()
	elseif spellId == 388716 then
		self.vb.icyCount = self.vb.icyCount + 1
		specWarnIcyShroud:Show(self.vb.icyCount)
		specWarnIcyShroud:Play("aesoon")
		timerIcyShroudCD:Start()
	elseif spellId == 388918 then
		self.vb.icyCount = self.vb.icyCount + 1
		specWarnFrozenShroud:Show(self.vb.icyCount)
		specWarnFrozenShroud:Play("aesoon")
		timerFrozenShroudCD:Start()
	elseif spellId == 375870 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnMortalStoneclaws:Show()
			specWarnMortalStoneclaws:Play("defensive")
		end
		timerMortalStoneclawsCD:Start()
	elseif spellId == 376272 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnBurrowingStrike:Show()
			specWarnBurrowingStrike:Play("defensive")
		end
		timerBurrowingStrikeCD:Start(nil, args.sourceGUID)
	elseif spellId == 375475 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnRendingBite:Show()
			specWarnRendingBite:Play("defensive")
		end
		timerRendingBiteCD:Start(nil, args.sourceGUID)
	elseif spellId == 375716 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnMages and self.vb.mageIcon > 5 then--Only use up to 3 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.mageIcon, 1, nil, 12, "SetIconOnMages")
			end
			self.vb.mageIcon = self.vb.mageIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnIceBarrage:Show(args.sourceName, count)
			if count == 1 then
				specWarnIceBarrage:Play("kick1r")
			elseif count == 2 then
				specWarnIceBarrage:Play("kick2r")
			elseif count == 3 then
				specWarnIceBarrage:Play("kick3r")
			elseif count == 4 then
				specWarnIceBarrage:Play("kick4r")
			elseif count == 5 then
				specWarnIceBarrage:Play("kick5r")
			else
				specWarnIceBarrage:Play("kickcast")
			end
		end
	elseif spellId == 375653 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnStormbringers and self.vb.StormbringerIcon > 4 then--Only use up to 3 icons
				self:ScanForMobs(args.sourceGUID, 2, self.vb.StormbringerIcon, 1, nil, 12, "SetIconOnStormbringers")
			end
			self.vb.StormbringerIcon = self.vb.StormbringerIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnStaticJolt:Show(args.sourceName, count)
			if count == 1 then
				specWarnStaticJolt:Play("kick1r")
			elseif count == 2 then
				specWarnStaticJolt:Play("kick2r")
			elseif count == 3 then
				specWarnStaticJolt:Play("kick3r")
			elseif count == 4 then
				specWarnStaticJolt:Play("kick4r")
			elseif count == 5 then
				specWarnStaticJolt:Play("kick5r")
			else
				specWarnStaticJolt:Play("kickcast")
			end
		end
	elseif spellId == 376257 then
		specWarnTremors:Show()
		specWarnTremors:Play("shockwave")
		timerTremorsCD:Start(nil, args.sourceGUID)
	elseif spellId == 375485 then
		warnCauterizingFlashflames:Show()
		timerCauterizingFlashflamesCD:Start(nil, args.sourceGUID)
	elseif spellId == 375575 then
		warnFlameSentry:Show()
		timerFlameSentryCD:Start(nil, args.sourceGUID)
	elseif spellId == 375457 then
		warnChillingTantrum:Show()
		timerChillingTantrumCD:Start(nil, args.sourceGUID)
	elseif spellId == 375630 then
		timerIonizingChargeCD:Start(nil, args.sourceGUID)
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 375842 then
		self.vb.staffCount = self.vb.staffCount + 1
		specWarnGreatstaffoftheBroodkeeper:Show(self.vb.staffCount)
		specWarnGreatstaffoftheBroodkeeper:Play("specialsoon")
		timerGreatstaffoftheBroodkeeperCD:start()
	elseif spellId == 380176 then
		self.vb.staffCount = self.vb.staffCount + 1
		specWarnEGreatstaffoftheBroodkeeper:Show(self.vb.staffCount)
		specWarnEGreatstaffoftheBroodkeeper:Play("specialsoon")
		timerEGreatstaffoftheBroodkeeperCD:start()
	elseif spellId == 375889 then
		warnGreatstaffsWrath:CombinedShow(1, args.destName)--Aggregated for now in case strat is to just pop multiple eggs and CD like fuck for Clutchwatcher's Rage
		if args:IsPlayer() then
			specWarnGreatstaffsWrath:Show()
			specWarnGreatstaffsWrath:Play("targetyou")
			yellGreatstaffsWrath:Yell()
		end
	elseif spellId == 380483 then
		warnEGreatstaffsWrath:CombinedShow(1, args.destName)--Aggregated for now in case strat is to just pop multiple eggs and CD like fuck for Clutchwatcher's Rage
		if args:IsPlayer() then
			specWarnEGreatstaffsWrath:Show()
			specWarnEGreatstaffsWrath:Play("targetyou")
			yellEGreatstaffsWrath:Yell()
		end
	elseif spellId == 375620 then
		warnIonizingCharge:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnIonizingCharge:Show()
			specWarnIonizingCharge:Play("range5")
			yellIonizingCharge:Yell()
		end
	elseif spellId == 375829 then
		warnClutchwatchersRage:Cancel()
		warnClutchwatchersRage:Schedule(1, args.destName, args.amount or 1)
	elseif spellId == 376073 then--Buff mobs get when they hatch
		if self.Options.NPRapidIncubation then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 30)
		end
	elseif spellId == 376074 or spellId == 376077 or spellId == 376160 then--Buffs they get while hatching
		if self.Options.NPRapidIncubation then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, spellId == 376077 and 4 or 15)
		end
	elseif spellId == 378782 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnMortalWounds:Show(args.destName)
			specWarnMortalWounds:Play("tauntboss")
		else
			warnMortalWounds:Show(args.destName, amount)
		end
	elseif spellId == 390561 and args:IsPlayer() then
		warnDiurnasGaze:Show()
	elseif spellId == 376272 and not args:IsPlayer() then
		local amount = args.amount or 1
		--local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		--local remaining
		--if expireTime then
		--	remaining = expireTime-GetTime()
		--end
		--if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
		--	specWarnMortalWounds:Show(args.destName)
		--	specWarnMortalWounds:Play("tauntboss")
		--else
			warnBurrowingStrike:Show(args.destName, amount)
		--end
	elseif spellId == 375475 and not args:IsPlayer() then
		local amount = args.amount or 1
		--local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		--local remaining
		--if expireTime then
		--	remaining = expireTime-GetTime()
		--end
		--if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
		--	specWarnMortalWounds:Show(args.destName)
		--	specWarnMortalWounds:Play("tauntboss")
		--else
			warnRendingBite:Show(args.destName, amount)
		--end
	elseif spellId == 375487 then
		specWarnIceBarrage:CombinedShow(1, args.destName)
		specWarnIceBarrage:ScheduleVoice(1, "helpldispel")
	elseif spellId == 375879 then
		warnBroodkeepersFury:Show(args.destName, args.amount or 1)
		if self.vb.phase == 1 then
			self:SetStage(2)
			self.vb.staffCount = 0
			self.vb.icyCount = 0--Reused for frozen shroud
			--Just stop outright
			timerRapidIncubationCD:Stop()
			timerIcyShroudCD:Stop()
			timerPrimalistReinforcementsCD:Stop()
			--Restarts
			timerWildfireCD:Stop()
			timerGreatstaffoftheBroodkeeperCD:Stop()
			timerMortalStoneclawsCD:Stop()
			timerWildfireCD:Start(2)
			timerGreatstaffoftheBroodkeeperCD:Start(2)--Reused for empowered great staff, spellname too long as it is
			timerMortalStoneclawsCD:Start(2)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 375809 then
		warnBroodkeepersBond:Show()
	elseif spellId == 375842 then
		warnGreatstaffoftheBroodkeeperEnded:Show()
		--Update other timers?
	elseif spellId == 380176 then
		warnEGreatstaffoftheBroodkeeperEnded:Show()
		--Update other timers?
	elseif spellId == 376073 or spellId == 376074 or spellId == 376077 or spellId == 376160 then
		if self.Options.NPRapidIncubation then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 191225 then--Tarasek Earthreaver
		timerBurrowingStrikeCD:Stop(args.destGUID)
		timerTremorsCD:Stop(args.destGUID)
	elseif cid == 192771 or cid == 191230 then--Dragonspawn Flamebender
		timerCauterizingFlashflamesCD:Stop(args.destGUID)
		timerFlameSentryCD:Stop(args.destGUID)
	elseif cid == 191222 then--Juvenile Frost Proto-Dragon
		timerRendingBiteCD:Stop(args.destGUID)
		timerChillingTantrumCD:Stop(args.destGUID)
	elseif cid == 191232 then--Drakonid Stormbringer
		timerIonizingChargeCD:Stop(args.destGUID)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 390747 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 385618 then--Summon Primalists
		self.vb.addsCount = self.vb.addsCount + 1
		self.vb.mageIcon = 8
		self.vb.StormbringerIcon = 6
		specWarnPrimalistReinforcements:Show()
		specWarnPrimalistReinforcements:Play("killmob")
		timerPrimalistReinforcementsCD:Start()
	end
end
