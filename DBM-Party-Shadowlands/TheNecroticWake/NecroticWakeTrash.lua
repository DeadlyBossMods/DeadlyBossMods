local mod	= DBM:NewMod("NecroticWakeTrash", "DBM-Party-Shadowlands", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 324293 327240 327399",
--	"SPELL_CAST_SUCCESS"
	"SPELL_AURA_APPLIED 327401",
	"SPELL_AURA_REMOVED 327401"
)

--TODO targetscan shared agony during cast and get at least one of targets early? for fade/invis and feign death?
local warnSharedAgony						= mod:NewCastAnnounce(274400, 3)
local warnSharedAgonyTargets				= mod:NewTargetAnnounce(274400, 4)

local specWarnSharedAgony					= mod:NewSpecialWarningMoveAway(274400, nil, nil, nil, 1, 11)
local yellSharedAgony						= mod:NewYell(274400)
local specWarnGutturalScream				= mod:NewSpecialWarningInterrupt(324293, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpineCrush					= mod:NewSpecialWarningDodge(324293, nil, nil, nil, 2, 2)
--local specWarnBestialWrath				= mod:NewSpecialWarningDispel(257476, "RemoveEnrage", nil, nil, 1, 2)
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
	if spellId == 324293 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnGutturalScream:Show(args.sourceName)
		specWarnGutturalScream:Play("kickcast")
	elseif spellId == 327240 and self:AntiSpam(3, 2) then
		specWarnSpineCrush:Show()
		specWarnSpineCrush:Play("watchstep")
	elseif spellId == 327399 and self:AntiSpam(3, 6) then
		warnSharedAgony:Show()
--	elseif spellId == 272402 then
--		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RicochetingTarget", 0.1, 4)
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

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 324293 then
		warnSharedAgonyTargets:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSharedAgony:Show()
			specWarnSharedAgony:Play("lineapart")
			yellSharedAgony:Yell()
		end
--	elseif spellId == 258323 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
--		specWarnBestialWrath:Show(args.destName)
--		specWarnBestialWrath:Play("helpdispel")
	end
end
