local mod	= DBM:NewMod(1195, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78948, 80557, 80551, 99999)--78948 Tectus, 80557 Mote of Tectus, 80551 Shard of Tectus
mod:SetEncounterID(1722)--Hopefully win will work fine off this because otherwise tracking shard deaths is crappy
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")
mod:SetMinSyncTime(4)--Rise Mountain can occur pretty often.

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162475 162968 162894 163312",
	"SPELL_AURA_APPLIED 162346 162658",
	"SPELL_AURA_REMOVED 162346",
	"SPELL_PERIODIC_DAMAGE 162370",
	"SPELL_PERIODIC_MISSED 162370",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--TODO, find better icons for adds, these are filler icons for spells they use.
--TODO, figure out what's wrong with DBM-Core stripping most of EJ spellname in specWarnEarthwarper (it's saying "Night - Switch" instead of "Night-Twisted Earthshaper - Switch")
--Tectus
local warnEarthenPillar				= mod:NewSpellAnnounce(162518, 3)--No way to detect unless it hits a player :\
local warnTectonicUpheaval			= mod:NewSpellAnnounce(162475, 3)
local warnCrystallineBarrage		= mod:NewTargetAnnounce(162346, 3)
local warnEarthwarper				= mod:NewSpellAnnounce("ej10061", 3, 162894)
local warnBerserker					= mod:NewSpellAnnounce("ej10062", 3, 163312)
--Night-Twisted NPCs
local warnEarthenFlechettes			= mod:NewSpellAnnounce(162968, 3, nil, mod:IsMelee())
local warnGiftOfEarth				= mod:NewCountAnnounce(162894, 4, nil, mod:IsMelee())
local warnRavingAssault				= mod:NewSpellAnnounce(163312, 3)--Target scanning? Emote?

local specWarnEarthwarper			= mod:NewSpecialWarningSwitch("ej10061", nil, nil, nil, nil, nil, true)
local specWarnTectonicUpheaval		= mod:NewSpecialWarningSpell(162475, nil, nil, nil, 2, nil, true)
local specWarnEarthenPillar			= mod:NewSpecialWarningSpell(162518, nil, nil, nil, 3, nil, true)
local specWarnCrystallineBarrageYou	= mod:NewSpecialWarningYou(162346, nil, nil, nil, nil, nil, true)
local yellCrystalineBarrage			= mod:NewYell(162346)
local specWarnCrystallineBarrage	= mod:NewSpecialWarningMove(162370, nil, nil, nil, nil, nil, true)
--Night-Twisted NPCs
local specWarnEarthenFlechettes		= mod:NewSpecialWarningSpell(162968, mod:IsMelee(), nil, nil, nil, nil, true)
local specWarnGiftOfEarth			= mod:NewSpecialWarningCount(162894, mod:IsTank(), nil, nil, nil, nil, true)

local timerEarthwarperCD			= mod:NewNextTimer(41, "ej10061", nil, nil, nil, 162894)--Both of these get delayed by upheavel
local timerBerserkerCD				= mod:NewNextTimer(41, "ej10062", nil, mod:IsTank(), nil, 163312)--Both of these get delayed by upheavel
local timerGiftOfEarthCD			= mod:NewCDTimer(10.5, 162894, nil, mod:IsMelee())--10.5 but obviously delayed if stuns were used.
local timerEarthenFlechettesCD		= mod:NewCDTimer(14, 162968, nil, mod:IsMelee())--14 but obviously delayed if stuns were used. Also tends to be recast immediately if stun interrupted
local timerCrystalBarrageCD			= mod:NewNextSourceTimer(30, 162346, nil, false)--Very accurate but spammy mess with 4+ adds up.
local timerCrystalBarrage			= mod:NewBuffFadesTimer(15, 162346)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownEarthwarper			= mod:NewCountdown(41, "ej10061", mod:IsMelee())

local voiceCrystallineBarrage		= mod:NewVoice(162346)
local voiceEarthenFlechettes		= mod:NewVoice(162968, mod:IsMelee())
local voiceTectonicUpheaval			= mod:NewVoice(162475)
local voiceGiftOfEarth				= mod:NewVoice(162894, mod:IsMelee())
local voiceRavingAssault			= mod:NewVoice(163312)
local voiceEarthwarper				= mod:NewVoice("ej10061", mod:IsDps())
local voiceEarthenPillar			= mod:NewVoice(162518, nil )


mod:AddSetIconOption("SetIconOnEarthwarper", "ej10061", true, true)
mod:AddSetIconOption("SetIconOnMote", "ej10064", false, true)--Working with both shard and mote. ej10083 description is bad / This more or less assumes the 4 at a time strat. if you unleash 8 it will fail. Although any guild unleashing 8 is probably doing it wrong (minus LFR)

local UnitGUID, UnitExists = UnitGUID, UnitExists
local Earthwarper = EJ_GetSectionInfo(10061)
local Berserker = EJ_GetSectionInfo(10062)
mod.vb.EarthwarperAlive = 0
local earthDuders = {}

local tectusN = EJ_GetEncounterInfo(1195)
local shardN = EJ_GetSectionInfo(10063)
local moteN = EJ_GetSectionInfo(10064)
local moteH = {}
local healthPhase = 0 -- not need to sync.
function mod:CustomHealthUpdate()
	local tectusH, shardC, shardT, moteC, moteT = 0, 0, 0, 0, 0
	if UnitExists("boss1") then
		healthPhase = 1
		tectusH = UnitHealth("boss1") / UnitHealthMax("boss1") * 100
	end
	if UnitExists("boss2") then
		healthPhase = 2
		shardC = shardC + 1
		shardT = shardT + (UnitHealth("boss2") / UnitHealthMax("boss2") * 100)
	end
	if UnitExists("boss3") then
		healthPhase = 2
		shardC = shardC + 1
		shardT = shardT + (UnitHealth("boss3") / UnitHealthMax("boss3") * 100)
	end
	for guid, health in pairs(moteH) do
		local newhealth = self:GetBossHPByGUID(guid) or health
		if newhealth >= 1 then
			healthPhase = 3
			moteC = moteC + 1
			moteT = moteT + newhealth
			moteH[guid] = newhealth
		end
	end
	if DBM.BossHealth:IsShown() then
		if UnitExists("boss1") then
			if DBM.BossHealth:HasBoss(78948) then
				DBM.BossHealth:RemoveBoss(78948)
			end
			if not DBM.BossHealth:HasBoss("boss1") then
				DBM.BossHealth:AddBoss("boss1", tectusN)
			end
		else
			if DBM.BossHealth:HasBoss("boss1") then
				DBM.BossHealth:RemoveBoss("boss1")
			end
		end
		if UnitExists("boss2") then
			if not DBM.BossHealth:HasBoss("boss2") then
				DBM.BossHealth:AddBoss("boss2", shardN)
			end
		else
			if DBM.BossHealth:HasBoss("boss2") then
				DBM.BossHealth:RemoveBoss("boss2")
			end
		end
		if UnitExists("boss3") then
			if not DBM.BossHealth:HasBoss("boss3") then
				DBM.BossHealth:AddBoss("boss3", shardN)
			end
		else
			if DBM.BossHealth:HasBoss("boss3") then
				DBM.BossHealth:RemoveBoss("boss3")
			end
		end
		for guid, health in pairs(moteH) do
			if not DBM.BossHealth:HasBoss(guid) then
				DBM.BossHealth:AddBoss(guid, moteN)
			end
		end
	end
	if healthPhase == 1 then
		return ("(%d%%, %s)"):format(tectusH, tectusN)
	elseif healthPhase == 2 then
		return ("(%d%%, %s)"):format(shardT / shardC, shardN)
	elseif healthPhase == 3 then
		return ("(%d%%, %s)"):format(moteT / moteC, moteN)
	end
	return DBM_CORE_UNKNOWN
end

function mod:OnCombatStart(delay)
	table.wipe(earthDuders)
	self.vb.EarthwarperAlive = 0
	healthPhase = 1
	table.wipe(moteH)
	timerEarthwarperCD:Start(11-delay)
	countdownEarthwarper:Start(11-delay)
	timerBerserkerCD:Start(21-delay)
	if self:IsMythic() then
		--Figure out berserk
	elseif self:IsDifficulty("normal", "heroic") then
		berserkTimer:Start(-delay)--Confirmed 10 min in both.
	else
		--Find LFR berserk for LFR
	end
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss("boss1", tectusN)
	end
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162475 and self:AntiSpam(5, 1) then--Antispam for later fight.
		warnTectonicUpheaval:Show()
		specWarnTectonicUpheaval:Show()
		voiceTectonicUpheaval:Play("aesoon")
	elseif spellId == 162968 then
		warnEarthenFlechettes:Show()
		specWarnEarthenFlechettes:Show()
		timerEarthenFlechettesCD:Start(args.sourceGUID)
		local guid = args.souceGUID
		if guid == UnitGUID("target") or guid == UnitGUID("focus") then
			voiceEarthenFlechettes:Play("watchwave")
		end
	elseif spellId == 162894 then
		local GUID = args.sourceGUID
		--Support for counts for each earth guy up.
		if not earthDuders[GUID] then
			earthDuders[GUID] = 0
		end
		earthDuders[GUID] = earthDuders[GUID] + 1
		warnGiftOfEarth:Show(earthDuders[GUID])
		specWarnGiftOfEarth:Show(earthDuders[GUID])
		timerGiftOfEarthCD:Start(GUID)
		voiceGiftOfEarth:Play("162894")
	elseif spellId == 163312 then
		warnRavingAssault:Show()
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
	elseif spellId == 162658 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 80557 then
			if not moteH[args.destGUID] then
				moteH[args.destGUID] = 0
			end
			if self.Options.SetIconOnMote and not self:IsLFR() then--Don't mark kill/pickup marks in LFR, it'll be an aoe fest.
				self:ScanForMobs(args.destGUID, 0, 8, 8, 0.05, 12)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 162346 and args:IsPlayer() then
		timerCrystalBarrage:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId)
	if spellId == 162370 then
		if (healthPhase == 0 or healthPhase == 3) and not moteH[sourceGUID] and sourceName == moteN then -- try to recover moteH table if timer recovery worked.
			moteH[sourceGUID] = 0
		end
		if destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
			specWarnCrystallineBarrage:Show()
			voiceCrystallineBarrage:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 140562 then--Break Player Targetting (cast when tectus splits)
		--TODO< need mythic logs to see if they restart. the adds don't stop spawning on mythic. but no idea if split resets the timer.
		timerEarthwarperCD:Cancel()
		countdownEarthwarper:Cancel()
		timerBerserkerCD:Cancel()
	end
end

--"<11.7 15:07:19> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#MASTER! I COME FOR YOU!#Night-Twisted Earthwarper#####0#0##0#480#nil#0#false#false", -- [1951]
--"<21.3 15:07:28> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Graaagh! KAHL...  AHK... RAAHHHH!#Night-Twisted Berserker#####0#0##0#482#nil#0#false#false", -- [4086]
function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if npc == Earthwarper then
		self.vb.EarthwarperAlive = self.vb.EarthwarperAlive + 1
		warnEarthwarper:Show()
		specWarnEarthwarper:Show()
		voiceEarthwarper:Play("killmob")
		timerGiftOfEarthCD:Start(10)
		timerEarthenFlechettesCD:Start(15)
		timerEarthwarperCD:Start()
		countdownEarthwarper:Start()
		if self.Options.SetIconOnEarthwarper and self.vb.EarthwarperAlive < 9 and not (self:IsMythic() and self.Options.SetIconOnMote) then--Support for marking up to 8 mobs (you're group is terrible)
			self:ScanForMobs(80599, 2, 9-self.vb.EarthwarperAlive, 1, 0.2, 10, "SetIconOnEarthwarper")
		end
	elseif npc == Berserker then
		warnBerserker:Show()
		timerBerserkerCD:Start()
	elseif msg == L.pillarSpawn or msg:find(L.pillarSpawn) then
		self:SendSync("TectusPillar")
	end
end

function mod:OnSync(msg)
	if msg == "TectusPillar" and self:IsInCombat() then
		warnEarthenPillar:Show()
		specWarnEarthenPillar:Show()
		voiceEarthenPillar:Play("watchstep")
	end
end
