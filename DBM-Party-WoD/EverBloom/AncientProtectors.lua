local mod	= DBM:NewMod(1207, "DBM-Party-WoD", 5, 556)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(83894, 83892, 83893)--Dulhu 83894, Gola 83892, Telu
mod:SetEncounterID(1757)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 168082 168041 168105 168383 175997",
	"SPELL_CAST_SUCCESS 168375",
	"SPELL_AURA_APPLIED 168105 168041 168520",
	"SPELL_AURA_REMOVED 168520",
	"SPELL_PERIODIC_DAMAGE 167977",
	"SPELL_ABSORBED 167977",
	"UNIT_DIED"
)

mod:SetBossHealthInfo(83894, 83892, 83893)

--Timers are too difficult to do, rapidTides messes up any chance of ever having decent timers.
local warnRevitalizingWaters		= mod:NewSpellAnnounce(168082, 4)
local warnBriarskin					= mod:NewTargetAnnounce("OptionVersion2", 168041, 3, nil, "MagicDispeller")
local warnRapidTides				= mod:NewTargetAnnounce(168105, 4)
local warnGraspingVine				= mod:NewTargetAnnounce(168375, 2)
local warnSlash						= mod:NewSpellAnnounce("OptionVersion3", 168383, 3)
local warnNoxious					= mod:NewSpellAnnounce("OptionVersion2", 175997, 3)
local warnShapersFortitude			= mod:NewTargetAnnounce(168520, 3)

local specWarnRevitalizingWaters	= mod:NewSpecialWarningInterrupt(168082, "-Healer")
local specWarnBriarskin				= mod:NewSpecialWarningInterrupt(168041, false)--if you have more than one interruptor, great. but off by default because we can't assume you can interrupt every bosses abilities. and heal takes priority
local specWarnBriarskinDispel		= mod:NewSpecialWarningDispel(168041, false)--Not as important as rapid Tides and to assume you have at least two dispellers is big assumption
local specWarnRapidTidesDispel		= mod:NewSpecialWarningDispel(168105, "MagicDispeller", nil, nil, 3)
local specWarnSlash					= mod:NewSpecialWarningSpell(168383)
local specWarnNoxious				= mod:NewSpecialWarningRun(175997, nil, nil, 2, 4)
local specWarnBramble				= mod:NewSpecialWarningMove(167977)

local timerShapersFortitude			= mod:NewTargetTimer("OptionVersion2", 15, 168520, nil, false)
local timerNoxiousCD				= mod:NewCDTimer(16, 175997, nil, "Melee")
local timerGraspingVineCD			= mod:NewNextTimer(31.5, 168375)

local voiceRevitalizingWaters		= mod:NewVoice(168082, "-Healer")
local voiceNoxious					= mod:NewVoice(175997, "Melee")
local voiceRapidTides				= mod:NewVoice(168105, "MagicDispeller")
local voiceBramble					= mod:NewVoice(167977)

function mod:GraspingVineTarget(targetname, uId)
	if not targetname then return end
	warnGraspingVine:Show(targetname)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 168082 then
		warnRevitalizingWaters:Show()
		specWarnRevitalizingWaters:Show(args.sourceName)
		if self:IsTank() then
			voiceRevitalizingWaters:Play("kickcast")
		else
			voiceRevitalizingWaters:Play("helpkick")
		end
	elseif spellId == 168041 then
		specWarnBriarskin:Show(args.sourceName)
	elseif spellId == 168383 then
		warnSlash:Show()
		specWarnSlash:Show()
	elseif spellId == 175997 then
		warnNoxious:Show()
		specWarnNoxious:Show()
		timerNoxiousCD:Start()
		voiceNoxious:Play("watchstep")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 168375 then
		self:BossTargetScanner(83894, "GraspingVineTarget", 0.05, 10)
		timerGraspingVineCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 168105 then
		warnRapidTides:Show(args.destName)
		specWarnRapidTidesDispel:Show(args.destName)
		voiceRapidTides:Play("dispelboss")
	elseif spellId == 168041 then
		warnBriarskin:Show(args.destName)
		specWarnBriarskinDispel:Show(args.destName)
	elseif spellId == 168520 then
		warnShapersFortitude:Show(args.destName)
		timerShapersFortitude:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 168520 then
		timerShapersFortitude:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 167977 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBramble:Show()
		voiceBramble:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 83894 then
		timerNoxiousCD:Cancel()
	end
end
