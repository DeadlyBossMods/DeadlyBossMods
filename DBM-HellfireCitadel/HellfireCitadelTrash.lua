local mod	= DBM:NewMod("HellfireCitadelTrash", "DBM-HellfireCitadel")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 189595 189612",
	"SPELL_AURA_APPLIED 189533 188476 182644 186961 189512 187990 179219 187110",
	"SPELL_AURA_REMOVED 186961 187990 179219 187110",
	"CHAT_MSG_MONSTER_YELL"
)

--First time mod loads, inject custom sound for kaz
if not mod.Options.SpecWarn189512youSWSound then
	mod.Options.SpecWarn189512youSWSound = "Sound\\Creature\\KazRogal\\CAV_Kaz_Mark02.ogg"
end

--TODO, http://ptr.wowhead.com/spell=188510/graggra-smash
--http://ptr.wowhead.com/spell=188448/blazing-fel-touch
--Add Solar Chakram once right spellid is seen
--Add Harbinger's Mending when trash version is observed
local warnDarkFate					= mod:NewTargetAnnounce(182644, 3)
local warnPhantasmalCorruption		= mod:NewTargetAnnounce(187990, 3)
local warnPhantasmalFelBomb			= mod:NewTargetAnnounce(179219, 3)

local specWarnCrowdControl			= mod:NewSpecialWarningSpell(189595, nil, nil, nil, 1, 2)--Maybe use a custom "Look Away" warning
local specWarnSeverSoul				= mod:NewSpecialWarningYou(189533, nil, nil, nil, 1, 2)
local specWarnSeverSoulOther		= mod:NewSpecialWarningTaunt(189533, nil, nil, nil, 1, 2)
local specWarnBadBreathOther		= mod:NewSpecialWarningTaunt(188476, nil, nil, nil, 1, 2)
local specWarnBloodthirster			= mod:NewSpecialWarningSwitch("ej11266", "Dps", nil, 2, 1, 5)
local specWarnRendingHowl			= mod:NewSpecialWarningInterrupt(189612, "-Healer", nil, nil, 1, 2)
local yellDarkFate					= mod:NewFadesYell(182644)
local specWarnPhantasmalCorruption	= mod:NewSpecialWarningYou(187990)
local yellPhantasmalCorruption		= mod:NewYell(187990, 144421)
local specWarnPhantasmalFelBomb		= mod:NewSpecialWarningMoveAway(179219)--On trash, it is a move away
local yellPhantasmalFelBomb			= mod:NewYell(179219, 49685)
local specWarnFocusedFire			= mod:NewSpecialWarningYou(187110)
local yellFocusedFire				= mod:NewYell(187110)
local specWarnMarkofKaz				= mod:NewSpecialWarningYou(189512)

local voiceSeverSoul				= mod:NewVoice(189533, "Tank")--changemt
local voiceCrowdControl				= mod:NewVoice(189595)--turnaway
local voiceBloodthirster			= mod:NewVoice("ej11266", "Dps", nil, 2)
local voiceRendingHowl				= mod:NewVoice(189612, "-Healer")--kickcast

mod:RemoveOption("HealthFrame")
mod:AddRangeFrameOption(15)

local Bloodthirster = EJ_GetSectionInfo(11266)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 189595 then
		specWarnCrowdControl:Show()
		voiceCrowdControl:Play("turnaway")
	elseif spellId == 189612 and self:CheckInterruptFilter(args.sourceGUID) and self:AntiSpam(3, 1) then
		specWarnRendingHowl:Show(args.sourceName)
		voiceRendingHowl:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 189533 then
		voiceSeverSoul:Play("changemt")
		if args:IsPlayer() then
			specWarnSeverSoul:Show()
		else
			specWarnSeverSoulOther:Show(args.destName)
		end
	elseif spellId == 188476 and not args:IsPlayer() and not UnitDebuff("player", args.spellName) then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnBadBreathOther:Show(args.destName)
		end
	elseif spellId == 186961 then
		warnDarkFate:Show(args.destName)
		if args:IsPlayer() then
			yellDarkFate:Schedule(14, 1)
			yellDarkFate:Schedule(13, 2)
			yellDarkFate:Schedule(12, 3)
			yellDarkFate:Schedule(11, 4)
			yellDarkFate:Schedule(10, 5)
		end
	elseif spellId == 189512 then
		if args:IsPlayer() then
			specWarnMarkofKaz:Show()
		end
	elseif spellId == 187990 then
		warnPhantasmalCorruption:Show(args.destName)
		if args:IsPlayer() then
			specWarnPhantasmalCorruption:Show()
			yellPhantasmalCorruption:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(15)
			end
		end
	elseif spellId == 179219 then
		warnPhantasmalFelBomb:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPhantasmalFelBomb:Show()
			yellPhantasmalFelBomb:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(15)
			end
		end
	elseif spellId == 187110 and args:IsPlayer() then
		specWarnFocusedFire:Show()
		yellFocusedFire:Yell()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5, nil, nil, 2, true)--2 players or 3? 3 minimum right now i suppose since mythic is about 550k
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 186961 and args:IsPlayer() then
		yellDarkFate:Cancel()
	elseif spellId == 187990 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 179219 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 187110 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if npc == Bloodthirster then
		local kilroggMod = DBM:GetModByName("1396")
		if not kilroggMod:IsInCombat() and self:AntiSpam(2, 2) then--Don't activate if kilrogg is engaged
			specWarnBloodthirster:Show()
			voiceBloodthirster:Play("ej11266")
		end
	end
end