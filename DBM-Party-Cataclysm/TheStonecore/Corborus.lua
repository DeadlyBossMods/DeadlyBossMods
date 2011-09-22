local mod	= DBM:NewMod("Corborus", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43438)
mod:SetModelID(33477)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnCrystalBarrage			= mod:NewTargetAnnounce(81634, 2)
local warnDampening					= mod:NewSpellAnnounce(82415, 2)
local warnSubmerge					= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge					= mod:NewAnnounce("WarnEmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnCrystalBarrage		= mod:NewSpecialWarningYou(81634)
local specWarnCrystalBarrageClose	= mod:NewSpecialWarningClose(81634)

local timerDampening				= mod:NewCDTimer(10, 82415)
local timerSubmerge					= mod:NewTimer(80, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge					= mod:NewTimer(25, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local crystalTargets = {}

mod:AddBoolOption("CrystalArrow")
mod:AddBoolOption("RangeFrame")

local function warnCrystalTargets()
	warnCrystalBarrage:Show(table.concat(crystalTargets, "<, >"))
	table.wipe(crystalTargets)
end

function mod:OnCombatStart(delay)
	timerSubmerge:Start(30.5-delay)
	self:ScheduleMethod(30.5-delay, "Submerge")
	table.wipe(crystalTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:Submerge()
	warnSubmerge:Show()
	timerEmerge:Start()
	timerDampening:Cancel()
	self:ScheduleMethod(25, "Emerge")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:Emerge()
	warnEmerge:Show()
	timerSubmerge:Start()
	self:ScheduleMethod(80, "Submerge")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86881, 92648) then
		if args:IsPlayer() then
			specWarnCrystalBarrage:Show()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then--May also not work right if same spellid is applied to people near the target, then will need more work.
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 6 then
					specWarnCrystalBarrageClose:Show(args.destName)
					if self.Options.CrystalArrow then
						DBM.Arrow:ShowRunAway(x, y, 8, 5)
					end
				end
			end
		end
		crystalTargets[#crystalTargets + 1] = args.destName
		self:Unschedule(warnCrystalTargets)
		self:Schedule(0.2, warnCrystalTargets)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82415, 92650) then
		warnDampening:Show()
		timerDampening:Start()
	end
end