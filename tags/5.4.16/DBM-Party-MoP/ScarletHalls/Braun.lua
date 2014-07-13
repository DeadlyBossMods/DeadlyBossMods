local mod	= DBM:NewMod(660, "DBM-Party-MoP", 8, 311)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59303)
mod:SetEncounterID(1422)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnPiercingThrow			= mod:NewSpellAnnounce(114021, 2)
local warnDeathBlossom			= mod:NewSpellAnnounce(114242, 3)
local warnCallDog				= mod:NewSpellAnnounce(114259, 4)
local warnBloodyRage			= mod:NewSpellAnnounce(116140, 4)

local timerPiercingThrowCD		= mod:NewNextTimer(6, 114021)
local timerDeathBlossomCD		= mod:NewNextTimer(6, 114242)

--local throwCount = 0
--local barProgress = 0

--Old Data
--Heroic Pull 1 Throw/Blossom Pattern 12, 6, 6, Dog, 12, Dog, 12, 6, 6, 6, Dog, 12, 6, Dog, 12, 6, 6, Blood, 13.5, 6

--New Data (build 15799, 7/9 05:19)
--inaccrate existing data, need to rebuild timer.
--[[
"<1480.8> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Braun#", -- [28135]
"<1487.8> [CLEU] 114021#Throw#1", -- [28296]
"<1492.9> [CLEU] 114259#Call Dog#1", -- [28485] -- 90%
"<1498.9> [CLEU] 114259#Call Dog#1", -- [28747] -- 80%
"<1505.9> [CLEU] 114021#Throw#1", -- [29085]
"<1512.6> [CLEU] 114259#Call Dog#1", -- [29354] -- 70%
"<1512.6> [CLEU] 114242#Blossom#1", -- [29349]
"<1523.9> [CLEU] 114021#Throw#1", -- [29857]
"<1526.8> [CLEU] 114259#Call Dog#1", -- [29973] -- 60%
"<1535.8> [CLEU] 114021#Throw#1", -- [30425]
"<1538.7> [CLEU] 116140#Blood Rage#1", -- [30571] -- 50%
"<1552.4> [CLEU] 114242#Blossom#1", -- [31206]
"<1558.8> [UNIT_SPELLCAST_SUCCEEDED] Braun [boss1:Throw::0:114086]", -- [31462]
"<1562.1> [UNIT_SPELLCAST_SUCCEEDED] Braun [boss1:Throw::0:114086]", -- [31558]
"<1564.8> [UNIT_SPELLCAST_SUCCEEDED] Braun [boss1:Throw::0:114086]", -- [31654]
"<1568.4> [CLEU] 114242#Blossom#1", -- [31782]
"<1570.8> [UNIT_SPELLCAST_SUCCEEDED] Braun [boss1:Throw::0:114086]", -- [31867]
"<1584.8> [CLEU] UNIT_DIED#Braun#68168#0", -- [32372]
]]

function mod:OnCombatStart(delay)
--	throwCount = 0
--	barProgress = 0
	timerPiercingThrowCD:Start(7-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 114021 then
--		throwCount = throwCount + 1
		warnPiercingThrow:Show()
--		if throwCount < 2 then
--			timerPiercingThrowCD:Start()
--		else
--			timerDeathBlossomCD:Start()
--		end
	elseif args.spellId == 114242 then
		warnDeathBlossom:Show()
--		timerPiercingThrowCD:Start()
	elseif args.spellId == 114259 then--Call Dog
		warnCallDog:Show()
--[[
		if timerPiercingThrowCD:IsStarted() then--When this is cast, it extend the current CD of throw/blossom from 6 to 12
			barProgress = timerPiercingThrowCD:GetTime() --So we see how far of 6 second cd we are into
			timerPiercingThrowCD:Update(12 - barProgress, 12)--then we subtrack it from 12, then update bar with what's remaining
		elseif timerDeathBlossomCD:IsStarted() then
			barProgress = timerDeathBlossomCD:GetTime() 
			timerDeathBlossomCD:Update(12 - barProgress, 12)
		end
]]
	elseif args.spellId == 116140 then--Blood Rage(done calling dogs)
--		throwCount = 0
		warnBloodyRage:Show()
		timerPiercingThrowCD:Start(13.5)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 114086 then
		warnPiercingThrow:Show()
	end
end
