local mod	= DBM:NewMod(821, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68065, 70212, 70235, 70247)--flaming 70212. Frozen 70235, Venomous 70247
mod:SetMainBossID(68065)
mod:SetModelID(47414)--Hydra Fire Head, 47415 Frost Head, 47416 Poison Head
mod:SetUsedIcons(7, 6, 4, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

--25H no venom heads killed
--http://worldoflogs.com/reports/rt-1qbbhz82okzsklik/xe/?enc=bosses&boss=68065&x=spell+%3D+%22Icy+Touch%22+or+%28spellid+%3D+139850+or+spell+%3D+%22Rampage%22%29+and+targetname+%3D+%22Omegal%22+or+%28spellid+%3D+139822+or+spellid+%3D+139866%29+and+fulltype+%3D+SPELL_CAST_SUCCESS
--25N no fire heads killed
--http://worldoflogs.com/reports/bew77b3cbc6bqd40/xe/?s=3537&e=3951&x=spell+%3D+%22Icy+Touch%22+or+%28spellid+%3D+139850+or+spell+%3D+%22Rampage%22%29+and+targetname+%3D+%22Omegal%22+or+%28spellid+%3D+139822+or+spellid+%3D+139866%29+and+fulltype+%3D+SPELL_CAST_SUCCESS
--25N no ice heads killed
--http://worldoflogs.com/reports/t4bwnbajfwm9gsbv/xe/?s=2435&e=2856&x=spell+%3D+%22Icy+Touch%22+or+%28spellid+%3D+139850+or+spell+%3D+%22Rampage%22%29+and+targetname+%3D+%22Omegal%22+or+%28spellid+%3D+139822+or+spellid+%3D+139866%29+and+fulltype+%3D+SPELL_CAST_SUCCESS

local warnRampage				= mod:NewCountAnnounce(139458, 3)
local warnRampageFaded			= mod:NewFadesAnnounce(139458, 2)
local warnArcticFreeze			= mod:NewStackAnnounce(139843, 3, nil, mod:IsTank() or mod:IsHealer())
local warnIgniteFlesh			= mod:NewStackAnnounce(137731, 3, nil, mod:IsTank() or mod:IsHealer())
local warnRotArmor				= mod:NewStackAnnounce(139840, 3, nil, mod:IsTank() or mod:IsHealer())
local warnArcaneDiffusion		= mod:NewStackAnnounce(139993, 3, nil, mod:IsTank() or mod:IsHealer())--Heroic
local warnCinders				= mod:NewTargetAnnounce(139822, 4)
local warnTorrentofIce			= mod:NewTargetAnnounce(139889, 4)
local warnNetherTear			= mod:NewSpellAnnounce(140138, 3)--Heroic

local specWarnRampage			= mod:NewSpecialWarningCount(139458, nil, nil, nil, 2)
local specWarnRampageFaded		= mod:NewSpecialWarningFades(139458)--Spread back out quickly (plus for tanks to get back to heads and face them correctly)
local specWarnArcticFreeze		= mod:NewSpecialWarningStack(139843, mod:IsTank(), 2)
local specWarnIgniteFlesh		= mod:NewSpecialWarningStack(137731, mod:IsTank(), 2)
local specWarnRotArmor			= mod:NewSpecialWarningStack(139840, mod:IsTank(), 2)
local specWarnArcaneDiffusion	= mod:NewSpecialWarningStack(139993, mod:IsTank(), 2)
local specWarnCinders			= mod:NewSpecialWarningYou(139822)
local specWarnCindersMove		= mod:NewSpecialWarningMove(139836)--Fire left on ground after the fact
local yellCinders				= mod:NewYell(139822)
local specWarnTorrentofIceYou	= mod:NewSpecialWarningRun(139889)
local yellTorrentofIce			= mod:NewYell(139889)
local specWarnTorrentofIce		= mod:NewSpecialWarningMove(139909)--Ice left on ground by the beam
local specWarnNetherTear		= mod:NewSpecialWarningSwitch("ej7816", mod:IsDps())

local timerRampage				= mod:NewBuffActiveTimer(21, 139458)
mod:AddBoolOption("timerBreaths", mod:IsTank() or mod:IsHealer(), "timer")--Better to have one option for breaths than 4
local timerArcticFreezeCD		= mod:NewCDTimer(16, 139843, nil, nil, false)--We keep timers for artic and freeze for engage, since the breaths might be out of sync until after first rampage
local timerRotArmorCD			= mod:NewCDTimer(16, 139840, nil, nil, false)--^
local timerBreathsCD			= mod:NewTimer(16, "timerBreathsCD", 137731, nil, false)--Rest of breaths after first rampage consolidated into one timer instead of 2

--TODO, maybe monitor length since last cast and if it's 28 instead of 25, make next timer also 28 for remainder of that head phase (then return to 25 after rampage unless we detect another 28)
--TODO, Verify timers on normal. WoL bugs out and combines GUIDs making it hard to determine actual CDs in my logs.
local timerCinderCD				= mod:NewCDTimer(25, 139822, nil, not mod:IsTank())--The cd is either 25 or 28 (either or apparently, no in between). it can even swap between teh two in SAME pull
local timerTorrentofIce			= mod:NewBuffFadesTimer(11, 139866)
local timerTorrentofIceCD		= mod:NewCDTimer(25, 139866, nil, not mod:IsTank())--Same as bove, either 25 or 28
--local timerAcidRainCD			= mod:NewCDTimer(13.5, 139850, nil, false)--Can only give time for next impact, no cast trigger so cannot warn cast very effectively. Also seems not possible to separate heads on this one. In my log every cast came from same head GUID
local timerNetherTearCD			= mod:NewCDTimer(25, 140138)--Heroic. Also either 25 or 28. On by default since these require more pre planning than fire and ice.

local soundCinders				= mod:NewSound(139822)
local soundTorrentofIce			= mod:NewSound(139889)

mod:AddBoolOption("SetIconOnCinders", true)
mod:AddBoolOption("SetIconOnTorrentofIce", true)

mod:AddDropdownOption("AnnounceCooldowns", {"Never", "Every", "EveryTwo", "EveryThree", "EveryTwoExcludeDiff", "EveryThreeExcludeDiff"}, "Never", "misc")
--CD order options that change based on raid dps and diffusion strat. With high dps, you need 3 groups, with lower dps (and typically heroic) you need 3. Also, on heroic, many don't cd rampage when high stack diffusion tank can be healed off of to heal raid.
--"Every": for groups that prefer to assign certain rampage numbers to players (e.g. for CD at the 4th rampage only) (maybe "Every" should even be the default option for everyone, beside of any cooldowns?)

--count will go to hell fast on a DC though. Need to figure out some kind of head status recovery to get active/inactive head counts.
--Maybe add an info frame that shows head status too would be cool such as
---------------------------
--Flaming head: A: 0 I: 2 -
--Frozen head: A: 1 I: 1  -
--Venomous head: A: 1 I: 1-
---------------------------
local fireInFront = 0
local venomInFront = 0
local iceInFront = 0
local arcaneInFront = 0
local fireBehind = 0
local venomBehind = 0
local iceBehind = 0
local arcaneBehind = 0
local rampageCount = 0
local rampageCast = 0
local cinderIcon = 7
local iceIcon = 6
local activeHeadGUIDS = {}
local iceTorrent = GetSpellInfo(139857)
local torrentTarget1 = nil
local torrentTarget2 = nil
local arcaneRecent = false

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss' highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	if UnitExists("boss2target") and UnitDetailedThreatSituation(unit, "boss2") then
		return true
	end
	if UnitExists("boss3target") and UnitDetailedThreatSituation(unit, "boss3") then
		return true
	end
	if UnitExists("boss4target") and UnitDetailedThreatSituation(unit, "boss4") then
		return true
	end
	if UnitExists("boss5target") and UnitDetailedThreatSituation(unit, "boss5") then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	table.wipe(activeHeadGUIDS)
	rampageCount = 0
	rampageCast = 0
	fireInFront = 0
	venomInFront = 0
	iceInFront = 0
	fireBehind = 1
	venomBehind = 0
	iceBehind = 0
	cinderIcon = 7
	iceIcon = 6
	torrentTarget1 = nil
	torrentTarget2 = nil
	if self:IsDifficulty("heroic10", "heroic25") then
		arcaneBehind = 1
		arcaneInFront = 0
		arcaneRecent = false
		timerCinderCD:Start(13)
		timerNetherTearCD:Start()
	elseif self:IsDifficulty("normal10", "normal25") then
		timerCinderCD:Start()
	else
		timerCinderCD:Start(58)
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 140138 then
		warnNetherTear:Show()
		specWarnNetherTear:Show()
		timerNetherTearCD:Start(args.sourceGUID)
	elseif args.spellId == 139866 then
		timerTorrentofIceCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 139843 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if isTank(uId) then
			local amount = args.amount or 1
			warnArcticFreeze:Show(args.destName, amount)
			if args:IsPlayer() and amount >= 2 then
				specWarnArcticFreeze:Show(amount)
			end
			if not self.Options.timerBreaths then return end
			if rampageCount == 0 then--In first phase, the breaths aren't at same time because the cds don't start until the specific head is engaged, thus, they can be desynced 1-3 seconds, so we want each breath to use it's own timer until after first rampage
				timerArcticFreezeCD:Start()
			else
				timerBreathsCD:Start()
			end
		end
	elseif args.spellId == 137731 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if isTank(uId) then
			local amount = args.amount or 1
			warnIgniteFlesh:Show(args.destName, amount)
			if args:IsPlayer() and amount >= 2 then
				specWarnIgniteFlesh:Show(amount)
			end
			if not self.Options.timerBreaths then return end
			timerBreathsCD:Start()
		end
	elseif args.spellId == 139840 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if isTank(uId) then
			local amount = args.amount or 1
			warnRotArmor:Show(args.destName, amount)
			if args:IsPlayer() and amount >= 2 then
				specWarnRotArmor:Show(amount)
			end
			if not self.Options.timerBreaths then return end
			if rampageCount == 0 then--In first phase, the breaths aren't at same time because the cds don't start until the specific head is engaged, thus, they can be desynced 1-3 seconds, so we want each breath to use it's own timer until after first rampage
				timerRotArmorCD:Start()
			else
				timerBreathsCD:Start()
			end
		end
	elseif args.spellId == 139993 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if isTank(uId) then
			local amount = args.amount or 1
			warnArcaneDiffusion:Show(args.destName, amount)
			if args:IsPlayer() and amount >= 2 then
				specWarnArcaneDiffusion:Show(amount)
			end
			if not self.Options.timerBreaths then return end
			timerBreathsCD:Start()
		end
	elseif args.spellId == 139822 then
		warnCinders:Show(args.destName)
		timerCinderCD:Start(args.sourceGUID)
		if args:IsPlayer() then
			specWarnCinders:Show()
			yellCinders:Yell()
			soundCinders:Play()
		end
		if self.Options.SetIconOnCinders then
			self:SetIcon(args.destName, cinderIcon)
			if cinderIcon == 7 then--Alternate cinder icons because you can have two at once in later fight.
				cinderIcon = 2--orange is closest match to red for a fire like color
			else
				cinderIcon = 7
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 139822 and self.Options.SetIconOnCinders then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 139836 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnCindersMove:Show()
	--[[elseif spellId == 139850 and self:AntiSpam(2, 1) then--Does not work right because sourceguid is not the head, it's an invisible mob and it seems that invisible mob can be used by more than one head (so no way to separate teh Cds of 2 or more heads
		timerAcidRainCD:Start(sourceGUID)--]]
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 139909 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnTorrentofIce:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:139458") then
		rampageCount = rampageCount + 1
		warnRampage:Show(rampageCount)
		specWarnRampage:Show(rampageCount)
		timerArcticFreezeCD:Cancel()
		timerRotArmorCD:Cancel()
		timerBreathsCD:Cancel()
		timerCinderCD:Cancel()
		timerTorrentofIceCD:Cancel()
--		timerAcidRainCD:Cancel()
		timerNetherTearCD:Cancel()
		timerRampage:Start()
		if not self.Options.AnnounceCooldowns == "Every" then
			if self.Options.AnnounceCooldowns == "Never" or (arcaneInFront > 0 or arcaneRecent) and (self.Options.AnnounceCooldowns == "EveryTwoExcludeDiff" or self.Options.AnnounceCooldowns == "EveryThreeExcludeDiff") then return end--You have a diffused player, don't call out cds
			if (self.Options.AnnounceCooldowns == "EveryTwoExcludeDiff" or self.Options.AnnounceCooldowns == "EveryTwo") and rampageCast == 2 then rampageCast = 0 end--Option is set to one of the twos and we're already at 2, reset cast count
			if rampageCast == 3 then rampageCast = 0 end--We already checked and know option isn't set to 2 or never, so it's definitely set to 3, no need to check option.
		end
		rampageCast = rampageCast + 1
		if rampageCast > 10 then return end --failsafe
		if DBM.Options.UseMasterVolume then
			PlaySoundFile("Interface\\AddOns\\DBM-Core\\Sounds\\Corsica_S\\"..rampageCast..".ogg", "Master")
		else
			PlaySoundFile("Interface\\AddOns\\DBM-Core\\Sounds\\Corsica_S\\"..rampageCast..".ogg")
		end
	elseif msg == L.rampageEnds or msg:find(L.rampageEnds) then
		arcaneRecent = false
		warnRampageFaded:Show()
		specWarnRampageFaded:Show()
		if self.Options.timerBreaths then
			timerBreathsCD:Start(10)
		end
		--timers below may need adjusting by 1-2 seconds as I had to substitute last rampage SPELL_DAMAGE event for rampage ends emote when i reg expressioned these timers on WoL
		if iceBehind > 0 then
			if self:IsDifficulty("heroic10", "heroic25") then
				timerTorrentofIceCD:Start(12)--12-17 second variation on heroic
			else
				timerTorrentofIceCD:Start(8)--8-12 second variation on normal
			end
		end
		if fireBehind > 0 then
			if self:IsDifficulty("lfr25") then
				timerCinderCD:Start(12)--12-15 second variatio
			else
				timerCinderCD:Start(5)--5-8 second variatio
			end
		end
--[[		if venomBehind > 0 then
			timerAcidRainCD:Start(15)--15-20 seconds after rampage ends, unknown heroic value, this number is from normal log.
		end--]]
		if arcaneBehind > 0 then
			timerNetherTearCD:Start(15)--15-18 seconds after rampages end
		end
	end
end

local function CheckHeads(GUID)
	for i = 1, 5 do
		if UnitExists("boss"..i) and not activeHeadGUIDS[UnitGUID("boss"..i)] then--Check if new units exist we haven't detected and added yet.
			activeHeadGUIDS[UnitGUID("boss"..i)] = true
			local cid = mod:GetCIDFromGUID(UnitGUID("boss"..i))
			if cid == 70235 then--Frozen
				iceInFront = iceInFront + 1
				if iceBehind > 0 then
					iceBehind = iceBehind - 1
				end
			elseif cid == 70212 then--Flaming
				fireInFront = fireInFront + 1
				if fireBehind > 0 then
					fireBehind = fireBehind - 1
				end
			elseif cid == 70247 then--Venomous
				venomInFront = venomInFront + 1
				if venomBehind > 0 then
					venomBehind = venomBehind - 1
				end
			elseif cid == 70248 then--Arcane
				arcaneInFront = arcaneInFront + 1
				if arcaneBehind > 0 then
					arcaneBehind = arcaneBehind - 1
				end
			end
		end
	end
--	print("DBM Boss Debug: ", "Active Heads: ".."Fire: "..fireInFront.." Ice: "..iceInFront.." Venom: "..venomInFront.." Arcane: "..arcaneInFront)
--	print("DBM Boss Debug: ", "Inactive Heads: ".."Fire: "..fireBehind.." Ice: "..iceBehind.." Venom: "..venomBehind.." Arcane: "..arcaneBehind)
end

--Only real way to detect heads moving from back to front.
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	self:Unschedule(CheckHeads)
	self:Schedule(1, CheckHeads)--Delay check to make sure dying heads are cleared before accidentally adding them back in after they cast "feign death" but before they actually die"
end

--Unfortunately we need to update the counts sooner than UNIT_DIED fires because we need those counts BEFORE CHAT_MSG_RAID_BOSS_EMOTE fires.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 70628 and self:AntiSpam(2, 3) then--Permanent Feign Death
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		if cid == 70235 then--Frozen
			iceInFront = iceInFront - 1
			iceBehind = iceBehind + 2
		elseif cid == 70212 then--Flaming
			fireInFront = fireInFront - 1
			fireBehind = fireBehind + 2
		elseif cid == 70247 then--Venomous
			venomInFront = venomInFront - 1
			venomBehind = venomBehind + 2
		elseif cid == 70248 then--Arcane
			arcaneInFront = arcaneInFront - 1
			arcaneBehind = arcaneBehind + 2
			arcaneRecent = true
		end
--		print("DBM Boss Debug: ", "Active Heads: ".."Fire: "..fireInFront.." Ice: "..iceInFront.." Venom: "..venomInFront.." Arcane: "..arcaneInFront)
--		print("DBM Boss Debug: ", "Inactive Heads: ".."Fire: "..fireBehind.." Ice: "..iceBehind.." Venom: "..venomBehind.." Arcane: "..arcaneBehind)
	end
end

local function clearHeadGUID(GUID)
	activeHeadGUIDS[GUID] = nil
end

--Nil out front boss GUIDs and cancel timers for correct died unit so those units can activate again later
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70235 then--Frozen
		self:Schedule(5, clearHeadGUID, args.destGUID)
	elseif cid == 70212 then--Flaming
		self:Schedule(5, clearHeadGUID, args.destGUID)
	elseif cid == 70247 then--Venomous
		self:Schedule(5, clearHeadGUID, args.destGUID)
	elseif cid == 70248 then--Arcane
		self:Schedule(5, clearHeadGUID, args.destGUID)
	end
end

local function warnTorrent(name)
	if not name then return end
	warnTorrentofIce:Show(name)
	if name == UnitName("player") then
		specWarnTorrentofIceYou:Show()
		timerTorrentofIce:Start()
		yellTorrentofIce:Yell()
		mod:SendSync("IceTarget", UnitGUID("player")) -- Remain sync stuff for older version.
	end
end

function mod:UNIT_AURA(uId)
	if UnitDebuff(uId, iceTorrent) and not torrentTarget1 and (torrentTarget2 or "") ~= uId then
		torrentTarget1 = uId
		local name = DBM:GetUnitFullName(uId)
		warnTorrent(name)
		if self.Options.SetIconOnTorrentofIce then
			self:SetIcon(uId, 6)
		end
	elseif UnitDebuff(uId, iceTorrent) and not torrentTarget2 and (torrentTarget1 or "") ~= uId then
		torrentTarget2 = uId
		local name = DBM:GetUnitFullName(uId)
		warnTorrent(name)
		if self.Options.SetIconOnTorrentofIce then
			self:SetIcon(uId, 4)
		end
	elseif torrentTarget1 and torrentTarget1 == uId and not UnitDebuff(uId, iceTorrent) then
		torrentTarget1 = nil
		if self.Options.SetIconOnTorrentofIce then
			self:SetIcon(uId, 0)
		end
	elseif torrentTarget2 and torrentTarget2 == uId and not UnitDebuff(uId, iceTorrent) then
		torrentTarget2 = nil
		if self.Options.SetIconOnTorrentofIce then
			self:SetIcon(uId, 0)
		end
	end
end
