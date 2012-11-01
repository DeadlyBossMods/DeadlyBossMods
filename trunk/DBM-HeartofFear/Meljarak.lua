local mod	= DBM:NewMod(741, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62397)
mod:SetModelID(42645)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_AURA"
)

local warnWhirlingBlade					= mod:NewTargetAnnounce(121896, 4)--Target scanning not tested
local warnRainOfBlades					= mod:NewSpellAnnounce(122406, 4)
local warnRecklessness					= mod:NewTargetAnnounce(125873, 3)
local warnImpalingSpear					= mod:NewPreWarnAnnounce(125873, 5, 3)--Pre warn your CC is about to break. Maybe need to localize it later to better explain what option is for.
local warnAmberPrison					= mod:NewTargetAnnounce(121881, 3)
local warnCorrosiveResin				= mod:NewTargetAnnounce(122064, 3)
local warnMending						= mod:NewCastAnnounce(122193, 4)
local warnQuickening					= mod:NewCastAnnounce(122149, 4)
local warnKorthikStrike					= mod:NewSpellAnnounce(123963, 3)--Target scanning does NOT work
local warnWindBomb						= mod:NewTargetAnnounce(131830, 4)

local specWarnWhirlingBlade				= mod:NewSpecialWarningSpell(121896, nil, nil, nil, true)
local specWarnRainOfBlades				= mod:NewSpecialWarningSpell(122406, nil, nil, nil, true)
local specWarnRecklessness				= mod:NewSpecialWarningTarget(125873)
local specWarnReinforcements			= mod:NewSpecialWarningSpell("ej6554", mod:IsTank())
local specWarnAmberPrison				= mod:NewSpecialWarningYou(121881)
local yellAmberPrison					= mod:NewYell(121881)
local specWarnAmberPrisonOther			= mod:NewSpecialWarningSpell(121881, false)--Only people who are freeing these need to know this.
local specWarnCorrosiveResin			= mod:NewSpecialWarningRun(122064)
local yellCorrosiveResin				= mod:NewYell(122064, nil, false)
local specWarnCorrosiveResinPool		= mod:NewSpecialWarningMove(122125)
local specWarnMending					= mod:NewSpecialWarningInterrupt(122193)--Whoever is doing this or feels responsible should turn it on.
local specWarnQuickening				= mod:NewSpecialWarningSpell(122149, false)--^^
local specWarnKorthikStrike				= mod:NewSpecialWarningYou(123963)
local yellKorthikStrike					= mod:NewYell(123963)
local specWarnWindBomb					= mod:NewSpecialWarningMove(131830)
local yellWindBomb						= mod:NewYell(131830)

local timerWhirlingBladeCD				= mod:NewNextTimer(45.5, 121896)
local timerRainOfBladesCD				= mod:NewNextTimer(61.5, 122406)--60 CD, but Cd starts when last cast ends, IE 60+cast time. Starting cd off cast start is 61.5, but on pull it's 60.0
local timerRecklessness					= mod:NewBuffActiveTimer(30, 125873)
local timerReinforcementsCD				= mod:NewNextCountTimer(50, "ej6554")--EJ says it's 45 seconds after adds die but it's actually 50 in logs. EJ is not updated for current tuning.
local timerImpalingSpear				= mod:NewTargetTimer(50, 122224)--Filtered to only show your own target, may change to a popup option later that lets you pick whether you show ALL of them or your own (all will be spammy)
local timerAmberPrisonCD				= mod:NewNextTimer(36, 121876)--each add has their own CD. This is on by default since it concerns everyone.
local timerCorrosiveResinCD				= mod:NewNextTimer(36, 122064)--^^
local timerMendingCD					= mod:NewNextTimer(36, 122193, nil, false)--To reduce bar spam, only those dealing with this should turn CD bar on, off by default
local timerQuickeningCD					= mod:NewNextTimer(36, 122149, nil, false)--^^
local timerKorthikStrikeCD				= mod:NewCDTimer(32, 123963)--^^
local timerWindBombCD					= mod:NewCDTimer(6, 131830)--^^

local berserkTimer						= mod:NewBerserkTimer(480)

mod:AddBoolOption("AmberPrisonIcons", true)

local scansDone = 0
local addsCount = 0
local amberPrisonIcon = 2
local strikeTarget = GetSpellInfo(123963)
local strikeWarned = false
local amberPrisonTargets = {}
local windBombTargets = {}

local function warnAmberPrisonTargets()
	warnAmberPrison:Show(table.concat(amberPrisonTargets, "<, >"))
	table.wipe(amberPrisonTargets)
end

local function warnWindBombTargets()
	warnWindBomb:Show(table.concat(windBombTargets, "<, >"))
	table.wipe(windBombTargets)
	timerWindBombCD:Start()
end

local function getBossuId()
	local uId
	if UnitExists("boss1") or UnitExists("boss2") or UnitExists("boss3") or UnitExists("boss4") then
		for i = 1, 4 do
			if UnitName("boss"..i) == L.name then
				uId = "boss"..i
				break
			end
		end
	else
		for i = 1, DBM:GetGroupMembers() do
			if UnitName("raid"..i.."target") == L.name and not UnitIsPlayer("raid"..i.."target") then
				uId = "raid"..i.."target"
				break
			end			
		end
	end
	return uId
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check shannox's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	local uId = getBossuId()
	if uId and UnitExists(uId.."target") and UnitDetailedThreatSituation(unit, uId) then
		return true
	end
	return false
end

function mod:ScanHandler(SpellID, GUID, ScanComplete)
	scansDone = scansDone + 1
	local targetname = nil
	for i=1, DBM:GetGroupMembers() do
		if UnitGUID("raid"..i.."target") == GUID then
			targetname = DBM:GetUnitFullName("raid"..i.."targettarget")
			break
		end
	end
	if UnitExists(targetname) then
		local uId = DBM:GetRaidUnitId(targetname)
		if isTank(uId) and not ScanComplete then--He's targeting a tank.
			if scansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "ScanHandler", SpellID, GUID)--Check multiple times to be sure it's not on someone other then tank.
			else
				self:ScanHandler(SpellID, GUID, true)--It's still on tank, force true isTank and activate else rule and warn trap is on tank.
			end
		else--He's not targeting a tank target (or isTank was set to true after 12 scans) so this has to be right target.
			self:UnscheduleMethod("ScanHandler")--Unschedule all checks just to be sure none are running, we are done.
			if SpellID == 122409 then
			--	self:KorthikStrikeTarget(targetname)
				print(targetname, SpellID)
			else
			--	self:WhirlingBladeTarget(targetname)
				print(targetname, SpellID)
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "ScanHandler", SpellID, GUID)
		end
--		print("Target scanning failed", SpellID)
	end
end

function mod:OnCombatStart(delay)
	scansDone = 0
	addsCount = 0
	amberPrisonIcon = 2
	strikeWarned = false
	table.wipe(amberPrisonTargets)
	table.wipe(windBombTargets)
	timerWhirlingBladeCD:Start(35.5-delay)
	timerRainOfBladesCD:Start(60-delay)
	berserkTimer:Start(-delay)
	DBM.InfoFrame:SetHeader("Kor'thik Strike Debug")--Temp frame. just need to see if unit aura works way i think it does and if timing is sufficent to avoid ugly target scanning. If it does, i can actually just do it like ragnaros meteors
	DBM.InfoFrame:Show(1, "playerbaddebuff", 123963)
end

function mod:OnCombatEnd()
	DBM.InfoFrame:Hide()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122224) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Schedule(45)
		timerImpalingSpear:Start(args.destName)
	elseif args:IsSpellID(121881) then--Not a mistake, 121881 is targeting spellid.
		amberPrisonTargets[#amberPrisonTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnAmberPrison:Show()
			yellAmberPrison:Yell()
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
	elseif args:IsSpellID(122064) then
		warnCorrosiveResin:Show(args.destName)
		if args:IsPlayer() then
			specWarnCorrosiveResin:Show()
			yellCorrosiveResin:Yell()
		end
	elseif args:IsSpellID(122125) and args:IsPlayer() then
		specWarnCorrosiveResinPool:Show()
	elseif args:IsSpellID(125873) then
		addsCount = addsCount + 1
		warnRecklessness:Show(args.destName)
		specWarnRecklessness:Show(args.destName)
		timerRecklessness:Start()
		timerReinforcementsCD:Start(50, addsCount)--We count them cause some groups may elect to kill a 2nd group of adds and start a second bar to form before first ends.
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122224) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		timerImpalingSpear:Cancel(args.destName)
	elseif args:IsSpellID(121885) and self.Options.AmberPrisonIcons then--Not a mistake, 121885 is frozon spellid
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122406) then
		warnRainOfBlades:Show()
		specWarnRainOfBlades:Show()
		timerRainOfBladesCD:Start()
	elseif args:IsSpellID(121876) then
		timerAmberPrisonCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122064) then
		timerCorrosiveResinCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122193) then
		warnMending:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnMending:Show(args.sourceName)
		end
		timerMendingCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122149) then
		warnQuickening:Show()
		specWarnQuickening:Show(args.sourceName)
		timerQuickeningCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122409) then
		scansDone = 0
		self:ScanHandler(122409, args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, destName, destGUID, _, _, _, spellId)
	if spellId == 131830 then
		windBombTargets[#windBombTargets + 1] = destName
		self:Unschedule(warnWindBombTargets)
		self:Schedule(0.3, warnWindBombTargets)
		if destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
			specWarnWindBomb:Show()
			yellWindBomb:Yell()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Reinforcements or msg:find(L.Reinforcements) then
		specWarnReinforcements:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62405 then--Sra'thik Amber-Trapper
		timerAmberPrisonCD:Cancel(args.destGUID)
		timerCorrosiveResinCD:Cancel(args.destGUID)
	elseif cid == 62408 then--Zar'thik Battle-Mender
		timerMendingCD:Cancel(args.destGUID)
		timerQuickeningCD:Cancel(args.destGUID)
	elseif cid == 62402 then--The Kor'thik
		timerKorthikStrikeCD:Cancel()--No need for GUID cancelation, this ability seems to be off a timed trigger and they all do it together, unlike other mob sets.
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 124850 and self:AntiSpam(2, 1) then--Whirling Blade (Throw Cast spellid)
		specWarnWhirlingBlade:Show()
		timerWhirlingBladeCD:Start()
		local GUID = UnitGUID(uId)
		scansDone = 0
		self:ScanHandler(124850, GUID)
--	"<173.1> [UNIT_SPELLCAST_SUCCEEDED] The Kor'thik [[boss4:Kor'thik Strike::0:123963]]", -- [10366]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC8#Kor'thik Elite Blademaster#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10535]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC7#Kor'thik Elite Blademaster#2632#8#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10536]
	elseif spellId == 123963 and self:AntiSpam(2, 2) then--Kor'thik Strike Trigger, only triggered once, then all non CCed Kor'thik cast the strike about 2 sec later
		warnKorthikStrike:Show()
		timerKorthikStrikeCD:Start()
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", strikeTarget) and not strikeWarned then--Warn you that you have a meteor
		specWarnKorthikStrike:Show()
		yellKorthikStrike:Yell()
		strikeWarned = true
	elseif not UnitDebuff("player", strikeTarget) and strikeWarned then--reset warned status if you don't have debuff
		strikeWarned = false
	end
end
