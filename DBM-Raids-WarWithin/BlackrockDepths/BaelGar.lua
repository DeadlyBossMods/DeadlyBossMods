if DBM:GetTOC() < 110005 then return end
local mod	= DBM:NewMod(2664, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "lfr,normal,heroic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226303)
mod:SetEncounterID(3044)
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 462974 463890 462969 462972",
	"SPELL_CAST_SUCCESS 462969",
	"SPELL_SUMMON 462949 462966",
	"SPELL_AURA_APPLIED 462968"
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--NOTE, Figure out how many boulders fall during rockfall for automarking
--TODO, auto mark spawns of bael'Gar with https://www.wowhead.com/ptr-2/spell=462966/spawn-of-baelgar ?
local warnMoltenHeart						= mod:NewTargetNoFilterAnnounce(462968, 3, nil, "Healer")
local warnShatter							= mod:NewCountAnnounce(462972, 2)

local specWarnRockFall						= mod:NewSpecialWarningDodgeCount(463890, nil, nil, nil, 2, 2)
local specWarnMoltenFurnace					= mod:NewSpecialWarningCount(462969, nil, nil, nil, 2, 2)
local specWarnShatter						= mod:NewSpecialWarningCount(462972, nil, nil, nil, 2, 2)
--local yellHoneyMarinade					= mod:NewShortYell(438025)
--local yellHoneyMarinadeFades				= mod:NewShortFadesYell(438025)

local timerGiantStrikeCD					= mod:NewAITimer(33, 462974, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK)
local timerRockfallCD						= mod:NewAITimer(33, 463890, nil, nil, nil, 3)
local timerMoltenFurnaceCD					= mod:NewAITimer(33, 462969, nil, nil, nil, 2)

--mod:AddNamePlateOption("NPOnHoney", 443983)
mod:AddSetIconOption("SetIconOnRockfall", -30947, true, 5, {1, 2, 3, 4})
mod:AddInfoFrameOption(462969, false)

--local castsPerGUID = {}
mod.vb.GiantStrikeCount = 0
mod.vb.RockfallCount = 0
mod.vb.rockIcon = 1
mod.vb.furnaceCount = 0
mod.vb.activeBoulders = 0
mod.vb.shatterCount = 0

function mod:OnCombatStart(delay)
	self.vb.GiantStrikeCount = 0
	self.vb.RockfallCount = 0
	self.vb.rockIcon = 1
	self.vb.furnaceCount = 0
	self.vb.activeBoulders = 0
	self.vb.shatterCount = 0
	timerGiantStrikeCD:Start(1-delay)
	timerRockfallCD:Start(1-delay)
	timerMoltenFurnaceCD:Start(1-delay)
end

--function mod:OnCombatEnd()

--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 462974 then
		self.vb.GiantStrikeCount = self.vb.GiantStrikeCount + 1
		timerGiantStrikeCD:Start()--, self.vb.GiantStrikeCount+1)
	elseif spellId == 463890 then
		self.vb.rockIcon = 1
		self.vb.RockfallCount = self.vb.RockfallCount + 1
		specWarnRockFall:Show(self.vb.RockfallCount)
		specWarnRockFall:Play("watchstep")
		timerRockfallCD:Start()--, self.vb.RockfallCount+1)
	elseif spellId == 462969 then
		self.vb.furnaceCount = self.vb.furnaceCount + 1
		specWarnMoltenFurnace:Show(self.vb.furnaceCount)
		specWarnMoltenFurnace:Play("findshelter")
		timerMoltenFurnaceCD:Start()--, self.vb.furnaceCount+1)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_COMMON_L.NOTSAFE)
			DBM.InfoFrame:Show(15, "playergooddebuff", 462971)
		end
	elseif spellId == 462972 then
		self.vb.shatterCount = self.vb.shatterCount + 1
		if self.vb.activeBoulders >= 2 then
			specWarnShatter:Show(self.vb.shatterCount)
			specWarnShatter:Play("aesoon")
		else
			warnShatter:Show(self.vb.shatterCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 462969 then--Molten Furnace
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 462949 then--Boulder Spawning
		self.vb.activeBoulders = self.vb.activeBoulders + 1
		if self.Options.SetIconOnRockfall then
			self:ScanForMobs(args.destGUID, 2, self.vb.rockIcon, 1, nil, 12, "SetIconOnRockfall")
		end
		self.vb.rockIcon = self.vb.rockIcon + 1
	elseif spellId == 462966 then--Spawn of Bael'Gar (boulder dying)
		self.vb.activeBoulders = self.vb.activeBoulders - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 462968 then
		warnMoltenHeart:Show(args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 440134 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 440141 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 218016 then

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
