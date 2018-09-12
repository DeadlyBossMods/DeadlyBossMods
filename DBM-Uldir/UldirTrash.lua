local mod	= DBM:NewMod("UldirTrash", "DBM-Uldir")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 277047 274802 276540 278976",
	"SPELL_CAST_SUCCESS 277358",
	"SPELL_AURA_APPLIED 277047 277498 277548"
--	"SPELL_AURA_REMOVED"
)

local warnCorruptingGaze				= mod:NewTargetAnnounce(277047, 3)
local warnMindSlave						= mod:NewTargetNoFilterAnnounce(277498, 3)

local specWarnWildLeap					= mod:NewSpecialWarningDodge(278976, nil, nil, nil, 2, 2)
local specWarnCorruptingGaze			= mod:NewSpecialWarningMoveAway(277047, nil, nil, nil, 1, 2)
local specWarnCorruptingGazeNear		= mod:NewSpecialWarningClose(277047, nil, nil, nil, 1, 2)
local yellCorruptingGaze				= mod:NewYell(277047)
local specWarnBloodstorm				= mod:NewSpecialWarningRun(274802, nil, nil, nil, 4, 2)
local specWarnCrushingDarkness			= mod:NewSpecialWarningRun(277548, "Tank", nil, nil, 4, 2)
local specWarnBloodShield				= mod:NewSpecialWarningInterrupt(276540, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindFlay					= mod:NewSpecialWarningInterrupt(277358, "HasInterrupt", nil, nil, 1, 2)

--mod:AddRangeFrameOption(10, 221028)

function mod:GazeTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(5, targetname) then
		if targetname == UnitName("player") then
			specWarnCorruptingGaze:Show()
			specWarnCorruptingGaze:Play("runout")
			yellCorruptingGaze:Yell()
		elseif self:CheckNearby(5, targetname) then
			specWarnCorruptingGazeNear:Show(targetname)
			specWarnCorruptingGazeNear:Play("watchstep")
		else
			warnCorruptingGaze:Show(targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 277047 then
		--self:BossTargetScanner(args.sourceGUID, "SubmergeTarget", 0.1, 14)
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "GazeTarget", 0.1, 12)
	elseif spellId == 274802 and self:AntiSpam(3, 1) then
		specWarnBloodstorm:Show()
		specWarnBloodstorm:Play("justrun")
	elseif spellId == 276540 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBloodShield:Show(args.sourceName)
		specWarnBloodShield:Play("kickcast")
	elseif spellId == 278976 and self:AntiSpam(3, 2) then
		specWarnWildLeap:Show()
		specWarnWildLeap:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 277358 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 277047 and self:AntiSpam(5, args.destName) then--if target scan fails
		if args:IsPlayer() then
			specWarnCorruptingGaze:Show()
			specWarnCorruptingGaze:Play("runout")
			yellCorruptingGaze:Yell()
		elseif self:CheckNearby(5, args.destName) then
			specWarnCorruptingGazeNear:Show(args.destName)
			specWarnCorruptingGazeNear:Play("watchstep")
		else
			warnCorruptingGaze:Show(args.destName)
		end
	elseif spellId == 277498 then
		warnMindSlave:Show(args.destName)
	elseif spellId == 277548 then
		specWarnCrushingDarkness:Show()
		specWarnCrushingDarkness:Play("justrun")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 221028 then
	
	end
end
--]]
