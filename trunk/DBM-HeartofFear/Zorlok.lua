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
local warnAttenuation		= mod:NewSpellAnnounce(127834, 4)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnPlatform		= mod:NewSpecialWarning("specwarnPlatform")
local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarningTarget(122761, mod:IsHealer() or mod:IsTank())
local specwarnAttenuation	= mod:NewSpecialWarningSpell(127834, nil, nil, nil, true)

--Timers aren't worth a crap, at all, this is a timerless fight and will probably stay that way unless blizz redesigns it.
--Update, blizzard didn't redesign it, so don't uncomment these timers, they are wrong and will always be wrong until every single failsafe is discovered.
--Every time i figure one failsafe out, i find out it's wrong under a different condition
--basically this fight works like zon ozz, where if a certain condition is present, timers get changed. Problem is, in phase 4, there are about 5 or more failsafes active at same time
--EVERY ability drastically alters every other abilities cd, making it impossible with any level of accuracy to support even remotely accurate timers.
--I'm not adding a timer if the variation for it is gonna be "anywhere between 40 seconds and 90 seconds". Cause yeah, that's not very useful.
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
--local recentPlatformChange = false
--local platform = 0

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:OnCombatStart(delay)
--	recentPlatformChange = false
--	platform = 0
	table.wipe(MCTargets)
	berserkTimer:Start(-delay)
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
	--"<112.7 21:19:19> [CLEU] SPELL_CAST_START#false#0xF150F60400001A34#Imperial Vizier Zor'lok#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#127834#Attenuation#0", -- [30640] --First ID is universal spell cast start spellid
	--"<114.3 21:19:21> [CLEU] SPELL_AURA_APPLIED#false#0xF130F8420000203A#Imperial Vizier Zor'lok#2632#0#0xF130F8420000203A#Imperial Vizier Zor'lok#2632#0#122474#Attenuation#0#BUFF", -- [30914] --Second ID is direction (one of two buffs he gets, he also gets a buff from cast ID)
	elseif args:IsSpellID(122474, 122496, 123721) then
		if self.Options.ArrowOnAttenuation and args.sourceGUID == UnitGUID("target") then
			DBM.Arrow:ShowStatic(90, 9)
		end
	elseif args:IsSpellID(122479, 122497, 123722) then
		if self.Options.ArrowOnAttenuation and args.sourceGUID == UnitGUID("target") then
			DBM.Arrow:ShowStatic(270, 9)
		end
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
	elseif args:IsSpellID(122713) then
		timerForce:Start()
--[[	elseif args:IsSpellID(123791) and recentPlatformChange then--No one is in melee range of boss, he's aoeing. (i.e., he's arrived at new platform)
		recentPlatformChange = false--we want to ignore when this happens as a result of players doing fight wrong. Only interested in platform changes.--]]
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(124018) then
		platform = 4--He moved to middle, it's phase 2, although platform "4" is better then adding an extra variable.
	end
end--]]

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		specwarnPlatform:Show()
--		platform = platform + 1
--		recentPlatformChange = true
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122933 and self:AntiSpam(2, 1) then--Clear Throat (4 seconds before force and verve)
		warnForceandVerve:Show()
		specwarnForce:Show()
		timerForceCast:Start()
	end
end
