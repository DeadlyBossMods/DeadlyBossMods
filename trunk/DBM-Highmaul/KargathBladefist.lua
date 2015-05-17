local mod	= DBM:NewMod(1128, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(78714)
mod:SetEncounterID(1721)
mod:SetZone()
--mod:SetUsedIcons(7)
mod:SetModelSound("sound\\creature\\kargath\\VO_60_HMR_KARGATH_INTRO1.ogg", "sound\\creature\\kargath\\VO_60_HMR_KARGATH_SPELL2.ogg")
mod:SetHotfixNoticeRev(11928)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 159113 159947 158986",
	"SPELL_CAST_SUCCESS 181113",
	"SPELL_AURA_APPLIED 159947 158986 159178 159202 162497",
	"SPELL_AURA_APPLIED_DOSE 159178",
	"SPELL_PERIODIC_DAMAGE 159413 159311",
	"SPELL_ABSORBED 159413 159311"
)

local warnChainHurl					= mod:NewTargetAnnounce(159947, 3)--Warn for cast too?
local warnOpenWounds				= mod:NewStackAnnounce(159178, 2, nil, "Tank|Healer")
local warnPillar					= mod:NewSpellAnnounce("ej9394", 3, nil, 159202)
local warnOnTheHunt					= mod:NewTargetAnnounce(162497, 4)

local specWarnChainHurl				= mod:NewSpecialWarningSpell(159947, nil, nil, nil, nil, 2)
local specWarnBerserkerRushOther	= mod:NewSpecialWarningTarget(158986, nil, nil, nil, 2, 2)
local specWarnBerserkerRush			= mod:NewSpecialWarningMoveTo(158986, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(158986), nil, 3, 2)--Creative use of warning. Run option text but a moveto warning to get players in LFR to actually run to the flame jet instead of being clueless.
local yellBerserkerRush				= mod:NewYell(158986)
local specWarnImpale				= mod:NewSpecialWarningYou(159113)
local specWarnOpenWounds			= mod:NewSpecialWarningStack(159178, nil, 2)
local specWarnOpenWoundsOther		= mod:NewSpecialWarningTaunt(159178)--If it is swap every impale, will move this to impale cast and remove stack stuff all together.
local specWarnMaulingBrew			= mod:NewSpecialWarningMove(159413)
local specWarnFlameJet				= mod:NewSpecialWarningMove(159311)
local specWarnOnTheHunt				= mod:NewSpecialWarningMoveTo(162497, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run:format(162497), nil, nil, 2)--Does not need yell, tigers don't cleave other targets like berserker rush does.

local timerPillarCD					= mod:NewNextTimer(20, "ej9394", nil, nil, nil, 159202)
local timerChainHurlCD				= mod:NewNextTimer(106, 159947)--177776
local timerSweeperCD				= mod:NewTimer(55, "timerSweeperCD", 177258)
local timerBerserkerRushCD			= mod:NewCDTimer(45, 158986)--45 to 70 variation. Small indication that you can use a sequence to get it a little more accurate but even then it's variable. Pull1: 48, 60, 46, 70, 45, 51, 46, 70. Pull2: 48, 60, 50, 55, 45. Mythic pull1, 48, 50, 57, 49
local timerImpaleCD					= mod:NewCDTimer(43.5, 159113, nil, "Tank|Healer")--Highly variable now, seems better adjusted for berserker rush interaction
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerTigerCD					= mod:NewNextTimer(110, "ej9396", nil, "-Tank", nil, 162497)

local countdownChainHurl			= mod:NewCountdown(106, 159947)
local countdownSweeper				= mod:NewCountdown(55, 177776, nil, mod.localization.options.countdownSweeper)
local countdownTiger				= mod:NewCountdown("Alt110", "ej9396", "-Tank")--Tigers never bother tanks so not tanks probelm
local countdownImpale				= mod:NewCountdown("Alt45", 159113, "Tank")--Slightly veriable based on other spells

local voiceImpale					= mod:NewVoice(159113)
local voiceBerserkerRush			= mod:NewVoice(158986)
local voiceChainHurl				= mod:NewVoice(159947)
local voiceOnTheHunt				= mod:NewVoice(162497)
local voicePillar					= mod:NewVoice("ej9394", "Ranged")

mod:AddRangeFrameOption(4, 159386)

local firePillar = EJ_GetSectionInfo(9394)
local chainName = GetSpellInfo(159947)

local function checkHurl()
	if not UnitDebuff("player", chainName) then
		voiceChainHurl:Play("otherout")
	end
end

function mod:BerserkerRushTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(3, targetname) then
		if targetname == UnitName("player") then
			specWarnBerserkerRush:Show(firePillar)
			yellBerserkerRush:Yell()
			voiceBerserkerRush:Play("159202f") --find the pillar
		else
			specWarnBerserkerRushOther:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	timerPillarCD:Start(24-delay)
	timerImpaleCD:Start(35-delay)
	countdownImpale:Start(35-delay)
	timerBerserkerRushCD:Start(48-delay)
	timerChainHurlCD:Start(91-delay)
	countdownChainHurl:Start(91-delay)
	if self.Options.RangeFrame and not self:IsLFR() then
		DBM.RangeCheck:Show(4)--For Mauling Brew splash damage.
	end
	if self:IsMythic() then
		timerTigerCD:Start()
		countdownTiger:Start()
	end
	voiceChainHurl:Schedule(84.5-delay, "159947r") --ready for hurl
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 159113 then
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnImpale:Show()
		end
		timerImpaleCD:Start()
		countdownImpale:Start()
		if self:IsHealer() then
			voiceImpale:Play("tankheal")
		end
	elseif spellId == 159947 then
		specWarnChainHurl:Show()
		timerChainHurlCD:Start()
		countdownChainHurl:Start()
		voiceChainHurl:Schedule(99.5, "159947r") --ready for hurl
	elseif spellId == 158986 then
		timerBerserkerRushCD:Start()
		self:BossTargetScanner(78714, "BerserkerRushTarget", 0.05, 10)
		voiceBerserkerRush:Play("chargemove")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 159947 then
		warnChainHurl:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			timerSweeperCD:Start()
			countdownSweeper:Start()--TODO,scan for punted or whatever knockdown is and cancel.
			voiceChainHurl:Play("159947y") --you are the target
		else
			if self:AntiSpam(2, 2) then
				self:Schedule(0.5, checkHurl)
			end
		end
	elseif spellId == 158986 and self:AntiSpam(3, args.destName) then
		if args:IsPlayer() then
			specWarnBerserkerRush:Show(firePillar)
			yellBerserkerRush:Yell()
			voiceBerserkerRush:Play("159202f") --find the pillar
		else
			specWarnBerserkerRushOther:Show(args.destName)
		end
	elseif spellId == 159178 then
		local amount = args.amount or 1
		if amount >= 2 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnOpenWounds:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(159178)) and not UnitIsDeadOrGhost("player") then
					specWarnOpenWoundsOther:Show(args.destName)
				else
					warnOpenWounds:Show(args.destName, amount)
				end
			end
		else
			warnOpenWounds:Show(args.destName, amount)
		end
	elseif spellId == 159202 then
		warnPillar:Show()
		timerPillarCD:Start()
		voicePillar:Play("159202") --pillar
	elseif spellId == 162497 then
		warnOnTheHunt:Show(args.destName)
		if args:IsPlayer() then
			specWarnOnTheHunt:Show(firePillar)
			voiceOnTheHunt:Play("159202f") --find the pillar
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181113 then--Encounter Spawn
		timerTigerCD:Start()
		countdownTiger:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 159413 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMaulingBrew:Show()
	elseif spellId == 159311 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnFlameJet:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
