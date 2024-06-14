local mod	= DBM:NewMod(2601, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(217748)--Needs confirmation, could also use 218510
mod:SetEncounterID(2920)
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20240614000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 436971 437620 448364 438245 439576 440377 453683 442277 435405",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 436870 437343 447169 447174 440576",
	"SPELL_AURA_APPLIED_DOSE 447174 440576",
	"SPELL_AURA_REMOVED 436870 437343 447169 435405"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE: if they don't make ass a private aura, change yells to also include icons
--NOTE: Possibly auto mark phantoms via https://www.wowhead.com/beta/spell=436950/stalking-shadows
--NOTE: Emphasize nether rift? throttle it more?
--NOTE: see if https://www.wowhead.com/beta/spell=438153/twilight-massacre can be target scanned off phantom themselves to defeat the private aura
--TODO: Get the right tank stack swap count
--TODO: Eclipse Timer/alerts? https://www.wowhead.com/beta/spell=434645/eclipse . probelm is it lacks clear CLEU ID, probably using emote/USCS
--TODO, change option keys to match BW for weak aura compatability before live
--[[
(ability.id = 436971 or ability.id = 435405 or ability.id = 437620 or ability.id = 448364 or ability.id = 438245 or ability.id = 439576 or ability.id = 440377 or ability.id = 453683 or ability.id = 442277) and type = "begincast"
 or ability.id = 435405 and type = "removebuff"
--]]
local warnAss									= mod:NewTargetAnnounce(436971, 3)
local warnDeathMasks							= mod:NewCountAnnounce(448364, 4)
local warnChasmalGash							= mod:NewStackAnnounce(440576, 2, nil, "Tank|Healer")
local warnStarlessNight							= mod:NewCountAnnounce(435414, 3)
local warnEternalNight							= mod:NewCastAnnounce(442277, 4)

local specWarnAss								= mod:NewSpecialWarningSpell(436971, nil, nil, nil, 3, 2)
local yellAss									= mod:NewShortYell(436971)
local yellAssFades								= mod:NewShortFadesYell(436971)
local yellQueensBane							= mod:NewShortFadesYell(437343)
local specWarnDeathCloak						= mod:NewSpecialWarningSpell(447174, nil, nil, nil, 2, 2)
local specWarnNetherRift						= mod:NewSpecialWarningDodgeCount(437620, nil, nil, nil, 2, 2)
local specWarnNexusDaggers						= mod:NewSpecialWarningDodgeCount(439576, nil, nil, nil, 2, 2)
local specWarnVoidShredders						= mod:NewSpecialWarningDefensive(440377, nil, nil, nil, 1, 2)
local specWarnChasmalGashStack					= mod:NewSpecialWarningStack(440576, nil, 6, nil, nil, 1, 6)
local specWarnChasmalGashSwap					= mod:NewSpecialWarningTaunt(440576, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerAssCD								= mod:NewCDCountTimer(120, 436971, nil, nil, nil, 3)
local timerDeathMasksCD							= mod:NewAITimer(49, 448364, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerTwilightMassacreCD					= mod:NewCDCountTimer(30, 438245, nil, nil, nil, 3)
local timerNetherRiftCD							= mod:NewCDCountTimer(30, 437620, nil, nil, nil, 3)
local timerNexusDaggersCD						= mod:NewCDCountTimer(30, 439576, nil, nil, nil, 3)
local timerVoidShreddersCD						= mod:NewCDCountTimer(30, 440377, nil, "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerStarlessNightCD						= mod:NewCDCountTimer(120, 435405, nil, nil, nil, 6)
local timerStarlessNight						= mod:NewBuffActiveTimer(24, 435405, nil, nil, nil, 5)

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnAss", 436971, true, 0, {1, 2, 3, 4, 5})--Applies to 3, 4 or 5 targets based on difficultiy or raid size
mod:AddNamePlateOption("NPOnMask", 448364)
mod:AddPrivateAuraSoundOption(438141, true, 438245, 1)--Twilight Massacre Target
mod:AddPrivateAuraSoundOption(436671, true, 435486, 1)--Regicide Targets
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.assCount = 0
mod.vb.assIcon = 1
mod.vb.maskCount = 0
mod.vb.massacreCount = 0
mod.vb.riftCount = 0
mod.vb.daggersCount = 0
mod.vb.shredderCount = 0
mod.vb.starlessCount = 0

function mod:OnCombatStart(delay)
	self.vb.assCount = 0
	self.vb.maskCount = 0
	self.vb.massacreCount = 0
	self.vb.riftCount = 0
	self.vb.daggersCount = 0
	self.vb.shredderCount = 0
	self.vb.starlessCount = 0
	self:SetStage(1)
	timerAssCD:Start(13.3, 1)
	timerTwilightMassacreCD:Start(34, 1)
	timerNetherRiftCD:Start(22.3, 1)
	timerVoidShreddersCD:Start(40, 1)
	timerNexusDaggersCD:Start(46, 1)
	timerStarlessNightCD:Start(86, 1)
	self:EnablePrivateAuraSound(438141, "runout", 2)--Twilight Massacre
	self:EnablePrivateAuraSound(436671, "lineyou", 17)--Regicide
	self:EnablePrivateAuraSound(436664, "lineyou", 17, 436671)--Regicide
	self:EnablePrivateAuraSound(436677, "lineyou", 17, 436671)--Regicide
	self:EnablePrivateAuraSound(436665, "lineyou", 17, 436671)--Regicide
	self:EnablePrivateAuraSound(436663, "lineyou", 17, 436671)--Regicide
	self:EnablePrivateAuraSound(436666, "lineyou", 17, 436671)--Regicide
	self:EnablePrivateAuraSound(435534, "lineyou", 17, 436671)--Regicide
	if self:IsMythic() then
		timerDeathMasksCD:Start(1)
		if self.Options.NPOnMask then
			DBM:FireEvent("BossMod_EnableHostileNameplates")
		end
	end
end

function mod:OnCombatEnd()
	if self:IsMythic() and self.Options.NPOnMask then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 436971 then
		self.vb.assCount = self.vb.assCount + 1
		self.vb.assIcon = 1
	elseif spellId == 437620 then
		if self:AntiSpam(5, 1) then
			self.vb.riftCount = self.vb.riftCount + 1
			if self.vb.riftCount == 1 then
				timerNetherRiftCD:Start(30, 2)
			end
			specWarnNetherRift:Show(self.vb.riftCount)
			specWarnNetherRift:Play("watchstep")
		end
	elseif spellId == 448364 then
		self.vb.maskCount = self.vb.maskCount + 1
		warnDeathMasks:Show(self.vb.maskCount)
		timerDeathMasksCD:Start()
	elseif spellId == 438245 then
		self.vb.massacreCount = self.vb.massacreCount + 1
		if self.vb.massacreCount == 1 then
			timerTwilightMassacreCD:Start(30, 2)
		end
	elseif spellId == 439576 then
		if self:AntiSpam(5, 2) then
			self.vb.daggersCount = self.vb.daggersCount + 1
			if self.vb.daggersCount == 1 then
				timerNexusDaggersCD:Start(30, 2)
			end
			specWarnNexusDaggers:Show(self.vb.daggersCount)
			specWarnNexusDaggers:Play("watchstep")
		end
	elseif spellId == 440377 or spellId == 453683 then
		self.vb.shredderCount = self.vb.shredderCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVoidShredders:Show()
			specWarnVoidShredders:Play("defensive")
		end
		--Sets of 3, except on pull since technically it starts at 2nd of 3 in the rotation
		--So if night at 0, a single 30 second timer after first cast for 2nd and last in rotation
		--if night at 1, it's 11, 34, 30 for the 3 set
		if self.vb.shredderCount == 1 then
			timerVoidShreddersCD:Start(self.vb.starlessCount == 0 and 30 or 34, 2)
		elseif self.vb.starlessCount >= 1 and self.vb.shredderCount == 12 then
			timerVoidShreddersCD:Start(30, 3)
		end
	elseif spellId == 442277 then
		warnEternalNight:Show()
	elseif spellId == 435405 then
		self:SetStage(2)
		timerAssCD:Stop()
		timerTwilightMassacreCD:Stop()
		timerNetherRiftCD:Stop()
		timerNexusDaggersCD:Stop()
		timerDeathMasksCD:Stop()
		timerVoidShreddersCD:Stop()
		self.vb.starlessCount = self.vb.starlessCount + 1
		warnStarlessNight:Show(self.vb.starlessCount)
		timerStarlessNight:Start(29)-- 24 + 5
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
	if spellId == 436870 then
		warnAss:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnAss:Show()
			specWarnAss:Play("targetyou")
			yellAss:Yell()
			yellAssFades:Countdown(spellId, 3)
		end
		if self.Options.SetIconOnAss then
			self:SetIcon(args.destName, self.vb.assIcon)
		end
		self.vb.assIcon = self.vb.assIcon + 1
	elseif spellId == 437343 then
		if args:IsPlayer() then
			yellQueensBane:Countdown(spellId)
		end
	elseif spellId == 447169 then
		if self.Options.NPOnMask then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 447174 then
		local amount = args.amount or 1
		--Only warn death cloak aoe if it's at least 1 million damage per second
		if (amount >= 6) and self:AntiSpam(4, 2) then
			specWarnDeathCloak:Show()
			specWarnDeathCloak:Play("aesoon")
		end
	elseif spellId == 440576 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 then
				if amount >= 6 then--Tuned giga high for now. obviously fix later
					if args:IsPlayer() then
						specWarnChasmalGashStack:Show(amount)
						specWarnChasmalGashStack:Play("stackhigh")
					else
						if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
							specWarnChasmalGashSwap:Show(args.destName)
							specWarnChasmalGashSwap:Play("tauntboss")
						else
							warnChasmalGash:Show(args.destName, amount)
						end
					end
				else
					warnChasmalGash:Show(args.destName, amount)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 436870 then
		if args:IsPlayer() then
			yellAssFades:Cancel()
		end
		if self.Options.SetIconOnAss then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 437343 then
		if args:IsPlayer() then
			yellQueensBane:Cancel()
		end
	elseif spellId == 447169 then
		if self.Options.NPOnMask then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 435405 then
		self:SetStage(1)
--		self.vb.assCount = 0--Doesn't reset, it's linked to returning to phase 1 after starry
		self.vb.maskCount = 0
		self.vb.massacreCount = 0
		self.vb.riftCount = 0
		self.vb.daggersCount = 0
		self.vb.shredderCount = 0
		timerStarlessNight:Stop()
		timerVoidShreddersCD:Start(10.8, 1)
		timerAssCD:Start(18, self.vb.assCount+1)
		timerNetherRiftCD:Start(26.8, 1)
		timerTwilightMassacreCD:Start(38.8, 1)
		timerNexusDaggersCD:Start(50, 1)
		timerStarlessNightCD:Start(90, self.vb.starlessCount+1)
		if self:IsMythic() then
			timerDeathMasksCD:Start(2)
		end
	end
end

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
	if cid == 218429 or cid == 218265 then--Nether Phantom

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 426144 then

	end
end
--]]
