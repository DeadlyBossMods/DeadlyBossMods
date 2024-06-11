local mod	= DBM:NewMod(2607, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(215657)--VERIFY
mod:SetEncounterID(2902)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20231115000000)
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
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
	"UNIT_POWER_UPDATE boss1"
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
--Gleeful Brutality
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30011))
local warnStalkerNetting						= mod:NewTargetAnnounce(439419, 3)--Non Mythic
local warnHardenedNetting						= mod:NewTargetAnnounce(439419, 3)--Mythic
local warnVenomLash								= mod:NewCountAnnounce(441451, 3)
local warnDigestiveVenom						= mod:NewTargetAnnounce(435138, 3)
local warnHungeringBelows						= mod:NewCountAnnounce(438012, 3)

local specWarnBrutalLashings					= mod:NewSpecialWarningCount(434776, nil, nil, nil, 2, 2)
local specWarnStalkersWebbing					= mod:NewSpecialWarningDodgeCount(441451, nil, nil, nil, 2, 2)--aka Viscous Slobber apparently
local specWarnDigestiveVenom					= mod:NewSpecialWarningYou(435138, nil, nil, nil, 1, 2)
local yellDigestiveVenom						= mod:NewShortYell(435138)
local specWarnBrutalCrush						= mod:NewSpecialWarningDefensive(434697, nil, nil, nil, 1, 2)
local specWarnTenderized						= mod:NewSpecialWarningTaunt(434705, nil, nil, nil, 1, 2)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerBrutalLashingsCD						= mod:NewAITimer(49, 434776, nil, nil, nil, 3)
local timerStalkersWebbingCD					= mod:NewAITimer(49, 441451, nil, nil, nil, 3)
local timerVenomLashCD							= mod:NewAITimer(49, 435136, nil, nil, nil, 2)
local timerBrutalCrushCD						= mod:NewAITimer(49, 434697, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Feeding Frenzy
mod:AddTimerLine(DBM:EJ_GetSectionInfo(28845))
local specWarnChitteringSwarm					= mod:NewSpecialWarningSwitch(445052, nil, nil, nil, 1, 2)
local specWarnJuggernautCharge					= mod:NewSpecialWarningDodgeCount(436203, nil, nil, nil, 2, 2)
local specWarnSwallowingDarkness				= mod:NewSpecialWarningDodgeCount(451412, nil, nil, nil, 2, 2)
local specWarnHulkingCrash						= mod:NewSpecialWarningDodge(445290, nil, nil, nil, 2, 2)

local timerChitteringSwarmCD					= mod:NewAITimer(49, 445052, nil, nil, nil, 1)
local timerJuggernautChargeCD					= mod:NewAITimer(49, 436203, nil, nil, nil, 3)
local timerSwallowingDarknessCD					= mod:NewAITimer(49, 451412, nil, nil, nil, 3)
local timerHungeringBellowsCD					= mod:NewAITimer(49, 438012, nil, nil, nil, 2)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnAdds", 335114, true, 0, {1, 2, 3})
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.lashingsCount = 0
mod.vb.webbingChargeCount = 0--Abilities that leave webbing/Netting (Stalkers Webbing and Juggernaut
mod.vb.lashdarknessCount = 0--Abilities that remove webbing/netting (Venomous Lash and Swallowing Darkness)
mod.vb.brutalHungeringCount = 0--Abilities for tank/healer (Brutal Crush and Hungering Bellows)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.lashingsCount = 0
	self.vb.webbingChargeCount = 0
	self.vb.lashdarknessCount = 0
	self.vb.brutalHungeringCount = 0
	timerBrutalLashingsCD:Start(1)
	timerStalkersWebbingCD:Start(1)
	timerVenomLashCD:Start(1)
	timerBrutalCrushCD:Start(1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 434803 then
		self.vb.lashingsCount = self.vb.lashingsCount + 1
		specWarnBrutalLashings:Show()
		specWarnBrutalLashings:Play("gathershare")
		timerBrutalLashingsCD:Start()
	elseif spellId == 441451 or spellId == 441452 then
		self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
		specWarnStalkersWebbing:Show(self.vb.webbingChargeCount)
		specWarnStalkersWebbing:Play("watchstep")
		timerStalkersWebbingCD:Start()
	elseif spellId == 435136 then
		self.vb.lashdarknessCount = self.vb.lashdarknessCount + 1
		warnVenomLash:Show(self.vb.lashdarknessCount)
		timerVenomLashCD:Start()
	elseif spellId == 434697 then
		self.vb.brutalHungeringCount  = self.vb.brutalHungeringCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBrutalCrush:Show()
			specWarnBrutalCrush:Play("defensive")
		end
		timerBrutalCrushCD:Start()
	elseif spellId == 445052 then--Chittering Swarm
		specWarnChitteringSwarm:Show()
		specWarnChitteringSwarm:Play("killmob")
		timerChitteringSwarmCD:Start()
	elseif spellId == 436203 or spellId == 436200 then
		self.vb.webbingChargeCount = self.vb.webbingChargeCount + 1
		specWarnJuggernautCharge:Show()
		specWarnJuggernautCharge:Play("chargemove")
		timerJuggernautChargeCD:Start()
	elseif spellId == 451412 or spellId == 443842 then--Hard/Easy assumed (hard has knockback, easy does not)
		self.vb.lashdarknessCount = self.vb.lashdarknessCount + 1
		specWarnSwallowingDarkness:Show()
		specWarnSwallowingDarkness:Play("watchstep")
		timerSwallowingDarknessCD:Start()
	elseif spellId == 438012 then
		self.vb.brutalHungeringCount = self.vb.brutalHungeringCount + 1
		warnHungeringBelows:Show()
		timerHungeringBellowsCD:Start()
	elseif spellId == 445290 or spellId == 445123 then--Hard/Easy assumed (hard has shorter cast time)
		specWarnHulkingCrash:Show()
		specWarnHulkingCrash:Play("watchstep")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 422277 then

	end
end
--]]

--[[
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 449598 then--Ravenous Spawn
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnAdds")
		end
	elseif spellId == 457281 then--Bile-Soaked Spawn
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnAdds")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 439419 then
		warnStalkerNetting:CombinedShow(0.5, args.destName)
	elseif spellId == 455831 then
		warnHardenedNetting:CombinedShow(0.5, args.destName)
	elseif spellId == 435138 then
		warnDigestiveVenom:CombinedShow(0.5, args.destName)
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

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 216205 then--https://www.wowhead.com/beta/npc=216205/ravenous-spawn

	elseif cid == 227300 then--https://www.wowhead.com/beta/npc=227300/bile-soaked-spawn

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]

--TEMPORARY phasing (unless this ends up being only way)
function mod:UNIT_POWER_UPDATE(uId)
	local powerLevel = UnitPower(uId)
	if powerLevel == 100 and self:GetStage(2) then
		self:SetStage(1)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		timerChitteringSwarmCD:Stop()
		timerJuggernautChargeCD:Stop()
		timerSwallowingDarknessCD:Stop()
		timerHungeringBellowsCD:Stop()
		timerBrutalLashingsCD:Start(2)
		timerStalkersWebbingCD:Start(2)
		timerVenomLashCD:Start(2)
		timerBrutalCrushCD:Start(2)
	elseif powerLevel == 0 and self:GetStage(1) then
		self:SetStage(2)
		self.vb.lashdarknessCount = 0
		self.vb.webbingChargeCount = 0
		self.vb.brutalHungeringCount = 0
		timerBrutalLashingsCD:Stop()
		timerStalkersWebbingCD:Stop()
		timerVenomLashCD:Stop()
		timerBrutalCrushCD:Stop()
		timerChitteringSwarmCD:Start(2)
		timerJuggernautChargeCD:Start(2)
		timerSwallowingDarknessCD:Start(2)
		timerHungeringBellowsCD:Start(2)
	end
end
