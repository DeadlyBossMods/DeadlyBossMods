local mod	= DBM:NewMod(869, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71865)
mod:SetEncounterID(1623)
mod:SetHotfixNoticeRev(10828)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144583 144584 144969 144985 145037 147120 147011 145599",
	"SPELL_CAST_SUCCESS 144748 144749 145065 145171",
	"SPELL_AURA_APPLIED 144945 145065 145171 145183 145195 144585 147209 147665 147235",
	"SPELL_AURA_APPLIED_DOSE 145183 145195 147235",
	"SPELL_AURA_REMOVED 145183 145195 144945 145065 145171 147209",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--I saw garrosh fire boss1 and boss3 events, so use all 5 to be safe
)

--Stage 1: The True Horde
local warnDesecrate					= mod:NewTargetAnnounce(144748, 3)
local warnHellscreamsWarsong		= mod:NewSpellAnnounce(144821, 3)
local warnExplodingIronStar			= mod:NewSpellAnnounce(144798, 3)
local warnFarseerWolfRider			= mod:NewSpellAnnounce("ej8294", 3, 144585)
local warnSiegeEngineer				= mod:NewSpellAnnounce("ej8298", 4, 144616)
local warnChainHeal					= mod:NewSpellAnnounce(144583, 4)
local warnChainLightning			= mod:NewSpellAnnounce(144584, 3, nil, false)--Maybe turn off by default if too spammy
--Intermission: Realm of Y'Shaarj
local warnYShaarjsProtection		= mod:NewTargetAnnounce(144945, 2)
local warnYShaarjsProtectionFade	= mod:NewFadesAnnounce(144945, 1)
local warnAnnihilate				= mod:NewCastAnnounce(144969, 4)
--Stage Two: Power of Y'Shaarj
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnWhirlingCorruption		= mod:NewCountAnnounce(144985, 3)
local warnTouchOfYShaarj			= mod:NewTargetAnnounce(145071, 3)
local warnGrippingDespair			= mod:NewStackAnnounce(145183, 2, nil, mod:IsTank())
--Starge Three: MY WORLD
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnEmpWhirlingCorruption		= mod:NewSpellAnnounce(145037, 3)
local warnEmpTouchOfYShaarj			= mod:NewTargetAnnounce(145175, 3)
local warnEmpGrippingDespair		= mod:NewStackAnnounce(145195, 3, nil, mod:IsTank())--Distinction is not that important, may just remove for the tank warning.
--Starge Four: Heroic Hidden Phase
local warnPhase4					= mod:NewPhaseAnnounce(4)
local warnMalice					= mod:NewTargetAnnounce(147209, 2)
local warnBombardment				= mod:NewCountAnnounce(147120, 3)
local warnManifestRage				= mod:NewSpellAnnounce(147011, 4)
local warnIronStarFixate			= mod:NewTargetAnnounce(147665, 2)
local warnIronStarSpawn				= mod:NewSpellAnnounce(147047, 2)

--Stage 1: The True Horde
local specWarnDesecrate				= mod:NewSpecialWarningCount(144748, nil, nil, nil, 2)
local specWarnDesecrateYou			= mod:NewSpecialWarningYou(144748)
local specWarnDesecrateNear			= mod:NewSpecialWarningClose(144748)
local yellDesecrate					= mod:NewYell(144748)
local specWarnHellscreamsWarsong	= mod:NewSpecialWarningSpell(144821, mod:IsTank() or mod:IsHealer())
local specWarnExplodingIronStar		= mod:NewSpecialWarningSpell(144798, nil, nil, nil, 3)
local specWarnFarseerWolfRider		= mod:NewSpecialWarningSwitch("ej8294", not mod:IsHealer())
local specWarnSiegeEngineer			= mod:NewSpecialWarningPreWarn("ej8298", false, 4)
local specWarnChainHeal				= mod:NewSpecialWarningInterrupt(144583)
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(144584, false)
--Intermission: Realm of Y'Shaarj
local specWarnAnnihilate			= mod:NewSpecialWarningSpell("OptionVersion3", 144969, false, nil, nil, 3)
--Stage Two: Power of Y'Shaarj
local specWarnWhirlingCorruption	= mod:NewSpecialWarningCount(144985)--Two options important, for distinction and setting custom sounds for empowered one vs non empowered one, don't merge
local specWarnGrippingDespair		= mod:NewSpecialWarningStack(145183, mod:IsTank(), 4)--Unlike whirling and desecrate, doesn't need two options, distinction isn't important for tank swaps.
local specWarnGrippingDespairOther	= mod:NewSpecialWarningTaunt(145183, mod:IsTank())
local specWarnTouchOfYShaarj		= mod:NewSpecialWarningSwitch("OptionVersion3", 145071, not mod:IsHealer())
local specWarnTouchInterrupt		= mod:NewSpecialWarningInterrupt(145599, false)
--Starge Three: MY WORLD
local specWarnEmpWhirlingCorruption	= mod:NewSpecialWarningCount(145037)--Two options important, for distinction and setting custom sounds for empowered one vs non empowered one, don't merge
local specWarnEmpDesecrate			= mod:NewSpecialWarningCount(144749, nil, nil, nil, 2)--^^
--Starge Four: Heroic Hidden Phase
local specWarnMaliceYou				= mod:NewSpecialWarningYou(147209)
local yellMalice					= mod:NewYell("OptionVersion2", 147209, nil, false)
local specWarnBombardment			= mod:NewSpecialWarningCount(147120, nil, nil, nil, 2)
local specWarnBombardmentOver		= mod:NewSpecialWarningEnd(147120)
local specWarnISFixate				= mod:NewSpecialWarningYou(147665)
local specWarnIronStarSpawn			= mod:NewSpecialWarningSpell(147047, false)
local specWarnManifestRage			= mod:NewSpecialWarningInterrupt(147011, nil, nil, nil, 3)
local specWarnMaliciousBlast		= mod:NewSpecialWarningStack(147235, nil, 1)

local timerRoleplay					= mod:NewTimer(110, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime")--No boss option, cause I'll likely just make this a prototype later when i decide on text that fits perfectly in all languages.
--Stage 1: A Cry in the Darkness
local timerDesecrateCD				= mod:NewCDCountTimer(35, 144748)
local timerHellscreamsWarsongCD		= mod:NewNextTimer(42.2, 144821, nil, mod:IsTank() or mod:IsHealer())
local timerFarseerWolfRiderCD		= mod:NewNextTimer(50, "ej8294", nil, nil, nil, 144585)--EJ says they come faster as phase progresses but all i saw was 3 spawn on any given pull and it was 30 50 50
local timerSiegeEngineerCD			= mod:NewNextTimer(40, "ej8298", nil, nil, nil, 144616)
local timerPowerIronStar			= mod:NewCastTimer(16.5, 144616)
--Intermission: Realm of Y'Shaarj
local timerEnterRealm				= mod:NewNextTimer(145.5, 144866, nil, nil, nil, 144945)
local timerYShaarjsProtection		= mod:NewBuffActiveTimer(60.5, "ej8305", nil, nil, nil, 144945)--May be too long, but intermission makes more sense than protection buff which actually fades before intermission ends if you do it right.
--Stage Two: Power of Y'Shaarj
local timerWhirlingCorruptionCD		= mod:NewCDCountTimer(49.5, 144985)--One bar for both, "empowered" makes timer too long
local timerWhirlingCorruption		= mod:NewBuffActiveTimer("OptionVersion2", 9, 144985, nil, false)
local timerTouchOfYShaarjCD			= mod:NewCDCountTimer(45, 145071)
local timerGrippingDespair			= mod:NewTargetTimer(15, 145183, nil, mod:IsTank())
--Starge Three: MY WORLD
--Starge Four: Heroic Hidden Phase
local timerMaliceCD					= mod:NewNextTimer(29.5, 147209)--29.5-33sec variation
local timerBombardmentCD			= mod:NewNextTimer(55, 147120)
local timerBombardment				= mod:NewBuffActiveTimer(13, 147120)
local timerClumpCheck				= mod:NewNextTimer(3, 147126)
local timerMaliciousBlast			= mod:NewBuffFadesTimer(3, 147235, nil, false)

local soundWhirlingCorrpution		= mod:NewSound("OptionVersion2", 144985, false)--Depends on strat. common one on 25 man is to never run away from it
local countdownPowerIronStar		= mod:NewCountdown(16.5, 144616)
local countdownWhirlingCorruption	= mod:NewCountdown(49.5, 144985)
local countdownTouchOfYShaarj		= mod:NewCountdown("Alt45", 145071, false)--Off by default only because it's a cooldown and it does have a 45-48sec variation
local countdownRealm				= mod:NewCountdownFades(60.5, "ej8305", nil, nil, 10)

mod:AddBoolOption("yellMaliceFading", false)
mod:AddSetIconOption("SetIconOnShaman", "ej8294", false, true)
mod:AddSetIconOption("SetIconOnMC", 145071, false)
mod:AddSetIconOption("SetIconOnMalice", 147209, false)
mod:AddArrowOption("ShowDesecrateArrow", 144748, false)
mod:AddBoolOption("InfoFrame", mod:IsHealer())
--mod:AddBoolOption("RangeFrame")

--Upvales, don't need variables
local UnitExists, UnitDebuff = UnitExists, UnitDebuff
local bombardCD = {55, 40, 40, 25, 25}
local spellName1 = GetSpellInfo(149004)
local spellName2 = GetSpellInfo(148983)
local spellName3 = GetSpellInfo(148994)
--Tables, can't recover
local lines = {}
--Not important, don't need to recover
local engineerDied = 0
--Important, needs recover
mod.vb.shamanAlive = 0
mod.vb.phase = 1
mod.vb.whirlCount = 0
mod.vb.desecrateCount = 0
mod.vb.mindControlCount = 0
mod.vb.bombardCount = 0
mod.vb.firstIronStar = false

local function updateInfoFrame()
	table.wipe(lines)
	for uId in DBM:GetGroupMembers() do
		if not (UnitDebuff(uId, spellName1) or UnitDebuff(uId, spellName2) or UnitDebuff(uId, spellName3)) and not UnitIsDeadOrGhost(uId) then
			lines[UnitName(uId)] = ""
		end
	end
	return lines
end

local function showInfoFrame()
	if mod.Options.InfoFrame and mod:IsInCombat() then
		DBM.InfoFrame:SetHeader(L.NoReduce)
		DBM.InfoFrame:Show(10, "function", updateInfoFrame)
	end
end

local function hideInfoFrame()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:DesecrateTarget(targetname, uId)
	if not targetname then return end
	warnDesecrate:Show(targetname)
	if targetname == UnitName("player") and not self:IsTanking(uId) then--Never targets tanks
		specWarnDesecrateYou:Show()
		yellDesecrate:Yell()
	elseif self.vb.phase ~= 1 and self:CheckNearby(20, targetname) then
		specWarnDesecrateNear:Show(targetname)
		if self.Options.ShowDesecrateArrow then
			local x, y = GetPlayerMapPosition(targetname)--Map should already be correct from CheckNearby so don't need to do SetMapToCurrentZone
			DBM.Arrow:ShowRunAway(x, y, 15, 5)--Maybe adjust arrow run range from 15 to 20
		end
	else
		if UnitPower("boss1") < 75 then
			specWarnDesecrate:Show(self.vb.desecrateCount)
		else
			specWarnEmpDesecrate:Show(self.vb.desecrateCount)
		end
	end
end

function mod:OnCombatStart(delay)
	engineerDied = 0
	self.vb.shamanAlive = 0
	self.vb.phase = 1
	self.vb.whirlCount = 0
	self.vb.desecrateCount = 0
	self.vb.mindControlCount = 0
	self.vb.bombardCount = 0
	self.vb.firstIronStar = false
	timerDesecrateCD:Start(10.5-delay, 1)
	specWarnSiegeEngineer:Schedule(16-delay)
	timerSiegeEngineerCD:Start(20-delay)
	timerHellscreamsWarsongCD:Start(22-delay)
	timerFarseerWolfRiderCD:Start(30-delay)
end

function mod:OnCombatEnd()
--[[	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end--]]
	if self.Options.ShowDesecrateArrow then
		DBM.Arrow:Hide()
	end
	hideInfoFrame()
end

--[[
local function hideRangeDelay()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144583 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainHeal:Show(source)
		end
	elseif spellId == 144584 then
		local source = args.sourceName
		warnChainLightning:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainLightning:Show(source)
		end
	elseif spellId == 144969 then
		warnAnnihilate:Show()
		specWarnAnnihilate:Show()
	elseif args:IsSpellID(144985, 145037) then
		self.vb.whirlCount = self.vb.whirlCount + 1
		if spellId == 144985 then
			warnWhirlingCorruption:Show(self.vb.whirlCount)
			specWarnWhirlingCorruption:Show(self.vb.whirlCount)
		else
			warnEmpWhirlingCorruption:Show(self.vb.whirlCount)
			specWarnEmpWhirlingCorruption:Show(self.vb.whirlCount)
		end
		timerWhirlingCorruption:Start()
		timerWhirlingCorruptionCD:Start(nil, self.vb.whirlCount+1)
		countdownWhirlingCorruption:Start()
		soundWhirlingCorrpution:Play()
	elseif spellId == 147120 then
		self.vb.bombardCount = self.vb.bombardCount + 1
		warnBombardment:Show(self.vb.bombardCount)
		specWarnBombardment:Show(self.vb.bombardCount)
		specWarnBombardmentOver:Schedule(13)
		timerBombardment:Start()
		timerBombardmentCD:Start(bombardCD[self.vb.bombardCount] or 15, self.vb.bombardCount+1)
		timerClumpCheck:Start()
--[[		if self.Options.RangeFrame then
			if self:IsDifficulty("heroic10") then
				DBM.RangeCheck:Show(8, nil, nil, 3)
			else
				DBM.RangeCheck:Show(8, nil, nil, 7)
			end
			self:Schedule(13, hideRangeDelay)
		end--]]
	elseif spellId == 147011 then
		warnManifestRage:Show()
		if UnitDebuff("player", GetSpellInfo(147665)) then--Kiting an Unstable Iron Star
			specWarnManifestRage:Show()
		end
	elseif spellId == 145599 and self:AntiSpam(1.5) then
		specWarnTouchInterrupt:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(144748, 144749) then
		self.vb.desecrateCount = self.vb.desecrateCount + 1
		if self.vb.phase == 1 then
			timerDesecrateCD:Start(41, self.vb.desecrateCount+1)
		elseif self.vb.phase == 3 then
			timerDesecrateCD:Start(25, self.vb.desecrateCount+1)
		else--Phase 2
			timerDesecrateCD:Start(nil, self.vb.desecrateCount+1)
		end
		self:BossTargetScanner(71865, "DesecrateTarget", 0.02, 16)
	elseif args:IsSpellID(145065, 145171) then
		self.vb.mindControlCount = self.vb.mindControlCount + 1
		specWarnTouchOfYShaarj:Show()
		if self.vb.phase == 3 then
			if self.vb.mindControlCount == 1 then--First one in phase is shorter than rest (well that or rest are delayed because of whirling)
				timerTouchOfYShaarjCD:Start(35, self.vb.mindControlCount+1)
				countdownTouchOfYShaarj:Start(35)
			else
				timerTouchOfYShaarjCD:Start(42, self.vb.mindControlCount+1)
				countdownTouchOfYShaarj:Start(42)
			end
		else
			timerTouchOfYShaarjCD:Start(nil, self.vb.mindControlCount+1)
			countdownTouchOfYShaarj:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144945 then
		warnYShaarjsProtection:Show(args.destName)
		timerYShaarjsProtection:Start()
		countdownRealm:Start()
	elseif args:IsSpellID(145065, 145171) then
		if spellId == 145065 then
			warnTouchOfYShaarj:CombinedShow(0.5, args.destName)
		else
			warnEmpTouchOfYShaarj:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnMC then
			if self:IsDifficulty("normal25", "heroic25", "lfr25") then
				self:SetSortedIcon(1, args.destName, 1, 4)
			elseif self:IsDifficulty("normal10", "heroic10") then
				self:SetSortedIcon(1, args.destName, 1, 2)
			else
				self:SetSortedIcon(1, args.destName, 1)
			end
		end
	elseif args:IsSpellID(145183, 145195) then
		local amount = args.amount or 1
		if spellId == 145183 then
			warnGrippingDespair:Show(args.destName, amount)
		else
			warnEmpGrippingDespair:Show(args.destName, amount)
		end
		timerGrippingDespair:Start(args.destName)
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnGrippingDespair:Show(amount)
			else
				specWarnGrippingDespairOther:Show(args.destName)
			end
		end
	elseif spellId == 144585 then
		self.vb.shamanAlive = self.vb.shamanAlive + 1
		warnFarseerWolfRider:Show()
		specWarnFarseerWolfRider:Show()
		timerFarseerWolfRiderCD:Start()
		if self.Options.SetIconOnShaman and self.vb.shamanAlive < 9 then--Support for marking up to 8 shaman
			self:ScanForMobs(71983, 2, 9-self.vb.shamanAlive, 1, 0.2, 10, "SetIconOnShaman")
		end
	elseif spellId == 147209 then
		self:SendSync("MaliceTarget", args.destGUID)
	elseif spellId == 147665 then
		warnIronStarFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnISFixate:Show()
		end
	elseif spellId == 147235 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGrippingDespair:Start(args.destName)
		if amount >= 1 then
			specWarnMaliciousBlast:Show(amount)
			timerMaliciousBlast:Start()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(145183, 145195) then
		timerGrippingDespair:Cancel(args.destName)
	elseif spellId == 144945 then
		warnYShaarjsProtectionFade:Show()
		showInfoFrame()
	elseif args:IsSpellID(145065, 145171) and self.Options.SetIconOnMC then
		self:SetIcon(args.destName, 0)
	elseif spellId == 147209 then
		self:SendSync("MaliceTargetRemoved", args.destGUID)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71984 then--Siege Engineer
		engineerDied = engineerDied + 1
		if engineerDied == 2 then
			warnExplodingIronStar:Cancel()
			specWarnExplodingIronStar:Cancel()
			timerPowerIronStar:Cancel()
			countdownPowerIronStar:Cancel()
		end
	elseif cid == 71983 then--Farseer Wolf Rider
		self.vb.shamanAlive = self.vb.shamanAlive - 1
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 144821 then--Warsong. Does not show in combat log
		warnHellscreamsWarsong:Show()
		specWarnHellscreamsWarsong:Show()
		timerHellscreamsWarsongCD:Start()
	elseif spellId == 145235 then--Throw Axe At Heart
		timerSiegeEngineerCD:Cancel()
		timerFarseerWolfRiderCD:Cancel()
		timerDesecrateCD:Cancel()
		timerHellscreamsWarsongCD:Cancel()
		specWarnSiegeEngineer:Cancel()
		if self.vb.phase == 1 then
			timerEnterRealm:Start(25)
		end
	elseif spellId == 144866 then--Enter Realm of Y'Shaarj
		timerPowerIronStar:Cancel()
		countdownPowerIronStar:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		countdownTouchOfYShaarj:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		countdownWhirlingCorruption:Cancel()
	elseif spellId == 144956 then--Jump To Ground (intermission ending)
		if timerEnterRealm:GetTime() > 0 then--first cast, phase2 trigger.
			self.vb.phase = 2
			warnPhase2:Show()
		else
			self.vb.whirlCount = 0
			self.vb.desecrateCount = 0
			self.vb.mindControlCount = 0
			hideInfoFrame()
			timerDesecrateCD:Start(10, 1)
			timerTouchOfYShaarjCD:Start(15, 1)
			countdownTouchOfYShaarj:Start(15)
			timerWhirlingCorruptionCD:Start(30, 1)
			countdownWhirlingCorruption:Start(30)
			timerEnterRealm:Start()
		end
	--"<556.9 21:41:56> [UNIT_SPELLCAST_SUCCEEDED] Garrosh Hellscream [[boss1:Realm of Y'Shaarj::0:145647]]", -- [169886]
	elseif spellId == 145647 then--Phase 3 trigger
		self.vb.phase = 3
		self.vb.whirlCount = 0
		self.vb.desecrateCount = 0
		self.vb.mindControlCount = 0
		warnPhase3:Show()
		timerEnterRealm:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		countdownTouchOfYShaarj:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		countdownWhirlingCorruption:Cancel()
		timerDesecrateCD:Start(21, 1)
		timerTouchOfYShaarjCD:Start(30, 1)
		countdownTouchOfYShaarj:Start(30)
		timerWhirlingCorruptionCD:Start(44.5, 1)
		countdownWhirlingCorruption:Start(44.5)
	elseif spellId == 146984 then--Phase 4 trigger
		self.vb.phase = 4
		timerEnterRealm:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		countdownTouchOfYShaarj:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		countdownWhirlingCorruption:Cancel()
		warnPhase4:Show()
		timerMaliceCD:Start()
		timerBombardmentCD:Start(70)
	elseif spellId == 147126 then--Clump Check
		timerClumpCheck:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:144616") then
		engineerDied = 0
		warnSiegeEngineer:Show()
		specWarnSiegeEngineer:Cancel()
		specWarnSiegeEngineer:Schedule(41)
		if not self.vb.firstIronStar then
			self.vb.firstIronStar = true
			timerSiegeEngineerCD:Start(45)
		else
			timerSiegeEngineerCD:Start()
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerPowerIronStar:Start(11.5)
			countdownPowerIronStar:Start(11.5)
			warnExplodingIronStar:Schedule(11.5)
			specWarnExplodingIronStar:Schedule(11.5)
		else
			timerPowerIronStar:Start()
			countdownPowerIronStar:Start()
			warnExplodingIronStar:Schedule(16.5)
			specWarnExplodingIronStar:Schedule(16.5	)
        end
	elseif msg:find("spell:147047") then
		warnIronStarSpawn:Show()
		specWarnIronStarSpawn:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	end
end

function mod:OnSync(msg, guid)
	if msg == "MaliceTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnMalice:Show(targetName)
		timerMaliceCD:Start()
		if targetName == UnitName("player") then
			specWarnMaliceYou:Show()
			yellMalice:Yell()
			if self.Options.yellMaliceFading then
				local playerName = UnitName("player")
				DBM:Schedule(13, SendChatMessage, L.MaliceFadeYell:format(playerName, 1), "SAY")
				DBM:Schedule(12, SendChatMessage, L.MaliceFadeYell:format(playerName, 2), "SAY")
				DBM:Schedule(11, SendChatMessage, L.MaliceFadeYell:format(playerName, 3), "SAY")
			end
		end
		if self.Options.SetIconOnMalice then
			self:SetIcon(targetName, 7)
		end
	elseif msg == "MaliceTargetRemoved" and guid and self.Options.SetIconOnMalice then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		self:SetIcon(targetName, 0)
	elseif msg == "prepull" then
		timerRoleplay:Start()
	end
end
