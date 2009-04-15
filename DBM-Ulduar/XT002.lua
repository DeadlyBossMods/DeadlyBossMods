local mod = DBM:NewMod("XT002", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetZone()

-- disclaimer: we never did this boss on the PTR, this boss mod is based on combat logs and movies. This boss mod might be completely wrong or broken, we will replace it with an updated version asap

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local timerTympanicTantrumCast		= mod:NewTimer(2, "timerTympanicTantrumCast", 62776)
local timerTympanicTantrum		= mod:NewTimer(12, "timerTympanicTantrum", 62775)

local specWarnLightBomb			= mod:NewSpecialWarning("SpecialWarningLightBomb")
local warnLightBomb			= mod:NewAnnounce("WarningLightBomb", 3, 63018)
local timerLightBomb			= mod:NewTimer(9, "timerLightBomb", 65120)

local specWarnGravityBomb		= mod:NewSpecialWarning("SpecialWarningGravityBomb")
local warnGravityBomb			= mod:NewAnnounce("WarningGravityBomb", 3, 63024)
local timerGravityBomb			= mod:NewTimer(9, "timerGravityBomb", 63024)

mod:AddBoolOption("PlaySoundOnTympanicTantrum", true, "announce")
mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)


function mod:SPELL_CAST_START(args)
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCast:Start()
		if self.Options.PlaySoundOnTympanicTantrum then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62775 and args.auraType == "BUFF" then	-- Tympanic Tantrum
		timerTympanicTantrum:Start()

	elseif args.spellId == 63023 or args.spellId == 6302 or args.spellId == 65120 then 	-- Light Bomb  (which Ulduar10 spell id is correct?)
		if args.destName == UnitName("player") then
			specWarnLightBomb:Show()
		end
		if self.Options.SetIconOnLightBombTarget then
			mod:SetIcon(args.destName, 7, 9)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args.spellId == 63025 or args.spellId == 63024 or args.spellId == 64234 then		-- Gravity Bomb (which Ulduar10 spell id is correct?)
		if args.destName == UnitName("player") then
			specWarnGravityBomb:Show()
		end
		if self.Options.SetIconOnGravityBombTarget then
			mod:SetIcon(args.destName, 8, 9)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	end
end

