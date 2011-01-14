local mod	= DBM:NewMod("Maloriak", "DBM-BlackwingDescent", 3)
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

local warnPhase					= mod:NewAnnounce("WarnPhase", 4)
local warnReleaseAdds			= mod:NewSpellAnnounce(77569, 3)
local warnRemainingAdds			= mod:NewAnnounce("WarnRemainingAdds", 2, 77569)
local warnFlashFreeze			= mod:NewTargetAnnounce(77699, 3)
local warnBitingChill			= mod:NewTargetAnnounce(77760, 3)
local warnRemedy				= mod:NewSpellAnnounce(77912, 4)
local warnArcaneStorm			= mod:NewSpellAnnounce(77896, 3)
local warnConsumingFlames		= mod:NewTargetAnnounce(77786, 3)
local warnScorchingBlast		= mod:NewSpellAnnounce(77679, 3)
local warnDebilitatingSlime		= mod:NewSpellAnnounce(77615, 2)
local warnEngulfingDarkness		= mod:NewCastAnnounce(92754, 3)--Heroic Ability
local warnPhase2				= mod:NewPhaseAnnounce(2)
 
local timerPhase				= mod:NewTimer(50, "TimerPhase")
local timerBitingChill			= mod:NewBuffActiveTimer(10, 77760)
local timerFlashFreeze			= mod:NewNextTimer(15, 77699)--Seems consisting so using "next" for now.
local timerArcaneStorm			= mod:NewBuffActiveTimer(6, 77896)
local timerConsumingFlames		= mod:NewTargetTimer(10, 77786)
local timerScorchingBlast		= mod:NewCDTimer(10, 77679)--Varies heavily
local timerDebilitatingSlime	= mod:NewBuffActiveTimer(15, 77615)
local timerEngulfingDarknessCD	= mod:NewNextTimer(12, 92754)--Heroic Ability

local specWarnBitingChill		= mod:NewSpecialWarningYou(77760)
local specWarnConsumingFlames	= mod:NewSpecialWarningYou(77786)
local specWarnSludge			= mod:NewSpecialWarningMove(92987)
local specWarnArcaneStorm		= mod:NewSpecialWarningInterrupt(77896)
local specWarnEngulfingDarkness	= mod:NewSpecialWarningSpell(92754, mod:IsTank())--Heroic Ability
local specWarnRemedy			= mod:NewSpecialWarningDispel(77912, false)
local specWarnAdds				= mod:NewSpecialWarningSpell(77569, false)

local berserkTimer				= mod:NewBerserkTimer(360)

mod:AddBoolOption("FlashFreezeIcon")
mod:AddBoolOption("BitingChillIcon")
mod:AddBoolOption("ConsumingFlamesIcon")
mod:AddBoolOption("RangeFrame")

local adds = 18
local AddsInterrupted = false
local spamSlime = 0
local spamSludge = 0
local bitingChillTargets = {}
local bitingChillIcon = 6

local function showBitingChillWarning()
	warnBitingChill:Show(table.concat(bitingChillTargets, "<, >"))
	table.wipe(bitingChillTargets)
	bitingChillIcon = 6
	timerBitingChill:Start()
end

local function InterruptCheck()
	if not AddsInterrupted then
		adds = adds - 3
		warnRemainingAdds:Show(adds)
	end
	AddsInterrupted = false
end

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("normal10") then
		berserkTimer:Start(-delay)--he only berserks on 10 man normal, and only part of the time. apparently doesn't berserk on heroic or 25s. wtf?
	end
	adds = 18
	AddsInterrupted = false
	spamSlime = 0
	spamSludge = 0
	timerPhase:Start(15-delay)
	table.wipe(bitingChillTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77699, 92978, 92979, 92980) then
		warnFlashFreeze:Show(args.destName)
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, 8)
		end
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
	elseif args:IsSpellID(77912, 92965, 92966, 92967) then
		warnRemedy:Show()
		specWarnRemedy:Show(args.destName)
	elseif args:IsSpellID(77896) then
		warnArcaneStorm:Show()
		timerArcaneStorm:Start()
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
	elseif args:IsSpellID(92987, 92988) and GetTime() - spamSludge >= 4 then
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
		if adds >= 3 then--only schedule it if there actually are adds left.
			self:Schedule(1.95, InterruptCheck)--Schedule after 1.95 just to consider all posibilities such as a slow interrupt and curse of tongues having been up.
		end
	elseif args:IsSpellID(77991) then
		warnPhase2:Show()
	elseif args:IsSpellID(92754) then
		warnEngulfingDarkness:Show()
		timerEngulfingDarknessCD:Start()
		if self:GetUnitCreatureId("target") == 41378 then--Add tank doesn't need this spam, just tank on mal.
			specWarnEngulfingDarkness:Show()
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
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 77896) then
		timerArcaneStorm:Cancel()
	elseif type(args.extraSpellId) == "number" and (args.extraSpellId == 77569) then
		AddsInterrupted = true
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.YellRed or msg:find(L.YellRed) then
		warnPhase:Show(L.Red)
		timerScorchingBlast:Start(25)
		timerPhase:Start()
		timerFlashFreeze:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == L.YellBlue or msg:find(L.YellBlue) then
		warnPhase:Show(L.Blue)
		timerPhase:Start()
		timerFlashFreeze:Start(25)
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif msg == L.YellGreen or msg:find(L.YellGreen) then
		warnPhase:Show(L.Green)
		timerPhase:Start()
		timerFlashFreeze:Cancel()
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == L.YellDark or msg:find(L.YellDark) then--Need dark value for raidboss emote
		warnPhase:Show(L.Dark)
		timerEngulfingDarknessCD:Start(15)
		timerPhase:Start(100)		-- copied from BigWigs as I didnt have a timer yet for emotes instead of yells.
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end