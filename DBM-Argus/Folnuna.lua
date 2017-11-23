local mod	= DBM:NewMod(2010, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124514)
mod:SetEncounterID(2081)
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247379 247443",
	"SPELL_AURA_APPLIED 247361 247389",
	"SPELL_AURA_APPLIED_DOSE 247361"
)

local warnInfectedClaws					= mod:NewStackAnnounce(247361, 2, nil, "Tank")
local warnSlumberingGasp				= mod:NewTargetAnnounce(247389, 2, nil, false)
local warnGrotesqueSpawn				= mod:NewSpellAnnounce(247443, 2)

local specWarnInfectedClaws				= mod:NewSpecialWarningStack(247361, nil, 6, nil, nil, 1, 6)
local specWarnInfectedClawsOther		= mod:NewSpecialWarningTaunt(247361, nil, nil, nil, 1, 2)
local specWarnSlumberingGasp			= mod:NewSpecialWarningDodge(247379, nil, nil, nil, 2, 2)

--local timerInfectedClawsCD				= mod:NewAITimer(13.4, 247361, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSlumberingGaspCD				= mod:NewCDTimer(54.7, 247379, nil, nil, nil, 3, nil, DBM_CORE_IMPORTANT_ICON)
local timerGrotesqueSpawnCD				= mod:NewCDTimer(32.8, 247443, nil, nil, nil, 1)

local voiceInfectedClaws				= mod:NewVoice(247361)--tauntboss/stackhigh
local voiceSlumberingGasp				= mod:NewVoice(247379)--breathsoon

mod:AddReadyCheckOption(49199, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerGrotesqueSpawnCD:Start(9.5-delay)
		timerSlumberingGaspCD:Start(58-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247379 then
		specWarnSlumberingGasp:Show()
		voiceSlumberingGasp:Play("breathsoon")
		timerSlumberingGaspCD:Start()
	elseif spellId == 247443 then
		warnGrotesqueSpawn:Show()
		timerGrotesqueSpawnCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247361 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount % 3 == 0 then 
				if amount >= 6 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
					if args:IsPlayer() then--At this point the other tank SHOULD be clear.
						specWarnInfectedClaws:Show(amount)
						voiceInfectedClaws:Play("stackhigh")
					else--Taunt as soon as stacks are clear, regardless of stack count.
						if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
							specWarnInfectedClawsOther:Show(args.destName)
							voiceInfectedClaws:Play("tauntboss")
						else
							warnInfectedClaws:Show(args.destName, amount)
						end
					end
				else
					warnInfectedClaws:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 247389 then
		warnSlumberingGasp:CombinedShow(1.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
