local mod	= DBM:NewMod(869, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71865)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--I saw garrosh fire boss1 and boss3 events, so use all 5 to be safe
)

--Stage 1: The True Horde
local warnDesecrate					= mod:NewTargetAnnounce(144748, 3)
local warnHellscreamsWarsong		= mod:NewSpellAnnounce(144821, 3)
local warnFireUnstableIronStar		= mod:NewSpellAnnounce(147047, 3)
--local warnKorkronWarbringer		= mod:NewSpellAnnounce("ej8292", 3)--unlike shaman which very conviniently cast 144585 the instant they join the fight, warbringers are going to need additional work
local warnFarseerWolfRider			= mod:NewSpellAnnounce("ej8294", 3, 144585)
local warnSiegeEngineer				= mod:NewSpellAnnounce("ej8298", 4, 144616)
local warnChainHeal					= mod:NewSpellAnnounce(144583, 4)
local warnChainLightning			= mod:NewSpellAnnounce(144584, 3)--Maybe turn off by default if too spammy
--Intermission: Realm of Y'Shaarj
local warnYShaarjsProtection		= mod:NewTargetAnnounce(144945, 2)
local warnAnnihilate				= mod:NewCastAnnounce(144969, 4)
--Stage Two: Power of Y'Shaarj
local warnWhirlingCorruption		= mod:NewSpellAnnounce(144985, 3)
local warnEmpWhirlingCorruption		= mod:NewSpellAnnounce(145037, 3)
local warnTouchOfYShaarj			= mod:NewTargetAnnounce(145071, 3)
local warnEmpTouchOfYShaarj			= mod:NewTargetAnnounce(145175, 3)
local warnEmpDesecrate				= mod:NewSpellAnnounce(144749, 3)
local warnGrippingDespair			= mod:NewStackAnnounce(145183, 2, nil, mod:IsTank())
local warnEmpGrippingDespair		= mod:NewStackAnnounce(145195, 3, nil, mod:IsTank())

--Stage 1: The True Horde
local specWarnDesecrate				= mod:NewSpecialWarningSpell(144748, nil, nil, nil, 2)
local yellDesecrate					= mod:NewYell(144748)
local specWarnHellscreamsWarsong	= mod:NewSpecialWarningSpell(144821, mod:IsTank() or mod:IsHealer())
local specWarnFireUnstableIronStar	= mod:NewSpecialWarningSpell(147047, nil, nil, nil, 3)
--local specWarnKorkronWarbringer	= mod:NewSpecialWarningSwitch("ej8292", not mod:IsHealer())
local specWarnFarseerWolfRider		= mod:NewSpecialWarningSwitch("ej8294", not mod:IsHealer())
local specWarnSiegeEngineer			= mod:NewSpecialWarningSwitch("ej8298", mod:IsDps())
local specWarnChainHeal				= mod:NewSpecialWarningInterrupt(144583)
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(144584, false)
--Intermission: Realm of Y'Shaarj
local specWarnAnnihilate			= mod:NewSpecialWarningSpell(144969, nil, nil, nil, 3)
--Stage Two: Power of Y'Shaarj
local specWarnWhirlingCorruption	= mod:NewSpecialWarningRun(144985, mod:IsMelee())
local specWarnEmpWhirlingCorruption	= mod:NewSpecialWarningRun(145037, mod:IsMelee())
local specWarnEmpDesecrate			= mod:NewSpecialWarningSpell(144749, nil, nil, nil, 2)
local specWarnGrippingDespair		= mod:NewSpecialWarningStack(145183, mod:IsTank(), 2)
local specWarnGrippingDespairOther	= mod:NewSpecialWarningTarget(145183, mod:IsTank())

--Stage 1: A Cry in the Darkness
local timerDesecrateCD				= mod:NewNextTimer(41, 144748)
local timerHellscreamsWarsongCD		= mod:NewNextTimer(42.2, 144821, nil, mod:IsTank() or mod:IsHealer())
--local timerKorkronWarbringerCD	= mod:NewCDTimer(30, "ej8292")
local timerFarseerWolfRiderCD		= mod:NewNextTimer(50, "ej8294", nil, nil, nil, 144585)--EJ says they come faster as phase progresses but all i saw was 3 spawn on any given pull and it was 30 50 50
local timerSiegeEngineerCD			= mod:NewNextTimer(40, "ej8298", nil, nil, nil, 144616)
local timerPowerIronStar			= mod:NewCastTimer(15, 144616)
--Intermission: Realm of Y'Shaarj
local timerYShaarjsProtection		= mod:NewCastTimer(60, 144945)
--Stage Two: Power of Y'Shaarj
local timerWhirlingCorruptionCD		= mod:NewCDTimer(40, 144985)--One bar for both, "empowered" makes timer too long. CD not yet known except for first
local timerWhirlingCorruption		= mod:NewBuffActiveTimer(9, 144985)
local timerTouchOfYShaarjCD			= mod:NewCDTimer(45, 145071)
local timerGrippingDespairCD		= mod:NewCDTimer(8.5, 145183)
local timerGrippingDespair			= mod:NewTargetTimer(15, 145183, nil, mod:IsTank())

local soundWhirlingCorrpution		= mod:NewSound(144985)
local countdownPowerIronStar		= mod:NewCountdown(15, 144616)
local countdownWhirlingCorruption	= mod:NewCountdown(40, 144985)

local touchOfYShaarjTargets = {}
local firstIronStar = false
local engineerDied = 0
local phase = 1
local UnitExists = UnitExists

local function warnTouchOfYShaarjTargets(spellId)
	if spellId == 145171 then
		warnEmpTouchOfYShaarj:Show(table.concat(touchOfYShaarjTargets, "<, >"))
	else
		warnTouchOfYShaarj:Show(table.concat(touchOfYShaarjTargets, "<, >"))
	end
	table.wipe(touchOfYShaarjTargets)
end

--Another pre target scan (ie targets player BEFORE cast like iron qon)
local function DesecrateScan()
	if UnitExists("boss1target") and not mod:IsTanking("boss1target", "boss1") then--Boss 1 is looking at someone that isn't his highest threat or a tank (have to filter tanks cause he looks at them to cast impale, have to filter his highest threat in case it's not a tank, ie a healer)
		mod:Unschedule(DesecrateScan)
		local targetname = DBM:GetUnitFullName("boss1target")
		warnDesecrate:Show(targetname)
		if UnitIsUnit("boss1target", "player") then--you are target
			yellDesecrate:Yell()
		end
	else
		mod:Schedule(0.25, DesecrateScan)
	end
end

function mod:OnCombatStart(delay)
	firstIronStar = false
	engineerDied = 0
	phase = 1
	table.wipe(touchOfYShaarjTargets)
	self:Schedule(3, DesecrateScan)
	timerDesecrateCD:Start(10.5-delay)
	timerSiegeEngineerCD:Start(20-delay)
	timerHellscreamsWarsongCD:Start(22-delay)
	timerFarseerWolfRiderCD:Start(30-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144583 then
		local source = args.sourceName
		warnChainHeal:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainHeal:Show(source)
		end
	elseif args.spellId == 144584 then
		local source = args.sourceName
		warnChainLightning:Show()
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnChainLightning:Show(source)
		end
	elseif args.spellId == 144969 then
		warnAnnihilate:Show()
		specWarnAnnihilate:Show()
	elseif args.spellId == 144985 then
		warnWhirlingCorruption:Show()
		specWarnWhirlingCorruption:Show()
		timerWhirlingCorruption:Start()
		--timerWhirlingCorruptionCD:Start()
		--countdownWhirlingCorruption:Start()
		soundWhirlingCorrpution:Play()
	elseif args.spellId == 145037 then
		warnEmpWhirlingCorruption:Show()
		specWarnEmpWhirlingCorruption:Show()
		timerWhirlingCorruption:Start()
		--timerWhirlingCorruptionCD:Start()
		--countdownWhirlingCorruption:Start()
		soundWhirlingCorrpution:Play()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144748 then
		self:BossTargetScanner(71865, "DesecrateTarget", 0.025, 12)--Forgot to see if this is working
		warnDesecrate:Show()
		specWarnDesecrate:Show()
		if phase == 2 then
			timerDesecrateCD:Start(35)
		else
			timerDesecrateCD:Start()
		end
	elseif args.spellId == 144749 then
		self:Unschedule(DesecrateScan)
		warnEmpDesecrate:Show()
		specWarnEmpDesecrate:Show()
		if phase == 2 then
			timerDesecrateCD:Start(35)
			self:Schedule(30, DesecrateScan)
		else
			timerDesecrateCD:Start()
			self:Schedule(35, DesecrateScan)
		end
	elseif args:IsSpellID(145183, 145195) then--Can miss, so we start timer here
		timerGrippingDespairCD:Start()
--[[	elseif args:IsSpellID(145065, 145171) then--Seems no longer in combat log.
		--"<259.0 20:29:21> [CLEU] SPELL_CAST_START#false#0xF15118B900011259#Garrosh Hellscream#68168#0##nil#-2147483648#-2147483648#145065#Touch of Y'Shaarj#32", -- [41491]
		--"<259.9 20:29:21> [CLEU] SPELL_CAST_SUCCESS#false#0x01000000001FC86D#Torima#1300#0##nil#-2147483648#-2147483648#31224#Cloak of Shadows#1", -- [41583]
		--"<260.7 20:29:22> [CLEU] SPELL_MISSED#false#0xF15118B900011259#Garrosh Hellscream#68168#0#0x01000000001FC86D#Torima#1300#0#145065#Touch of Y'Shaarj#32#IMMUNE#nil", -- [41679]
		timerTouchOfYShaarjCD:Start()--]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144945 then--Intermission (there are earlier events but until the shield goes up phase 1 abilities can still be cast. the phase isn't truely over until this is cast, this is why we don't use the 2-3 second earlier events
		timerDesecrateCD:Cancel()
		self:Unschedule(DesecrateScan)
		timerSiegeEngineerCD:Cancel()
		timerFarseerWolfRiderCD:Cancel()
		timerHellscreamsWarsongCD:Cancel()
		warnYShaarjsProtection:Show(args.destName)
		timerYShaarjsProtection:Start()
	elseif args:IsSpellID(145065, 145171) then
		touchOfYShaarjTargets[#touchOfYShaarjTargets + 1] = args.destName
		self:Unschedule(warnTouchOfYShaarjTargets)
		self:Schedule(0.5, warnTouchOfYShaarjTargets, args.spellId)
		timerTouchOfYShaarjCD:Start()
	elseif args:IsSpellID(145071, 145175) then--Touch of Yshaarj Spread IDs?

	elseif args:IsSpellID(145183, 145195) then
		local amount = args.amount or 1
		if args.spellId == 145183 then
			warnGrippingDespair:Show(args.destName, amount)
		else
			warnEmpGrippingDespair:Show(args.destName, amount)
		end
		timerGrippingDespair:Start(args.destName)
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnGrippingDespair:Show(amount)
			else
				specWarnGrippingDespairOther:Show(args.destName)
			end
		end
	elseif args.spellId == 144585 then
		warnFarseerWolfRider:Show()
		specWarnFarseerWolfRider:Show()
		timerFarseerWolfRiderCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(145183, 145195) then
		timerGrippingDespair:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71984 then--Siege Engineer
		engineerDied = engineerDied + 1
		if engineerDied == 2 then
			warnFireUnstableIronStar:Cancel()
			specWarnFireUnstableIronStar:Cancel()
			timerPowerIronStar:Cancel()
			countdownPowerIronStar:Cancel()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 144821 then--Warsong. Does not show in combat log
		warnHellscreamsWarsong:Show()
		specWarnHellscreamsWarsong:Show()
		timerHellscreamsWarsongCD:Start()
	elseif spellId == 144956 then--Jump To Ground (intermission ending) Used instead of 144945 because 144945 can be removed early during intermission for free damage.
		phase = 2
		timerGrippingDespairCD:Start(5.5)
		self:Schedule(5, DesecrateScan)
		timerDesecrateCD:Start(10)
		timerTouchOfYShaarjCD:Start(15)
		timerWhirlingCorruptionCD:Start(30)
		countdownWhirlingCorruption:Start(30)
	end
end

--[[
"<10.5 19:58:04> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Garrosh Hellscream
"<30.5 19:58:24> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_mage_firestarter.blp:20|t|cFFFF0000Siege Engineers|r appears in the wings and begins to cast |cFFFF0000|Hspell:144616|h[Power Iron Star]|h|r!#Garrosh Hellscream#0#false", -- [1]
"<75.5 19:59:09> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_mage_firestarter.blp:20|t|cFFFF0000Siege Engineers|r appears in the wings and begins to cast |cFFFF0000|Hspell:144616|h[Power Iron Star]|h|r!#Garrosh Hellscream#0#false", -- [2]
"<115.4 19:59:49> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_mage_firestarter.blp:20|t|cFFFF0000Siege Engineers|r appears in the wings and begins to cast |cFFFF0000|Hspell:144616|h[Power Iron Star]|h|r!#Garrosh Hellscream#0#false", -- [3]
"<155.5 20:00:29> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_mage_firestarter.blp:20|t|cFFFF0000Siege Engineers|r appears in the wings and begins to cast |cFFFF0000|Hspell:144616|h[Power Iron Star]|h|r!#Garrosh Hellscream#0#false", -- [4]
--]]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:144616") then
		engineerDied = 0
		warnSiegeEngineer:Show()--Possibly an earlier place to warn for engineer though, they shouldn't cast this instantly as they have to run from side first
		specWarnSiegeEngineer:Show()
		if not firstIronStar then
			firstIronStar = true
			timerSiegeEngineerCD:Start(45)
		else
			timerSiegeEngineerCD:Start()
		end
		timerPowerIronStar:Start()
		countdownPowerIronStar:Start()
		warnFireUnstableIronStar:Schedule(15)
		specWarnFireUnstableIronStar:Schedule(15)
	end
end
