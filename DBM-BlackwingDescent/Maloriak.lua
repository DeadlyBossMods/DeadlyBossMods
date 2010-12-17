local mod	= DBM:NewMod("Maloriak", "DBM-BlackwingDescent", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41378)
mod:SetZone()
mod:SetUsedIcons(6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase				= mod:NewAnnounce("WarnPhase", 4)
local warnReleaseAdds		= mod:NewSpellAnnounce(77569, 3)
local warnRemainingAdds		= mod:NewAnnounce("WarnRemainingAdds", 2, 77569)
local warnFlashFreeze		= mod:NewTargetAnnounce(77699, 3)
local warnBitingChill		= mod:NewTargetAnnounce(77760, 3)
local warnRemedy			= mod:NewSpellAnnounce(77912, 4)
local warnArcaneStorm		= mod:NewSpellAnnounce(77896, 3)
local warnConsumingFlames	= mod:NewTargetAnnounce(77786, 3)
local warnScorchingBlast	= mod:NewSpellAnnounce(77679, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
 
local timerPhase			= mod:NewTimer(45, "TimerPhase")
local timerBitingChill		= mod:NewTargetTimer(10, 77760)
local timerFlashFreeze		= mod:NewCDTimer(25, 77699)
local timerArcaneStorm		= mod:NewBuffActiveTimer(6, 77896)
local timerConsumingFlames	= mod:NewTargetTimer(10, 77786)
local timerScorchingBlast	= mod:NewCDTimer(17, 77679)

local specWarnBitingChill	= mod:NewSpecialWarningYou(77760)
local specWarnConsumingFlames	= mod:NewSpecialWarningYou(77786)
local specWarnArcaneStorm	= mod:NewSpecialWarningInterupt(77896, false)
local specWarnRemedy		= mod:NewSpecialWarningDispel(77912, false)
local specWarnAdds			= mod:NewSpecialWarningSpell(77569, false)

local berserkTimer		= mod:NewBerserkTimer(360)

mod:AddBoolOption("FlashFreezeIcon")
mod:AddBoolOption("BitingChillIcon")
mod:AddBoolOption("ConsumingFlamesIcon")

local adds = 18
local AddsInterrupted = false

local function InterruptCheck()
	if not AddsInterrupted then
		adds = adds - 3
		warnRemainingAdds:Show(adds)
	end
	AddsInterrupted = false
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	adds = 18
	AddsInterrupted = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77699, 92978, 92979, 92980) then--Some spellids drycoded and not verified yet.
		warnFlashFreeze:Show(args.destName)
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(77760, 92975, 92976, 92977) then--Drycodes
		warnBitingChill:Show(args.destName)
		timerBitingChill:Start(args.destName)
		if self.Options.BitingChillIcon then
			self:SetIcon(args.destName, 7)
		end
		if args:IsPlayer() then
			specWarnBitingChill:Show()
		end
	elseif args:IsSpellID(77912, 92965, 92966, 92967) then--Drycodes
		warnRemedy:Show()
		specWarnRemedy:Show()
	elseif args:IsSpellID(77896) then
		warnArcaneStorm:Show()
		specWarnArcaneStorm:Show()
		timerArcaneStorm:Start()
	elseif args:IsSpellID(77786, 92971, 92972, 92973) then--Drycodes
		warnConsumingFlames:Show(args.destName)
		timerConsumingFlames:Start(args.destName)
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 6)
		end
		if args:IsPlayer() then
			specWarnConsumingFlames:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(77699, 92978, 92979, 92980) then--Some spellids drycoded and not verified yet.
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(77760, 92975, 92976, 92977) then--Drycodes
		if self.Options.BitingChillIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(77786, 92971, 92972, 92973) then--Drycodes
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77679, 92968, 92969, 92970) then
		warnScorchingBlast:Show()
		timerScorchingBlast:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(77569) then
		warnReleaseAdds:Show()
		specWarnAdds:Show()
		self:Schedule(1.95, InterruptCheck)--Schedule after 1.95 just to consider all posibilities such as a slow interupt and curse of tongues having been up.
	elseif args:IsSpellID(77991) then
		warnPhase2:Show()
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 77896) then
		timerArcaneStorm:Cancel()
	elseif type(args.extraSpellId) == "number" and (args.extraSpellId == 77569) then
		AddsInterrupted = true
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)--Method is terrible, breaks from curse of tongues. Need to use raidboss emote instead. but need a new log that contains them
	if msg == L.YellRed or msg:find(L.YellRed) then
		warnPhase:Show(L.Red)
		timerPhase:Start()
	elseif msg == L.YellBlue or msg:find(L.YellBlue) then
		warnPhase:Show(L.Blue)
		timerPhase:Start()
		timerFlashFreeze:Start()
	elseif msg == L.YellGreen or msg:find(L.YellGreen) then
		warnPhase:Show(L.Green)
		timerPhase:Start()
	elseif msg == L.YellDark or msg:find(L.YellDark) then
		warnPhase:Show(L.Dark)
		timerPhase:Start(100)		-- copied from BigWigs as I didnt have a timer yet
	end
end