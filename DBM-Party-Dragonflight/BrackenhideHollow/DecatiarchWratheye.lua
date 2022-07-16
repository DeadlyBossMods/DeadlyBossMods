local mod	= DBM:NewMod(2474, "DBM-Party-Dragonflight", 1, 1196)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(181224)
mod:SetEncounterID(2569)
mod:SetUsedIcons(8)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 373960 375989 376170",
	"SPELL_CAST_SUCCESS 373917",
	"SPELL_SUMMON 373944",
	"SPELL_AURA_APPLIED 373896",
	"SPELL_AURA_APPLIED_DOSE 373896",
	"SPELL_AURA_REMOVED 373896",
	"SPELL_AURA_REMOVED_DOSE 373896",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, correct Lifewater trigger (and remove it if it's hella spammy)
--TODO, proper decay strike trigger/CD
local warnLifewater								= mod:NewCountAnnounce(374117, 1)
local warnDecayigStrength						= mod:NewSpellAnnounce(373960, 3)

local specWarnRottingUpsurge					= mod:NewSpecialWarningDodge(375989, nil, nil, nil, 2, 2)
local specWarnRotburstTotem						= mod:NewSpecialWarningSwitch(373944, nil, nil, nil, 1, 2)
local specWarnChokingRotcloud					= mod:NewSpecialWarningDodge(376170, nil, nil, nil, 2, 2, 4)
local specWarnDecaystrike						= mod:NewSpecialWarningDefensive(373917, nil, nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerLifewaterCD							= mod:NewAITimer(35, 374117, nil, nil, nil, 5)
local timerDecayingStrengthCD					= mod:NewAITimer(35, 373960, nil, nil, nil, 2)
local timerRotburstTotemCD						= mod:NewAITimer(35, 373944, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerRottingUpsurgeCD						= mod:NewAITimer(35, 375989, nil, nil, nil, 3)
local timerChokingRotcloutCD					= mod:NewAITimer(35, 376170, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerDecayStrikeCD						= mod:NewAITimer(35, 373917, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(5, 373941)
mod:AddInfoFrameOption(373896, true)
mod:AddSetIconOption("SetIconOnRotburstTotem", 373944, true, 5, {8})

local WitheringRotStacks = {}
mod.vb.waterCount = 0

function mod:OnCombatStart(delay)
	table.wipe(WitheringRotStacks)
	self.vb.waterCount = 0
	timerLifewaterCD:Start(1-delay)
	timerDecayingStrengthCD:Start(1-delay)
	timerRottingUpsurgeCD:Start(1-delay)
	timerDecayStrikeCD:Start(1-delay)
	if self:IsMythic() then
		timerChokingRotcloutCD:Start(1-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(373896))
		DBM.InfoFrame:Show(5, "table", WitheringRotStacks, 1)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 373960 then
		warnDecayigStrength:Show()
		timerDecayingStrengthCD:Start()
	elseif spellId == 375989 then
		specWarnRottingUpsurge:Show()
		specWarnRottingUpsurge:Play("watchstep")
		timerRottingUpsurgeCD:Start()
	elseif spellId == 376170 then
		specWarnChokingRotcloud:Show()
		specWarnChokingRotcloud:Play("shockwave")
		timerChokingRotcloutCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 373917 then
		timerDecayStrikeCD:Start()
		if args:IsPlayer() then
			specWarnDecaystrike:Show()
			specWarnDecaystrike:Play("defensive")
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 376797 then
		specWarnRotburstTotem:Show()
		specWarnRotburstTotem:Play("attacktotem")
		if self.Options.SetIconOnRotburstTotem then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnRotburstTotem")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 373896 then
		local amount = args.amount or 1
		WitheringRotStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(WitheringRotStacks, 0.2)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 373896 then
		WitheringRotStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(WitheringRotStacks, 0.2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 373896 then
		WitheringRotStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(WitheringRotStacks, 0.2)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 375911 or spellId == 374109 then--Lifewater
		self.vb.waterCount = self.vb.waterCount + 1
		warnLifewater:Show(self.vb.waterCount)
		timerLifewaterCD:Start()
	end
end
