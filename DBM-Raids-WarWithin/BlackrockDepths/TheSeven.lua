if DBM:GetTOC() < 110005 then return end
local mod	= DBM:NewMod(2667, "DBM-Raids-WarWithin", 2, 1301)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "lfr,normal,heroic"

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(226307, 226310, 226309, 226313, 226311, 226312, 226308)--226307 Anger'rel, 226310/doomrel, 226309/doperel, 226313/gloomrel, 226311/haterel, 226312/seethrel, 226308/vilerel
mod:SetEncounterID(3048)
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 464347 464348 464358 464359 464361 464331 464333 464334 469628 464363 469636 464367 464341 469711 469723",
	"SPELL_CAST_SUCCESS 465652 464353 464344",
	"SPELL_SUMMON 464366",
	"SPELL_AURA_APPLIED 464347 464348 464358 464361 464371 464333 464356 464362 464337 464340 464344 469711 469723",
	"SPELL_AURA_APPLIED_DOSE 464347",
	"SPELL_AURA_REMOVED 464371 464337 464340",
	"SPELL_PERIODIC_DAMAGE 464350 464339",
	"SPELL_PERIODIC_MISSED 464350 464339"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, review all timers and decide if any are worth setting to nameplate only
--TODO, what stacks to tanks swap at
--TODO, figure out which boss is 3rd boss, on engage (and if it's always that one)
--TODO, figure out right Bladestorm trigger and if it can be target scanned
--TODO, change blizzard timer handling if pre target debuff is not logged to use https://www.wowhead.com/ptr-2/spell=464338/blizzard or https://www.wowhead.com/ptr-2/spell=464932/blizzard
--TODO, infoframe for absorb amount if it's not broken easily
--TODO, update terrify alert when it's clearer how mechanic works
--TODO, change option key if blizzard moves tooltip to correct ID for Mind Torrent (469722 vs 469723)
--General
--mod:AddNamePlateOption("NPOnHoney", 443983)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(464350, nil, nil, nil, 1, 8)

mod:AddSetIconOption("SetIconOnCorp", 464371, true, 5, {1})
--Anger'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30766))
local warnSunderArmor						= mod:NewStackAnnounce(464347, 3, nil, "Tank|Healer")
local warnMortalStrike						= mod:NewTargetNoFilterAnnounce(464348, 3, nil, "Tank|Healer")
local warnBladestorm						= mod:NewSpellAnnounce(465652, 3)

--local specWarnSunderArmor					= mod:NewSpecialWarningTaunt(464347, nil, nil, nil, 1, 2)
--local yellHoneyMarinade					= mod:NewShortYell(438025)
--local yellHoneyMarinadeFades				= mod:NewShortFadesYell(438025)

local timerSunderArmorCD					= mod:NewAITimer(33, 464347, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMortalStrikeCD					= mod:NewAITimer(33, 464348, nil, "Tank|Healer", nil, 5)
local timerBladestormCD						= mod:NewAITimer(33, 465652, nil, nil, nil, 3)

--Gloom'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30769))
local warnRend								= mod:NewTargetNoFilterAnnounce(464358, 2, nil, false)
local warnRecklessness						= mod:NewTargetNoFilterAnnounce(464361, 3, nil, "Tank|Healer")

local specWarnRampage						= mod:NewSpecialWarningDefensive(464359, nil, nil, nil, 1, 2)

local timerRendCD							= mod:NewAITimer(33, 464358, nil, false, nil, 3)
local timerRampageCD						= mod:NewAITimer(33, 464359, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRecklessnessCD					= mod:NewAITimer(33, 464361, nil, "Tank|Healer", nil, 5)
--Doom'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30767))

local specWarnShadowBoltVolley				= mod:NewSpecialWarningInterruptCount(464331, false, nil, nil, 1, 2)
local specWarnBanish						= mod:NewSpecialWarningDispel(464333, "RemoveMagic", nil, nil, 1, 2)
local specWarnSummonFelguard				= mod:NewSpecialWarningInterruptCount(464334, "HasInterrupt", nil, nil, 1, 2)

--local timerShadowBoltVolleyCD				= mod:NewAITimer(33, 464331, nil, false, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerBanishCD							= mod:NewAITimer(33, 464333, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerSummonFelguardCD					= mod:NewAITimer(33, 464334, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--Dope'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30768))
local warnFanofKnives						= mod:NewSpellAnnounce(464353, 2)
local warnSmokeBomb							= mod:NewSpellAnnounce(469628, 2)

local specWarnSmokeBomb						= mod:NewSpecialWarningMove(469628, nil, nil, nil, 1, 2)--Move is for 464356 on a boss

local timerFanofKnivesCD					= mod:NewAITimer(33, 464353, nil, nil, nil, 3)
local timerSmokeBombCD						= mod:NewAITimer(33, 469628, nil, nil, nil, 5)

--Hate'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30770))

local specWarnMagmaBolt						= mod:NewSpecialWarningInterruptCount(464363, "HasInterrupt", nil, nil, 1, 2)
local specWarnMagmaBurn						= mod:NewSpecialWarningDispel(464362, "RemoveMagic", nil, nil, 1, 2)
local specWarnSummonFireElemental			= mod:NewSpecialWarningSwitch(469636, nil, nil, nil, 1, 2)
local specWarnFireNova						= mod:NewSpecialWarningInterruptCount(464367, "HasInterrupt", nil, nil, 1, 2)

--local timerMagmaBoltCD					= mod:NewAITimer(33, 464363, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerSummonFireElementalCD			= mod:NewAITimer(33, 469636, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
--local timerFireNovaCD						= mod:NewCDPNPTimer(33, 464367, nil, "HasInterrupt", nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

mod:AddSetIconOption("SetIconOnFireElemental", 469636, true, 5, {2})
--Seeth'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30771))
local warnBlizzard							= mod:NewTargetAnnounce(464337, 2)

local specWarnBlizzard						= mod:NewSpecialWarningMoveAway(464337, nil, nil, nil, 1, 2)
local yellBlizzard							= mod:NewYell(464337)
local yellBlizzardFades						= mod:NewShortFadesYell(464337)
local specWarnBitterCold					= mod:NewSpecialWarningMoveAway(464341, nil, nil, nil, 3, 2)
local yellBitterCold						= mod:NewYell(464341, nil, false)
local yellBitterColdFades					= mod:NewShortFadesYell(464341, nil, false)

local timerBlizzardCD						= mod:NewAITimer(33, 464337, nil, nil, nil, 3)
local timerBitterColdCD						= mod:NewAITimer(33, 464341, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--Vile'rel
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30772))
local warnTerrify							= mod:NewCastAnnounce(469711, 3)
local warnMindTorrent						= mod:NewTargetNoFilterAnnounce(469722, 4)

local specWarnRespite						= mod:NewSpecialWarningSwitchCustom(464344, "Dps", nil, nil, 1, 2)
local specWarnTerrifyDispel					= mod:NewSpecialWarningDispel(469711, "RemoveMagic", nil, nil, 1, 2)
local specWarnMindTorrent					= mod:NewSpecialWarningMoveTo(469722, nil, nil, nil, 1, 2)
local yellMindTorrent						= mod:NewYell(469722, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")

local timerRespiteCD						= mod:NewAITimer(33, 464344, nil, "Dps", nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerTerrifyCD						= mod:NewAITimer(33, 469711, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerMindTorrentCD					= mod:NewAITimer(33, 469722, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)

local castsPerGUID = {}
mod.vb.activeBossGUID = "unknown"

---@param self DBMMod
local function scanBosses(self, delay)
	for i = 1, 7 do
		local unitID = "boss"..i
		if UnitExists(unitID) then
			local cid = self:GetUnitCreatureId(unitID)
			local bossGUID = UnitGUID(unitID)
			if cid == 226307 then--Anger'rel
				timerSunderArmorCD:Start(1, bossGUID)
				timerMortalStrikeCD:Start(1, bossGUID)
				timerBladestormCD:Start(1, bossGUID)
			elseif cid == 226313 then--Gloom'rel
				timerRendCD:Start(1, bossGUID)
				timerRampageCD:Start(1, bossGUID)
				timerRecklessnessCD:Start(1, bossGUID)
			--TODO, find dirtier way to detect these units GUID on pull if they do not have boss unit IDs
			elseif cid == 226312 then--Seeth'rel
				timerBlizzardCD:Start(1, bossGUID)
			elseif cid == 226308 then--Vile'rel
				timerRespiteCD:Start(1, bossGUID)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.activeBossGUID = "unknown"
	self:Schedule(1, scanBosses, self, delay)--1 second delay to give IEEU time to populate boss guids
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 464347 then
		timerSunderArmorCD:Start(nil, args.sourceGUID)
	elseif spellId == 464348 then
		timerMortalStrikeCD:Start(nil, args.sourceGUID)
	elseif spellId == 464358 then
		timerRendCD:Start(nil, args.sourceGUID)
	elseif spellId == 464359 then
		timerRampageCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnRampage:Show()
			specWarnRampage:Play("defensive")
		end
	elseif spellId == 464361 then
		timerRecklessnessCD:Start(nil, args.sourceGUID)
	elseif spellId == 464331 and self.vb.activeBossGUID == args.sourceGUID then
		--timerShadowBoltVolleyCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID][spellId] then
			castsPerGUID[args.sourceGUID][spellId] = 0
		end
		castsPerGUID[args.sourceGUID][spellId] = castsPerGUID[args.sourceGUID][spellId] + 1
		local count = castsPerGUID[args.sourceGUID][spellId]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnShadowBoltVolley:Show(args.sourceName, count)
			if count < 6 then
				specWarnShadowBoltVolley:Play("kick"..count.."r")
			else
				specWarnShadowBoltVolley:Play("kickcast")
			end
		end
	elseif spellId == 464363 and self.vb.activeBossGUID == args.sourceGUID then
		--timerMagmaBoltCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID][spellId] then
			castsPerGUID[args.sourceGUID][spellId] = 0
		end
		castsPerGUID[args.sourceGUID][spellId] = castsPerGUID[args.sourceGUID][spellId] + 1
		local count = castsPerGUID[args.sourceGUID][spellId]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnMagmaBolt:Show(args.sourceName, count)
			if count < 6 then
				specWarnMagmaBolt:Play("kick"..count.."r")
			else
				specWarnMagmaBolt:Play("kickcast")
			end
		end
	elseif spellId == 464334 then
		timerSummonFelguardCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID][spellId] then
			castsPerGUID[args.sourceGUID][spellId] = 0
		end
		castsPerGUID[args.sourceGUID][spellId] = castsPerGUID[args.sourceGUID][spellId] + 1
		local count = castsPerGUID[args.sourceGUID][spellId]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnSummonFelguard:Show(args.sourceName, count)
			if count < 6 then
				specWarnSummonFelguard:Play("kick"..count.."r")
			else
				specWarnSummonFelguard:Play("kickcast")
			end
		end
	elseif spellId == 464367 then
		--timerFireNovaCD:Start(nil, args.sourceGUID)
		--Delete redundant table creation if spell summon is in CLEU
		if castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = {}
		end
		if not castsPerGUID[args.sourceGUID][spellId] then
			castsPerGUID[args.sourceGUID][spellId] = 0
		end
		castsPerGUID[args.sourceGUID][spellId] = castsPerGUID[args.sourceGUID][spellId] + 1
		local count = castsPerGUID[args.sourceGUID][spellId]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnFireNova:Show(args.sourceName, count)
			if count < 6 then
				specWarnFireNova:Play("kick"..count.."r")
			else
				specWarnFireNova:Play("kickcast")
			end
		end
	elseif spellId == 464333 then
		timerBanishCD:Start(nil, args.sourceGUID)
	elseif spellId == 469628 then
		warnSmokeBomb:Show()
		timerSmokeBombCD:Start(nil, args.sourceGUID)
	elseif spellId == 469636 then
		specWarnSummonFireElemental:Show()
		specWarnSummonFireElemental:Play("killmob")
		timerSummonFireElementalCD:Start(nil, args.sourceGUID)
	elseif spellId == 464341 then
		specWarnBitterCold:Show()
		specWarnBitterCold:Play("scatter")
		timerBitterColdCD:Start(nil, args.sourceGUID)
	elseif spellId == 469711 then
		warnTerrify:Show()
		timerTerrifyCD:Start(nil, args.sourceGUID)
	elseif spellId == 469723 then
		timerMindTorrentCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 465652 then
		warnBladestorm:Show()
		timerBladestormCD:Start(nil, args.sourceGUID)
	elseif spellId == 464353 then
		warnFanofKnives:Show()
		timerFanofKnivesCD:Start(nil, args.sourceGUID)
	elseif spellId == 464344 then
		timerRespiteCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 464366 then
		--timerFireNovaCD:Start(nil, args.destGUID)
		if castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = {}
		end
		if self.Options.SetIconOnFireElemental then
			self:ScanForMobs(args.destGUID, 2, 2, 1, nil, 12, "SetIconOnFireElemental", nil, nil, nil, true)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 464347 then
		local amount = args.amount or 1
		--local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		--local remaining
		--if expireTime then
		--	remaining = expireTime-GetTime()
		--end
		--if (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") then
		--	specWarnSunderArmor:Show(args.destName)
		--	specWarnSunderArmor:Play("tauntboss")
		--else
		warnSunderArmor:Show(args.destName, amount)
		--end
	elseif spellId == 464348 then
		warnMortalStrike:Show(args.destName)
	elseif spellId == 464358 then
		warnRend:Show(args.destName)
	elseif spellId == 464361 then
		warnRecklessness:Show(args.destName)
	elseif spellId == 464333 and self:CheckDispelFilter("magic") then
		specWarnBanish:Show(args.destName)
		specWarnBanish:Play("dispelnow")
	elseif spellId == 464356 and args:IsDestTypeHostile() then
		if self:IsTanking("player", nil, nil, true, args.destGUID) then
			specWarnSmokeBomb:Show()
			specWarnSmokeBomb:Play("moveboss")
		end
	elseif spellId == 464362 and self:CheckDispelFilter("magic") then
		specWarnMagmaBurn:Show(args.destName)
		specWarnMagmaBurn:Play("dispelnow")
	elseif spellId == 464337 then
		if args:IsPlayer() then
			specWarnBlizzard:Show()
			specWarnBlizzard:Play("runout")
			yellBlizzard:Yell()
			yellBlizzardFades:Countdown(spellId)
		else
			warnBlizzard:Show(args.destName)
		end
		timerBlizzardCD:Start(nil, args.sourceGUID)
	elseif spellId == 464340 then
		if args:IsPlayer() then
			yellBitterCold:Yell()
			yellBitterColdFades:Countdown(spellId)
		end
	elseif spellId == 464344 then
		specWarnRespite:Show(args.destName)
		specWarnRespite:Play("attackshield")
	elseif spellId == 469711 and self:CheckDispelFilter("magic") then
		specWarnTerrifyDispel:Show(args.destName)
		specWarnTerrifyDispel:Play("dispelnow")
	elseif spellId == 469723 then
		if args:IsPlayer() then
			specWarnMindTorrent:Show(DBM_COMMON_L.ALLIES)
			specWarnMindTorrent:Play("gathershare")
			yellMindTorrent:Yell()
		else
			warnMindTorrent:Show(args.destName)
		end
	elseif spellId == 464371 then--Corporeal
		self.vb.activeBossGUID = args.destGUID
		if castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = {}
		end
		if self.Options.SetIconOnCorp then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 6, "SetIconOnCorp", nil, nil, nil, true)
		end
		local cid = self:GetCIDFromGUID(args.destGUID)
		--226307 Anger'rel, 226310/doomrel, 226309/doperel, 226313/gloomrel, 226311/haterel, 226312/seethrel, 226308/vilerel
		if cid == 226310 then--Doom'rel
			timerBanishCD:Start(1, args.destGUID)
			timerSummonFelguardCD:Start(1, args.destGUID)
		elseif cid == 226309 then--Dope'rel
			timerFanofKnivesCD:Start(1, args.destGUID)
			timerSmokeBombCD:Start(1, args.destGUID)
		elseif cid == 226311 then--Hate'rel
			timerSummonFireElementalCD:Start(1, args.destGUID)
		elseif cid == 226312 then--Seeth'rel
			timerBitterColdCD:Start(1, args.destGUID)
		elseif cid == 226308 then--Vile'rel
			timerTerrifyCD:Start(1, args.destGUID)
			timerMindTorrentCD:Start(1, args.destGUID)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 464371 then--Corporeal
		local cid = self:GetCIDFromGUID(args.destGUID)
		--226307 Anger'rel, 226310/doomrel, 226309/doperel, 226313/gloomrel, 226311/haterel, 226312/seethrel, 226308/vilerel
		if cid == 226310 then--Doom'rel
			timerBanishCD:Stop(args.destGUID)
			timerSummonFelguardCD:Stop(args.destGUID)
		elseif cid == 226309 then--Dope'rel
			timerFanofKnivesCD:Stop(args.destGUID)
			timerSmokeBombCD:Stop(args.destGUID)
		elseif cid == 226311 then--Hate'rel
			timerSummonFireElementalCD:Stop(args.destGUID)
		elseif cid == 226312 then--Seeth'rel
			timerBitterColdCD:Stop(args.destGUID)
		elseif cid == 226308 then--Vile'rel
			timerTerrifyCD:Stop(args.destGUID)
			timerMindTorrentCD:Stop(args.destGUID)
		end
	elseif spellId == 464337 then
		if args:IsPlayer() then
			yellBlizzardFades:Cancel()
		end
	elseif spellId == 464340 then
		if args:IsPlayer() then
			yellBitterColdFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 464350 or spellId == 464339) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 231410 then--Fire Elemental
		timerFireNovaCD:Stop(args.destGUID)
	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
