local mod	= DBM:NewMod(2096, "DBM-Party-BfA", 9, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(127503)
mod:SetEncounterID(2104)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 256038 256105",
	"SPELL_AURA_REMOVED 256038 256105",
	"SPELL_CAST_START 256083 256198 256199 263345",
	"SPELL_CAST_SUCCESS 256038 256101"
)

local warnAZBlast					= mod:NewSpellAnnounce(256199, 2)
local warnAZIncendiary				= mod:NewSpellAnnounce(256198, 2)
local warnDeadeye					= mod:NewTargetNoFilterAnnounce(256038, 4)
local warnExplosiveBurst			= mod:NewTargetAnnounce(256105, 2)

local specWarnCrossIgnition			= mod:NewSpecialWarningSpell(256083, nil, nil, nil, 2, 2)--If the lines have better visuals later maybe i'll say farfromline/dodge, but for now, treating as unavoidable aoe
local specWarnDeadeye				= mod:NewSpecialWarningDefensive(256038, nil, nil, nil, 1, 2)
local yellDeadeye					= mod:NewYell(256038)
local specWarnExplosiveBurst		= mod:NewSpecialWarningMoveAway(256105, nil, nil, nil, 1, 2)
local yellExplosiveBurst			= mod:NewYell(256105)
local specWarnMassiveBlast			= mod:NewSpecialWarningDodge(263345, nil, nil, nil, 2, 2)

local timerARBlastCD				= mod:NewCDTimer(44.8, 256199, nil, nil, nil, 3)
local timerARICD					= mod:NewCDTimer(44.8, 256198, nil, nil, nil, 3)
local timerCrossIgnitionCD			= mod:NewCDTimer(44.8, 256083, nil, nil, nil, 2)
local timerDeadeyeCD				= mod:NewCDTimer(23, 256038, nil, nil, nil, 3)
local timerExplosiveBurstCD			= mod:NewCDTimer(44.8, 256105, nil, nil, nil, 3)
local timerMassiveBlastCD			= mod:NewCDTimer(22, 263345, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnDeadeye", 256038, true, false, {1})
mod:AddInfoFrameOption(256044)
mod:AddRangeFrameOption(5, 256105)

mod.vb.crossCount = 0
mod.vb.burstCount = 0

function mod:OnCombatStart(delay)
	self.vb.crossCount = 0
	self.vb.burstCount = 0
	timerARICD:Start(5.1-delay)
	timerExplosiveBurstCD:Start(11.5-delay)
	timerCrossIgnitionCD:Start(16-delay)
	timerMassiveBlastCD:Start(17-delay)
	timerDeadeyeCD:Start(23.3-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(256044))
		DBM.InfoFrame:Show(5, "reverseplayerbaddebuffbyspellid", 256044)--Must match spellID to filter other debuffs out
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 256038 then--Targetting deadeye
		if args:IsPlayer() then
			specWarnDeadeye:Show()
			specWarnDeadeye:Play("targetyou")
			yellDeadeye:Yell()
		else
			warnDeadeye:Show(args.destName)
		end
		if self.Options.SetIconOnDeadeye then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 256105 then
		warnExplosiveBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnExplosiveBurst:Show()
			specWarnExplosiveBurst:Play("runout")
			yellExplosiveBurst:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 256038 and self.Options.SetIconOnDeadeye then
		self:SetIcon(args.destName, 0)
	elseif spellId == 256105 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 256083 then
		self.vb.crossCount = self.vb.crossCount + 1
		specWarnCrossIgnition:Show()
		specWarnCrossIgnition:Play("aesoon")
		--16.0, 27.5, 17.0, 27.9
		if self.vb.crossCount % 2 == 0 then
			timerCrossIgnitionCD:Start(17)--20?
		else
			timerCrossIgnitionCD:Start(27.5)
		end
	elseif spellId == 256198 then
		warnAZIncendiary:Show()
		--Blast next
		timerARBlastCD:Start(22.2)
	elseif spellId == 256199 then
		warnAZBlast:Show()
		--Incendiary next
		timerARICD:Start(22.2)
	elseif spellId == 263345 then
		specWarnMassiveBlast:Show()
		specWarnMassiveBlast:Play("shockwave")--Shockwave, but from cannon not boss
		timerMassiveBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 256038 then
		timerDeadeyeCD:Start()
	elseif spellId == 256101 then
		self.vb.burstCount = self.vb.burstCount + 1
		--12.9, 15.8, 7.3, 25.5 /// 12.6, 15.8, 7.3, 15.0, 7.3, 15.8, 7.3
		if self.vb.crossCount % 2 == 0 then
			timerExplosiveBurstCD:Start(7.3)
		else
			timerExplosiveBurstCD:Start(15)
		end
	end
end
