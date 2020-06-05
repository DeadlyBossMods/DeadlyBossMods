local mod	= DBM:NewMod("NecroticWakeTrash", "DBM-Party-Shadowlands", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
--	"SPELL_CAST_SUCCESS"
)


--local warnDuelistDash					= mod:NewTargetNoFilterAnnounce(274400, 4)

--local yellRicochetingThrow				= mod:NewYell(272402)
--local specWarnHealingBalm				= mod:NewSpecialWarningInterrupt(257397, "HasInterrupt", nil, nil, 1, 2)
--local specWarnBestialWrath				= mod:NewSpecialWarningDispel(257476, "RemoveEnrage", nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role

function mod:RicochetingTarget(targetname, uId)
	if not targetname then return end
--	warnRicochetingThrow:Show(targetname)
--	if targetname == UnitName("player") then
--		yellRicochetingThrow:Yell()
--	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
--	elseif spellId == 272402 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 258323 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
--		specWarnBestialWrath:Show(args.destName)
--		specWarnBestialWrath:Play("helpdispel")
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then

	end
end
--]]
