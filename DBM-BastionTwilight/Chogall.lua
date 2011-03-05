local mod	= DBM:NewMod("Chogall", "DBM-BastionTwilight")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(43324)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_HEALTH",
	"UNIT_AURA",
	"UNIT_TARGET"
)

local warnWorship					= mod:NewTargetAnnounce(91317, 3)--Phase 1
local warnFury						= mod:NewSpellAnnounce(82524, 3, nil, mod:IsTank() or mod:IsHealer())--Phase 1
local warnAdherent					= mod:NewSpellAnnounce(81628, 4)--Phase 1
local warnShadowOrders				= mod:NewSpellAnnounce(81556, 3, nil, mod:IsTank() or mod:IsHealer())
local warnFlameOrders				= mod:NewSpellAnnounce(81171, 3, nil, mod:IsTank() or mod:IsHealer())
local warnFlamingDestruction		= mod:NewSpellAnnounce(81194, 4)
local warnEmpoweredShadows			= mod:NewSpellAnnounce(81572, 4)
local warnCorruptingCrash			= mod:NewTargetAnnounce(93178, 2, nil, false)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnCreations					= mod:NewSpellAnnounce(82414, 3)--Phase 2

local specWarnSickness				= mod:NewSpecialWarningYou(82235, mod:IsMelee())--Ranged should already be spread out and not need a special warning every sickness.
local specWarnBlaze					= mod:NewSpecialWarningMove(81538)
local specWarnCorruptingCrash		= mod:NewSpecialWarningMove(93178, not mod:IsTank())--Subject to accuracy flaws so off by default for tanks.
local specWarnCorruptingCrashNear	= mod:NewSpecialWarningClose(93178, false)--Subject to accuracy flaws for everyone so off by default.
local specWarnWorship				= mod:NewSpecialWarningSpell(93205, false)

local timerWorshipCD				= mod:NewCDTimer(36, 91317)--21-40 second variations depending on adds
local timerAdherent					= mod:NewCDTimer(92, 81628)
local timerFesterBlood				= mod:NewNextTimer(40, 82299)--40 seconds after an adherent is summoned
local timerFlamingDestruction		= mod:NewBuffActiveTimer(10, 81194)
local timerEmpoweredShadows			= mod:NewBuffActiveTimer(9, 81572)
local timerFuryCD					= mod:NewCDTimer(47, 82524, nil, mod:IsTank() or mod:IsHealer())--47-48 unless a higher priority ability is channeling (such as summoning adds or MC)
local timerCreationsCD				= mod:NewNextTimer(30, 82414)
local timerSickness					= mod:NewBuffActiveTimer(5, 82235)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnWorship", true)
mod:AddBoolOption("SetIconOnCreature", false)
mod:AddBoolOption("YellOnCorrupting", not mod:IsTank(), "announce")--Subject to accuracy flaws so off by for tanks(if you aren't a tank then it probably sin't wrong so it's on for everyone else.)
mod:AddBoolOption("CorruptingCrashArrow", false)--Subject to accuracy flaws so off by default.
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("InfoFrame")

local worshipTargets = {}
local prewarned_Phase2 = false
local worshipIcon = 8
local worshipCooldown = 21
local blazeSpam = 0
local sickSpam = 0
local creatureGUIDs = {}
local creatureAmount = 4
local creatureIcon = 8
local Corruption = GetSpellInfo(82235)

local function showWorshipWarning()
	warnWorship:Show(table.concat(worshipTargets, "<, >"))
	table.wipe(worshipTargets)
	worshipIcon = 8
	timerWorshipCD:Start(worshipCooldown)
	specWarnWorship:Show()
end

local function trySetTarget()
	for i=1, GetNumRaidMembers() do
		if self:GetCIDFromGUID(UnitGUID("raid"..i.."target")) == 44045 and not creatureGUIDs[UnitGUID("raid"..i.."target")] then
			creatureGUIDs[UnitGUID("raid"..i.."target")] = true
			self:SetIcon("raid"..i.."target", creatureIcon)
			creatureIcon = creatureIcon - 1
		end
	end
end

function mod:CorruptingCrashTarget(sGUID)
	local targetname = nil
	for i=1, GetNumRaidMembers() do
		if UnitGUID("raid"..i.."target") == sGUID then
			targetname = UnitName("raid"..i.."targettarget")
		end
	end
	if not targetname then return end
	warnCorruptingCrash:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCorruptingCrash:Show()
		if self.Options.YellOnCorrupting then
			SendChatMessage(L.YellCrash, "SAY")
		end
	elseif targetname then
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
	timerWorshipCD:Start(10-delay)
--	timerFuryCD:Start(55-delay)--first fury of chogal is health based, 85%, cannot accurately time it.
--	timerAdherent:Start(60-delay)--This is also health based?
	table.wipe(worshipTargets)
	table.wipe(creatureGUIDs)
	prewarned_Phase2 = false
	worshipIcon = 8
	worshipCooldown = 21
	if mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25") then
		creatureAmount = 8
	else
		creatureAmount = 4
	end
	blazeSpam = 0
	sickSpam = 0
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.Bloodlevel)
		DBM.InfoFrame:Show(5, "playerpower", 25, ALTERNATE_POWER_INDEX)
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
		self:Schedule(0.3, showWorshipWarning)
	elseif args:IsSpellID(81194, 93264, 93265, 93266) then
		warnFlamingDestruction:Show()
		timerFlamingDestruction:Start()
	elseif args:IsSpellID(81572, 93218, 93219, 93220) then
		warnEmpoweredShadows:Show()
		timerEmpoweredShadows:Start()
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
		worshipCooldown = 36
	elseif args:IsSpellID(82524) then
		warnFury:Show()
		timerFuryCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(82414, 93160, 93161, 93162) then
		warnCreations:Show()
		if mod:IsDifficulty("heroic25") then -- other difficulty not sure, only comfirmed 25 man heroic
			timerCreationsCD:Start(40)
		else
			timerCreationsCD:Start()
		end
		table.wipe(creatureGUIDs)
		if mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25") then
			creatureAmount = 8
		else
			creatureAmount = 4
		end
		creatureIcon = 8
	elseif args:IsSpellID(82630) then
		warnPhase2:Show()
		timerAdherent:Cancel()
		timerWorshipCD:Cancel()
	elseif args:IsSpellID(81556) then--87575?
		warnShadowOrders:Show()
	elseif args:IsSpellID(81171) then--87579?
		warnFlameOrders:Show()
	elseif args:IsSpellID(81685, 93178, 93179, 93180) then
		self:ScheduleMethod(0.2, "CorruptingCrashTarget", args.sourceGUID)--Since this is an instance cast scanning accurately is very hard.
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(81538, 93212, 93123, 93214) and args:IsPlayer() and GetTime() - blazeSpam >= 4 then
		specWarnBlaze:Show()
		blazeSpam = GetTime()
	end
end

function mod:SPELL_MISSED(args)
	if args:IsSpellID(82414) then
		creatureAmount = creatureAmount - 1
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
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
	if uId ~= "player" then return end
	if UnitDebuff("player", Corruption) and GetTime() - sickSpam >= 7 then
		specWarnSickness:Show()
		timerSickness:Start()
		if self.Options.RangeFrame and not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(5)
		end
		sickSpam = GetTime()
	end
end

function mod:UNIT_TARGET(uId)
	if self.Options.SetIconOnCreature and #creatureGUIDs < creatureAmount then
		trySetTarget()
	end
end