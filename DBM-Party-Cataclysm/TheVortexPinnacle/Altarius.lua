local mod	= DBM:NewMod("Altairus", "DBM-Party-Cataclysm", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43873)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBreath		= mod:NewTargetAnnounce(88308, 2)
local warnUpwind		= mod:NewSpellAnnounce(88282, 4, nil, false)--Mega spam (the aura seems to be a periodic trigger, even if it doesn't change, you get like 5 warnings for SAME one in a row.
local warnDownwind		= mod:NewSpellAnnounce(88286, 3, nil, false)--More mega spam

local specWarnBreath	= mod:NewSpecialWarningYou(88308)
local specWarnBreathNear= mod:NewSpecialWarningClose(88308)

local timerBreath		= mod:NewCastTimer(2, 88308)
local timerBreathCD		= mod:NewCDTimer(12, 88308)

mod:AddBoolOption("BreathIcon")

function mod:BreathTarget()
	local targetname = self:GetBossTarget(43873)
	if not targetname then return end
		warnBreath:Show(targetname)
		if self.Options.BreathIcon then
			self:SetIcon(targetname, 8, 4)
		end
	if targetname == UnitName("player") and not mod:IsTank() then--Tank doesn't care about this so if your current spec is tank ignore this warning.
		specWarnBreath:Show()
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnBreathNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(88282) then
		warnUpwind:Show()
	elseif args:IsSpellID(88286) then
		warnDownwind:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(88308, 93989) then
		self:ScheduleMethod(0.2, "BreathTarget")
		timerBreath:Start()
		timerBreathCD:Start()
	end
end