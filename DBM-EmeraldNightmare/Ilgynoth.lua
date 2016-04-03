local mod	= DBM:NewMod(1738, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(105393)
mod:SetEncounterID(1873)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 210931 209471 208697 208929 208689 210781 208685",
	"SPELL_CAST_SUCCESS 210984 215128",
	"SPELL_AURA_APPLIED 209915 210099 210984 215234 215128",
	"SPELL_AURA_APPLIED_DOSE 210984",
	"SPELL_AURA_REMOVED 209915 215128",
	"SPELL_PERIODIC_DAMAGE 212886",
	"SPELL_PERIODIC_MISSED 212886",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, figure out how often deathglare is cast to determine swap count for tanks
--TODO, target scan ground slam if possible.
--TODO, figure out more add spawn triggers
--TODO, figure out voice to use for specWarnHeartPhaseBegin
--TODO, determine if filter is needed, like archimonde to filter events from those that are in heart from those that are not.
--Stage One: The Ruined Ground
local warnNightmareGaze				= mod:NewSpellAnnounce(210931, 3, nil, false)--Something tells me this is just something it spam casts
local warnFixate					= mod:NewTargetAnnounce(210099, 2)--If spammy change defaults
local warnNightmareExplosion		= mod:NewCastAnnounce(209471, 3)
local warnDeathglare				= mod:NewStackAnnounce(210984, 2, nil, "Tank")
local warnSpewCorruption			= mod:NewTargetAnnounce(208929, 3)
local warnGroundSlam				= mod:NewSpellAnnounce(208689, 2)--Figure this out later
--
local warnCursedBlood				= mod:NewTargetAnnounce(215128, 3)

--Stage One: The Ruined Ground
local specWarnNightmareCorruption	= mod:NewSpecialWarningMove(212886, nil, nil, nil, 1, 2)
local specWarnFixate				= mod:NewSpecialWarningMoveTo(210099, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(210099), nil, 1, 2)
local specWarnNightmareHorror		= mod:NewSpecialWarningSwitch("ej13188", "-Healer", nil, nil, 1, 2)--spellId for summon 210289
local specWarnDeathglare			= mod:NewSpecialWarningStack(210984, nil, 2)
local specWarnDeathglareOther		= mod:NewSpecialWarningTaunt(210984, nil, nil, nil, 1, 2)
local specWarnMindFlay				= mod:NewSpecialWarningInterrupt(208697, nil, nil, nil, 1, 2)
local specWarnSpewCorruption		= mod:NewSpecialWarningRun(208929, nil, nil, nil, 4, 2)
local yellSpewCorruption			= mod:NewYell(208929)
local specWarnNightmarishFury		= mod:NewSpecialWarningSpell(215234, "Tank", nil, nil, 3, 2)
local specWarnDominatorTentacle		= mod:NewSpecialWarningSwitch("ej13189", "Tank")
--Stage Two: The Heart of Corruption
local specWarnHeartPhaseBegin		= mod:NewSpecialWarningFades(209915, nil, nil, nil, 1)
local specWarnCursedBlood			= mod:NewSpecialWarningMoveAway(215128, nil, nil, nil, 1, 2)
local yellCursedBlood				= mod:NewFadesYell(215128)

--Stage One: The Ruined Ground
local timerNightmareHorrorCD		= mod:NewAITimer(16, "ej13188", nil, nil, nil, 1, 210289)
local timerDeathglareCD				= mod:NewAITimer(16, 210984, nil, "Tank", nil, 5)
local timerNightmareishFuryCD		= mod:NewAITimer(16, 215234, nil, "Tank", nil, 5)
--Stage Two: The Heart of Corruption
local timerDarkReconstitution		= mod:NewCastTimer(50, 210781, nil, nil, nil, 6, nil, DBM_CORE_DEADLY_ICON)
local timerCursedBloodCD			= mod:NewAITimer(16, 215128, nil, nil, nil, 3)

--Stage Two: The Heart of Corruption
local countdownDarkRecon			= mod:NewCountdown("Alt50", 210781)

--Stage One: The Ruined Ground
local voiceNightmareCorruption		= mod:NewVoice(212886)--runaway
local voiceFixate					= mod:NewVoice(210099)--targetyou
local voiceNightmareHorror			= mod:NewVoice("ej13188", "-Healer")--bigmob
local voiceDeathGlare				= mod:NewVoice(210984)--changemt
local voiceMindFlay					= mod:NewVoice(208697)--kickcast
local voiceSpewCorruption			= mod:NewVoice(208929)--runout
local voiceNightmarishFury			= mod:NewVoice(210984)--defensive

mod:AddRangeFrameOption(8, 215128)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local eyeName = EJ_GetSectionInfo(13185)

function mod:SpewCorruptionTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnSpewCorruption:Show()
		voiceSpewCorruption:Play("runout")
		yellSpewCorruption:Yell()
	else
		warnSpewCorruption:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerNightmareHorrorCD:Start(1)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 210931 then
		warnNightmareGaze:Show()
	elseif spellId == 209471 then
		warnNightmareExplosion:Show()
	elseif spellId == 208697 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnMindFlay:Show(args.sourceName)
		voiceMindFlay:Play("kickcast")
	elseif spellId == 208929 then
		self:BossTargetScanner(args.sourceGUID, "SpewCorruptionTarget", 0.2, 16)
	elseif spellId == 208689 then
		warnGroundSlam:Show()
	elseif spellId == 210781 then--Dark Reconstitution
		timerCursedBloodCD:Start(1)
		timerDarkReconstitution:Start()
		countdownDarkRecon:Start()
	elseif spellId == 208685 and self:AntiSpam(4, 2) then--Rupturing roar (Untanked tentacle)
		specWarnDominatorTentacle:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 210984 then
		timerDeathglareCD:Start(nil, args.sourceGUID)
	elseif spellId == 215128 then
		timerCursedBloodCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 209915 then--Stuff of Nightmares
		--Assumed can be used for tracking
		timerCursedBloodCD:Stop()
	elseif spellId == 210099 then--Ooze Fixate
		if args:IsPlayer() then
			specWarnFixate:Show(eyeName)
			voiceFixate:Play("targetyou")
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 210984 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnDeathglare:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnDeathglareOther:Show(args.destName)
					voiceDeathGlare:Play("changemt")
				else
					warnDeathglare:Show(args.destName, amount)
				end
			end
		else
			warnDeathglare:Show(args.destName, amount)
		end
	elseif spellId == 215234 then
		timerNightmareishFuryCD:Start(nil, args.sourceGUID)
		--Hopefully this has a boss unitID
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnNightmarishFury:Show()
				voiceNightmarishFury:Play("defensive")
				break
			end
		end
	elseif spellId == 215128 then
		warnCursedBlood:CombinedShow(0.5, args.destName)--Multi target assumed
		if args:IsPlayer() then
			specWarnCursedBlood:Show()
			yellCursedBlood:Schedule(7, 1)
			yellCursedBlood:Schedule(6, 2)
			yellCursedBlood:Schedule(5, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 209915 then--Stuff of Nightmares
		specWarnHeartPhaseBegin:Show()
	elseif spellId == 215128 and args:IsPlayer() then
		yellCursedBlood:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 212886 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnNightmareCorruption:Show()
		voiceNightmareCorruption:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 105591 then--Nightmare Horror
		timerDeathglareCD:Stop(args.destGUID)
	elseif cid == 105304 then--Dominator Tentacle
		timerNightmareishFuryCD:stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 210289 then
		specWarnNightmareHorror:Show()
		voiceNightmareHorror:Play("bigmob")
		timerNightmareHorrorCD:Start()
	end
end

--[[
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
