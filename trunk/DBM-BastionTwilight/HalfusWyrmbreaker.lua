local mod	= DBM:NewMod("HalfusWyrmbreaker", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(44600)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warnBreath			= mod:NewSpellAnnounce(83707, 3)
local warnFuriousRoar		= mod:NewSpellAnnounce(83710, 3)
local warnVengeance			= mod:NewSpellAnnounce(87683, 3)
local warnShadowNova		= mod:NewSpellAnnounce(83703, 3)
local warnParalysis			= mod:NewSpellAnnounce(84030, 2)

local specWarnShadowNova	= mod:NewSpecialWarningInterrupt(83703, false)

local timerFuriousRoar		= mod:NewCDTimer(30, 83710)
local timerBreathCD			= mod:NewCDTimer(20, 83707)--every 20-25 seconds.
local timerParalysis		= mod:NewBuffActiveTimer(12, 84030)
local timerParalysisCD		= mod:NewCDTimer(35, 84030)

local berserkTimer			= mod:NewBerserkTimer(360)

mod:AddBoolOption("ShowDrakeHealth", true)

local spamFuriousRoar = 0

function mod:OnCombatStart(delay)
	spamFuriousRoar = 0
	berserkTimer:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerBreathCD:Start(10-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87683) then
		warnVengeance:Show()
	elseif args:IsSpellID(84030) then
		warnParalysis:Show()
		timerParalysis:Start()
		timerParalysisCD:Start()
	elseif args:IsSpellID(83601, 83603, 83611) and self.Options.ShowDrakeHealth then
		DBM.BossHealth:AddBoss(self:GetCIDFromGUID(args.sourceGUID), args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(87683) then
		warnVengeance:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(83710, 86169, 86170, 86171) and GetTime() - spamFuriousRoar > 6 then
		warnFuriousRoar:Show()
		timerFuriousRoar:Cancel()--We Cancel any scheduled roar timers before doing anything else.
		timerFuriousRoar:Start()--And start a fresh one.
		timerFuriousRoar:Schedule(30)--If it comes off CD while he's stunned by paralysis, he no longer waits to casts it after stun, it now consumes his CD as if it was cast on time. This is why we schedule this timer. So we get a timer for next roar after a stun.
		spamFuriousRoar = GetTime()
	elseif args:IsSpellID(83707) then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args:IsSpellID(83703, 86166, 86167, 86168) then
		warnShadowNova:Show()
		specWarnShadowNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(83612) then
		DBM.BossHealth:AddBoss(self:GetCIDFromGUID(args.sourceGUID), args.sourceName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if self.Options.ShowDrakeHealth and (cid == 44652 or cid == 44645 or cid == 44797 or cid == 44650) then
		DBM.BossHealth:RemoveBoss(cid)
	end
end