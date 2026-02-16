local mod	= DBM:NewMod(2601, "DBM-Raids-WarWithin", 3, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(217748)--Needs confirmation, could also use 218510
mod:SetEncounterID(2920)
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20240911000000)
--mod:SetMinSyncRevision(20230929000000)
mod:SetZone(2657)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 436971 437620 438245 439576 440377 453683 442277 435405",
	"SPELL_CAST_SUCCESS 448364",
	"SPELL_AURA_APPLIED 447169 447174 440576 437343",--436870
	"SPELL_AURA_APPLIED_DOSE 447174 440576",
	"SPELL_AURA_REMOVED 447169 435405 437343"--436870
)

--NOTE: They made ass a private aura. Called it :D
--TODO: Get the right tank stack swap count
--TODO, recheck option keys to match BW for weak aura compatability before live
--TODO, verify queensbane is actually hidden, cause they flagged wrong spellids.
--[[
(ability.id = 436971 or ability.id = 435405 or ability.id = 437620 or ability.id = 438245 or ability.id = 439576 or ability.id = 440377 or ability.id = 453683 or ability.id = 442277) and type = "begincast"
or ability.id = 448364 and type = "cast"
or ability.id = 435405 and type = "removebuff"
--]]
local warnAss									= mod:NewIncomingCountAnnounce(436867, 3)
local warnDeathMasks							= mod:NewCountAnnounce(448364, 4)
local warnTwilightMassacre						= mod:NewCountAnnounce(438245, 3, nil, nil, nil, nil, DBM_COMMON_L.CHARGES)
local warnChasmalGash							= mod:NewStackAnnounce(440576, 2, nil, "Tank|Healer", 320007)--Shortname "Gash"
local warnStarlessNight							= mod:NewCountAnnounce(435414, 3)
local warnEternalNight							= mod:NewCastAnnounce(442277, 4)

local specWarnQueensBane						= mod:NewSpecialWarningMoveAway(437343, nil, nil, nil, 1, 2, 3)
local yellQueensBane							= mod:NewShortFadesYell(437343)
local specWarnDeathCloak						= mod:NewSpecialWarningSpell(447174, nil, nil, nil, 2, 2)
local specWarnNetherRift						= mod:NewSpecialWarningDodgeCount(437620, nil, nil, nil, 2, 2)
local specWarnNexusDaggers						= mod:NewSpecialWarningDodgeCount(439576, nil, 1180, nil, 2, 2)
local specWarnVoidShredders						= mod:NewSpecialWarningDefensive(440377, nil, nil, nil, 1, 2)
local specWarnChasmalGashStack					= mod:NewSpecialWarningStack(440576, nil, 8, 320007, nil, 1, 6)
local specWarnChasmalGashSwap					= mod:NewSpecialWarningTaunt(440576, nil, 320007, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerAssCD								= mod:NewCDCountTimer(120, 436867, nil, nil, nil, 3)
local timerOrbsCD								= mod:NewCastTimer(10, 439409, DBM_COMMON_L.ORBS, nil, nil, 3)
local timerDeathMasksCD							= mod:NewCDCountTimer(49, 448364, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerTwilightMassacreCD					= mod:NewCDCountTimer(30, 438245, DBM_COMMON_L.CHARGES.." (%s)", nil, nil, 3)
local timerNetherRiftCD							= mod:NewCDCountTimer(30, 437620, DBM_COMMON_L.RIFT.." (%s)", nil, nil, 3)--shortname Rift
local timerNexusDaggersCD						= mod:NewCDCountTimer(30, 439576, 1180, nil, nil, 3)--Shortname "Daggers"
local timerVoidShreddersCD						= mod:NewCDCountTimer(30, 440377, DBM_COMMON_L.TANKDEBUFF.." (%s)", "Tank|healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerStarlessNightCD						= mod:NewCDCountTimer(120, 435405, nil, nil, nil, 6)--BW note. They localized it as "stage 2" but they don't use a "stages" bar. if they ever change it, object needs to be changed to NewStageCountCycleTimer for WA compat to remain
local timerStarlessNight						= mod:NewBuffActiveTimer(24, 435405, nil, nil, nil, 5)

mod:AddNamePlateOption("NPOnMask", 448364)
mod:AddPrivateAuraSoundOption(438141, true, 438245, 1)--Twilight Massacre Target
mod:AddPrivateAuraSoundOption(436671, true, 435486, 1)--Regicide Targets
mod:AddPrivateAuraSoundOption(436870, true, 436867, 1)--Assassination Targets

mod.vb.assCount = 0
mod.vb.assIcon = 1
mod.vb.maskCount = 0
mod.vb.massacreCount = 0
mod.vb.riftCount = 0
mod.vb.daggersCount = 0
mod.vb.shredderCount = 0
mod.vb.starlessCount = 0
mod.vb.expectedOrbs = 0

function mod:OnCombatStart(delay)
	self.vb.assCount = 0
	self.vb.maskCount = 0
	self.vb.massacreCount = 0
	self.vb.riftCount = 0
	self.vb.daggersCount = 0
	self.vb.shredderCount = 0
	self.vb.starlessCount = 0
	self.vb.expectedOrbs = 0
	self:SetStage(1)
	timerVoidShreddersCD:Start(10, 1)
	timerAssCD:Start(13.2, 1)
	timerNetherRiftCD:Start(22, 1)
	timerTwilightMassacreCD:Start(34, 1)
	timerNexusDaggersCD:Start(45.2, 1)
	timerStarlessNightCD:Start(96, 1)
	self:EnablePrivateAuraSound(438141, "runout", 2)--Twilight Massacre
	self:EnablePrivateAuraSound({436671,436664,436677,436665,436663,436666,435534}, "lineyou", 17)--Regicide
	self:EnablePrivateAuraSound(436870, "runout", 2)--Assassination
	if self:IsHard() then--Only has spread on heroic and mythic
		self:EnablePrivateAuraSound({437343,463273,463276}, "runout", 2)--Queen's bane
	end
	if self:IsMythic() then
		timerDeathMasksCD:Start(18.9, 1)
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
		warnAss:Show(self.vb.assCount)
		self.vb.assIcon = 1
	elseif spellId == 437620 then
		if self:AntiSpam(5, 1) then
			self.vb.riftCount = self.vb.riftCount + 1
			if self.vb.riftCount % 3 ~= 0 then--Sets of 3 between each night
				timerNetherRiftCD:Start(30, self.vb.riftCount+1)
			end
			specWarnNetherRift:Show(self.vb.riftCount)
			specWarnNetherRift:Play("watchstep")
		end
	elseif spellId == 438245 then
		self.vb.massacreCount = self.vb.massacreCount + 1
		warnTwilightMassacre:Show(self.vb.massacreCount)
		if self.vb.massacreCount % 2 == 1 then
			timerTwilightMassacreCD:Start(30, 2)
		end
	elseif spellId == 439576 then
		if self:AntiSpam(5, 2) then
			self.vb.daggersCount = self.vb.daggersCount + 1
			if self.vb.daggersCount % 2 == 1 then
				timerNexusDaggersCD:Start(30, 2)
			end
			specWarnNexusDaggers:Show(self.vb.daggersCount)
			specWarnNexusDaggers:Play("farfromline")
		end
	elseif spellId == 440377 or spellId == 453683 then
		self.vb.shredderCount = self.vb.shredderCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVoidShredders:Show()
			specWarnVoidShredders:Play("defensive")
		end
		if self.vb.shredderCount % 3 ~= 0 then--Sets of 3 between each night
			timerVoidShreddersCD:Start(30, self.vb.shredderCount+1)
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

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 448364 then
		self.vb.maskCount = self.vb.maskCount + 1
		warnDeathMasks:Show(self.vb.maskCount)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 447169 then
		if self.Options.NPOnMask then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 437343 then
		if self:IsHard() and self:AntiSpam() then
			timerOrbsCD:Start()
		end
		if args:IsPlayer() and not self:IsEasy() then
			specWarnQueensBane:Show()
			specWarnQueensBane:Play("runout")
			yellQueensBane:Countdown(spellId)
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
			--Applies 4 stacks at a time (then just refreshes after that)
			--so this should effectively warn once per cast
			if amount % 4 == 0 then
				if args:IsPlayer() then--This basically can swap every 1-2 stacks based on it's cooldown.
					if amount >= 8 then
						specWarnChasmalGashStack:Show(amount)
						specWarnChasmalGashStack:Play("stackhigh")
					else
						warnChasmalGash:Show(args.destName, amount)
					end
				else
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if (not remaining or remaining and remaining < 30) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
						specWarnChasmalGashSwap:Show(args.destName)
						specWarnChasmalGashSwap:Play("tauntboss")
					else
						warnChasmalGash:Show(args.destName, amount)
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 447169 then
		if self.Options.NPOnMask then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 437343 then
		if args:IsPlayer() then
			yellQueensBane:Cancel()
		end
	elseif spellId == 435405 then
		self:SetStage(1)
		timerStarlessNight:Stop()
		timerVoidShreddersCD:Start(14.8, self.vb.shredderCount+1)--FIXME
		timerAssCD:Start(18.1, self.vb.assCount+1)
		timerNetherRiftCD:Start(26.8, self.vb.riftCount+1)
		timerTwilightMassacreCD:Start(38.8, self.vb.massacreCount+1)
		timerNexusDaggersCD:Start(50, self.vb.daggersCount+1)
		timerStarlessNightCD:Start(100, self.vb.starlessCount+1)
		if self:IsMythic() then
			timerDeathMasksCD:Start(23.8, self.vb.maskCount+1)
		end
	end
end
