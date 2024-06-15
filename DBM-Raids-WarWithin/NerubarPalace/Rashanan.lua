local mod	= DBM:NewMod(2609, "DBM-Raids-WarWithin", 1, 1273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(214504)
mod:SetEncounterID(2918)
--mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20240614000000)
--mod:SetMinSyncRevision(20230929000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 444687 439789 455373 439784 439795 439811 454989 452806",
	"SPELL_AURA_APPLIED 458067",
	"SPELL_AURA_APPLIED_DOSE 458067",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_START boss1"
)

--TODO, maybe auto mark https://www.wowhead.com/beta/spell=434579/corrosion so still assign clears by icon
--TODO, maybe use https://www.wowhead.com/beta/spell=455287/infested-bite to announce or mark infested spawns after the fact for healing?
--TODO, target scan Web Reave? Or probably CHAT_MSG_RAID_BOSS_EMOTE or WHISPER. it's not a private aura (yet)
--TODO, emphasize Enveloping webs cast itself? will probably only have a soon warning for it that's emphasized with a precise timer
--TODO, change option keys to match BW for weak aura compatability before live
local warnSavageWound							= mod:NewStackAnnounce(458067, 2, nil, "Tank|Healer")
local warnRollingAcid							= mod:NewIncomingCountAnnounce(439789, 2)--General announce, private aura sound will be personal emphasis
local warnInfestedSpawn							= mod:NewIncomingCountAnnounce(455373, 2)
local warnSpinneretsStrands						= mod:NewIncomingCountAnnounce(439784, 3)--General announce, private aura sound will be personal emphasis
local warnErosiveSpray							= mod:NewCountAnnounce(439811, 2)
local warnEnvelopingWebs						= mod:NewCountAnnounce(454989, 4)
local warnAcidEruption							= mod:NewCastAnnounce(452806, 4)

local specWarnSavageAssault						= mod:NewSpecialWarningDefensive(444687, nil, nil, nil, 1, 2)
local specWarnSavageWoundSwap					= mod:NewSpecialWarningTaunt(458067, nil, nil, nil, 1, 2)
local specWarnWebReave							= mod:NewSpecialWarningCount(439795, nil, nil, nil, 2, 2)
local yellWebReave								= mod:NewShortYell(439795, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local specWarnAcidEruption						= mod:NewSpecialWarningInterrupt(452806, "HasInterrupt", nil, nil, 1, 2)
--local yellSearingAftermathFades				= mod:NewShortFadesYell(422577)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(421532, nil, nil, nil, 1, 8)

local timerSavageAssaultCD						= mod:NewAITimer(49, 444687, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRollingAcidCD						= mod:NewAITimer(21.3, 439789, nil, nil, nil, 3)
local timerInfestedSpawnCD						= mod:NewAITimer(21.3, 455373, nil, nil, nil, 1)
local timerSpinneretsStrandsCD					= mod:NewAITimer(33.9, 439784, nil, nil, nil, 3)
local timerWebReaveCD							= mod:NewAITimer(49, 439795, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerErosiveSprayCD						= mod:NewAITimer(49, 439811, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerEnvelopingWebsCD						= mod:NewAITimer(49, 454989, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)

--mod:AddInfoFrameOption(407919, true)
--mod:AddSetIconOption("SetIconOnSinSeeker", 335114, true, 0, {1, 2, 3})
mod:AddPrivateAuraSoundOption(439790, true, 439789, 1)--Rolling Acid target
mod:AddPrivateAuraSoundOption(455284, true, 455373, 1)--Infested Spawn target
mod:AddPrivateAuraSoundOption(439783, true, 439784, 1)--Spineret's Strands target

mod.vb.assaultCount = 0
mod.vb.rollingCount = 0
mod.vb.spawnCount = 0
mod.vb.strandsCount = 0
mod.vb.reaveCount = 0
mod.vb.sprayCount = 0
mod.vb.envelopingCount = 0

local savedDifficulty = "heroic"
local allTimers = {
	["normal"] = {
		--Erosive Spray
		[439811] = {},
		--Infested Spawn
		[455373] = {},
		--Rolling Acid
		[439789] = {},
		--Savage Assault
		[444687] = {},
		--Spinneret's Strands
		[439784] = {},
		--Web Reave
		[439795] = {},
	},
	["heroic"] = {
		--Erosive Spray
		[439811] = {3.0, 29.6, 44.4, 57.5, 44.4, 56.6, 44.4, 59.1, 44.4, 59.6, 44.5, 57.4, 44.4},
		--Infested Spawn
		[455373] = {59.1, 82.9, 75.7, 29.7, 20.2, 78.9, 123.2, 57.4, 29.8, 20.2},
		--Rolling Acid
		[439789] = {41.4, 76.7, 30.2, 19.6, 95.4, 103.6, 59.5, 29.8, 20.2, 77.1},
		--Savage Assault
		[444687] = {10.5, 13.0, 23.0, 6.5, 14.9, 42.7, 14.8, 23.6, 5.9, 14.8, 3.7, 38.6, 14.8, 23.7, 5.9, 14.8, 3.5, 40.6, 14.8, 23.7, 5.9, 14.9, 3.7, 41.0, 14.8, 23.1, 6.5, 14.8, 3.7, 38.9, 14.8, 23.8, 5.9, 14.8, 3.7},
		--Spinneret's Strands
		[439784] = {14.2, 27.1, 20.2, 96.4, 81.8, 78.3, 30.3, 19.7, 79.3, 121.1},
		--Web Reave
		[439795] = {106.3, 101.6, 103.6, 104.0, 101.9},
	},
	["mythic"] = {
		--Erosive Spray
		[439811] = {},
		--Infested Spawn
		[455373] = {},
		--Rolling Acid
		[439789] = {},
		--Savage Assault
		[444687] = {},
		--Spinneret's Strands
		[439784] = {},
		--Web Reave
		[439795] = {},
	},
}

function mod:OnCombatStart(delay)
	self.vb.assaultCount = 0
	self.vb.rollingCount = 0
	self.vb.spawnCount = 0
	self.vb.strandsCount = 0
	self.vb.reaveCount = 0
	self.vb.sprayCount = 0
	self.vb.envelopingCount = 0
	--if self:IsMythic() then
	--	savedDifficulty = "mythic"
	--elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	--else--Combine LFR and Normal
	--	savedDifficulty = "normal"
	--end
	timerSavageAssaultCD:Start(allTimers[savedDifficulty][444687][1]-delay, 1)
	timerRollingAcidCD:Start(allTimers[savedDifficulty][439789][1]-delay, 1)
	timerInfestedSpawnCD:Start(allTimers[savedDifficulty][455373][1]-delay, 1)
	timerSpinneretsStrandsCD:Start(allTimers[savedDifficulty][439784][1]-delay, 1)
	timerWebReaveCD:Start(allTimers[savedDifficulty][439795][1]-delay, 1)
	timerErosiveSprayCD:Start(allTimers[savedDifficulty][439811][1]-delay, 1)
	if self:IsMythic() then
		timerEnvelopingWebsCD:Start(1)
	end
	self:EnablePrivateAuraSound(439790, "targetyou", 2)--Raid version, (434406 is in dungeon)
	--self:EnablePrivateAuraSound(434406, "targetyou", 2, 439790)--Likely dungeon version of Rolling Acid
	self:EnablePrivateAuraSound(455284, "mobout", 2)--Maybe better sound later, but this one does say "mob out" as in "mob on you, get out and spread" which is the mechanic
	self:EnablePrivateAuraSound(439815, "mobout", 2, 455284)--Secondary ID for Infested Spawn
	self:EnablePrivateAuraSound(439783, "pullin", 12)--Raid version of Spinneret's Strands
--	self:EnablePrivateAuraSound(434090, "pullin", 12, 439783)--Likely the Dungeon version of Spinneret's Strands
end

function mod:OnTimerRecovery()
	--if self:IsMythic() then
	--	savedDifficulty = "mythic"
	--elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	--else--Combine LFR and Normal
	--	savedDifficulty = "normal"
	--end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 444687 then
		self.vb.assaultCount = self.vb.assaultCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSavageAssault:Show()
			specWarnSavageAssault:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.assaultCount+1)
		if timer then
			timerSavageAssaultCD:Start(timer, self.vb.assaultCount+1)
		end
	elseif spellId == 439789 then
		self.vb.rollingCount = self.vb.rollingCount + 1
		warnRollingAcid:Show(self.vb.rollingCount)
		timerRollingAcidCD:Start()--nilil, self.vb.rollingCount+1
	elseif spellId == 455373 then
		self.vb.spawnCount = self.vb.spawnCount + 1
		warnInfestedSpawn:Show(self.vb.spawnCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.spawnCount+1)
		if timer then
			timerInfestedSpawnCD:Start(timer, self.vb.spawnCount+1)
		end
	elseif spellId == 439784 then
		self.vb.strandsCount = self.vb.strandsCount + 1
		warnSpinneretsStrands:Show(self.vb.strandsCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.strandsCount+1)
		if timer then
			timerSpinneretsStrandsCD:Start(timer, self.vb.strandsCount+1)
		end
	elseif spellId == 439795 then
		self.vb.reaveCount = self.vb.reaveCount + 1
		specWarnWebReave:Show(self.vb.reaveCount)
		specWarnWebReave:Play("gathershare")
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.reaveCount+1)
		if timer then
			timerWebReaveCD:Start(timer, self.vb.reaveCount+1)
		end
	elseif spellId == 439811 then
		self.vb.sprayCount = self.vb.sprayCount + 1
		warnErosiveSpray:Show(self.vb.sprayCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.sprayCount+1)
		if timer then
			timerErosiveSprayCD:Start(timer, self.vb.sprayCount+1)
		end
	elseif spellId == 454989 then--Mythic
		self.vb.envelopingCount = self.vb.envelopingCount + 1
		warnEnvelopingWebs:Show(self.vb.envelopingCount)
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, false, spellId, self.vb.envelopingCount+1)
		if timer then
			timerEnvelopingWebsCD:Start(timer, self.vb.envelopingCount+1)
		end
	elseif spellId == 452806 then
		if self.Options.SpecWarn452806Interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnAcidEruption:Show(args.sourceName)
			specWarnAcidEruption:Play("kickcast")
		else
			warnAcidEruption:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 458067 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
				specWarnSavageWoundSwap:Show(args.destName)
				specWarnSavageWoundSwap:Play("tauntboss")
			else
				warnSavageWound:Show(args.destName, args.amount or 1)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 421532 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:WebReaveTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellWebReave:Yell()
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 439795 then
		self:BossUnitTargetScanner(uId, "WebReaveTarget")
	end
end
