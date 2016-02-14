local mod	= DBM:NewMod(1665, "DBM-Party-Legion", 5, 767)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(91004)
mod:SetEncounterID(1791)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 198496 198443 193375",
--	"SPELL_DAMAGE 193273",
--	"SPELL_MISSED 193273",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnStrikeofMountain			= mod:NewTargetAnnounce(198443, 2)
local warnBellowofDeeps				= mod:NewSpellAnnounce(193375, 2)--Change to special warning if they become important enough to switch to
local warnStanceofMountain			= mod:NewSpellAnnounce(198509, 2)

local specWarnSunder				= mod:NewSpecialWarningSpell(198496, "Tank", nil, nil, 1, 2)
local yellStrikeofMountain			= mod:NewYell(198443)

local timerSunderCD					= mod:NewCDTimer(8.5, 198496, nil, "Tank", nil, 5)
local timerStrikeCD					= mod:NewCDTimer(15.5, 198443, nil, "Tank", nil, 5)

local voiceSunder					= mod:NewVoice(198496, "Tank")--defensive

function mod:StrikeTarget(targetname, uId)
	if not targetname then return end
	warnStrikeofMountain:Show(targetname)
	if targetname == UnitName("player") then
		yellStrikeofMountain:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerSunderCD:Start(7-delay)
	timerStrikeCD:Start(17-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 198496 then
		specWarnSunder:Show()
		voiceSunder:Play("defensive")
		timerSunderCD:Start()
	elseif spellId == 198443 then
		timerStrikeCD:Start()
		self:BossTargetScanner(91004, "StrikeTarget", 0.2, 12, true, nil, nil, nil, true)
	elseif spellId == 193375 then
		warnBellowofDeeps:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 193273 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then

	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 198509 then--Stance of the Mountain
		warnStanceofMountain:Show()
		timerSunderCD:Cancel()
		timerStrikeCD:Cancel()
	end
end
