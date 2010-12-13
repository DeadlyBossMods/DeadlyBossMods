local mod	= DBM:NewMod("Chogall", "DBM-BastionTwilight", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43324)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnWorship		= mod:NewTargetAnnounce(91317, 3)
local warnAdherent		= mod:NewSpellAnnounce(81628, 4)
local warnFesterBlood		= mod:NewSpellAnnounce(82299, 3)
local warnCreations		= mod:NewSpellAnnounce(82414, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnShadowOrders		= mod:NewSpellAnnounce(81556, 3)
local warnFlameOrders		= mod:NewSpellAnnounce(81171, 3)

local timerAdherent		= mod:NewCDTimer(90, 81628)
local timerFesterBlood		= mod:NewCDTimer(90, 82299)

local worshipTargets = {}
local prewarned_Phase2 = false

local showWorshipWarning = function()
	warnWorship:Show(table.concat(worshipTargets, "<, >"))
	table.wipe(worshipTargets)
end

function mod:OnCombatStart(delay)
	timerAdherent:Start(70-delay)
	timerFesterBlood:Start(110-delay)
	table.wipe(worshipTargets)
	prewarned_Phase2 = false
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(91317, 93365, 93366, 93367) then
		worshipTargets[#worshipTargets] = args.destName
		self:Unschedule(showWorshipWarning)
		self:Schedule(0.3, showWorshipWarning())
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(81628) then
		warnAdherent:Show()
		timerAdherent:Start()
	elseif args:IsSpellID(82299) then
		warnFesterBlood:Show()
		timerFesterBlood:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82414, 93160, 93161, 93162) then
		warnCreations:Show()
	elseif args:IsSpellID(82630) then
		warnPhase2:Show()
	elseif args:IsSpellID(81556) then--87575?
		warnShadowOrders:Show()
	elseif args:IsSpellID(81171) then--87579?
		warnFlameOrders:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarned_Phase2 then
			prewarned_Phase2 = false
		elseif not prewarned_Phase2 and (h > 27 and h < 30) then
			warnPhase2Soon:Show()
			prewarned_Phase2 = true
		end
	end
end