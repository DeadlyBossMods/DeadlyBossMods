local mod	= DBM:NewMod(2095, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(126983)
mod:SetEncounterID(2096)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 257314 257305",
	"SPELL_CAST_START 257402 257458",
	"SPELL_CAST_SUCCESS 257316 257278",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 257402 or ability.id = 257458) and type = "begincast" or (ability.id = 257278 or ability.id = 257316) and type = "cast"
 or (ability.id = 257305 or ability.id = 257314) and type = "applydebuff"
 --]]
local warnBlackPowder				= mod:NewTargetAnnounce(257314, 4)
local warnCannonBarrage				= mod:NewTargetAnnounce(257305, 3)

local specWarnBlackPowder			= mod:NewSpecialWarningRun(257314, nil, nil, nil, 4, 2)
local yellBlackPowder				= mod:NewYell(257314)
local specWarnAvastye				= mod:NewSpecialWarningSwitch(257316, "Dps", nil, nil, 1, 2)
local specWarnSwiftwindSaber		= mod:NewSpecialWarningDodge(257278, nil, nil, nil, 2, 2)
local specWarnCannonBarrage			= mod:NewSpecialWarningDodge(257305, nil, nil, nil, 3, 2)
local yellCannonBarrage				= mod:NewYell(257305)

local timerAvastyeCD				= mod:NewCDTimer(13, 257316, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)
local timerSwiftwindSaberCD			= mod:NewCDTimer(15.8, 257316, nil, nil, nil, 3)
local timerCannonBarrageCD			= mod:NewCDTimer(17.4, 257305, nil, nil, nil, 3)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerSwiftwindSaberCD:Start(10.4-delay)
	timerCannonBarrageCD:Start(20-delay)
	timerAvastyeCD:Start(31.6-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnBlackPowder:Show()
			specWarnBlackPowder:Play("justrun")
			yellBlackPowder:Yell()
		else
			warnBlackPowder:Show(args.destName)
			specWarnAvastye:Show()--Switch warning after it picks a fixate target and you're not that target
			specWarnAvastye:Play("killmob")
		end
	elseif spellId == 257305 then
		if self.vb.phase >= 2 then--Multiple targets
			warnCannonBarrage:CombinedShow(0.3, args.destName)
		end
		if args:IsPlayer() then
			specWarnCannonBarrage:Show()
			specWarnCannonBarrage:Play("watchstep")
			--specWarnCannonBarrage:ScheduleVoice(1.5, "keepmove")
			yellCannonBarrage:Yell()
		else
			if self.vb.phase == 1 then--Only one target
				warnCannonBarrage:Show(args.destName)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257402 or spellId == 257458 then
		self.vb.phase = self.vb.phase + 1
		timerSwiftwindSaberCD:Stop()
		timerAvastyeCD:Stop()
		timerCannonBarrageCD:Stop()
		timerCannonBarrageCD:Start(17)
		timerAvastyeCD:Start(23)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then
		if self.vb.phase == 1 then
			timerAvastyeCD:Start(20.5)
		elseif self.vb.phase == 2 then
			timerAvastyeCD:Start(24)
		else
			timerAvastyeCD:Start(18)
		end
	elseif spellId == 257278 then
		specWarnSwiftwindSaber:Show()
		specWarnSwiftwindSaber:Play("watchwave")
		timerSwiftwindSaberCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453 or spellId == 257304 then--Cannon Barrage (Stage 1), Cannon Barrage (Stage 2/3)
		timerCannonBarrageCD:Start()
	end
end
