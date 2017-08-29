local mod	= DBM:NewMod(2013, "DBM-Argus", nil, 959)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124492)
--mod:SetEncounterID(1952)--Does not have one
--mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247320 247393",
	"SPELL_CAST_SUCCESS 247318 247325",
	"SPELL_AURA_APPLIED 247318 247330",
	"SPELL_AURA_APPLIED_DOSE 247318"
)

--TODO, see if tanks tuff needs to be more complex, like Ursoc. Also adjust stacks (if it even stacks)
local warnGushingWound					= mod:NewStackAnnounce(247318, 2, nil, "Tank")
local warnLash							= mod:NewSpellAnnounce(247325, 2, nil, "Tank")

local specWarnGushingWound				= mod:NewSpecialWarningStack(247318, nil, 2, nil, nil, 1, 2)
local specWarnGushingWoundOther			= mod:NewSpecialWarningTaunt(247318, nil, nil, nil, 1, 2)
local specWarnSearingGaze				= mod:NewSpecialWarningInterrupt(247320, "HasInterrupt", nil, nil, 1, 2)
local specWarnPhantasm					= mod:NewSpecialWarningDodge(247393, nil, nil, nil, 2, 2)
local specWarnEyeSore					= mod:NewSpecialWarningTarget(247330, "Healer", nil, nil, 1, 2)

local timerGushingWoundCD				= mod:NewAITimer(13.4, 247318, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerLashCD						= mod:NewAITimer(13.4, 247325, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSearingGazeCD				= mod:NewAITimer(61, 247320, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerPhantasmCD					= mod:NewAITimer(61, 247393, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerEyeSoreCD					= mod:NewAITimer(61, 247330, nil, "Healer", nil, 3, nil, DBM_CORE_HEALER_ICON)

local voiceGushingWound					= mod:NewVoice(247318)--tauntboss/stackhigh
local voiceSearingGaze					= mod:NewVoice(247320, "HasInterrupt")--kickcast
local voicePhantasm						= mod:NewVoice(247393)--watchorb
local voiceEyeSore						= mod:NewVoice(247330, "Healer")--healall

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247320 then
		timerSearingGazeCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnSearingGaze:Show(args.sourceName)
			voiceSearingGaze:Play("kickcast")
		end
	elseif spellId == 247393 then
		specWarnPhantasm:Show()
		voicePhantasm:Play("watchorb")
		timerPhantasmCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247318 then
		timerGushingWoundCD:Start()
	elseif spellId == 247325 then
		warnLash:Show()
		timerLashCD:Start()
	elseif spellId == 247330 then
		timerEyeSoreCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247318 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnGushingWound:Show(amount)
					voiceGushingWound:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnGushingWoundOther:Show(args.destName)
						voiceGushingWound:Play("tauntboss")
					else
						warnGushingWound:Show(args.destName, amount)
					end
				end
			else
				warnGushingWound:Show(args.destName, amount)
			end
		end
	elseif spellId == 247330 then
		specWarnEyeSore:CombinedShow(0.3, args.destName)
		if self:AntiSpam(4, 1) then
			voiceEyeSore:Play("healall")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
