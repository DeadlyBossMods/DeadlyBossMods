local mod	= DBM:NewMod(698, "DBM-Party-MoP", 5, 321)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(61398)
mod:SetModelID(41987)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)


local warnGroundSmash	= mod:NewCastAnnounce(119684, 4)
local warnRoar			= mod:NewSpellAnnounce(122959, 3, nil, mod:IsTank() or mod:IsHealer())

local specwarnSmash		= mod:NewSpecialWarningMove(119684, mod:IsTank())

local timerSmashCD		= mod:NewCDTimer(28, 119684)
--local timerRoarCD		= mod:NewCDTimer(48, 122959)--Need to confirm, i crashed during log and only got 2 casts, so only one CD, not enough confirmation for me.

function mod:OnCombatStart(delay)
	timerSmashCD:Start(9.5-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119684) then
		warnGroundSmash:Show()
		specwarnSmash:Show()
		timerSmashCD:Start()
	elseif args:IsSpellID(122959) then
		warnRoar:Show()
--		timerRoarCD:Start()
	end
end

--[[
Notes
1a. This boss has a LOT of traps that do not show in combat log, as a result, the mod will be incomplete until we have transcriptor logs
1b. If transcriptor doesn't show cast events, then we can use locals i guess from emotes.
1c. i'd rathor wait til mods are enabled and do it a non localized way first.
5/2 14:32:02.158  Xin the Weaponmaster activates his Whirlwinding Axe trap!
5/2 14:32:50.293  Xin the Weaponmaster activates his Stream of Blades trap!
--]]