local mod	= DBM:NewMod("EadricthePure", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(35119)
mod:SetUsedIcons(8)
--mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local isDispeller = select(2, UnitClass("player")) == "PRIEST"
				 or select(2, UnitClass("player")) == "PALADIN"

local warnHammerofRighteous		= mod:NewSpellAnnounce(66867)
local warnVengeance             = mod:NewSpellAnnounce(66889)
local warnHammerofJustice		= mod:NewTargetAnnounce(66940)
local timerVengeance			= mod:NewBuffActiveTimer(6, 66889)
local specwarnRadiance			= mod:NewSpecialWarning("specwarnRadiance")
local specwarnHammerofJustice	= mod:NewSpecialWarningDispel(66940, isDispeller)

mod:AddBoolOption("SetIconOnHammerTarget", true)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66935) then					-- Radiance Look Away!
		specwarnRadiance:Show()
	elseif args:IsSpellID(66867) then				-- Hammer of the Righteous
		warnHammerofRighteous:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(66940) then								-- Hammer of Justice on <Player>
		if self.Options.SetIconOnHammerTarget then
			self:SetIcon(args.destName, 8, 6)
		end
		warnHammerofJustice:Show(args.destName)
		specwarnHammerofJustice:Show(args.destName)
	elseif args:IsSpellID(66889) then							-- Vengeance
		warnVengeance:Show(args.destName)
		timerVengeance:Start(args.destName)
	end
end

