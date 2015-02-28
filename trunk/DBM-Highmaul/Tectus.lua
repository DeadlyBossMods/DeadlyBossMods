local mod	= DBM:NewMod(1195, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78948, 80557, 80551, 99999)--78948 Tectus, 80557 Mote of Tectus, 80551 Shard of Tectus
mod:SetEncounterID(1722)--Hopefully win will work fine off this because otherwise tracking shard deaths is crappy
mod:SetZone()
mod:SetMinSyncRevision(13109)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetModelSound("sound\\creature\\tectus\\VO_60_HMR_TECTUS_AGGRO_01.ogg", "sound\\creature\\tectus\\vo_60_hmr_tectus_spell_05.ogg")
mod:SetHotfixNoticeRev(13109)

mod:RegisterCombat("combat")
mod:SetMinSyncTime(4)--Rise Mountain can occur pretty often.
mod:SetWipeTime(30)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162475 162968 162894 163312",
	"SPELL_AURA_APPLIED 162346 162658",
	"SPELL_AURA_REMOVED 162346",
	"SPELL_CAST_SUCCESS 181089 181113",
	"SPELL_PERIODIC_DAMAGE 162370",
	"SPELL_ABSORBED 162370",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--TODO, find better icons for adds, these are filler icons for spells they use.
--TODO, figure out what's wrong with DBM-Core stripping most of EJ spellname in specWarnEarthwarper (it's saying "Night - Switch" instead of "Night-Twisted Earthshaper - Switch")
--Tectus
local warnCrystallineBarrage		= mod:NewTargetAnnounce(162346, 3)
local warnBerserker					= mod:NewSpellAnnounce("ej10062", 3, 163312)

local specWarnEarthwarper			= mod:NewSpecialWarningSwitch("OptionVersion2", "ej10061", "-Healer", nil, nil, nil, nil, 2)
local specWarnTectonicUpheaval		= mod:NewSpecialWarningSpell(162475, nil, nil, nil, 2, nil, 2)
local specWarnEarthenPillar			= mod:NewSpecialWarningDodge(162518, nil, nil, nil, 3, nil, 2)
local specWarnCrystallineBarrageYou	= mod:NewSpecialWarningYou(162346, nil, nil, nil, nil, nil, 2)
local yellCrystalineBarrage			= mod:NewYell(162346)
local specWarnCrystallineBarrage	= mod:NewSpecialWarningMove(162370, nil, nil, nil, nil, nil, 2)
--Night-Twisted NPCs
local specWarnRavingAssault			= mod:NewSpecialWarningDodge(163312, "Melee", nil, nil, nil, nil, 2)
local specWarnEarthenFlechettes		= mod:NewSpecialWarningDodge(162968, "Melee", nil, nil, nil, nil, 2)
local specWarnGiftOfEarth			= mod:NewSpecialWarningCount(162894, "Melee", nil, nil, nil, nil, 2)

local timerEarthwarperCD			= mod:NewNextTimer(40, "ej10061", nil, nil, nil, 162894)--Both of these get delayed by upheavel
local timerBerserkerCD				= mod:NewNextTimer(40, "ej10062", nil, "Tank", nil, 163312)--Both of these get delayed by upheavel
local timerGiftOfEarthCD			= mod:NewCDTimer(10.5, 162894, nil, "Melee")--10.5 but obviously delayed if stuns were used.
local timerEarthenFlechettesCD		= mod:NewCDTimer(14, 162968, nil, "Melee")--14 but obviously delayed if stuns were used. Also tends to be recast immediately if stun interrupted
local timerCrystalBarrageCD			= mod:NewNextSourceTimer(30, 162346, nil, false)--Very accurate but spammy mess with 4+ adds up.
local timerCrystalBarrage			= mod:NewBuffFadesTimer(15, 162346)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownEarthwarper			= mod:NewCountdown(41, "ej10061", "Melee")

local voiceCrystallineBarrage		= mod:NewVoice(162346)
local voiceEarthenFlechettes		= mod:NewVoice(162968, "Melee")
local voiceTectonicUpheaval			= mod:NewVoice(162475)
local voiceGiftOfEarth				= mod:NewVoice(162894, "Melee")
local voiceRavingAssault			= mod:NewVoice(163312)
local voiceEarthwarper				= mod:NewVoice("ej10061", "Dps")
local voiceEarthenPillar			= mod:NewVoice(162518, nil )


mod:AddSetIconOption("SetIconOnEarthwarper", "ej10061", true, true)
mod:AddSetIconOption("SetIconOnMote", "ej10064", false, true)--Working with both shard and mote. ej10083 description is bad / This more or less assumes the 4 at a time strat. if you unleash 8 it will fail. Although any guild unleashing 8 is probably doing it wrong (minus LFR)
mod:AddSetIconOption("SetIconOnCrystal", 162370, false)--icons 1 and 2, no conflict with icon on earthwarper

local UnitGUID, UnitExists = UnitGUID, UnitExists
mod.vb.EarthwarperAlive = 0
mod.vb.shardDeath = 0
mod.vb.moteDeath = 0
mod.vb.healthPhase = 0
local earthDuders = {}

local tectusN = EJ_GetEncounterInfo(1195)
local shardN = EJ_GetSectionInfo(10063)
local moteN = EJ_GetSectionInfo(10064)
local moteH = {}
local tectusGUID
local shardGUID = {}
local ltectusH, lshardC, lshardT, lmoteC, lmoteT = 1, 1, 1, 1, 1 -- not need to sync.

function mod:CustomHealthUpdate()
	local tectusH, shardC, shardT, moteC, moteT = 0, 0, 0, 0, 0
	local moteGUID = {}
	for i = 1, 5 do
		local unitID = "boss"..i
		local guid = UnitGUID(unitID)
		if UnitExists(unitID) then
			local cid = self:GetCIDFromGUID(guid)
			if cid == 78948 then
				tectusH = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
				tectusGUID = guid
				ltectusH = tectusH
			elseif cid == 80551 then
				shardC = shardC + 1
				shardT = shardT + (UnitHealth(unitID) / UnitHealthMax(unitID) * 100)
				shardGUID[guid] = true
				lshardC = shardC
				lshardT = shardT
			elseif cid == 80557 then
				moteC = moteC + 1
				moteT = moteT + (UnitHealth(unitID) / UnitHealthMax(unitID) * 100)
				moteGUID[guid] = true
				lmoteC = moteC
				lmoteT = moteH
				moteH[guid] = newhealth
			end
		end
	end
	for guid, health in pairs(moteH) do
		if not moteGUID[guid] then
			local newhealth = self:GetBossHPByGUID(guid) or health
			if newhealth >= 1 then
				self.vb.healthPhase = 3
				moteC = moteC + 1
				moteT = moteT + newhealth
				moteGUID[guid] = true
				lmoteC = moteC
				lmoteT = moteH
				moteH[guid] = newhealth
			end
		end
	end
	if DBM.BossHealth:IsShown() then
		if DBM.BossHealth:HasBoss(78948) then
			DBM.BossHealth:RemoveBoss(78948)
		end
		if tectusGUID then
			if tectusH > 0 then
				if not DBM.BossHealth:HasBoss(tectusGUID) then
					DBM.BossHealth:AddBoss(tectusGUID, tectusN)
				end
			else
				if DBM.BossHealth:HasBoss(tectusGUID) then
					DBM.BossHealth:RemoveBoss(tectusGUID)
				end
			end
		end
		for guid, value in pairs(shardGUID) do
			if shardT > 0 then
				if not DBM.BossHealth:HasBoss(guid) then
					DBM.BossHealth:AddBoss(guid, shardN)
				end
			else
				if DBM.BossHealth:HasBoss(guid) then
					DBM.BossHealth:RemoveBoss(guid)
				end
			end
		end
		for guid, health in pairs(moteH) do
			if not DBM.BossHealth:HasBoss(guid) then
				DBM.BossHealth:AddBoss(guid, moteN)
			end
		end
	end
	if self.vb.healthPhase == 1 then
		return ("(%d%%, %s)"):format(tectusH > 0 and tectusH or ltectusH, tectusN)
	elseif self.vb.healthPhase == 2 then
		return ("(%d%%, %s)"):format((shardT > 0 and shardT or lshardT) / (shardC > 0 and shardC or lshardC), shardN)
	elseif self.vb.healthPhase == 3 then
		return ("(%d%%, %s)"):format((moteT > 0 and moteT or lmoteT) / (moteC > 0 and moteC or lmoteC), moteN)
	end
	return DBM_CORE_UNKNOWN
end

function mod:OnCombatStart(delay)
	table.wipe(earthDuders)
	self.vb.EarthwarperAlive = 0
	self.vb.moteDeath = 0
	self.vb.shardDeath = 0
	self.vb.healthPhase = 1
	table.wipe(moteH)
	timerEarthwarperCD:Start(8-delay)
	countdownEarthwarper:Start(8-delay)
	timerBerserkerCD:Start(18-delay)
	if self:IsMythic() then
		--Figure out berserk
	elseif self:IsDifficulty("normal", "heroic") then
		berserkTimer:Start(-delay)--Confirmed 10 min in both.
	else
		--Find LFR berserk for LFR
	end
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
	end
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162475 and self:AntiSpam(5, 1) then--Antispam for later fight.
		specWarnTectonicUpheaval:Show()
		voiceTectonicUpheaval:Play("aesoon")
	elseif spellId == 162968 then
		local guid = args.souceGUID
		specWarnEarthenFlechettes:Show()
		timerEarthenFlechettesCD:Start(guid)
		if guid == UnitGUID("target") or guid == UnitGUID("focus") then
			voiceEarthenFlechettes:Play("shockwave")
		end
	elseif spellId == 162894 then
		local GUID = args.sourceGUID
		--Support for counts for each earth guy up.
		if not earthDuders[GUID] then
			earthDuders[GUID] = 0
		end
		earthDuders[GUID] = earthDuders[GUID] + 1
		specWarnGiftOfEarth:Show(earthDuders[GUID])
		timerGiftOfEarthCD:Start(GUID)
		voiceGiftOfEarth:Play("162894")
	elseif spellId == 163312 then
		specWarnRavingAssault:Show()
		voiceRavingAssault:Play("chargemove")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 162346 then
		warnCrystallineBarrage:CombinedShow(1, args.destName)
		timerCrystalBarrageCD:Start(30, args.sourceName, args.sourceGUID)
		if args:IsPlayer() then
			specWarnCrystallineBarrageYou:Show()
			timerCrystalBarrage:Start()
			if not self:IsLFR() then
				yellCrystalineBarrage:Yell()
				voiceCrystallineBarrage:Play("runout")
			end
		end
		if self.Options.SetIconOnCrystal and self.vb.healthPhase ~= 3 then
			self:SetSortedIcon(1, args.destName, 1, 2)--Wait 3 seconds or until we have 2 targets, mobs sometimes stagger casts.
		end
	elseif spellId == 162658 then
		local guid = args.destGUID
		local cid = self:GetCIDFromGUID(guid)
		if cid == 80557 then
			if not moteH[guid] then
				moteH[guid] = 0
			end
			if self.Options.SetIconOnMote and not self:IsLFR() then--Don't mark kill/pickup marks in LFR, it'll be an aoe fest.
				if self:AntiSpam(5, 3) then
					self:ClearIcons()--Clear any barrage icons
					self:CustomHealthUpdate()--Force update to health phase 3
				end
				self:ScanForMobs(guid, 0, 8, 8, 0.1, 20, "SetIconOnMote")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162346 then
		if args:IsPlayer() then
			timerCrystalBarrage:Cancel()
		end
		if self.Options.SetIconOnCrystal then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181113 then--Encounter Spawn
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 80599 then--Earth Warper
			self.vb.EarthwarperAlive = self.vb.EarthwarperAlive + 1
			specWarnEarthwarper:Show()
			voiceEarthwarper:Play("killmob")
			timerGiftOfEarthCD:Start(10)--TODO, verify timing on new event
			timerEarthenFlechettesCD:Start(15)--TODO, verify timing on new event
			timerEarthwarperCD:Start()--TODO, verify timing on new event
			countdownEarthwarper:Start()--TODO, verify timing on new event
			if self.Options.SetIconOnEarthwarper and self.vb.EarthwarperAlive < 9 and not (self:IsMythic() and self.Options.SetIconOnMote) then--Support for marking up to 8 mobs (you're group is terrible)
				self:ScanForMobs(80599, 2, 9-self.vb.EarthwarperAlive, 1, 0.2, 13, "SetIconOnEarthwarper")
			end
		elseif cid == 80822 then
			warnBerserker:Show()
			timerBerserkerCD:Start()
		end
	elseif spellId == 181089 then--Encounter Event
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 78948 then
			self.vb.healthPhase = 2
			if not self:IsMythic() then
				timerEarthwarperCD:Cancel()
				countdownEarthwarper:Cancel()
				timerBerserkerCD:Cancel()
			end
		elseif cid == 80551 then
			self.vb.shardDeath = self.vb.shardDeath + 1
			if self.vb.shardDeath == 2 then
				self.vb.healthPhase = 3
			end
		elseif cid == 80557 then--Mote of Tectus
			self.vb.moteDeath = self.vb.moteDeath + 1
			if self.vb.moteDeath == 8 then
				DBM:EndCombat(self)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId)
	if spellId == 162370 then
		if (self.vb.healthPhase == 0 or self.vb.healthPhase == 3) and not moteH[sourceGUID] and sourceName == moteN then -- try to recover moteH table if timer recovery worked.
			moteH[sourceGUID] = 0
		end
		if destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
			specWarnCrystallineBarrage:Show()
			voiceCrystallineBarrage:Play("runaway")
		end
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80599 then
		local GUID = args.destGUID
		self.vb.EarthwarperAlive = self.vb.EarthwarperAlive - 1
		timerGiftOfEarthCD:Cancel(GUID)--Only issue is that this won't cancel the FIRST timer which lacks a GUID, if you manage to kill it before first cast
		timerEarthenFlechettesCD:Cancel(GUID)
		earthDuders[GUID] = nil
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if msg == L.pillarSpawn or msg:find(L.pillarSpawn) then
		self:SendSync("TectusPillar")
	end
end

function mod:OnSync(msg)
	if msg == "TectusPillar" and self:IsInCombat() then
		specWarnEarthenPillar:Show()
		voiceEarthenPillar:Play("watchstep")
	end
end
