local mod	= DBM:NewMod(2387, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164185)
mod:SetEncounterID(2380)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 319733 319941",
	"SPELL_CAST_SUCCESS 328206 326389",
	"SPELL_AURA_APPLIED 319603 319724",
	"SPELL_AURA_REMOVED 319724"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify Leap target scanning, if doesn't work, maybe hidden aura scan or RAID_WHISPER event
--TODO, https://shadowlands.wowhead.com/spell=319611/turned-to-stone needed?
--TODO, switch to more efficient and faster UNIT_TARGET scanner if timing works out
--TODO, more timer refinements to do better prediction of spell queuing from timer interactions
--[[
(ability.id = 319941 or ability.id = 319733) and type = "begincast"
 or (ability.id = 328206 or ability.id = 326389) and type = "cast"
 --]]
local warnStoneShatteringLeap		= mod:NewTargetNoFilterAnnounce(319592, 3)

local specWarnStoneCall				= mod:NewSpecialWarningSpell(319733, nil, nil, nil, 2, 2)
local specWarnCurseofStoneDispel	= mod:NewSpecialWarningDispel(319603, "RemoveCurse", nil, nil, 1, 2)
local specWarnCurseofStone			= mod:NewSpecialWarningYou(319603, nil, nil, nil, 1, 2)
local specWarnBloodTorrent			= mod:NewSpecialWarningSpell(319702, nil, nil, nil, 2, 2)
local specWarnStoneShatteringLeap	= mod:NewSpecialWarningYou(319592, nil, nil, nil, 1, 2)
local yellStoneShatteringLeap		= mod:NewYell(319592)
local yellStoneShatteringLeapFades	= mod:NewShortFadesYell(319592)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerStoneCallCD				= mod:NewCDTimer(37.6, 319733, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--37.6-49.19
local timerStoneShatteringLeapCD	= mod:NewCDTimer(29.1, 319592, nil, nil, nil, 3)
local timerCurseofStoneCD			= mod:NewCDTimer(29.1, 327411, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerBloodTorrentCD			= mod:NewCDTimer(16.9, 319702, nil, nil, nil, 2)--16.9 unless delayed by one of other casts

mod:AddNamePlateOption("NPAuraOnStoneForm", 319724)

function mod:LeapTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnStoneShatteringLeap:Show()
		specWarnStoneShatteringLeap:Play("targetyou")
		yellStoneShatteringLeap:Yell()
		yellStoneShatteringLeapFades:Countdown(5-scanningTime)
	else
		warnStoneShatteringLeap:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerBloodTorrentCD:Start(9-delay)--SUCCESS
	timerStoneCallCD:Start(14.9-delay)--START
	timerCurseofStoneCD:Start(21.3-delay)--SUCCESS
	timerStoneShatteringLeapCD:Start(22.8-delay)--START
	if self.Options.NPAuraOnStoneForm then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnStoneForm then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 319733 then
		specWarnStoneCall:Show()
		specWarnStoneCall:Play("killmob")
		timerStoneCallCD:Start()
	elseif spellId == 319941 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "LeapTarget", 0.1, 8, true, nil, nil, nil, true)
		timerStoneShatteringLeapCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 328206 then
		timerCurseofStoneCD:Start()
	elseif spellId == 326389 then
		specWarnBloodTorrent:Show()
		specWarnBloodTorrent:Play("aesoon")
		timerBloodTorrentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 319603 then
		if self.Options.SpecWarn319603dispel and self:CheckDispelFilter() then
			specWarnCurseofStoneDispel:CombinedShow(0.3, args.destName)
			specWarnCurseofStoneDispel:ScheduleVoice(0.3, "helpdispel")
		elseif args:IsPlayer() then
			specWarnCurseofStone:Show()
			specWarnCurseofStone:Play("targetyou")
		end
	elseif spellId == 319724 then
		if self.Options.NPAuraOnStoneForm then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 30)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 319724 then
		if self.Options.NPAuraOnStoneForm then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
