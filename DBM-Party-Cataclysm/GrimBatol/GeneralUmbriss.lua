local mod	= DBM:NewMod("GeneralUmbriss", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39625)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnBleedingWound		= mod:NewTargetAnnounce(74846, 4)
local warnGroundSiege		= mod:NewSpellAnnounce(74634, 3)
local warnBlitz			= mod:NewSpellAnnounce(74670, 2)
local warnMalady		= mod:NewTargetAnnounce(90179, 2)
local warnMalice		= mod:NewSpellAnnounce(90170, 3)
local warnFrenzySoon		= mod:NewSoonAnnounce(74846, 2)
local warnFrenzy		= mod:NewSpellAnnounce(74846, 3)

local timerBleedingWound	= mod:NewTargetTimer(15, 74846)
local timerBleedingWoundCD	= mod:NewCDTimer(25, 74846)
local timerGroundSiege		= mod:NewCastTimer(2, 74634)
local timerBlitz		= mod:NewCDTimer(25, 74670)
local timerMalady		= mod:NewTargetTimer(10, 90179)
local timerMalice		= mod:NewBuffActiveTimer(20, 90170)

local warnedFrenzy
function mod:OnCombatStart(delay)
	warnedFrenzy = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74846, 91937) then
		warnBleedingWound:Show(args.destName)
		timerBleedingWound:Start(args.destName)
		timerBleedingWoundCD:Start()
	elseif args:IsSpellID(74853) then
		warnFrenzy:Show()
	elseif args:IsSpellID(74837, 90179) then
		warnMalady:Show(args.destName)
		timerMalady:Start(args.destName)
	elseif args:IsSpellID(90170) then
		warnMalice:Show()
		timerMalice:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(74837, 90179) then
		timerMalady:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(74846, 91937) then
		timerBleedingWound:Cancel(args.destName)
	elseif args:IsSpellID(74837, 90179) then
		timerMalady:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74634, 90249) then
		warnGroundSiege:Show()
		timerGroundSiege:Start()
	elseif args:IsSpellID(74670, 90250) then
		warnBlitz:Show()
		timerBlitz:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if warnedFrenzy and h > 50 then
			warnedFrenzy = false
		elseif h > 33 and h < 38 and not warnedFrenzy then
			warnFrenzySoon:Show()
			warnedFrenzy = true
		end
	end
end