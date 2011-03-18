local mod	= DBM:NewMod("Maloriak", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41378)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_INTERRUPT",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPhase					= mod:NewAnnounce("WarnPhase", 2)
local warnReleaseAdds			= mod:NewSpellAnnounce(77569, 3)
local warnRemainingAdds			= mod:NewAnnounce("WarnRemainingAdds", 2, 77569)
local warnFlashFreeze			= mod:NewTargetAnnounce(77699, 4)
local warnBitingChill			= mod:NewTargetAnnounce(77760, 3)
local warnRemedy				= mod:NewSpellAnnounce(77912, 3)
local warnArcaneStorm			= mod:NewSpellAnnounce(77896, 4)
local warnConsumingFlames		= mod:NewTargetAnnounce(77786, 3)
local warnScorchingBlast		= mod:NewSpellAnnounce(77679, 4)
local warnDebilitatingSlime		= mod:NewSpellAnnounce(77615, 2)
local warnMagmaJets				= mod:NewSpellAnnounce(78194, 4, nil, mod:IsTank())--4.0.6+ now supporting this warning.
local warnEngulfingDarkness		= mod:NewSpellAnnounce(92754, 4, nil, mod:IsHealer() or mod:IsTank())--Heroic Ability
local warnPhase2				= mod:NewPhaseAnnounce(2)
 
local timerPhase				= mod:NewTimer(49, "TimerPhase", 89250)--Just some random cauldron icon not actual spellid
local timerBitingChill			= mod:NewBuffActiveTimer(10, 77760)
local timerFlashFreeze			= mod:NewCDTimer(14, 77699)--Varies on other abilities CDs
local timerAddsCD				= mod:NewCDTimer(15, 77569, nil, not mod:IsHealer())--Varies on other abilities CDs
local timerArcaneStormCD		= mod:NewCDTimer(14, 77896)--Varies on other abilities CDs
local timerConsumingFlames		= mod:NewTargetTimer(10, 77786, nil, mod:IsHealer())
local timerScorchingBlast		= mod:NewCDTimer(10, 77679)--Varies on other abilities CDs
local timerDebilitatingSlime	= mod:NewBuffActiveTimer(15, 77615)
local timerMagmaJetsCD			= mod:NewNextTimer(10, 78194)
local timerEngulfingDarknessCD	= mod:NewNextTimer(12, 92754, nil, mod:IsHealer() or mod:IsTank())--Heroic Ability

local specWarnBitingChill		= mod:NewSpecialWarningYou(77760)
local specWarnConsumingFlames	= mod:NewSpecialWarningYou(77786)
local specWarnSludge			= mod:NewSpecialWarningMove(92987)
local specWarnArcaneStorm		= mod:NewSpecialWarningInterrupt(77896)
local specWarnMagmaJets			= mod:NewSpecialWarningMove(78194, mod:IsTank())
local specWarnEngulfingDarkness	= mod:NewSpecialWarningSpell(92754, mod:IsTank())--Heroic Ability
local specWarnFlashFreeze		= mod:NewSpecialWarningTarget(77699, mod:IsRanged())--On Heroic it has a lot more health.
local specWarnRemedy			= mod:NewSpecialWarningDispel(77912, false)
local specWarnAdds				= mod:NewSpecialWarningSpell(77569, false)

local berserkTimer				= mod:NewBerserkTimer(420)

mod:AddBoolOption("FlashFreezeIcon")
mod:AddBoolOption("BitingChillIcon", false)
mod:AddBoolOption("ConsumingFlamesIcon", false)
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetTextures", false)--Blizz sucks and just about ALL friendly spells cover dark sludge and make you unable to see it.

local adds = 18
local AddsInterrupted = false
local spamSlime = 0
local spamSludge = 0
local bitingChillTargets = {}
local flashFreezeTargets = {}
local bitingChillIcon = 6
local flashFreezeIcon = 8

local function showBitingChillWarning()
	warnBitingChill:Show(table.concat(bitingChillTargets, "<, >"))
	table.wipe(bitingChillTargets)
	bitingChillIcon = 6
	timerBitingChill:Start()
end

local function showFlashFreezeWarning()
	warnFlashFreeze:Show(table.concat(flashFreezeTargets, "<, >"))
	table.wipe(flashFreezeTargets)
	flashFreezeIcon = 8
	timerFlashFreeze:Start()
end

local function InterruptCheck()
	if not AddsInterrupted then
		adds = adds - 3
		warnRemainingAdds:Show(adds)
	end
	AddsInterrupted = false
end

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
		berserkTimer:Start(-delay)--7 min berserk on normal
	else
		berserkTimer:Start(720-delay)--12 min on heroic
	end
	adds = 18
	AddsInterrupted = false
	spamSlime = 0
	spamSludge = 0
	bitingChillIcon = 6
	flashFreezeIcon = 8
	timerArcaneStormCD:Start(10-delay)--10-15 seconds from pull
	timerAddsCD:Start()--This may or may not happen depending on arcane storms duration and when it was cast.
	timerPhase:Start(18.5-delay)
	table.wipe(bitingChillTargets)
	table.wipe(flashFreezeTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.SetTextures and not GetCVarBool("projectedTextures") then
		SetCVar("projectedTextures", 1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77699, 92978, 92979, 92980) then
		flashFreezeTargets[#flashFreezeTargets + 1] = args.destName
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			specWarnFlashFreeze:Show(args.destName)
		end
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, flashFreezeIcon)
			flashFreezeIcon = flashFreezeIcon - 1
		end
		self:Unschedule(showFlashFreezeWarning)
		self:Schedule(0.3, showFlashFreezeWarning)
	elseif args:IsSpellID(77760, 92975, 92976, 92977) then
		bitingChillTargets[#bitingChillTargets + 1] = args.destName
		if self.Options.BitingChillIcon then
			self:SetIcon(args.destName, bitingChillIcon)
			bitingChillIcon = bitingChillIcon - 1
		end
		if args:IsPlayer() then
			specWarnBitingChill:Show()
		end
		self:Unschedule(showBitingChillWarning)
		self:Schedule(0.3, showBitingChillWarning)
	elseif args:IsSpellID(77912, 92965, 92966, 92967) and not args:IsDestTypePlayer() then
		warnRemedy:Show()
		specWarnRemedy:Show(args.destName)
	elseif args:IsSpellID(77896) then
		warnArcaneStorm:Show()
		timerArcaneStormCD:Start()
		if self:GetUnitCreatureId("target") == 41378 or self:GetUnitCreatureId("focus") == 41378 then
			specWarnArcaneStorm:Show()
		end
	elseif args:IsSpellID(77786, 92971, 92972, 92973) then
		warnConsumingFlames:Show(args.destName)
		timerConsumingFlames:Start(args.destName)
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 7)
		end
		if args:IsPlayer() then
			specWarnConsumingFlames:Show()
		end
	elseif args:IsSpellID(77615) and GetTime() - spamSlime >= 4 then
		spamSlime = GetTime()
		warnDebilitatingSlime:Show()
		timerDebilitatingSlime:Start()
	elseif args:IsSpellID(92930, 92986, 92987, 92988) and GetTime() - spamSludge >= 2 and args:IsPlayer() then
		spamSludge = GetTime()
		specWarnSludge:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(77699, 92978, 92979, 92980) then
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(77760, 92975, 92976, 92977) then
		if self.Options.BitingChillIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(77786, 92971, 92972, 92973) then
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(77569) then
		warnReleaseAdds:Show()
		specWarnAdds:Show()
		timerAddsCD:Start()
		if adds >= 3 then--only schedule it if there actually are adds left.
			self:Schedule(2.6, InterruptCheck)--Schedule after 2.6 just to consider all posibilities such as a slow interrupt and curse of tongues having been up.
		end
	elseif args:IsSpellID(77991) then
		warnPhase2:Show()
		timerMagmaJetsCD:Start()
		timerFlashFreeze:Cancel()
		timerScorchingBlast:Cancel()
		timerAddsCD:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") then
			SetCVar("projectedTextures", 1)
		end
	elseif args:IsSpellID(92754) then
		warnEngulfingDarkness:Show()
		timerEngulfingDarknessCD:Start()
		if self:GetUnitCreatureId("target") == 41378 then--Add tank doesn't need this spam, just tank on mal.
			specWarnEngulfingDarkness:Show()
		end
	elseif args:IsSpellID(78194) then
		warnMagmaJets:Show()
		if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
			timerMagmaJetsCD:Start()--10 second on normal.
		else
			timerMagmaJetsCD:Start(5)--5 second cd on heroic
		end
		if self:GetUnitCreatureId("target") == 41378 then--Add tank doesn't need this spam, just tank on mal.
			specWarnMagmaJets:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77679, 92968, 92969, 92970) then
		warnScorchingBlast:Show()
		timerScorchingBlast:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 77569) then
		AddsInterrupted = true
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.YellRed or msg:find(L.YellRed) then
		warnPhase:Show(L.Red)
		timerAddsCD:Start()
		timerArcaneStormCD:Start(19)
		timerScorchingBlast:Start(22)
		timerPhase:Start()
		timerFlashFreeze:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") then
			SetCVar("projectedTextures", 1)
		end
	elseif msg == L.YellBlue or msg:find(L.YellBlue) then
		warnPhase:Show(L.Blue)
		timerPhase:Start()
		timerAddsCD:Start()
		timerArcaneStormCD:Start(19)
		timerFlashFreeze:Start(22)
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") then
			SetCVar("projectedTextures", 1)
		end
	elseif msg == L.YellGreen or msg:find(L.YellGreen) then
		warnPhase:Show(L.Green)
		timerPhase:Start()
		timerAddsCD:Start()
		timerArcaneStormCD:Start(12)--First one is always shorter in green phase then other 2.
		timerFlashFreeze:Cancel()
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == L.YellDark or msg:find(L.YellDark) then
		warnPhase:Show(L.Dark)
		timerEngulfingDarknessCD:Start(16.5)
		timerPhase:Start(100)
		timerArcaneStormCD:Cancel()
		timerAddsCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetTextures and GetCVarBool("projectedTextures") then
			SetCVar("projectedTextures", 0)
		end
	end
end