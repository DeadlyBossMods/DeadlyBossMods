local mod = DBM:NewMod("NorthrendBeasts", "DBM-Coliseum", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 599 $"):sub(12, -3))
mod:SetCreatureID(34797)
mod:SetMinCombatTime(30)
mod:SetZone()

-- 34816 npc to talk to
-- 34797 npc icehowl died

mod:RegisterCombat("yell", "Hailing from the deepest, darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on, heroes!")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED_DOSE"
)

local timerBreath		= mod:NewCastTimer(5, 67650)

local warnImpaleOn		= mod:NewAnnounce("WarningImpale", 2, 67478)
local warnFireBomb		= mod:NewAnnounce("WarningFireBomb", 4, 66317)
local warnSpray			= mod:NewAnnounce("WarningSpray", 2, 67616)
local warnBreath		= mod:NewAnnounce("WarningBreath", 1, 67650)
local warnRage			= mod:NewAnnounce("WarningRage", 3, 67657)

local specWarnImpale3	= mod:NewSpecialWarning("SpecialWarningImpale3", false)
local specWarnFireBomb	= mod:NewSpecialWarning("SpecialWarningFireBomb")
local specWarnSpray		= mod:NewSpecialWarning("SpecialWarningSpray")
local specWarnSilence	= mod:NewSpecialWarning("SpecialWarningSilence")
local specWarnCharge	= mod:NewSpecialWarning("SpecialWarningCharge")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67616 then
		warnSpray:Show(args.spellName, args.destName)
		if args.destName == UnitName("player") then
			specWarnSpray:Show()
		end
--	elseif args.spellId == 67478 then
--		warnImpaleOn:Show(args.spellName, args.destName)
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
	elseif args.spellId == 66313 then		-- FireBomb (Impaler)
		warnFireBomb:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg:match(L.Charge)
	if target and target == UnitName("player") then
		specWarnCharge:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if (args.spellId == 67477 or args.spellId == 66331) and args.amount >= 3 then
		if UnitName("player") == args.destName then
			specWarnImpale3:Show()
		end
		warnImpaleOn:Show(args.spellName, args.destName)
	end
end

function mod:SPELL_DAMAGE(args)
		if args.spellId == 66320 or args.spellId == 66317 then
			if UnitName("player") == args.destName then
				specWarnFireBomb:Show()
			end
		end
end

