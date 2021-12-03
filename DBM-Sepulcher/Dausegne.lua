local mod	= DBM:NewMod(2459, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(181224)--or 183042
mod:SetEncounterID(2540)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 359483 363607 361513 361630 365418",
	"SPELL_CAST_SUCCESS 361018 361214 361751 365373",
	"SPELL_AURA_APPLIED 361966 361018 361651",
	"SPELL_AURA_APPLIED_DOSE 361966",
	"SPELL_AURA_REMOVED 361966 361018 361651"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, exact stack count optimal of tanks swaps of 361966, for now most warnings are silent or way overtuned
--TODO, Staggering Barrage tracking https://ptr.wowhead.com/spell=364289/staggering-barrage
--TODO, use https://ptr.wowhead.com/spell=359481/domination-core for auto marking domination ores maybe, if more than 1 to mark
--TODO, valid Encroaching Dominion cast and maybe count timer if it's not spam cast. also GTFO
--TODO, verify target scanning of arc
--TODO, likely spellids for Disintegration Halo are completely wrong. It has too many scripts to accurately guess correct cast trigger
--TODO, verify more phasing stuff
--The Fallen Oracle
local warnInfusedStrikes						= mod:NewStackAnnounce(361966, 2, nil, "Tank|Healer")
local warnStaggeringBarrage						= mod:NewTargetNoFilterAnnounce(361018, 3)
local warnEncroachingDominion					= mod:NewSpellAnnounce(361214, 2)
local warnObliterationArc						= mod:NewTargetNoFilterAnnounce(361513, 3)
--Inevitable Dominion
local warnSiphonReservoir						= mod:NewCountAnnounce(361643, 2)

--The Fallen Oracle
local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnInfusedStrikesTaunt				= mod:NewSpecialWarningTaunt(361966, nil, nil, nil, 1, 2)
local yellInfusedStrikes						= mod:NewShortFadesYell(361966)
local specWarnStaggeringBarrage					= mod:NewSpecialWarningYouPos(361018, nil, nil, nil, 1, 2)
local yellStaggeringBarrage						= mod:NewShortPosYell(361018)
local yellStaggeringBarrageFades				= mod:NewIconFadesYell(361018)
local specWarnStaggeringBarrageTarget			= mod:NewSpecialWarningTarget(361018, false, nil, nil, 1, 2, 3)--Optional Soak special warning that auto checks no soak debuff
local specWarnDominationBolt					= mod:NewSpecialWarningInterruptCount(363607, "HasInterrupt", nil, nil, 1, 2)
local specWarnObliterationArc					= mod:NewSpecialWarningDodge(361513, nil, nil, nil, 2, 2)
local yellObliterationArc						= mod:NewYell(361513)
local specWarnDisintegrationHalo				= mod:NewSpecialWarningDodge(365373, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)
--Inevitable Dominion
local specWarnTotalDominion						= mod:NewSpecialWarningSpell(365418, nil, nil, nil, 3, 2)--Basically soft enrage/wipe mechanic

--mod:AddTimerLine(BOSS)
--The Fallen Oracle
local timerStaggeringBarrageCD					= mod:NewAITimer(28.8, 361018, nil, nil, nil, 3)
local timerDominationCoreCD						= mod:NewAITimer(28.8, 359483, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--local timerEncroachingDominionCD				= mod:NewAITimer(28.8, 361214, nil, nil, nil, 3)
local timerObliterationArcCD					= mod:NewAITimer(28.8, 361513, nil, nil, nil, 3)
local timerDisintegrationHaloCD					= mod:NewAITimer(28.8, 365373, nil, nil, nil, 3)
--Inevitable Dominion
local timerSiphonReservoirCD					= mod:NewAITimer(28.8, 361643, nil, nil, nil, 6)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.DebuffIcon = 1
mod.vb.ReservoirCount = 0
mod.vb.softEnrage = false
local castsPerGUID = {}

function mod:ArcTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
--		specWarnObliterationArc:Show()
--		specWarnObliterationArc:Play("targetyou")
		yellObliterationArc:Yell()
	else
		warnObliterationArc:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.DebuffIcon = 1
	self.vb.ReservoirCount = 0
	self.vb.softEnrage = false
	timerStaggeringBarrageCD:Start(1-delay)
	timerDominationCoreCD:Start(1-delay)
	timerObliterationArcCD:Start(1-delay)
	timerDisintegrationHaloCD:Start(1-delay)
	timerSiphonReservoirCD:Start(1-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnBurdenofDestiny then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 359483 then

		timerDominationCoreCD:Start()
	elseif spellId == 363607 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnDominationBolt:Show(args.sourceName, count)
			if count == 1 then
				specWarnDominationBolt:Play("kick1r")
			elseif count == 2 then
				specWarnDominationBolt:Play("kick2r")
			elseif count == 3 then
				specWarnDominationBolt:Play("kick3r")
			elseif count == 4 then
				specWarnDominationBolt:Play("kick4r")
			elseif count == 5 then
				specWarnDominationBolt:Play("kick5r")
			else
				specWarnDominationBolt:Play("kickcast")
			end
		end
	elseif spellId == 361513 then
		specWarnObliterationArc:Show()
		specWarnObliterationArc:Play("shockwave")
		timerObliterationArcCD:Start()
		self:BossTargetScanner(args.sourceGUID, "ArcTarget", 0.1, 12)
	elseif spellId == 361630 then--Teleport
		self.vb.ReservoirCount = self.vb.ReservoirCount + 1
		warnSiphonReservoir:Show(self.vb.ReservoirCount)
		timerStaggeringBarrageCD:Stop()
		timerDominationCoreCD:Stop()
		timerObliterationArcCD:Stop()
		timerDisintegrationHaloCD:Stop()
	elseif spellId == 365418 then
		self.vb.softEnrage = true
		specWarnTotalDominion:Show()
		specWarnTotalDominion:Play("stilldanger")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 361018 then
		self.vb.DebuffIcon = 1
		timerStaggeringBarrageCD:Start()
	elseif spellId == 361214 then
		warnEncroachingDominion:Show()
		--timerEncroachingDominionCD:Start(nil, args.sourceGUID)
	elseif (spellId == 361751 or spellId == 365373) and self:AntiSpam(5, 1) then
		specWarnDisintegrationHalo:Show()
		specWarnDisintegrationHalo:Play("watchwave")
		if not self.vb.softEnrage then--Disable timer if boss is spamming halos
			timerDisintegrationHaloCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 361966 then
		local amount = args.amount or 1
		if args:IsPlayer() then
			yellInfusedStrikes:Cancel()
			yellInfusedStrikes:Countdown(spellId, 5)
			if amount % 3 == 0 and amount >= 9 then
				specWarnInfusedStrikes:Show(amount)
				specWarnInfusedStrikes:Play("stackhigh")
			end
		else
			if amount % 3 == 0 and amount >= 9 then
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", 362008) then--Not dead and not 100% vulnerable
					specWarnInfusedStrikesTaunt:Show(args.destName)
					specWarnInfusedStrikesTaunt:Play("tauntboss")
				else
					warnInfusedStrikes:Show(args.destName, amount)
				end
			else
				warnInfusedStrikes:Show(args.destName, amount)
			end
		end
	elseif spellId == 361018 then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnStaggeringBarrage then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			--Unschedule target warning if you've become one of victims
			specWarnStaggeringBarrageTarget:Cancel()
			specWarnStaggeringBarrageTarget:CancelVoice()
			--Now show your warnings
			specWarnStaggeringBarrage:Show(self:IconNumToTexture(icon))
			specWarnStaggeringBarrage:Play("mm"..icon)
			yellStaggeringBarrage:Yell(icon, icon)
			yellStaggeringBarrageFades:Countdown(spellId, nil, icon)
		elseif self.Options.SpecWarn361018target and not DBM:UnitDebuff("player", 364289) then
			--Don't show special warning if you're one of victims
			specWarnStaggeringBarrageTarget:CombinedShow(0.5, args.destName)
			specWarnStaggeringBarrageTarget:ScheduleVoice(0.5, "helpsoak")
		else
			warnStaggeringBarrage:CombinedShow(0.5, args.destName)
		end
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 361651 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 361966 then
		if args:IsPlayer() then
			yellInfusedStrikes:Cancel()
		end
	elseif spellId == 361018 then
		if self.Options.SetIconOnStaggeringBarrage then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellStaggeringBarrageFades:Cancel()
		end
	elseif spellId == 361651 then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		timerSiphonReservoirCD:Start(2)
		--Do timers reset this way?
		timerStaggeringBarrageCD:Start(2)
		timerDominationCoreCD:Start(2)
		timerObliterationArcCD:Start(2)
		if not self.vb.softEnrage then
			timerDisintegrationHaloCD:Start(2)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 181244 then--Domination Core
		timerEncroachingDominionCD:Stop(args.destGUID)
	end
end
-]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
