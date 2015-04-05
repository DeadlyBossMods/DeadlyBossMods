local mod	= DBM:NewMod("Teluur", "DBM-WorldEvents", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90946)
mod:SetZone(1159, 1331, 1158, 1153, 1152, 1330)--4 of these not needed, but don't know what's what ATM

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180849",
	"SPELL_CAST_SUCCESS 180836 180849",
	"SPELL_AURA_APPLIED 180836",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnPodlingSwarm			= mod:NewSpellAnnounce(180836, 2)
local warnEntanglement			= mod:NewTargetAnnounce(180836, 3)--Players who didn't move and got caught
local warnSpore					= mod:NewSpellAnnounce(180825, 3)--Hidden from combat log, until it's too late. Unit event gives enough time to run out but don't know who it's targeting then. target scanning seems to kinda work but not reliable enough. There is somewhat of a delay and often no target at all

local specWarnEntanglement		= mod:NewSpecialWarningDodge(180836)--Dodgable. puts green swirly under random player. traps everyone there after 4 seconds. Target scanning not possible, warn everyone to check feet
--local specWarnSpore				= mod:NewSpecialWarningRun(180825, nil, nil, nil, 4)
--local yellSpore					= mod:NewYell(180825)

local timerEntanglementCD		= mod:NewNextTimer(10, 180836)--CD is 10 unless delayed by podlings
local timerPodlingSwarmCD		= mod:NewCDTimer(30, 180836)--30-32 variable, clearly a 30 second cd from cast finish or engage
local timerSporeCD				= mod:NewCDTimer(15, 180825)--15-20

function mod:OnCombatStart(delay)
	timerEntanglementCD:Start(10)
	timerSporeCD:Start(11)
	timerPodlingSwarmCD:Start(30)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180849 then
		warnPodlingSwarm:Show()
		timerEntanglementCD:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180836 then
		specWarnEntanglement:Show()
		timerEntanglementCD:Start()
	elseif spellId == 180849 then
		timerEntanglementCD:Start()--Will be cast 10 seconds after cast FINISH of podlings
		timerPodlingSwarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180836 then
		warnEntanglement:CombinedShow(0.5, args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 180825 and self:AntiSpam() then
		self:SendSync("Spore")
	end
end

function mod:OnSync(msg)
	if msg == "Spore" then
		warnSpore:Show()
		timerSporeCD:Start()
	end
end
