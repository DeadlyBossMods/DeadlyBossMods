local mod	= DBM:NewMod(729, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62983)--62995 Animated Protector
mod:SetModelID(42811)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)--Kill detection is aweful. No death, no special cast. yell is like 40 seconds AFTER victory. terrible.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnProtect						= mod:NewSpellAnnounce(123250, 2)
local warnHide							= mod:NewSpellAnnounce(123244, 3)
local warnHideOver						= mod:NewAnnounce("warnHideOver", 2, 123244)--Because we can. with creativeness, the boss returning is detectable a full 1-2 seconds before even visible. A good signal to stop aoe and get ready to return norm DPS
local warnGetAway						= mod:NewSpellAnnounce(123461, 3)
local warnSpray							= mod:NewStackAnnounce(123121, 3, nil, mod:IsTank() or mod:IsHealer())

local specWarnAnimatedProtector			= mod:NewSpecialWarningSwitch("ej6224", not mod:IsHealer())
local specWarnHide						= mod:NewSpecialWarningSpell(123244, nil, nil, nil, true)
local specWarnGetAway					= mod:NewSpecialWarningSpell(123461, nil, nil, nil, true)
local specWarnSpray						= mod:NewSpecialWarningStack(123121, mod:IsTank(), 6)
local specWarnSprayOther				= mod:NewSpecialWarningTarget(123121, mod:IsTank())

local timerSpecialCD					= mod:NewTimer(22, "timerSpecialCD", 123250)--Not even this is 100% reliable. it's iffy at best, but she seems to use specials about 22-25 seconds after last one ended, except when last one was protect, then next one is used IMMEDIATELY upon protect ending. Timers for this fight are just jacked.
local timerSpray						= mod:NewTargetTimer(10, 123121, nil, mod:IsTank() or mod:IsHealer())
local timerGetAway						= mod:NewBuffActiveTimer(30, 123461)

local berserkTimer						= mod:NewBerserkTimer(600)

local hideActive = false

function mod:OnCombatStart(delay)
	hideActive = false
	timerSpecialCD:Start(42.5-delay)--the ONLY timer that ever seems to be right, is FIRST special.
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123250) then
		warnProtect:Show()
		specWarnAnimatedProtector:Show()
	elseif args:IsSpellID(123505) then
--[[Adds need super fancy icons for their spawns using this data.
"<84.9> [CLEU] SPELL_AURA_APPLIED#false#0xF130F61300000686#Animated Protector#2632#0#0xF130F61300000686#Animated Protector#2632#0#123505#Protect#8#BUFF", -- [14636]
"<84.9> [CLEU] SPELL_AURA_APPLIED#false#0xF130F61300000687#Animated Protector#2632#0#0xF130F61300000687#Animated Protector#2632#0#123505#Protect#8#BUFF", -- [14637]
"<84.9> [CLEU] SPELL_AURA_APPLIED#false#0xF130F61300000679#Animated Protector#2632#0#0xF130F61300000679#Animated Protector#2632#0#123505#Protect#8#BUFF", -- [14638]--]]
	elseif args:IsSpellID(123461) then
		warnGetAway:Show()
		specWarnGetAway:Show()
		timerGetAway:Start()
	elseif args:IsSpellID(123121) then
		if (args.amount or 1) % 3 == 0 then
			warnSpray:Show(args.destName, args.amount)
			if args.amount >= 6 and args:IsPlayer() then
				specWarnSpray:Show(args.amount)
			else
				if args.amount >= 6 and not UnitDebuff("player", GetSpellInfo(123121)) and not UnitIsDeadOrGhost("player") then
					specWarnSprayOther:Show(args.destName)
				end
			end
		end
		if not hideActive then--filter out all the splash sprays that go out during hide.
			timerSpray:Start(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123121) then
		timerSpray:Cancel(args.destName)
	elseif args:IsSpellID(123461) then
		timerGetAway:Cancel()
--		timerSpecialCD:Start()--Probably wrong so disabled. i still can't find this fights true pattern since it's all over the place and never matches up.
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(123244) then
		hideActive = true
		warnHide:Show()
		specWarnHide:Show()
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register on hide, because it also fires just before hide, every time and don't want to trigger "hide over" at same time as hide.
		)
	end
end

--Fires twice when boss returns, once BEFORE visible (and before we can detect unitID, so it flags unknown), then once a 2nd time after visible
--"<233.9> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#nil#nil#Unknown#0xF130F6070000006C#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [14168]
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	hideActive = false
	self:UnregisterShortTermEvents()--Once boss appears, unregister event, so we ignore the next two that will happen, which will be 2nd time after reappear, and right before next Hide.
	warnHideOver:Show(GetSpellInfo(123244))
--	timerSpecialCD:Start()--Probably wrong so disabled. i still can't find this fights true pattern since it's all over the place and never matches up.
end
