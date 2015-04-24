local mod	= DBM:NewMod(1392, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90435)
mod:SetEncounterID(1787)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 181292 181293 181296 181297 181299 181300 180244",
	"SPELL_CAST_SUCCESS 180068 181305 181307",
	"SPELL_AURA_APPLIED 181306 186882 180115 180116 180117",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 181306 180244",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fix leap ID, i'm suspect of it being instant cast, maybe it is though.
--TODO, verify energy IDs, all of them had 2 Potential canidates.
--TODO, target announce, maybe mark players in grasping hands.
--TODO, figure out more tank stuffs and where to plug in "taunt" warnings.
--TODO, other countdowns, other voices, once ability importance is assessed.
local warnLeap						= mod:NewSpellAnnounce(180068, 3)
local warnShadowEnergy				= mod:NewSpellAnnounce(180115, 2)
local warnExplosiveEnergy			= mod:NewSpellAnnounce(180116, 3)--This one looks more dangerous than other 2, because it enables the Explosive Runes ability
local warnFoulEnergy				= mod:NewSpellAnnounce(180117, 2)
--These are probably temp, changed to better tank special warnings when better understood
local warnSwat						= mod:NewSpellAnnounce(181305, 3, nil, "Tank|Healer")
local warnExplosiveBurst			= mod:NewTargetAnnounce(181306, 4)--Concerns everyone
local warnEnrage					= mod:NewSpellAnnounce(186882, 3)

local specWarnPound					= mod:NewSpecialWarningSpell(180244, nil, nil, nil, 2, nil, 2)
local specWarnExplosiveBurst		= mod:NewSpecialWarningYou(181306)
local specWarnExplosiveBurstNear	= mod:NewSpecialWarningClose(181306, nil, nil, nil, 3, nil, 2)
local specWarnFoulCrush				= mod:NewSpecialWarningSwitch(181307, "Dps|Tank")--Tweak it as needed once can figure out how to detect what tank it's on
local yellExplosiveBurst			= mod:NewYell(181306)
local specWarnEmpShadowWaves		= mod:NewSpecialWarningDodge(181293, nil, nil, nil, 2, nil, 2)
local specWarnShadowWaves			= mod:NewSpecialWarningDodge(181292, nil, nil, nil, 2, nil, 2)
local specWarnExplosiveRunes		= mod:NewSpecialWarningMoveTo(181296, "-Tank")--Might need tweaking once more visible strategy and quantity of runes observed.
local specWarnGraspingHands			= mod:NewSpecialWarningSwitch(181299)--Do tanks need to help? is it bad for tanks to help?
--Empowered versions (made separate so users can set different sounds for the more dangerous versions if they choose)
local specWarnEmpShadowWaves		= mod:NewSpecialWarningDodge(181293, nil, nil, nil, 2, nil, 2)
local specWarnEmpExplosiveRunes		= mod:NewSpecialWarningMoveTo(181297, "-Tank")
local specWarnDraggingHands			= mod:NewSpecialWarningSwitch(181300)

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
local voiceExplosiveBurst			= mod:NewVoice(181306)--justrun

mod:AddRangeFrameOption("4/40")

mod.vb.explodingTank = nil
mod.vb.poundActive = false
local debuffName = GetSpellInfo(181306)
local UnitDebuff = UnitDebuff

local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

local function updateRangeCheck(self)
	if not self.Options.RangeFrame then return end
	if self.vb.explodingTank then
		if UnitDebuff("player", debuffName) then
			DBM.RangeCheck:Show(40)
		elseif not self:CheckNearby(41, self.vb.explodingTank) and self.vb.poundActive then--far enough from tank and pound is active, switch back to 4
			DBM.RangeCheck:Show(4)
		else--No pound, tank still active, keep filtered radar up to prevent walking back into tank
			DBM.RangeCheck:Show(40, debuffFilter)
		end
	elseif self.vb.poundActive then--Just pound, no tank debuff.
		DBM.RangeCheck:Show(4)
	else
		DBM.RangeCheck:Hide()
	end
end

local function trippleBurstCheck(self, target, first)
	if self:CheckNearby(41, target) then--Second and third check will use smaller range
		specWarnExplosiveBurstNear:Show(target)
		voiceExplosiveBurst:Play("justrun")
	end
	if first then
		self:Schedule(2.5, trippleBurstCheck, self, target)
	end
	updateRangeCheck(self)
end

function mod:OnCombatStart(delay)
	self.vb.explodingTank = nil
	self.vb.poundActive = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
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
	elseif spellId == 180244 then
		self.vb.poundActive = true
		specWarnPound:Show()
		voicePound:Play("aesoon")
		--timerPoundCD:Start()
		updateRangeCheck(self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180068 then
		warnLeap:Show()
		--timerLeapCD:Start()
	elseif spellId == 181305 then
		warnSwat:Show()
		--timerTankSpecialCD:Start()
	elseif spellId == 181307 then
		specWarnFoulCrush:Show()
		--timerTankSpecialCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		self.vb.explodingTank = args.destName
		--timerTankSpecialCD:Start()
		countdownExplosiveBurst:Start()
		if args:IsPlayer() then
			specWarnExplosiveBurst:Show()
			yellExplosiveBurst:Yell()
		else
			if self:CheckNearby(41, args.destName) then
				specWarnExplosiveBurstNear:Show(args.destName)
				voiceExplosiveBurst:Play("justrun")
			else
				warnExplosiveBurst:Show(args.destName)
			end
			--Check player distance 3x, like mark of chaos, don't let players run INTO it after they are safe
			self:Schedule(3, trippleBurstCheck, self, args.destName, true)
		end
		updateRangeCheck(self)
	elseif spellId == 180115 then
		warnShadowEnergy:Show()
	elseif spellId == 180116 then
		warnExplosiveEnergy:Show()
	elseif spellId == 180117 then
		warnFoulEnergy:Show()
	elseif spellId == 186882 then
		warnEnrage:Show()
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181306 then
		self.vb.explodingTank = nil
		self:Unschedule(trippleBurstCheck)
		countdownExplosiveBurst:Cancel()
		updateRangeCheck(self)
	elseif spellId == 180244 then
		self.vb.poundActive = false
		updateRangeCheck(self)
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
