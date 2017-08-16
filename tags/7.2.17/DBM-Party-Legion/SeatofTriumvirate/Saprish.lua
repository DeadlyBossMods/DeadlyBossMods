local mod	= DBM:NewMod(1980, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(124872)
mod:SetEncounterID(2066)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245802 248831",
	"SPELL_AURA_APPLIED 247145 247245",
--	"SPELL_AURA_REMOVED 247245",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, target scan dark hatchet?
--TODO, figure out which void trap ID to use, doubt cast is in combat log
--TODO, verify target scanning for ravaging darkness
--TODO, see if swoop/screech target can be identified
--TODO, swoop timer, with correct IDs
--Void Hunter
local warnUmbralFlanking				= mod:NewTargetAnnounce(247245, 3)
local warnRavagingDarkness				= mod:NewTargetAnnounce(245802, 3)
local warnDreadScreech					= mod:NewCastAnnounce(248831, 2)

local specWarnHuntersRush				= mod:NewSpecialWarningDefensive(247145, "Tank", nil, nil, 1, 2)
local specWarnOverloadTrap				= mod:NewSpecialWarningDodge(247206, nil, nil, nil, 2, 2)
local specWarnUmbralFlanking			= mod:NewSpecialWarningMoveAway(247245, nil, nil, nil, 1, 2)
local yellUmbralFlanking				= mod:NewYell(247245)
local specWarnRavagingDarkness			= mod:NewSpecialWarningMove(245802, nil, nil, nil, 1, 2)
local yellRavagingDarkness				= mod:NewYell(245802)

local timerHuntersRushCD				= mod:NewAITimer(12, 247145, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)
local timerVoidTrapCD					= mod:NewAITimer(9.7, 246026, nil, nil, nil, 3)
local timerOverloadTrapCD				= mod:NewAITimer(9.7, 247206, nil, nil, nil, 3)
local timerRavagingDarknessCD			= mod:NewAITimer(9.7, 245802, nil, nil, nil, 3)

--local countdownBreath					= mod:NewCountdown(22, 227233)

local voiceHuntersRush					= mod:NewVoice(247145)--defensive
local voiceOverloadTrap					= mod:NewVoice(247206)--watchstep
local voiceUmbralFlanking				= mod:NewVoice(247245)--scatter
local voiceRavagingDarkness				= mod:NewVoice(245802)--runaway

function mod:RavagingDarknessTarget(targetname, uId)
	if not targetname then
		return
	end
	if targetname == UnitName("player") then
		specWarnRavagingDarkness:Show()
		voiceRavagingDarkness:Play("runaway")
		yellRavagingDarkness:Yell()
	else
		warnRavagingDarkness:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerHuntersRushCD:Start(1-delay)
	timerVoidTrapCD:Start(1-delay)
	timerOverloadTrapCD:Start(1-delay)
	timerRavagingDarknessCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 245802 then
		timerRavagingDarknessCD:Start()
		self:BossTargetScanner(args.sourceGUID, "RavagingDarknessTarget", 0.1, 12, true)
	elseif spellId == 248831 then
		warnDreadScreech:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247145 then
		specWarnHuntersRush:Show()
		voiceHuntersRush:Play("defensive")
		timerHuntersRushCD:Start()
	elseif spellId == 247245 then
		warnUmbralFlanking:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUmbralFlanking:Show()
			voiceUmbralFlanking:Play("scatter")
			yellUmbralFlanking:Yell()
		end
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 247245 then
		
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 247175 then--Void Trap
		timerVoidTrapCD:Start()
	elseif spellId == 247206 then--Overload Trap
		specWarnOverloadTrap:Show()
		voiceOverloadTrap:Play("watchstep")
		timerOverloadTrapCD:Start()
	end
end
