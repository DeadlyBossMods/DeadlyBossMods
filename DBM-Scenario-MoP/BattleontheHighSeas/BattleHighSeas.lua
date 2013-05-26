local mod	= DBM:NewMod("d652", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 940)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Lieutenant Drak'on
local warnSwashbuckling			= mod:NewSpellAnnounce(141438, 4)
--Lieutenant Fizzel
local warnThrowBomb				= mod:NewSpellAnnounce(132995, 3, nil, false)
local warnVolatileConcoction	= mod:NewSpellAnnounce(141327, 3)
--Admiral Hagman
local warnVerticalSlash			= mod:NewSpellAnnounce(141187, 4)

--Lieutenant Drak'on
local specWarnWaterJets			= mod:NewSpecialWarningSpell(133121, false)
--Lieutenant Fizzel
local specWarnVolatileConcoction= mod:NewSpecialWarningSpell(141327)
--Admiral Hagman
local specWarnVerticalSlash		= mod:NewSpecialWarningMove(141187)

--Lieutenant Drak'on
local timerSwashbucklingCD		= mod:NewNextTimer(17, 141438)
--Lieutenant Fizzel
local timerThrowBombCD			= mod:NewNextTimer(6, 132995, nil, false)
--Admiral Hagman
local timerVerticalSlashCD		= mod:NewCDTimer(18, 141187)--18-20 second variation

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args.spellId == 141327 then
		warnVolatileConcoction:Show()
		specWarnVolatileConcoction:Show()
	elseif args.spellId == 141187 then
		warnVerticalSlash:Show()
		specWarnVerticalSlash:Show()
		timerVerticalSlashCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70963 then--Lieutenant Fizzel
		timerThrowBombCD:Cancel()
	elseif cid == 67391 then--Lieutenant Drak'on
		timerSwashbucklingCD:Cancel()
	elseif cid == 67426 then--Admiral Hagman
		timerVerticalSlashCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 132995 and self:AntiSpam() then
		self:SendSync("ThrowBomb")
	end
end

function mod:OnSync(msg)
	if msg == "ThrowBomb" then
		warnThrowBomb:Show()
		timerThrowBombCD:Start()
	end
end
