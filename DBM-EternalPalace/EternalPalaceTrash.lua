local mod	= DBM:NewMod("EternalPalaceTrash", "DBM-EternalPalace", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true
mod:SetUsedIcons(1, 2, 3, 4, 5)

mod:RegisterEvents(
	"SPELL_CAST_START 304261 296701 304098 303619 303205",
	"SPELL_AURA_APPLIED 304026 303619 303942",
	"SPELL_AURA_REMOVED 304026 303619"
)

--TODO, verify gale buffet trash spellID 296701 is used somewhere
local warnArcaneBomb						= mod:NewTargetNoFilterAnnounce(304026, 3)
local warnDread								= mod:NewTargetNoFilterAnnounce(303619, 4, nil, "Healer")
local warnCoalescedNightmares				= mod:NewTargetAnnounce(303942, 3)

local specWarnHeal							= mod:NewSpecialWarningInterrupt(303205, "HasInterrupt", nil, nil, 1, 2)
local specWarnRejuvenatingAlgae				= mod:NewSpecialWarningInterrupt(304261, "HasInterrupt", nil, nil, 1, 2)
local specWarnGaleBuffet					= mod:NewSpecialWarningSpell(296701, nil, nil, nil, 2, 2)
local specWarnArcaneBomb					= mod:NewSpecialWarningMoveAway(304026, nil, nil, nil, 1, 2)
local yellArcaneBomb						= mod:NewYell(304026)
local yellArcaneBombFades					= mod:NewShortFadesYell(304026)
local yellDread								= mod:NewPosYell(303619)
local yellDreadFades						= mod:NewIconFadesYell(303619)
local specWarnCoalescedNightmares			= mod:NewSpecialWarningMoveAway(303942, nil, nil, nil, 1, 2)
local yellCoalescedNightmares				= mod:NewYell(303942)

mod:AddSetIconOption("SetIconDread", 303619, true, false, {1, 2, 3, 4, 5})

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 304261 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnRejuvenatingAlgae:Show(args.sourceName)
		specWarnRejuvenatingAlgae:Play("kickcast")
	elseif spellId == 303205 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHeal:Show(args.sourceName)
		specWarnHeal:Play("kickcast")
	elseif spellId == 296701 or spellId == 304098 then
		specWarnGaleBuffet:Show()
		specWarnGaleBuffet:Play("carefly")
	elseif spellId == 303619 then
		self.vb.dreadIcon = 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 304026 then
		warnArcaneBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(spellId)
		end
	elseif spellId == 303619 then
		warnDread:CombinedShow(0.3, args.destName)
		if not self:IsLFR() then
			local icon = self.vb.dreadIcon
			if args:IsPlayer() then
				yellDread:Yell(icon, icon, icon)
				yellDreadFades:Countdown(spellId, nil, icon)
			end
			if self.Options.SetIconDread then
				self:SetIcon(args.destName, icon)
			end
			self.vb.dreadIcon = self.vb.dreadIcon + 1
		end
	elseif spellId == 303942 then
		warnCoalescedNightmares:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnCoalescedNightmares:Show()
			specWarnCoalescedNightmares:Play("runout")
			specWarnCoalescedNightmares:ScheduleVoice(1, "keepmove")
			yellCoalescedNightmares:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 304026 then
		if args:IsPlayer() then
			yellArcaneBombFades:Cancel()
		end
	elseif spellId == 303619 then--Non LFR
		if args:IsPlayer() then
			yellDreadFades:Cancel()
		end
		if self.Options.SetIconDread then
			self:SetIcon(args.destName, 0)
		end
	end
end
