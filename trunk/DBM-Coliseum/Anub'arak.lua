local mod = DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1236 $"):sub(12, -3))
mod:SetCreatureID(34660)  

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnPursue			= mod:NewAnnounce("WarnPursue", 3)
local warnBurrow			= mod:NewAnnounce("WarnBurrow", 2)
local timerPursue			= mod:NewTargetTimer(30, 67574)
local timerBurrowCD			= mod:NewCDTimer(90, 67322)
local specWarnPursue		= mod:NewSpecialWarning("SpecWarnPursue")

mod:AddBoolOption("PlaySoundOnPursue")

local phase = 1
function mod:OnCombatStart(delay)
	phase = 1
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67574) then		-- Pursue
		if args.destName == UnitName("player") then
			specWarnPursue:Show()
			if self.Options.PlaySoundOnPursue then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
		warnPursue:Show(args.destName)
		timerPursue:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67322) then		-- Submerge
		phase = 2
	end
end
mod.SPELL_CAST_SUCCESS = mod.SPELL_CAST_START		-- currently unsure if this is start/success ^^

function mod:UNIT_HEALTH(uId)

end

