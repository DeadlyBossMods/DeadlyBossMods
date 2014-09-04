local mod	= DBM:NewMod(1195, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78948, 99999)--78948 Tectus, 80557 Mote of Tectus, 80551 Shard of Tectus
mod:SetEncounterID(1722)--Hopefully win will work fine off this because otherwise tracking shard deaths is crappy
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 162475 162968 162894 163312",
	"SPELL_AURA_APPLIED 162346 162674",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--TODO, find better icons for adds, these are filler icons for spells they use.
--Tectus
--local warnEarthenPillar				= mod:NewSpellAnnounce(162518, 3)--No way to detect unless it hits a player :\
local warnTectonicUpheaval			= mod:NewSpellAnnounce(162475, 3)
local warnCrystallineBarrage		= mod:NewTargetAnnounce(162346, 3)
local warnEarthwarper				= mod:NewSpellAnnounce("ej10061", 3, 162894)
local warnBerserker					= mod:NewSpellAnnounce("ej10062", 3, 163312)
--Night-Twisted NPCs
local warnEarthenFlechettes			= mod:NewSpellAnnounce(162968, 3, nil, mod:IsTank())
local warnGiftOfEarth				= mod:NewSpellAnnounce(162894, 4, nil, mod:IsTank())
local warnRavingAssault				= mod:NewSpellAnnounce(163312, 3)--Target scanning? Emote?

local specWarnEarthwarper			= mod:NewSpecialWarningSwitch("ej10061")
local specWarnTectonicUpheaval		= mod:NewSpecialWarningSpell(162475, nil, nil, nil, 2)
--local specWarnEarthenPillar			= mod:NewSpecialWarningSpell(162518, nil, nil, nil, 2)
local specWarnCrystallineBarrage	= mod:NewSpecialWarningYou(162894)
--Night-Twisted NPCs
local specWarnEarthenFlechettes		= mod:NewSpecialWarningSpell(162968, mod:IsTank())--Change to "move" warning if it's avoidable
local specWarnGiftOfEarth			= mod:NewSpecialWarningSpell(162894, mod:IsTank())

local timerEarthwarperCD			= mod:NewNextTimer(41, "ej10061", nil, nil, nil, 162894)
local timerBerserkerCD				= mod:NewNextTimer(41, "ej10062", nil, nil, nil, 163312)

mod:AddSetIconOption("SetIconOnEarthwarper", "ej10061", true, true)
mod:AddSetIconOption("SetIconOnMote", "ej10083", false, true)--This more or less assumes the 4 at a time strat. if you unleash 8 it will fail. Although any guild unleashing 8 is probably doing it wrong (minus LFR)

local Earthwarper = EJ_GetSectionInfo(10061)
local Berserker = EJ_GetSectionInfo(10062)
mod.vb.EarthwarperAlive = 0

function mod:OnCombatStart(delay)
	self.vb.EarthwarperAlive = 0
	timerEarthwarperCD:Start(11-delay)
	timerBerserkerCD:Start(21-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 162475 and self:AntiSpam(5, 1) then--Antispam for later fight.
		warnTectonicUpheaval:Show()
		specWarnTectonicUpheaval:Show()
	elseif spellId == 162968 then
		warnEarthenFlechettes:Show()
		specWarnEarthenFlechettes:Show()
	elseif spellId == 162894 then
		warnGiftOfEarth:Show()
		specWarnGiftOfEarth:Show()
	elseif spellId == 163312 then
		warnRavingAssault:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 162346 then
		warnCrystallineBarrage:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnCrystallineBarrage:Show()
		end
	elseif spellId == 162674 and self.Options.SetIconOnMote and not self:IsDifficulty("lfr") then--Don't mark kill/pickup marks in LFR, it'll be an aoe fest.
		self:ScanForMobs(args.destGUID, 0, 8, 4, 0.05, 10)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 80599 then
		self.vb.EarthwarperAlive = self.vb.EarthwarperAlive - 1
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 140562 then--Break Player Targetting (cast when tectus splits)
		timerEarthwarperCD:Cancel()
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
		timerEarthwarperCD:Start()
		if self.Options.SetIconOnEarthwarper and self.vb.EarthwarperAlive < 9 then--Support for marking up to 8 mobs (you're group is terrible)
			self:ScanForMobs(80599, 2, 9-self.vb.EarthwarperAlive, 1, 0.2, 10, "SetIconOnEarthwarper")
		end
	elseif npc == Berserker then
		warnBerserker:Show()
		timerBerserkerCD:Start()
	end
end
