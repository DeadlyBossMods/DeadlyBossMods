local mod	= DBM:NewMod(2601, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(218425)--Needs confirmation, could also use 218510
mod:SetEncounterID(2920)
mod:SetUsedIcons(1, 2, 3, 4, 5)
--mod:SetHotfixNoticeRev(20231115000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 436971 437620 448364 438245 439576 440377 453683 442277",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 436870 437343 447169 447174 440576 435414",
	"SPELL_AURA_APPLIED_DOSE 447174 440576",
	"SPELL_AURA_REMOVED 436870 437343 447169 435414"
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

local timerAssCD								= mod:NewAITimer(49, 436971, nil, nil, nil, 3)
local timerDeathMasksCD							= mod:NewAITimer(49, 448364, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerTwilightMassacreCD					= mod:NewAITimer(49, 438245, nil, nil, nil, 3)
local timerNetherRiftCD							= mod:NewAITimer(49, 437620, nil, nil, nil, 3)
local timerNexusDaggersCD						= mod:NewAITimer(49, 439576, nil, nil, nil, 3)
local timerVoidShreddersCD						= mod:NewAITimer(49, 440377, nil, "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnAss", 436971, true, 0, {1, 2, 3, 4, 5})--Applies to 3, 4 or 5 targets based on difficultiy or raid size
mod:AddNamePlateOption("NPOnMask", 448364)
mod:AddPrivateAuraSoundOption(438141, true, 438245, 1)--Twilight Massacre Target
mod:AddPrivateAuraSoundOption(436671, true, 435486, 1)--Twilight Massacre Targets
--mod:AddPrivateAuraSoundOption(426010, true, 425885, 4)

mod.vb.assCount = 0
mod.vb.assIcon = 1
mod.vb.maskCount = 0
mod.vb.massacreCount = 0
mod.vb.daggersCount = 0
mod.vb.shredderCount = 0
mod.vb.starlessCount = 0

function mod:OnCombatStart(delay)
	self.vb.assCount = 0
	self.vb.maskCount = 0
	self.vb.massacreCount = 0
	self.vb.daggersCount = 0
	self.vb.shredderCount = 0
	self.vb.starlessCount = 0
	self:SetStage(1)
	timerAssCD:Start()
	timerTwilightMassacreCD:Start(1)
	timerNetherRiftCD:Start(1)
	timerNexusDaggersCD:Start(1)
	self:EnablePrivateAuraSound(438141, "runout", 2)--Twilight Massacre
	self:EnablePrivateAuraSound(436671, "targetyou", 2)--Regicide
	self:EnablePrivateAuraSound(436664, "targetyou", 2, 436671)--Regicide
	self:EnablePrivateAuraSound(436677, "targetyou", 2, 436671)--Regicide
	self:EnablePrivateAuraSound(436665, "targetyou", 2, 436671)--Regicide
	self:EnablePrivateAuraSound(436663, "targetyou", 2, 436671)--Regicide
	self:EnablePrivateAuraSound(436666, "targetyou", 2, 436671)--Regicide
	self:EnablePrivateAuraSound(435534, "targetyou", 2, 436671)--Regicide
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
		timerAssCD:Start()
	elseif spellId == 437620 then
		if args:GetSrcCreatureID() == 218425 then--Boss casting it
			timerNetherRiftCD:Start()
		end
		if self:AntiSpam(5, 1) then
			specWarnNetherRift:Show()
			specWarnNetherRift:Play("watchstep")
		end
	elseif spellId == 448364 then
		self.vb.maskCount = self.vb.maskCount + 1
		warnDeathMasks:Show(self.vb.maskCount)
		timerDeathMasksCD:Start()
	elseif spellId == 438245 then
		self.vb.massacreCount = self.vb.massacreCount + 1
		timerTwilightMassacreCD:Start()
	elseif spellId == 439576 then
		self.vb.daggersCount = self.vb.daggersCount + 1
		if args:GetSrcCreatureID() == 218425 then--Boss casting it
			timerNexusDaggersCD:Start()
		end
		if self:AntiSpam(5, 2) then
			specWarnNexusDaggers:Show()
			specWarnNexusDaggers:Play("watchstep")
		end
	elseif spellId == 440377 or spellId == 453683 then
		self.vb.shredderCount = self.vb.shredderCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVoidShredders:Show()
			specWarnVoidShredders:Play("defensive")
		end
		timerVoidShreddersCD:Start()
	elseif spellId == 442277 then
		warnEternalNight:Show()
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
	elseif spellId == 435414 then
		self:SetStage(2)
		timerAssCD:Stop()
		timerTwilightMassacreCD:Stop()
		timerNetherRiftCD:Stop()
		timerNexusDaggersCD:Stop()
		timerDeathMasksCD:Stop()
		self.vb.starlessCount = self.vb.starlessCount + 1
		warnStarlessNight:Show(self.vb.starlessCount)
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
	elseif spellId == 435414 then
		self:SetStage(1)
		timerAssCD:Start(2)
		timerTwilightMassacreCD:Start(2)
		timerNetherRiftCD:Start(2)
		timerNexusDaggersCD:Start(2)
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
