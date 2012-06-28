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
local warnInhale			= mod:NewCountAnnounce(122852, 2)
local warnExhale			= mod:NewTargetAnnounce(122761, 3)
local warnForceandVerve		= mod:NewSpellAnnounce(122713, 4)
local warnAttenuation		= mod:NewSpellAnnounce(127834, 4)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarningTarget(122761, mod:IsHealer())
local specwarnAttenuation	= mod:NewSpecialWarningSpell(127834, nil, nil, nil, true)

--Honestly, i cannot make heads or tails of Cds, they are either 41, or altered.
--But WHEN they get altered is too hard to figure out.
--so including them at all would serve to just be more underminding then not having any at all
--it seems the abilities got a ton of failsafes that need figuring out, code that prevents fatal overlap that can cause very drastic CD shifts.
--I do NOT want a lazy CD bar that says "it might be in 34 seconds, or 1 minute 20 second) for any of these abilities.
--If we can't figure out what's altering them, we will not impliment half assed ones that are flat out wrong half the time.
--local timerInhaleCD			= mod:NewCDTimer(25, 122852)--This one is usually 25, but sometimes longer at random, it's also SUPER longer in phase 2.
--local timerExhaleCD			= mod:NewCDTimer(41, 122761)
local timerExhale				= mod:NewTargetTimer(6, 122761)
--local timerForceCD			= mod:NewCDTimer(41, 122713)
local timerForce				= mod:NewBuffActiveTimer(12.5, 122713)
--local timerAttenuationCD		= mod:NewCDTimer(41, 127834)
local timerAttenuation			= mod:NewBuffActiveTimer(14, 127834)
--local timerConvertCD			= mod:NewCDTimer(41, 122740)

mod:AddBoolOption("MindControlIcon", true)

local phase = 1
local MCTargets = {}
local MCIcon = 8

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:OnCombatStart(delay)
	phase = 1
	table.wipe(MCTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122852) then
		warnInhale:Show(args.amount or 1)
		if (args.amount or 1) < 3 then
			timerInhaleCD:Start()	
		end
	elseif args:IsSpellID(122761) then
		warnExhale:Show(args.destName)
		specwarnExhale:Show(args.destName)
		timerExhale:Start(args.destName)
	elseif args:IsSpellID(122740) then
		MCTargets[#MCTargets + 1] = args.destName
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
	if args:IsSpellID(122852) then
--		timerInhaleCD:Start(12)
	elseif args:IsSpellID(122761) then
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
	elseif args:IsSpellID(122713) then
		warnForceandVerve:Show()
		specwarnForce:Show()
		timerForce:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(124018) then
		phase = 2--In case i ever figure out what in the hell is affecting timers, especially in phase 2.
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		--Also really serves no purpose since the timers are too hard to figure out, but maybe one day something will be here.
	end
end
