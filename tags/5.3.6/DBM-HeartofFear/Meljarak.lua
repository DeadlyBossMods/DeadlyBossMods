local mod	= DBM:NewMod(741, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62397)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

-- CC can be cast before combat. So needs to seperate SPELL_AURA_APPLIED for pre-used CCs before combat.
mod:RegisterEvents(
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_APPLIED"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_AURA_UNFILTERED"
)

local warnWhirlingBlade					= mod:NewTargetAnnounce(121896, 4)--Target scanning not tested
local warnRainOfBlades					= mod:NewSpellAnnounce(122406, 4)
local warnRecklessness					= mod:NewTargetAnnounce(125873, 3)
local warnImpalingSpear					= mod:NewPreWarnAnnounce(122224, 10, 3)--Pre warn your CC is about to break. Maybe need to localize it later to better explain what option is for.
local warnAmberPrison					= mod:NewTargetAnnounce(121881, 3)
local warnCorrosiveResin				= mod:NewTargetAnnounce(122064, 3)
local warnMending						= mod:NewCastAnnounce(122193, 4)
local warnQuickening					= mod:NewTargetCountAnnounce(122149, 4)
local warnKorthikStrike					= mod:NewTargetAnnounce(123963, 3)
local warnWindBomb						= mod:NewTargetAnnounce(131830, 4)

local specWarnWhirlingBlade				= mod:NewSpecialWarningSpell(121896, nil, nil, nil, true)
local specWarnRainOfBlades				= mod:NewSpecialWarningSpell(122406, nil, nil, nil, true)
local specWarnRecklessness				= mod:NewSpecialWarningTarget(125873)
local specWarnAmberPrison				= mod:NewSpecialWarningYou(121881)
local yellAmberPrison					= mod:NewYell(121881)
local specWarnAmberPrisonOther			= mod:NewSpecialWarningSpell(121881, false)--Only people who are freeing these need to know this.
local specWarnCorrosiveResin			= mod:NewSpecialWarningRun(122064)
local yellCorrosiveResin				= mod:NewYell(122064, nil, false)
local specWarnCorrosiveResinPool		= mod:NewSpecialWarningMove(122125)
local specWarnMending					= mod:NewSpecialWarningInterrupt(122193)--Whoever is doing this or feels responsible should turn it on.
local specWarnQuickening				= mod:NewSpecialWarningCount(122149, mod:IsMagicDispeller())--This is not stack warning.
local specWarnKorthikStrike				= mod:NewSpecialWarningYou(123963)
local specWarnKorthikStrikeOther		= mod:NewSpecialWarningTarget(123963, mod:IsHealer())
local yellKorthikStrike					= mod:NewYell(123963)
local specWarnWindBomb					= mod:NewSpecialWarningMove(131830, nil, nil, nil, 3)
local specWarnWhirlingBladeMove			= mod:NewSpecialWarningMove(121898)
local yellWindBomb						= mod:NewYell(131830)
local specWarnReinforcements			= mod:NewSpecialWarningTarget("ej6554", not mod:IsHealer(), "specWarnReinforcements")--Also important to dps. (Espcially CC classes)

local timerRainOfBladesCD				= mod:NewCDTimer(48, 122406)--48-64 sec variation now. so much for it being a precise timer.
local timerRainOfBlades					= mod:NewBuffActiveTimer(7.5, 122406)
local timerRecklessness					= mod:NewBuffActiveTimer(30, 125873)--Heroic recklessness
local timerReinforcementsCD				= mod:NewNextCountTimer(50, "ej6554")--EJ says it's 45 seconds after adds die but it's actually 50 in logs. EJ is not updated for current tuning.
local timerImpalingSpear				= mod:NewTargetTimer(50, 122224)--Filtered to only show your own target, may change to a popup option later that lets you pick whether you show ALL of them or your own (all will be spammy)
local timerAmberPrisonCD				= mod:NewCDTimer(36, 121876, nil, false)--Reduce bar spam like Zarthik / each add has their own CD. This is on by default since it concerns everyone.
local timerCorrosiveResinCD				= mod:NewCDTimer(36, 122064, nil, false)--^^
local timerResidue						= mod:NewBuffFadesTimer(120, 122055)
local timerMendingCD					= mod:NewNextTimer(37, 122193, nil, false)--To reduce bar spam, only those dealing with this should turn CD bar on, off by default / 37~37.5 sec
local timerQuickeningCD					= mod:NewNextTimer(37.3, 122149, nil, false)--^^37.3~37.6sec.
local timerKorthikStrikeCD				= mod:NewCDTimer(50, 123963)--^^
local timerWindBombCD					= mod:NewCDTimer(6, 131830)--^^
local timerReinforcementsCD				= mod:NewNextCountTimer(50, "ej6554")--EJ says it's 45 seconds after adds die but it's actually 50 in logs. EJ is not updated for current tuning.

local berserkTimer						= mod:NewBerserkTimer(480)

local countdownImpalingSpear			= mod:NewCountdown(49, 122224, nil, nil, 10) -- like Crossed Over, warns 1 sec earlier.

mod:AddBoolOption("AmberPrisonIcons", true)

local Reinforcement = EJ_GetSectionInfo(6554)
local addsCount = 0
local amberPrisonIcon = 2
local zarthikCount = 0
local firstStriked = false
local strikeSpell = GetSpellInfo(123963)
local strikeTarget = nil
local amberPrisonTargets = {}
local windBombTargets = {}
local zarthikGUIDS = {}

local function warnAmberPrisonTargets()
	warnAmberPrison:Show(table.concat(amberPrisonTargets, "<, >"))
	table.wipe(amberPrisonTargets)
end

local function warnWindBombTargets()
	warnWindBomb:Show(table.concat(windBombTargets, "<, >"))
	table.wipe(windBombTargets)
	timerWindBombCD:Start()
end

function mod:OnCombatStart(delay)
	addsCount = 0
	amberPrisonIcon = 2
	zarthikCount = 0
	firstStriked = false
	strikeTarget = nil
	table.wipe(amberPrisonTargets)
	table.wipe(windBombTargets)
	table.wipe(zarthikGUIDS)
	timerKorthikStrikeCD:Start(18-delay)
	timerRainOfBladesCD:Start(60-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 122224 and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		warnImpalingSpear:Schedule(40)
		countdownImpalingSpear:Cancel()
		countdownImpalingSpear:Start()
		timerImpalingSpear:Start(args.destName)
	elseif args.spellId == 121881 then--Not a mistake, 121881 is targeting spellid.
		amberPrisonTargets[#amberPrisonTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnAmberPrison:Show()
			if not self:IsDifficulty("lfr25") then
				yellAmberPrison:Yell()
			end
		end
		self:Unschedule(warnAmberPrisonTargets)
		self:Schedule(0.3, warnAmberPrisonTargets)
		specWarnAmberPrisonOther:Show()
		if self.Options.AmberPrisonIcons then
			self:SetIcon(args.destName, amberPrisonIcon)
			if amberPrisonIcon == 2 then
				amberPrisonIcon = 1
			else
				amberPrisonIcon = 2
			end
		end
	elseif args.spellId == 122064 then
		warnCorrosiveResin:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 5) then
			specWarnCorrosiveResin:Show()
			yellCorrosiveResin:Yell()
		end
	elseif args.spellId == 122055 and args:IsPlayer() then
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
		timerResidue:Start(expires-GetTime())
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 122224 and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		countdownImpalingSpear:Cancel()
		timerImpalingSpear:Cancel(args.destName)
	elseif args.spellId == 121885 and self.Options.AmberPrisonIcons then--Not a mistake, 121885 is frozon spellid
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 122406 then
		warnRainOfBlades:Show()
		specWarnRainOfBlades:Show()
		timerRainOfBlades:Start()
		timerRainOfBladesCD:Start()
	elseif args.spellId == 121876 then
		timerAmberPrisonCD:Start(36, args.sourceGUID)
	elseif args.spellId == 122064 then
		timerCorrosiveResinCD:Start(36, args.sourceGUID)
	elseif args.spellId == 122193 then
		warnMending:Show()
		timerMendingCD:Start(nil, args.sourceGUID)
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnMending:Show(args.sourceName)
		end
	elseif args.spellId == 122149 then
		if not zarthikGUIDS[args.sourceGUID] then
			zarthikCount = zarthikCount + 1
			zarthikGUIDS[args.sourceGUID] = zarthikCount
		end
		local count = zarthikGUIDS[args.sourceGUID] -- This is set counter for dispel(1, 2, 3, 1, 2, 3.. repeats). Especailly for mass dispel. Very useful for PRIEST. NO SPAM. DO NOT REMOVE THIS. 
		warnQuickening:Show(count, args.sourceName)
		specWarnQuickening:Show(count)
		timerQuickeningCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 131830 then
		if #windBombTargets < 6 then -- prevent target warning spam.
			windBombTargets[#windBombTargets + 1] = destName
		end
		self:Unschedule(warnWindBombTargets)
		self:Schedule(0.3, warnWindBombTargets)
		if destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
			specWarnWindBomb:Show()
			if not self:IsDifficulty("lfr25") then
				yellWindBomb:Yell()
			end
		end
	elseif spellId == 122125 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnCorrosiveResinPool:Show()
	elseif spellId == 122064 and destGUID == UnitGUID("player") and self:AntiSpam(3, 5) then
		specWarnCorrosiveResin:Show()
	elseif spellId == 121898 and destGUID == UnitGUID("player") and not self:IsDifficulty("lfr25") and self:AntiSpam(3, 6) then
		specWarnWhirlingBladeMove:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62405 then--Sra'thik Amber-Trapper
		timerAmberPrisonCD:Cancel(args.destGUID)
		timerCorrosiveResinCD:Cancel(args.destGUID)
	elseif cid == 62408 then--Zar'thik Battle-Mender
		timerMendingCD:Cancel(args.destGUID)
		timerQuickeningCD:Cancel(args.destGUID)
		zarthikCount = 0
		table.wipe(zarthikGUIDS)
	elseif cid == 62402 then--The Kor'thik
		timerKorthikStrikeCD:Cancel()--No need for GUID cancelation, this ability seems to be off a timed trigger and they all do it together, unlike other mob sets.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerKorthikStrikeCD:Start(79)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 124850 and self:AntiSpam(2, 1) then--Whirling Blade (Throw Cast spellid)
		specWarnWhirlingBlade:Show()
	elseif spellId == 123963 and self:AntiSpam(2, 2) then--Kor'thik Strike Trigger, only triggered once, then all non CCed Kor'thik cast the strike about 2 sec later
		if firstStriked then--first Strike 32~33 sec cd. after 2nd strike 50~51 sec cd.
			timerKorthikStrikeCD:Start()
		else
			firstStriked = true
			timerKorthikStrikeCD:Start(32)
		end
	elseif spellId == 125873 then -- If adds die before Recklessness fades, CLEU not firing at all. To prevent fail, changes Recklessness check to UNIT_SPELLCAST_SUCCEEDED.
		local mobname = UnitName(uId)
		addsCount = addsCount + 1
		warnRecklessness:Show(L.name)
		specWarnRecklessness:Show(L.name)
		timerRecklessness:Start()
		timerReinforcementsCD:Start(50, addsCount)--We count them cause some groups may elect to kill a 2nd group of adds and start a second bar to form before first ends.
		specWarnReinforcements:Schedule(50, mobname)
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	if UnitDebuff(uId, strikeSpell) and not strikeTarget then
		strikeTarget = uId
		local name = DBM:GetUnitFullName(uId)
		warnKorthikStrike:Show(name)
		if name == UnitName("player") then
			specWarnKorthikStrike:Show()
			yellKorthikStrike:Yell()
		else
			specWarnKorthikStrikeOther:Show(name)
		end
	elseif strikeTarget and strikeTarget == uId and not UnitDebuff(uId, strikeSpell) then
		strikeTarget = nil
	end
end
