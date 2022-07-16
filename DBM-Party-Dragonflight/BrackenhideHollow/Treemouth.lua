local mod	= DBM:NewMod(2473, "DBM-Party-Dragonflight", 1, 1196)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)
mod:SetEncounterID(2568)
mod:SetUsedIcons(8, 7, 6, 5)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 376811 381770 377559",
--	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON 376797",
	"SPELL_AURA_APPLIED 376933 377222 378022 377864",
	"SPELL_AURA_APPLIED_DOSE 377864",
	"SPELL_AURA_REMOVED 377222 378022"
	"SPELL_PERIODIC_DAMAGE 378054",
	"SPELL_PERIODIC_MISSED 378054"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, proper event for grasping Vines
--TODO, proper phasing and timer updates
--TODO, better stack alert handling, maybe dispel special warning for RemoveDisease?
--TODO, CID
local warnGraspingVines							= mod:NewGraspingVinesAnnounce(376933, 3)
local warnConsume								= mod:NewTargetNoFilterAnnounce(377222, 4)
local warnDecaySpray							= mod:NewSpellAnnounce(376933, 2)
local warnInfectiousSpit						= mod:NewStackAnnounce(377864, 2, nil, "Healer|RemoveDisease")

--local yellInfusedStrikes						= mod:NewShortFadesYell(361966)
local specWarnGushingOoze						= mod:NewSpecialWarningInterrupt(381770, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(378054, nil, nil, nil, 1, 8)
local specWarnVineWhip							= mod:NewSpecialWarningDefensive(377559, nil, nil, nil, 1, 2)

local timerGraspingVinesCD						= mod:NewAITimer(35, 376933, nil, nil, nil, 6)
local timerConsume								= mod:NewTargetTimer(10, 377222, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDecaySprayCD							= mod:NewAITimer(35, 376811, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(378022, true)
mod:AddSetIconOption("SetIconOnDecaySpray", 376811, true, 5, {8, 7, 6, 5})

mod:GroupSpells(377222, 378022)--Consume with Consuming

mod.vb.addIcon = 8

function mod:OnCombatStart(delay)
	timerGraspingVinesCD:Start(1-delay)
	timerDecaySprayCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 376811 then
		self.vb.addIcon = 8
		timerDecaySprayCD:Start()
	elseif spellId == 381770 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGushingOoze:Show(args.sourceName)
		specWarnGushingOoze:Play("kickcast")
	elseif spellId == 377559 then
		--Update timers?
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnVineWhip:Show()
			specWarnVineWhip:Play("defensive")
		end
	end
end

--function mod:SPELL_CAST_SUCCESS(args)
--	local spellId = args.spellId
--	if spellId == 362805 then
--
--	end
--end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 376797 then
		if self.Options.SetIconOnDecaySpray then
			self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnDecaySpray")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 376933 and self:AntiSpam(3, 1) then
		warnGraspingVines:Show()
		timerGraspingVinesCD:Start()--Probably not right place to start
		--Update timers?
	elseif spellId == 377222 then--On Player
		warnConsume:Show(args.destName)
		timerConsume:Start(args.destName)
	elseif spellId == 378022 then--On Boss
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, args.amount, "boss1")
		end
	elseif spellId == 377864 then
		warnInfectiousSpit:Show(args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 377222 then
		timerConsume:Stop(args.destName)
	elseif spellId == 378022 then--On Boss
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 378054 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
