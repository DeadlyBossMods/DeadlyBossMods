local mod	= DBM:NewMod(745, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62980)--63554 (Special invisible Vizier that casts the direction based spellid versions of attenuation)
mod:SetModelID(42807)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Defeat)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--[[WoL Reg expression
(spellid = 123791 or spellid = 122713) and fulltype = SPELL_CAST_START or (spell = "Inhale" or spell = "Exhale") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE or fulltype = SPELL_AURA_REMOVED) or spellid = 127834 or spell = "Convert" or spellid = 124018
(spellid = 123791 or spellid = 122713 or spellid = 122740 or spellid = 127834) and fulltype = SPELL_CAST_START or spellid = 124018
--]]
--Notes: Currently, his phase 2 chi blast abiliteis are not detectable via traditional combat log. maybe with transcriptor.
local warnInhale			= mod:NewStackAnnounce(122852, 2)
local warnExhale			= mod:NewTargetAnnounce(122761, 3)
local warnForceandVerve		= mod:NewCastAnnounce(122713, 4, 4)
local warnAttenuation		= mod:NewTargetAnnounce(127834, 4)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnPlatform		= mod:NewSpecialWarning("specwarnPlatform")
local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarningTarget(122761, mod:IsHealer() or mod:IsTank())
local specwarnAttenuation	= mod:NewSpecialWarningTarget(127834, nil, nil, nil, true)

--Timers aren't worth a crap, at all, this is a timerless fight and will probably stay that way unless blizz redesigns it.
--http://us.battle.net/wow/en/forum/topic/7004456927 for more info on lack of timers.
--local timerExhaleCD			= mod:NewCDTimer(41, 122761)
local timerExhale				= mod:NewTargetTimer(6, 122761)
--local timerForceCD			= mod:NewCDTimer(48, 122713)--Phase 1, every 41 seconds since exhale keeps resetting it, phase 2, 48 seconds or as wildly high as 76 seconds if exhale resets it late in it's natural CD
local timerForceCast			= mod:NewCastTimer(4, 122713)
local timerForce				= mod:NewBuffActiveTimer(12.5, 122713)
--local timerAttenuationCD		= mod:NewCDTimer(34, 127834)--34-41 second variations, when not triggered off exhale. It's ALWAYS 11 seconds after exhale.
local timerAttenuation			= mod:NewBuffActiveTimer(14, 127834)
--local timerConvertCD			= mod:NewCDTimer(41, 122740)--totally don't know this CD, but it's probably 41 like other specials in phase 1.

local berserkTimer				= mod:NewBerserkTimer(660)

mod:AddBoolOption("MindControlIcon", true)
mod:AddBoolOption("ArrowOnAttenuation", true)

local MCTargets = {}
local MCIcon = 8

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:OnCombatStart(delay)
	table.wipe(MCTargets)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(600-delay)--still 10 min on normal. they only raised it to 11 minutes on heroic apparently.
	end
end

function mod:OnCombatEnd()
	if self.Options.ArrowOnAttenuation then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122852) then
		warnInhale:Show(args.destName, args.amount or 1)
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
	if args:IsSpellID(122761) then
		timerExhale:Cancel(args.destName)
	elseif args:IsSpellID(122740) then
		if self.Options.MindControlIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122713) then
		timerForce:Start()
	elseif args:IsSpellID(122474, 122496, 123721) then
		warnAttenuation:Show(args.sourceName)
		specwarnAttenuation:Show(args.sourceName)
		timerAttenuation:Start()
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(90, 12)
		end
	elseif args:IsSpellID(122479, 122497, 123722) then
		warnAttenuation:Show(args.sourceName)
		specwarnAttenuation:Show(args.sourceName)
		timerAttenuation:Start()
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(270, 12)
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		specwarnPlatform:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122933 and self:AntiSpam(2, 1) then--Clear Throat (4 seconds before force and verve)
		warnForceandVerve:Show()
		specwarnForce:Show()
		timerForceCast:Start()
	end
end
