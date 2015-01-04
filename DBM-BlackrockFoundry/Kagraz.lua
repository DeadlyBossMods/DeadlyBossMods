local mod	= DBM:NewMod(1123, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76814)--76794 Cinder Wolf, 80590 Aknor Steelbringer
mod:SetEncounterID(1689)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156018 156040 155382 155064",
	"SPELL_CAST_SUCCESS 155776 155074",
	"SPELL_AURA_APPLIED 155277 155493 154952 163284 155074 154932 154950",
	"SPELL_AURA_APPLIED_DOSE 163284 155074",
	"SPELL_AURA_REMOVED 155277 154932 154950 154952",
	"SPELL_PERIODIC_DAMAGE 155314",
	"SPELL_PERIODIC_MISSED 155314",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
--Who is this dude?
local warnDevastatingSlam				= mod:NewSpellAnnounce(156018, 4)
local warnDropHammer					= mod:NewSpellAnnounce(156040, 3)--Target scanning?

local warnLavaSlash						= mod:NewSpellAnnounce(155318, 2, nil, false)--Likely cast often & doesn't show in combat log anyways except for damage and not THAT important
local warnSummonEnchantedArmaments		= mod:NewSpellAnnounce(156724, 3)
local warnMoltenTorrent					= mod:NewTargetAnnounce(154932, 3)
local warnSummonCinderWolves			= mod:NewSpellAnnounce(155776, 3)--Cast trigger could be anything, undefined on wowhead. just "Channeled" which I've seen use START, SUCCESS and even APPLIED. sigh
local warnOverheated					= mod:NewTargetAnnounce(154950, 3, nil, mod:IsTank())
local warnRekindle						= mod:NewCastAnnounce(155064, 4)
local warnFixate						= mod:NewTargetAnnounce(154952, 3)
local warnFireStorm						= mod:NewSpellAnnounce(155493, 4, nil, mod:IsTank())
local warnBlazingRadiance				= mod:NewTargetAnnounce(155277, 3)
local warnFireStorm						= mod:NewSpellAnnounce(155493, 4)
local warnRisingFlames					= mod:NewStackAnnounce(163284, 2, nil, mod:IsTank())
local warnCharringBreath				= mod:NewStackAnnounce(155074, 2, nil, mod:IsTank())

local specWarnLavaSlash					= mod:NewSpecialWarningMove(155318)
local specWarnMoltenTorrent				= mod:NewSpecialWarningYou(154932, nil, nil, nil, nil, nil, true)
local specWarnMoltenTorrentOther		= mod:NewSpecialWarningMoveTo(154932, false)--Strat dependant. most strats i saw ran these into meleee instead of running to the meteor target.
local yellMoltenTorrent					= mod:NewYell(154932)
local specWarnCinderWolves				= mod:NewSpecialWarningSwitch(155776, not mod:IsHealer(), nil, nil, nil, nil, true)
local specWarnOverheated				= mod:NewSpecialWarningSwitch(154950, mod:IsTank())
local specWarnFixate					= mod:NewSpecialWarningYou(154952, nil, nil, nil, 3, nil, true)
local specWarnFixateEnded				= mod:NewSpecialWarningEnd(154952, false)
local specWarnBlazinRadiance			= mod:NewSpecialWarningMoveAway(155277, nil, nil, nil, nil, nil, true)
local yellBlazinRadiance				= mod:NewYell(155277, nil, false)
local specWarnFireStorm					= mod:NewSpecialWarningSpell(155493, nil, nil, nil, 2, nil, true)
local specWarnRisingFlames				= mod:NewSpecialWarningStack(163284, nil, 10)--stack guessed
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(163284, nil, nil, nil, nil, nil, true)
local specWarnCharringBreath			= mod:NewSpecialWarningStack(155074, nil, 3)--Assumed based on timing and casts, that you swap every breath.
local specWarnCharringBreathOther		= mod:NewSpecialWarningTaunt(155074)
--

local timerLavaSlashCD					= mod:NewCDTimer(14.5, 155318, nil, false)
local timerMoltenTorrentCD				= mod:NewCDTimer(14, 154932)
local timerSummonEnchantedArmamentsCD	= mod:NewCDTimer(45, 156724)--45-47sec variation
local timerSummonCinderWolvesCD			= mod:NewNextTimer(74, 155776)
local timerOverheated					= mod:NewTargetTimer(14, 154950, nil, mod:IsTank())
local timerCharringBreathCD				= mod:NewNextTimer(5, 155074, nil, mod:IsTank())
local timerFixate						= mod:NewTargetTimer(10, 154952, nil, false)--Spammy, can't combine them beacause of wolves will desync if players die.
local timerBlazingRadianceCD			= mod:NewCDTimer(12, 155277, nil, false)--somewhat important but not important enough. there is just too much going on to be distracted by this timer
local timerFireStormCD					= mod:NewNextTimer(63, 155493)

local countdownCinderWolves				= mod:NewCountdown(74, 155776)
local countdownFireStorm				= mod:NewCountdown(63, 155493)--Same voice as wolves cause never happen at same time, in fact they alternate.
local countdownEnchantedArmaments		= mod:NewCountdown("Alt45", 156724, mod:IsRanged())
local countdownOverheated				= mod:NewCountdownFades("Alt20", 154950, mod:IsTank())

local voiceMoltenTorrent				= mod:NewVoice(154932) --runin
local voiceFixate						= mod:NewVoice(154952) --justrun
local voiceCinderWolves					= mod:NewVoice(155776, not mod:IsHealer()) --killmob
local voiceBlazinRadiance				= mod:NewVoice(155277)  --runaway (scatter if we have power system)
local voiceRisingFlames					= mod:NewVoice(163284, mod:IsTank())  --changemt
local voiceFireStorm					= mod:NewVoice(155493) --aoe

mod:AddRangeFrameOption("10/6")
mod:AddArrowOption("TorrentArrow", 154932, false, true)

function mod:OnCombatStart(delay)
	timerLavaSlashCD:Start(11-delay)
	timerMoltenTorrentCD:Start(30-delay)
	timerSummonCinderWolvesCD:Start(60-delay)
	countdownCinderWolves:Start(60-delay)
	if self.Options.RangeFrame and self:IsRanged() then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.TorrentArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156018 then
		warnDevastatingSlam:Show()
	elseif spellId == 156040 then
		warnDropHammer:Show()
	elseif spellId == 155382 then
		timerBlazingRadianceCD:Start()
	elseif spellId == 155064 then
		warnRekindle:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155776 then
		warnSummonCinderWolves:Show()
		specWarnCinderWolves:Show()
		timerBlazingRadianceCD:Start(34)
		timerFireStormCD:Start()
		countdownFireStorm:Start()
		voiceCinderWolves:Play("killmob")
	elseif spellId == 155074 then
		timerCharringBreathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155277 then
		warnBlazingRadiance:CombinedShow(0.5, args.destName)--Assume it can affect more than one target
		if args:IsPlayer() then
			specWarnBlazinRadiance:Show()
			yellBlazinRadiance:Yell()
			voiceBlazinRadiance:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 155493 then
		warnFireStorm:Show()
		specWarnFireStorm:Show()
		timerBlazingRadianceCD:Cancel()
		timerMoltenTorrentCD:Start(44)
		timerSummonCinderWolvesCD:Start()
		countdownCinderWolves:Start()
		voiceFireStorm:Play("aesoon")--maybe gather?
	elseif spellId == 154952 then
		warnFixate:CombinedShow(0.5, args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()--Are these kited? add a run away sound?
			voiceFixate:Play("justrun")
		end
	elseif spellId == 163284 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRisingFlames:Show(args.destName, amount)
		end
		if amount % 3 == 0 and amount >= 10 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRisingFlames:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163284)) and not UnitIsDeadOrGhost("player") then
					specWarnRisingFlamesOther:Show(args.destName)
					voiceRisingFlames:Play("changemt")
				end
			end
		end
	elseif spellId == 155074 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") or self:IsTanking(uId, "boss3") or self:IsTanking(uId, "boss4") or self:IsTanking(uId, "boss5") then
			local amount = args.amount or 1
			warnCharringBreath:Show(args.destName, amount)
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnCharringBreath:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitDebuff("player", GetSpellInfo(155074)) and not UnitIsDeadOrGhost("player") then
						specWarnCharringBreathOther:Show(args.destName)
					end
				end
			end
		end
	elseif spellId == 154932 then
		warnMoltenTorrent:Show(args.destName)
		timerMoltenTorrentCD:Start()
		if args:IsPlayer() then
			specWarnMoltenTorrent:Show()
			yellMoltenTorrent:Yell()
			voiceMoltenTorrent:Play("runin")
		else
			specWarnMoltenTorrentOther:Show(args.destName)
			if self.Options.TorrentArrow then
				DBM.Arrow:ShowRunTo(args.destName, 3, 3, 5)
			end
		end
	elseif spellId == 154950 then
		warnOverheated:Show(args.destName)
		specWarnOverheated:Show()
		timerOverheated:Start(args.destName)
		timerCharringBreathCD:Start()
		countdownOverheated:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155277 and args:IsPlayer() then
		specWarnBlazinRadiance:Show()
		if self.Options.RangeFrame then
			if self:IsRanged() then
				DBM.RangeCheck:Show(6)
			else
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 154932 and self.Options.TorrentArrow then
		DBM.Arrow:Hide()
	elseif spellId == 154950 then
		timerOverheated:Cancel(args.destName)
		countdownOverheated:Cancel()
	elseif spellId == 154952 then
		timerFixate:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnFixateEnded:Show()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 155314 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnLavaSlash:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 163644 then
		warnSummonEnchantedArmaments:Show()
		if self:IsMythic() then
			timerSummonEnchantedArmamentsCD:Start(20)
			countdownEnchantedArmaments:Start(20)
		else
			timerSummonEnchantedArmamentsCD:Start()
			countdownEnchantedArmaments:Start()
		end
	elseif spellId == 154914 then
		warnLavaSlash:Show()
		timerLavaSlashCD:Start()
	end
end
