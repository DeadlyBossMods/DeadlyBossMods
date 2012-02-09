--local mod	= DBM:NewMod(167, "DBM-BastionTwilight", nil, 72)
local mod	= DBM:NewMod("Chogall", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43324)
mod:SetModelID(34576)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent15.wav", "Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent42.wav")
--Long: Foolish mortals-(Usurper's children!) nothing you have done- (Spawn of a lesser god!) I am TRYING to speak here. (Words, words, words. The Master wants murder.) ALL falls to chaos. ALL will be destroyed. (Chaos, chaos!) Your work here today changes nothing. (Chaos, chaos, all things end) No mortal may see what you have and live. Your end has come.
--Short: (The Master sees, the Master sees!)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_HEALTH",
	"UNIT_AURA",
	"UNIT_DIED"
)

local warnWorship					= mod:NewTargetAnnounce(91317, 3)--Phase 1
local warnFury						= mod:NewSpellAnnounce(82524, 3, nil, mod:IsTank() or mod:IsHealer())--Phase 1
local warnAdherent					= mod:NewSpellAnnounce(81628, 4)--Phase 1
local warnShadowOrders				= mod:NewSpellAnnounce(81556, 3, nil, mod:IsDps())--Warning is disabled on normal mode, it has no use there
local warnFlameOrders				= mod:NewSpellAnnounce(81171, 3, nil, mod:IsDps())--This one is also disabled on normal.
local warnFlamingDestruction		= mod:NewSpellAnnounce(81194, 4, nil, mod:IsTank() or mod:IsHealer())
local warnEmpoweredShadows			= mod:NewSpellAnnounce(81572, 4, nil, mod:IsHealer())
local warnCorruptingCrash			= mod:NewTargetAnnounce(93178, 2, nil, false)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnCreations					= mod:NewSpellAnnounce(82414, 3)--Phase 2

local specWarnSickness				= mod:NewSpecialWarningYou(82235, mod:IsMelee())--Ranged should already be spread out and not need a special warning every sickness.
local specWarnBlaze					= mod:NewSpecialWarningMove(81538)
local specWarnWorship				= mod:NewSpecialWarningSpell(93205, false)
local specWarnEmpoweredShadows		= mod:NewSpecialWarningSpell(81572, mod:IsHealer(), nil, nil, true)
local specWarnCorruptingCrash		= mod:NewSpecialWarningMove(93178)--Subject to accuracy flaws in rare cases but most of the time it's right.
local specWarnCorruptingCrashNear	= mod:NewSpecialWarningClose(93178)--^^
local yellCrash						= mod:NewYell(93178)--^^
local specWarnDepravity				= mod:NewSpecialWarningInterrupt(93177)--On by default cause these things don't get interrupted otherwise. but will only warn if it's target.
local specwarnFury					= mod:NewSpecialWarningTarget(82524, mod:IsTank())
local specwarnFlamingDestruction	= mod:NewSpecialWarningSpell(81194, mod:IsTank())

local timerWorshipCD				= mod:NewCDTimer(36, 91317)
local timerAdherent					= mod:NewCDTimer(92, 81628)
local timerFesterBlood				= mod:NewNextTimer(40, 82299)--40 seconds after an adherent is summoned
local timerFlamingDestruction		= mod:NewBuffActiveTimer(10, 81194, nil, mod:IsTank() or mod:IsHealer())
local timerEmpoweredShadows			= mod:NewBuffActiveTimer(9, 81572, nil, mod:IsHealer())
local timerFuryCD					= mod:NewCDTimer(47, 82524, nil, mod:IsTank() or mod:IsHealer())--47-48 unless a higher priority ability is channeling (such as summoning adds or MC)
local timerCreationsCD				= mod:NewNextTimer(30, 82414)
local timerSickness					= mod:NewBuffFadesTimer(5, 82235)
local timerFlamesOrders				= mod:NewNextTimer(25, 81171, nil, mod:IsDps())--Orders are when he summons elemental
local timerShadowsOrders			= mod:NewNextTimer(25, 81556, nil, mod:IsDps())--These are more for dps to switch to them to lower em so useless for normal mode
local timerFlamingDestructionCD		= mod:NewNextTimer(20, 81194, nil, mod:IsTank() or mod:IsHealer())--Timer for when the special actually goes off (when he absorbs elemental)
local timerEmpoweredShadowsCD		= mod:NewNextTimer(20, 81572, nil, mod:IsHealer())--^^
local timerDepravityCD				= mod:NewCDTimer(12, 93177, nil, mod:IsMelee())

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnWorship", true)
mod:AddBoolOption("SetIconOnCreature", true)
mod:AddBoolOption("CorruptingCrashArrow", true)
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("InfoFrame")

local worshipTargets = {}
local prewarned_Phase2 = false
local firstFury = false
local worshipIcon = 8
local worshipCooldown = 20.5
local shadowOrdersCD = 15
local blazeSpam = 0
local sickSpam = 0
local creatureIcons = {}
local creatureIcon = 8
local iconsSet = 0
local Corruption = GetSpellInfo(82235)

local function showWorshipWarning()
	warnWorship:Show(table.concat(worshipTargets, "<, >"))
	table.wipe(worshipTargets)
	worshipIcon = 8
	timerWorshipCD:Start(worshipCooldown)
	specWarnWorship:Show()
end

local function resetCreatureIconState()
	table.wipe(creatureIcons)
	creatureIcon = 8
	iconsSet = 0
end

function mod:CorruptingCrashTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
			break
		end
	end
	if not targetname then return end
	warnCorruptingCrash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCorruptingCrash:Show()
		yellCrash:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnCorruptingCrashNear:Show(targetname)
				if self.Options.CorruptingCrashArrow then
					DBM.Arrow:ShowRunAway(x, y, 10, 5)
				end
			end
		end
	end
end

function mod:OnCombatStart(delay)
	timerFlamesOrders:Start(5-delay)
	timerWorshipCD:Start(10-delay)
	table.wipe(worshipTargets)
	table.wipe(creatureIcons)
	prewarned_Phase2 = false
	firstFury = false
	worshipIcon = 8
	worshipCooldown = 20.5
	shadowOrdersCD = 15
	blazeSpam = 0
	sickSpam = 0
	creatureIcon = 8
	iconsSet = 0
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.Bloodlevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end	

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(91317, 93365, 93366, 93367) then
		worshipTargets[#worshipTargets + 1] = args.destName
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, worshipIcon)
			worshipIcon = worshipIcon - 1
		end
		self:Unschedule(showWorshipWarning)
		if (self:IsDifficulty("normal25", "heroic25") and #worshipTargets >= 4) or (self:IsDifficulty("normal10", "heroic10") and #worshipTargets >= 2) then
			showWorshipWarning()
		else
			self:Schedule(0.3, showWorshipWarning)
		end
	elseif args:IsSpellID(81194, 93264, 93265, 93266) then
		warnFlamingDestruction:Show()
		if self:GetUnitCreatureId("target") == 43324 or self:GetBossTarget(43324) == UnitName("target") then--Add tank doesn't need this spam, just tank on chogal and healers healing that tank.
			specwarnFlamingDestruction:Show()
		end
		timerFlamingDestruction:Start()
	elseif args:IsSpellID(81572, 93218, 93219, 93220) then
		warnEmpoweredShadows:Show()
		specWarnEmpoweredShadows:Show()
		timerEmpoweredShadows:Start()
	elseif args:IsSpellID(82518, 93154, 93155, 93156) then
		specwarnFury:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(91317, 93365, 93366, 93367) then
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(81628) then
		warnAdherent:Show()
		timerAdherent:Start()
		timerFesterBlood:Start()
	elseif args:IsSpellID(82524) then
		warnFury:Show()
		timerFuryCD:Start()
		if not firstFury then--85% fury of chogal, it resets cd on worship and changes cd to 36
			firstFury = true
			worshipCooldown = 36
			shadowOrdersCD = 25
			timerWorshipCD:Start(10)--worship is 10 seconds after first fury, regardless of what timer was at before 85%
			timerShadowsOrders:Cancel()--Cancel shadows orders timer, flame is going to be next.
			timerFlamesOrders:Start(15)--Flames orders is 15 seconds after first fury, regardless whether or not shadow was last.
		end
	elseif args:IsSpellID(82411, 93132, 93133, 93134) then -- Creatures are channeling after their spawn.
		if self.Options.SetIconOnCreature and not creatureIcons[args.sourceGUID] then
			creatureIcons[args.sourceGUID] = creatureIcon
			creatureIcon = creatureIcon - 1
		end
	elseif args:IsSpellID(81713, 93175, 93176, 93177) then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then--Check if added to boss health
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)--And add if not.
		end
		if args.sourceGUID == UnitGUID("target") then--Only show warning for your own target.
			specWarnDepravity:Show()
			if self:IsDifficulty("normal10", "heroic10") then
				timerDepravityCD:Start()--every 12 seconds on 10 man from their 1 adherent, can be solo interrupted.
			else
				timerDepravityCD:Start(6)--every 6 seconds on 25 man (unless interrupted by a mage then 7.5 cause of school lockout)
			end
		end
	end
end

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnCreature and (DBM:GetRaidRank() > 0 and not (iconsSet == 8 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 4 and self:IsDifficulty("normal10", "heroic10"))) then
		for i = 1, GetNumRaidMembers() do
			local uId = "raid"..i.."target"
			local guid = UnitGUID(uId)
			if creatureIcons[guid] then
				SetRaidTarget(uId, creatureIcons[guid])
				iconsSet = iconsSet + 1
				creatureIcons[guid] = nil
			end
		end
	end
end, 1)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82414, 93160, 93161, 93162) then
		warnCreations:Show()
		resetCreatureIconState()
		if self:IsDifficulty("heroic10", "heroic25") then -- other difficulty not sure, only comfirmed 25 man heroic
			timerCreationsCD:Start(40)
		else
			timerCreationsCD:Start()
		end
	elseif args:IsSpellID(82630) then
		warnPhase2:Show()
		timerAdherent:Cancel()
		timerWorshipCD:Cancel()
		timerFesterBlood:Cancel()
		timerFlamesOrders:Cancel()
		timerShadowsOrders:Cancel()
	elseif args:IsSpellID(81556) then--Shadow's Orders
		if self:IsDifficulty("heroic10", "heroic25") then
			warnShadowOrders:Show()--No reason to do this warning on normal, nothing spawns so nothing you can do about it.
			timerEmpoweredShadowsCD:Start()--Time til he actually absorbs elemental and gains it's effects
			timerFlamesOrders:Start()--always 25 seconds after shadows orders, regardless of phase.
		else
			timerEmpoweredShadowsCD:Start(10.8)--Half the time on normal since you don't actually have to kill elementals plus the only thing worth showing on normal.
		end
	elseif args:IsSpellID(81171) then--Flame's Orders
		if self:IsDifficulty("heroic10", "heroic25") then
			warnFlameOrders:Show()--No reason to do this warning on normal, nothing spawns so nothing you can do about it.
			timerFlamingDestructionCD:Start()--Time til he actually absorbs elemental and gains it's effects
			timerShadowsOrders:Start(shadowOrdersCD)--15 seconds after a flame order above 85%, 25 seconds after a flame orders below 85%
		else
			timerFlamingDestructionCD:Start(10.8)--Half the time on normal since you don't actually have to kill elementals plus the only thing worth showing on normal.
		end
	elseif args:IsSpellID(81685, 93178, 93179, 93180) then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then--Check if added to boss health
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)--And add if not.
		end
		self:ScheduleMethod(0.2, "CorruptingCrashTarget", args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
	if (spellId == 81538 or spellId == 93212 or spellId == 93213 or spellId == 93214) and destGUID == UnitGUID("player") and GetTime() - blazeSpam >= 4 then
		specWarnBlaze:Show()
		blazeSpam = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 43324 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and prewarned_Phase2 then
			prewarned_Phase2 = false
		elseif not prewarned_Phase2 and (h > 27 and h < 30) then
			warnPhase2Soon:Show()
			prewarned_Phase2 = true
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" or not self:IsInCombat() then return end
	if UnitDebuff("player", Corruption) and GetTime() - sickSpam >= 7 then
		specWarnSickness:Show()
		timerSickness:Start()
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(5)
		end
		sickSpam = GetTime()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 43622 then--Also remove from boss health when they die based on GUID
		DBM.BossHealth:RemoveBoss(args.destGUID)
	end
end