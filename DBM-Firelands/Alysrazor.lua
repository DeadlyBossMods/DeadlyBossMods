local mod	= DBM:NewMod("Alysrazor", "DBM-Firelands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetModelID(38446)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_POWER"
)


local warnMolting		= mod:NewSpellAnnounce(99464, 3)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3)

local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerPhaseChange		= mod:NewTimer(30, "TimerPhaseChange")
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs")

mod:AddBoolOption("InfoFrame")

local phase = 1
function mod:OnCombatStart(delay)
	timerMoltingCD:Start(10-delay)
	timerHatchEggs:Start(50-delay)
	phase = 1
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.PowerLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464) then
		warnMolting:Show()
		timerMoltingCD:Start()
		if phase ~= 1 then
			phase = 1
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then
		warnPhase:Show(2)
		timerMolting:Cancel()
		timerPhaseChange:Start(30, 3)
		phase = 2
	end
end

function mod:UNIT_POWER(uId)
	if uId == "boss1" then
		local p = UnitPower(uId, ALTERNATE_POWER_INDEX) / UnitPowerMax(uId, ALTERNATE_POWER_INDEX) * 100
		if p == 0 then		-- Seems to drop instantly from 100 -> 0
			warnPhase:Show(3)
			phase = 3
		elseif phase == 3 and p >= 50 then
			warnPhase:Show(4)
			phase = 4
		elseif phase == 4 and p == 100 then
			timerHatchEggs:Start(38)
			warnPhase:Show(1)
			phase = 1
		end
	end
end