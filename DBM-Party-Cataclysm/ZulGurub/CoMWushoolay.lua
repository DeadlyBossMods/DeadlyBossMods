local mod	= DBM:NewMod(180, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 5749 $"):sub(12, -3))
mod:SetCreatureID(52286)
mod:SetModelID(37831)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnRush			= mod:NewCastAnnounce(96697, 3)
local warnRod			= mod:NewCastAnnounce(96698, 4)

local specWarnRush		= mod:NewSpecialWarningYou(96697)--Assumed target scanning even works here, if it doesn't mod will be broken.
local specWarnRushNear	= mod:NewSpecialWarningClose(96697)--Assumed target scanning even works here, if it doesn't mod will be broken.
local specWarnCloud		= mod:NewSpecialWarningMove(96710)

local timerRushCD		= mod:NewNextTimer(25, 96697)

function mod:OnCombatStart(delay)
	timerRushCD:Start(15.5-delay)--Consistent?
end

function mod:LightingRushTarget()
	local targetname = self:GetBossTarget(52286)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnRush:Show()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange <14 then
				specWarnRushNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(96697) then
		self:ScheduleMethod(0.2, "LightingRushTarget")
		warnRush:Show()
		timerRushCD:Start()
	elseif args:IsSpellID(96698) then
		warnRod:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96710, 96711) and args:IsPlayer() then
		specWarnCloud:Show()
	end
end