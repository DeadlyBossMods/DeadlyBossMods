local mod = DBM:NewMod("LordJaraxxus", "DBM-Trial")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34780)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnPortalSoon	= mod:NewAnnounce("PortalSoonWarning", 3)
local warnVolcanoSoon	= mod:NewAnnounce("VolcanoSoonWarning", 3)
local warnFlame			= mod:NewAnnounce("WarnFlame", 3)

local timerFlame 		= mod:NewTargetTimer(6, 68123)
local timerFlameCD		= mod:NewCDTimer(30, 68125) 
local timerFlesh		= mod:NewTargetTimer(12, 67049)
local timerFleshCD		= mod:NewCDTimer(23, 67051) 
local timerPortalCD		= mod:NewCDTimer(120, 67900)
local timerVolcanoCD	= mod:NewCDTimer(120, 67901)

local specWarnFlame		= mod:NewSpecialWarning("SpecWarnFlame")
local specWarnFlesh		= mod:NewSpecialWarning("SpecWarnFlesh")

function mod:OnCombatStart(delay)
	timerVolcano:Start(105-delay)
	timerPortal:Start(45-delay)
	warnVolcanoSoon:Schedule(110-delay)
	warnPortalSoon:Schedule(40-delay)
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67051 or args.spellId == 67049 then		-- Incinerate Flesh
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		self:SetIcon(args.destName, 8, 12)
		if args.destName == UnitName("player") then
			specWarnFlesh:Show()
		end
	elseif args.spellId == 68125 or args.spellId == 68123 then	-- Legion Flame
		local targetname = args.destName
		warnFlame:Show(args.destName)
		timerFlame:Start(args.destName)
		timerFlameCD:Start()
		self:SetIcon(args.destName, 6, 8)
		self:SendWhisper("Legion Flame on YOU!", targetname)
		if args.destName == UnitName("player") then
			specWarnFlame:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 67051 or args.spellId == 67049 then		-- Incinerate Flesh
		timerFlesh:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67901 then					-- Infernal Volcano
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)
	elseif args.spellId == 67900 or args.spellId == 67898 then	-- Nether Portal
		timerPortalCD:Start()
		warnPortalSoon:Schedule(40)
	end
end
