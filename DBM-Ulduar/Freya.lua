local mod = DBM:NewMod("Freya", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

mod:AddBoolOption("AddHealthFrame")
mod:RemoveOption("HealthFrame") -- we cannot use the default static health frame as we need to be able to add/remove mobs

local specWarnSunBeam = mod:NewSpecialWarning("SpecWarnUnstableSunBeam")
local warnSunBeam = mod:NewAnnounce("WarnUnstableSunBeam", 2, 62243)
local warnPhase2 = mod:NewAnnounce("WarnPhase2", 3)
local warnSimulKill = mod:NewAnnounce("WarnSimulKill", 1)

local enrage = mod:NewEnrageTimer(600)

local timerSunBeam = mod:NewTimer(20, "TimerUnstableSunBeam", 62243)
local timerAlliesOfNature = mod:NewTimer(60, "TimerAlliesOfNature", 62678)
local timerSimulKill = mod:NewTimer(60, "TimerSimulKill")

function mod:OnCombatStart(delay)
	enrage:Start()
	if self.Options.AddHealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(L.name, 32906) -- Freya
	end
end

function mod:SPELL_AURA_APPLIED(args)
--[[	if args.spellId == 62243 then -- unstable sun beam
		warnSunBeam:Show(args.destName)
		if args.destName == UnitName("player") then
			specWarnSunBeam:Show()
		end
		self:SetIcon(args.destName, 8, 21)
		timerSunBeam:Start(args.destName)
	end]]--
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62519 then
		warnPhase2:Show()
	end
end

--[[
0xF1300081B2004D93,"Ancient Water Spirit" --> 33202
0xF130008094004D94,"Snaplasher" --> 32916
0xF130008097004D95,"Storm Lasher" --> 32919
0xF13000808A004B25,"Freya" --> 32906
]]--

local adds = {}

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62678 then -- Summon Allies of Nature
		timerAlliesOfNature:Start()
		DBM.BossHealth:AddBoss(33202, L.WaterSpirit) -- ancient water spirit
		DBM.BossHealth:AddBoss(32916, L.Snaplasher) -- snaplasher
		DBM.BossHealth:AddBoss(32919, L.StormLasher) -- storm lasher
		adds[33202] = true
		adds[32916] = true
		adds[32919] = true
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destName)
	if cid == 33202 or cid == 32916 or cid == 32919 then
		DBM.BossHealth:RemoveBoss(cid)
		if not timerSimulKill:IsStarted() then
			timerSimulKill:Start()
			warnSimulKill:Show()
		end
		adds[cid] = nil
		local counter = 0
		for i, v in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end
end


