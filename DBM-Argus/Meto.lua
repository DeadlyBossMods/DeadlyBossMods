local mod	= DBM:NewMod(2012, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124592)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247492 247585 247632",
	"SPELL_CAST_SUCCESS 247495",
	"SPELL_AURA_APPLIED 247495",
	"SPELL_AURA_APPLIED_DOSE 247495"
)

--TODO, see if run over flowr is appropriate or i it lacks clarity, since here we want to STAND on them not run over them.
--TODO, target scan death field?
local warnSow					= mod:NewStackAnnounce(247495, 2, nil, "Tank")

local specReap					= mod:NewSpecialWarningSpell(247492, "Tank", nil, nil, 1, 2)
local specWarnSow				= mod:NewSpecialWarningStack(247495, nil, 2, nil, nil, 1, 2)
local specWarnSowOther			= mod:NewSpecialWarningTaunt(247495, nil, nil, nil, 1, 2)
local specSeedsofChaos			= mod:NewSpecialWarningSpell(247585, "-Tank", nil, nil, 1, 2)
local specWarnDeathField		= mod:NewSpecialWarningDodge(247632, nil, nil, nil, 2, 2)

local timerReapCD				= mod:NewAITimer(13.4, 247492, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSowCD				= mod:NewAITimer(13.4, 247495, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSeedsofChaosCD		= mod:NewAITimer(13.4, 247585, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerDeathFieldCD			= mod:NewAITimer(13.4, 247632, nil, nil, nil, 3)

local voiceReap					= mod:NewVoice(247492)--shockwave
local voiceSow					= mod:NewVoice(247495)--tauntboss/stackhigh
local voiceSeedsofChaos			= mod:NewVoice(247585, "-Tank")--169613 (run over the flower)?
local voiceDeathField			= mod:NewVoice(247632)--shockwave (will this confuse tanks?)

--mod:AddReadyCheckOption(49198, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247492 then
		specReap:Show()
		voiceReap:Play("shockwave")
		timerReapCD:Start()
	elseif spellId == 247585 then
		specSeedsofChaos:Show()
		voiceSeedsofChaos:Play("169613")
		timerSeedsofChaosCD:Start()
	elseif spellId == 247632 then
		specWarnDeathField:Show()
		voiceDeathField:Play("shockwave")
		timerDeathFieldCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247495 then
		timerSowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247495 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnSow:Show(amount)
					voiceSow:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnSowOther:Show(args.destName)
						voiceSow:Play("tauntboss")
					else
						warnSow:Show(args.destName, amount)
					end
				end
			else
				warnSow:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
