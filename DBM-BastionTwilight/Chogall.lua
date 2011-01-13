local mod	= DBM:NewMod("Chogall", "DBM-BastionTwilight", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43324)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnWorship			= mod:NewTargetAnnounce(91317, 3)--Phase 1
local warnFury				= mod:NewSpellAnnounce(82524, 3, nil, mod:IsTank() or mod:IsHealer())--Phase 1
local warnAdherent			= mod:NewSpellAnnounce(81628, 4)--Phase 1
local warnFesterBlood		= mod:NewSpellAnnounce(82299, 3)--Phase 1
local warnShadowOrders		= mod:NewSpellAnnounce(81556, 3)
local warnFlameOrders		= mod:NewSpellAnnounce(81171, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnPhase2Soon		= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnCreations			= mod:NewSpellAnnounce(82414, 3)--Phase 2

local timerWorshipCD		= mod:NewCDTimer(36, 91317)--21-40 second variations depending on adds
local timerAdherent			= mod:NewCDTimer(92, 81628)
local timerFesterBlood		= mod:NewCDTimer(40, 82299)--40 seconds after an adherent is summoned
local timerFuryCD			= mod:NewCDTimer(47, 82524, nil, mod:IsTank() or mod:IsHealer())--47-48 unless a higher priority ability is channeling (such as summoning adds or MC)
local timerCreationsCD		= mod:NewNextTimer(30, 82414)

mod:AddBoolOption("SetIconOnWorship", true)
--mod:AddBoolOption("InfoFrame")

local worshipTargets = {}
local prewarned_Phase2 = false
local worshipIcon = 8
local worshipCooldown = 21

local HardCodedBloodFrame = false  	-- set to true for testing purposes ;)

local function showWorshipWarning()
	warnWorship:Show(table.concat(worshipTargets, "<, >"))
	table.wipe(worshipTargets)
	worshipIcon = 8
	timerWorshipCD:Start(worshipCooldown)
end

function mod:OnCombatStart(delay)
	timerWorshipCD:Start(10-delay)
	timerFuryCD:Start(55-delay)
	timerAdherent:Start(60-delay)
	table.wipe(worshipTargets)
	prewarned_Phase2 = false
	worshipIcon = 8
	worshipCooldown = 21
	--if self.Options.InfoFrame then
	if HardCodedBloodFrame then
		DBM.InfoFrame:SetHeader(L.Bloodlevel)
		DBM.InfoFrame:Show(10, "UNIT_POWER", 25, "ALTERNATE", ALTERNATE_POWER_INDEX)
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(91317, 93365, 93366, 93367) then
		worshipTargets[#worshipTargets + 1] = args.destName
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, worshipIcon)
			worshipIcon = worshipIcon - 1
		end
		self:Unschedule(showWorshipWarning)
		self:Schedule(0.3, showWorshipWarning)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(91317, 93365, 93366, 93367) then
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(81628) then
		warnAdherent:Show()
		timerAdherent:Start()
		timerFesterBlood:Start()
		worshipCooldown = 36
	elseif args:IsSpellID(82299) then
		warnFesterBlood:Show()
	elseif args:IsSpellID(82524) then
		warnFury:Show()
		timerFuryCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82414, 93160, 93161, 93162) then
		warnCreations:Show()
		timerCreationsCD:Start()
	elseif args:IsSpellID(82630) then
		warnPhase2:Show()
		timerAdherent:Cancel()
		timerWorshipCD:Cancel()
		timerFuryCD:Cancel()
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