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
local specWarnPhantasmalParasiteDPL	= mod:NewSpecialWarningDispel(319626, "RemoveMagic", nil, nil, 1, 2)
local yellPhantasmalParasite		= mod:NewYell(319626)
local specWarnGraspingHands			= mod:NewSpecialWarningDodge(319589, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDrawSoulCD				= mod:NewCDTimer(20.5, 319521, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPhantasmalParasiteCD		= mod:NewCDTimer(25.5, 319626, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerGraspingHandsCD			= mod:NewCDTimer(20.6, 319589, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerPhantasmalParasiteCD:Start(3.3-delay)--SUCCESS
	timerGraspingHandsCD:Start(8.2-delay)--SUCCESS
	timerDrawSoulCD:Start(15.5-delay)
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
		local dispelWarned = false
		if self.Options.SpecWarn319626dispel and args:IsDestTypePlayer() and self:CheckDispelFilter() then
			specWarnPhantasmalParasiteDPL:Show(args.destName)
			specWarnPhantasmalParasiteDPL:Play("helpdispel")
			dispelWarned = true
		end
		if args:IsPlayer() then
			if not dispelWarned then--If player is a dispeller, they may have already gotten alert to dispel themselves
				specWarnPhantasmalParasite:Show()
				specWarnPhantasmalParasite:Play("runout")
			end
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
