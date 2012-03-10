local mod	= DBM:NewMod(318, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(53879)
mod:SetModelID(35268)
mod:SetModelSound("sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_BACKEVENT_01.OGG", "sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_BACKSLAY_01.OGG")
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3, 2, 1)

mod:RegisterCombat("yell", L.Pull)--INSTANCE_ENCOUNTER_ENGAGE_UNIT comes 30 seconds after encounter starts, because of this, the mod can miss the first round of ability casts such as first grip targets. have to use yell

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnAbsorbedBlood		= mod:NewStackAnnounce(105248, 2)
local warnResidue			= mod:NewCountAnnounce("ej4057", 3, nil, false) -- maybe info frame will be better. (temporarly added)
local warnGrip				= mod:NewTargetAnnounce(109459, 4)
local warnNuclearBlast		= mod:NewCastAnnounce(105845, 4)
local warnSealArmor			= mod:NewCastAnnounce(105847, 4)
local warnAmalgamation		= mod:NewSpellAnnounce("ej4054", 3, 106005)--Amalgamation spawning, give temp icon.

local specWarnRoll			= mod:NewSpecialWarningSpell("ej4050", nil, nil, nil, true)--The actual roll
local specWarnTendril		= mod:NewSpecialWarning("SpecWarnTendril")--A personal warning for you only if you're not gripped 3 seconds after roll started
local specWarnGrip			= mod:NewSpecialWarningSpell(109459, mod:IsDps())
local specWarnNuclearBlast	= mod:NewSpecialWarningRun(105845, mod:IsMelee())
local specWarnSealArmor		= mod:NewSpecialWarningSpell(105847, mod:IsDps())
local specWarnAmalgamation	= mod:NewSpecialWarningSpell("ej4054", false)

local timerSealArmor		= mod:NewCastTimer(23, 105847)
local timerBarrelRoll		= mod:NewCastTimer(5, "ej4050")
local timerGripCD			= mod:NewNextTimer(32, 109457)
local timerDeathCD			= mod:NewCDTimer(8.5, 106199)--8.5-10sec variation.

local countdownRoll			= mod:NewCountdown(5, "ej4050")
local countdownGrip			= mod:NewCountdown(32, 109457, false)--Can get confusing if used with roll countdown. This is off by default but can be turned on by someone willing to sort out the confusion on their own.

local soundNuclearBlast		= mod:NewSound(105845, nil, mod:IsMelee())

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("SetIconOnGrip", true)
mod:AddBoolOption("ShowShieldInfo", false)--on 25 man this is quite frankly a spammy nightmare, especially on heroic. off by default since it's really only sensible in 10 man. Besides I may be adding an alternate frame option for "grip damage needed"

local gripTargets = {}
local gripIcon = 6
local corruptionActive = {}
local residueCount = 0
local diedOozeGUIDS = {}

local function checkTendrils()
	if not UnitDebuff("player", GetSpellInfo(109454)) and not UnitIsDeadOrGhost("player") then
		specWarnTendril:Show()
	end
end

local function clearTendrils()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

local function showGripWarning()
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	specWarnGrip:Show()
	table.wipe(gripTargets)
end

local function warningResidue()
	warnResidue:Cancel()
	warnResidue:Schedule(1.25, residueCount)
end

local function checkOozeResurrect(GUID)
	-- set min resurrect time to 5 sec. (guessed)
	if diedOozeGUIDS[GUID] and GetTime() - diedOozeGUIDS[GUID] > 5 then
		residueCount = residueCount - 1
		diedOozeGUIDS[GUID] = nil
		warningResidue()
	end
end

local clearPlasmaTarget, setPlasmaTarget, clearPlasmaVariables
do
	local plasmaTargets = {}
	local healed = {}
	
	function mod:SPELL_HEAL(_, _, _, _, destGUID, _, _, _, _, _, _, _, _, absorbed)
		if plasmaTargets[destGUID] then
			healed[destGUID] = healed[destGUID] + (absorbed or 0)
		end
	end
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL

	local function updatePlasmaTargets()
		local maxAbsorb =	mod:IsDifficulty("heroic25") and 420000 or
							mod:IsDifficulty("heroic10") and 280000 or
							mod:IsDifficulty("normal25") and 300000 or
							mod:IsDifficulty("normal10") and 200000 or 1
		DBM.BossHealth:Clear()
		if not DBM.BossHealth:IsShown() then
			DBM.BossHealth:Show(L.name)
		end
		for i,v in pairs(plasmaTargets) do
			DBM.BossHealth:AddBoss(function() return math.max(1, math.floor((healed[i] or 0) / maxAbsorb * 100))	end, L.PlasmaTarget:format(v))
		end
	end

	function setPlasmaTarget(guid, name)
		plasmaTargets[guid] = name
		healed[guid] = 0
		updatePlasmaTargets()
	end

	function clearPlasmaTarget(guid, name)
		plasmaTargets[guid] = nil
		healed[guid] = nil
		updatePlasmaTargets()
	end

	function clearPlasmaVariables()
		table.wipe(plasmaTargets)
		table.wipe(healed)
		updatePlasmaTargets()
	end
end

function mod:OnCombatStart(delay)
	if self:IsDifficulty("lfr25") then
		warnSealArmor = mod:NewCastAnnounce(105847, 4, 34.5)
	else
		warnSealArmor = mod:NewCastAnnounce(105847, 4)
	end
	table.wipe(gripTargets)
	table.wipe(corruptionActive)
	table.wipe(diedOozeGUIDS)
	if self.Options.ShowShieldInfo then
		clearPlasmaVariables()
	end
	gripIcon = 6
	residueCount = 0
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(105845) then
		warnNuclearBlast:Show()
		specWarnNuclearBlast:Show()
		soundNuclearBlast:Play()
	elseif args:IsSpellID(105847, 105848) then
		warnSealArmor:Show()
		specWarnSealArmor:Show()
		if self:IsDifficulty("lfr25") then
			timerSealArmor:Start(34.5)
		else
			timerSealArmor:Start()
		end
	elseif args:IsSpellID(109379) then
		if not corruptionActive[args.sourceGUID] then
			corruptionActive[args.sourceGUID] = 0
			if self:IsDifficulty("normal25", "heroic25") then
				timerGripCD:Start(16, args.sourceGUID)
				if #corruptionActive < 2 then--because using countdowns with more then 1 will be noisy not informative.
					countdownGrip:Start(16, args.sourceGUID)
				end
			else
				timerGripCD:Start(nil, args.sourceGUID)
				if #corruptionActive < 2 then--because using countdowns with more then 1 will be noisy not informative.
					countdownGrip:Start(32, args.sourceGUID)
				end
			end
		end
		corruptionActive[args.sourceGUID] = corruptionActive[args.sourceGUID] + 1
		if corruptionActive[args.sourceGUID] == 2 and self:IsDifficulty("normal25", "heroic25") then
			timerGripCD:Update(8, 16, args.sourceGUID)
		elseif corruptionActive[args.sourceGUID] == 4 and self:IsDifficulty("normal10", "heroic10") then
			timerGripCD:Update(24, 32, args.sourceGUID)
		end
	end
end

-- not needed guid check. This is residue creation step.
function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105219, 109371, 109372, 109373) then 
		diedOozeGUIDS[args.sourceGUID] = GetTime()
		residueCount = residueCount + 1
		warningResidue()
	elseif args:IsSpellID(105248) then
		diedOozeGUIDS[args.sourceGUID] = nil
		residueCount = residueCount - 1
		warningResidue()
	end
end

--Damage event that indicates an ooze is taking damage
--we check its GUID to see if it's a resurrected ooze and if so remove it from table.
--oozes do not fires SPELL_DAMAGE event from source. so track SPELL_DAMAGE event only from dest.
function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID)
	checkOozeResurrect(destGUID)
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, _, _, _, destGUID)
	checkOozeResurrect(destGUID)
	checkOozeResurrect(sourceGUID)
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105248) then
		warnAbsorbedBlood:Cancel()--Just a little anti spam
		warnAbsorbedBlood:Schedule(1.25, args.destName, 1)
	elseif args:IsSpellID(105490, 109457, 109458, 109459) then
		gripTargets[#gripTargets + 1] = args.destName
		timerGripCD:Cancel(args.sourceGUID)
		countdownGrip:Cancel(args.sourceGUID)
		if corruptionActive[args.sourceGUID] then
			corruptionActive[args.sourceGUID] = nil
		end
		if self.Options.SetIconOnGrip then
			if gripIcon == 0 then
				gripIcon = 6
			end
			self:SetIcon(args.destName, gripIcon)
			gripIcon = gripIcon - 1
		end
		self:Unschedule(showGripWarning)
		self:Schedule(0.3, showGripWarning)
	elseif args:IsSpellID(105479, 109362, 109363, 109364) then
		if self.Options.ShowShieldInfo then
			setPlasmaTarget(args.destGUID, args.destName)
		end
	end
end		

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(105248) then
		warnAbsorbedBlood:Cancel()--Just a little anti spam
		if args.amount == 9 then
			warnAbsorbedBlood:Show(args.destName, 9)
		else
			warnAbsorbedBlood:Schedule(1.25, args.destName, args.amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(105490, 109457, 109458, 109459) then
		if self.Options.SetIconOnGrip then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(105479, 109362, 109363, 109364) then
		if self.Options.ShowShieldInfo then
			clearPlasmaTarget(args.destGUID, args.destName)
		end
	end
end	

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.DRoll or msg:find(L.DRoll) then
		self:Unschedule(checkTendrils)--In case you manage to spam spin him, we don't want to get a bunch of extra stuff scheduled.
		self:Unschedule(clearTendrils)--^
		countdownRoll:Cancel()--^
		specWarnRoll:Show()--Warn you right away.
		self:Schedule(3, checkTendrils)--After 3 seconds of roll starting, check tendrals, you should have leveled him out by now if this wasn't on purpose.
		self:Schedule(8, clearTendrils)--Clearing 3 seconds after the roll should be sufficent
		timerBarrelRoll:Start()
		countdownRoll:Start(5)
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(L.NoDebuff:format(GetSpellInfo(109454)))
			DBM.InfoFrame:Show(5, "playergooddebuff", 109454)
		end
	elseif msg == L.DLevels or msg:find(L.DLevels) then
		self:Unschedule(checkTendrils)
		self:Unschedule(clearTendrils)
		clearTendrils()
		countdownRoll:Cancel()
		timerBarrelRoll:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53891 or cid == 56162 or cid == 56161 then
		timerGripCD:Cancel(args.sourceGUID)
		countdownGrip:Cancel(args.sourceGUID)
		warnAmalgamation:Schedule(4.5)--4.5-5 seconds after corruption dies.
		specWarnAmalgamation:Schedule(4.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDeathCD:Start(args.destGUID)
		end
	elseif cid == 56341 or cid == 56575 then
		timerSealArmor:Cancel()
	end
end
