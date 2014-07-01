local mod	= DBM:NewMod(866, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(72276)
mod:SetEncounterID(1624)
mod:DisableESCombatDetection()
mod:DisableEEKillDetection()
mod:SetMinSyncRevision(11308)
mod:SetHotfixNoticeRev(10768)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 145216 144482 144654 144628 144649 144657 146707",
	"SPELL_AURA_APPLIED 144514 145226 144849 144850 144851",
	"SPELL_AURA_APPLIED_DOSE 146124",
	"SPELL_AURA_REMOVED 145226 144849 144850 144851",
	"SPELL_DAMAGE 145073",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",--This boss can change boss ID any time you jump into one of tests, because he gets unregistered as boss1 then registered as boss2 when you leave, etc
	"CHAT_MSG_ADDON",
	"GROUP_ROSTER_UPDATE"
)

mod:RegisterEvents(
	"ENCOUNTER_START",
	"CHAT_MSG_MONSTER_YELL"
)

local boss = EJ_GetSectionInfo(8216)

mod:SetBossHealthInfo(
	72276, boss
)

--Amalgam of Corruption
local warnSelfDoubt						= mod:NewStackAnnounce(146124, 2, nil, mod:IsTank())
local warnBlindHatred					= mod:NewSpellAnnounce(145226, 3)
local warnManifestation					= mod:NewCountAnnounce("ej8232", 1, 147082)
local warnResidualCorruption			= mod:NewSpellAnnounce(145073)
local warnLookWithinEnd					= mod:NewEndTargetAnnounce("ej8220", 2, nil, false)
--Test of Serenity (DPS)
local warnTearReality					= mod:NewCastAnnounce(144482, 3)
--Test of Reliance (Healer)
local warnDishearteningLaugh			= mod:NewSpellAnnounce(146707, 3)
local warnLingeringCorruption			= mod:NewTargetAnnounce(144514, 3)
--Test of Confidence (tank)
local warnTitanicSmash					= mod:NewCastAnnounce(144628, 4)
local warnBurstOfCorruption				= mod:NewCastAnnounce(144654, 3)
local warnHurlCorruption				= mod:NewCastAnnounce(144649, 4)
local warnPiercingCorruption			= mod:NewSpellAnnounce(144657, 3)

--Amalgam of Corruption
local specWarnUnleashedAnger			= mod:NewSpecialWarningSpell(145216, mod:IsTank())--Cast warning, not stack. for active mitigation timing.
local specWarnSelfDoubtOther			= mod:NewSpecialWarningTaunt(146124, mod:IsTank())--Stack warning, to taunt off other tank
local specWarnBlindHatred				= mod:NewSpecialWarningSpell(145226, nil, nil, nil, 2)
local specWarnManifestation				= mod:NewSpecialWarningSwitch("ej8232", not mod:IsHealer())--Unleashed Manifestation of Corruption
local specWarnManifestationSoon			= mod:NewSpecialWarningSoon("ej8232", not mod:IsHealer(), nil, nil, 2)--WHen the ones die inside they don't spawn right away, there is like a 5 second lag.
local specWarnResidualCorruption		= mod:NewSpecialWarningSpell("OptionVersion2", 145073, false)--spammy. but sometimes needed.
--Test of Serenity (DPS)
local specWarnTearReality				= mod:NewSpecialWarningMove(144482)
--Test of Reliance (Healer)
local specWarnDishearteningLaugh		= mod:NewSpecialWarningSpell(146707, false, nil, nil, 2)
local specWarnLingeringCorruption		= mod:NewSpecialWarningDispel(144514)
local specWarnBottomlessPitMove			= mod:NewSpecialWarningMove(146703)
--Test of Confidence (tank)
local specWarnTitanicSmash				= mod:NewSpecialWarningMove(144628)
local specWarnBurstOfCorruption			= mod:NewSpecialWarningSpell(144654, nil, nil, nil, 2)
local specWarnHurlCorruption			= mod:NewSpecialWarningInterrupt(144649, nil, nil, nil, 3)
local specWarnPiercingCorruption		= mod:NewSpecialWarningSpell(144657)

--Amalgam of Corruption
local timerCombatStarts					= mod:NewCombatTimer(25)
local timerUnleashedAngerCD				= mod:NewCDTimer(11, 145216, nil, mod:IsTank())
local timerBlindHatred					= mod:NewBuffActiveTimer("OptionVersion3", 30, 145226, nil, mod:IsHealer())
local timerBlindHatredCD				= mod:NewNextTimer(30, 145226)
--All Tests
local timerLookWithin					= mod:NewBuffFadesTimer(60, "ej8220")
--Test of Serenity (DPS)
local timerTearRealityCD				= mod:NewCDTimer(8.5, 144482)--8.5-10sec variation
--Test of Reliance (Healer)
local timerDishearteningLaughCD			= mod:NewNextTimer(12, 146707)
local timerLingeringCorruptionCD		= mod:NewNextTimer(15.5, 144514)
--Test of Confidence (tank)
local timerTitanicSmashCD				= mod:NewCDTimer(14.5, 144628)--14-17sec variation
local timerPiercingCorruptionCD			= mod:NewCDTimer(14, 144657)--14-17sec variation
local timerHurlCorruptionCD				= mod:NewNextTimer(20, 144649)

local berserkTimer						= mod:NewBerserkTimer(418)

local countdownLookWithin				= mod:NewCountdownFades(59, "ej8220")
local countdownLingeringCorruption		= mod:NewCountdown("Alt15.5", 144514)
local countdownHurlCorruption			= mod:NewCountdown("Alt20", 144649)

mod:AddInfoFrameOption("ej8252", false)--May still be buggy but it's needed for heroic.

--Upvales, don't need variables
local corruptionLevel = EJ_GetSectionInfo(8252)
local Ambiguate = Ambiguate
--Tables, can't recover
local residue = {}
--Not important, don't need to recover
local playerInside = false
local previousPower = nil
--Important, needs recover
mod.vb.unleashedAngerCast = 0
mod.vb.manifestationCount = 0

--May be buggy with two adds spawning at exact same time
--Two different icon functions end up both marking same mob with 8 and 7 and other mob getting no mark.
--Not sure if GUID table will be fast enough to prevent, we shall see!
local function addsDelay()
	mod.vb.manifestationCount = mod.vb.manifestationCount + 1
	warnManifestation:Show(mod.vb.manifestationCount)
	specWarnManifestation:Show(mod.vb.manifestationCount)
end

local function addSync()
	specWarnManifestationSoon:Show()
	if mod:IsDifficulty("lfr25") then
		mod:Schedule(15, addsDelay, GetTime())
	else
		mod:Schedule(5, addsDelay, GetTime())
	end
end

local function delayPowerSync()
	mod:RegisterShortTermEvents(
		"UNIT_POWER player"
	)
	SendAddonMessage("BigWigs", "T:".."BWPower "..UnitPower("player", 10), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
end

function mod:OnCombatStart(delay)
	playerInside = false
	previousPower = nil
	mod.vb.unleashedAngerCast = 0
	mod.vb.manifestationCount = 0
	table.wipe(residue)
	timerBlindHatredCD:Start(25-delay)
	if self:IsDifficulty("lfr25") then
		berserkTimer:Start(600-delay)
	else
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(corruptionLevel)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	self:Schedule(1, delayPowerSync)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 145216 then
		self.vb.unleashedAngerCast = self.vb.unleashedAngerCast + 1
		specWarnUnleashedAnger:Show()
		if self.vb.unleashedAngerCast < 3 then
			timerUnleashedAngerCD:Start(nil, self.vb.unleashedAngerCast+1)
		end
	elseif spellId == 144482 then
		warnTearReality:Show()
		specWarnTearReality:Show()
		timerTearRealityCD:Start()
	elseif spellId == 144654 then
		warnBurstOfCorruption:Show()
		specWarnBurstOfCorruption:Show()
	elseif spellId == 144628 then
		warnTitanicSmash:Show()
		specWarnTitanicSmash:Show()
		timerTitanicSmashCD:Start()
	elseif spellId == 144649 then
		warnHurlCorruption:Show()
		specWarnHurlCorruption:Show(args.sourceName)
		timerHurlCorruptionCD:Start()
		countdownHurlCorruption:Start()
	elseif spellId == 144657 then
		warnPiercingCorruption:Show()
		specWarnPiercingCorruption:Show()
		timerPiercingCorruptionCD:Start()
	elseif spellId == 146707 then
		warnDishearteningLaugh:Show()
		specWarnDishearteningLaugh:Show()
		timerDishearteningLaughCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144514 then
		warnLingeringCorruption:Show(args.destName)
		specWarnLingeringCorruption:Show(args.destName)
		timerLingeringCorruptionCD:Start()
		countdownLingeringCorruption:Start()
	elseif spellId == 145226 then
		self:SendSync("BlindHatred")
	elseif args:IsSpellID(144849, 144850, 144851) and args:IsPlayer() then--Look Within
		playerInside = true
		timerLookWithin:Start()
		countdownLookWithin:Start()
	elseif spellId == 146703 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnBottomlessPitMove:Show()
	elseif spellId == 146124 then
		local amount = args.amount or 1
		warnSelfDoubt:Show(args.destName, amount)
		if not args:IsPlayer() and amount >= 3 then
			specWarnSelfDoubtOther:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(144849, 144850, 144851) then--Look Within
		warnLookWithinEnd:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			playerInside = false
			timerTearRealityCD:Cancel()
			timerLingeringCorruptionCD:Cancel()
			countdownLingeringCorruption:Cancel()
			timerDishearteningLaughCD:Cancel()
			timerTitanicSmashCD:Cancel()
			timerHurlCorruptionCD:Cancel()
			countdownHurlCorruption:Cancel()
			timerPiercingCorruptionCD:Cancel()
			timerLookWithin:Cancel()
			countdownLookWithin:Cancel()
		end
	elseif spellId == 145226 then
		self:SendSync("BlindHatredEnded")
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, _, _, _, spellId)
	if spellId == 145073 and not residue[sourceGUID] then
		residue[sourceGUID] = true
		warnResidualCorruption:Show()
		specWarnResidualCorruption:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71977 then--Manifestation of Corruption (Dps Test)
		timerTearRealityCD:Cancel()
		self:SendSync("ManifestationDied")
	elseif cid == 72001 then--Greater Corruption (Healer Test)
		timerLingeringCorruptionCD:Cancel()
		countdownLingeringCorruption:Cancel()
		timerDishearteningLaughCD:Cancel()
	elseif cid == 72051 then--Titanic Corruption (Tank Test)
		timerTitanicSmashCD:Cancel()
		timerHurlCorruptionCD:Cancel()
		countdownHurlCorruption:Cancel()
		timerPiercingCorruptionCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 145769 and self:AntiSpam(1, 5) then--Unleash Corruption
		specWarnManifestationSoon:Show()
		self:Schedule(5, addsDelay, GetTime())
	end
end

function mod:ENCOUNTER_START(id)
	if id == 1624 then
		if self.lastWipeTime and GetTime() - self.lastWipeTime < 20 then return end--False ENCOUNTER_START firing on a wipe (blizz bug), ignore it so we don't start pre pull timer
		self:SendSync("prepull")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	end
end

function mod:OnSync(msg, guid)
	if msg == "prepull" then
		if self.lastWipeTime and GetTime() - self.lastWipeTime < 20 then return end
		timerCombatStarts:Start()
	end
end

function mod:CHAT_MSG_ADDON(prefix, message, channel, sender)
	--Because core already registers BigWigs prefix with server, shouldn't need it here
	if prefix == "D4" and message then
		sender = Ambiguate(sender, "none")
		if message:find("ManifestationDied") and not playerInside and self:AntiSpam(1, 1) then
			addSync()
		elseif message:find("BlindHatredEnded") and self:AntiSpam(5, 4) then
			timerBlindHatredCD:Start()
			self.vb.unleashedAngerCast = 0
		elseif message:find("BlindHatred") and not message:find("BlindHatredEnded") and self:AntiSpam(5, 3) then
			warnBlindHatred:Show()
			if not playerInside then
				specWarnBlindHatred:Show()
			end
			timerBlindHatred:Start()
		end
	elseif prefix == "BigWigs" and message then
		sender = Ambiguate(sender, "none")
		local bwPrefix, bwMsg = message:match("^(%u-):(.+)")
		if bwMsg == "InsideBigAddDeath" and not playerInside and self:AntiSpam(1, 1) then
			addSync()
		end
	end
end

--Make sure we send Bigwigs altPower syncs so DBM users aren't yelled at by raid leaders for not installing BW
function mod:UNIT_POWER(uId)
	local currentPower = UnitPower("player", 10)
	if not previousPower or (previousPower ~= currentPower) then
		previousPower = currentPower
		SendAddonMessage("BigWigs", "T:".."BWPower "..currentPower, IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
	end
end

function mod:GROUP_ROSTER_UPDATE(uId)
	local currentPower = UnitPower("player", 10)
	SendAddonMessage("BigWigs", "T:".."BWPower "..currentPower, IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
end
