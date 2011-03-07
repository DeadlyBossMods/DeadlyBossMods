if tonumber((select(2, GetBuildInfo()))) < 13682 then return end
local mod	= DBM:NewMod("Akilzon5", "DBM-Party-Cataclysm", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(23574)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnStorm			= mod:NewTargetAnnounce(43648, 4)
local warnStormSoon		= mod:NewSoonAnnounce(43648, 5, 3)
local warnPlucked		= mod:NewTargetAnnounce(97318, 3)

local specWarnStorm		= mod:NewSpecialWarningSpell(43648)

local timerStorm		= mod:NewCastTimer(8, 43648)
local timerStormCD		= mod:NewCDTimer(55, 43648)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("StormIcon", true)

function mod:OnCombatStart(delay)
	warnStormSoon:Schedule(43)
	timerStormCD:Start(48)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43648) then
		warnStorm:Show(args.destName)
		specWarnStorm:Show()
		timerStorm:Start()
		warnStormSoon:Schedule(50)
		timerStormCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
			mod:Schedule(10, function()
				DBM.RangeCheck:Show()
			end)
		end
		if self.Options.StormIcon then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(97318) then
		warnPlucked:Show(args.destName)	
	end
end
