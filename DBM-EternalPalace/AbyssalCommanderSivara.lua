local mod	= DBM:NewMod(2352, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(151881)
mod:SetEncounterID(2298)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 294726 295332 296551 298122 295791",
	"SPELL_CAST_SUCCESS 295346",
	"SPELL_AURA_APPLIED 294711 294715 295795 295796 300701 300705 295348 300961 300962",
	"SPELL_AURA_APPLIED_DOSE 294711 294715 300701 300705",
	"SPELL_AURA_REMOVED 294711 294715 295348"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
)

--TODO, chimeric marks special warnig? it goes out on pull so might be redundant
--TODO, request voice pack authors add "frost mark" and "toxic mark"
--TODO< fix tank swap code when debuff ID implimented
--TODO, improve DBM when strats formulate for boss on how to handle tank stacks
--TODO, add frostshock Bolts?
--local warnPoweringDown					= mod:NewSpellAnnounce(271965, 2, nil, nil, nil, nil, nil, 2)
local warnChimericMarks					= mod:NewSpellAnnounce(294726, 4)
local warnRimefrost						= mod:NewStackAnnounce(300701, 2, nil, "Tank")
local warnSepticTaint					= mod:NewStackAnnounce(300705, 2, nil, "Tank")
local warnOverflowingChill				= mod:NewTargetAnnounce(295348, 3)
local warnOverflowingVenom				= mod:NewTargetAnnounce(295421, 3)

local specWarnFrostMark					= mod:NewSpecialWarningYouPos(294711, nil, nil, nil, 1, 9)
local specWarnToxicMark					= mod:NewSpecialWarningYouPos(294715, nil, nil, nil, 1, 9)
local yellMark							= mod:NewPosYell(294726, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, false)
local specWarnFrozenBlood				= mod:NewSpecialWarningKeepMove(295795, nil, nil, nil, 1, 2)
local specWarnVenomousBlood				= mod:NewSpecialWarningStopMove(295796, nil, nil, nil, 1, 2)
local specWarnCrushingReverb			= mod:NewSpecialWarningDefensive(295332, nil, nil, nil, 1, 2)
--local specWarnCrushingReverbTaunt		= mod:NewSpecialWarningTaunt(295332, nil, nil, nil, 1, 2)
local specWarnOverwhelmingBarrage		= mod:NewSpecialWarningSpell(296551, nil, nil, nil, 2, 2)
local specWarnOverflowingChill			= mod:NewSpecialWarningMoveAway(295348, nil, nil, nil, 1, 2)
local yellOverflowingChill				= mod:NewYell(295348)
local yellOverflowingChillFades			= mod:NewShortFadesYell(295348)
local specWarnOverflowingVenom			= mod:NewSpecialWarningMoveAway(295421, nil, nil, nil, 1, 2)
local yellOverflowingVenom				= mod:NewYell(295421)
local yellOverflowingVenomFades			= mod:NewShortFadesYell(295421)
local specWarnInversion					= mod:NewSpecialWarningSpell(295791, nil, nil, nil, 3, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(300961, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--local timerPlasmaDischargeCD			= mod:NewAITimer(30.4, 271225, nil, nil, nil, 3)--30.4-42
local timerCrushingReverbCD				= mod:NewAITimer(58.2, 295332, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerOverwhelmingBarrageCD		= mod:NewAITimer(58.2, 296551, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
local timerOverflowCD					= mod:NewAITimer(58.2, 295346, nil, nil, nil, 3)
local timerInversionCD					= mod:NewAITimer(58.2, 295791, nil, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON)
local timerChimericMarksCD				= mod:NewAITimer(58.2, 294726, nil, nil, nil, 2)--Mythic

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCudgelofGore				= mod:NewCountdown(58, 271296)
--local countdownEnlargedHeart			= mod:NewCountdown("Alt60", 275205, true, 2)

mod:AddSetIconOption("SetIconOnMarks", 294726, true)
mod:AddInfoFrameOption(294726, true)

--mod.vb.phase = 1
local MarksStacks = {}

function mod:OnCombatStart(delay)
	table.wipe(MarksStacks)
	timerCrushingReverbCD:Start(1-delay)
	timerOverwhelmingBarrageCD:Start(1-delay)
	timerOverflowCD:Start(1-delay)
	if self:IsHard() then
		timerInversionCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(294726))
		DBM.InfoFrame:Show(10, "table", MarksStacks, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 294726 then
		warnChimericMarks:Show()
		timerChimericMarksCD:Start()
	elseif spellId == 295332 then
		if UnitDetailedThreatSituation("player", "boss1") then
			specWarnCrushingReverb:Show()
			specWarnCrushingReverb:Play("defensive")
		end
		timerCrushingReverbCD:Start()
	elseif spellId == 296551 or spellId == 298122 then
		specWarnOverwhelmingBarrage:Show()
		specWarnOverwhelmingBarrage:Play("aesoon")
		timerOverwhelmingBarrageCD:Start()
	elseif spellId == 295791 then
		specWarnInversion:Show()
		specWarnInversion:Play("scatter")
		timerInversionCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 295346 then
		timerOverflowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 294711 or spellId == 294715 then--Frost left, Toxic right
		local amount = args.amount or 1
		MarksStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(MarksStacks)
		end
		if args:IsPlayer() then
			if spellId == 294711 then--Frost
				specWarnFrostMark:Show(self:IconNumToTexture(6))
				specWarnFrostMark:Play("frostmark")
				yellMark:Yell(6, "", 6)--Square
			else--Toxic
				specWarnToxicMark:Show(self:IconNumToTexture(3))
				specWarnToxicMark:Play("toxicmark")
				yellMark:Yell(3, "", 3)--Triangle
			end
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if self.Options.SetIconOnMarks and self:IsTanking(uId) then
			if spellId == 294711 then--Frost
				self:SetIcon(args.destName, 6)
			else
				self:SetIcon(args.destName, 3)
			end
		end
	elseif spellId == 295795 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnFrozenBlood:Show()
		specWarnFrozenBlood:Play("keepmove")
	elseif spellId == 295796 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnVenomousBlood:Show()
		specWarnVenomousBlood:Play("stopmove")
	elseif spellId == 300701 then--Rimefrost
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRimefrost:Show(args.destName, amount)
		end
	elseif spellId == 300705 then--Septic Taint
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnSepticTaint:Show(args.destName, amount)
		end
	elseif spellId == 295348 then
		warnOverflowingChill:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOverflowingChill:Show()
			specWarnOverflowingChill:Play("runout")
			yellOverflowingChill:Yell()
			yellOverflowingChillFades:Countdown(5)
		end
	elseif spellId == 295421 then
		warnOverflowingVenom:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnOverflowingVenom:Show()
			specWarnOverflowingVenom:Play("runout")
			yellOverflowingVenom:Yell()
			yellOverflowingVenomFades:Countdown(5)
		end
	elseif (spellId == 300961 or spellId == 300962) and args:IsPlayer() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
--	elseif spellId == 295332 then
--		local uId = DBM:GetRaidUnitId(args.destName)
--		if self:IsTanking(uId) then
--			specWarnCrushingReverbTaunt:Show(args.destName)
--			specWarnCrushingReverbTaunt:Play("tauntboss")
--		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 294711 or spellId == 294715 then
		MarksStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(MarksStacks)
		end
		--if self.Options.SetIconOnMarks then
		--	self:SetIcon(args.destName, 0)
		--end
	elseif spellId == 295348 then
		if args:IsPlayer() then
			yellOverflowingChillFades:Cancel()
		end
	elseif spellId == 295421 then
		if args:IsPlayer() then
			yellOverflowingVenomFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135824 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 then

	end
end
--]]
