local mod = DBM:NewMod("XT002", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetZone()


mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local timerTympanicTantrumCast		= mod:NewCastTimer(62775)
local timerTympanicTantrum		= mod:NewBuffActiveTimer(12, 62775)
local timerTympanicTantrumCD		= mod:NewCDTimer(28, 62776)
local timerHeart			= mod:NewCastTimer(30, 63849)
local timerLightBomb			= mod:NewTargetTimer(9, 65121)
local timerGravityBomb			= mod:NewTargetTimer(9, 64234)

local warnLightBomb			= mod:NewAnnounce("WarningLightBomb", 3, 65121)
local specWarnLightBomb			= mod:NewSpecialWarning("SpecialWarningLightBomb")

local warnGravityBomb			= mod:NewAnnounce("WarningGravityBomb", 3, 64234)
local specWarnGravityBomb		= mod:NewSpecialWarning("SpecialWarningGravityBomb")

local enrageTimer			= mod:NewEnrageTimer(480)

mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerTympanicTantrumCD:Start(65-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62775 and args.auraType == "BUFF" then	-- Tympanic Tantrum
		timerTympanicTantrumCD:Start()
		timerTympanicTantrum:Start()

	elseif args.spellId == 63018 or args.spellId == 65121 then 	-- Light Bomb
		if args.destName == UnitName("player") then
			specWarnLightBomb:Show()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 7, 9)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args.spellId == 63025 or args.spellId == 63024 or args.spellId == 64234 then		-- Gravity Bomb (which Ulduar10 spell id is correct?)
		if args.destName == UnitName("player") then
			specWarnGravityBomb:Show()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 8, 9)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args.spellId == 63849 then
		timerHeart:Start()
	end
end

