local mod	= DBM:NewMod("SoOTrash", "DBM-SiegeOfOrgrimmar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	--"SPELL_CAST_START",
	--"UNIT_SPELLCAST_SUCCEEDED",
	--"SPELL_AURA_APPLIED",
	"RAID_BOSS_WHISPER"
)

local warnLockedOn			= mod:NewTargetAnnounce(146680, 3)

local specWarnLockedOn		= mod:NewSpecialWarningRun(146680)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
--mod:AddBoolOption("RangeFrame")
--[[
function mod:SPELL_AURA_APPLIED(args)
	if not mod.Options.Enabled then return end
end

function mod:SPELL_CAST_START(args)
	if not mod.Options.Enabled then return end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not mod.Options.Enabled then return end
end
--]]

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("Ability_Siege_Engineer_Superheated") then
		specWarnLockedOn:Show()
		self:SendSync("LockedOnTarget", UnitGUID("player"))
	end
end

function mod:OnSync(msg, guid)
	if msg == "LockedOnTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnLockedOn:Show(targetName)
	end
end
