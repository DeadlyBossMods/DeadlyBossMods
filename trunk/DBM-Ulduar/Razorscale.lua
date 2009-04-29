local mod = DBM:NewMod("Razorscale", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33186)
mod:SetZone()

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellAir)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local specWarnDevouringFlame		= mod:NewSpecialWarning("SpecWarnDevouringFlame")
local timerDeepBreathCooldown		= mod:NewCDTimer(21, 64021)
local timerDeepBreathCast		= mod:NewCastTimer(2.5, 64021)
local timerAllTurretsReady		= mod:NewTimer(115, "timerAllTurretsReady") -- todo: icon?
local warnTurretsReadySoon		= mod:NewAnnounce("warnTurretsReadySoon", 1)
local warnTurretsReady			= mod:NewAnnounce("warnTurretsReady", 3)
local enrageTimer			= mod:NewEnrageTimer(600)

local specWarnDevouringFlameCast	= mod:NewSpecialWarning("SpecWarnDevouringFlameCast")
local warnDevouringFlameCast		= mod:NewAnnounce("WarnDevouringFlameCast", 2, 64733) 

mod:AddBoolOption("PlaySoundOnDevouringFlame", false, "announce")

local castFlames

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAllTurretsReady:Start(-delay)
	warnTurretsReadySoon:Schedule(95-delay)
	warnTurretsReady:Schedule(115-delay)
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 64733 and args.destName == UnitName("player") then		-- you are standing in Devouring Flame
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnDevouringFlame then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if msg == L.YellAir then
		timerAllTurretsReady:Start()
		warnTurretsReadySoon:Schedule(95)
		warnTurretsReady:Schedule(115)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64021 then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	elseif args.spellId == 63236 then
		local target = self:GetBossTarget(self.creatureId)
		if target then
			self:flameCast(target)
		else
			castFlames = true
		end
	end
end

function mod:UNIT_TARGET(unit)
	if castFlames and self:GetUnitCreatureId(unit.."target") == self.creatureId then
		local target = UnitName(unit.."targettarget")
		if target then
			self:flameCast(target)
		else
			self:flameCast("UNKNOWN")
		end
		castFlames = false
	end
end 

function mod:flameCast(target)
   warnDevouringFlameCast:Show(target)
   if target == UnitName("player") then
      specWarnDevouringFlameCast:Show()
   end
   self:SetIcon(target, 8, 9)
end 

