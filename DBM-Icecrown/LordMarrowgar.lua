local mod = DBM:NewMod("LordMarrowgar", "DBM-Icecrown")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36612)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local timerNextWhirlwind			= mod:NewNextTimer(60, 69076)
local warnBoneSpike					= mod:NewSpellAnnounce(69057)
local timerBoneSpike				= mod:NewCDTimer(18, 69057) --Roughly 18-23 second delay between casts, using an 18sec cooldown timer.
local timerWhirlwind				= mod:NewBuffActiveTimer(30, 69076)
local warnImpale					= mod:NewAnnounce("warnImpale")
local specWarnWhirlwind				= mod:NewSpecialWarning("specWarnWhirlwind")
local specWarnColdflame				= mod:NewSpecialWarning("specWarnColdflame")

mod:AddBoolOption("PlaySoundOnWhirlwind", true, "announce")

function mod:OnCombatStart(delay)
	timerNextWhirlwind:Start(45-delay)
	timerBoneSpike:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69076) then						-- Whirlwind
		specWarnWhirlwind:Show()
		if self.Options.PlaySoundOnWhirlwind then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end	
	elseif args:IsSpellID(69057) then					-- Bone Spike Graveyard
		warnBoneSpike:Show(args.spellName)
		timerBoneSpike:Start()
	end
end

do 
	local lastColdflame = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69146, 70823, 70824, 70825) and args:IsPlayer() and time() - lastColdflame > 2 then		-- Coldflame, MOVE!
			specWarnColdflame:Show()
			lastColdflame = time()
		end
	end
end

local impaleTargets = {}

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062) then							-- Impale (This function is iffy and I'm not sure it'll work)
		self:UnscheduleMethod("warnImpale")
		impaleTargets[#impaleTargets + 1] = args.sourceName
		mod:ScheduleMethod(0.2, "warnImpale")   end
	timerBoneSpike:Start()
	end
end

function mod:warnImpale() 
	warnImpale:Show(table.concat(impaleTargets, "<, >")) 
	table.wipe(impaleTargets) 
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69076) then						-- Whirlwind Begins
		timerWhirlwind:Show(args.destName)
--[[	elseif args:IsSpellID(69065) then					-- Impale (this function is a last resort if summon doesn't work. This happens at least 1-2 seconds after the summon event and after person has already taken damage from it.
		self:UnscheduleMethod("warnImpale")
		impaleTargets[#impaleTargets + 1] = args.destName
		mod:ScheduleMethod(0.2, "warnImpale")   end]]--
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69076) then						-- Whirlwind Ends
		timerNextWhirlwind:Start()
	end
end
