local mod	= DBM:NewMod("FoeReaper", "DBM-Party-Cataclysm", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43778)
mod:SetModelID(35606)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnOverdrive			= mod:NewSpellAnnounce(88481, 3)
local warnHarvest			= mod:NewTargetAnnounce(88495, 4)
local warnEnrage			= mod:NewSpellAnnounce(91720, 4)
local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

local specWarnHarvest		= mod:NewSpecialWarningRun(88495)
local specWarnHarvestNear	= mod:NewSpecialWarningClose(88495)

local timerHarvest			= mod:NewCastTimer(5, 88495)
local timerOverdrive		= mod:NewBuffActiveTimer(10, 88481)

local soundHarvest			= mod:NewSound(88495)

mod:AddBoolOption("HarvestIcon")

function mod:HarvestTarget()
	local targetname = self:GetBossTarget(43778)
	if not targetname then return end
		warnHarvest:Show(targetname)
		if self.Options.HarvestIcon then
			self:SetIcon(targetname, 8, 5)
		end
	if targetname == UnitName("player") then
		specWarnHarvest:Show()
		soundHarvest:Play()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnHarvestNear:Show(targetname)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(88495) then
		self:ScheduleMethod(0.1, "HarvestTarget")
		timerHarvest:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(88481) then
		warnOverdrive:Show()
		timerOverdrive:Start()
	elseif args:IsSpellID(91720) then
		warnEnrage:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(59304) and mod:IsInCombat() then
		warnSpiritStrike:Show()
	end
end