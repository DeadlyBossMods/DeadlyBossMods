local mod	= DBM:NewMod(2352, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(151881)
mod:SetEncounterID(2298)
mod:SetZone()
mod:SetUsedIcons(4, 6)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 294726 295332 296551 298122 295791",
	"SPELL_CAST_SUCCESS 295346 295332 295791",
	"SPELL_AURA_APPLIED 294711 294715 300701 300705 295348 300961 300962 300882 300883",
	"SPELL_AURA_APPLIED_DOSE 294711 294715 300701 300705",
	"SPELL_AURA_REMOVED 294711 294715 295348 300882 300883",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED"
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, request voice pack authors add "frost mark" and "toxic mark"
--TODO, fix tank swap code when a strategy consensus is reached
--TODO, improve DBM when strats formulate for boss on how to handle tank stacks
--TODO, if inversion sickness is a LOT of people (or everyone) ono mythic, disable target warning on mythic
--[[
(ability.id = 294726 or ability.id = 295332 or ability.id = 296551 or ability.id = 298122 or ability.id = 295791) and type = "begincast"
 or (ability.id = 295332 or ability.id = 295346) and type = "cast"
 or (ability.id = 295348 or ability.id = 295421) and type = "applydebuff"
--]]
local warnChimericMarks					= mod:NewSpellAnnounce(294726, 4)
local warnRimefrost						= mod:NewStackAnnounce(300701, 2, nil, "Tank")
local warnSepticTaint					= mod:NewStackAnnounce(300705, 2, nil, "Tank")
local warnOverflowingChill				= mod:NewTargetNoFilterAnnounce(295348, 3)
local warnOverflowingVenom				= mod:NewTargetNoFilterAnnounce(295421, 3)
local warnInversionSickness				= mod:NewTargetNoFilterAnnounce(300882, 4)

local specWarnFrostMark					= mod:NewSpecialWarningYouPos(294711, nil, nil, nil, 1, 9)
local specWarnToxicMark					= mod:NewSpecialWarningYouPos(294715, nil, nil, nil, 1, 9)
local yellMark							= mod:NewPosYell(294726, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, true, 2)
local specWarnFrozenBlood				= mod:NewSpecialWarningKeepMove(295795, nil, nil, nil, 1, 2)
local specWarnVenomousBlood				= mod:NewSpecialWarningStopMove(295796, nil, nil, nil, 1, 2)
local specWarnCrushingReverb			= mod:NewSpecialWarningDefensive(295332, "Melee", nil, 2, 2, 2)
local specWarnOverwhelmingBarrage		= mod:NewSpecialWarningDodge(296551, nil, nil, nil, 3, 2)
local specWarnOverflowingChill			= mod:NewSpecialWarningMoveAway(295348, nil, nil, nil, 1, 2)
local yellOverflowingChill				= mod:NewYell(295348)
local yellOverflowingChillFades			= mod:NewShortFadesYell(295348)
local specWarnOverflowingVenom			= mod:NewSpecialWarningMoveAway(295421, nil, nil, nil, 1, 2)
local yellOverflowingVenom				= mod:NewYell(295421)
local yellOverflowingVenomFades			= mod:NewShortFadesYell(295421)
local specWarnInversion					= mod:NewSpecialWarningMoveAway(295791, nil, nil, nil, 3, 2)
local specWarnInversionSicknessFrost	= mod:NewSpecialWarningYou(300882, nil, nil, nil, 1, 2)--Separate warning in case user wants to customize sound based on type
local specWarnInversionSicknessToxic	= mod:NewSpecialWarningYou(300883, nil, nil, nil, 1, 2)--Separate warning in case user wants to customize sound based on type
local yellInversionSickness				= mod:NewYell(300882)
local yellInversionSicknessFades		= mod:NewShortFadesYell(300882)
local specWarnFrostJav					= mod:NewSpecialWarningYou(295606, nil, nil, nil, 1, 2)
local yellFrostJav						= mod:NewYell(295606)
local specWarnToxicJav					= mod:NewSpecialWarningYou(295607, nil, nil, nil, 1, 2)
local yellToxicJav						= mod:NewYell(295607)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(300961, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerCrushingReverbCD				= mod:NewCDTimer(21.1, 295332, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON, nil, mod:IsMelee() and 2, 4)
local timerOverwhelmingBarrageCD		= mod:NewCDTimer(40, 296551, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON, nil, 1, 4)
local timerOverflowCD					= mod:NewCDTimer(31.6, 295346, nil, nil, nil, 3)--31.6 but can be delayed by boss spell queuing
local timerInversionCD					= mod:NewCDTimer(90, 295791, nil, nil, nil, 2, nil, DBM_CORE_HEROIC_ICON, nil, 3, 4)
local timerfrostshockboltsCD			= mod:NewCDTimer(61.2, 295601, nil, nil, nil, 3)
local timerChimericMarksCD				= mod:NewAITimer(58.2, 294726, nil, nil, nil, 2)--Mythic

--local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnMarks", 294726, true, false, {4, 6})
mod:AddInfoFrameOption(294726, true)

local MarksStacks = {}
local playerMark = 0--1 Toxic, 2 Frost

function mod:OnCombatStart(delay)
	table.wipe(MarksStacks)
	playerMark = 0--1 Toxic, 2 Frost
	timerCrushingReverbCD:Start(10.6-delay)
	timerOverflowCD:Start(15.7-delay)
	timerOverwhelmingBarrageCD:Start(40.2-delay)
	timerfrostshockboltsCD:Start(47.3-delay)
	if self:IsHard() then
		timerInversionCD:Start(90-delay)
		self:RegisterShortTermEvents(
			"UNIT_POWER_FREQUENT player"
		)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(294726))
		DBM.InfoFrame:Show(10, "table", MarksStacks, 1)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:OnTimerRecovery()
	if DBM:UnitDebuff("player", 294715) then
		playerMark = 1--Toxic
	elseif DBM:UnitDebuff("player", 294711) then
		playerMark = 2--Frost
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 294726 then
		warnChimericMarks:Show()
		timerChimericMarksCD:Start()
	elseif spellId == 295332 then
		specWarnCrushingReverb:Show()
		specWarnCrushingReverb:Play("carefly")
	elseif spellId == 296551 or spellId == 298122 then
		specWarnOverwhelmingBarrage:Show()
		specWarnOverwhelmingBarrage:Play("aesoon")
		timerOverwhelmingBarrageCD:Start(40)
	elseif spellId == 295791 then
		specWarnInversion:Show()
		specWarnInversion:Play("scatter")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 295346 then
		DBM:AddMsg("blizzard added overflow to combat log, tell DBM author")
	elseif spellId == 295332 then--Has to be in success, can stutter cast
		timerCrushingReverbCD:Start()
	elseif spellId == 295791 then
		timerInversionCD:Start(90)
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
		if amount == 1 then
			if args:IsPlayer() then
				if spellId == 294711 then--Frost
					specWarnFrostMark:Show(self:IconNumToTexture(6))
					specWarnFrostMark:Play("frostmark")
					yellMark:Yell(6, "", 6)--Square
					playerMark = 2--1 Toxic, 2 Frost
				else--Toxic
					specWarnToxicMark:Show(self:IconNumToTexture(4))
					specWarnToxicMark:Play("toxicmark")
					yellMark:Yell(4, "", 4)--Triangle
					playerMark = 1--1 Toxic, 2 Frost
				end
			end
			local uId = DBM:GetRaidUnitId(args.destName)
			if self.Options.SetIconOnMarks and self:IsTanking(uId) then
				if spellId == 294711 then--Frost
					self:SetIcon(args.destName, 6)
				else
					self:SetIcon(args.destName, 4)
				end
			end
		end
	elseif spellId == 300701 then--Rimefrost
		local amount = args.amount or 1
		--if amount % 3 == 0 then
			warnRimefrost:Show(args.destName, amount)
		--end
	elseif spellId == 300705 then--Septic Taint
		local amount = args.amount or 1
		--if amount % 3 == 0 then
			warnSepticTaint:Show(args.destName, amount)
		--end
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
	elseif (spellId == 300882 or spellId == 300883) then
		warnInversionSickness:CombinedShow(0.3, args.destname)
		if args:IsPlayer() then
			if spellId == 300882 then--Frost
				specWarnInversionSicknessFrost:Show()
				specWarnInversionSicknessFrost:Play("targetyou")
			else--Toxic
				specWarnInversionSicknessToxic:Show()
				specWarnInversionSicknessToxic:Play("targetyou")
			end
			yellInversionSickness:Yell()
			yellInversionSicknessFades:Countdown(4)
		end
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
		--if args:IsPlayer() then
		--	playerMark = 0--1 Toxic, 2 Frost
		--end
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
	elseif (spellId == 300882 or spellId == 300883) then
		if args:IsPlayer() then
			yellInversionSicknessFades:Cancel()
		end
	end
end
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, targetname)
	if msg:find("spell:295607") then--Toxic Jav
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnToxicJav:Show()
				specWarnToxicJav:Play("targetyou")
				yellToxicJav:Yell()
			end
		end
	elseif msg:find("spell:295606") then--Frost Jav
		if targetname and self:AntiSpam(5, targetname) then
			if targetname == UnitName("player") then
				specWarnFrostJav:Show()
				specWarnFrostJav:Play("targetyou")
				yellFrostJav:Yell()
			end
		end
	end
end

function mod:UNIT_POWER_FREQUENT(uId, type)
	if type == "ALTERNATE" then
		local altPower = UnitPower(uId, 10)
		if self:AntiSpam(3, 1) and altPower >= 70 then
			if playerMark == 1 then--Toxic
				specWarnVenomousBlood:Show()
				specWarnVenomousBlood:Play("stopmove")
			elseif playerMark == 2 then--Frost
				specWarnFrozenBlood:Show()
				specWarnFrozenBlood:Play("keepmove")
			end
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 295346 and self:AntiSpam(5, 3) then
		timerOverflowCD:Start()
	elseif spellId == 295601 and self:AntiSpam(5, 4) then
		timerfrostshockboltsCD:Start()
	end
end
