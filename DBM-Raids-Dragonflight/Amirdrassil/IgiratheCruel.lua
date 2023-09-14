local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2554, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(206689)
mod:SetEncounterID(2709)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20210126000000)
--mod:SetMinSyncRevision(20210126000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 414425 416996 422776 419048 416048 415624",
	"SPELL_CAST_SUCCESS 424456",
	"SPELL_AURA_APPLIED 414340 414888 414367 419462",
	"SPELL_AURA_APPLIED_DOSE 414340",
	"SPELL_AURA_REMOVED 415623"
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, detect which powers boss has for starting correct timers after mark of torment
--TODO, secondary warning for https://wowhead.com/ptr-2/spell=424347 ?
--TODO, watch orb alert for https://www.wowhead.com/ptr-2/spell=426056/vital-rupture on removal of heart stoppers?
local warnDrenchedBlades							= mod:NewStackAnnounce(414340, 2, nil, "Tank|Healer")
local warnBlisteringSpear							= mod:NewTargetCountAnnounce(414425, 3, nil, nil, nil, nil, nil, nil, true)
local warnMarkedforTorment							= mod:NewCountAnnounce(422776, 3)
local warnGatheringTorment							= mod:NewYouAnnounce(414367, 4)
local warnSmashingViscera							= mod:NewTargetNoFilterAnnounce(424456, 3)
local warnHeartStopper								= mod:NewTargetCountAnnounce(415624, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnDrenchedBlades						= mod:NewSpecialWarningTaunt(414340, nil, nil, nil, 1, 2)
local specWarnBlisteringSpear						= mod:NewSpecialWarningYou(414425, nil, nil, nil, 1, 2)
local yellBlisteringSpear							= mod:NewShortPosYell(414425)
local specWarnTwistedBlade							= mod:NewSpecialWarningDodgeCount(416996, nil, nil, nil, 2, 2)
local specWarnFleshMortification					= mod:NewSpecialWarningYou(419462, nil, nil, nil, 1, 2)
local specWarnRuinousEnd							= mod:NewSpecialWarningSpell(419048, nil, nil, nil, 3, 2)
--Torments
local specWarnWrackingSkewer						= mod:NewSpecialWarningCount(416048, nil, nil, nil, 2, 2)
local specWarnSmashingViscera						= mod:NewSpecialWarningYou(424456, nil, nil, nil, 1, 2)
local yellSmashingViscera							= mod:NewShortYell(424456)
local specWarnHeartStopper							= mod:NewSpecialWarningYou(415624, nil, nil, nil, 1, 2)
local yellHeartStopperFades							= mod:NewIconFadesYell(415624)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerBlisteringSpearCD						= mod:NewAITimer(49, 414425, nil, nil, nil, 3)
local timerTwistedBladeCD							= mod:NewAITimer(49, 416996, nil, nil, nil, 3)
local timerMarkedforTormentCD						= mod:NewAITimer(49, 422776, nil, nil, nil, 6)
--local timerSpreadshotCD							= mod:NewAITimer(11.8, 334404, nil, nil, nil, 2, nil, DBM_COMMON_L.TANK_ICON)
--Torments
local timerWrackingSkewerCD							= mod:NewAITimer(49, 416048, nil, nil, nil, 5)
local timerSmashingVisceraCD						= mod:NewAITimer(49, 424456, nil, nil, nil, 3)
local timerHeartStopperCD							= mod:NewAITimer(49, 415624, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnBlisteringSpear", 414425, false, false, {1, 2, 3, 4, 5, 6})
mod:AddSetIconOption("SetIconOnHeartStopper", 415624, true, false, {1, 2, 3, 4, 5, 6})

mod.vb.spearCount = 0
mod.vb.spearIcon = 1
mod.vb.twistedCount = 0
mod.vb.tormentCount = 0
--Toremnts
mod.vb.wrackingCount = 0
mod.vb.heartCount = 0
mod.vb.heartIcon = 1
mod.vb.smashingCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.spearCount = 0
	self.vb.spearIcon = 1
	self.vb.twistedCount = 0
	self.vb.tormentCount = 0
	timerBlisteringSpearCD:Start(1-delay)
	timerTwistedBladeCD:Start(1-delay)
	timerMarkedforTormentCD:Start(1-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 414425 then
		self.vb.spearCount = self.vb.spearCount + 1
		self.vb.spearIcon = 1
		timerBlisteringSpearCD:Start()
	elseif spellId == 416996 then
		self.vb.twistedCount = self.vb.twistedCount + 1
		specWarnTwistedBlade:Show(self.vb.twistedCount)
		specWarnTwistedBlade:Play("watchstep")
		timerTwistedBladeCD:Start()
	elseif spellId == 422776 then
		self.vb.tormentCount = self.vb.tormentCount + 1
		warnMarkedforTorment:Show(self.vb.tormentCount)
		self:SetStage(self.vb.tormentCount)--Matching BW behavior which is kinda meh, but WA parity and all

		self.vb.spearCount = 0
		self.vb.twistedCount = 0
		--Toremnts
		self.vb.wrackingCount = 0
		self.vb.heartCount = 0
		self.vb.smashingCount = 0
		--timerWrackingSkewerCD:Start(2)
		--timerSmashingVisceraCD:Start(2)
		--timerHeartStopperCD:Start(2)
	elseif spellId == 419048 then
		specWarnRuinousEnd:Show()
		specWarnRuinousEnd:Play("aesoon")
	elseif spellId == 416048 then
		self.vb.wrackingCount = self.vb.wrackingCount + 1
		specWarnWrackingSkewer:Show()
		specWarnWrackingSkewer:Play("specialsoon")--Vague voice instead of backseating til more time to review strategies
		timerWrackingSkewerCD:Start()
	elseif spellId == 415624 then
		self.vb.heartCount = self.vb.heartCount + 1
		self.vb.heartIcon = 1
		timerHeartStopperCD:Start()
	end
end
--]]

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 424456 then
		self.vb.smashingCount = self.vb.smashingCount + 1
--		timerSmashingVisceraCD:Start()--AI timer won't work here if she leaps multiple times
		if args:IsPlayer() then
			specWarnSmashingViscera:Show()
			specWarnSmashingViscera:Play("runout")
			yellSmashingViscera:Yell()
		else
			warnSmashingViscera:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 414340 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 or amount > 6 then--Placeholder until review
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnDrenchedBlades:Show(args.destName)
					specWarnDrenchedBlades:Play("tauntboss")
				else
					warnDrenchedBlades:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 414888 then
		local icon = self.vb.spearIcon
		if self.Options.SetIconOnBlisteringSpear then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlisteringSpear:Show()
			specWarnBlisteringSpear:Play("targetyou")
			yellBlisteringSpear:Yell(icon, icon)
		end
		warnBlisteringSpear:CombinedShow(0.5, self.vb.spearCount, args.destName)
		self.vb.spearIcon = self.vb.spearIcon + 1
	elseif spellId == 414367 and args:IsPlayer() then
		warnGatheringTorment:Show()
	elseif spellId == 419462 and args:IsPlayer() then
		specWarnFleshMortification:Show()
		specWarnFleshMortification:Play("otherout")--Still reviewing best sound for this or if new one needed
	elseif spellId == 415623 then
		local icon = self.vb.heartIcon
		if self.Options.SetIconOnHeartStopper then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnHeartStopper:Show()
			specWarnHeartStopper:Play("targetyou")
--			yellHeartStopper:Yell(icon, icon)
			yellHeartStopperFades:Countdown(spellId, nil, icon)
		end
		warnHeartStopper:CombinedShow(0.5, self.vb.heartCount, args.destName)
		self.vb.heartIcon = self.vb.heartIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 414888 then
		if self.Options.SetIconOnBlisteringSpear then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 415623 then
		if self.Options.SetIconOnHeartStopper then
			self:SetIcon(args.destName, 0)
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 409058 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--https://www.wowhead.com/ptr-2/npc=207341/blistering-spear
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165067 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 405814 then

	end
end
--]]
