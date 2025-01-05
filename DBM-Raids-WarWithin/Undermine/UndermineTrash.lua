if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod("UndermineTrash", "DBM-Raids-WarWithin", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true
mod:SetZone(2769)
mod:RegisterZoneCombat(2769)

mod:RegisterEvents(
--	"SPELL_CAST_START,
--	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"UNIT_DIED"
)

--local warnShadowflameBomb					= mod:NewTargetAnnounce(425300, 3)

--local specWarnFixate						= mod:NewSpecialWarningYou(445553, nil, nil, nil, 1, 2)
--local specWarnGossemerWeave					= mod:NewSpecialWarningDodge(444000, nil, nil, nil, 2, 15)
--local yellInfestingSwarm					= mod:NewYell(436784)
--local yellShadowflameBombFades			= mod:NewShortFadesYell(425300)
--local specWarnPsychicScream					= mod:NewSpecialWarningInterrupt(439873, "HasInterrupt", nil, nil, 1, 2)

--local timerGossemereWeaveCD				= mod:NewCDNPTimer(17, 444000, nil, nil, nil, 3)

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 439873 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 445553 then

	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 428765 then

	end
end
--]]

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 222305 then

	end
end
--]]

--All timers subject to a ~0.5 second clipping due to ScanEngagedUnits
function mod:StartEngageTimers(guid, cid, delay)
	if cid == 222305 then

	end
end

--Abort timers when all players out of combat, so NP timers clear on a wipe
--Caveat, it won't calls top with GUIDs, so while it might terminate bar objects, it may leave lingering nameplate icons
function mod:LeavingZoneCombat()
	self:Stop(true)
end
