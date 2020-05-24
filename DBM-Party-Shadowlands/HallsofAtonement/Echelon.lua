local mod	= DBM:NewMod(2387, "DBM-Party-Shadowlands", 4, 1185)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(158087)--Or 156827
mod:SetEncounterID(2380)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 319603 319724",
	"SPELL_AURA_REMOVED 319724",
	"SPELL_CAST_START 319733",
	"SPELL_CAST_SUCCESS 319941 328206 326389"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, do omre with leap if target scan can be done and if damage it does is threatening
--TODO, https://shadowlands.wowhead.com/spell=319611/turned-to-stone needed?
--[[
ability.id = 319733 and type = "begincast"
 or (ability.id = 319941 or ability.id = 328206 or ability.id = 326389) and type = "cast"
 --]]
local warnStoneShatteringLeap		= mod:NewSpellAnnounce(319592, 3)

local specWarnStoneCall				= mod:NewSpecialWarningSpell(319733, nil, nil, nil, 2, 2)
local specWarnCurseofStoneDispel	= mod:NewSpecialWarningDispel(319603, "RemoveCurse", nil, nil, 1, 2)
local specWarnCurseofStone			= mod:NewSpecialWarningYou(319603, nil, nil, nil, 1, 2)
local specWarnBloodTorrent			= mod:NewSpecialWarningSpell(319702, nil, nil, nil, 2, 2)
--local yellBlackPowder				= mod:NewYell(257314)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerStoneCallCD				= mod:NewCDTimer(37.6, 319733, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--37.6-43.6
local timerStoneShatteringLeapCD	= mod:NewCDTimer(29, 319592, nil, nil, nil, 3)
local timerCurseofStoneCD			= mod:NewCDTimer(29.1, 327411, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerBloodTorrentCD			= mod:NewCDTimer(16.9, 319702, nil, nil, nil, 2)--16.9 unless delayed by one of other casts

mod:AddNamePlateOption("NPAuraOnStoneForm", 319724)

function mod:OnCombatStart(delay)
	timerBloodTorrentCD:Start(9-delay)--SUCCESS
	timerStoneCallCD:Start(15.7-delay)
	timerCurseofStoneCD:Start(22.1-delay)--SUCCESS
	timerStoneShatteringLeapCD:Start(28.6-delay)--SUCCESS
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
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 319941 then
		warnStoneShatteringLeap:Show()
		timerStoneShatteringLeapCD:Start()
	elseif spellId == 328206 then
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
