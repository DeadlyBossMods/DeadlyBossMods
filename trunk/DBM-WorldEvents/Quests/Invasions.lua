local mod	= DBM:NewMod("GarrisonInvasions", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_START 180939 180932",
	"SPELL_CAST_SUCCESS 181098",
	"SPELL_AURA_APPLIED 180950",
	"SPELL_AURA_REMOVED 180950",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)
mod.noStatistics = true
mod.isTrashMod = true--Flag as trash mod to at least disable mod during raid combat, since it stays active at all times after loaded. Doing same way as pvp mods wouldn't save any cpu really considering we'd need ZONE_CHANGED too, not just ZONE_CHANGED_NEW_AREA and this fires a ton even in raids.

--Annihilon
local warnVoidBomb				= mod:NewTargetAnnounce(180939, 3)
local warnWhirlingVoid			= mod:NewTargetAnnounce(180932, 2)
local warnTwistMind				= mod:NewTargetAnnounce(180950, 4)

--Annihilon
local specWarnVoidBomb			= mod:NewSpecialWarningYou(180939)
local yellVoidBomb				= mod:NewYell(180939)
local specWarnTwistMind			= mod:NewSpecialWarningSwitch(180950, "Dps")
--Generic
local specWarnRylak				= mod:NewSpecialWarning("specWarnRylak")
local specWarnWorker			= mod:NewSpecialWarning("specWarnWorker")
local specWarnSpy				= mod:NewSpecialWarning("specWarnSpy")
local specWarnBuilding			= mod:NewSpecialWarning("specWarnBuilding")

--Annihilon
local timerWhirlingVoidCD		= mod:NewCDTimer(14, 180932)
local timerTwistMindCD			= mod:NewCDTimer(28, 180950)

--Generic
--local timerCombatStart			= mod:NewCombatTimer(44)--rollplay for first pull

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddHudMapOption("HudMapOnMC", 180950)

mod.vb.MCCount = 0

function mod:VoidTarget(targetname, uId)
	if not targetname then return end
	warnWhirlingVoid:Show(targetname)
end

function mod:BombTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVoidBomb:Show()
		yellVoidBomb:Yell()
	else
		warnVoidBomb:Show(targetname)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 181098 then--Ammihilon Summon
		self.vb.MCCount = 0
		timerWhirlingVoidCD:Start(7.5)--Only one pull, small sample
		timerTwistMindCD:Start(34)--Only one pull, small sample
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 180939 then
		self:BossTargetScanner(90802, "BombTarget", 0.05, 25)
	elseif spellId == 180932 then
		self:BossTargetScanner(90802, "VoidTarget", 0.05, 25)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 180950 then
		self.vb.MCCount = self.vb.MCCount + 1
		warnTwistMind:CombinedShow(0.5, args.destName)--Only saw 1 target in 12 person raid, but maybe scales up in larger raid size? so combined show just in case
		if self:AntiSpam(2, 1) then
			specWarnTwistMind:Show()
			timerTwistMindCD:Start()
			if self.Options.HudMapOnMC then
				DBMHudMap:Enable()
			end
		end
		if self.Options.HudMapOnMC then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 5, 30, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 180950 then
		self.vb.MCCount = self.vb.MCCount - 1
		if self.Options.HudMapOnMC then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if self.vb.MCCount == 0 then
			specWarnTwistMind:Show()
			timerTwistMindCD:Start()
			DBMHudMap:Disable()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 90802 then--Annihilon
		--Sync died events, in case far away such as dead and released.
		self:SendSync("AnnihilonDied")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.rylakSpawn or msg:find(L.rylakSpawn) then
		specWarnRylak:Show()
	elseif msg == L.terrifiedWorker or msg:find(L.terrifiedWorker) then
		specWarnWorker:Show()
	elseif msg == L.sneakySpy or msg:find(L.sneakySpy) then
		specWarnSpy:Show()
	elseif msg == L.buildingAttack or msg:find(L.buildingAttack) then
		specWarnBuilding:Show()
	end
end

--Ogre
--"<11.02 22:30:06> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#To arms! To your posts! Our fight today is with ogres.#Sergeant Crowler###Esoth##0#0##0#4137#nil#0#false#false#false", -- [3]
--"<55.10 22:30:50> [SCENARIO_CRITERIA_UPDATE] criteriaID#25172#Info#Gorian Assault#1#6#0#false#false#false#625#228000#StepInfo#Invasion!#Follow the Sergeant#1#false#false#false#CriteriaInfo1#Follow the Sergeant#92#true#1#1#0#39813#1#25172#0#0#false", -- [40]
--Goren
--"<25.24 19:40:45> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#To arms! To your posts! And look beneath you. They'll come from below....#Sergeant Crowler
--"<71.58 19:41:31> [SCENARIO_CRITERIA_UPDATE] criteriaID#25172#Info#Something Rumbling This Way Comes#
--Iron Horde
--"<29.58 17:13:46> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#To arms! To your posts! We face a worthy foe today...#Sergeant Crowler###Omegal##0#0##0#1343#nil#0#false#false#false", -- [5]
--"<91.66 17:14:48> [SCENARIO_CRITERIA_UPDATE] criteriaID#25172#Info#The Iron Tide#1#6#0#false#false#false#0#0#StepInfo#Invasion#Follow the Sergeant.#1#false#false#false#CriteriaInfo1#Follow the Sergeant#92#true#1#1#0#39813#1#25172#0#0#false", -- [24]
--Shadow Council
--"<16.08 18:08:54> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#The air has taken a turn for the foul...#Sergeant Crowler###Omegal##0#0##0#82#nil#0#false#false#false", -- [4]
--"<63.05 18:09:41> [SCENARIO_CRITERIA_UPDATE] criteriaID#25172#Info#Amidst the Shadows#1#6#0#false#false#false#0#0#StepInfo#Invasion!#Follow the Sergeant#1#false#false#false#CriteriaInfo1#Follow the Sergeant#92#true#1#1#0#39813#1#25172#0#0#false", -- [13]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.preCombat or msg:find(L.preCombat) then
		--timerCombatStart:Start()
	end
end

function mod:OnSync(msg)
	if msg == "AnnihilonDied" then
		self.vb.MCCount = 0--For good measure
		timerWhirlingVoidCD:Cancel()
		timerTwistMindCD:Cancel()
		if self.Options.HudMapOnMC then
			DBMHudMap:Disable()
		end
	end
end
