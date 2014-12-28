local mod	= DBM:NewMod(967, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76143)
mod:SetEncounterID(1700)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED 159382",
	"SPELL_CAST_START 153810 153794 159382",
	"RAID_BOSS_WHISPER"
)

local warnSolarFlare			= mod:NewSpellAnnounce(153810, 3)
local warnPierceArmor			= mod:NewSpellAnnounce(153794, 3, nil, mod:IsTank())
local warnQuills				= mod:NewSpellAnnounce(159382, 4)

local specWarnSolarFlare		= mod:NewSpecialWarningSwitch(153810, false)--Not everyone needs to, really just requires 1 person, unless it's harder on heroic/challenge mode and needs more, then i'll default all damage dealers
local specWarnPierceArmor		= mod:NewSpecialWarningSpell(153794, mod:IsTank())
local specWarnFixate			= mod:NewSpecialWarningYou(176544)
local specWarnQuills			= mod:NewSpecialWarningSpell(159382, nil, nil, nil, 2)
local specWarnQuillsEnd			= mod:NewSpecialWarningEnd(159382)

local timerSolarFlareCD			= mod:NewCDTimer(18, 153810)
local timerQuills				= mod:NewBuffActivTimer(17, 159382)

local voiceSolarFlare			= mod:NewVoice(153810, not mod:IsTank())
local voiceQuills				= mod:NewVoice(159382)

local skyTrashMod = DBM:GetModByName("SkyreachTrash")

function mod:OnCombatStart(delay)
	timerSolarFlareCD:Start(11-delay)
	if self:IsHeroic() then
		--timerQuillsCD:Start(33-delay)--Needs review
	end
	if skyTrashMod.Options.RangeFrame and skyTrashMod.vb.debuffCount ~= 0 then--In case of bug where range frame gets stuck open from trash pulls before this boss.
		skyTrashMod.vb.debuffCount = 0--Fix variable
		DBM.RangeCheck:Hide()--Close range frame.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 159382 then
		specWarnQuillsEnd:Show()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153810 then
		warnSolarFlare:Show()
		specWarnSolarFlare:Show()
		timerSolarFlareCD:Start()
		voiceSolarFlare:Play("mobsoon")
		if self:IsDps() then
			voiceSolarFlare:Schedule(2, "mobkill")
		end
	elseif spellId == 153794 then
		warnPierceArmor:Show()
		specWarnPierceArmor:Show()
	elseif spellId == 159382 then
		warnQuills:Show()
		specWarnQuills:Show()
		timerQuills:Start()
		voiceQuills:Play("findshelter")
	end
end

function mod:RAID_BOSS_WHISPER()
	specWarnFixate:Show()
end
