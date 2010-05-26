local mod	= DBM:NewMod("Saviana", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39747)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningWarnConflag	= mod:NewSpellAnnounce(74452, 3)--Will change to a target announce if possible. need to do encounter
local warningWarnEnrage		= mod:NewSpellAnnounce(78722, 3)
local warningWarnBreath		= mod:NewSpellAnnounce(74404, 3)

local specWarnConflag		= mod:NewSpecialWarningYou(74452)--Target scanning may not even work since i haven't done encounter yet it's just a guess.
local specWarnConflagNear	= mod:NewSpecialWarning("specWarnConflagNear")--Same as above, may not work. Need to do encounter to test.
local specWarnTranq			= mod:NewSpecialWarning("SpecialWarningTranq", mod:CanRemoveEnrage())

local timerConflagCD		= mod:NewNextTimer(35, 74452)
local timerBreath			= mod:NewNextTimer(35, 74404)
local timerEnrage			= mod:NewBuffActiveTimer(10, 78722)

mod:AddBoolOption("YellOnConflag", true, "announce")
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("ConflagIcon")

function mod:OnCombatStart(delay)
	timerConflagCD:Start(33-delay)
	timerBreath:Start(45-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:ConflagTarget()--May not even work, also don't know if it's done to more than one person on 25 man, if it is, then this function would be limited
	local targetname = self:GetBossTarget(39747)
	if not targetname then return end
	if self.Options.ConflagIcon then
		self:SetIcon(targetname, 8, 6)
	end
	if targetname == UnitName("player") then
		specWarnConflag:Show()
		if self.Options.YellOnConflag then
			SendChatMessage(L.YellConflag, "SAY")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnConflagNear:Show()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74452) then
		warningWarnConflag:Show()
		timerConflagCD:Start()
		self:ScheduleMethod(0.1, "ConflagTarget")
	elseif args:IsSpellID(74403, 74404) then
		warningWarnBreath:Show()
		timerBreath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(78722) then
		warningWarnEnrage:Show()
		specWarnTranq:Show()
		timerEnrage:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(78722) then
		timerEnrage:Cancel()
	end
end