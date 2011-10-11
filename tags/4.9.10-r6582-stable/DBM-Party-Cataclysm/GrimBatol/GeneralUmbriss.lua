local mod	= DBM:NewMod("GeneralUmbriss", "DBM-Party-Cataclysm", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39625)
mod:SetModelID(31498)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBleedingWound		= mod:NewTargetAnnounce(74846, 4, nil, mod:IsHealer() or mod:IsTank())
local warnMalady			= mod:NewTargetAnnounce(90179, 2)
local warnMalice			= mod:NewSpellAnnounce(90170, 4)
local warnFrenzySoon		= mod:NewSoonAnnounce(74853, 2, nil, mod:IsHealer() or mod:IsTank())
local warnFrenzy			= mod:NewSpellAnnounce(74853, 3, nil, mod:IsHealer() or mod:IsTank())
local warnBlitz				= mod:NewTargetAnnounce(74670, 4)

local specWarnMalice		= mod:NewSpecialWarningSpell(90170, mod:IsTank())
local specWarnBlitz			= mod:NewSpecialWarningYou(74670)

local timerBleedingWound	= mod:NewTargetTimer(15, 74846, nil, mod:IsHealer() or mod:IsTank())
local timerBleedingWoundCD	= mod:NewCDTimer(25, 74846, nil, mod:IsHealer() or mod:IsTank())
local timerGroundSiege		= mod:NewCastTimer(2, 74634, nil, mod:IsHealer() or mod:IsMelee())
local timerBlitz			= mod:NewCDTimer(23, 74670)
local timerMalady			= mod:NewBuffActiveTimer(10, 90179)
local timerMalice			= mod:NewBuffActiveTimer(20, 90170)

mod:AddBoolOption("PingBlitz")

local warnedFrenzy
local maladyTargets = {}
local maladyCount = 0

local function showMaladyWarning()
	warnMalady:Show(table.concat(maladyTargets, "<, >"))
	table.wipe(maladyTargets)
	timerMalady:Start()
end

function mod:OnCombatStart(delay)
	warnedFrenzy = false
	table.wipe(maladyTargets)
	maladyCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74846, 91937) then
		warnBleedingWound:Show(args.destName)
		timerBleedingWound:Start(args.destName)
		timerBleedingWoundCD:Start()
	elseif args:IsSpellID(74853) then
		warnFrenzy:Show()
	elseif args:IsSpellID(74837, 90179) then
		maladyCount = maladyCount + 1
		maladyTargets[#maladyTargets + 1] = args.destName
		self:Unschedule(showMaladyWarning)
		self:Schedule(0.3, showMaladyWarning)
	elseif args:IsSpellID(90170) then
		warnMalice:Show()
		specWarnMalice:Show()
		timerMalice:Start()
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(74846, 91937) then
		timerBleedingWound:Cancel(args.destName)
	elseif args:IsSpellID(74837, 90179) then
		maladyCount = maladyCount - 1
		if maladyCount == 0 then
			timerMalady:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74634, 90249) then
		timerGroundSiege:Start()
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.Blitz) then
		timerBlitz:Start()
		if target then
			warnBlitz:Show(target)
			if target == UnitName("player") then
				specWarnBlitz:Show()
				if self.Options.PingBlitz then
					Minimap:PingLocation()
				end
			end
		end
	end
end