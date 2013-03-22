local mod	= DBM:NewMod("Landfall", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 911, 920)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_DIED"
)

local warnDivineStorm		= mod:NewSpellAnnounce(135404, 4, nil, mod:IsMelee())
local warnDivineLight		= mod:NewSpellAnnounce(135403, 4)

local warnAchFiveAlive		= mod:NewAnnounce("WarnAchFiveAlive", 3, nil, false)

local specWarnDivineLight	= mod:NewSpecialWarningInterrupt(135403)

mod:RemoveOption("HealthFrame")

--[[ Alliance 'heroes'
68581 Daggin Windbeard 
68685 Admiral Taylor
68871 Amber Kearnen
68883 Sully "The Pickle" MxLeary
68870 Mishka
--]]

--[[ Horde 'heroes'	-- Someone verify those please :)
68997 General Nazgrim
69002 Warlord Bloodhilt
68996 Kromthar
--]]

local heroes = {
	[68581] = "Daggin Windbeard",
	[68695] = "Admiral Taylor",
	[68871] = "Amber Kearnen",
	[68883] = "Sully \"The Pickle\" MxLeary",
	[68870] = "Mishka"
}
local achievementFailed = false

function mod:OnCombatStart(delay)
	achievementFailed = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 135403 then
		warnDivineLight:Show()
		specWarnDivineLight:Show()
	elseif args.spellId == 135404 then
		warnDivineStorm:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if heroes[cid] then
		self:SendSync("AchFailed")
	end
end

function mod:OnSync(msg, str)
	if not achievementFailed and msg == "AchFailed" then
		achievementFailed = true
		warnAchFiveAlive:Show()
	end
end
