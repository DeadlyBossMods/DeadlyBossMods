local mod	= DBM:NewMod(2527, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201579)
mod:SetEncounterID(2683)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230324000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 408358 402989 403740 403671 409093 402344 404846",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 408839 407879 408955 402994",
	"SPELL_AURA_APPLIED_DOSE 408839 408955",
	"SPELL_AURA_REMOVED 408839 407879 402994"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, dynamic energy calculation for accurate Catastrophic timer. Since energy rate changes based on puddles this would have to be a near constant check
--TODO, fine tune personal stack alerts
--TODO, nani? https://www.wowhead.com/ptr/spell=401522/incinerating-maws
local warnMoltenSpittle								= mod:NewTargetCountAnnounce(402989, 2)
local warnIncineratingMaws							= mod:NewStackAnnounce(404846, 2, nil, "Tank|Healer")

local specWarnCatastrophicEruption					= mod:NewSpecialWarningSpell(408358, nil, nil, nil, 3, 2)
local specWarnHeatStacks							= mod:NewSpecialWarningStack(408839, nil, 12, nil, nil, 1, 6)
local specWarnBlazingTantrum						= mod:NewSpecialWarningMove(407879, "Tank", nil, nil, 1, 2)
local specWarnIgnitingRoar							= mod:NewSpecialWarningCount(403740, nil, nil, nil, 2, 2)
local specWarnOverpoweringStomp						= mod:NewSpecialWarningCount(403671, nil, nil, nil, 2, 2)
local specWarnMoltenSpittle							= mod:NewSpecialWarningYou(402989, nil, nil, nil, 1, 2)
local yellMoltenSpittle								= mod:NewShortPosYell(402989)
local yellMoltenSpittleFades						= mod:NewIconFadesYell(402989)
local specWarnBlazingBreath							= mod:NewSpecialWarningDodge(409238, nil, nil, nil, 2, 2)
local specWarnIncineratingMaws						= mod:NewSpecialWarningStack(404846, nil, 2, nil, nil, 1, 6)
local specWarnIncineratingMawsSwap					= mod:NewSpecialWarningTaunt(404846, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

--local timerCatastrophicCD							= mod:NewAITimer(28.9, 408358, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerMoltenSpittleCD							= mod:NewAITimer(29.9, 402989, nil, nil, nil, 3)
local timerIngitingRoarCD							= mod:NewAITimer(28.9, 403740, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerOverpoweringStompCD						= mod:NewAITimer(28.9, 403671, nil, nil, nil, 2)
local timerBlazingBreathCD							= mod:NewAITimer(29.9, 409238, nil, nil, nil, 3)
local timerIncineratingMawsCD						= mod:NewAITimer(28.9, 404846, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(408839, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnMoltenSpittle", 402989, true, 0, {1, 2, 3})
mod:AddNamePlateOption("NPAuraOnTantrum", 407879)
--mod:GroupSpells(390715, 396094)

local heatStacks = {}
mod.vb.spitCount = 0
mod.vb.roarCount = 0
mod.vb.stompCount = 0
mod.vb.breathCount = 0
mod.vb.riftIcon = 1

function mod:OnCombatStart(delay)
	table.wipe(heatStacks)
	self.vb.spitCount = 0
	self.vb.roarCount = 0
	self.vb.stompCount = 0
	self.vb.breathCount = 0
	self.vb.riftIcon = 1
	timerMoltenSpittleCD:Start(1-delay)
	timerIngitingRoarCD:Start(1-delay)
	timerOverpoweringStompCD:Start(1-delay)
	timerBlazingBreathCD:Start(1-delay)
	timerIncineratingMawsCD:Start(1-delay)
	if self.Options.NPAuraOnTantrum then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(408839))
		DBM.InfoFrame:Show(30, "table", heatStacks, 1)
	end
end

function mod:OnCombatEnd()
	table.wipe(heatStacks)
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnTantrum then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 408358 then
		specWarnCatastrophicEruption:Show()
		specWarnCatastrophicEruption:Play("stilldanger")
	elseif spellId == 402989 then
		self.vb.spitCount = self.vb.spitCount + 1
		self.vb.riftIcon = 1
		warnMoltenSpittle:Show(self.vb.spitCount)
		timerMoltenSpittleCD:Start()
	elseif spellId == 403740 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnIgnitingRoar:Show(self.vb.roarCount)
		specWarnIgnitingRoar:Play("aesoon")
		timerIngitingRoarCD:Start()
	elseif spellId == 403671 then
		self.vb.stompCount = self.vb.stompCount + 1
		specWarnOverpoweringStomp:Show(self.vb.stompCount)
		specWarnOverpoweringStomp:Play("carefly")
		timerOverpoweringStompCD:Start()
	elseif spellId == 409093 or spellId == 402344 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnBlazingBreath:Show(self.vb.breathCount)
		specWarnBlazingBreath:Play("breathsoon")
		timerBlazingBreathCD:Start()
	elseif spellId == 404846 then
		timerIncineratingMawsCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 408839 then
		local amount = args.amount or 1
		heatStacks[args.destName] = amount
		if args:IsPlayer() and (amount >= 12 and amount % 3 == 0) then--12, 15, 18, 21
			specWarnHeatStacks:Show(amount)
			specWarnHeatStacks:Play("stackhigh")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(heatStacks)
		end
	elseif spellId == 407879 then
		if self:AntiSpam(3, 1) then
			specWarnBlazingTantrum:Show()
			specWarnBlazingTantrum:Play("moveboss")
		end
		if self.Options.NPAuraOnTantrum then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 408955 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnIncineratingMaws:Show(amount)
				specWarnIncineratingMaws:Play("stackhigh")
			else
				if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
					specWarnIncineratingMawsSwap:Show(args.destName)
					specWarnIncineratingMawsSwap:Play("tauntboss")
				else
					warnIncineratingMaws:Show(args.destName, amount)
				end
			end
		else
			warnIncineratingMaws:Show(args.destName, amount)
		end
	elseif spellId == 402994 then
		local icon = self.vb.riftIcon
		if self.Options.SetIconOnMoltenSpittle then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnMoltenSpittle:Show()
			specWarnMoltenSpittle:Play("targetyou")
			yellMoltenSpittle:Yell(icon, icon)
			yellMoltenSpittleFades:Countdown(spellId, nil, icon)
		end
		warnMoltenSpittle:CombinedShow(0.3, self.vb.spitCount, args.destName)
		self.vb.riftIcon = self.vb.riftIcon + 1
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 408839 then
		heatStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(heatStacks)
		end
	elseif spellId == 407879 then
		if self.Options.NPAuraOnTantrum then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 402994 then
		if self.Options.SetIconOnMoltenSpittle then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellMoltenSpittleFades:Cancel()
		end
	end
end


--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 199233 then

	end
end
--]]

--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
