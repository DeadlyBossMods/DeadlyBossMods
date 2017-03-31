local mod	= DBM:NewMod("CoENTrash", "DBM-Party-Legion", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 15403 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 239232 237391 238543 236737"
)

--TODO, Interrupt warning for Shadow Wall 241937?
local warnFelStrike				= mod:NewTargetAnnounce(236737, 3)

local specWarnFelStrike			= mod:NewSpecialWarningDodge(236737, nil, nil, nil, 1, 2)
local yellFelStrike				= mod:NewYell(236737)
local specWarnAlluringAroma		= mod:NewSpecialWarningInterrupt(237391, "HasInterrupt", nil, nil, 1, 2)
local specWarnDemonicMending	= mod:NewSpecialWarningInterrupt(238543, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlindingGlare		= mod:NewSpecialWarningSpell(239232, nil, nil, nil, 1, 2)

local voiceFelStrike			= mod:NewVoice(236737)--watchstep
local voiceAlluringAroma		= mod:NewVoice(237391, "HasInterrupt")--kickcast
local voiceDemonicMending		= mod:NewVoice(238543, "HasInterrupt")--kickcast
local voiceBlindingGlare		= mod:NewVoice(239232)--turnaway

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
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200154 then
		if args:IsPlayer() then
			specWarnBurningHatred:Show()
			voiceBurningHatred:Play("targetyou")
		else
			warnBurningHatred:Show(args.destName)
		end
	elseif spellId == 183407 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnAcidSplatter:Show()
		voiceAcidSplatter:Play("runaway")
	end
end

--]]
