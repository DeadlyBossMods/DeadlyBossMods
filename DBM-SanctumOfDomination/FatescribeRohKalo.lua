local mod	= DBM:NewMod(2447, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175730)
mod:SetEncounterID(2431)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20210531000000)--2021-05-31
mod:SetMinSyncRevision(20210531000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 351680 350554 350421 353426 350169 351969 354367",
	"SPELL_CAST_SUCCESS 350355",
	"SPELL_AURA_APPLIED 354365 351680 353432 350568 353195 353428 351969 354964",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 354365 351680 350568 353195 353428 351969",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://ptr.wowhead.com/spell=354966/unstable-accretion trackingn for mythic phase 2
--TODO, other phase 2 stuff? it's mostly just passive stuff like adds and dodgables
--TODO, verify UNIT_AURA solution for Re-Align Fate buff no longer being in combat
--TODO, further mythic timer data for phase 3 and resquence all of heroic timer data with latest in retest if there is one or on live
--[[
(ability.id = 350421 or ability.id = 351680 or ability.id = 351969 or ability.id = 350554 or ability.id = 354367) and type = "begincast"
 or ability.id = 353195 or ability.id = 351969
 or (ability.id = 353931 or ability.id = 353195) and type = "applydebuff"
 --]]
--Stage One: Scrying Fate
local warnGrimPortent							= mod:NewTargetNoFilterAnnounce(354365, 4)--Mythic
local warnTwistFate								= mod:NewCountAnnounce(353931, 2, nil, "RemoveMagic")
local warnCallofEternity						= mod:NewTargetAnnounce(350568, 4)
--Stage Two: Defying Destiny
local warnRunicAffinity							= mod:NewTargetNoFilterAnnounce(354964, 4)--Mythic
--Stage Three: Fated Terminus
local warnExtemporaneousFate					= mod:NewSoonAnnounce(353195, 3)

--Stage One: Scrying Fate
local specWarnGrimPortent						= mod:NewSpecialWarningYouPos(354365, nil, nil, nil, 1, 2, 4)--Mythic
local yellGrimPortent							= mod:NewShortPosYell(354365)--Mythic
local yellGrimPortentFades						= mod:NewIconFadesYell(354365)--Mythic
local specWarnInvokeDestiny						= mod:NewSpecialWarningMoveAway(351680, nil, nil, nil, 1, 2)
local yellInvokeDestiny							= mod:NewYell(351680)
local yellInvokeDestinyFades					= mod:NewShortFadesYell(351680)
local specWarnInvokeDestinySwap					= mod:NewSpecialWarningTaunt(328897, nil, nil, nil, 1, 2)
local specWarnBurdenofDestinyYou				= mod:NewSpecialWarningRun(353432, nil, nil, nil, 4, 2)
local specWarnBurdenofDestiny					= mod:NewSpecialWarningSwitch(353432, "Dps", nil, nil, 1, 2)
local specWarnFatedConjunction					= mod:NewSpecialWarningDodge(350355, nil, nil, nil, 2, 2)
local specWarnCallofEternity					= mod:NewSpecialWarningMoveAway(350568, nil, nil, nil, 1, 2)
local yellCallofEternity						= mod:NewShortYell(350568)
local yellCallofEternityFades					= mod:NewShortFadesYell(350568)
--Stage Two: Defying Destiny
local specWarnRealignFate						= mod:NewSpecialWarningCount(351969, nil, nil, nil, 2, 2)
local specWarnRunicAffinity						= mod:NewSpecialWarningYou(354964, nil, nil, nil, 2, 2, 4)
--Stage Three: Fated Terminus Desperate
local specWarnExtemporaneousFate				= mod:NewSpecialWarningSpell(353195, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Scrying Fate
local timerGrimPortentCD						= mod:NewCDTimer(28.8, 354365, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)--28-46?
local timerInvokeDestinyCD						= mod:NewCDTimer(37.8, 351680, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--37.8-41
local timerTwistFateCD							= mod:NewCDTimer(48.7, 353931, nil, "RemoveMagic", nil, 5, nil, DBM_CORE_L.MAGIC_ICON)
local timerFatedConjunctionCD					= mod:NewCDTimer(59.7, 350355, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON, nil, 1, 3)
local timerCallofEternityCD						= mod:NewCDTimer(37.9, 350554, nil, nil, nil, 3)
--Stage Two: Defying Destiny
--local timerRealignFateCD						= mod:NewAITimer(17.8, 351969, nil, nil, nil, 6)
local timerDarkestDestiny						= mod:NewCastTimer(40, 353122, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
--Stage Three: Fated Terminus Desperate
local timerExtemporaneousFateCD					= mod:NewCDTimer(39.0, 353195, nil, nil, nil, 6)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnGrimPortent", 354365, false, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.DebuffIcon = 1
mod.vb.realignCount = 0
mod.vb.twistCount = 0
mod.vb.eternityCount = 0
mod.vb.destinyCount = 0
mod.vb.conjunctionCount = 0
mod.vb.portentCount = 0
mod.vb.buffFound = false
local difficultyName = "normal"
--Currently non mythic difficulties not using table yet since data not yet built (heroic logs kinda bad because dps too high to get actual sequences)
local allTimers = {
	["mythic"] = {
		[1] = {
			--Twist Fate
			[354265] = {5.8, 29.2, 43.8, 36.4, 17.0, 32.9},
			--Call of Eternity
			[350554] = {11.8, 41.3, 35.4, 54.8},
			--Heroic Destiny
			[351680] = {20.8, 40.1, 39.7, 40.1},
			--Fated Conjunction
			[350421] = {22.8, 68.9, 53.5},
			--Grim Portent
			[354367] = {43.9, 28.8, 47.3},
		},
		[3] = {
			--Twist Fate
			[354265] = {},
			--Call of Eternity
			[350554] = {},
			--Heroic Destiny
			[351680] = {},
			--Fated Conjunction
			[350421] = {},
		}
	},
	["heroic"] = {
		[1] = {--No reliable data, bad transcriptor log AND dps too high for heroic sequencing
			--Twist Fate
			[354265] = {4.5},
			--Call of Eternity
			[350554] = {24},
			--Heroic Destiny
			[351680] = {35},
			--Fated Conjunction
			[350421] = {13.1},
		},
		[3] = {
			--Twist Fate
			[354265] = {},
			--Call of Eternity
			[350554] = {},
			--Heroic Destiny
			[351680] = {},
			--Fated Conjunction
			[350421] = {},
		}
	},
	["normal"] = {
		[1] = {--No data at all
			--Twist Fate
			[354265] = {},
			--Call of Eternity
			[350554] = {},
			--Heroic Destiny
			[351680] = {},
			--Fated Conjunction
			[350421] = {},
		},
		[3] = {
			--Twist Fate
			[354265] = {},
			--Call of Eternity
			[350554] = {},
			--Heroic Destiny
			[351680] = {},
			--Fated Conjunction
			[350421] = {},
		}
	},
}

function mod:OnCombatStart(delay)
	self.vb.DebuffIcon = 1
	self:SetStage(1)
	self.vb.realignCount = 0
	self.vb.twistCount = 0
	self.vb.eternityCount = 0
	self.vb.destinyCount = 0
	self.vb.conjunctionCount = 0
	self.vb.portentCount = 0
	self.vb.buffFound = false
--	berserkTimer:Start(-delay)
	if self:IsMythic() then
		difficultyName = "mythic"
		timerTwistFateCD:Start(5.8-delay, 1)
		timerCallofEternityCD:Start(13-delay, 1)
		timerInvokeDestinyCD:Start(20-delay, 1)
		timerFatedConjunctionCD:Start(22-delay, 1)
		timerGrimPortentCD:Start(43-delay, 1)
	else
		if self:IsHeroic() then
			difficultyName = "heroic"
			timerTwistFateCD:Start(4.5-delay, 1)
			timerFatedConjunctionCD:Start(13.1-delay, 1)
			timerCallofEternityCD:Start(24-delay, 1)
			timerInvokeDestinyCD:Start(35-delay, 1)
		else
			difficultyName = "normal"
			--Timers copied from heroic, probably wrong
			timerTwistFateCD:Start(4.5-delay, 1)
			timerFatedConjunctionCD:Start(13.1-delay, 1)
			timerCallofEternityCD:Start(24-delay, 1)
			timerInvokeDestinyCD:Start(35-delay, 1)
		end
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnBurdenofDestiny then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnBurdenofDestiny then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351680 then
		self.vb.destinyCount = self.vb.destinyCount + 1
		local timer = self:IsMythic() and allTimers[difficultyName][self.vb.phase][spellId][self.vb.destinyCount+1] or not self:IsMythic() and 37.8
		if timer then
			timerInvokeDestinyCD:Start(timer, self.vb.destinyCount+1)
		end
	elseif spellId == 350554 then--Two sub cast IDs, but one primary?
		self.vb.eternityCount = self.vb.eternityCount + 1
		local timer = self:IsMythic() and allTimers[difficultyName][self.vb.phase][spellId][self.vb.eternityCount+1] or not self:IsMythic() and 37.9
		if timer then
			timerCallofEternityCD:Start(timer, self.vb.eternityCount+1)
		end
	elseif (spellId == 350421 or spellId == 353426 or spellId == 350169) then--350421 confiremd, others unknown
		self.vb.conjunctionCount = self.vb.conjunctionCount + 1
		specWarnFatedConjunction:Show()
		specWarnFatedConjunction:Play("watchstep")
		local timer = self:IsMythic() and allTimers[difficultyName][self.vb.phase][spellId][self.vb.conjunctionCount+1] or not self:IsMythic() and 59.7
		if timer then
			timerFatedConjunctionCD:Start(timer, self.vb.conjunctionCount+1)
		end
	elseif spellId == 351969 then
		self:SetStage(2)
		self.vb.realignCount = self.vb.realignCount + 1
		specWarnRealignFate:Show(self.vb.realignCount)
		specWarnRealignFate:Play("specialsoon")
		timerInvokeDestinyCD:Stop()
		timerTwistFateCD:Stop()
		timerFatedConjunctionCD:Stop()
		timerCallofEternityCD:Stop()
		timerGrimPortentCD:Stop()
		self.vb.buffFound = false
		self:RegisterShortTermEvents(
			"UNIT_AURA boss1"
		)
	elseif spellId == 354367 then
		self.vb.DebuffIcon = 1
		self.vb.portentCount = self.vb.portentCount + 1
		local timer = self:IsMythic() and allTimers[difficultyName][self.vb.phase][spellId][self.vb.portentCount+1] or 59.7
		if timer then
			timerGrimPortentCD:Start(timer, self.vb.portentCount+1)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353931 then
		timerTwistFateCD:Start()
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 354365 then
		if args:IsDestTypePlayer() then
			local icon = self.vb.DebuffIcon
			if self.Options.SetIconOnGrimPortent and icon < 9 then
				self:SetIcon(args.destName, icon)
			end
			if args:IsPlayer() then
				specWarnGrimPortent:Show()
				specWarnGrimPortent:Play("targetyou")
				yellGrimPortent:Yell()
				yellGrimPortentFades:Countdown(spellId)
			end
			warnGrimPortent:CombinedShow(0.5, args.destName)
			self.vb.DebuffIcon = self.vb.DebuffIcon + 1
		end
	elseif spellId == 351680 then
		if args:IsPlayer() then
			specWarnInvokeDestiny:Show()
			specWarnInvokeDestiny:Play("runout")
			yellInvokeDestiny:Yell()
			yellInvokeDestinyFades:Countdown(spellId)
		else
			specWarnInvokeDestinySwap:Show(args.destName)
			specWarnInvokeDestinySwap:Play("tauntboss")
			specWarnInvokeDestinySwap:ScheduleVoice(1.5, "defensive")
		end
	elseif spellId == 353432 then
		if args:IsPlayer() then
			specWarnBurdenofDestinyYou:Show()
			specWarnBurdenofDestinyYou:Play("justrun")
			if self.Options.NPAuraOnBurdenofDestiny then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		else
			specWarnBurdenofDestiny:Show()
			specWarnBurdenofDestiny:Play("killmob")
		end
	elseif spellId == 350568 then
		warnCallofEternity:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnCallofEternity:Show()
			specWarnCallofEternity:Play("runout")
			yellCallofEternity:Yell()
			yellCallofEternityFades:Countdown(spellId)
		end
	elseif spellId == 353195 then--Extemporaneous Fate
		specWarnExtemporaneousFate:Show()
		specWarnExtemporaneousFate:Play("specialsoon")--"157060" if they just happen to be yellow
		timerExtemporaneousFateCD:Start()
		timerDarkestDestiny:Start(30)
	elseif spellId == 353428 or spellId == 351969 then--Realign Fate, 351969 is incorrect spellID and blizz might fix it later to use 353428
		timerDarkestDestiny:Start()
	elseif spellId == 354964 then
		warnRunicAffinity:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnRunicAffinity:Show()
			specWarnRunicAffinity:Play("targetyou")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 354365 then
		if self.Options.SetIconOnGrimPortent then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 351680 then
		if args:IsPlayer() then
			yellInvokeDestinyFades:Cancel()
		end
	elseif spellId == 353432 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnBurdenofDestiny then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 353195 then--Extemporaneous Fate
		timerDarkestDestiny:Stop()
	elseif (spellId == 353428 or spellId == 351969) and self.vb.phase == 2 then--Realign Fate, 351969 is incorrect spellID and blizz might fix it later to use 353428
		self:UnregisterShortTermEvents()
		timerDarkestDestiny:Stop()
		self.vb.twistCount = 0
		self.vb.eternityCount = 0
		self.vb.destinyCount = 0
		self.vb.conjunctionCount = 0
		self.vb.portentCount = 0
		if self.vb.realignCount == 1 then--first cast
			self:SetStage(1)
			if self:IsMythic() then
				--Extrapolated sincce it's same as initial phase 1 but offset a little
				timerTwistFateCD:Start(8.4, 1)
				timerCallofEternityCD:Start(15.6, 1)
				timerInvokeDestinyCD:Start(22.6, 1)
				timerFatedConjunctionCD:Start(24.6, 1)
				timerGrimPortentCD:Start(45.6, 1)
			else
				timerTwistFateCD:Start(7.3, 1)
				timerFatedConjunctionCD:Start(15.7, 1)
				timerCallofEternityCD:Start(26.6, 1)
				timerInvokeDestinyCD:Start(37.6, 1)
			end
		else--Second cast
			self:SetStage(3)
			timerFatedConjunctionCD:Start(8.4, 1)
			timerCallofEternityCD:Start(10.9, 1)
			timerInvokeDestinyCD:Start(24.4, 1)
			timerExtemporaneousFateCD:Start(39.7, 1)
			timerTwistFateCD:Start(48.9, 1)
			if self:IsMythic() then
				--timerGrimPortentCD:Start(2, 1)
			end
		end
	end
end

function mod:UNIT_AURA(uId)
	if DBM:UnitDebuff("boss1", 353428, 351969) and not self.vb.buffFound then
		self.vb.buffFound = true
	elseif not DBM:UnitDebuff("boss1", 353428, 351969) and self.vb.buffFound then--Boss had buff found through unit aura, but it's gone now, phase over
		self:UnregisterShortTermEvents()
		self.vb.buffFound = false
		if self.vb.phase == 2 then
			timerDarkestDestiny:Stop()
			self.vb.twistCount = 0
			self.vb.eternityCount = 0
			self.vb.destinyCount = 0
			self.vb.conjunctionCount = 0
			self.vb.portentCount = 0
			if self.vb.realignCount < 3 then
				self:SetStage(1)
				if self:IsMythic() then
					--Extrapolated sincce it's same as initial phase 1 but offset a little
					timerTwistFateCD:Start(8.4, 1)
					timerCallofEternityCD:Start(15.6, 1)
					timerInvokeDestinyCD:Start(22.6, 1)
					timerFatedConjunctionCD:Start(24.6, 1)
					timerGrimPortentCD:Start(45.6, 1)
				else
					timerTwistFateCD:Start(7.3, 1)
					timerFatedConjunctionCD:Start(15.7, 1)
					timerCallofEternityCD:Start(26.6, 1)
					timerInvokeDestinyCD:Start(37.6, 1)
				end
			else
				self:SetStage(3)
				timerFatedConjunctionCD:Start(8.4, 1)
				timerCallofEternityCD:Start(10.9, 1)
				timerInvokeDestinyCD:Start(24.4, 1)
				timerExtemporaneousFateCD:Start(39.7, 1)
				timerTwistFateCD:Start(48.9, 1)
				if self:IsMythic() then
					--timerGrimPortentCD:Start(2, 1)
				end
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--"<1445.83 22:22:30> [UNIT_SPELLCAST_SUCCEEDED] Fatescribe Roh-Kalo(Shazzul) -Extemporaneous Fate- [[boss1:Cast-3-2012-2450-10555-353193-000195A188:353193]]", -- [28166]
--"<1453.06 22:22:37> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\Achievement_GuildPerk_WorkingOvertime_Rank2.blp:20|t Fatescribe Roh-Kalo is creating an |cFFFF0000|Hspell:353195|h[Extemporaneous Fate]|h|r!#Fatescribe Roh-Kalo###Fatescribe Roh-Kalo##0#0##0#572#nil#0#false#false#false#false", -- [28352]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then--Extemporaneous Fate (precast)
		warnExtemporaneousFate:Show()
	elseif spellId == 354265 then--Twist Fate
		self.vb.twistCount = self.vb.twistCount + 1
		warnTwistFate:Show(self.vb.twistCount)
		local timer = self:IsMythic() and allTimers[difficultyName][self.vb.phase][spellId][self.vb.twistCount+1] or not self:IsMythic() and 48.7
		if timer then
			timerTwistFateCD:Start(timer, self.vb.twistCount+1)
		end
	end
end
