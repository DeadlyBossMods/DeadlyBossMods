local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(37813)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBloodNova			= mod:NewSpellAnnounce(73058)
local warnMark				= mod:NewTargetAnnounce(72444)
local timerBloodNova		= mod:NewCDTimer(20, 73058)--20-25sec cooldown?
local timerNextMark			= mod:NewCDTimer(35, 72444)--Unsure if this is next or CD, so using CD for now.
local timerCallBloodBeast	= mod:NewNextTimer(30, 72173)

mod:AddBoolOption("RangeFrame")

function mod:OnCombatStart(delay)
	timerCallBloodBeast:Start(-delay)
	timerNextMark:Start(50-delay)
	timerBloodNova:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(73058, 72378) then	-- Blood Nova (only 2 cast IDs, 4 spell damage IDs, and one dummy)
		warnBloodNova:Show()
		timerBloodNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72173) then
		timerCallBloodBeast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72255, 72444, 72445, 72446) then	-- Mark of the Fallen Champion
		warnMark:Show(args.destName)
		timerNextMark:Start()
	end
end

--[[function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72255, 72444, 72445, 72446) then	-- Mark of the Fallen Champion
		mod:SetIcon(args.destName, 0)
	end
end--]]