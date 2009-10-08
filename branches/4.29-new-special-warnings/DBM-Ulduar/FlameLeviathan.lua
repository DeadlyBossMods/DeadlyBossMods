local mod = DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetCreatureID(33113)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_APPLIED",	
	"CHAT_MSG_RAID_BOSS_EMOTE"
)


local timerSystemOverload	= mod:NewBuffActiveTimer(20, 62475)
local timerFlameVents		= mod:NewCastTimer(10, 62396)
local timerPursued			= mod:NewTargetTimer(30, 62374)
local warnSystemOverload	= mod:NewSpecialWarning("SystemOverload")

local pursueSpecWarn		= mod:NewSpecialWarning("SpecialPursueWarnYou")
local pursueTargetWarn		= mod:NewAnnounce("PursueWarn", 2)
local warnNextPursueSoon	= mod:NewAnnounce("warnNextPursueSoon", 3)


local guids = {}
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, GetNumRaidMembers() do
		guids[UnitGUID("raid"..i.."pet") or ""] = UnitName("raid"..i)
	end
end

function mod:OnCombatStart(delay)
	buildGuidTable()
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62396 then		-- Flame Vents
		timerFlameVents:Start()

	elseif args.spellId == 62475 then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		warnSystemOverload:Show()

	elseif args.spellId == 62374 then	-- Pursued
		local player = guids[args.destGUID]
		warnNextPursueSoon:Schedule(25)
		timerPursued:Start(player)
		pursueTargetWarn:Show(player)

		if player == UnitName("player") then
			pursueSpecWarn:Show()
		end
	end

end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62396 then
		timerFlameVents:Stop()
	end
end

