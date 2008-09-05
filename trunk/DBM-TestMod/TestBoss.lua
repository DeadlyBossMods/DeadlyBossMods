local mod = DBM:NewMod("The Test Mod", "DBM-TestMod")
local L = mod:GetLocalizedStrings()

mod:SetModelScale(0.25)
mod:SetModelOffset(0, 0, 0)
mod:SetModelWalkSequence(4)
mod:SetModelIdleSquences(16, 18, 2, 1)

mod:SetZone(GetAddOnMetadata("DBM-TestMod", "X-DBM-Mod-LoadZone"))
mod:SetCreatureID(448)
mod:RegisterCombat("combat")
mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local testWarning1 = mod:NewAnnounce("shield_applied", 1, 48066)
local testWarning2 = mod:NewAnnounce("shield_expire", 4, 48168)
local testWarning3 = mod:NewAnnounce("shield_expire2", 2, 48066, nil, "testoption")
local testWarning4 = mod:NewAnnounce("shield_removed", 3, "Interface\\ChatFrame\\UI-ChatIcon-Blizz.blp")
local testSpecialWarning = mod:NewSpecialWarning("Special Warning Test")

local testTimer1 = mod:NewTimer(30, "shield_timer")

local enrageTest = mod:NewEnrageTimer(600)

mod:AddBoolOption("test1")
mod:AddBoolOption("test2")
mod:AddBoolOption("test3")
mod:AddBoolOption("test4")
mod:AddBoolOption("test5")
mod:AddBoolOption("test6", false, "lol!")
mod:AddBoolOption("test7", true, "lol!")
mod:AddBoolOption("test8", false, "lol!")
mod:SetOptionCategory("shield_applied", "lol!")


function mod:OnCombatStart(delay)
	self:AddMsg(delay)
	enrageTest:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48066 then -- Power Word: Shield (Rank 14)
		testWarning1:Show(args.destName)
		testWarning2:Schedule(3)
		testWarning3:Schedule(6, args.sourceName, args.spellName)
		testTimer1:Start(args.destName)
		testSpecialWarning:Show()
		testSpecialWarning:Schedule(10)
	elseif args.spellId == 48168 then -- Inner Fire (Rank 9)
		testTimer1:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48066 then -- Power Word: Shield (Rank 14)
		testWarning4:Show()
		self:ScheduleMethod(1, "TestCancel")
		testTimer1:Stop(args.destName)
	elseif args.spellId == 48168 then
		self:SendSync("TestSync", args.destName)
	end
end

function mod:TestCancel()
	testWarning2:Cancel()
	testWarning3:Cancel()
end

function mod:OnSync(event, arg)
	self:AddMsg(arg, event)
end

function mod:OnUpdate(elapsed)
--	self:AddMsg("Test: "..elapsed)
end

mod:RegisterOnUpdateHandler(mod.OnUpdate, 15)
