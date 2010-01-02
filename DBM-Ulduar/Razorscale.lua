local mod	= DBM:NewMod("Razorscale", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(33186)
mod:SetUsedIcons(8)

--mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellAir)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"UNIT_TARGET",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnTurretsReadySoon			= mod:NewAnnounce("warnTurretsReadySoon", 1)
local warnTurretsReady				= mod:NewAnnounce("warnTurretsReady", 3)
local warnDevouringFlameCast		= mod:NewAnnounce("WarnDevouringFlameCast", 2, 64733, false, "OptionDevouringFlame") -- new option is just a work-around...the saved variable handling will be updated to allow changing and updating default values soon

local specWarnDevouringFlame		= mod:NewSpecialWarning("SpecWarnDevouringFlame")
local specWarnDevouringFlameCast	= mod:NewSpecialWarning("SpecWarnDevouringFlameCast")

local enrageTimer					= mod:NewBerserkTimer(900) -- uhm?
local timerDeepBreathCooldown		= mod:NewCDTimer(21, 64021)
local timerDeepBreathCast			= mod:NewCastTimer(2.5, 64021)
local timerTurret1					= mod:NewTimer(53, "timerTurret1")
local timerTurret2					= mod:NewTimer(73, "timerTurret2")
local timerTurret3					= mod:NewTimer(93, "timerTurret3")
local timerTurret4					= mod:NewTimer(113, "timerTurret4")
local timerGrounded                 = mod:NewTimer(45, "timerGrounded")

mod:AddBoolOption("PlaySoundOnDevouringFlame", false)

local castFlames
local combattime = 0

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	combattime = GetTime()
	if mod:IsDifficulty("heroic10") then
		warnTurretsReadySoon:Schedule(53-delay)
		warnTurretsReady:Schedule(73-delay)
		timerTurret1:Start(-delay)
		timerTurret2:Start(-delay)
	else
		warnTurretsReadySoon:Schedule(93-delay)
		warnTurretsReady:Schedule(113-delay)
		timerTurret1:Start(-delay) -- 53sec
		timerTurret2:Start(-delay) -- +20
		timerTurret3:Start(-delay) -- +20
		timerTurret4:Start(-delay) -- +20
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(64733, 64704) and args:IsPlayer() then
		specWarnDevouringFlame:Show()
		if self.Options.PlaySoundOnDevouringFlame then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end		
	end
end


function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmotePhase2 or emote:find(L.EmotePhase2) then
		-- phase2
		timerTurret1:Stop()
		timerTurret2:Stop()
		timerTurret3:Stop()
		timerTurret4:Stop()
		timerGrounded:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if msg == L.YellAir or msg == L.YellAir2 and GetTime() - combattime > 30 then
		warnTurretsReadySoon:Cancel()
		warnTurretsReady:Cancel()
		if mod:IsDifficulty("heroic10") then -- not sure?
			warnTurretsReadySoon:Schedule(23)
			warnTurretsReady:Schedule(43)
			timerTurret1:Start(23)
			timerTurret2:Start(43)
		else
			warnTurretsReadySoon:Schedule(93)
			warnTurretsReady:Schedule(113)
			timerTurret1:Start()
			timerTurret2:Start()
			timerTurret3:Start()
			timerTurret4:Start()
		end

	elseif msg == L.YellGround then
		timerGrounded:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64021) then	-- deep breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	elseif args:IsSpellID(63236) then
		local target = self:GetBossTarget(self.creatureId)
		if target then
			self:CastFlame(target)
		else
			castFlames = GetTime()
		end
	end
end

function mod:UNIT_TARGET(unit)	-- I think this is useless, why would anyone in the raid target razorflame right after the flame stuff?
	if castFlames and GetTime() - castFlames <= 1 and self:GetUnitCreatureId(unit.."target") == self.creatureId then
		local target = UnitName(unit.."targettarget")
		if target then
			self:CastFlame(target)
		else
			self:CastFlame(L.FlamecastUnknown)
		end
		castFlames = false
	end
end 

function mod:CastFlame(target)
	warnDevouringFlameCast:Show(target)
	if target == UnitName("player") then
		specWarnDevouringFlameCast:Show()
	end
	self:SetIcon(target, 8, 9)
end 