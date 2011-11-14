if tonumber((select(2, GetBuildInfo()))) <= 14545 then return end

local mod	= DBM:NewMod(324, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55308)
mod:SetModelID(39138)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnVoidofUnmaking		= mod:NewSpellAnnounce(103571, 4, 103527)
local warnVoidDiffusion			= mod:NewStackAnnounce(106836, 2)
local warnFocusedAnger			= mod:NewStackAnnounce(104543, 3, nil, mod:IsTank() or mod:IsHealer())
local warnPsychicDrain			= mod:NewStackAnnounce(104322, 4, nil, mod:IsTank())
local warnShadows				= mod:NewSpellAnnounce(103434, 3)
local warnBlackBlood			= mod:NewSpellAnnounce(104378, 2)

local specWarnVoidofUnmaking	= mod:NewSpecialWarningSpell(103571, nil, nil, nil, true)
local specWarnPsychicDrain		= mod:NewSpecialWarningSpell(104322, false)
local specWarnShadows			= mod:NewSpecialWarningYou(103434)

local timerVoidofUnmakingCD		= mod:NewCDTimer(90, 103571)
local timerVoidDiffusionCD		= mod:NewCDTimer(5, 106836)--Can not be triggered more then once per 5 seconds.
local timerFocusedAngerCD		= mod:NewCDTimer(6, 104543, nil, false)--Off by default as it may not be entirely useful information to know, but an option just for heck of it. You know SOMEONE is gonna request it
local timerPsychicDrainCD		= mod:NewCDTimer(20, 104543, nil, mod:IsTank())--Every 20-25 seconds, variates.
local timerShadowsCD			= mod:NewCDTimer(25, 103434)--Every 25-30, variates
local timerBlackBlood			= mod:NewBuffActiveTimer(30, 104378)

mod:AddBoolOption("RangeFrame", true)--For heroic shadows, doesn't seem relevent on normal.

local shadowsTargets	= {}

local function warnShadowsTargets()
	if mod.Options.RangeFrame and mod:IsDifficulty("heroic10", "heroic25") then
		DBM.RangeCheck:Show(10)--Show range frame on heroic
	end
	warnShadows:Show(table.concat(shadowsTargets, "<, >"))
	timerShadowsCD:Start()
	table.wipe(shadowsTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(shadowsTargets)
	timerVoidofUnmakingCD:Start(6-delay)
	timerFocusedAngerCD:Start(10.5-delay)
	timerPsychicDrainCD:Start(-delay)
	timerShadowsCD:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104378) then--104378 confirmed 10 man normal
		timerFocusedAngerCD:Cancel()
		timerPsychicDrainCD:Cancel()
		warnBlackBlood:Show()
		timerBlackBlood:Start()
	elseif args:IsSpellID(104322, 104606, 104607, 104608) then--104378 confirmed 10 man normal
		warnPsychicDrain:Show()
		specWarnPsychicDrain:Show()
		timerPsychicDrainCD:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104543, 109409, 109410, 109411) then--104543 confirmed 10 man normal
		warnFocusedAnger:Show(args.destName, args.amount or 1)
		timerFocusedAngerCD:Start()
	elseif args:IsSpellID(106836) then--106836 confirmed 10 man normal, do NOT add 103527 to this, that's a seperate spellid for when BOSS is affected by diffusion, this warning is counting the ball stacks.
		warnVoidDiffusion:Show(args.destName, args.amount or 1)
		timerVoidDiffusionCD:Start()
	elseif args:IsSpellID(103434, 104599, 104600, 104601) then--103434 confirmed 10 man normal.
		shadowsTargets[#shadowsTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnShadows:Show()
		end
		self:Unschedule(warnShadowsTargets)
		if (self:IsDifficulty("normal10") and #shadowsTargets >= 3) then--Don't know the rest yet, will tweak as they are discovered
			warnShadowsTargets()
		else
			self:Schedule(0.3, warnShadowsTargets)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104378) then--104378 confirmed 10 man normal
		--Everything but void will be cast 6 seconds after blood phase.
		timerFocusedAngerCD:Start(6)
		timerPsychicDrainCD:Start(6)
		timerShadowsCD:Start(6)
	end
end	

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if not uId == "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if spellID == 103571 then--Void of the unmaking cast, do not use spellname because we want to ignore vents using spellid 103627 which fires when the sphere dispurses on the boss.
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
		timerVoidofUnmakingCD:Start()
	end
end