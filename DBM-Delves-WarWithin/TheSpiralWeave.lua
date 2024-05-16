local mod	= DBM:NewMod("z2688", "DBM-Delves")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")

mod:RegisterCombat("scenario", 2688)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 449072 448644 449038 450714",
	--"SPELL_CAST_SUCCESS",
	--"SPELL_AURA_APPLIED",
	--"SPELL_AURA_REMOVED",
	--"SPELL_PERIODIC_DAMAGE",
	"ENCOUNTER_START",
	"ENCOUNTER_END"
)

local warnDrones							= mod:NewSpellAnnounce(449072, 2)

local specWarnJaggedBarbs					= mod:NewSpecialWarningDodge(450714, nil, nil, nil, 2, 2)
local specWarnBurrowingTremors				= mod:NewSpecialWarningRun(448644, nil, nil, nil, 4, 2)--Boss
local specWarnImpalingStrikes				= mod:NewSpecialWarningDodge(449038, nil, nil, nil, 2, 2)--Boss

local timerBurrowingTremorsCD				= mod:NewCDTimer(31.5, 448644, nil, nil, nil, 5)
local timerCallDronesCD						= mod:NewCDTimer(31.5, 449072, nil, nil, nil, 1)
local timerImpalingStrikesCD				= mod:NewCDTimer(31.5, 449038, nil, nil, nil, 3)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 off interrupt

mod.vb.impalingCount = 0

function mod:SPELL_CAST_START(args)
	if args.spellId == 449072 then
		warnDrones:Show()
		timerCallDronesCD:Start()
	elseif args.spellId == 448644 then
		specWarnBurrowingTremors:Show()
		specWarnBurrowingTremors:Play("justrun")
		specWarnBurrowingTremors:ScheduleVoice(1.5, "keepmove")
		timerBurrowingTremorsCD:Start()
	elseif args.spellId == 449038 then
		self.vb.impalingCount = self.vb.impalingCount + 1
		specWarnImpalingStrikes:Show()
		specWarnImpalingStrikes:Play("watchstep")
		if self.vb.impalingCount < 3 then
			timerImpalingStrikesCD:Start(25.1)
		else
			timerImpalingStrikesCD:Start(31.5)
		end
	elseif args.spellId == 450714 then
		if self:AntiSpam(3, 2) then
			specWarnJaggedBarbs:Show()
			specWarnJaggedBarbs:Play("shockwave")
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138680 then

	end
end
--]]

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 then

	end
end
--]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138561 and destGUID == UnitGUID("player") and self:AntiSpam() then

	end
end
--]]

function mod:ENCOUNTER_START(eID)
	if eID == 2990 then
		--Start some timers
		self.vb.impalingCount = 0
		timerImpalingStrikesCD:Start(6.4)
		timerBurrowingTremorsCD:Start(12.5)
		timerCallDronesCD:Start(27.1)
	end
end

function mod:ENCOUNTER_END(eID, _, _, _, success)
	if eID == 2990 then
		if success then
			DBM:EndCombat(self)
		else
			timerImpalingStrikesCD:Stop()
			timerBurrowingTremorsCD:Stop()
			timerCallDronesCD:Stop()
		end
	end
end
