local mod = DBM:NewMod("The Test Mod", "DBM-TestMod", GetAddOnMetadata("DBM-TestMod", "X-DBM-Mod-LoadZone"))

local L = mod:GetLocalizedStrings()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local testWarning1 = mod:NewAnnounce("shield_applied", 1, "WarnShieldApplied")
local testWarning2 = mod:NewAnnounce("shield_expire", 4, "ShieldExpireTest")
local testWarning3 = mod:NewAnnounce("shield_expire2", 2, "ShieldExpireTest2")
local testWarning4 = mod:NewAnnounce("shield_removed", 3, "WarnShieldRemoved")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48065 then -- Power Word: Shield (Rank 13)
		testWarning1:Show(args.destName)
		testWarning2:Schedule(3)
		testWarning3:Schedule(6, args.sourceName, args.spellName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48065 then
		testWarning4:Show()
		self:ScheduleMethod(1, "TestCancel")
	end
end

function mod:TestCancel()
	testWarning2:Cancel()
	testWarning3:Cancel()
end

function mod:OnUpdate(elapsed)
--	self:AddMsg("test: "..elapsed)
end

mod:RegisterOnUpdateHandler(mod.OnUpdate, 15)
