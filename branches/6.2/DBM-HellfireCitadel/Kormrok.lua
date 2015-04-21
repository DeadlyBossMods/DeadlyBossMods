local mod	= DBM:NewMod(1392, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(76877)
mod:SetEncounterID(1787)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181292 181293 181296 181297 181299 181300",
	"SPELL_CAST_SUCCESS 180068 180115 180116 180117 181305",
	"SPELL_AURA_APPLIED 180244 181306",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 181306",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fix leap ID, i'm suspect of it being instant cast, maybe it is though.
--TODO, verify energy IDs, all of them had 2 Potential canidates.
--TODO, target announce, maybe mark players in grasping hands.
local warnLeap						= mod:NewSpellAnnounce(180068, 3)
local warnShadowEnergy				= mod:NewSpellAnnounce(180115, 2)
local warnExplosiveEnergy			= mod:NewSpellAnnounce(180116, 3)
local warnFoulEnergy				= mod:NewSpellAnnounce(180117, 2)
--These are probably temp, changed to better tank special warnings when better understood
local warnSwat						= mod:NewSpellAnnounce(181305, 3, nil, "Tank|Healer")
local warnExplosiveBurst			= mod:NewTargetAnnounce(181306, 4)--Concerns everyone

local specWarnPound					= mod:NewSpecialWarningSpell(180244, nil, nil, nil, 2, nil, 2)
local specWarnEmpShadowWaves		= mod:NewSpecialWarningDodge(181293, nil, nil, nil, 2, nil, 2)
local specWarnShadowWaves			= mod:NewSpecialWarningDodge(181292, nil, nil, nil, 2, nil, 2)
local specWarnExplosiveRunes		= mod:NewSpecialWarningMoveTo(181296, "-Tank")--Might need tweaking once more visible strategy and quantity of runes observed.
local specWarnGraspingHands			= mod:NewSpecialWarningSwitch(181299, "Dps")--Do tanks need to help? is it bad for tanks to help?
--Empowered versions (made separate so users can set different sounds for the more dangerous versions if they choose)
local specWarnEmpShadowWaves		= mod:NewSpecialWarningDodge(181293, nil, nil, nil, 2, nil, 2)
local specWarnEmpExplosiveRunes		= mod:NewSpecialWarningMoveTo(181297, "-Tank")
local specWarnDraggingHands			= mod:NewSpecialWarningSwitch(181300, "Dps")--Are these still dpsed?

--local timerLeapCD					= mod:NewCDTimer(107, 180068)
--local timerPoundCD				= mod:NewCDTimer(107, 180244)
--local timerShadowWavesCD			= mod:NewCDTimer(107, 181292)
--local timerExplosiveRunesCD		= mod:NewCDTimer(107, 181297)
--local timerGraspingHandsCD		= mod:NewCDTimer(107, 181299)
--local timerTankSpecialCD			= mod:NewSpecialCDTimer(107)--3 tank specials have same cd, but what ability is used is based on bosses current empowerment

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownExplosiveBurst		= mod:NewCountdown("Alt10", 181306)

local voicePound					= mod:NewVoice(180244)--aesoon
local voiceShadowWaves				= mod:NewVoice(181292)--watchwave

mod:AddRangeFrameOption(40, 181306)
--mod:AddHudMapOption("HudMapOnShatter", 155530, false)


local debuffFilter
do
	local debuffName = GetSpellInfo(181306)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--[[	if self.Options.HudMapOnShatter then
		DBMHudMap:Disable()
	end--]]
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 181292 or spellId == 181293 then
		if spellId == 181293 then
			specWarnEmpShadowWaves:Show()
		else
			specWarnShadowWaves:Show()
		end
		voiceShadowWaves:Play("watchwave")
		--timerShadowWavesCD:Start()
	elseif spellId == 181296 or spellId == 181297 then
		if spellId == 181297 then
			specWarnEmpExplosiveRunes:Show(RUNES)
		else
			specWarnExplosiveRunes:Show(RUNES)
		end
		--timerExplosiveRunesCD:Start()
	elseif spellId == 181299 or spellId == 181300 then
		if spellId == 181300 then
			specWarnDraggingHands:Show()
		else
			specWarnGraspingHands:Show()
		end
		--timerGraspingHandsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180068 then
		warnLeap:Show()
		--timerLeapCD:Start()
	elseif spellId == 180115 then
		warnShadowEnergy:Show()
	elseif SpellId == 180116 then
		warnExplosiveEnergy:Show()
	elseif spellId == 180117 then
		warnFoulEnergy:Show()
	elseif spellId == 181305 then
		warnSwat:Show()
		--timerTankSpecialCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		--timerTankSpecialCD:Start()
		if args:IsPlayer() then

			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(40)
			end
		else
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(40, debuffFilter)
			end
			if close then
				
			else
				warnExplosiveBurst:Show(args.destName)
			end
		end
	elseif spellId == 180244 then
		specWarnPound:Show()
		voicePound:Play("aesoon")
		--timerPoundCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 173195 then
		
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
