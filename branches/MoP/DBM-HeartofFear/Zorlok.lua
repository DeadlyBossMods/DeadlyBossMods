local mod	= DBM:NewMod(745, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62980)
mod:SetModelID(42807)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Defeat)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE"
)

--[[WoL Reg expression
(spellid = 123791 or spellid = 122713) and fulltype = SPELL_CAST_START or (spell = "Inhale" or spell = "Exhale") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE or fulltype = SPELL_AURA_REMOVED) or spellid = 127834 or spell = "Convert" or spellid = 124018
--]]
--Notes: Currently, his phase 2 chi blast abiliteis are not detectable via traditional combat log. maybe with transcriptor.
local warnInhale			= mod:NewStackAnnounce(122852, 2)
local warnExhale			= mod:NewTargetAnnounce(122761, 3)
local warnForceandVerve		= mod:NewSpellAnnounce(122713, 4)
local warnAttenuation		= mod:NewSpellAnnounce(127834, 4)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarningTarget(122761, mod:IsHealer())
local specwarnAttenuation	= mod:NewSpecialWarningSpell(127834, nil, nil, nil, true)

--These timers are not Cds, they are precise next timers, all of them, BUT, they are all heavily altered by other abilities
--My goal is to have all the timers be precise, not half assed CD timers that say (this ability might be in 34 seconds, or 74 seconds)
--^^ is not acceptable. A timer that's 40 seconds off is not a useful timer. I will only start timers if i know they are RIGHT
--For beta testing i may start them on some working theories, but on live i will comment out any timers that aren't figured out by then.
local timerExhaleCD				= mod:NewCDTimer(41, 122761)
local timerExhale				= mod:NewTargetTimer(6, 122761)
local timerForceCD				= mod:NewCDTimer(48, 122713)--Phase 1, every 41 seconds since exhale keeps resetting it, phase 2, 48 seconds or as wildly high as 76 seconds if exhale resets it late in it's natural CD
local timerForce				= mod:NewBuffActiveTimer(12.5, 122713)
local timerAttenuationCD		= mod:NewCDTimer(34, 127834)--34-41 second variations, when not triggered off exhale. It's ALWAYS 11 seconds after exhale.
local timerAttenuation			= mod:NewBuffActiveTimer(14, 127834)
local timerConvertCD			= mod:NewCDTimer(41, 122740)--totally don't know this CD, but it's probably 41 like other specials in phase 1.

mod:AddBoolOption("MindControlIcon", true)

local MCTargets = {}
local MCIcon = 8
local recentPlatformChange = false
local platform = 0
local inhaleCount = 0

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:OnCombatStart(delay)
	recentPlatformChange = false
	platform = 0
	inhaleCount = 0
	table.wipe(MCTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122852) then
		inhaleCount = (args.amount or 1)
		warnInhale:Show(inhaleCount)
		if inhaleCount < 3 and platform < 4 then--Can't figure out how this behaves in phase 2 yet
			timerInhaleCD:Start()	
		end
	elseif args:IsSpellID(122761) then
		warnExhale:Show(args.destName)
		specwarnExhale:Show(args.destName)
		timerExhale:Start(args.destName)
		if platform == 1 then--Exhale apsolutely alters some of the ability CDs. Triggering these here is only accurate way i can find to do this. These seem dead on this way
			timerInhaleCD:Start(17.5)
			timerForceCD:Start(27.5)
			timerExhaleCD:Start()
		elseif platform == 2 then
			timerInhaleCD:Start(33)
			timerAttenuationCD:Start(17)
			timerExhaleCD:Start()
		elseif platform == 3 then
			timerInhaleCD:Start(18)
			timerExhaleCD:Start(25)--He exhales more often on platform 3.
		elseif platform == 4 then
			timerInhaleCD:Start(67.5)--Probably wrong.
			timerAttenuationCD:Start(17)
			timerForceCD:Start(37.5)
		end
	elseif args:IsSpellID(122740) then
		MCTargets[#MCTargets + 1] = args.destName
--[[	if platform == 4 then
			timerConvertCD:Start()--Not known
		else
			timerConvertCD:Start()--Not known
		end--]]
		if self.Options.MindControlIcon then
			self:SetIcon(args.destName, MCIcon)
			MCIcon = MCIcon - 1
		end
		self:Unschedule(showMCWarning)
		self:Schedule(0.9, showMCWarning)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122761) then
		timerExhale:Cancel(args.destName)
	elseif args:IsSpellID(122740) then
		if self.Options.MindControlIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(127834) then
		warnAttenuation:Show()
		specwarnAttenuation:Show()
		timerAttenuation:Start()
		if platform == 4 then
			timerAttenuationCD:Start()
		end
	elseif args:IsSpellID(122713) then
		warnForceandVerve:Show()
		specwarnForce:Show()
		timerForce:Start()
		if platform == 4 then
			timerForceCD:Start()
		end
	elseif args:IsSpellID(123791) and recentPlatformChange then--No one is in melee range of boss, he's aoeing. (i.e., he's arrived at new platform)
		recentPlatformChange = false--we want to ignore when this happens as a result of players doing fight wrong. Only interested in platform changes.
		if platform == 1 then
			timerForceCD:Start(22)
			timerExhaleCD:Start(44)
		elseif platform == 2 then
			timerAttenuationCD:Start(19)
			timerExhaleCD:Start(35.5)
		elseif platform == 3 then
			timerConvertCD:Start(36)--Probably wrong.
--			timerExhaleCD:Start(35.5)--Not known, in my log it was accelerated by entering this platform with 3 stack of inhale.
		elseif platform == 4 then
			timerAttenuationCD:Start(19)
			timerForceCD:Start(25)
			timerConvertCD:Start(74)--probably wrong
			timerExhaleCD:Start(76)--Also probably wrong, can't quite put my finger on inhale/exhale in phase 2(platform 4)
		end
		if inhaleCount == 3 then
			timerExhaleCD:Start(12.5)--If inhale is already at 3, then he will exhale early in the phase instead of honoring exhales norm phase timer.
		else
			timerInhaleCD:Start(12.5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(124018) then
		platform = 4--He moved to middle, it's phase 2, although platform "4" is better then adding an extra variable.
		timerForceCD:Cancel()
		timerAttenuationCD:Cancel()
		timerConvertCD:Cancel()
		timerExhaleCD:Cancel()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		platform = platform + 1
		recentPlatformChange = true
		timerForceCD:Cancel()
		timerAttenuationCD:Cancel()
		timerConvertCD:Cancel()
		timerExhaleCD:Cancel()
	end
end
