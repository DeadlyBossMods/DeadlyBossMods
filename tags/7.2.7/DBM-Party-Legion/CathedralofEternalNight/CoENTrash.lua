local mod	= DBM:NewMod("CoENTrash", "DBM-Party-Legion", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 15403 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 239232 237391 238543 236737 242724 242760 238653",
	"SPELL_AURA_APPLIED 238688 239161"
)

--TODO, Interrupt warning for Shadow Wall 241937?
local warnFelStrike				= mod:NewTargetAnnounce(236737, 3)

local specWarnFelStrike			= mod:NewSpecialWarningDodge(236737, nil, nil, nil, 1, 2)
local yellFelStrike				= mod:NewYell(236737)
local specWarnAlluringAroma		= mod:NewSpecialWarningInterrupt(237391, "HasInterrupt", nil, nil, 1, 2)
local specWarnDemonicMending	= mod:NewSpecialWarningInterrupt(238543, "HasInterrupt", nil, nil, 1, 2)
local specWarnDreadScream		= mod:NewSpecialWarningInterrupt(242724, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlindingGlare		= mod:NewSpecialWarningSpell(239232, nil, nil, nil, 1, 2)
local specWarnLumberingCrash	= mod:NewSpecialWarningRun(242760, "Melee", nil, nil, 4, 2)
local specWarnShadowWave		= mod:NewSpecialWarningDodge(238653, nil, nil, nil, 2, 2)
local specWarnChokingVines		= mod:NewSpecialWarningRun(238688, nil, nil, nil, 4, 2)
local specWarnTomeSilence		= mod:NewSpecialWarningSwitch(239161, "-Healer", nil, nil, 1, 2)

local voiceFelStrike			= mod:NewVoice(236737)--watchstep
local voiceAlluringAroma		= mod:NewVoice(237391, "HasInterrupt")--kickcast
local voiceDemonicMending		= mod:NewVoice(238543, "HasInterrupt")--kickcast
local voiceDreadScream			= mod:NewVoice(242724, "HasInterrupt")--kickcast
local voiceBlindingGlare		= mod:NewVoice(239232)--turnaway
local voiceLumberingCrash		= mod:NewVoice(242760, "Melee")--runout
local voiceShadowWave			= mod:NewVoice(238653)--watchwave
local voiceChokingVine			= mod:NewVoice(238688)--runout
local voiceTomeSilence			= mod:NewVoice(239161)--targetchange

mod:RemoveOption("HealthFrame")

function mod:FelStrikeTarget(targetname, uId)
	if not targetname then
		warnFelStrike:Show(DBM_CORE_UNKNOWN)
		return
	end
	if self:AntiSpam(2, targetname) then--In case two enemies target same target
		if targetname == UnitName("player") then
			specWarnFelStrike:Show()
			voiceFelStrike:Play("watchstep")
			yellFelStrike:Yell()
		else
			warnFelStrike:CombinedShow(0.5, targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 236737 then
		self:BossTargetScanner(args.sourceGUID, "FelStrikeTarget", 0.1, 9)
	elseif spellId == 239232 then
		specWarnBlindingGlare:Show()
		voiceBlindingGlare:Play("turnaway")
	elseif spellId == 237391 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnAlluringAroma:Show(args.sourceName)
		voiceAlluringAroma:Play("kickcast")
	elseif spellId == 238543 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDemonicMending:Show(args.sourceName)
		voiceDemonicMending:Play("kickcast")
	elseif spellId == 242724 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnDreadScream:Show(args.sourceName)
		voiceDreadScream:Play("kickcast")
	elseif spellId == 242760 then
		specWarnLumberingCrash:Show()
		voiceLumberingCrash:Play("runout")
	elseif spellId == 238653 then
		specWarnShadowWave:Show()
		voiceShadowWave:Play("watchwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 238688 and args:IsPlayer() then
		specWarnChokingVines:Show()
		voiceChokingVine:Play("runout")
	elseif spellId == 239161 and self:AntiSpam(4, 1) then
		specWarnTomeSilence:Show()
		voiceTomeSilence:Play("targetchange")
	end
end
