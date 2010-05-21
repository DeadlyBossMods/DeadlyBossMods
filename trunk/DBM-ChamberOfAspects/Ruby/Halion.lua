local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39863)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warningConsumption		= mod:NewTargetAnnounce(74792)
local warningMeteor				= mod:NewSpellAnnounce(74648)
local warningShadowBreath		= mod:NewSpellAnnounce(75954)
local warningTwilightCutter		= mod:NewSpellAnnounce(77844)

local specWarnConsumption		= mod:NewSpecialWarningRun(74792)

--local timerConsumptionCD			= mod:NewCDTimer(22, 74792)
--local timerMeteorCD				= mod:NewCDTimer(22, 74648)
--local timerTwilightCutterCD		= mod:NewCDTimer(22, 77844)
--local timerShadowBreathCD			= mod:NewCDTimer(22, 75954)

local soundConsumption 			= mod:NewSound(74792)
mod:AddBoolOption("SetIconOnConsumption", true)

function mod:OnCombatStart(delay)
--		timerMeteorCD:Start(-delay)
--		timerConsumptionCD:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then--not sure if we need all 4 spellids or the cast dummy will suffice. Need logs. Not even sure if it uses SPELL_CAST_SUCCESS
		warningShadowBreath:Show()
--		timerShadowBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(74637) or args:IsSpellID(74648, 75877, 75878, 75879) then--not sure if we need all 4 spellids or the cast dummy will suffice. Need logs. Not even sure if it uses SPELL_CAST_SUCCESS
		warningMeteor:Show()
--		timerMeteorCD:Start()
	elseif args:IsSpellID(74768) or args:IsSpellID(74769, 77844, 77845, 77846) then--not sure if we need all 4 spellids or the cast dummy will suffice. Need logs. Not even sure if it uses SPELL_CAST_SUCCESS
		warningTwilightCutter:Show()
--		timerTwilightCutterCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74792) then
		warningConsumption:Show(args.destName)
--		timerConsumptionCD:Start()
		if args:IsPlayer() then
			specWarnConsumption:Show()
			soundConsumption:Play()
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(74792) then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end