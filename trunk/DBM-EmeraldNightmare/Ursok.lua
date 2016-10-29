local mod	= DBM:NewMod(1667, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(100497)
mod:SetEncounterID(1841)
mod:SetZone()
mod:SetUsedIcons(6, 4)
mod:SetHotfixNoticeRev(15348)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 197942 197969",
	"SPELL_CAST_SUCCESS 197943",
	"SPELL_AURA_APPLIED 198006 197943 205611 204859",
	"SPELL_AURA_APPLIED_DOSE 197943",
	"SPELL_AURA_REMOVED 198006",
	"SPELL_DAMAGE 205611",
	"SPELL_MISSED 205611"
)

--TODO, find a good voice for roaring. Maybe watch step? move away?
--TODO, multiple auto assignments. Assign by group regardless of debuff status. Assign by smart mode (current default). Maybe other options?
--(ability.id = 197942 or ability.id = 197969) and type = "begincast" or ability.id = 197943 and type = "cast" or ability.id = 198006 and type = "applydebuff"
--(ability.id = 197969) and type = "begincast"
local warnFocusedGaze				= mod:NewTargetCountAnnounce(198006, 3)
local warnBloodFrenzy				= mod:NewSpellAnnounce(198388, 4)
local warnOverwhelm					= mod:NewStackAnnounce(197943, 2, nil, "Tank|Healer")

local specWarnFocusedGaze			= mod:NewSpecialWarningYou(198006, nil, nil, nil, 1, 2)
local specWarnFocusedGazeOther		= mod:NewSpecialWarningMoveTo(198006, nil, nil, nil, 1, 6)
local yellFocusedGaze				= mod:NewPosYell(198006)
local specWarnRoaringCacophony		= mod:NewSpecialWarningCount(197969, nil, nil, nil, 2, 2)--Don't know what voice to give it yet, aesoon used for now
local specWarnMiasma				= mod:NewSpecialWarningMove(205611, nil, nil, nil, 1, 2)
local specWarnRendFlesh				= mod:NewSpecialWarningDefensive(197942, "Tank", nil, nil, 3, 2)
local specWarnRendFleshOther		= mod:NewSpecialWarningTaunt(197942, nil, nil, nil, 3, 2)
local specWarnOverwhelmOther		= mod:NewSpecialWarningTaunt(197943, nil, nil, nil, 1, 2)

local timerFocusedGazeCD			= mod:NewNextCountTimer(40, 198006, nil, nil, nil, 3)
local timerRendFleshCD				= mod:NewNextCountTimer(20, 197942, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerOverwhelmCD				= mod:NewNextTimer(10, 197943, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerRoaringCacophonyCD		= mod:NewNextCountTimer(30, 197969, nil, nil, nil, 2)

local berserkTimer					= mod:NewBerserkTimer(300)

local countdownFocusedGazeCD		= mod:NewCountdown(40, 198006)
local countdownRendFlesh			= mod:NewCountdown("Alt20", 198006, "Tank")
local countdownOverwhelm			= mod:NewCountdown("AltTwo10", 197943, "Tank", nil, 3)
local countdownFocusedGaze			= mod:NewCountdownFades(6, 198006)

local voiceFocusedGaze				= mod:NewVoice(198006, "-Tank")--targetyou/share
local voiceRendFlesh				= mod:NewVoice(197942)--defensive/tauntboss
local voiceOverwhelm				= mod:NewVoice(197943)--tauntboss
local voiceMiasma					= mod:NewVoice(205611)--runaway
local voiceBloodFrenzy				= mod:NewVoice(198388)
local voiceRoaringCacophony			= mod:NewVoice(197969)--aesoon

mod:AddSetIconOption("SetIconOnCharge", 198006, true)
mod:AddHudMapOption("HudMapOnCharge", 198006)
mod:AddInfoFrameOption(198108, false)
mod:AddBoolOption("NoAutoSoaking2", true)

mod.vb.roarCount = 0
mod.vb.chargeCount = 0
mod.vb.tankCount = 2
mod.vb.rendCount = 0

--Doesn't assign a soaker who'll die from it.
--Doesn't assign tanks or the targeted player themselves.
--(Tanks are welcome to help of course but it doesn't assign them because it's difficult to tell which ones are busy, tanks will make that call themselves.
--This of course means auto assigning will fail to assign enough if too many soaked last one by accident
--However, This is smartest way to do it anyways, it'll automatically use two different groups by this logic. It won't assign people who went last time.
--Reasoning: If I simply assign half raid to one and other half to other it doesn't factor in someone that got hit by ome they shouldn't have.
--This way, it'll ensure it assigns enough available soakers when possible, even when names shift groups as fight progresses. (Deaths/battle rezes, boss targetting)
local GenerateSoakAssignment
do
	local soakTable = {}
	local UnitDebuff, UnitIsUnit = UnitDebuff, UnitIsUnit
	local playerName = UnitName("player")
	local unbalancedName, focusedGazeName = GetSpellInfo(198108), GetSpellInfo(198006)
	GenerateSoakAssignment = function(self, count, targetName)
		table.wipe(soakTable)
		local soakers = 0
		local raidCount = DBM:GetNumRealGroupMembers()--Support dynamic raid sizes, or even mythic raids that may be undermanning (8.0 5 manning or something)
		local soakerCount = raidCount - self.vb.tankCount - 1--Subtrack tanks and person with debuff
		local soakerHalf = math.floor(soakerCount/2)--A half a person can't soak so we floor half for odd sized raids
		DBM:Debug("Raid size: "..raidCount..". Soakers: "..soakerCount..". Soaker Half: "..soakerHalf)
		for i = 1, raidCount do
			local unitID = "raid"..i
			if not UnitDebuff(unitID, unbalancedName) and not UnitDebuff(unitID, focusedGazeName) and not self:IsTanking(unitID) then
				soakers = soakers + 1
				soakTable[#soakTable+1] = DBM:GetUnitFullName(unitID)
				if UnitIsUnit("player", unitID) then
					specWarnFocusedGazeOther:Show(targetName)
					if count == 2 then
						voiceFocusedGaze:Play("sharetwo")
						if self.Options.HudMapOnCharge then
							--Blue line
							DBMHudMap:AddEdge(0, 0, 1, 0.5, 6, playerName, targetName, nil, nil, nil, nil, 135)
						end
					else
						if self.Options.HudMapOnCharge then
							--Green line
							DBMHudMap:AddEdge(0, 1, 0, 0.5, 6, playerName, targetName, nil, nil, nil, nil, 135)
						end
						voiceFocusedGaze:Play("shareone")
					end
				end
				if soakers == soakerHalf then break end--Got enough soakers, stop
			end
		end
		if self.Options.SpecWarn198006moveto then
			--if soaker special warning is disabled, this too is disabled.
			DBM:AddMsg(L.SoakersText:format(table.concat(soakTable, "<, >")))
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.roarCount = 0
	self.vb.chargeCount = 0
	self.vb.rendCount = 0
	self.vb.tankCount = self:GetNumAliveTanks() or 2
	timerOverwhelmCD:Start(-delay)
	countdownOverwhelm:Start(-delay)
	timerRendFleshCD:Start(13-delay, 1)
	countdownRendFlesh:Start(13-delay)
	timerFocusedGazeCD:Start(19-delay, 1)
	countdownFocusedGazeCD:Start(19-delay)
	if self:IsMythic() then
		timerRoaringCacophonyCD:Start(18-delay, 1)
	else
		timerRoaringCacophonyCD:Start(37-delay, 1)
	end
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(GetSpellInfo(198108))
		DBM.InfoFrame:Show(15, "reverseplayerbaddebuff", 198108)
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
		self.vb.rendCount = self.vb.rendCount + 1
		timerRendFleshCD:Start(nil, self.vb.rendCount+1)
		countdownRendFlesh:Start()
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then
			specWarnRendFlesh:Show()
			voiceRendFlesh:Play("defensive")
		else
			--Other tank has overwhelm stacks and is about to die to rend flesh, TAUNT NOW!
			if UnitExists("boss1target") and not UnitIsUnit("player", "boss1target") then
				local _, _, _, _, _, _, expireTimeTarget = UnitDebuff("boss1target", GetSpellInfo(197943)) -- Overwhelm
				if expireTimeTarget and expireTimeTarget-GetTime() >= 2 then
					specWarnRendFleshOther:Show(UnitName("boss1target"))
					voiceRendFlesh:Play("tauntboss")
				end
			end
		end
	elseif spellId == 197969 then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnRoaringCacophony:Show(self.vb.roarCount)
		voiceRoaringCacophony:Play("aesoon")
		if self:IsLFR() then
			--No echos, just every 40 seconds
			timerRoaringCacophonyCD:Start(40, self.vb.roarCount + 1)
		else
			if self:IsMythic() then
				--17, 20, 10, 30, 10, 30, 10, 30, 10, 30, 10
				if self.vb.roarCount == 1 then--Second one is 20
					timerRoaringCacophonyCD:Start(20, self.vb.roarCount + 1)
				--Because of odd 2nd one, these rules are reversed
				elseif self.vb.roarCount % 2 == 0 then
					timerRoaringCacophonyCD:Start(10, self.vb.roarCount + 1)
				else
					timerRoaringCacophonyCD:Start(30, self.vb.roarCount + 1)
				end
			else
				if self.vb.roarCount % 2 == 0 then
					timerRoaringCacophonyCD:Start(30, self.vb.roarCount + 1)
				else
					timerRoaringCacophonyCD:Start(10, self.vb.roarCount + 1)
				end
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197943 then
		timerOverwhelmCD:Start()
		countdownOverwhelm:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 198006 then
		self.vb.chargeCount = self.vb.chargeCount + 1
		timerFocusedGazeCD:Start(nil, self.vb.chargeCount+1)
		countdownFocusedGazeCD:Start()
		countdownFocusedGaze:Start()
		local icon = 0
		local secondCount
		--Icons 6/4 used to ensure no conflict with BW.
		if self.vb.chargeCount % 2 == 0 then
			icon = 6
			secondCount = 2
		else
			icon = 4
			secondCount = 1
		end
		warnFocusedGaze:Show(self.vb.chargeCount.."-"..secondCount, args.destName)
		if args:IsPlayer() then
			specWarnFocusedGaze:Show()
			yellFocusedGaze:Yell(icon, icon, icon)
			voiceFocusedGaze:Play("targetyou")
		end
		if self.Options.SetIconOnCharge then
			self:SetIcon(args.destName, icon)
		end
		if self.Options.HudMapOnCharge then
			if args:IsPlayer() then
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 8, nil, nil, nil, 0.5):Appear():SetLabel(args.destName)
			else
				DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 8, 8, nil, nil, nil, 0.5):Appear():RegisterForAlerts(nil, args.destName)
			end
		end
		if not self.Options.NoAutoSoaking2 then
			GenerateSoakAssignment(self, secondCount, args.destName)
		end
	elseif spellId == 197943 then
		warnOverwhelm:Show(args.destName, args.amount or 1)
		if not args:IsPlayer() then--Overwhelm Applied to someone that isn't you
			--Taunting is safe now because your rend flesh will vanish (or is already gone), and not be cast again, before next overwhelm
			local rendCooldown = timerRendFleshCD:GetRemaining() or 0
			local _, _, _, _, _, _, expireTime = UnitDebuff("player", GetSpellInfo(204859))
			if rendCooldown > 10 and (not expireTime or expireTime and expireTime-GetTime() < 10) then
				specWarnOverwhelmOther:Show(args.destName)
				voiceOverwhelm:Play("tauntboss")
			end
		end
	elseif spellId == 198388 then
		warnBloodFrenzy:Show()
		voiceBloodFrenzy:Play("frenzy")
	elseif spellId == 205611 and args:IsPlayer() and self:AntiSpam(2, 1) then
		specWarnMiasma:Show()
		voiceMiasma:Play("runaway")
	elseif spellId == 204859 and not args:IsPlayer() then
		specWarnRendFleshOther:Show(args.destName)
		voiceRendFlesh:Play("tauntboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnMiasma:Show()
		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
