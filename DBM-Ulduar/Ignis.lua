local mod = DBM:NewMod("Ignis", "DBM-Ulduar")
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))

mod:SetZone()

-- freely created by provided informations from
-- http://www.mmo-champion.com/index.php?page=839
-- this mod issn't fully working and finished - please provide combatlogs

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnFlameJetsCast			= mod:NewSpecialWarning("SpecWarnJetsCast")	-- counterspell (says tooltip^^)
local timerFlameJetsCast		= mod:NewTimer(2.7, "TimerFlameJetsCast", 63472)
local timerFlameJetsCooldown		= mod:NewTimer(35, "TimerFlameJetsCooldown", 63472)

local timerScorchCooldown		= mod:NewTimer(25, "TimerScorch", 63473)
local timerScorchCast			= mod:NewTimer(3, "TimerScorchCast", 63473)

local announceSlagPot			= mod:NewAnnounce("WarningSlagPot", 3, 63477)
local timerSlagPot			= mod:NewTimer(10, "TimerSlagPot", 63477)

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
	if args.spellId == 63472 then		-- Flame Jets
		timerFlameJetsCast:Start()
		warnFlameJetsCast:Show()
		timerFlameJetsCooldown:Start()

	elseif args.spellId == 63473 then	-- Scorch
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63477 then		-- Slag Pot
		announceSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
	end
end


