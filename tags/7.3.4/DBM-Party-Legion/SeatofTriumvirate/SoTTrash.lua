local mod	= DBM:NewMod("SoTTrash", "DBM-Party-Legion", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 248304 245585 245727 248133 248184 248227",
	"SPELL_AURA_APPLIED 245510 249081"
)

local warnCorruptingVoid			= mod:NewTargetAnnounce(245510, 3)
local warnSupField					= mod:NewTargetAnnounce(249081, 3)
local warnWildSummon				= mod:NewCastAnnounce(248304, 3)

local specWarnCorruptingVoid		= mod:NewSpecialWarningMoveAway(245510, nil, nil, nil, 1, 2)
local specWarnDarkMatter			= mod:NewSpecialWarningSwitch(248227, nil, nil, nil, 1, 2)
local yellCorruptingVoid			= mod:NewYell(245510)
local specWarnSupField				= mod:NewSpecialWarningYou(249081, nil, nil, nil, 1, 2)
local yellSupField					= mod:NewYell(249081)
local specWarnVoidDiffusion			= mod:NewSpecialWarningInterrupt(245585, "HasInterrupt", nil, nil, 1, 2)
local specWarnConsumeEssence		= mod:NewSpecialWarningInterrupt(245727, "HasInterrupt", nil, nil, 1, 2)
local specWarnStygianBlast			= mod:NewSpecialWarningInterrupt(248133, "HasInterrupt", nil, nil, 1, 2)
local specWarnDarkFlay				= mod:NewSpecialWarningInterrupt(248184, "HasInterrupt", nil, nil, 1, 2)

local voiceCorruptingVoid			= mod:NewVoice(245510)--runout
local voiceDarkMatter				= mod:NewVoice(248227)--killmob
local voiceSupField					= mod:NewVoice(249081)--stopmove
local voiceVoidDiffusion			= mod:NewVoice(245585, "HasInterrupt")--kickcast
local voiceConsumeEssence			= mod:NewVoice(245727, "HasInterrupt")--kickcast
local voiceStygianBlast				= mod:NewVoice(248133, "HasInterrupt")--kickcast
local voiceDarkFlay					= mod:NewVoice(248184, "HasInterrupt")--kickcast

mod:RemoveOption("HealthFrame")


function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 248304 then
		warnWildSummon:Show()
	elseif spellId == 245585 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnVoidDiffusion:Show(args.sourceName)
		voiceVoidDiffusion:Play("kickcast")
	elseif spellId == 245727 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnConsumeEssence:Show(args.sourceName)
		voiceConsumeEssence:Play("kickcast")
	elseif spellId == 248133 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnStygianBlast:Show(args.sourceName)
		voiceStygianBlast:Play("kickcast")
	elseif spellId == 248184 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDarkFlay:Show(args.sourceName)
		voiceDarkFlay:Play("kickcast")
	elseif spellId == 248227 then
		specWarnDarkMatter:Show()
		voiceDarkMatter:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 245510 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnCorruptingVoid:Show()
			voiceCorruptingVoid:Play("runout")
			yellCorruptingVoid:Yell()
		else
			warnCorruptingVoid:Show(args.destName)
		end
	elseif spellId == 249081 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnSupField:Show()
			voiceSupField:Play("stopmove")
			yellSupField:Yell()
		else
			warnSupField:Show(args.destName)
		end
	end
end
