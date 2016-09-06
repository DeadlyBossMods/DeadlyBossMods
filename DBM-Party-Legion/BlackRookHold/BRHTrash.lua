local mod	= DBM:NewMod("BRHTrash", "DBM-Party-Legion", 1, 740)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 200261 221634 221688 225573",
	"SPELL_AURA_APPLIED 194966",
	"SPELL_CAST_SUCCESS 200343 200345"
)

--TODO, add Etch? http://www.wowhead.com/spell=198959/etch
--TODO, add Brutal Assault
local warnSoulEchoes				= mod:NewTargetAnnounce(194966, 2)

local specWarnBonebreakingStrike	= mod:NewSpecialWarningDodge(200261, "Tank", nil, nil, 1, 2)
local specWarnSoulEchos				= mod:NewSpecialWarningRun(194966, nil, nil, nil, 1, 2)
local specWarnArrowBarrage			= mod:NewSpecialWarningDodge(200343, nil, nil, nil, 2, 2)
local yellArrowBarrage				= mod:NewYell(200343)
--Braxas the Fleshcarver
local specWarnWhirlOfFlame			= mod:NewSpecialWarningDodge(221634, nil, nil, nil, 2, 2)
local specWarnOverDetonation		= mod:NewSpecialWarningRun(221688, nil, nil, nil, 4, 2)
local specWarnDarkMending			= mod:NewSpecialWarningInterrupt(225573, "HasInterrupt", nil, nil, 1, 2)

local voiceBonebreakingStrike		= mod:NewVoice(200261, "Tank")--shockwave
local voiceSoulEchos				= mod:NewVoice(194966)--runaway/keepmove
local voiceArrowBarrage				= mod:NewVoice(200343)--stilldanger (best one i could come up with)
local voiceWhirlOfFlame				= mod:NewVoice(221634)--watchstep
local voiceOverDetonation			= mod:NewVoice(221688)--runout
local voiceDarkMending				= mod:NewVoice(225573, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200261 and self:AntiSpam(2, 1) then
		specWarnBonebreakingStrike:Show()
		voiceBonebreakingStrike:Play("shockwave")
	elseif spellId == 221634 then
		specWarnWhirlOfFlame:Show()
		voiceWhirlOfFlame:Play("watchstep")
	elseif spellId == 221688 then
		specWarnOverDetonation:Show()
		voiceOverDetonation:Play("runout")
	elseif spellId == 225573 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDarkMending:Show(args.sourceName)
		voiceDarkMending:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194966 then
		if args:IsPlayer() then
			specWarnSoulEchos:Show()
			voiceSoulEchos:Play("runaway")
			voiceSoulEchos:Schedule(1, "keepmove")
		else
			warnSoulEchoes:Show(args.destName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200343 then
		if self:AntiSpam(3, 2) then
			specWarnArrowBarrage:Show(args.destName)
			voiceArrowBarrage:Play("stilldanger")
		end
		if args:IsPlayer() and self:AntiSpam(3, 3) then
			yellArrowBarrage:Yell()
		end
	end
end
