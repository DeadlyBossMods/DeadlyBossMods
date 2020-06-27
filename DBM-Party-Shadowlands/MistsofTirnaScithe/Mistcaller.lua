local mod	= DBM:NewMod(2402, "DBM-Party-Shadowlands", 3, 1184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(126983)--Maybe 164501?
mod:SetEncounterID(2392)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 321471 321834 321873 321828",
	"SPELL_AURA_APPLIED 321891 321828",
	"SPELL_AURA_REMOVED 321891"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--https://shadowlands.wowhead.com/npc=165108/illusionary-clone Clones
--TODO, improve dodgeball warnings if the target scan is successful
--TODO, auto mark adds during guessing game (use Penalizing Burst to grab GUIDS)
local warnGuessingGame				= mod:NewCastAnnounce(321471, 3)
local warnFreezeTag					= mod:NewCastAnnounce(321873, 3)
local warnFixate					= mod:NewTargetNoFilterAnnounce(321891, 3)

local specWarnDodgeBall				= mod:NewSpecialWarningDodge(321834, nil, nil, nil, 2, 2)
local yellDodgeBall					= mod:NewYell(321834)
local specWarnFixate				= mod:NewSpecialWarningRun(321891, nil, nil, nil, 4, 2)
local specWarnPattyCakes			= mod:NewSpecialWarningYou(321828, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerGuessingGameCD			= mod:NewAITimer(13, 321471, nil, nil, nil, 6)
local timerDodgeBallCD				= mod:NewAITimer(13, 321834, nil, nil, nil, 3)
local timerFreezeTagCD				= mod:NewAITimer(13, 321873, nil, nil, nil, 3)
local timerPattyCakesCD				= mod:NewAITimer(13, 321828, nil, nil, nil, 3)

mod:AddNamePlateOption("NPAuraOnFixate", 321891)

function mod:BallTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellDodgeBall:Yell()
	end
	DBM:AddMsg("BallTarget returned: "..targetname.." Report if accurate or inaccurate to DBM Author")
end

function mod:OnCombatStart(delay)
	timerGuessingGameCD:Start(1-delay)
	timerDodgeBallCD:Start(1-delay)
	timerFreezeTagCD:Start(1-delay)
	timerPattyCakesCD:Start(1-delay)
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 321471 then
		warnGuessingGame:Show()
		timerGuessingGameCD:Start()
	elseif spellId == 321834 then
		specWarnDodgeBall:Show()
		specWarnDodgeBall:Play("shockwave")
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "BallTarget", 0.1, 6)
		timerDodgeBallCD:Start()
	elseif spellId == 321873 then
		warnFreezeTag:Show()
		timerFreezeTagCD:Start()
	elseif spellId == 321828 then
		timerPattyCakesCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 257316 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 321891 then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("runout")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 6)
			end
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 321828 then
		if args:IsPlayer() then
			specWarnPattyCakes:Show()
			specWarnPattyCakes:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 321891 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
