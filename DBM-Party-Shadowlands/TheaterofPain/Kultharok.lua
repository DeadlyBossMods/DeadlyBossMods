local mod	= DBM:NewMod(2389, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162309)
mod:SetEncounterID(2364)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS 319521 319626 319589",
	"SPELL_AURA_APPLIED 319521 319416 319626 333567",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, is PhantasmalParasite actually dispelable?
--TODO, Spectral Reach (319669) needed?
--[[
(ability.id = 319521 or ability.id = 319626 or ability.id = 319589) and type = "cast"
--]]
local warnDrawSoul					= mod:NewTargetAnnounce(319521, 2)
local warnPhantasmalParasite		= mod:NewTargetNoFilterAnnounce(319626, 3, nil, "Healer|RemoveMagic")
local warnPossession				= mod:NewTargetNoFilterAnnounce(333567, 4)

local specWarnDrawSoul				= mod:NewSpecialWarningRun(319521, nil, nil, nil, 4, 2)--Want to run away from boss to spawn it further away
--local yellDrawSoul				= mod:NewYell(319521)
local specWarnTornSoul				= mod:NewSpecialWarningYou(319416, nil, nil, nil, 1, 2)--expel Soul debuff
--local yellTornSoul				= mod:NewYell(319416)
local specWarnPhantasmalParasite	= mod:NewSpecialWarningMoveAway(319626, nil, nil, nil, 1, 2)
local yellPhantasmalParasite		= mod:NewYell(319626)
local specWarnGraspingHands			= mod:NewSpecialWarningDodge(319589, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDrawSoulCD				= mod:NewCDTimer(20.5, 319521, nil, nil, nil, 3, nil, DBM_CORE_L.DAMAGE_ICON)
local timerPhantasmalParasiteCD		= mod:NewCDTimer(25.5, 319626, nil, nil, nil, 3, nil, DBM_CORE_L.HEALER_ICON)--DBM_CORE_L.MAGIC_ICON tooltip shows it dispelable, journal does not
local timerGraspingHandsCD			= mod:NewCDTimer(25.5, 319589, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerPhantasmalParasiteCD:Start(3.6-delay)--SUCCESS
	timerGraspingHandsCD:Start(8.5-delay)--SUCCESS
	timerDrawSoulCD:Start(15.8-delay)
end

--[[
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257402 then

--	elseif spellId == 257397 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnHealingBalm:Show(args.sourceName)
--		specWarnHealingBalm:Play("kickcast")
	end
end
--]]

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 319521 then
		timerDrawSoulCD:Start()
	elseif spellId == 319626 then
		timerPhantasmalParasiteCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 319521 then
		if args:IsPlayer() then
			specWarnDrawSoul:Show()
			specWarnDrawSoul:Play("justrun")
			--yellDrawSoul:Yell()
		else
			warnDrawSoul:Show(args.destName)
		end
	elseif spellId == 319416 then
		if args:IsPlayer() then
			specWarnTornSoul:Show()
			specWarnTornSoul:Play("targetyou")
			--yellTornSoul:Yell()
		end
	elseif spellId == 319626 then
		if args:IsPlayer() then
			specWarnPhantasmalParasite:Show()
			specWarnPhantasmalParasite:Play("runout")
			yellPhantasmalParasite:Yell()
		else
			warnPhantasmalParasite:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 333567 then
		warnPossession:Show(args.destName)
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 319589 then
		specWarnGraspingHands:Show()
		specWarnGraspingHands:Play("watchstep")
		timerGraspingHandsCD:Start()
	end
end
