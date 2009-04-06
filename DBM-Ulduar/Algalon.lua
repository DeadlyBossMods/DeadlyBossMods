local mod = DBM:NewMod("Algalon", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

-- freely created by provided informations from
-- http://www.mmo-champion.com/index.php?page=850
-- this mod issn't fully working and finished - please provide combatlogs

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local timerBigBangCast		= mod:NewTimer(8, "TimerBigBangCast", 64584)
local announceBlackHole		= mod:NewAnnounce("WarningBlackHole", 2, 65108)
local announcePhasePunch	= mod:NewAnnounce("WarningPhasePunch", 4, 65108)
local specWarnPhasePunch	= mod:NewSpecialWarning("SpecWarnPhasePunch")

function mod:OnCombatStart(delay)
	DBM:AddMsg("We require more combatlogs on www.deadlybossmods.com to improve DBM, start logging now")
	LoggingCombat(1)
	LoggingChat(1)
end

function mod:OnCombatEnd()
	LoggingCombat(0)	
	LoggingChat(0)
	DBM:AddMsg("[DE] Hallo, dieses Bossmod ist nicht fertig. Ein Chat und Kampflog wurde erzeugt, bitte lade es auf www.deadlybossmods.com hoch.")
	DBM:AddMsg("[EN] Hello, this Bossmod is not yet finished. A Chat and Combatlog was created, please upload it on www.deadlybossmods.com.")
end


function mod:SPELL_CAST_START(args)
	if args.spellId == 65108 then 	-- Black Hole Explosion
		announceBlackHole:Show()

	--elseif args.spellId == 62311 then	-- Cosmic Smash
	--elseif args.spellId == 64395 then	-- Quantum Strike
	--elseif args.spellId == 64412 then 	-- Phase Punch

	elseif args.spellId == 64584 then 	-- Big Bang
		timerBigBangCast:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64412 then
		if args.destName == UnitName("player") then
			specWarnPhasePunch:Show()
		end
		announcePhasePunch:Show(args.destName)
	end
end

