local mod = DBM:NewMod("Auriaya", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 679 $"):sub(12, -3))

mod:SetZone()

mod:SetCreatureID(33515)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_AURA_REMOVED"
)

local canInterrupt
do
	local class = select(2, UnitClass("player"))
	canInterrupt = class == "SHAMAN"
		or class == "WARRIOR"
		or class == "ROGUE"
		or class == "MAGE"
end

mod:RemoveOption("HealthFrame") -- we don't want the automatically generated healthframe so remove the option to enable it
mod:AddBoolOption("AddHealthFrame") -- we use our own health frame instead

local warnSwarm = mod:NewGenericTargetAnnounce(64396, 2) -- do not use this method; it will be replaced sone

local specWarnBlast = mod:NewSpecialWarning("SpecWarnBlast", canInterrupt)
local warnFear = mod:NewAnnounce("WarnFear", 3, 64386)
local warnFearSoon = mod:NewAnnounce("WarnFearSoon", 1, 64386)
local warnCatDied = mod:NewAnnounce("WarnCatDied", 3, 64455)

local timerFear = mod:NewCastTimer(64386)
local timerNextFear = mod:NewNextTimer(35.5, 64386)

function mod:OnCombatStart(delay)
	if self.Options.AddHealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(33515, L.name) -- Auriaya
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64678 then -- Sentinel Blast
		specWarnBlast:Show()
	elseif args.spellId == 64386 then -- Terrifying Screech
		warnFear:Show()
		timerFear:Start()
		timerNextFear:Schedule(2)
		warnFearSoon:Schedule(34)
	elseif args.spellid == 64688 then --Sonic Screech
		-- warning needed here?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64396 then -- Guardian Swarm
		warnSwarm:Show()
	elseif args.spellId == 64455 then -- Feral Essence
		DBM.BossHealth:AddBoss(34035, L.Defender:format(9))
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args.spellId == 64455 then -- Feral Essence
		DBM.BossHealth:RemoveBoss(34035)
		DBM.BossHealth:AddBoss(34035, L.Defender:format(args.amount))
		warnCatDied:Show(args.amount)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 64455 then -- Feral Essence
		DBM.BossHealth:RemoveBoss(34035)
	end
end


