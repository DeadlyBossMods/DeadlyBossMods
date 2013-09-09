local mod	= DBM:NewMod("HoFTrash", "DBM-HeartofFear")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnUnseenStrike			= mod:NewTargetAnnounce(122949, 4, 123017)
local warnDispatch				= mod:NewSpellAnnounce(125877, 3)

local specWarnUnseenStrike		= mod:NewSpecialWarningYou(123017)
local specWarnUnseenStrikeOther	= mod:NewSpecialWarningTarget(123017)
local yellUnseenStrike			= mod:NewYell(122949)
local specWarnDispatch			= mod:NewSpecialWarningInterrupt(125877)

local timerUnseenStrike			= mod:NewCastTimer(4.8, 123017)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("UnseenStrikeArrow")

local spellName = GetSpellInfo(122949)

local function findUnseen()
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, spellName) then
			warnUnseenStrike:Show(name)
			if name == UnitName("player") then
				specWarnUnseenStrike:Show()
				yellUnseenStrike:Yell()
			else
				specWarnUnseenStrikeOther:Show(name)
				if mod.Options.UnseenStrikeArrow then
					DBM.Arrow:ShowRunTo(uId, 3, 3, 5)
				end
			end
			return
		end
	end
	mod:Schedule(0.1, findUnseen)
end

function mod:SPELL_CAST_START(args)
	if not mod.Options.Enabled then return end
	if args.spellId == 125877 then
		warnDispatch:Show()
		if args.sourceGUID == UnitGUID("target") then
			specWarnDispatch:Show(args.sourceName)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if not mod.Options.Enabled then return end
	if spellId == 122949 and self:AntiSpam() and self:GetCIDFromGUID(UnitGUID(uId)) == 64340 then
		self:SendSync("UnseenTrash")
	end
end

function mod:OnSync(msg)
	if msg == "UnseenTrash" then
		findUnseen()
	end
end
