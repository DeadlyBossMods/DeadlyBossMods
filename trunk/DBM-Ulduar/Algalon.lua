local mod = DBM:NewMod("Algalon", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(32871)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

local timerNextBigBang		= mod:NewCDTimer(90.5, 64584)
local timerBigBangCast		= mod:NewCastTimer(8, 64584)
local announceBigBang		= mod:NewAnnounce("WarningBigBang", 3, 64584)
local announcePreBigBang	= mod:NewAnnounce("PreWarningBigBang", 3, 64584)

local timerNextColapsingStar	= mod:NewTimer(15, "NextColapsingStar")
local timerCDCosmicSmash	= mod:NewTimer(25, "PossibleNextCosmicSmash")

local announceBlackHole		= mod:NewAnnounce("WarningBlackHole", 2, 65108)

local timerPhasePunch		= mod:NewBuffActiveTimer(45, 64412)
local timerNextPhasePunch	= mod:NewNextTimer(16, 64412)
local announcePhasePunch	= mod:NewAnnounce("WarningPhasePunch", 4, 65108)
local specWarnPhasePunch	= mod:NewSpecialWarning("SpecWarnPhasePunch")

local enrageTimer		= mod:NewEnrageTimer(366) -- combatstart take some combattime

local phase = 0

function mod:OnCombatStart(delay)
	phase = 1
	enrageTimer:Start(-delay)
	-- added 6 seconds because of +combat until spawn difference
	timerNextBigBang:Start(96.5-delay)
	announcePreBigBang:Schedule(86-delay)
	timerNextColapsingStar:Start(21-delay)
	timerCDCosmicSmash:Start(31-delay)
end

function mod:UNIT_HEALTH(unitid)
	if phase == 1 and UnitName(unitid) == L.name then
		if UnitHealth(unitid) <= 20 then
			phase = 2
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 65108 then 	-- Black Hole Explosion
		announceBlackHole:Show()
	
	elseif args.spellId == 64584 then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64412 then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args.destName == UnitName("player") and amount >= 3 then
			specWarnPhasePunch:Show()
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == "%s begins to Summon Collapsing Stars!" then
		timerNextColapsingStar:Start()
	elseif msg == "%s begins to cast Cosmic Smash!" then
		timerCDCosmicSmash:Start()
	end
end

--[[
(18:33:24) Kyrana: 6 min enrage timer 
beginn entweder mit dem ersten hit vom tank auf ihn oder dem ersten hit von ihm auf den tank, dazwischen liegen paar sec weil er erst noch labert
sollte sich aber anhand der logs sagen lassen da gleichzeitig auch der timer für big bang startet Big Bang alle 1:30 -> durch die voidportale   
(reset bei 20%?) 15sec in fight Erste Sternengruppe (Collapsing Star) 4 Stück, von da an alle 15sec (laut  Aussage, im Video sieht’s nach wesentlich mehr aus)Nacheinander töten -> Black Hole Explosion ->Black Hole (für BigBang) 

(18:33:40) Kyrana: Cosmic Smash alle 25sec, void (wie bei Kel) unter demjenigen Rauslaufen und Abstand halten Kein Targeting vom Boss, keine erkannter debuff auf dem mit der Void Living Constellations ca jede 1:10min Aggroliste, stun bar, benötigen keine Aufmerksamkeit, schießen nach ihrer Aggroliste immer wieder Bolts, kein nennenswerter dmg/effektLiving Constellations schließen immer wieder die Voidportale Phase Punch Alle 15sec auf den Tank -> debuff, bei ca 3 taunt vom anderen Tank Debuff hält 45 secBei 5 stacks wird der tank von algalon ignoriert 

(18:33:51) Kyrana: 20% Alle Collapsing Stars, Living Constellations und Black Holes verschwinden4 neue Black Holes erscheinen (kann man nicht durch) daraus spawnt je ein Unleashed Dark Matter, offtanken, weiter dmg auf Algalon25-30sec später nochmal 4 (genauen timer im log?) Quantum Strike alle 30 sec ?    Wichtigsten Timer:EnrageBigBangPhase Punsh (plus ansage wieviele Stacks wann taunt (ca 3 stacks), wanns bei dem Tank ausläuft)Cosmic Smash Collapsing StarLiving Constellation Bei 20% ansage Unleashed Dark Matter gleich oä + Timer für nächsten   
--]]

