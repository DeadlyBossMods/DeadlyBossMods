local mod	= DBM:NewMod("RTKTrash", "DBM-Party-Legion", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
--	"SPELL_CAST_START",
--	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED 229489"
--	"SPELL_DAMAGE 204762",
--	"SPELL_MISSED 204762",
--	"UNIT_DIED"
--	"CHAT_MSG_MONSTER_YELL"
)

--local warnSummonBeasts				= mod:NewSpellAnnounce(204966, 2)

local specWarnRoyalty				= mod:NewSpecialWarningSwitch(229489, nil, nil, nil, 1, 2)
--local specWarnShadowBoltVolley		= mod:NewSpecialWarningInterrupt(204963, "HasInterrupt", nil, nil, 1, 2)--Malgath interruptable aoe

--local timerPortal					= mod:NewTimer(122, "TimerPortal", 57687, nil, nil, 6)
--local timerShieldDestruction		= mod:NewNextTimer(12.5, 202312, nil, nil, nil, 1)--Time between boss yell and shield coming down.

--local voiceShadowBomb				= mod:NewVoice(204962)--runout
--local voiceShadowBoltVolley			= mod:NewVoice(204963, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

--[[
function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 204966 then
		warnSummonBeasts:Show()
	elseif spellId == 204963 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnShadowBoltVolley:Show(args.sourceName)
		voiceShadowBoltVolley:Play("kickcast")
	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 204962 then

	end
end
--]]

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 229489 then
		specWarnRoyalty:Show(args.destName)
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if not self.Options.Enabled then return end
	if spellId == 204762 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelEnergy:Show()
		voiceFelEnergy:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = mod:GetCIDFromGUID(args.destGUID)
	if cid == 102246 then

	end
end

--]]
