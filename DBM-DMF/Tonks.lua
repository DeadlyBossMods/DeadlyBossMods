local mod	= DBM:NewMod("Tonks", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 102341",
	"UNIT_SPELLCAST_SUCCEEDED player",
	"UNIT_DIED",
	"UNIT_EXITED_VEHICLE player"
)
mod.noStatistics = true

local specWarnMarked			= mod:NewSpecialWarningRun(102341, nil, nil, 2, 4, 2)

local timerGame					= mod:NewBuffActiveTimer(60, 102178, nil, nil, nil, 5, nil, nil, nil, 1, 5)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 102341 and UnitGUID("pet") == args.destGUID and self:AntiSpam() then
		specWarnMarked:Show()
		specWarnMarked:Play("justrun")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 102178 then
		timerGame:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 54588 and UnitGUID("pet") == args.destGUID then
		timerGame:Cancel()
	end
end

function mod:UNIT_EXITED_VEHICLE(uId)
	timerGame:Cancel()
end
