local mod	= DBM:NewMod(2390, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(162329)
mod:SetEncounterID(2366)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320644 317231 320729",
	"SPELL_CAST_SUCCESS 320050 320114",
	"SPELL_AURA_APPLIED 320102"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
ability.id = 320644 and type = "begincast"
 or (ability.id = 320050 or ability.id = 320114 or ability.id = 331618) and type = "cast"
 or (ability.id = 317231 or ability.id = 320729 or ability.id = 339415) and type = "begincast"
--]]
local warnCrushingSlam				= mod:NewCountAnnounce(317231, 4)
local warnMassiveCleave				= mod:NewCountAnnounce(320729, 4)
local warnDeafeningCrash			= mod:NewCountAnnounce(339415, 4)
local warnBloodandGlory				= mod:NewTargetNoFilterAnnounce(320102, 2)

local specWarnBrutalCombo			= mod:NewSpecialWarningDefensive(320644, "Tank", nil, nil, 2, 2)
local specWarnMightofMaldraxxus		= mod:NewSpecialWarningDodge(320050, nil, nil, nil, 3, 2)
local specWarnDeafeningCrash		= mod:NewSpecialWarningCast(339415, false, nil, nil, 1, 2, 4)
local specWarnBloodandGlory			= mod:NewSpecialWarningYou(320102, nil, nil, nil, 1, 2)
local specWarnOppressiveBanner		= mod:NewSpecialWarningSwitch(331618, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerBrutalComboCD			= mod:NewCDCountTimer(15.8, 320644, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)--Sequenced timer
local timerMightofMaldraxxusCD		= mod:NewCDCountTimer(15.8, 320050, nil, nil, nil, 6, nil, DBM_CORE_L.DEADLY_ICON)
local timerBloodandGloryCD			= mod:NewCDCountTimer(70.5, 320102, nil, nil, nil, 3, nil, DBM_CORE_L.DAMAGE_ICON)
local timerOppressiveBannerCD		= mod:NewCDCountTimer(30.3, 331618, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)

mod.vb.MightCount = 0
mod.vb.MightCastCount = 0
mod.vb.brutalComboCount = 0
mod.vb.bloodCount = 0
mod.vb.bannerCount = 0

local allTimers = {
	--Combo
	[320644] = {6.0, 30.4, 15.8, 26.8, 30.4},
	--Might
	[320050] = {16.9, 40.1, 30.4, 35.2},
	--Blood
--	[320102] = {34.0, 70.5},
	--Banner
--	[331618] = {10.8, 30.3, 35.3, 30.4, 35.1},
}

function mod:OnCombatStart(delay)
	self.vb.MightCount = 0
	self.vb.MightCastCount = 0
	self.vb.brutalComboCount = 0
	self.vb.bloodCount = 0
	self.vb.bannerCount = 0
	timerBrutalComboCD:Start(5.8-delay, 1)
	timerOppressiveBannerCD:Start(10.7-delay, 1)
	timerMightofMaldraxxusCD:Start(17.1-delay, 1)
	timerBloodandGloryCD:Start(33.9-delay, 1)--SUCCESS
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320644 then
		self.vb.brutalComboCount = self.vb.brutalComboCount + 1
		specWarnBrutalCombo:Show()
		specWarnBrutalCombo:Play("defensive")
		local timer = allTimers[spellId][self.vb.brutalComboCount+1]
		if timer then
			timerBrutalComboCD:Start(timer, self.vb.brutalComboCount+1)
		end
	elseif spellId == 317231 then
		self.vb.MightCount = self.vb.MightCount + 1
		warnCrushingSlam:Show(self.vb.MightCount)
	elseif spellId == 320729 then
		self.vb.MightCount = self.vb.MightCount + 1
		warnMassiveCleave:Show(self.vb.MightCount)
	elseif spellId == 339415 then
		self.vb.MightCount = self.vb.MightCount + 1
		if self.Options.SpecWarn339415cast then
			specWarnDeafeningCrash:Show()
			specWarnDeafeningCrash:Play("stopcast")
		else
			warnDeafeningCrash:Show(self.vb.MightCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320050 then
		self.vb.MightCount = 0
		self.vb.MightCastCount = self.vb.MightCastCount + 1
		specWarnMightofMaldraxxus:Show()
		specWarnMightofMaldraxxus:Play("watchstep")
		local timer = allTimers[spellId][self.vb.MightCastCount+1]
		if timer then
			timerMightofMaldraxxusCD:Start(timer, self.vb.MightCastCount+1)
		end
	elseif spellId == 320114 and self:AntiSpam(5, 1) then
		self.vb.bloodCount = self.vb.bloodCount + 1
		timerBloodandGloryCD:Start(70.5, self.vb.bloodCount+1)
	elseif spellId == 331618 then
		self.vb.bannerCount = self.vb.bannerCount + 1
		specWarnOppressiveBanner:Show()
		specWarnOppressiveBanner:Play("attacktotem")--Technically banner, but better than "kill mob"
		if self.vb.bannerCount % 2 == 0 then
			timerOppressiveBannerCD:Start(35, self.vb.bannerCount+1)
		else
			timerOppressiveBannerCD:Start(30, self.vb.bannerCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320102 then
		warnBloodandGlory:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBloodandGlory:Show()
			specWarnBloodandGlory:Play("targetyou")
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
	if spellId == 325863 and self:AntiSpam(10, 1) then--Might of Maldraxxus

	end
end
--]]
