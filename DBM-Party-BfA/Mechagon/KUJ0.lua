local mod	= DBM:NewMod(2339, "DBM-Party-BfA", 11, 1178)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(144246)
mod:SetEncounterID(2258)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 291946 291973",
	"SPELL_CAST_SUCCESS 291918 294929",
	"SPELL_AURA_APPLIED 291972 294929",
	"SPELL_AURA_APPLIED_DOSE 294929",
	"SPELL_AURA_REMOVED 291946"
)

--[[
(ability.id = 291946 or ability.id = 291973) and type = "begincast"
 or (ability.id = 291918 or ability.id = 294929) and type = "cast"
--]]
--TODO, can't see a way to detect Robo waste drops, schedule a timer loop?
local warnAirDrop					= mod:NewCountAnnounce(291930, 2)
local warnExplosiveLeap				= mod:NewTargetNoFilterAnnounce(291972, 3)
local warnBlazingChomp				= mod:NewStackAnnounce(294929, 2, nil, "Tank|Healer")

local specWarnExplosiveLeap			= mod:NewSpecialWarningMoveAway(291972, nil, nil, nil, 1, 2)
local yellExplosiveLeap				= mod:NewYell(291972)
local specWarnVentingFlames			= mod:NewSpecialWarningMoveTo(291946, nil, nil, nil, 3, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

local timerAurDropCD				= mod:NewNextTimer(34, 291930, nil, nil, nil, 3)
local timerExplosiveLeapCD			= mod:NewCDTimer(33.4, 291972, nil, nil, nil, 3)
local timerVentingFlamesCD			= mod:NewCDTimer(13.4, 291946, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerBlazingChompCD			= mod:NewCDTimer(15.8, 294929, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)

mod:AddRangeFrameOption(10, 291972)
mod:AddInfoFrameOption(291937, true)

mod.vb.airDropCount = 0

function mod:OnCombatStart(delay)
	self.vb.airDropCount = 0
	timerAurDropCD:Start(7.2-delay)--SUCCESS
	timerBlazingChompCD:Start(10.7-delay)--SUCCESS
	timerVentingFlamesCD:Start(15.5-delay)--START
	timerExplosiveLeapCD:Start(38.6-delay)--START
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 291946 then
		specWarnVentingFlames:Show(DBM_CORE_BREAK_LOS)
		specWarnVentingFlames:Play("findshelter")
		--15.5, 33.9, 34.0, 34.0"
		timerVentingFlamesCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_CORE_NOTSAFE)
			DBM.InfoFrame:Show(5, "playergooddebuff", 291937)
		end
	elseif spellId == 291973 then
		--38.6, 33.9, 34.0, 33.4
		timerExplosiveLeapCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10, nil, nil, nil, nil, 15)--Auto hide after about 15 seconds (12 plus cast)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 291918 then
		self.vb.airDropCount = self.vb.airDropCount + 1
		warnAirDrop:Show(self.vb.airDropCount)
		--7.2, 26.3, 34.0, 34.0, 34.0
		timerAurDropCD:Start(self.vb.airDropCount == 1 and 26.3 or 34)
	elseif spellId == 294929 then
		--10.7, 18.2, 18.2, 17.0, 17.0, 15.8
		timerBlazingChompCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 291972 then
		warnExplosiveLeap:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnExplosiveLeap:Show()
			specWarnExplosiveLeap:Play("runout")
			yellExplosiveLeap:Yell()
		end
	elseif spellId == 294929 then
		local amount = args.amount or 1
		warnBlazingChomp:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 291946 and self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
