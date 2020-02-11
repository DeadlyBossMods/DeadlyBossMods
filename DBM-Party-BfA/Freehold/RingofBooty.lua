local mod	= DBM:NewMod(2094, "DBM-Party-BfA", 2, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(126969)
mod:SetEncounterID(2095)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 256405 256489",
	"SPELL_CAST_SUCCESS 256358"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_REMOVED_DOSE 257829",
	"SPELL_AURA_REMOVED 257829",
	"UNIT_DIED"
)

--(ability.id = 256405 or ability.id = 256489) and type = "begincast" or ability.id = 256358
local warnSharkToss					= mod:NewTargetAnnounce(256358, 2)
local warnGreasy					= mod:NewCountAnnounce(257829, 2)

local specWarnSharkToss				= mod:NewSpecialWarningYou(256358, nil, nil, nil, 1, 2)
local specWarnSharkTossNear			= mod:NewSpecialWarningClose(256358, nil, nil, nil, 1, 2)
local yellSharkToss					= mod:NewYell(256358)
local specWarnSharknado				= mod:NewSpecialWarningRun(256405, nil, nil, nil, 4, 2)
local specWarnRearm					= mod:NewSpecialWarningDodge(256489, nil, nil, nil, 2, 2)

local timerRP						= mod:NewRPTimer(68)
--local timerSharkTossCD			= mod:NewCDTimer(31.5, 194956, nil, nil, nil, 3)--Disabled until more data, seems highly variable, even pull to pull
local timerSharknadoCD				= mod:NewCDTimer(26.9, 256405, nil, nil, nil, 3)
local timerRearmCD					= mod:NewCDTimer(40, 256489, nil, nil, nil, 3)

mod:AddRangeFrameOption(8, 256358)

--"Shark Toss-256358-npc:126969 = pull:14.4, 31.5, 40.1, 40.1", -- [8]

function mod:OnCombatStart(delay)
	timerSharknadoCD:Start(20.4-delay)
	timerRearmCD:Start(43.5-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 256405 then
		specWarnSharknado:Show()
		specWarnSharknado:Play("justrun")
		timerSharknadoCD:Start()
	elseif spellId == 256489 then
		specWarnRearm:Show()
		specWarnRearm:Play("farfromline")
		timerRearmCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 256358 then
		if args:IsPlayer() then
			specWarnSharkToss:Show()
			specWarnSharkToss:Play("runaway")
			yellSharkToss:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnSharkTossNear:Show(args.destName)
			specWarnSharkTossNear:Play("watchstep")
		else
			warnSharkToss:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 257829 then
		local amount = args.amount or 0
		warnGreasy:Show(amount)
		--"<78.80 02:52:31> [CLEU] SPELL_AURA_REMOVED#Creature-0-2084-1754-9152-130099-00007D20E9#Lightning#Creature-0-2084-1754-9152-130099-00007D20E9#Lightning#257829#Greasy#BUFF#nil", -- [62]
		--"<104.47 02:52:56> [IsEncounterInProgress()] true", -- [69]
		if amount == 0 then
			timerRP:Start(25)
		end
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_REMOVED_DOSE

--"<146.61 02:53:38> [CLEU] UNIT_DIED##nil#Creature-0-2084-1754-9152-129699-00007D20E9#Ludwig Von Tortollen#-1#false#nil#nil", -- [334]
--"<182.54 02:54:14> [ENCOUNTER_START] ENCOUNTER_START#2095#Ring of Booty#1#5", -- [366]
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 129699 then--Ludwig Von Tortollen
		timerRP:Start(35)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	--"<0.92 02:51:13> [CHAT_MSG_MONSTER_YELL] Gather 'round and place yer bets! We got a new set of vict-- uh... competitors! Take it away, Gurthok and Wodin!#Davey \"Two Eyes\"###Hunyadi##0#0##0#1165#nil#0#false#false#false#false",
	--"<63.07 02:52:15> [CLEU] SPELL_AURA_APPLIED#Creature-0-2084-1754-9152-130099-00007D20E9#Lightning#Creature-0-2084-1754-9152-130099-00007D20E9#Lightning#257829#Greasy#BUFF#nil", -- [23]
	if (msg == L.openingRP or msg:find(L.openingRP)) and self:LatencyCheck(1000) then
		self:SendSync("openingRP")
	end
end

function mod:OnSync(msg, targetname)
	if msg == "openingRP" and self:AntiSpam(10, 6) then
		timerRP:Start(62)
	end
end
