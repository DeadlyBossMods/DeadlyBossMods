local mod	= DBM:NewMod("CoMGrilek", "DBM-Party-Cataclysm", 11)
--local mod	= DBM:NewMod(603, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52258)
mod:SetModelID(37829)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnPursuit				= mod:NewTargetAnnounce(96306, 4)
local warnRupture				= mod:NewTargetAnnounce(96619, 3)

local specWarnPursuit			= mod:NewSpecialWarningRun(96306)
local specWarnRupture			= mod:NewSpecialWarningYou(96619)
local specWarnRuptureNear		= mod:NewSpecialWarningClose(96619)

local timerPursuit				= mod:NewBuffActiveTimer(15, 96306)
local timerPursuitCD			= mod:NewCDTimer(45, 96306)--Assumed, it's a very short fight.

local soundPursuit				= mod:NewSound(96306)

function mod:OnCombatStart(delay)
--	timerPursuitCD:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96619) then
		warnRupture:Show(args.destName)
		if args:IsPlayer() then
			specWarnRupture:Show()
		end
		local uId = DBM:GetRaidUnitId(args.destName)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnRuptureNear:Show(targetname)
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find(L.pursuitEmote) and self:IsInCombat() then
		timerPursuit:Start()
		timerPursuitCD:Start()
		if target then
			warnPursuit:Show(target)
			if target == UnitName("player") then
				specWarnPursuit:Show()
				soundPursuit:Play()
			end
		end
	end
end