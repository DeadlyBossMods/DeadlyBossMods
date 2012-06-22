local mod	= DBM:NewMod("Corborus", "DBM-Party-Cataclysm", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43438)
mod:SetModelID(33477)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnCrystalBarrage			= mod:NewTargetAnnounce(81634, 2)
local warnDampening					= mod:NewSpellAnnounce(82415, 2)
local warnSubmerge					= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge					= mod:NewAnnounce("WarnEmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local specWarnCrystalBarrage		= mod:NewSpecialWarningYou(81634)
local specWarnCrystalBarrageClose	= mod:NewSpecialWarningClose(81634)

local timerDampening				= mod:NewCDTimer(10, 82415)
local timerSubmerge					= mod:NewTimer(80, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge					= mod:NewTimer(30, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local crystalTargets = {}

mod:AddBoolOption("CrystalArrow")
mod:AddBoolOption("RangeFrame")

local function warnCrystalTargets()
	warnCrystalBarrage:Show(table.concat(crystalTargets, "<, >"))
	table.wipe(crystalTargets)
end

function mod:OnCombatStart(delay)
	timerSubmerge:Start(30-delay)
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

--"<6.5> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Corborus#0xF130A9AE00013D1D#elite#2904790#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [40]
--"<36.5> [UNIT_SPELLCAST_SUCCEEDED] Corborus:Possible Target<Omegal>:boss1:ClearAllDebuffs::0:34098", -- [1228]
--"<65.6> [UNIT_SPELLCAST_SUCCEEDED] Corborus:Possible Target<nil>:boss1:Emerge::0:81948", -- [1830]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(34098) and self:AntiSpam() then--ClearAllDebuffs, He casts this before borrowing.
		warnSubmerge:Show()
		timerEmerge:Start()
		timerDampening:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellName == GetSpellInfo(81948) and self:AntiSpam() then--Emerge, He casts this before borrowing.
		warnEmerge:Show()
		timerSubmerge:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	end
end