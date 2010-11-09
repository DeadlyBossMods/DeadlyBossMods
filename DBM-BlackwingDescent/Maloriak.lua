local mod	= DBM:NewMod("Maloriak", "DBM-BlackwingDescent", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41378)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase			= mod:NewAnnounce("WarnPhase", 4)
local warnReleaseAdds		= mod:NewSpellAnnounce(77569, 3)
local warnRemainingAdds		= mod:NewAnnounce("WarnRemainingAdds", 2, nil, false)
local warnFlashFreeze		= mod:NewTargetAnnounce(77699, 3)
local warnBitingChill		= mod:NewTargetAnnounce(77760, 3)
local warnRemedy		= mod:NewSpellAnnounce(77912, 4)
local warnPhase2		= mod:NewPhaseAnnounce(2)
 
local timerPhase		= mod:NewTimer(45, "TimerPhase")
local timerBitingChill		= mod:NewTargetTimer(10, 77760)
local timerFlashFreeze		= mod:NewCDTimer(25, 77699)

local specWarnBitingChill	= mod:NewSpecialWarningYou(77760)

local berserkTimer		= mod:NewBerserkTimer(360)
local adds = 18

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	adds = 18
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(77699, 92979) then
		warnFlashFreeze:Show(args.destName)
		self:SetIcon(args.destName, 8)
	elseif args:IsSpellID(77760) then
		warnBitingChill:Show(args.destName)
		self:SetIcon(args.destName, 7)
		if args:IsPlayer() then
			specWarnBitingChill:Show()
		end
	elseif args:IsSpellID(77912, 92966) and args.destName == L.name then
		warnRemedy:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(77569) then
		adds = adds - 3
		warnReleaseAdds:Show()
		warnRemainingAdds:Show(adds)
	elseif args:IsSpellID(77991) then
		warnPhase2:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellRed then
		warnPhase:Show(L.Red)
		timerPhase:Start()
	elseif msg == L.YellBlue then
		warnPhase:Show(L.Blue)
		timerPhase:Start()
		timerFlashFreeze:Start()
	elseif msg == L.YellGreen then
		warnPhase:Show(L.Green)
		timerPhase:Start()
	elseif msg == L.YellDark then
		warnPhase:Show(L.Dark)
		timerPhase:Start(100)		-- copied from BigWigs as I didnt have a timer yet
	end
end