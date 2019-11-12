local mod	= DBM:NewMod("WrathEvent", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(36597, 34564, 15936)
mod:SetEncounterID(2321)
mod:SetModelID(30721)--Lich King
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetMinSyncRevision(20191108000000)--2019, November 8th

mod:RegisterCombat("combat")
mod:SetWipeTime(60)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68981 72259 72262 70498 72762",
	"SPELL_CAST_SUCCESS 69200",
	"SPELL_SUMMON 69037",
	"SPELL_AURA_APPLIED 72754 67574 66012",
	"SPELL_DAMAGE 68983",
	"SPELL_MISSED 68983",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"ZONE_CHANGED_NEW_AREA"
)

--TODO, switch defile to even faster UNIT_TARGET scanner if boss unitIDs check out from transcriptor
--Heigan
local warnTeleportSoon		= mod:NewAnnounce("WarningTeleportSoon", 2, "135736")
local warnTeleportNow		= mod:NewAnnounce("WarningTeleportNow", 3, "135736")
--Anub
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnPursue			= mod:NewTargetNoFilterAnnounce(67574, 4)
local warnFreezingSlash		= mod:NewTargetNoFilterAnnounce(66012, 2, nil, "Tank|Healer")
--Lich King
local warnRemorselessWinter = mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetNoFilterAnnounce(69200, 3) --Transition Add
local warnDefileSoon		= mod:NewSoonAnnounce(72762, 3)	--Phase 2+ Ability
local warnDefileCast		= mod:NewTargetNoFilterAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3, 71844) --Phase 2 Add
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add

--Anub
local specWarnPursue		= mod:NewSpecialWarningRun(67574, nil, nil, nil, 4, 2)
local yellPursue			= mod:NewYell(67574)
--Lich King
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
local specWarnDefileCast	= mod:NewSpecialWarningMoveAway(72762, nil, nil, nil, 3, 2) --Phase 2+ Ability
local yellDefile			= mod:NewYell(72762)
local specWarnDefileNear	= mod:NewSpecialWarningClose(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnGTFO			= mod:NewSpecialWarningGTFO(72762, nil, nil, nil, 1, 8) --Phase 2+ Ability

--Heigan
local timerTeleport			= mod:NewTimer(90, "TimerTeleport", "135736", nil, nil, 6)
--Anub
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
--Lich King
local timerDefileCD			= mod:NewCDTimer(32.5, 72762, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON, nil, 1, 6)

local seenAdds = {}

mod.vb.phase = 0

function mod:OnCombatStart(delay)
	table.wipe(seenAdds)
	self.vb.phase = 0
	self.vb.bossLeft = 4--Because we change it to 3 right away
	self.numBoss = 3
end

--function mod:OnCombatEnd()

--end

function mod:DefileTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		yellDefile:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show(targetname)
				specWarnDefileNear:Play("runaway")
			else
				warnDefileCast:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 72259) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerDefileCD:Stop()
		warnDefileSoon:Cancel()
	elseif args.spellId == 72262 then -- Quake (phase transition end)
		warnQuake:Show()
		warnDefileSoon:Schedule(32.3)
		timerDefileCD:Start(37.3)
	elseif args.spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
	elseif args.spellId == 72762 then -- Defile
		self:BossTargetScanner(args.sourceGUID, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:Schedule(27.5)
		timerDefileCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 69200 then -- Raging Spirit
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 69037 and self:AntiSpam(3, 1) then -- Summon Val'kyr
		warnSummonValkyr:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72754 and args:IsPlayer() and self:AntiSpam(2, 2) then		-- Defile Damage
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif args.spellId == 67574 then
		if args:IsPlayer() then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
			specWarnPursue:ScheduleVoice(1.5, "keepmove")
			yellPursue:Yell()
		else
			warnPursue:Show(args.destName)
		end
	elseif args.spellId == 66012 then
		warnFreezingSlash:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 68983 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
	elseif msg and msg:find(L.Emerge) then
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(65)
		timerSubmerge:Start()
	end
end

do
	--Back in room has an emote, but that requires translation, scheduling works better
	local function BackInRoom(time)
		warnTeleportNow:Show()
		timerTeleport:Start(88.5)
		warnTeleportSoon:Schedule(78.5)
	end
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if spellId == 30211 then--Teleport Self
			warnTeleportNow:Show()
			warnTeleportSoon:Schedule(37.5)
			timerTeleport:Start(47.5)
			self:Schedule(47.5, BackInRoom)
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenAdds[GUID] then
			seenAdds[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 36597 then--Lich King
				self.vb.bossLeft = self.vb.bossLeft - 1
				self.vb.phase = self.vb.phase + 1
				timerDefileCD:Start(29.1)
			elseif cid == 34564 then--Anub'arak
				self.vb.bossLeft = self.vb.bossLeft - 1
				self.vb.phase = self.vb.phase + 1
				warnSubmergeSoon:Schedule(5.5)
				timerSubmerge:Start(15.5)
			elseif cid == 15936 then--Heigan
				self.vb.bossLeft = self.vb.bossLeft - 1
				self.vb.phase = self.vb.phase + 1
				timerTeleport:Start(16)
				warnTeleportSoon:Schedule(6)
			end
		end
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	--Cleanup timers and scheduled events
	if IsEncounterInProgress() then return end--On frozen throne this event fires when near edge of area, we need to filter that canceling timers by mistake
	timerDefileCD:Stop()
	timerEmerge:Stop()
	timerSubmerge:Stop()
	timerTeleport:Stop()
	warnTeleportSoon:Cancel()
	warnEmergeSoon:Cancel()
	warnSubmergeSoon:Cancel()
	warnDefileSoon:Cancel()
end
