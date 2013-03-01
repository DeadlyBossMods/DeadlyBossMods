if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(814, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 8441 $"):sub(12, -3))
mod:SetCreatureID(69099)
--mod:SetModelID(41448)
mod:SetZone(928)--Isle of Thunder

mod:RegisterCombat("combat")
mod:SetWipeTime(120)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnStormcloud				= mod:NewTargetAnnounce(136340, 3)
local warnLightningTether			= mod:NewTargetAnnounce(136339, 3)
local warnArcNova					= mod:NewCastAnnounce(136338, 3)

local specWarnStormcloudCast		= mod:NewSpecialWarningSpell(136340, nil, nil, nil, 2)--Needed?
local specWarnStormcloud			= mod:NewSpecialWarningYou(136340)
local specWarnLightningTether		= mod:NewSpecialWarningYou(136339)--Is this important enough?
local specWarnArcNova				= mod:NewSpecialWarningSpell(136338, nil, nil, nil, 2)--3 second cast enough time to run out? should this be a run warning for melee? (will have to guage his hitbox and how far you can stand back to start with)

local timerStormcloudCD				= mod:NewCDTimer(24, 136340)
local timerLightningTetherCD		= mod:NewNextTimer(40, 136339)
local timerArcNovaCD				= mod:NewNextTimer(42, 136338)

mod:AddBoolOption("RangeFrame")--For Stormcloud, might tweek to not show all the time with actual better logs than me facepulling it and dying with 20 seconds

local stormcloudTargets = {}
local tetherTargets = {}

local function warnStormcloudTargets()
	warnStormcloud:Show(table.concat(stormcloudTargets, "<, >"))
	table.wipe(stormcloudTargets)
end

local function warnTetherTargets()
	warnLightningTether:Show(table.concat(tetherTargets, "<, >"))
	table.wipe(tetherTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(stormcloudTargets)
	table.wipe(tetherTargets)
	timerStormcloudCD:Start(15-delay)--15-17 variation noted
	timerLightningTetherCD:Start(28-delay)
	timerArcNovaCD:Start(39-delay)--Not a large sample size
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(136340) then
		specWarnStormcloudCast:Show()
		timerStormcloudCD:Start()
	elseif args:IsSpellID(136338) then
		warnArcNova:Show()
		specWarnArcNova:Show()
		timerArcNovaCD:Start()
	elseif args:IsSpellID(136339) then
		timerLightningTetherCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136340) then
		stormcloudTargets[#stormcloudTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStormcloud:Show()
		end
		self:Unschedule(warnStormcloudTargets)
		self:Schedule(0.3, warnStormcloudTargets)
	elseif args:IsSpellID(136339) then
		tetherTargets[#tetherTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnLightningTether:Show()
		end
		self:Unschedule(warnTetherTargets)
		self:Schedule(0.3, warnTetherTargets)
	end
end
