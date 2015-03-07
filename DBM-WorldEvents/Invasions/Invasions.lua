local mod	= DBM:NewMod("GarrisonInvasions", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 181098",
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
		DBM:GetModByName("Annihilon")
		DBM:StartCombat(DBM:GetModByName("Annihilon"), 0, "SPELL_CAST_SUCCESS")
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
