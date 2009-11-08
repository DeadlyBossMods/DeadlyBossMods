local mod = DBM:NewMod("Deathwhisper", "DBM-Icecrown", 1)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 1799 $"):sub(12, -3))
mod:SetCreatureID(36855)
--mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnDominateMind	= mod:NewTargetAnnounce(71289, 3)
local warnFrostbolt		= mod:NewCastAnnounce(72007, 2)
local warnDeathDecay	= mod:NewAnnounce("WarnDeathDecay", 2)
local warnAddsSoon		= mod:NewAnnounce("WarnAddsSoon" , 4)
local warnPhase2		= mod:NewPhaseAnnounce(2, 3)
local warnAddherent		= mod:NewAnnounce("WarnAdherent", 2)

local specWarnCurseTorpor	= mod:NewSpecialWarning("SpecWarnCurseTorpor")
local specWarnDeathDecay	= mod:NewSpecialWarning("SpecWarnDeathDecay")

local timerAdds             = mod:NewTimer(21, "TimerAdds")
local timerDominateMind		= mod:NewTargetTimer(20, 71289)
local timerDominateMindCD	= mod:NewCDTimer(40, 71289)

local enrageTimer		= mod:NewEnrageTimer(600)

local lastDD = 0

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAdds:Start(10)
	warnAddsSoon:Schedule(7)
	timerDominateMindCD:Start(30)	-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(71289) then
		warnDominateMind:Show(args.destName)
		timerDominateMind:Start(args.destName)
		timerDominateMindCD:Start()
	elseif args:IsSpellID(72108, 71001) then
		if args:IsPlayer() then
			specWarnDeathDecay:Show()
		end
		if (GetTime() - lastDD > 5) then
			warnDeathDecay:Show()
			lastDD = GetTime()
		end
	elseif args:IsSpellID(71237) and args:IsPlayer() then
		specWarnCurseTorpor:Show()
	end
end


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70842) then
		warnPhase2:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(72007) then
		warnFrostbolt:Show()
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAdds then
		self:SendSync("Adds")
	elseif msg == L.YellAdherent then
		self:SendSync("Adherent")
--[[	elseif msg == L.YellEmbrace then
		self:SendSync("Embrace")
	elseif msg == L.YellBlessing then
		self:SendSync("Blessing")
						Dont know exactly what these 2 yells do, but added them in case they are needed :) 
]]--
	end
end

function mod:OnSync(msg, arg)
	if msg == "Adds" then
		timerAdds:Start()
		warnAddsSoon:Schedule(18)
	elseif msg == "Adherent" then
		warnAdherent:Show()
	end
end