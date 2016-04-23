local mod	= DBM:NewMod(1713, "DBM-Nighthold", nil, 786)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(101002)----TODO, verify (103769)
mod:SetEncounterID(1842)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 205368 205370 205420 209017 206352",
	"SPELL_CAST_SUCCESS 206677 205361",
	"SPELL_AURA_APPLIED 206677 205344",
	"SPELL_AURA_REMOVED 205344",
	"SPELL_SUMMON 206350",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"UNIT_DIED"
)

--TODO, range frame for tank affected by Fel Brand?
--TODO, voice for fel beam when I have a clue how it works.
--TODO, auto assign soakers for burning pitch, depending on complicity of it?
--TODO, voices for burning pitch with more data on strats
--TODO, interrupt helper (counter, timers etc) for felburst/blast?
local warnExpelOrbDestro			= mod:NewTargetAnnounce(205344, 4)
local warnBurningEmber				= mod:NewSpellAnnounce("ej12914", 3, 205420, "Dps")

local specWarnFelBrand				= mod:NewSpecialWarningRun(206677, nil, nil, nil, 4, 2)
local yellFelBrand					= mod:NewYell(206677)
local specWarnFelBrandOther			= mod:NewSpecialWarningTaunt(206677, nil, nil, nil, 1, 2)
local specWarnFelBeam				= mod:NewSpecialWarningSpell(205368, nil, nil, nil, 2, 2)
local specWarnOrbDestro				= mod:NewSpecialWarningMoveAway(205344, nil, nil, nil, 3, 2)
local yellOrbDestro					= mod:NewFadesYell(205344)
local specWarnBurningPitch			= mod:NewSpecialWarningSpell(205420, nil, nil, nil, 2)
local specWarnFelBlast				= mod:NewSpecialWarningInterrupt(209017, "HasInterrupt", nil, nil, 1, 2)
local specWarnFelBurst				= mod:NewSpecialWarningInterrupt(206352, "HasInterrupt", nil, nil, 1, 2)

local timerFelBrand					= mod:NewTargetTimer(16, 206677, nil, "Tank", nil, 5)
local timerFelBrandCD				= mod:NewAITimer(16, 206677, nil, "Tank", nil, 5)
local timerFelBeamCD				= mod:NewAITimer(16, 205368, nil, nil, nil, 3)--Targeted color?
local timerOrbDestroCD				= mod:NewAITimer(16, 205344, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)--Not that deadly on non mythic but on mythic it is
local timerBurningPitchCD			= mod:NewAITimer(16, 205420, nil, "-Tank", nil, 5)

local countdownOrbDestro			= mod:NewCountdownFades("AltTwo5", 205344)

local voiceFelBrand					= mod:NewVoice(206677)--runout/tauntboss
local voiceOrbDestro				= mod:NewVoice(205344)--runout
local voiceFelBlast					= mod:NewVoice(209017, "HasInterrupt")--kickcast
local voiceFelBurst					= mod:NewVoice(206352, "HasInterrupt")--kickcast

mod:AddRangeFrameOption(5, 206352)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)
mod:AddInfoFrameOption(215944, false)

local burningPitchDebuff = GetSpellInfo(215944)
mod.vb.burningEmbers = 0

function mod:OnCombatStart(delay)
	self.vb.burningEmbers = 0
	timerFelBrandCD:Start(1-delay)
	timerFelBeamCD:Start(1-delay)
	timerOrbDestroCD:Start(1-delay)
	timerBurningPitchCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(burningPitchDebuff)
		DBM.InfoFrame:Show(5, "reverseplayerbaddebuff", burningPitchDebuff)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 205368 or spellId == 205370 then--2 spell IDs?
		specWarnFelBeam:Show()
		timerFelBeamCD:Start()
	elseif spellId == 205420 then
		--Do fancy auto assigning stuff here? or perhaps at very least only warn players not affected by debuff?
		specWarnBurningPitch:Show()
		timerBurningPitchCD:Start()
	elseif spellId == 209017 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFelBlast:Show(args.sourceName)
		voiceFelBlast:Play("kickcast")
	elseif spellId == 206352 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnFelBurst:Show(args.sourceName)
		voiceFelBurst:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 206677 then
		timerFelBrandCD:Start()
	elseif spellId == 205361 then
		timerOrbDestroCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 206677 then
		timerFelBrand:Start(args.destName)
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnFelBrand:Show()
			voiceFelBrand:Play("runout")
			yellFelBrand:Yell()
--			if self.Options.RangeFrame then
--				DBM.RangeCheck:Show(5)
--			end
		else
			specWarnFelBrandOther:Show(args.destName)
			voiceFelBrand:Play("tauntboss")
		end
	elseif spellId == 205344 then
		warnExpelOrbDestro:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then--Still do yell and range frame here, in case DK
			specWarnOrbDestro:Show()
			voiceOrbDestro:Play("runout")
			yellOrbDestro:Yell(5)
			yellOrbDestro:Schedule(4, 1)
			yellOrbDestro:Schedule(3, 2)
			yellOrbDestro:Schedule(2, 3)
			countdownOrbDestro:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 205344 then
		if args:IsPlayer() then
			yellOrbDestro:Cancel()
			countdownOrbDestro:Cancel()
		end
--	elseif spellId == 215944 then--Burning Pitch
		
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 206350 then
		self.vb.burningEmbers = self.vb.burningEmbers + 1
		if self:AntiSpam(3, 1) then
			warnBurningEmber:Show()
		end
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 104262 then--Burning Ember
		self.vb.burningEmbers = self.vb.burningEmbers - 1
		if self.Options.RangeFrame and self.vb.burningEmbers == 0 then
			DBM.RangeCheck:Hide()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
