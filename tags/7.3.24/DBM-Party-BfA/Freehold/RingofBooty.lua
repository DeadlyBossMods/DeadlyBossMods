local mod	= DBM:NewMod(2094, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(126969)
mod:SetEncounterID(2095)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 256405 256489",
	"SPELL_CAST_SUCCESS 256358"
)

--(ability.id = 256405 or ability.id = 256489) and type = "begincast" or ability.id = 256358
local warnSharkToss					= mod:NewTargetAnnounce(256358, 2)

local specWarnSharkToss				= mod:NewSpecialWarningYou(256358, nil, nil, nil, 1, 2)
local specWarnSharkTossNear			= mod:NewSpecialWarningClose(256358, nil, nil, nil, 1, 2)
local yellSharkToss					= mod:NewYell(256358)
local specWarnSharknado				= mod:NewSpecialWarningRun(256405, nil, nil, nil, 4, 2)
local specWarnRearm					= mod:NewSpecialWarningDodge(256489, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--local timerSharkTossCD			= mod:NewCDTimer(31.5, 194956, nil, nil, nil, 3)--Disabled until more data, seems highly variable, even pull to pull
local timerSharknadoCD				= mod:NewCDTimer(39.1, 256405, nil, nil, nil, 3)
local timerRearmCD					= mod:NewCDTimer(40, 256489, nil, nil, nil, 3)

mod:AddRangeFrameOption(8, 256358)

--"Shark Toss-256358-npc:126969 = pull:14.4, 31.5, 40.1, 40.1", -- [8]

function mod:OnCombatStart(delay)
	timerSharknadoCD:Start(20.4-delay)
	timerRearmCD:Start(43.5-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 256405 then
		specWarnSharknado:Show()
		specWarnSharknado:Play("justrun")
		timerSharknadoCD:Start()
	elseif spellId == 256489 then
		specWarnRearm:Show()
		specWarnRearm:Play("farfromline")
		timerRearmCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 256358 then
		if args:IsPlayer() then
			specWarnSharkToss:Show()
			specWarnSharkToss:Play("runaway")
			yellSharkToss:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnSharkTossNear:Show(args.destName)
			specWarnSharkTossNear:Play("watchstep")
		else
			warnSharkToss:Show(args.destName)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then
	end
end
--]]
