local mod	= DBM:NewMod("PlaguefallTrash", "DBM-Party-Shadowlands", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 328016 328177 327581",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 328015"
)

--TODO, maybe auto icon marking/tracking of slimes summoned via 327598
local warnBeckonSlime					= mod:NewCastAnnounce(327581, 2, 6)--Cast 3 seconds, plus 3 seconds til slime appears
--local warnDuelistDash					= mod:NewTargetNoFilterAnnounce(274400, 4)

--local yellRicochetingThrow				= mod:NewYell(272402)
local specWarnWonderGrow					= mod:NewSpecialWarningInterrupt(328016, "HasInterrupt", nil, nil, 1, 2)
local specWarnWonderGrowDispel				= mod:NewSpecialWarningDispel(328015, "MagicDispeller", nil, nil, 1, 2)
local specWarnFungistorm					= mod:NewSpecialWarningRun(328177, nil, nil, nil, 4, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

--function mod:RicochetingTarget(targetname, uId)
--	if not targetname then return end
--	warnRicochetingThrow:Show(targetname)
--	if targetname == UnitName("player") then
--		yellRicochetingThrow:Yell()
--	end
--end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 328016 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWonderGrow:Show(args.sourceName)
		specWarnWonderGrow:Play("kickcast")
	elseif spellId == 328177 and self:AntiSpam(3, 1) then
		specWarnFungistorm:Show()
		specWarnFungistorm:Play("justrun")
	elseif spellId == 327581 and self:AntiSpam(3, 6) then
		warnBeckonSlime:Show()
--	elseif spellId == 272402 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 328015 then
		specWarnWonderGrowDispel:CombinedShow(1, args.destName)
		specWarnWonderGrowDispel:ScheduleVoice(1, "dispelboss")
--	elseif spellId == 328015 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
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
