local mod	= DBM:NewMod(831, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69473)--69888
mod:SetQuestID(32753)
mod:SetZone()
mod:SetUsedIcons(2, 1)

mod:RegisterCombat("combat")
mod:RegisterKill("yell_regex", L.Defeat)--Does not die, just yells

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_POWER_FREQUENT boss1"
)

--Anima
local warnAnima					= mod:NewSpellAnnounce(138331, 2)--Switched to anima phase
local warnMurderousStrike		= mod:NewSpellAnnounce(138333, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
local warnUnstableAnima			= mod:NewTargetAnnounce(138288)--May range frame needed. 138295 is damage id according to wowhead, 138288 is debuff cast.
local warnSanguineHorror		= mod:NewCountAnnounce(138338, 3, nil, not mod:IsHealer())--Adds
--Vita
local warnVita					= mod:NewSpellAnnounce(138332, 2)--Switched to vita phase
local warnFatalStrike			= mod:NewSpellAnnounce(138334, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
local warnVitaSoakerSoon		= mod:NewAnnounce("warnVitaSoakerSoon", 2, 138297)
local warnUnstableVita			= mod:NewTargetAnnounce(138297, 4)
local warnCracklingStalker		= mod:NewCountAnnounce(138339, 3, nil, not mod:IsHealer())--Adds
--General
local warnCreation				= mod:NewCountAnnounce(138321, 3)--aka Orbs/Balls
local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnCallEssence			= mod:NewSpellAnnounce(139040, 4, 139071)

--Anima
local specWarnMurderousStrike	= mod:NewSpecialWarningSpell(138333, mod:IsTank(), nil, nil, 3)
local specWarnSanguineHorror	= mod:NewSpecialWarningSwitch(138338, mod:IsRangedDps() or mod:IsTank())
local specWarnAninaSensitive	= mod:NewSpecialWarningYou(139318)
local specWarnUnstableAnima		= mod:NewSpecialWarningYou(138288, nil, nil, nil, 3)
local yellUnstableAnima			= mod:NewYell(138288, nil, false)
--Vita
local specWarnFatalStrike		= mod:NewSpecialWarningSpell(138334, mod:IsTank(), nil, nil, 3)
local specWarnCracklingStalker	= mod:NewSpecialWarningSwitch(138339, mod:IsRangedDps() or mod:IsTank())
local specWarnVitaSensitive		= mod:NewSpecialWarningYou(138372)
local specWarnVitaSoaker		= mod:NewSpecialWarning("specWarnVitaSoaker")
local specWarnUnstablVita		= mod:NewSpecialWarningYou(138297, nil, nil, nil, 3)
local specWarnUnstablVitaJump	= mod:NewSpecialWarningYou(138308, nil, nil, nil, 1)
local yellUnstableVita			= mod:NewYell(138297, nil, false)
--General
local specWarnCreation			= mod:NewSpecialWarningSpell(138321, mod:IsDps())
local specWarnCallEssence		= mod:NewSpecialWarningSpell(139040, mod:IsDps())

--Anima
local timerMurderousStrikeCD	= mod:NewCDTimer(33, 138333, nil, mod:IsTank())--Gains 3 power per second roughly and uses special at 100 Poewr
--local timerSanguineHorrorCD	= mod:NewCDCountTimer(41, 138338)--CD not known. No one fights him in anima phase for more than like 1-2 seconds.
--Vita
local timerFatalStrikeCD		= mod:NewCDTimer(10, 138334, nil, mod:IsTank())--Gains 10 power per second roughly and uses special at 100 Poewr
local timerUnstableVita			= mod:NewTargetTimer(12, 138297)
local timerCracklingStalkerCD	= mod:NewCDCountTimer(41, 138339)
--General
local timerCreationCD			= mod:NewCDCountTimer(32.5, 138321)--32.5-35second variation
local timerCallEssenceCD		= mod:NewNextTimer(15.5, 139040)

local countdownUnstableVita		= mod:NewCountdownFades(11, 138297)
local countdownCreation			= mod:NewCountdown(32.5, 138321, nil, nil, nil, nil, true)

mod:AddBoolOption("SetIconsOnVita", false)--Both the vita target and furthest from vita target
mod:AddBoolOption("InfoFrame")

local creationCount = 0
local stalkerCount = 0
local horrorCount = 0
local lastStalker = 0
local playerWithVita = nil
local furthestDistancePlayer = nil
local lastfurthestDistancePlayer = nil
local lastsPlayerOne = nil
local lastPlayerTwo = nil
local playerName = UnitName("player")
local vitaName = GetSpellInfo(138332)
local animaName = GetSpellInfo(138331)

function mod:checkVitaDistance()
	if not playerWithVita then--Failsafe more or less. This shouldn't happen unless combat log lag fires events out of order
		self:UnscheduleMethod("checkVitaDistance")--So terminate loop (anima phase or phase 2 probably)
		return
	end
	local furthestDistance = 0
	for uId in DBM:GetGroupMembers() do
		if not UnitIsUnit(uId, playerWithVita) then
			local distance = DBM.RangeCheck:GetDistance(uId, playerWithVita)
			if distance > furthestDistance then
				furthestDistance = distance
				furthestDistancePlayer = uId
			end
		end
	end
	if furthestDistancePlayer ~= lastfurthestDistancePlayer then--Set icon throttling to avoid hitting blizzard throttle
		SetRaidTarget(furthestDistancePlayer, 2)
		lastfurthestDistancePlayer = furthestDistancePlayer
	end
	self:ScheduleMethod(1, "checkVitaDistance")
end

local function infoFrameChanged(players)
	if players[1] == playerName and playerName ~= lastsPlayerOne then
		specWarnVitaSoaker:Show()
	elseif players[2] == playerName and playerName ~= lastPlayerTwo  then
		warnVitaSoakerSoon:Show()
	end
	lastsPlayerOne = players[1]
	lastPlayerTwo = players[2]
end

function mod:OnCombatStart(delay)
	creationCount = 0
	stalkerCount = 0
	horrorCount = 0
	lastsPlayerOne = nil
	lastPlayerTwo = nil
	timerCreationCD:Start(11-delay, 1)
	countdownCreation:Start(11-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.NoSensitivity)
		DBM.InfoFrame:Show(10, "reverseplayerbaddebuff", 138372, nil, nil, nil, true, true)
		DBM.InfoFrame:RegisterCallback(infoFrameChanged)
	elseif self.Options[specWarnVitaSoaker.option or ""] or self.Options[warnVitaSoakerSoon.option or ""] then
		self:AddMsg(L.VitaSoakerOptionConflict)
	end

end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 138338 then
		horrorCount = horrorCount + 1
		warnSanguineHorror:Show(horrorCount)
		specWarnSanguineHorror:Show()
--		timerSanguineHorrorCD:Start(nil, horrorCount+1)
	elseif args.spellId == 138339 then
		lastStalker = GetTime()
		stalkerCount = stalkerCount + 1
		warnCracklingStalker:Show(stalkerCount)
		specWarnCracklingStalker:Show()
		timerCracklingStalkerCD:Start(nil, stalkerCount+1)
	elseif args.spellId == 138321 then
		creationCount = creationCount + 1
		warnCreation:Show(creationCount)
		specWarnCreation:Show()
		timerCreationCD:Start(nil, creationCount+1)
		countdownCreation:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138333 then
		warnMurderousStrike:Show()
		timerMurderousStrikeCD:Start()
	elseif args.spellId == 138334 then
		warnFatalStrike:Show()
		timerFatalStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138331 then--Anima Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 3
		horrorCount = 0
		timerFatalStrikeCD:Cancel()
		timerCracklingStalkerCD:Cancel()
		timerMurderousStrikeCD:Start(33-radenPower)
		--timerSanguineHorrorCD:Start(nil, 1)
		warnAnima:Show()
	elseif args.spellId == 138332 then--Vita Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 10
		local stalkerupdate = nil
		if GetTime() - lastStalker < 32 then--Check if it's been at least 32 seconds since last stalker
			stalkerupdate = 40 - (GetTime() - lastStalker)--if not, find out how much time is left on internal stalker cd (cause CD doesn't actually reset when you reset vita, it just extends to 8-9 seconds if less than 8-9 seconds remaining)
		else
			stalkerupdate = 8
		end
		stalkerCount = 0
		warnVita:Show()
		timerMurderousStrikeCD:Cancel()
		--timerSanguineHorrorCD:Cancel()
		timerCracklingStalkerCD:Start(stalkerupdate, 1)
		timerFatalStrikeCD:Start(10-radenPower)
	elseif args.spellId == 139318 then--Anima Sensitivity
		if args:IsPlayer() then
			specWarnAninaSensitive:Show()
		end
	elseif args.spellId == 138372 then--Vita Sensitivity
		if args:IsPlayer() then
			specWarnVitaSensitive:Show()
		end
	elseif args.spellId == 138288 then--Unstable Anima
		warnUnstableAnima:Show(args.destName)
		if args:IsPlayer() then
			specWarnUnstableAnima:Show()
			yellUnstableAnima:Yell()
		end
	elseif args:IsSpellID(138297, 138308) then--Unstable Vita (138297 cast, 138308 jump)
		if self.Options.SetIconsOnVita then
			playerWithVita = DBM:GetRaidUnitId(args.destName)
			self:SetIcon(args.destName, 1)
			self:ScheduleMethod(6, "checkVitaDistance")--Wait about 6 seconds for initial. don't want to spam icons before next target actually runs out. May raise initial even higher, debuff is 12 seconds. so maybe 7-8 if 6 too soon 
		end
		warnUnstableVita:Show(args.destName)
		timerUnstableVita:Start(args.destName)
		if args:IsPlayer() then
			if args.spellId == 138297 then
				specWarnUnstablVita:Show()
			else
				specWarnUnstablVitaJump:Show()
			end
			yellUnstableVita:Yell()
			countdownUnstableVita:Start()
		end
	end
end

--[[
"<19.8 01:50:11> [CLEU] SPELL_AURA_APPLIED#false#0xF1310F61000091B6#Ra-den#2632#0#0x0300000007B5931A#Takeaseat#1297#0#138297#Unstable Vita#8#DEBUFF", -- [2245]
"<31.8 01:50:23> [CLEU] SPELL_AURA_REMOVED#false#0xF1310F61000091B6#Ra-den#68168#0#0x0300000007B5931A#Takeaseat#1297#0#138297#Unstable Vita#8#DEBUFF", -- [3753]--SPELL_AURA_REMOVED should fire before jump
"<31.9 01:50:23> [CLEU] SPELL_AURA_APPLIED#false#0x0300000007B5931A#Takeaseat#1297#0#0x0300000007764949#Ryukou#1300#0#138308#Unstable Vita#8#DEBUFF", -- [3769]--Code may break if it doesn't but i've seen no indicatino this should happen
--]]
function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(138297, 138308) and self.Options.SetIconsOnVita then--Unstable Vita
		self:UnscheduleMethod("checkVitaDistance")
		playerWithVita = nil
		self:SetIcon(args.destName, 0)
		SetRaidTarget(furthestDistancePlayer, 0)--Use SetRaidTarget because seticon expects targetname, no point in changing it twice for no reason
	end
end

--"<299.6 01:54:51> CHAT_MSG_MONSTER_YELL#You still think victory possible? Fools!#Ra-den#####0#0##0#298#nil#0#false#false",
--"<299.9 01:54:51> [UNIT_SPELLCAST_SUCCEEDED] Ra-den [boss1:Ruin::0:139073]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 139040 then--Call Essence
		warnCallEssence:Show()
		specWarnCallEssence:Show()
		timerCallEssenceCD:Start()
		countdownCreation:Start(15)
	elseif spellId == 139073 then--Phase 2 (the Ruin Trigger)
		warnPhase2:Show()
		timerCracklingStalkerCD:Cancel()
--		timerSanguineHorrorCD:Cancel()
		timerMurderousStrikeCD:Cancel()
		timerFatalStrikeCD:Cancel()
		timerCreationCD:Cancel()
		countdownCreation:Cancel()
		timerCallEssenceCD:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:UNIT_POWER_FREQUENT(uId)
	local power = UnitPower(uId)
	if power == 90 and UnitBuff(uId, vitaName) and self:AntiSpam(3, 1) then
		specWarnFatalStrike:Show()
	elseif power == 96 and UnitBuff(uId, animaName) and self:AntiSpam(3, 2) then
		specWarnMurderousStrike:Show()
	end
end
