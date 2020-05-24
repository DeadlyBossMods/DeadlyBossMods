local mod	= DBM:NewMod(2389, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162309)
mod:SetEncounterID(2364)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 319521 319637 319416 319626",
--	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS 319521 319390 319626 319589"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Get correct draw soul event
--TODO, number of players affected by draw soul
--TODO, is haunt actually dispelable?
--TODO, remove CombinedShow on haunt if only one victim at a time
local warnConsumedSoul				= mod:NewTargetNoFilterAnnounce(319637, 4)
local warnHaunt						= mod:NewTargetNoFilterAnnounce(319626, 3, nil, "Healer|RemoveMagic")

local specWarnDrawSoul				= mod:NewSpecialWarningRun(319521, nil, nil, nil, 4, 2)--Want to run away from boss to spawn it further away
--local yellDrawSoul				= mod:NewYell(319521)
local specWarnTornSoul				= mod:NewSpecialWarningYou(319416, nil, nil, nil, 1, 2)--expel Soul debuff
--local yellTornSoul				= mod:NewYell(319416)
local specWarnHaunt					= mod:NewSpecialWarningMoveAway(319626, nil, nil, nil, 1, 2)
local yellHaunt						= mod:NewYell(319626)
local specWarnGraspingHands			= mod:NewSpecialWarningDodge(319589, nil, nil, nil, 2, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDrawSoulCD				= mod:NewAITimer(13, 319521, nil, nil, nil, 3, nil, DBM_CORE_Translations.DAMAGE_ICON)
local timerExpelSoulCD				= mod:NewAITimer(15.8, 319390, nil, nil, nil, 3)
local timerHauntCD					= mod:NewAITimer(13, 319626, nil, nil, nil, 3, nil, DBM_CORE_Translations.HEALER_ICON)--DBM_CORE_Translations.MAGIC_ICON tooltip shows it dispelable, journal does not
local timerGraspingHandsCD			= mod:NewAITimer(15.8, 319589, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerDrawSoulCD:Start(1-delay)
	timerExpelSoulCD:Start(1-delay)--SUCCESS
	timerHauntCD:Start(1-delay)--SUCCESS
	timerGraspingHandsCD:Start(1-delay)--SUCCESS
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257402 then

--	elseif spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 319521 then
		timerDrawSoulCD:Start()
	elseif spellId == 319390 then
		timerExpelSoulCD:Start()
	elseif spellId == 319626 then
		timerHauntCD:Start()
	elseif spellId == 319589 then
		specWarnGraspingHands:Show()
		specWarnGraspingHands:Play("watchstep")
		timerGraspingHandsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 319521 then
		if args:IsPlayer() then
			specWarnDrawSoul:Show()
			specWarnDrawSoul:Play("justrun")
			--yellDrawSoul:Yell()
		end
	elseif spellId == 319637 then
		warnConsumedSoul:Show(args.destName)
	elseif spellId == 319416 then
		if args:IsPlayer() then
			specWarnTornSoul:Show()
			specWarnTornSoul:Play("targetyou")
			--yellTornSoul:Yell()
		end
	elseif spellId == 319626 then
		if args:IsPlayer() then
			specWarnHaunt:Show()
			specWarnHaunt:Play("runout")
			yellHaunt:Yell()
		else
			warnHaunt:CombinedShow(0.3, args.destName)
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
