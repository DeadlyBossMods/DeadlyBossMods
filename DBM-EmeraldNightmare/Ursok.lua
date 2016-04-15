local mod	= DBM:NewMod(1667, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(100497)
mod:SetEncounterID(1841)
mod:SetZone()
mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(12324)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 197942 197969",
	"SPELL_CAST_SUCCESS 197943",
	"SPELL_AURA_APPLIED 198006 197943",
	"SPELL_AURA_REMOVED 198006",
	"SPELL_PERIODIC_DAMAGE 205611",
	"SPELL_PERIODIC_MISSED 205611"
)

--TODO, info frame for unbalanced maybe, depends on how fast raid gets it (unbalanced can't soak charges)
--TODO, countdown yell maybe for focused gaze. Arrow or goto warnings system too, maybe. Hud as well
--TODO, find a good voice for roaring. Maybe watch step? move away?
--TODO, figure out a good number to repeat for charge count
local warnFocusedGaze				= mod:NewTargetAnnounce(198006, 3)
local warnBloodFrenzy				= mod:NewSpellAnnounce(198388, 4)

local specWarnFocusedGaze			= mod:NewSpecialWarningYou(198006, nil, nil, nil, 1, 6)
local yellFocusedGaze				= mod:NewYell(198006)
local specWarnRoaringCacophony		= mod:NewSpecialWarningCount(197969, nil, nil, nil, 2)--Don't know what voice to give it yet, i'll figure it out.
local specWarnMiasma				= mod:NewSpecialWarningMove(205611, nil, nil, nil, 1, 2)
local specWarnOverwhelm				= mod:NewSpecialWarningTaunt(197943, "Tank", nil, nil, 1, 2)

local timerFocusedGazeCD			= mod:NewNextTimer(40, 198006, nil, nil, nil, 3)
local timerRendFleshCD				= mod:NewNextTimer(20, 197942, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerOverwhelmCD				= mod:NewNextTimer(10, 197943, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRoaringCacophonyCD		= mod:NewNextCountTimer(30, 197969, nil, nil, nil, 2)

local berserkTimer					= mod:NewBerserkTimer(300)

--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)

local voiceFocusedGaze				= mod:NewVoice(198006, "-Tank")--targetyou/share
local voiceOverwhelm				= mod:NewVoice(197943)--Tauntboss/changemt
local voiceMiasma					= mod:NewVoice(205611)--runaway
local voiceBloodFrenzy				= mod:NewVoice(198388)
--local voiceRoaringCacophony			= mod:NewVoice(197969)--watchstep

mod:AddSetIconOption("SetIconOnCharge", 198006, true)
mod:AddHudMapOption("HudMapOnCharge", 198006)
mod:AddInfoFrameOption(198108, false)

mod.vb.roarCount = 0
mod.vb.chargeCount = 0

function mod:OnCombatStart(delay)
	self.vb.roarCount = 0
	self.vb.chargeCount = 0
	timerOverwhelmCD:Start(-delay)
	timerRendFleshCD:Start(13-delay)
	timerFocusedGazeCD:Start(19-delay)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(198108))
		DBM.InfoFrame:Show(5, "reverseplayerbaddebuff", 198108)
	end
end

function mod:OnCombatEnd()
	if self.Options.HudMapOnCharge then
		DBMHudMap:Disable()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 197942 then
		timerRendFleshCD:Start()
	elseif spellId == 197969 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnRoaringCacophony:Show(self.vb.roarCount)
		--voiceRoaringCacophony:Play("watchstep")
		if self.vb.roarCount % 2 == 0 then
			timerRoaringCacophonyCD:Start(30, self.vb.roarCount + 1)
		else
			timerRoaringCacophonyCD:Start(10, self.vb.roarCount + 1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197943 then
		timerOverwhelmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 198006 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		warnFocusedGaze:Show(args.destName)
		timerFocusedGazeCD:Start()
		if args:IsPlayer() then
			specWarnFocusedGaze:Show()
			yellFocusedGaze:Yell()
			voiceFocusedGaze:Play("targetyou")
		--This code still needs unbalanced check so it doesn't warn player with debuff to soak
		elseif ( self.vb.chargeCount % 2) then
			voiceFocusedGaze:Play("shareone")
		else
			voiceFocusedGaze:Play("sharetwo")	
		--This code still needs unbalanced check so it doesn't warn player with debuff to soak
		end
		if self.Options.SetIconOnCharge then
			self:SetIcon(args.destName, 1)
		end
		if self.Options.HudMapOnCharge then
			if args:IsPlayer() then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 8, nil, nil, nil, 0.5):Appear():SetLabel(args.destName)
			else
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 8, nil, nil, nil, 0.5):Appear():RegisterForAlerts(nil, args.destName)
			end
		end
	elseif spellId == 197943 then
		if not args:IsPlayer() then
			specWarnOverwhelm:Show(args.destName)
			voiceOverwhelm:Play("tauntboss")
		else
			voiceOverwhelm:Play("changemt")
		end
	elseif spellId == 198388 then
		warnBloodFrenzy:Show()
		voiceBloodFrenzy:Play("frenzy")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 198006 then
		if self.Options.SetIconOnCharge then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.HudMapOnCharge then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMiasma:Show()
		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
