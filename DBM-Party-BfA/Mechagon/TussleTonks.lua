local mod	= DBM:NewMod(2336, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144244, 145185)
mod:SetEncounterID(2257)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 285020 283422 285388",
	"SPELL_CAST_SUCCESS 285344 285152",
	"SPELL_AURA_REMOVED 282801 285388",
	"SPELL_AURA_REMOVED_DOSE 282801",
	"UNIT_DIED"
)

--TODO, Foe Flipper success target valid?
--TODO, thrust scan was changed to slower scan method, because UNIT_TARGET scan method relies on boss changing target after cast begins, but 8.3 notes now say boss changes target before cast starts
--TODO, the part two of above is need to verify whether or not a target scanner is even needed at all now. If boss is already looking at atarget at cast start then all we need is boss1target and no scan what so ever
--[[
(ability.id = 285020 or ability.id = 283422 or ability.id = 285388) and type = "begincast"
 or (ability.id = 285344 or ability.id = 285152) and type = "cast"
 --]]
local warnPlatinumPlating			= mod:NewCountAnnounce(282801, 2)
local warnLayMine					= mod:NewSpellAnnounce(285351, 2)
local warnFoeFlipper				= mod:NewTargetNoFilterAnnounce(285153, 2)
local warnVentJets					= mod:NewEndAnnounce(285388, 1)
local warnMaxThrust					= mod:NewTargetNoFilterAnnounce(283565, 2)

local specWarnWhirlingEdge			= mod:NewSpecialWarningDodge(285020, "Tank", nil, nil, 1, 2)
local specWarnVentJets				= mod:NewSpecialWarningDodge(285388, nil, nil, nil, 2, 2)
local specWarnMaxThrust				= mod:NewSpecialWarningYou(283565, nil, nil, nil, 1, 2)
local yellMaxThrust					= mod:NewYell(283565)
local specWarnFoeFlipper			= mod:NewSpecialWarningYou(285153, nil, nil, nil, 1, 2)
local yellFoeFlipper				= mod:NewYell(285153)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerRP						= mod:NewRPTimer(68)
local timerLayMineCD				= mod:NewCDTimer(12.1, 285351, nil, nil, nil, 3)
local timerWhirlingEdgeCD			= mod:NewNextTimer(32.8, 285020, nil, "Tank", nil, 5, nil, DBM_CORE_Translations.TANK_ICON)
--local timerFoeFlipperCD				= mod:NewAITimer(13.4, 285153, nil, nil, nil, 3)
local timerVentJetsCD				= mod:NewCDTimer(43.8, 285388, nil, nil, nil, 2)
local timerMaxThrustCD				= mod:NewCDTimer(45.8, 283565, nil, nil, nil, 3)

function mod:ThrustTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnMaxThrust:Show()
		specWarnMaxThrust:Play("targetyou")
		yellMaxThrust:Yell()
	else
		warnMaxThrust:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	--timerMaxThrustCD:Start(3-delay)
	timerWhirlingEdgeCD:Start(8.2-delay)
	timerLayMineCD:Start(15.5-delay)
	--timerFoeFlipperCD:Start(16.7-delay)
	timerVentJetsCD:Start(22.8-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 285020 then
		specWarnWhirlingEdge:Show()
		specWarnWhirlingEdge:Play("shockwave")
		timerWhirlingEdgeCD:Start()
	elseif spellId == 283422 then
		timerMaxThrustCD:Start()
		self:BossTargetScanner(args.sourceGUID, "ThrustTarget", 0.1, 7)
	elseif spellId == 285388 then
		specWarnVentJets:Show()
		specWarnVentJets:Play("watchstep")
		timerVentJetsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 285344 then
		warnLayMine:Show()
		timerLayMineCD:Start()
	elseif spellId == 285152 then
		if args:IsPlayer() then
			specWarnFoeFlipper:Show()
			specWarnFoeFlipper:Play("targetyou")
			yellFoeFlipper:Yell()
		else
			warnFoeFlipper:Show(args.destName)
		end
		--timerFoeFlipperCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282801 then
		local amount = args.amount or 0
		warnPlatinumPlating:Cancel()
		warnPlatinumPlating:Schedule(0.5, amount)
	elseif spellId == 285388 then
		warnVentJets:Show()
		timerVentJetsCD:Stop()
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144244 then--The Platinum Pummeler
		timerWhirlingEdgeCD:Stop()
	elseif cid == 145185 then--Gnomercy 4.U.
		--timerFoeFlipperCD:Stop()
		timerVentJetsCD:Stop()
		timerMaxThrustCD:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	--"<745.04 00:25:22> [CHAT_MSG_MONSTER_YELL] Now this is a statistical anomaly! Our visitors are still alive!#Deuce Mecha-Buffer###Anshlun##0#0##0#2667#nil#0#false#false#false#false", -- [3780]
	--"<769.56 00:25:47> [ENCOUNTER_START] 2257#Tussle Tonks#23#5", -- [3807]
	if (msg == L.openingRP or msg:find(L.openingRP)) and self:LatencyCheck(1000) then
		self:SendSync("openingRP")
	end
end

function mod:OnSync(msg, targetname)
	if msg == "openingRP" and self:AntiSpam(10, 1) then
		timerRP:Start(24.5)
	end
end
