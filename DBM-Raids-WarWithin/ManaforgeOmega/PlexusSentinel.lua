local mod	= DBM:NewMod(2684, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(233814)
mod:SetEncounterID(3129)
mod:SetHotfixNoticeRev(20250813000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

--mod:AddCustomAlertSoundOption(1280960, true, 1)
--mod:AddCustomTimerOptions(1280960, true, 4, 0)
--Midnight private aura replacements
mod:AddPrivateAuraSoundOption(1219439, true, 1219439, 1)
mod:AddPrivateAuraSoundOption(1219459, true, 1219459, 1)
mod:AddPrivateAuraSoundOption(1219607, true, 1219607, 1)
mod:AddPrivateAuraSoundOption(1219354, true, 1219354, 1)--GTFO

function mod:OnLimitedCombatStart()
--	self:DisableSpecialWarningSounds()--Prevents special warning sounds playing from the ENCOUNTER_WARNING api
--	self:EnableTimelineOptions(1280946, 421)
--	self:EnableAlertOptions(1280946, 421, "kickcast", 2)
	self:EnablePrivateAuraSound(1219439, "runout", 2)
	self:EnablePrivateAuraSound(1219459, "runout", 2)
	self:EnablePrivateAuraSound(1219607, "gathershare", 2)
	self:EnablePrivateAuraSound(1219531, "gathershare", 2, 1219607)
	self:EnablePrivateAuraSound(1219354, "watchfeet", 8)
end

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1219450 1219263 1219531 1220489 1220553 1220555 1234733",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1219459 1219439 1219607 1218625 1219531",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 1219459 1219439 1219607 1220618 1220981 1220982",
	"SPELL_PERIODIC_DAMAGE 1219354",
	"SPELL_PERIODIC_MISSED 1219354"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
--]]

--[[
(ability.id = 1220489 or ability.id = 1220553 or ability.id = 1220555) and type = "begincast"
 or (ability.id = 1220618 or ability.id = 1220981 or ability.id = 1220982) and type = "removebuff"
 or ability.id = 1234733 and type = "begincast"
--]]
--[[
--Stage One: Purge The Intruders
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(31626))
local warnManifestMatrices							= mod:NewTargetAnnounce(1219450, 3)
local warnDisplacementMatrix						= mod:NewTargetNoFilterAnnounce(1218625, 4)
local warnEradicatingSalvo							= mod:NewTargetCountAnnounce(1219607, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnManifestMatrices						= mod:NewSpecialWarningMoveAway(1219450, nil, nil, DBM_COMMON_L.POOL, 1, 2)
local yellManifestMatrices							= mod:NewShortYell(1219450, DBM_COMMON_L.POOL)
local yellManifestMatricesFades						= mod:NewShortFadesYell(1219450)
local specWarnObliterationArcanocannon				= mod:NewSpecialWarningYouCount(1219263, nil, 37859, nil, 1, 2)
local yellObliterationArcanocannon					= mod:NewShortYell(1219263, 37859)
local yellObliterationArcanocannonFades				= mod:NewShortFadesYell(1219263)
local specWarnObliterationArcanocannonOther			= mod:NewSpecialWarningTaunt(1219263, nil, 37859, nil, 1, 2)
local specWarnEradicatingSalvo						= mod:NewSpecialWarningYouCount(1219531, nil, nil, DBM_COMMON_L.GROUPSOAK, 1, 2)
local yellEradicatingSalvo							= mod:NewShortYell(1219607, DBM_COMMON_L.GROUPSOAK, nil, nil, "YELL")
local yellEradicatingSalvoFades						= mod:NewShortFadesYell(1219607, nil, nil, nil, "YELL")
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1219607, nil, nil, nil, 1, 8)

local timerManifestMatricesCD						= mod:NewVarCountTimer("v33.1-38.9", 1219450, DBM_COMMON_L.POOLS.." (%s)", nil, nil, 3)
local timerObliterationArcanocannonCD				= mod:NewVarCountTimer("v34.0-36.5", 1219263, 37859, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Shortname "Bomb"
local timerEradicatingSalvoCD						= mod:NewVarCountTimer("v34.0-36.5", 1219607, DBM_COMMON_L.GROUPSOAK.." (%s)", nil, nil, 3)
--Stage Two: The Sieve Awakens
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(31634))
local specWarnProtocolPurge							= mod:NewSpecialWarningCount(1220489, nil, nil, nil, 3, 2)
local warnCleansetheChamber							= mod:NewSpellAnnounce(1234733, 4)

local timerProtocolPurgeCD							= mod:NewCDCountTimer(97.3, 1220489, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)
local timerCleansetheChamberCD						= mod:NewCDCountTimer(97.3, 1234733, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)

mod.vb.matricesCount = 0
mod.vb.arcanocannonCount = 0
mod.vb.eradicatingSalvoCount = 0
mod.vb.radicatingIcon = 1
mod.vb.purgeCount = 0

local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[0] = {
			[1219450] = {"v8.4-9.5", 28.1},--Manifest Matrices
			[1219263] = {21.7, 30.4},--Obliteration Arcanocannon
			[1219531] = {41.0},--Eradicating Salvo
		},
		[1] = {--1 and 2 should be identical
			[1219450] = {"v4.5-5.8", "v23.1-26.8", "v23.1-28", "v24.4-26.8"},--Manifest Matrices
			[1219263] = {"v12.6-14.3", "v28.0-29.2", "v28.0-29.3"},--Obliteration Arcanocannon
			[1219531] = {"v19.4-21.6", "v31.6-35", "v32-35"},--Eradicating Salvo
			[1234733] = {32.5},--Cleanse the Chamber
		},
		[2] = {--1 and 2 should be identical
			[1219450] = {"v4.7-5.8", "v23.1-26.8", "v23.1-28", "v24.4-26.8"},--Manifest Matrices
			[1219263] = {"v12.6-14.3", "v28.0-29.2", "v28.0-29.3"},--Obliteration Arcanocannon
			[1219531] = {"v19.4-21.6", "v31.6-35", "v32-35"},--Eradicating Salvo
			[1234733] = {27.3},--Cleanse the Chamber
		},
		[3] = {--Need more data to get soft enrage repeater
			[1219450] = {"v4.8-5.4", 23.1, 23.1, "v23.1-33.1", "v23.1-33.1"},--Manifest Matrices
			[1219263] = {13.3, 29.1, 29.2, "25.6-32.8", "30.4-32.8"},--Obliteration Arcanocannon
			[1219531] = {"v19.3-21.2", "v31.6-33.7", "v36.9-38.2", 31.6},--Eradicating Salvo
			[1234733] = {65.3, 6, 9.7, 6.9, 11.3, 11, 7, 6.3, 11, 9.7, 7},--Cleanse the Chamber
		},
	},
	["heroic"] = {
		[0] = {
			[1219450] = {10.4, 34.0},--Manifest Matrices
			[1219263] = {21.2, 32.9},--Obliteration Arcanocannon
			[1219531] = {30.1},--Eradicating Salvo
		},
		[1] = {
			[1219450] = {6.2, 35.2, 35.2},--Manifest Matrices
			[1219263] = {"v17.9-20.3", "v34.0-35.2", 34.0},--Obliteration Arcanocannon
			[1219531] = {"v27.9-28.7", "v34.0-35.2"},--Eradicating Salvo
		},
		[2] = {
			[1219450] = {6.2, 35.2, 35.2},--Manifest Matrices
			[1219263] = {"v18.2-20.2", "v34.0-35.2", 34.0},--Obliteration Arcanocannon
			[1219531] = {"v27.9-28.7", "v34.0-35.2"},--Eradicating Salvo
		},
		[3] = {--Need more data to get soft enrage repeater
			[1219450] = {6.4, 35.2, 35.2, 35.2, 36.4},--Manifest Matrices
			[1219263] = {18.5, 34.0, 36.4, 35.2, 34.4},--Obliteration Arcanocannon
			[1219531] = {28.2, 37.6, 35.2, 35.2},--Eradicating Salvo
			[1234733] = {62.2, 11, 8, 5.2, 9.7, 11, 6, 6.9, 10, 12.1, 6.1, 7, 5.2, 9.7, 12, 5, 7, 5.2, 9.7},--Cleanse the Chamber
		},
	},
	["normal"] = {
		[0] = {
			[1219450] = {10.6, 33.9},--Manifest Matrices
			[1219263] = {20.9, 32.8},--Obliteration Arcanocannon
			[1219531] = {30.0},--Eradicating Salvo
		},
		[1] = {
			[1219450] = {"v5.4-6.5", 35.2, "v35.2-37.0"},--Manifest Matrices
			[1219263] = {18.2, 34.0, "v33.5-34.0"},--Obliteration Arcanocannon
			[1219531] = {27.9, "v34.0-35.2"},--Eradicating Salvo
		},
		[2] = {
			[1219450] = {"v5.4-6.5", 35.2, "v35.2-37.0"},--Manifest Matrices
			[1219263] = {18.2, 34.0, "v33.5-34.0"},--Obliteration Arcanocannon
			[1219531] = {27.9, "v34.0-35.2"},--Eradicating Salvo
		},
		[3] = {--Eventually normal becomes 36.4 repeating?
			[1219450] = {6.1, 35.2, 35.2, 38.8, 35.2, 36.4, 36.4, 36.4},--Manifest Matrices
			[1219263] = {18.2, 34.0, 36.5, 34.0, 36.4, 36.4, 36.4, 36.4},--Obliteration Arcanocannon
			[1219531] = {28.0, 34.0, 35.2, 36.4, 36.4, 36.4, 36.4},--Eradicating Salvo
			[1234733] = {93, 11, 7.3, 7.3, 9.7, 10.9, 7.3, 7.3, 9.1, 11, 7.3, 7.3, 9.7, 11, 7.3, 7.3, 9.7, 11, 7.3, 7.3, 9.7},--Cleanse the Chamber
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.matricesCount = 0
	self.vb.arcanocannonCount = 0
	self.vb.eradicatingSalvoCount = 0
	self.vb.radicatingIcon = 1
	self.vb.purgeCount = 0
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	timerManifestMatricesCD:Start(allTimers[savedDifficulty][0][1219450][1], 1)
	timerObliterationArcanocannonCD:Start(allTimers[savedDifficulty][0][1219263][1], 1)
	timerEradicatingSalvoCD:Start(allTimers[savedDifficulty][0][1219531][1], 1)
	timerProtocolPurgeCD:Start(60.8, 1)--Was 69 on heroic but not likely still 69 since it was 61 on normal and mythic
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1219450 then
		self.vb.matricesCount = self.vb.matricesCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.purgeCount, spellId, self.vb.matricesCount+1)
		if timer then
			timerManifestMatricesCD:Start(timer, self.vb.matricesCount+1)
		end
	elseif spellId == 1219263 then
		self.vb.arcanocannonCount = self.vb.arcanocannonCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.purgeCount, spellId, self.vb.arcanocannonCount+1)
		if timer then
			timerObliterationArcanocannonCD:Start(timer, self.vb.arcanocannonCount+1)
		end
	elseif spellId == 1219531 then
		self.vb.eradicatingSalvoCount = self.vb.eradicatingSalvoCount + 1
		local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.purgeCount, spellId, self.vb.eradicatingSalvoCount+1)
		if timer then
			timerEradicatingSalvoCD:Start(timer, self.vb.eradicatingSalvoCount+1)
		end
	elseif spellId == 1220489 or spellId == 1220553 or spellId == 1220555 then
		self:SetStage(2)
		self.vb.purgeCount = self.vb.purgeCount + 1
		specWarnProtocolPurge:Show(self.vb.purgeCount)
		specWarnProtocolPurge:Play("findshelter")
		--Stop all timers
		timerManifestMatricesCD:Stop()
		timerObliterationArcanocannonCD:Stop()
		timerEradicatingSalvoCD:Stop()
	elseif spellId == 1234733 then
		warnCleansetheChamber:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1219459 then
		warnManifestMatrices:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnManifestMatrices:Show()
			specWarnManifestMatrices:Play("runout")
			yellManifestMatrices:Yell()
			yellManifestMatricesFades:Countdown(spellId)
		end
	elseif spellId == 1219439 then
		if args:IsPlayer() then
			specWarnObliterationArcanocannon:Show(self.vb.arcanocannonCount)
			specWarnObliterationArcanocannon:Play("runout")
			yellObliterationArcanocannon:Yell()
			yellObliterationArcanocannonFades:Countdown(spellId)
		else
			specWarnObliterationArcanocannonOther:Show(args.destName)
			specWarnObliterationArcanocannonOther:Play("tauntboss")
		end
	--"<40.79 18:58:21> [CLEU] SPELL_AURA_APPLIED#Creature-0-4247-2810-5972-233814-000020B84E#Plexus Sentinel#Player-1084-0AF5B15C#Rycnpinkx#1219607#Eradicating Salvo#DEBUFF#nil#nil#nil#nil#nil"
	--"<45.79 18:58:26> [CLEU] SPELL_AURA_APPLIED#Creature-0-4247-2810-5972-233814-000020B84E#Plexus Sentinel#Player-1084-0AF5B15C#Rycnpinkx#1219531#Eradicating Salvo#DEBUFF#nil#nil#nil#nil#nil",
	--"<48.29 18:58:29> [CLEU] SPELL_AURA_REMOVED#Creature-0-4247-2810-5972-233814-000020B84E#Plexus Sentinel#Player-1084-0AF5B15C#Rycnpinkx#1219607#Eradicating Salvo#DEBUFF#nil#nil#ni
	elseif spellId == 1219607 then
		if args:IsPlayer() then
			specWarnEradicatingSalvo:Show(self.vb.eradicatingSalvoCount)
			specWarnEradicatingSalvo:Play("gathershare")
			yellEradicatingSalvo:Yell()
			if self:IsHard() then
				yellEradicatingSalvoFades:Countdown(5)--We need to shorten it from 7.5 to 5 because first goes off at 5 and second at 7.5
			else
				yellEradicatingSalvoFades:Countdown(spellId)
			end
		end
		warnEradicatingSalvo:Show(self.vb.eradicatingSalvoCount, args.destName)
	elseif spellId == 1219531 and self:IsHard() then--Ignore on normal in LFR, it doesnt have second missile.
		if args:IsPlayer() then
	--		yellEradicatingSalvo:Yell()
			yellEradicatingSalvoFades:Countdown(2.5)
		end
	elseif spellId == 1218625 then
		warnDisplacementMatrix:CombinedShow(0.3, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1219459 then
		if args:IsPlayer() then
			yellManifestMatricesFades:Cancel()
		end
	elseif spellId == 1219439 then
		if args:IsPlayer() then
			yellObliterationArcanocannonFades:Cancel()
		end
	elseif spellId == 1219607 then
		if self.Options.SetIconOnEradicatingSalvo then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellEradicatingSalvoFades:Cancel()
		end
	elseif spellId == 1220618 or spellId == 1220981 or spellId == 1220982 then--Purge Removed
		self:SetStage(1)
		--restart Timers
		self.vb.matricesCount = 0
		self.vb.arcanocannonCount = 0
		self.vb.eradicatingSalvoCount = 0
		self.vb.radicatingIcon = 1
		timerManifestMatricesCD:Start(allTimers[savedDifficulty][self.vb.purgeCount][1219450][1], 1)
		timerObliterationArcanocannonCD:Start(allTimers[savedDifficulty][self.vb.purgeCount][1219263][1], 1)
		timerEradicatingSalvoCD:Start(allTimers[savedDifficulty][self.vb.purgeCount][1219531][1], 1)
		if self.vb.purgeCount < 3 then
			timerProtocolPurgeCD:Start(94, self.vb.purgeCount+1)
			if self:IsMythic() then
				--This only happens before final stage on mythic
				timerCleansetheChamberCD:Start(allTimers[savedDifficulty][self.vb.purgeCount][1234733][1], 1)
			end
		else
			--This happens on all difficulties after 3rd
			timerCleansetheChamberCD:Start(allTimers[savedDifficulty][self.vb.purgeCount][1234733][1], 1)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1219354 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
