local mod	= DBM:NewMod("CoENTrash", "DBM-Party-Legion", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 15403 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 239232 237391 238543 236737 242724 242760 239320 239266",
	"SPELL_AURA_APPLIED 238688 239161",
	"UNIT_SPELLCAST_START"
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
local specWarnFelblazeOrb		= mod:NewSpecialWarningDodge(239320, nil, nil, nil, 1, 2)
local specWarnVenomStorm		= mod:NewSpecialWarningDodge(239266, nil, nil, nil, 1, 2)

function mod:FelStrikeTarget(targetname, uId)
	if not targetname then
		warnFelStrike:Show(DBM_CORE_UNKNOWN)
		return
	end
	if self:AntiSpam(2, targetname) then--In case two enemies target same target
		if targetname == UnitName("player") then
			specWarnFelStrike:Show()
			specWarnFelStrike:Play("watchstep")
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
		specWarnBlindingGlare:Play("turnaway")
	elseif spellId == 237391 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnAlluringAroma:Show(args.sourceName)
		specWarnAlluringAroma:Play("kickcast")
	elseif spellId == 238543 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDemonicMending:Show(args.sourceName)
		specWarnDemonicMending:Play("kickcast")
	elseif spellId == 242724 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDreadScream:Show(args.sourceName)
		specWarnDreadScream:Play("kickcast")
	elseif spellId == 242760 then
		specWarnLumberingCrash:Show()
		specWarnLumberingCrash:Play("runout")
	elseif spellId == 239320 then
		specWarnFelblazeOrb:Show()
		specWarnFelblazeOrb:Play("watchorb")
	elseif spellId == 239266 then
		specWarnVenomStorm:Show()
		specWarnVenomStorm:Play("shockwave")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 238688 and args:IsPlayer() then
		specWarnChokingVines:Show()
		specWarnChokingVines:Play("runout")
	elseif spellId == 239161 and self:AntiSpam(4, 1) then
		specWarnTomeSilence:Show()
		specWarnTomeSilence:Play("targetchange")
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 238653 then
		self:SendSync("ShadowWave")
	end
end

function mod:OnSync(msg)
	if msg == "ShadowWave" then
		specWarnShadowWave:Show()
		specWarnShadowWave:Play("shockwave")
	end
end
