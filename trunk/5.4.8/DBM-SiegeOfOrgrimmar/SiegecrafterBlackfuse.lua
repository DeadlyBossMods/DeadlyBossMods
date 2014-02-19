local mod	= DBM:NewMod(865, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71504)--71591 Automated Shredder
mod:SetEncounterID(1601)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Not sure how many mines spawn on 25 man, even more of them on heroic 25, so maybe all 8 used?

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 143265 144208",
	"SPELL_CAST_SUCCESS 145774",
	"SPELL_SUMMON 143641",
	"SPELL_AURA_APPLIED 145365 143385 145444 144210 144236 145269 145580 144466 143856",
	"SPELL_AURA_APPLIED_DOSE 143385 145444 143856",
	"SPELL_AURA_REMOVED 143385 144236 145269",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER"
)

--Siegecrafter Blackfuse
local warnLaunchSawblade				= mod:NewTargetAnnounce(143265, 3)
local warnProtectiveFrenzy				= mod:NewTargetAnnounce(145365, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElectroStaticCharge			= mod:NewStackAnnounce(143385, 2, nil, mod:IsTank())
local warnOvercharge					= mod:NewTargetAnnounce(145774, 4)--Heroic. Probably doesn't show in combat log and will require emotes i'm sure.
--Automated Shredders
local warnAutomatedShredder				= mod:NewCountAnnounce("ej8199", 3, 85914)
local warnOverload						= mod:NewStackAnnounce(145444, 3)
local warnDeathFromAbove				= mod:NewTargetAnnounce(144208, 4)--Player target, not vulnerable shredder target. (should always be cast on highest threat target, but i like it still being a "target" warning)
--The Assembly Line
local warnAssemblyLine					= mod:NewCountAnnounce("OptionVersion2", "ej8202", 3, 85914, mod:IsDps())
local warnInactive						= mod:NewTargetAnnounce(138089, 1)
local warnShockwaveMissile				= mod:NewSpellAnnounce(143641, 3)
--local warnLaserTurretActivated			= mod:NewSpellAnnounce("ej8208", 3, 143867, false)--No event to detect it
local warnLaserFixate					= mod:NewTargetAnnounce(143828, 3, 143867)
local warnMagneticCrush					= mod:NewSpellAnnounce(144466, 3)--Unsure if correct ID, could be 143487 instead
local warnCrawlerMine					= mod:NewSpellAnnounce("ej8212", 3, 144010)--Crawler Mine Spawning
local warnReadyToGo						= mod:NewTargetAnnounce(145580, 4)--Crawler mine not dead fast enough

--Siegecrafter Blackfuse
local specWarnLaunchSawblade			= mod:NewSpecialWarningYou(143265)
local yellLaunchSawblade				= mod:NewYell("OptionVersion3", 143265)
local specWarnProtectiveFrenzy			= mod:NewSpecialWarningTarget(145365, mod:IsTank())
local specWarnOvercharge				= mod:NewSpecialWarningTarget(145774)
--Automated Shredders
local specWarnAutomatedShredder			= mod:NewSpecialWarningCount("ej8199", mod:IsTank())--No sense in dps switching when spawn, has damage reduction. This for tank pickup
local specWarnDeathFromAbove			= mod:NewSpecialWarningYou(144208)
local specWarnDeathFromAboveNear		= mod:NewSpecialWarningClose(144208)
local specWarnAutomatedShredderSwitch	= mod:NewSpecialWarningSwitch("ej8199", false)--Strat dependant, you may just ignore them and have tank kill them with laser pools
--The Assembly Line
local specWarnCrawlerMine				= mod:NewSpecialWarningSwitch("OptionVersion3", "ej8212", not mod:IsHealer())
local specWarnAssemblyLine				= mod:NewSpecialWarningCount("OptionVersion3", "ej8202", false)--Not all in raid need, just those assigned
local specWarnShockwaveMissile			= mod:NewSpecialWarningSpell(143641, nil, nil, nil, 2)
local specWarnReadyToGo					= mod:NewSpecialWarningTarget(145580)
local specWarnLaserFixate				= mod:NewSpecialWarningRun(143828)
local yellLaserFixate					= mod:NewYell(143828)
local specWarnSuperheated				= mod:NewSpecialWarningMove(143856)--From lasers. Hard to see, this warning will help a ton
local specWarnMagneticCrush				= mod:NewSpecialWarningSpell(144466, nil, nil, nil, 2)
local specWarnCrawlerMineFixate			= mod:NewSpecialWarningRun("ej8212")
local yellCrawlerMineFixate				= mod:NewYell("ej8212", nil, false)

--Siegecrafter Blackfuse
local timerProtectiveFrenzy				= mod:NewBuffActiveTimer(10, 145365, nil, false, nil, nil, nil, nil, nil, 2)
local timerElectroStaticCharge			= mod:NewTargetTimer(60, 143385, nil, mod:IsTank())
local timerElectroStaticChargeCD		= mod:NewCDTimer(17, 143385, nil, mod:IsTank())--17-22 second variation
local timerLaunchSawbladeCD				= mod:NewCDTimer(10, 143265)--10-15sec cd
--Automated Shredders
local timerAutomatedShredderCD			= mod:NewNextTimer("OptionVersion2", 60, "ej8199", nil, mod:IsTank(), nil, 85914)
local timerOverloadCD					= mod:NewCDCountTimer(10, 145444)
local timerDeathFromAboveDebuff			= mod:NewTargetTimer(5, 144210, nil, not mod:IsHealer())
local timerDeathFromAboveCD				= mod:NewNextTimer(40, 144208, nil, not mod:IsHealer())
--The Assembly Line
local timerAssemblyLineCD				= mod:NewNextCountTimer("OptionVersion2", 40, "ej8202", nil, mod:IsDps(), nil, 59193)
local timerPatternRecognition			= mod:NewBuffFadesTimer("OptionVersion2", 60, 144236, nil, false)
--local timerDisintegrationLaserCD		= mod:NewNextCountTimer(10, 143867)
--local timerShockwaveMissileActive		= mod:NewBuffActiveTimer(30, 143639)
local timerLaserFixate					= mod:NewBuffFadesTimer(15, 143828)
local timerBreakinPeriod				= mod:NewTargetTimer(60, 145269, nil, false)--Many mines can be up at once so timer off by default do to spam
local timerMagneticCrush				= mod:NewBuffActiveTimer(30, 144466)

local countdownAssemblyLine				= mod:NewCountdown(40, "ej8202", false)
local countdownShredder					= mod:NewCountdown(60, "ej8199", mod:IsTank())
local countdownElectroStatic			= mod:NewCountdown("Alt17", 143385, mod:IsTank())

local soundMineFixate					= mod:NewSound("ej8212", mod:IsMelee())--No strat involves ranged moving for these, they should die before reaching ranged. But melee must run out.
local soundLaserFixate					= mod:NewSound(143828, false)

mod:AddInfoFrameOption("ej8202")
mod:AddSetIconOption("SetIconOnMines", "ej8212", false, true)

--Upvales, don't need variables
--Names very long in english, makes frame HUGE, may switch to shorter localized names
local assemblyLine = EJ_GetSectionInfo(8202)
local crawlerMine = EJ_GetSectionInfo(8212)
local shockwaveMissile = EJ_GetSectionInfo(8205)
local laserTurret = EJ_GetSectionInfo(8208)
local electroMagnet = EJ_GetSectionInfo(8210)
local assemblyName = {
	[71606] = shockwaveMissile, -- Deactivated Missile Turret
	[71790] = crawlerMine, -- Disassembled Crawler Mines
	[71751] = laserTurret, -- Deactivated Laser Turret
	[71694] = electroMagnet, -- Deactivated Electromagnet
}

--Not important, don't need to recover
--Important, needs recover
mod.vb.shockwaveOvercharged = false
mod.vb.weapon = 0
mod.vb.shredderCount = 0

--VEM Idea
local function showWeaponInfo()
	local lines = {}
	if mod.vb.weapon == 1 or mod.vb.weapon == 2 or mod.vb.weapon == 4 then
		lines[shockwaveMissile] = laserTurret.." , "..crawlerMine
	elseif mod.vb.weapon == 3 then
		lines[shockwaveMissile] = laserTurret.." , "..electroMagnet
	elseif mod.vb.weapon == 5 then
		lines[shockwaveMissile] = electroMagnet.." , "..crawlerMine
	elseif mod.vb.weapon == 6 then
		lines[crawlerMine] = laserTurret.." , "..crawlerMine
	elseif mod.vb.weapon == 7 then
		lines[shockwaveMissile] = laserTurret.." , "..crawlerMine
	elseif mod.vb.weapon == 8 then
		lines[shockwaveMissile] = electroMagnet.." , "..crawlerMine
	elseif mod.vb.weapon == 9 then
		lines[laserTurret] =  crawlerMine.." , "..laserTurret
	elseif mod.vb.weapon == 10 then
		lines[shockwaveMissile] =  crawlerMine.." , "..laserTurret
	elseif mod.vb.weapon == 11 then
		lines[shockwaveMissile] = electroMagnet.." , "..shockwaveMissile
	elseif mod.vb.weapon == 12 then
		lines[electroMagnet] = crawlerMine.." , "..laserTurret
	else
		lines[_G["UNKNOWN"]] = ""
	end
	return lines
end
--End VEM Idea

function mod:LaunchSawBladeTarget(targetname, uId)
	warnLaunchSawblade:Show(targetname)
end

--May be two up at once so can't use generic boss scanner.
function mod:DeathFromAboveTarget(sGUID)
	local targetname = nil
	for uId in DBM:GetGroupMembers() do
		if UnitGUID(uId.."target") == sGUID then
			targetname = DBM:GetUnitFullName(uId.."targettarget")
			break
		end
	end
	if not targetname then return end
	warnDeathFromAbove:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDeathFromAbove:Show()
	elseif self:CheckNearby(10, targetname) then
		specWarnDeathFromAboveNear:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
--	table.wipe(activeWeaponsGUIDS)
--	laserCount = 0
	self.vb.weapon = 0
	self.vb.shredderCount = 0
	self.vb.shockwaveOvercharged = false
	timerAutomatedShredderCD:Start(35-delay, 1)
	countdownShredder:Start(35-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 143265 then
		timerLaunchSawbladeCD:Start()
		self:BossTargetScanner(71504, "LaunchSawBladeTarget", 0.1, 16)
	elseif spellId == 144208 then
		timerDeathFromAboveCD:Start(args.sourceGUID)
		self:ScheduleMethod(0.2, "DeathFromAboveTarget", args.sourceGUID)--Always targets tank, so 1 scan all needed
		specWarnAutomatedShredderSwitch:Schedule(3)--Better here then when debuff goes up, give dps 2 seconds rampup time so spells in route when debuff goes up.
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 145774 then
		warnOvercharge:Show(args.destName)
		specWarnOvercharge:Show(args.destName)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 71638 then
			self.vb.shockwaveOvercharged = true
		else
			self.vb.shockwaveOvercharged = false
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 143641 then--Missile Launching
		warnShockwaveMissile:Show()
		specWarnShockwaveMissile:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 145365 then
		warnProtectiveFrenzy:Show(args.destName)
		specWarnProtectiveFrenzy:Show(args.destName)
		timerProtectiveFrenzy:Start()
		for i = 1, 5 do
			if UnitExists("boss"..i) and UnitIsDead("boss"..i) then
				local cId = self:GetUnitCreatureId("boss"..i)
				if assemblyName[cId] then
					warnInactive:Show(assemblyName[cId])
				end
			end
		end
	elseif spellId == 143385 and args:IsDestTypePlayer() then
		local amount = args.amount or 1
		warnElectroStaticCharge:Show(args.destName, amount)
		timerElectroStaticCharge:Start(args.destName)
		timerElectroStaticChargeCD:Start()
		countdownElectroStatic:Start()
	elseif spellId == 145444 then
		local amount = args.amount or 1
		warnOverload:Show(args.destName, amount)
		timerOverloadCD:Start(nil, amount+1)
	elseif spellId == 144210 and not args:IsDestTypePlayer() then
		timerDeathFromAboveDebuff:Start(args.destName)
	elseif spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Start()
	elseif spellId == 145269 then
		if self:AntiSpam(20, 3) then
			warnCrawlerMine:Show()
			specWarnCrawlerMine:Show()
			if self.Options.SetIconOnMines then
				self:ScanForMobs(71788, 0, 8, nil, 0.1, 20)
			end
		end
		timerBreakinPeriod:Start(args.destName, args.destGUID)
	elseif spellId == 145580 then
		warnReadyToGo:Show(args.destName)
		specWarnReadyToGo:Show(args.destName)
--[[	elseif spellId == 143867 then
		if not activeWeaponsGUIDS[args.sourceGUID] then
			activeWeaponsGUIDS[args.sourceGUID] = true
			laserCount = 0
			warnLaserTurretActivated:Show()
		end
		laserCount = laserCount + 1
		if laserCount < 3 then--Seems each laser construction casts 3 times, then disapears.
			timerDisintegrationLaserCD:Start(nil, laserCount+1)
		end--]]
	elseif spellId == 144466 and self:AntiSpam(35, 1) then--Only way i see to detect magnet activation, antispam is so it doesn't break if a player dies during it.
		warnMagneticCrush:Show()
		specWarnMagneticCrush:Show()
		timerMagneticCrush:Start()
	elseif spellId == 143856 and args:IsPlayer() and self:AntiSpam(2, 2) then
		specWarnSuperheated:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 143385 then
		timerElectroStaticCharge:Cancel(args.destName)
	elseif spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Cancel()
	elseif spellId == 145269 then
		timerBreakinPeriod:Cancel(args.destName, args.destGUID)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71591 then
		timerDeathFromAboveCD:Cancel(args.destGUID)
		timerOverloadCD:Cancel()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:143266") then--Target scanning works on this one, but is about 1 second slower than emote. emote is .2 seconds after SPELL_CAST_START, but target scanning can't grab right target until like 1.0 or 1.2 sec into cast
		specWarnLaunchSawblade:Show()
		yellLaunchSawblade:Yell()
	--"<55.7 18:31:39> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#|TInterface\\Icons\\Ability_Siege_Engineer_Detonate.blp:20|tA Crawler Mine has targeted you!#Crawler Mine#0#true", -- [4345]
	elseif msg:find("Ability_Siege_Engineer_Detonate") then--Doesn't show in combat log at all (what else is new)
		specWarnCrawlerMineFixate:Show()
		yellCrawlerMineFixate:Yell()
		soundMineFixate:Play()
	elseif msg:find("Ability_Siege_Engineer_Superheated") then
		specWarnLaserFixate:Show()
		yellLaserFixate:Yell()
		timerLaserFixate:Start()
		soundLaserFixate:Play()
		self:SendSync("LockedOnTarget", UnitGUID("player"))
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg == L.newWeapons or msg:find(L.newWeapons) then
		self.vb.weapon = self.vb.weapon + 1
		warnAssemblyLine:Show(self.vb.weapon)
		specWarnAssemblyLine:Show(self.vb.weapon)
		timerAssemblyLineCD:Start(nil, self.vb.weapon + 1)
		countdownAssemblyLine:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(assemblyLine.."("..self.vb.weapon..")")
			DBM.InfoFrame:Show(1, "function", showWeaponInfo, true)
		end
	elseif msg == L.newShredder or msg:find(L.newShredder) then
		self.vb.shredderCount = self.vb.shredderCount + 1
		warnAutomatedShredder:Show(self.vb.shredderCount)
		specWarnAutomatedShredder:Show(self.vb.shredderCount)
		timerDeathFromAboveCD:Start(18)
		timerAutomatedShredderCD:Start(nil, self.vb.shredderCount+14)
		countdownShredder:Start()
	end
end

function mod:OnSync(msg, guid)
	if msg == "LockedOnTarget" and guid then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		warnLaserFixate:Show(targetName)
	end
end
