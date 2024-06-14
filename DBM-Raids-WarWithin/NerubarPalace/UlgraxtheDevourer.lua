local mod	= DBM:NewMod(2607, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(215657)--VERIFY
mod:SetEncounterID(2902)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20240614000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 434803 441451 441452 435136 434697 445052 436203 436200 451412 443842 438012 445290 445123",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 439419 455831 435138 434705",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, proper detection of slathering Maw. is cast ID used now for the gather part, or run out part after gather?
--TODO, announce netting targets unfiltered?
--TODO, now boss seems to be mid rework so work on this mod haulted until some stuff clarified.
--TODO, auto marking or countdown yell for Digestive Venom? countdown seens unneeded if you dispel it soon as you arrive and icons depends on number of webs/venoms
--TODO, clean way to detect boss phasing into feeding frenzy. Can't assume right now if it's adds or rage that'll happen first (or something else)
--TODO, auto marking with spell summon events?
--TODO, announce deaths of adds (viscera)? depends how many adds there are. if it's 1-3 at a time, maybe. if it's 10 of em, no
--TODO, target scan Juggernaut charge? depends which of two IDs it uses. One has AI faces target and one has "aie does not face target"
--TODO, obviously phase detection. If I had to guess, Hulking Crash is signal that feeding frenzy is over. POWER updates is less efficient and TEMPORARY
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 434803 or ability.id = 441451 or ability.id = 441452 or ability.id = 435136 or ability.id = 434697 or ability.id = 445052 or ability.id = 436203 or ability.id = 436200 or ability.id = 451412 or ability.id = 443842 or ability.id = 438012 or ability.id = 445290 or ability.id = 445123) and type = "begincast"
--]]
--Gleeful Brutality
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30011))
local warnStalkerNetting						= mod:NewTargetAnnounce(439419, 3)--Non Mythic
local warnHardenedNetting						= mod:NewTargetAnnounce(439419, 3)--Mythic
local warnVenomLash								= mod:NewCountAnnounce(435136, 3)
local warnDigestiveVenom						= mod:NewTargetAnnounce(435138, 3)
local warnHungeringBelows						= mod:NewCountAnnounce(438012, 3)

local specWarnBrutalLashings					= mod:NewSpecialWarningCount(434803, nil, nil, nil, 2, 2)
local specWarnStalkersWebbing					= mod:NewSpecialWarningDodgeCount(441451, nil, nil, nil, 2, 2)--aka Viscous Slobber apparently
local specWarnDigestiveVenom					= mod:NewSpecialWarningYou(435138, nil, nil, nil, 1, 2)
local yellDigestiveVenom						= mod:NewShortYell(435138)
local specWarnBrutalCrush						= mod:NewSpecialWarningDefensive(434697, nil, nil, nil, 1, 2)
local specWarnTenderized						= mod:NewSpecialWarningTaunt(434705, nil, nil, nil, 1, 2)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerBrutalLashingsCD						= mod:NewCDCountTimer(36.0, 434803, nil, nil, nil, 3)
local timerStalkersWebbingCD					= mod:NewCDCountTimer(49, 441451, nil, nil, nil, 3)
local timerVenomLashCD							= mod:NewCDCountTimer(32.9, 435136, nil, nil, nil, 2)
local timerBrutalCrushCD						= mod:NewCDCountTimer(14.0, 434697, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Feeding Frenzy
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28845))
local warnJuggernautCharge						= mod:NewCountAnnounce(436200, 4)--Charges 2+ of the set

local specWarnChitteringSwarm					= mod:NewSpecialWarningSwitch(445052, nil, nil, nil, 1, 2)--BW using -28848 instead?
local specWarnJuggernautCharge					= mod:NewSpecialWarningDodgeCount(436200, nil, nil, nil, 2, 2)--Activation
local specWarnSwallowingDarkness				= mod:NewSpecialWarningDodgeCount(443842, nil, nil, nil, 2, 2)
local specWarnHulkingCrash						= mod:NewSpecialWarningDodge(445290, nil, nil, nil, 2, 2)

local timerChitteringSwarmCD					= mod:NewCDTimer(49, 445052, nil, nil, nil, 1)
local timerJuggernautChargeCD					= mod:NewCDCountTimer(49, 436200, nil, nil, nil, 3)
local timerSwallowingDarknessCD					= mod:NewCDTimer(49, 443842, nil, nil, nil, 3)
local timerHungeringBellowsCD					= mod:NewCDCountTimer(18, 438012, nil, nil, nil, 2)
local timerHulkingCrashCD						= mod:NewCDCountTimer(18, 445290, nil, nil, nil, 3)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnAdds", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.lashingsCount = 0--Ability that's go smash and knock players around (Brutal Lashings and Hulking Crash)
mod.vb.webbingChargeCount = 0--Abilities that leave webbing/Netting (Stalkers Webbing and Juggernaut
mod.vb.lashdarknessCount = 0--Abilities that remove webbing/netting (Venomous Lash and Swallowing Darkness)
mod.vb.brutalHungeringCount = 0--Abilities for tank/healer (Brutal Crush and Hungering Bellows)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.lashingsCount = 0
	self.vb.webbingChargeCount = 0
	self.vb.lashdarknessCount = 0
	self.vb.brutalHungeringCount = 0
	timerBrutalCrushCD:Start(3, 1)--Can be delayed by kiting or pulling boss from far away, then get further spell queued
	timerStalkersWebbingCD:Start(8, 1)
	timerVenomLashCD:Start(14.1, 1)
	timerBrutalLashingsCD:Start(20.4, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 434803 then
		self.vb.lashingsCount = self.vb.lashingsCount + 1
		specWarnBrutalLashings:Show(self.vb.lashingsCount)
		specWarnBrutalLashings:Play("gathershare")
		timerBrutalLashingsCD:Start(nil, self.vb.lashingsCount+1)
		timerBrutalCrushCD:Stop()
		timerBrutalCrushCD:Start(16, self.vb.brutalHungeringCount+1)
	elseif spellId == 441451 or spellId == 441452 then
		self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
		specWarnStalkersWebbing:Show(self.vb.webbingChargeCount)
		specWarnStalkersWebbing:Play("watchstep")
		if self.vb.webbingChargeCount % 3 == 1 then
			timerStalkersWebbingCD:Start(36, self.vb.webbingChargeCount+1)
		elseif self.vb.webbingChargeCount % 3 == 2 then
			timerStalkersWebbingCD:Start(33.9, self.vb.webbingChargeCount+1)
		end
	elseif spellId == 435136 then
		self.vb.lashdarknessCount = self.vb.lashdarknessCount + 1
		warnVenomLash:Show(self.vb.lashdarknessCount)
		if self.vb.lashdarknessCount % 3 == 1 then
			timerVenomLashCD:Start(32.9, self.vb.lashdarknessCount+1)
		elseif self.vb.lashdarknessCount % 3 == 2 then
			timerVenomLashCD:Start(37, self.vb.lashdarknessCount+1)
		end
		if timerBrutalCrushCD:GetRemaining(self.vb.brutalHungeringCount+1) < 5 then
			local elapsed, total = timerBrutalCrushCD:GetTime(self.vb.brutalHungeringCount+1)
			local extend = 5 - (total-elapsed)
			DBM:Debug("timerBrutalCrushCD extended by: "..extend, 2)
			timerBrutalCrushCD:Stop()
			timerBrutalCrushCD:Update(elapsed, total+extend, self.vb.brutalHungeringCount+1)
		end
	elseif spellId == 434697 then
		self.vb.brutalHungeringCount  = self.vb.brutalHungeringCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBrutalCrush:Show()
			specWarnBrutalCrush:Play("defensive")
		end
		timerBrutalCrushCD:Start(nil, self.vb.brutalHungeringCount+1)
	elseif spellId == 445052 then--Chittering Swarm
		specWarnChitteringSwarm:Show()
		specWarnChitteringSwarm:Play("killmob")
	elseif spellId == 436200 or spellId == 436203 then--First charge, subsiquent ones
		if spellId == 436200 then
			self.vb.webbingChargeCount = 1
			specWarnJuggernautCharge:Show(1)
			specWarnJuggernautCharge:Play("chargemove")
			timerJuggernautChargeCD:Start(4.6, 2)
		else
			self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
			warnJuggernautCharge:Show(self.vb.webbingChargeCount)
			if self.vb.webbingChargeCount < 5 then
				timerJuggernautChargeCD:Start(7.1, self.vb.webbingChargeCount+1)
			end
		end
	elseif spellId == 451412 or spellId == 443842 then--Hard/Easy assumed (hard has knockback, easy does not)
		self.vb.lashdarknessCount = self.vb.lashdarknessCount + 1
		specWarnSwallowingDarkness:Show(self.vb.lashdarknessCount)
		specWarnSwallowingDarkness:Play("watchstep")
	elseif spellId == 438012 then
		self.vb.brutalHungeringCount = self.vb.brutalHungeringCount + 1
		warnHungeringBelows:Show(self.vb.brutalHungeringCount)
		timerHungeringBellowsCD:Start(18, self.vb.brutalHungeringCount+1)
	elseif spellId == 445290 or spellId == 445123 then--Hard/Easy assumed (hard has shorter cast time)
		specWarnHulkingCrash:Show()
		specWarnHulkingCrash:Play("watchstep")
		if self:GetStage(2) then
			self.vb.lashingsCount = self.vb.lashingsCount + 1
			timerHulkingCrashCD:Start(18, self.vb.lashingsCount+1)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 439419 then
		warnStalkerNetting:CombinedShow(1.5, args.destName)
	elseif spellId == 455831 then
		warnHardenedNetting:CombinedShow(0.5, args.destName)
	elseif spellId == 435138 then
		warnDigestiveVenom:CombinedShow(1, args.destName)--Goes out really slow
		if args:IsPlayer() then
			specWarnDigestiveVenom:Show()
			specWarnDigestiveVenom:Play("targetyou")--Request final voice when blizzard finalizes spell name. is it web or is it drool/puddle. this matters
			yellDigestiveVenom:Yell()
		end
	elseif spellId == 434705 then
		if not args:IsPlayer() then
			local uID = DBM:GetUnitIdFromGUID(args.destGUID)
			if self:IsTanking(uID, "boss1") then--Filter non tank spec numpties in front of boss for some reason
				if not DBM:UnitDebuff("player", spellId) then--Double check player didn't also get hit
					specWarnTenderized:Show(args.destName)
					specWarnTenderized:Play("tauntboss")
				end
			end
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 421656 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 441425 and self:GetStage(1) then--Phase Transition None (Fires on both beginning and ending of phase 2)
		self:SetStage(2)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		self.vb.lashingsCount = 0
		timerBrutalLashingsCD:Stop()
		timerStalkersWebbingCD:Stop()
		timerVenomLashCD:Stop()
		timerBrutalCrushCD:Stop()
		timerChitteringSwarmCD:Start(7.6)--Cast only once
		timerJuggernautChargeCD:Start(12.1, 1)--Cast only once (but multi hit so still count timer)
		timerSwallowingDarknessCD:Start(48.3)--Cast only once
		--Technically these can also be started below by 441445
		timerHungeringBellowsCD:Start(59, 1)
		timerHulkingCrashCD:Start(69.9, 1)
--	elseif spellId == 441445 then---Phase Transition P1 -> P2
		--We don't do much with this one. This is when boss switches to cycling Hungering Belows and Hulking Crash
	elseif spellId == 441427 then--Phase Transition P2 -> P1
		self:SetStage(1)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		self.vb.lashingsCount = 0
		timerChitteringSwarmCD:Stop()
		timerJuggernautChargeCD:Stop()
		timerSwallowingDarknessCD:Stop()
		timerHungeringBellowsCD:Stop()
		timerBrutalCrushCD:Start(3, 1)
		timerStalkersWebbingCD:Start(8, 1)
		timerVenomLashCD:Start(14, 1)
		timerBrutalLashingsCD:Start(23, 1)
	end
end
