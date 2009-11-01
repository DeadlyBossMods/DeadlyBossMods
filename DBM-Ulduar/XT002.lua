local mod = DBM:NewMod("XT002", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local timerTympanicTantrumCast		= mod:NewCastTimer(62776)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(8, 62776)
local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776)
local timerHeart					= mod:NewCastTimer(30, 63849)
local timerLightBomb				= mod:NewTargetTimer(9, 65121)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234)

local warnLightBomb					= mod:NewAnnounce("WarningLightBomb", 3, 65121)
local specWarnLightBomb				= mod:NewSpecialWarning("SpecialWarningLightBomb")

local warnGravityBomb				= mod:NewAnnounce("WarningGravityBomb", 3, 64234)
local specWarnGravityBomb			= mod:NewSpecialWarning("SpecialWarningGravityBomb")

local enrageTimer					= mod:NewEnrageTimer(600)
local timerAchieve					= mod:NewAchievementTimer(205, 2937, "TimerSpeedKill")

mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	if mod:IsDifficulty("heroic10") then
		timerTympanicTantrumCD:Start(35-delay)
	else
		timerTympanicTantrumCD:Start(50-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62776) then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCast:Start()
		timerTympanicTantrumCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62775) and args.auraType == "DEBUFF" then	-- Tympanic Tantrum
		timerTympanicTantrumCD:Start()
		timerTympanicTantrum:Start()

	elseif args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 7, 9)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 8, 9)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args:IsSpellID(63849) then
		timerHeart:Start()
	end
end

