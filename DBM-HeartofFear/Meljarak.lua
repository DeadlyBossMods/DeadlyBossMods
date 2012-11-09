local mod	= DBM:NewMod(741, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62397)
mod:SetModelID(42645)
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
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_AURA"
)

local warnWhirlingBlade					= mod:NewTargetAnnounce(121896, 4)--Target scanning not tested
local warnRainOfBlades					= mod:NewSpellAnnounce(122406, 4)
local warnRecklessness					= mod:NewTargetAnnounce(125873, 3)
local warnImpalingSpear					= mod:NewPreWarnAnnounce(122224, 5, 3)--Pre warn your CC is about to break. Maybe need to localize it later to better explain what option is for.
local warnAmberPrison					= mod:NewTargetAnnounce(121881, 3)
local warnCorrosiveResin				= mod:NewTargetAnnounce(122064, 3)
local warnMending						= mod:NewCastAnnounce(122193, 4)
local warnQuickening					= mod:NewCastAnnounce(122149, 4)
local warnKorthikStrike					= mod:NewTargetAnnounce(123963, 3)
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
local specWarnKorthikStrikeOther		= mod:NewSpecialWarningTarget(123963, mod:IsHealer())
local yellKorthikStrike					= mod:NewYell(123963)
local specWarnWindBomb					= mod:NewSpecialWarningMove(131830)
local yellWindBomb						= mod:NewYell(131830)

--local timerWhirlingBladeCD				= mod:NewCDTimer(30, 121896)--30~60 sec. very large variable. timer useless?
local timerRainOfBladesCD				= mod:NewCDTimer(48, 122406)--48-64 sec variation now. so much for it being a precise timer.
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

local countdownImpalingSpear			= mod:NewCountdown(49, 122224) -- like Crossed Over, warns 1 sec earlier.

mod:AddBoolOption("AmberPrisonIcons", true)

local addsCount = 0
local amberPrisonIcon = 2
local strikeTarget = GetSpellInfo(123963)
local strikeWarned = false
local amberPrisonTargets = {}
local windBombTargets = {}
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetGroupMembers() do
		guids[UnitGUID("raid"..i) or "none"] = GetRaidRosterInfo(i)
	end
end

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
	strikeWarned = false
	table.wipe(amberPrisonTargets)
	table.wipe(windBombTargets)
	--timerWhirlingBladeCD:Start(35.5-delay)
	timerRainOfBladesCD:Start(60-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122224) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		warnImpalingSpear:Schedule(45)
		countdownImpalingSpear:Cancel()
		countdownImpalingSpear:Start()
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
		countdownImpalingSpear:Cancel()
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
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
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
		--timerWhirlingBladeCD:Start()
--	"<173.1> [UNIT_SPELLCAST_SUCCEEDED] The Kor'thik [[boss4:Kor'thik Strike::0:123963]]", -- [10366]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC8#Kor'thik Elite Blademaster#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10535]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC7#Kor'thik Elite Blademaster#2632#8#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10536]
	elseif spellId == 123963 and self:AntiSpam(2, 2) then--Kor'thik Strike Trigger, only triggered once, then all non CCed Kor'thik cast the strike about 2 sec later
		timerKorthikStrikeCD:Start()
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", strikeTarget) and not strikeWarned then--Warn you that you have a meteor
		specWarnKorthikStrike:Show()
		yellKorthikStrike:Yell()
		strikeWarned = true
		self:SendSync("KorthikStrikeTarget", UnitGUID("player"))--Screw target scanning, this way is much better, never wrong.
	elseif not UnitDebuff("player", strikeTarget) and strikeWarned then--reset warned status if you don't have debuff
		strikeWarned = false
	end
end

function mod:OnSync(msg, guid)
	--Make sure we build a table if we DCed mid fight, before we try comparing any syncs to that table.
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	if msg == "KorthikStrikeTarget" and guids[guid] then
		warnKorthikStrike:Show(guids[guid])
		if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
			specWarnKorthikStrikeOther:Show(guids[guid])
		end
	end
end
