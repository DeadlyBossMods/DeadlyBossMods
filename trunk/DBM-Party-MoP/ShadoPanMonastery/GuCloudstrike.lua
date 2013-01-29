local mod	= DBM:NewMod(673, "DBM-Party-MoP", 3, 312)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56747)--56747 (Gu Cloudstrike), 56754 (Azure Serpent)
mod:SetModelID(39489)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_DIED"
)


local warnInvokeLightning	= mod:NewSpellAnnounce(106984, 2, nil, false)
local warnStaticField		= mod:NewAnnounce("warnStaticField", 3, 106923)--Target scanning verified working
local warnChargingSoul		= mod:NewSpellAnnounce(110945, 3)--Phase 2
local warnLightningBreath	= mod:NewSpellAnnounce(102573, 3)
local warnMagneticShroud	= mod:NewSpellAnnounce(107140, 4)
local warnOverchargedSoul	= mod:NewSpellAnnounce(110852, 3)--Phase 3

local specWarnStaticField	= mod:NewSpecialWarningMove(106923)
local yellStaticField		= mod:NewYell(106923)
local specWarnMagneticShroud= mod:NewSpecialWarningSpell(107140)

local timerInvokeLightningCD= mod:NewNextTimer(6, 106984)--Phase 1 ability
local timerStaticFieldCD	= mod:NewNextTimer(8, 106923)--^^
local timerLightningBreathCD= mod:NewNextTimer(9.7, 102573)--Phase 2 ability
local timerMagneticShroudCD	= mod:NewCDTimer(12.5, 107140)--^^

local staticFieldText = GetSpellInfo(106923)
-- very poor code. not clean. (to replace %%s -> %s)
local targetFormatText
do
	local originalText = DBM_CORE_AUTO_ANNOUNCE_TEXTS.target
	local startIndex = string.find(originalText, "%%%%") 
	local tmp1 = string.sub(originalText, 1, startIndex)
	local tmp2 = string.sub(originalText, startIndex+2)
	targetFormatText = tmp1..tmp2
end

function mod:StaticFieldTarget()
	local targetname = self:GetBossTarget(56754)
	if not targetname then--No one is targeting/focusing the cloud serpent, so just use generic warning
		staticFieldText = GetSpellInfo(106923)
		warnStaticField:Show(staticFieldText)
	else--We have a valid target, so use target warnings.
		staticFieldText = targetFormatText:format(GetSpellInfo(106923), targetname)
		warnStaticField:Show(staticFieldText)
		if targetname == UnitName("player") then
			specWarnStaticField:Show()
			yellStaticField:Yell()
		end
	end
end

function mod:OnCombatStart(delay)
	timerInvokeLightningCD:Start(-delay)
	timerStaticFieldCD:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(110945) then
		warnChargingSoul:Show()
		warnInvokeLightning:Cancel()
		timerStaticFieldCD:Cancel()
		timerLightningBreathCD:Start()
		timerMagneticShroudCD:Start(20)
	elseif args:IsSpellID(110852) then
		warnOverchargedSoul:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(110945) then
		warnInvokeLightning:Cancel()
		timerStaticFieldCD:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106923) then
--		warnStaticField:Show()
		self:ScheduleMethod(0.1, "StaticFieldTarget")--Timing might not be right but target scanning will definitely work with correct timing.
		timerStaticFieldCD:Start()
	elseif args:IsSpellID(106984) then
		warnInvokeLightning:Show()
		timerInvokeLightningCD:Start()
	elseif args:IsSpellID(102573) then
		warnLightningBreath:Show()
		timerLightningBreathCD:Start()
	elseif args:IsSpellID(107140) then
		warnMagneticShroud:Show()
		specWarnMagneticShroud:Show()
		timerMagneticShroudCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56754 then
		timerMagneticShroudCD:Cancel()
		timerStaticFieldCD:Cancel()
		timerLightningBreathCD:Cancel()
	end
end
