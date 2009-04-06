local mod = DBM:NewMod("XT002", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

-- freely created by provided informations from
-- http://www.mmo-champion.com/index.php?page=841
-- this mod issn't fully working and finished - please provide combatlogs

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

mod:AddBoolOption("PlaySoundOnGravityBomb", true, "announce")
mod:AddBoolOption("PlaySoundOnTympanicTantrum", true, "announce")
mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)

function mod:OnCombatStart(delay)

end


function mod:SPELL_CAST_START(args)
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damge + daze)
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnTympanicTantrum then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end

	elseif args.spellId == 63024 or args.spellId == 64234 then	-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			mod:SetIcon(args.destName, 8, 9)	-- set Skull for 9 seconds on target
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)

	elseif args.spellId == 63018 or args.spellId == 65121 then	-- Light Bomb	
		if self.Options.SetIconOnLightBombTarget then 
			mod:SetIcon(args.destName, 4, 9)	-- set Triangle for 9 seconds on target
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62775 and args.auraType == "BUFF" then	-- Tympanic Tantrum (buff because we don't wan to parse for each raidmember affected by this)
		timerTympanicTantrum:Start()

	elseif args.spellId == 63023 or args.spellId == 65120 then 	-- Light Bomb
		if args.destName == UnitName("player") then
			specWarnLightBomb:Show()
		end
		
	elseif args.spellId == 63025 or args.spellId == 64233 then		-- Gravity Bomb
		if self.Options.PlaySoundOnGravityBomb and args.destName == UnitName("player") then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end



