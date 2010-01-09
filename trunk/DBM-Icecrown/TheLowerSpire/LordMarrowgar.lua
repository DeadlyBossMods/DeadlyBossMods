local mod	= DBM:NewMod("LordMarrowgar", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36612)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local preWarnWhirlwind   	= mod:NewSoonAnnounce(69076, 2)
local warnBoneSpike			= mod:NewCastAnnounce(69057)
local warnImpale			= mod:NewAnnounce("WarnImpale")

local specWarnColdflame		= mod:NewSpecialWarningMove(70825)
local specWarnWhirlwind		= mod:NewSpecialWarningRun(69076)

local timerBoneSpike		= mod:NewCDTimer(18, 69057)
local timerWhirlwindCD		= mod:NewCDTimer(90, 69076)
local timerWhirlwind		= mod:NewBuffActiveTimer(20, 69076)
local timerBoned			= mod:NewAchievementTimer(8, 4610, "achievementBoned")

local berserkTimer			= mod:NewBerserkTimer(600)

local soundWhirlwind = mod:NewSound(69076)
mod:AddBoolOption("SetIconOnImpale", true)

local impaleTargets = {}
local impaleIcon	= 8

do 
	local lastColdflame = 0
	function mod:SPELL_PERIODIC_DAMAGE(args)
		if args:IsSpellID(69146, 70823, 70824, 70825) and args:IsPlayer() and time() - lastColdflame > 2 then		-- Coldflame, MOVE!
			specWarnColdflame:Show()
			lastColdflame = time()
		end
	end
end

local function showImpaleWarning()
	warnImpale:Show(table.concat(impaleTargets, "<, >"))
	table.wipe(impaleTargets)
	impaleIcon = 8
end

function mod:OnCombatStart(delay)
	preWarnWhirlwind:Schedule(40-delay)
	timerWhirlwindCD:Start(45-delay)
	timerBoneSpike:Start(15-delay)
	berserkTimer:Start(-delay)
	table.wipe(impaleTargets)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69057, 70826) then				-- Bone Spike Graveyard
		warnBoneSpike:Show()
		timerBoneSpike:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669, 72670) then						-- Impale
		impaleTargets[#impaleTargets + 1] = args.sourceName
		timerBoned:Start()
		if mod.Options.SetIconOnImpale and impaleIcon > 0 then
			mod:SetIcon(args.sourceName, impaleIcon)
			impaleIcon = impaleIcon - 1
		end
		self:Unschedule(showImpaleWarning)
		if mod:IsDifficulty("normal10") or (mod:IsDifficulty("normal25") and #impaleTargets >= 3) then
			showImpaleWarning()
		else
			self:Schedule(0.3, showImpaleWarning)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69076) then						-- Bone Storm (Whirlwind)
		timerBoneSpike:Cancel()							-- He doesn't do Bone Spike Graveyard during Bone Storm
		specWarnWhirlwind:Show()
		timerWhirlwindCD:Start()
		preWarnWhirlwind:Schedule(85)
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerWhirlwind:Show(40)						-- 40seconds on heroic
		else
			timerWhirlwind:Show()						-- 20seconds on normal.
		end
		soundWhirlwind:Play()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69065) then			-- Impaled
		mod:SetIcon(args.destName, 0)
	elseif args:IsSpellID(69076) then
		timerBoneSpike:Start(15)			-- He will do Bone Spike Graveyard 15 seconds after whirlwind ends
	end
end