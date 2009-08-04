local mod = DBM:NewMod("NorthrendBeasts", "DBM-Coliseum", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 599 $"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetZone()

mod:RegisterCombat("combat", 34796)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local timerBreath		= mod:NewCastTimer(5, 67650)

local warnImpaleOn		= mod:NewAnnounce("WarningImpale", 2, 67478)
local warnSpray			= mod:NewAnnounce("WarningSpray", 2, 67616)
local warnBreath		= mod:NewAnnounce("WarningBreath", 1, 67650)
local warnRage			= mod:NewAnnounce("WarningRage", 3, 67657)

local specWarnSpray		= mod:NewSpecialWarning("SpecialWarningSpray")
local specWarnSilence	= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge	= mod:NewSpecialWarning("SpecialWarningCharge")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67616 then
		warnSpray:Show(args.spellName, args.destName)
		if args.destName == UnitName("player") then
			specWarnSpray:Show()
		end
	elseif args.spellId == 67478 then
		warnImpaleOn:Show(args.spellName, args.destName)
	elseif args.spellId == 67657 then
		warnRage:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 67648 then
		specWarnSilence:Show()
	elseif args.spellId == 67650 then
		timerBreath:Start()
		warnBreath:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg:match(L.Charge)
	if target and target == UnitName("player") then
		specWarnCharge:Show()
	end
end

