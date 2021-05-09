local mod	= DBM:NewMod(2447, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175730)
mod:SetEncounterID(2431)
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 351680 350554 350421 353426 350169 351969",
	"SPELL_CAST_SUCCESS 350355",
	"SPELL_AURA_APPLIED 354365 351680 353432 353931 350568 353195 353428 351969",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 354365 351680 350568 353195 353428 351969",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, figure out how fates alter timers, it's not pause, it's not reset, sometimes either works but never consistently
--TODO, https://ptr.wowhead.com/spell=354964/runic-affinity for mythic phase 2
--TODO, https://ptr.wowhead.com/spell=354966/unstable-accretion trackingn for mythic phase 2
--TODO, other phase 2 stuff? it's mostly just passive stuff like adds and dodgables
--[[
(ability.id = 350421 or ability.id = 351680 or ability.id = 351969 or ability.id = 350554) and type = "begincast"
 or ability.id = 353195 or ability.id = 351969
 or (ability.id = 353931 or ability.id = 353195) and type = "applydebuff"
 --]]
--Stage One: Scrying Fate
local warnGrimPortent							= mod:NewTargetNoFilterAnnounce(354365, 4)--Mythic
local warnTwistFate								= mod:NewTargetNoFilterAnnounce(353931, 2, nil, "RemoveMagic")
local warnCallofEternity						= mod:NewTargetAnnounce(350568, 4)
--Stage Two: Defying Destiny

--Stage Three: Fated Terminus
local warnExtemporaneousFate					= mod:NewSoonAnnounce(353195, 3)

--Stage One: Scrying Fate
local specWarnGrimPortent						= mod:NewSpecialWarningYouPos(354365, nil, nil, nil, 1, 2, 4)--Mythic
local yellGrimPortent							= mod:NewShortPosYell(354365)--Mythic
local yellGrimPortentFades						= mod:NewIconFadesYell(354365)--Mythic
local specWarnHeroicDestiny						= mod:NewSpecialWarningMoveAway(351680, nil, nil, nil, 1, 2)
local yellHeroicDestiny							= mod:NewYell(351680)
local yellHeroicDestinyFades					= mod:NewShortFadesYell(351680)
local specWarnHeroicDestinySwap					= mod:NewSpecialWarningTaunt(328897, nil, nil, nil, 1, 2)
local specWarnBurdenofDestinyYou				= mod:NewSpecialWarningRun(353432, nil, nil, nil, 4, 2)
local specWarnBurdenofDestiny					= mod:NewSpecialWarningSwitch(353432, "Dps", nil, nil, 1, 2)
local specWarnFatedConjunction					= mod:NewSpecialWarningDodge(350355, nil, nil, nil, 2, 2)
local specWarnCallofEternity					= mod:NewSpecialWarningMoveAway(350568, nil, nil, nil, 1, 2)
local yellCallofEternity						= mod:NewShortYell(350568)
local yellCallofEternityFades					= mod:NewShortFadesYell(350568)
--Stage Two: Defying Destiny
local specWarnRealignFate						= mod:NewSpecialWarningSpell(351969, nil, nil, nil, 2, 2)
--Stage Three: Fated Terminus Desperate
local specWarnExtemporaneousFate				= mod:NewSpecialWarningSpell(353195, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Stage One: Scrying Fate
local timerGrimPortentCD						= mod:NewAITimer(20, 354365, nil, nil, nil, 3, nil, DBM_CORE_L.MYTHIC_ICON)
local timerHeroicDestinyCD						= mod:NewCDTimer(39.2, 351680, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--39-41
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
mod:AddSetIconOption("SetIconOnGrimPortent", 354365, true, false, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnBurdenofDestiny", 353432, true)

mod.vb.DebuffIcon = 1
mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.DebuffIcon = 1
	self.vb.phase = 1
--	timerHeroicDestinyCD:Start(1-delay)--UNKNOWN, dps too high to see this before fate phase
	timerTwistFateCD:Start(4.5-delay)
	timerFatedConjunctionCD:Start(13.2-delay)
	timerCallofEternityCD:Start(24.2-delay)
--	berserkTimer:Start(-delay)
	if self:IsMythic() then
		timerGrimPortentCD:Start(1-delay)
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351680 then
		timerHeroicDestinyCD:Start()
	elseif spellId == 350554 then--Two sub cast IDs, but one primary?
		timerCallofEternityCD:Start()
	elseif (spellId == 350421 or spellId == 353426 or spellId == 350169) then--350421 confiremd, others unknown
		specWarnFatedConjunction:Show()
		specWarnFatedConjunction:Play("watchstep")
		timerFatedConjunctionCD:Start()
	elseif spellId == 351969 then
		specWarnRealignFate:Show()
		specWarnRealignFate:Play("specialsoon")
		timerHeroicDestinyCD:Stop()
		--No idea how timers work, can't figure it out
--		timerTwistFateCD:Stop()
--		timerFatedConjunctionCD:Stop()
--		timerCallofEternityCD:Stop()
--		timerGrimPortentCD:Stop()
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
		if self:AntiSpam(5, 1) then--TODO: Move to cast event if there is one
			timerGrimPortentCD:Start()
		end
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnGrimPortent then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnGrimPortent:Show(self:IconNumToTexture(icon))
			specWarnGrimPortent:Play("mm"..icon)
			yellGrimPortent:Yell(icon, icon)
			yellGrimPortentFades:Countdown(spellId, nil, icon)
		end
		warnGrimPortent:CombinedShow(0.5, args.destName)
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
		if self.vb.DebuffIcon > 8 then
			self.vb.DebuffIcon = 1
			DBM:AddMsg("Cast event for Grim Portent is wrong, doing backup icon reset")
		end
	elseif spellId == 351680 then
		if args:IsPlayer() then
			specWarnHeroicDestiny:Show()
			specWarnHeroicDestiny:Play("runout")
			yellHeroicDestiny:Yell()
			yellHeroicDestinyFades:Countdown(spellId)
		else
			specWarnHeroicDestinySwap:Show(args.destName)
			specWarnHeroicDestinySwap:Play("tauntboss")
			specWarnHeroicDestinySwap:ScheduleVoice(1.5, "defensive")
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
	elseif spellId == 353931 then
		warnTwistFate:CombinedShow(0.3, args.destName)
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
		--No idea how timers work, can't figure it out
--		timerHeroicDestinyCD:Stop()
--		timerTwistFateCD:Stop()
--		timerTwistFateCD:Start(11.6)
--		timerHeroicDestinyCD:Start(26.1)
	elseif spellId == 353428 or spellId == 351969 then--Realign Fate, 351969 is incorrect spellID and blizz might fix it later to use 353428
		timerDarkestDestiny:Start()
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
			yellHeroicDestinyFades:Cancel()
		end
	elseif spellId == 353432 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnBurdenofDestiny then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 353195 then--Extemporaneous Fate
		timerDarkestDestiny:Stop()
	elseif spellId == 353428 or spellId == 351969 then--Realign Fate, 351969 is incorrect spellID and blizz might fix it later to use 353428
		timerDarkestDestiny:Stop()
		--No idea how timers work, can't figure it out
--		timerTwistFateCD:Start(7.3)
--		timerFatedConjunctionCD:Start(15.7)
--		timerCallofEternityCD:Start(26.6)
--		timerHeroicDestinyCD:Start(37.6)
--		if self:IsMythic() then
--			timerGrimPortentCD:Start(2)
--		end
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
		timerTwistFateCD:Start()
	end
end
