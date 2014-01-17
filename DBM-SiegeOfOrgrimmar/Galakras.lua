local mod	= DBM:NewMod(868, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72311, 72560, 72249, 73910, 72302, 72561, 73909)--Boss needs to engage off friendly NCPS, not the boss. I include the boss too so we don't detect a win off losing varian. :)
mod:SetEncounterID(1622)
mod:DisableESCombatDetection()
mod:SetMinSyncRevision(10768)
mod:SetHotfixNoticeRev(10768)
mod:SetReCombatTime(180, 15)--fix combat re-starts after killed. Same issue as tsulong. Fires TONS of IEEU for like 1-2 minutes after fight ends.
mod:SetMainBossID(72249)
mod:SetZone()
mod:SetUsedIcons(8, 7, 2)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 147688 146757",
	"SPELL_CAST_SUCCESS 147824 146769 146849",
	"SPELL_AURA_APPLIED 147068 147328 146899 147042",
	"SPELL_AURA_APPLIED_DOSE 147029",
	"SPELL_AURA_REMOVED 147068 147029",
	"SPELL_PERIODIC_DAMAGE 147705",
	"SPELL_PERIODIC_MISSED 147705",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UPDATE_WORLD_STATES",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

--Stage 2: Bring Her Down!
local warnWarBanner					= mod:NewSpellAnnounce(147328, 3)
local warnFracture					= mod:NewTargetAnnounce(146899, 3)
local warnChainHeal					= mod:NewCastAnnounce(146757, 4)
local warnAdd						= mod:NewCountAnnounce("ej8553", 2, "Interface\\ICONS\\INV_Misc_Head_Orc_01.blp")
local warnProto						= mod:NewCountAnnounce("ej8587", 2, 59961)
local warnTowerOpen					= mod:NewAnnounce("warnTowerOpen", 1, "Interface\\ICONS\\Achievement_BG_DefendXtowers_AV.blp")
local warnDemolisher				= mod:NewSpellAnnounce("ej8562", 3, 116040)
local warnTowerGrunt				= mod:NewAnnounce("warnTowerGrunt", 3, 89253)
----Master Cannoneer Dragryn (Tower)
local warnMuzzleSpray				= mod:NewSpellAnnounce(147824, 3)--147824 spams combat log, 147825 is actual cast but does not show in combat log only UNIT event
----Lieutenant General Krugruk (Tower)
local warnArcingSmash				= mod:NewSpellAnnounce(147688, 3)
----High Enforcer Thranok (Road)
local warnCrushersCall				= mod:NewSpellAnnounce(146769, 4)
local warnShatteringCleave			= mod:NewSpellAnnounce(146849, 3, nil, mod:IsTank())

--Phase 3: Galakras,The Last of His Progeny
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnFlamesofGalakrondTarget	= mod:NewTargetAnnounce(147068, 4)
local warnFlamesofGalakrond			= mod:NewStackAnnounce(147029, 2, nil, mod:IsTank())
local warnPulsingFlames				= mod:NewCountAnnounce(147042, 3)

--Stage 2: Bring Her Down!
local specWarnWarBanner				= mod:NewSpecialWarningSwitch(147328, not mod:IsHealer())
local specWarnFracture				= mod:NewSpecialWarningTarget(146899, mod:IsHealer())
local specWarnChainheal				= mod:NewSpecialWarningInterrupt(146757)
local specWarnFlameArrow			= mod:NewSpecialWarningMove("OptionVersion2", 146764, false)
----Master Cannoneer Dragryn (Tower)
local specWarnMuzzleSpray			= mod:NewSpecialWarningSpell(147824, nil, nil, nil, 2)
----Lieutenant General Krugruk (Tower)
local specWarnArcingSmash			= mod:NewSpecialWarningSpell(147688, nil, nil, nil, 2)
----High Enforcer Thranok (Road)
local specWarnCrushersCall			= mod:NewSpecialWarningSpell(146769, false, nil, nil, 2)--optional pre warning for the grip soon. although melee/tank probably don't really care and ranged are 50/50
----Korgra the Snake (Road)
local specWarnPoisonCloud			= mod:NewSpecialWarningMove(147705)
--Phase 3: Galakras,The Last of His Progeny
local specWarnFlamesofGalakrond		= mod:NewSpecialWarningSpell(147029, false)--Cast often, so lets make this optional since it's spammy
local specWarnFlamesofGalakrondYou	= mod:NewSpecialWarningYou(147068)
local yellFlamesofGalakrond			= mod:NewYell(147068)
local specWarnFlamesofGalakrondStack= mod:NewSpecialWarningStack("OptionVersion4", 147029, nil, 6)
local specWarnFlamesofGalakrondOther= mod:NewSpecialWarningTarget(147029, mod:IsTank())
local specWarnPulsingFlames			= mod:NewSpecialWarningSpell(147042, false, nil, nil, 2)

--Stage 2: Bring Her Down!
local timerCombatStarts				= mod:NewCombatTimer(34.5)
local timerAddsCD					= mod:NewNextCountTimer(55, "ej8553", nil, nil, nil, "Interface\\ICONS\\INV_Misc_Head_Orc_01.blp")
local timerProtoCD					= mod:NewNextCountTimer(55, "ej8587", nil, nil, nil, 59961)
local timerTowerCD					= mod:NewTimer(99, "timerTowerCD", 88852)
local timerTowerGruntCD				= mod:NewTimer(60, "timerTowerGruntCD", 89253)
local timerDemolisherCD				= mod:NewNextTimer(20, "ej8562", nil, nil, nil, 116040)--EJ is just not complete yet, shouldn't need localizing
----High Enforcer Thranok (Road)
local timerShatteringCleaveCD		= mod:NewCDTimer(7.5, 146849, nil, mod:IsTank())
local timerCrushersCallCD			= mod:NewNextTimer(30, 146769)

--Phase 3: Galakras,The Last of His Progeny
local timerFlamesofGalakrondCD		= mod:NewCDTimer(6, 147068)
local timerFlamesofGalakrond		= mod:NewTargetTimer(15, 147029, nil, mod:IsTank())
local timerPulsingFlamesCD			= mod:NewNextCountTimer(25, 147042)
local timerPulsingFlames			= mod:NewBuffActiveTimer(7, 147042)

mod:AddSetIconOption("FixateIcon", 147068)
mod:AddSetIconOption("SetIconOnAdds", "ej8556", false, true)

--Important, needs recover
mod.vb.addsCount = 0
mod.vb.firstTower = 0--0: first tower not started, 1: first tower started, 2: first tower breached
mod.vb.pulseCount = 0

local function protos()
	mod.vb.addsCount = mod.vb.addsCount + 1
	warnProto:Show(mod.vb.addsCount)
	timerAddsCD:Start(nil, mod.vb.addsCount + 1)
end

local function TowerGrunt()
	warnTowerGrunt:Show()
	timerTowerGruntCD:Start()
	mod:Schedule(60, TowerGrunt)
end

function mod:OnCombatStart(delay)
	self.vb.addsCount = 0
	self.vb.firstTower = 0
	self.vb.pulseCount = 0
--	timerAddsCD:Start(6.5-delay)--First wave actually seems to have a couple second variation, since timer is so short anyways, just disabling it
	if not self:IsDifficulty("heroic10", "heroic25") then
		timerTowerCD:Start(116.5-delay)
	else
		timerTowerGruntCD:Start(6)
		self:Schedule(6, TowerGrunt)
	end
	if self.Options.SpecWarn146764move then--specWarnFlameArrow is turned on, since it's off by default, no reasont to register high CPU events unless user turns it on
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 146764",
			"SPELL_MISSED 146764"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 147688 and UnitPower("player", 10) > 0 then--Tower Spell
		warnArcingSmash:Show()
		specWarnArcingSmash:Show()
	elseif spellId == 146757 and UnitPower("player", 10) == 0 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainheal:Show(source)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 147824 and UnitPower("player", 10) > 0 and self:AntiSpam(3, 2) then--Tower Spell
		warnMuzzleSpray:Show()
		specWarnMuzzleSpray:Show()
	elseif spellId == 146769 and UnitPower("player", 10) == 0 then
		warnCrushersCall:Show()
		specWarnCrushersCall:Show()
		timerCrushersCallCD:Start()
	elseif spellId == 146849 and UnitPower("player", 10) == 0 then
		warnShatteringCleave:Show()
		timerShatteringCleaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 147068 then
		warnFlamesofGalakrondTarget:Show(args.destName)
		timerFlamesofGalakrondCD:Start()
		if args:IsPlayer() then
			specWarnFlamesofGalakrondYou:Show()
			yellFlamesofGalakrond:Yell()
		else
			specWarnFlamesofGalakrond:Show()
		end
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 2)
		end
	elseif spellId == 147328 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnWarBanner:Show()
		specWarnWarBanner:Show()
	elseif spellId == 146899 and UnitPower("player", ALTERNATE_POWER_INDEX) == 0 then
		warnFracture:Show(args.destName)
		specWarnFracture:Show(args.destName)
	elseif spellId == 147042 then
		self.vb.pulseCount = self.vb.pulseCount + 1
		warnPulsingFlames:Show(self.vb.pulseCount)
		specWarnPulsingFlames:Show()
		timerPulsingFlames:Start()
		timerPulsingFlamesCD:Start(nil, self.vb.pulseCount + 1)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 147029 then
		local amount = args.amount or 1
		if amount >= 6 and args:IsPlayer() then
			specWarnFlamesofGalakrondStack:Show(amount)
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID then
				if self:IsTanking(uId, bossUnitID) then
					warnFlamesofGalakrond:Show(args.destName, amount)
					timerFlamesofGalakrond:Start(args.destName)
					if amount >= 6 then
						specWarnFlamesofGalakrondOther:Show(args.destName)
					end
				end
				break--break loop if find right boss
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 147068 then
		if self.Options.FixateIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 147029 then--Tank debuff version
		timerFlamesofGalakrond:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 147705 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnPoisonCloud:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 146764 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFlameArrow:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 72249 then--Main Boss ID
		DBM:EndCombat(self)
	elseif cid == 72355 then--High Enforcer Thranok
		timerShatteringCleaveCD:Cancel()
		timerCrushersCallCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
		timerAddsCD:Cancel(self.vb.addsCount + 1)
		timerProtoCD:Cancel(self.vb.addsCount + 1)
		warnPhase2:Show()
		timerFlamesofGalakrondCD:Start(13.5)
		timerPulsingFlamesCD:Start(39, 1)--unconfirmed
	end
end

--[[
TODO, see if one of these earlier says are a pull say (not sure if they are part of pull, or RP from ships landing)
"<12.2 21:55:36> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#Well done! Landing parties, form up! Footmen to the front!#King Varian Wrynn#
"<18.0 21:55:42> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#The Dragonmaw are supporting the Warchief.#Lady Jaina Proudmoore#
"<32.4 21:55:56> [CHAT_MSG_MONSTER_SAY] CHAT_MSG_MONSTER_SAY#We're going to need some serious firepower.#Lady Jaina Proudmoore
"<47.1 21:56:11> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:
"<47.9 21:56:12> [PLAYER_REGEN_DISABLED]  ++ > Regen Disabled : Entering combat! ++ > ", -- [1167]
--]]
function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	elseif msg == L.wasteOfTime2 then
		self:SendSync("prepull2")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.newForces1 or msg == L.newForces1H or msg == L.newForces2 or msg == L.newForces3 or msg == L.newForces4 then
		self:SendSync("Adds")
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(4, GetWorldStateUIInfo(4))
	local percent = tonumber(string.match(text or "", "%d+"))
	if percent == 1 and (self.vb.firstTower == 0) and not self:IsDifficulty("heroic10", "heroic25") then
		self.vb.firstTower = 1
		timerTowerCD:Start()
	end
end

--"<167.7 21:23:40> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#Warlord Zaela orders a |cFFFF0404|hKor'kron Demolisher|h|r to assault the tower!
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then--They fixed epiccenter bug (figured they would). Color code should be usuable though. It's only emote on encounter that uses it.
		warnDemolisher:Show()
		if self:IsDifficulty("heroic10", "heroic25") and self.vb.firstTower == 0 then
			timerTowerGruntCD:Start(15)
			self:Schedule(15, TowerGrunt)
			self.vb.firstTower = 2
		end
	elseif msg:find(L.tower) then
		warnTowerOpen:Show()
		timerDemolisherCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerTowerGruntCD:Cancel()
			self:Unschedule(TowerGrunt)
		end
	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(10, 4) then
		self.vb.addsCount = self.vb.addsCount + 1
		if self.vb.addsCount % 5 == 3 then
			warnAdd:Show(self.vb.addsCount)
			timerProtoCD:Start(nil, self.vb.addsCount + 1)
			self:Schedule(55, protos)
		elseif self.vb.addsCount == 1 then
			warnAdd:Show(self.vb.addsCount)
			timerAddsCD:Start(48, 2)
		else
			warnAdd:Show(self.vb.addsCount)
			timerAddsCD:Start(nil, self.vb.addsCount + 1)
		end
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(72958, 0, 8, 2, 0.2, 8)
		end
	elseif msg == "prepull" then--Alliance
		timerCombatStarts:Start()
	elseif msg == "prepull2" then--Horde
		timerCombatStarts:Start(30.5)
	end
end
