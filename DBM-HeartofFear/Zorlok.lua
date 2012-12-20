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
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

--[[WoL Reg expression
(spellid = 123791 or spellid = 122713) and fulltype = SPELL_CAST_START or (spell = "Inhale" or spell = "Exhale") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE or fulltype = SPELL_AURA_REMOVED) or spellid = 127834 or spell = "Convert" or spellid = 124018
(spellid = 123791 or spellid = 122713 or spellid = 122740 or spellid = 127834) and fulltype = SPELL_CAST_START or spellid = 124018
--]]
--Notes: Currently, his phase 2 chi blast abiliteis are not detectable via traditional combat log. maybe with transcriptor.
local warnInhale			= mod:NewStackAnnounce(122852, 2)
local warnExhale			= mod:NewTargetAnnounce(122761, 3)
local warnForceandVerve		= mod:NewCastAnnounce(122713, 4, 4)
local warnAttenuation		= mod:NewAnnounce("warnAttenuation", 4, 127834)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnPlatform		= mod:NewSpecialWarning("specwarnPlatform")
local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarningTarget(122761, mod:IsHealer() or mod:IsTank())
local specwarnAttenuation	= mod:NewSpecialWarning("specwarnAttenuation", nil, nil, nil, true)

--Timers aren't worth a crap, at all, but added anyways. if people complain about how inaccurate they are tell them to go to below thread or get bent.
--http://us.battle.net/wow/en/forum/topic/7004456927 for more info on lack of timers.
local timerExhale				= mod:NewTargetTimer(6, 122761)
local timerForceCD				= mod:NewCDTimer(35, 122713)--35-50 second variation
local timerForceCast			= mod:NewCastTimer(4, 122713)
local timerForce				= mod:NewBuffActiveTimer(12.5, 122713)
local timerAttenuationCD		= mod:NewCDTimer(32.5, 127834)--32.5-41 second variations, when not triggered off exhale. It's ALWAYS 11 seconds after exhale.
local timerAttenuation			= mod:NewBuffActiveTimer(14, 127834)
local timerConvertCD			= mod:NewCDTimer(40, 122740)--40-50 second variations

local berserkTimer				= mod:NewBerserkTimer(660)

mod:AddBoolOption("MindControlIcon", true)
mod:AddBoolOption("ArrowOnAttenuation", true)

local MCTargets = {}
local MCIcon = 8
local platform = 0
local EchoAlive = false--Will be used for the very accurate phase 2 timers when an echo is left up on purpose. when convert is disabled the other 2 abilities trigger failsafes that make them predictable. it's the ONLY time phase 2 timers are possible. otherwise they are too variable to be useful

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	timerConvertCD:Start()
	table.wipe(MCTargets)
	MCIcon = 8
end

function mod:OnCombatStart(delay)
	platform = 0
	EchoAlive = false
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
	if args:IsSpellID(122852) and UnitName("target") == args.sourceName then
		warnInhale:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(122761) and UnitName("target") == args.sourceName then--probalby won't work for healers but oh well. On heroic if i'm tanking echo i don't want this spam. I only care if i'm tanking boss.
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
		warnAttenuation:Show(args.spellName, args.sourceName, L.Left)
		specwarnAttenuation:Show(args.spellName, args.sourceName, L.Left)
		timerAttenuation:Start()
		if platform < 4 then
			timerAttenuationCD:Start()
		else
			if EchoAlive then--if echo isn't active don't do any timers
				if args:GetSrcCreatureID() == 65173 then--Echo
					timerAttenuationCD:Start(28, args.sourceGUID)--Because both echo and boss can use it in final phase and we want 2 bars
				else--Boss
					timerAttenuationCD:Start(54, args.sourceGUID)
				end
			end
		end
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(90, 12)
		end
	elseif args:IsSpellID(122479, 122497, 123722) then
		warnAttenuation:Show(args.spellName, args.sourceName, L.Right)
		specwarnAttenuation:Show(args.spellName, args.sourceName, L.Right)
		timerAttenuation:Start()
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(270, 12)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(124018) then
		platform = 4--He moved to middle, it's phase 2, although platform "4" is better then adding an extra variable.
		timerConvertCD:Cancel()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		platform = platform + 1
		specwarnPlatform:Show()
		timerForceCD:Cancel()
		timerAttenuationCD:Cancel()
	end
end

--"<55.0 21:38:55> [CLEU] UNIT_DIED#true#0x0000000000000000#nil#-2147483648#-2147483648#0xF130FE9600003072#Echo of Force and Verve#68168#0", -- [10971]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122933 and self:AntiSpam(2, 1) then--Clear Throat (4 seconds before force and verve)
		warnForceandVerve:Show()
		specwarnForce:Show()
		timerForceCast:Start()
		if platform < 4 then
			timerForceCD:Start()
		else
			if EchoAlive then
				timerForceCD:Start(54)
			end
		end
	elseif (spellId == 130297 or spellId == 127541) and not EchoAlive then--Echo of Zor'lok
		EchoAlive = true
		if platform == 2 then--Boss flew off from first platform to 2nd, and this means the echo that spawned is an Echo of Force and Verve
--			timerForceCD:Start()
		elseif platform == 3 then--Boss flew to 3rd platform and left an Echo of Attenuation behind on 2nd.
--			timerAttenuationCD:Start()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68168 then--Echo of Force and Verve
		EchoAlive = false
		timerForceCD:Cancel()
	elseif cid == 65173 then--Echo of Attenuation
		EchoAlive = false
		if platform < 4 then
			timerAttenuationCD:Cancel()
		else--No echo left up in final phase, cancel al timers because they are going to go back to clusterfuck random (as in may weave convert in but may not, and delay other abilities by as much as 30-50 seconds)
			timerAttenuationCD:Cancel()
			timerForceCD:Cancel()
		end
	end
end
