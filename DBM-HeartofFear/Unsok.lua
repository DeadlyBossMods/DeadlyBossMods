local mod	= DBM:NewMod(737, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62511)
mod:SetModelID(43126)
mod:SetZone()
mod:SetMinSyncRevision(8052)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_POWER"
)

--[[WoL Reg Expression
(spellid = 45477 or spellid = 122540 or spellid = 122532 or spellid = 122348) and fulltype = SPELL_CAST_SUCCESS or (spellid =122784 or spellid =121949 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_APPLIED or (spellid =122370 or spellid = 122540 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_REMOVED or (spellid = 122408 or spellid = 122413 or spellid = 122398 or spellid = 122540 or spellid = 122402) and fulltype = SPELL_CAST_START or fulltype = UNIT_DIED and (targetname = "Omegal" or targetname = "Shiramune")
(spellid = 45477 or spellid = 122540) and fulltype = SPELL_CAST_SUCCESS or (spellid =122784 or spellid =121949 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_APPLIED or (spellid =122370 or spellid = 122540 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_REMOVED or (spellid = 122408 or spellid = 122413 or spellid = 122398 or spellid = 122540 or spellid = 122402) and fulltype = SPELL_CAST_START or fulltype = UNIT_DIED and (targetname = "Omegal" or targetname = "Shiramune")
--]]
--Boss
local warnReshapeLifeTutor		= mod:NewAnnounce("warnReshapeLifeTutor", 1, 122784)--Another LFR focused warning really.
local warnReshapeLife			= mod:NewTargetAnnounce(122784, 4)
local warnAmberScalpel			= mod:NewTargetAnnounce(121994, 3)
local warnParasiticGrowth		= mod:NewTargetAnnounce(121949, 4, nil, mod:IsHealer())
local warnAmberGlob				= mod:NewTargetAnnounce(125502, 4)--Heroic drycode, might need some tweaks
--Construct
local warnAmberExplosion		= mod:NewAnnounce("warnAmberExplosion", 3, 122398, false)--In case you want to get warned for all of them, but could be spammy later fight so off by default. This announce includes source of cast.
local warnStruggleForControl	= mod:NewTargetAnnounce(122395, 2)--Disabled in phase 3 as at that point it's just a burn.
local warnDestabalize			= mod:NewStackAnnounce(123059, 1, nil, false)--This can be super spammy so off by default.
--Living Amber
local warnLivingAmber			= mod:NewSpellAnnounce("ej6261", 2, nil, false)--122348 is what you check spawns with. ALso spamming and off by default
local warnBurningAmber			= mod:NewCountAnnounce("ej6567", 2, nil, false)--Keep track of Burning Amber Puddles. Spammy, but nessesary for heroic for someone managing them.
--Amber Monstrosity
local warnAmberCarapace			= mod:NewTargetAnnounce(122540, 4)--Monstrosity Shielding Boss (phase 2 start)
local warnMassiveStomp			= mod:NewCastAnnounce(122408, 3)
local warnAmberExplosionSoon	= mod:NewSoonAnnounce(122402, 3)
local warnFling					= mod:NewSpellAnnounce(122413, 3)--think this always does his aggro target but not sure. If it does random targets it will need target scanning.
local warnInterruptsAvailable	= mod:NewAnnounce("warnInterruptsAvailable", 1, 122398)

--Boss
local specwarnAmberScalpel			= mod:NewSpecialWarningYou(121994)
local yellAmberScalpel				= mod:NewYell(121994)
local specwarnAmberScalpelNear		= mod:NewSpecialWarningClose(121994)
local specwarnReshape				= mod:NewSpecialWarningYou(122784)
local specwarnParasiticGrowth		= mod:NewSpecialWarningTarget(121949, mod:IsHealer())
local specwarnParasiticGrowthYou	= mod:NewSpecialWarningYou(121949) -- This warn will be needed at player is clustered together. Especially on Phase 3.
local specwarnAmberGlob				= mod:NewSpecialWarningYou(125502)
--Construct
local specwarnAmberExplosionYou		= mod:NewSpecialWarning("specwarnAmberExplosionYou")--Only interruptable by the player controling construct casting, so only that person gets warning. non generic used to make this one more specific.
local specwarnAmberExplosionAM		= mod:NewSpecialWarning("specwarnAmberExplosionAM")--Must be on by default. Amber montrosity's MUST be interrupted on heroic or it's an auto wipe. it hits for over 500k.
local specwarnAmberExplosionOther	= mod:NewSpecialWarning("specwarnAmberExplosionOther", false)--A compromise. loose non player controled constructs now off by default but should still be an option as they are still perfectly interruptable (and should be)
local specwarnAmberExplosion		= mod:NewSpecialWarningTarget(122398, nil, nil, nil, true)--One you can't interrupt it
local specwarnWillPower				= mod:NewSpecialWarning("specwarnWillPower")--Special warning for when your will power is low (construct)
--local specwarnBossDebuff			= mod:NewSpecialWarning("specwarnBossDebuff")--Some special warning that says "get your ass to boss and refresh debuff NOW" (Debuff stacks up to 255 with 10% damage taken increase every stack, keeping buff up and stacking is paramount to dps check on heroic)
--Living Amber
local specwarnBurningAmber		= mod:NewSpecialWarningMove(122504)--Standing in a puddle
--Amber Monstrosity
local specwarnAmberMonstrosity	= mod:NewSpecialWarningSwitch("ej6254", not mod:IsHealer())
local specwarnFling				= mod:NewSpecialWarningSpell(122413, mod:IsTank())
local specwarnMassiveStomp		= mod:NewSpecialWarningSpell(122408, nil, nil, nil, true)

--Boss
local timerReshapeLifeCD		= mod:NewNextTimer(50, 122784)--50 second cd in phase 1-2, 15 second in phase 3. if no construct is up, cd is ignored and boss casts it anyways to make sure 1 is always up.
local timerAmberScalpelCD		= mod:NewCDTimer(40, 121994)--40 seconds after last one ENDED
local timerAmberScalpel			= mod:NewBuffActiveTimer(10, 121994)
local timerParasiticGrowthCD	= mod:NewCDTimer(35, 121949, nil, mod:IsHealer())--35-50 variation (most of the time 50, rare pulls he decides to use 35 sec cd instead)
local timerParasiticGrowth		= mod:NewTargetTimer(30, 121949, nil, mod:IsHealer())
--Construct
local timerAmberExplosionCD		= mod:NewNextSourceTimer(13, 122398)--13 second cd on player controled units, 18 seconds on non player controlled constructs
local timerDestabalize			= mod:NewTargetTimer(10, 123059)
local timerStruggleForControl	= mod:NewTargetTimer(5, 122395)
--Amber Monstrosity
local timerMassiveStompCD		= mod:NewCDTimer(18, 122408)--18-25 seconds variation
local timerFlingCD				= mod:NewCDTimer(25, 122413)--25-40sec variation.
local timerAmberExplosionAMCD	= mod:NewTimer(46, "timerAmberExplosionAMCD", 122402)--Special timer just for amber monstrosity. easier to cancel, easier to tell apart. His bar is the MOST important and needs to be seperate from any other bar option.

local countdownAmberExplosion	= mod:NewCountdown(49, 122398)

mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("FixNameplates", false)--Because having 215937495273598637205175t9 hostile nameplates on screen when you enter a construct is not cool.

local Phase = 1
local Puddles = 0
local Constructs = 0
local playerIsConstruct = false
local warnedWill = false
local lastStrike = 0
local scansDone = 0
local Totems = nil
local Guardians = nil
local Pets = nil
local TPTPNormal = nil
local amberExplosion = GetSpellInfo(122402)
local Monstrosity = EJ_GetSectionInfo(6254)
local MutatedConstruct = EJ_GetSectionInfo(6249)
local canInterrupt = {}
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetGroupMembers() do
		guids[UnitGUID("raid"..i) or "none"] = GetRaidRosterInfo(i)
	end
end

function mod:ScalpelTarget()
	scansDone = scansDone + 1
	local targetname = DBM:GetUnitFullName("boss1targettarget")--Not a mistake, just clever use of available api to get the target of an invisible mob the boss is targeting ;)
	if UnitExists("boss1targettarget") and not UnitIsUnit("boss1", "boss1targettarget") then
		warnAmberScalpel:Show(targetname)
		if targetname == UnitName("player") then
			specwarnAmberScalpel:Show()
			yellAmberScalpel:Yell()
		else
			local uId = DBM:GetRaidUnitId(targetname)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 5 then--Guessed range
					specwarnAmberScalpelNear:Show(targetname)
				end
			end
		end
	else--He failed sanity check (ie boss1targettarget was himself, so he was obviously still targeting tank, reschedule check)
		if scansDone < 6 then
			self:ScheduleMethod(0.2, "ScalpelTarget")
		end
	end
end

local function warnAmberExplosionCast(spellId, source)
	print("Debug: warnAmberExplosionCast event fired: ", spellId, source)--Determine if this event is even firing from syncs and not just from constructs > 0 internets == 0 scenario
	if #canInterrupt == 0 then--This will never happen if fired by "InterruptAvailable" sync since it should always be 1 or greater. This is just a fallback if contructs > 0 and we scheduled "warnAmberExplosionCast" there
		print("Debug: Interrupts were not available in warnAmberExplosionCast", spellId)
		specwarnAmberExplosion:Show(spellId == 122402 and Monstrosity or MutatedConstruct)--No interupts, warn the raid to prep for aoe damage with beware! alert.
	else--Interrupts available, lets call em out as a great tool to give raid leader split second decisions on who to allocate to the task (so they don't all waste it on same target and not have for next one).
		print("Debug: Interrupts were available in warnAmberExplosionCast", spellId)
		warnInterruptsAvailable:Show(spellId == 122402 and Monstrosity or MutatedConstruct, table.concat(canInterrupt, "<, >"))
	end
	table.wipe(canInterrupt)
end

function mod:OnCombatStart(delay)
	warnedWill = true--avoid wierd bug on pull
	buildGuidTable()
	Phase = 1
	Puddles = 0
	Constructs = 0
	lastStrike = 0
	table.wipe(canInterrupt)
	playerIsConstruct = false
	timerAmberScalpelCD:Start(9-delay)
	timerReshapeLifeCD:Start(20-delay)
	timerParasiticGrowthCD:Start(23.5-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.WillPower)--This is a work in progress
		DBM.InfoFrame:Show(5, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, true)--At a point i need to add an arg that lets info frame show the 5 LOWEST not the 5 highest, instead of just showing 10
	end
	if self.Options.FixNameplates then
		--Blizz settings either return 1 or nil, we pull users original settings first, then change em if appropriate after.
		Totems = GetCVarBool("nameplateShowEnemyTotems")
		Guardians = GetCVarBool("nameplateShowEnemyGuardians")
		Pets = GetCVarBool("nameplateShowEnemyPets")
		--Now change all settings to make the nameplates while in constructs not terrible.
		if Totems then
			SetCVar("nameplateShowEnemyTotems", 0)
		end
		if Guardians then
			SetCVar("nameplateShowEnemyGuardians", 0)
		end
		if Pets then
			SetCVar("nameplateShowEnemyPets", 0)
		end
		--Check for Tidy plates threat plates (it has additional options to even further hide worthless nameplates on unsok.
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then
			TPTPNormal = TidyPlatesThreat.db.profile.nameplate.toggle["Normal"]--Returns true or false, use TidyPlatesNormal to save that value on pull
			if TPTPNormal == true then
				TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] = false
				TidyPlates:ReloadTheme()--Call the Tidy plates update methods
				TidyPlates:ForceUpdate()
			end
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.FixNameplates then
		--if any of settings were on before pull, we put them back to way they were.
		if Totems then
			SetCVar("nameplateShowEnemyTotems", 1)
		end
		if Guardians then
			SetCVar("nameplateShowEnemyGuardians", 1)
		end
		if Pets then
			SetCVar("nameplateShowEnemyPets", 1)
		end
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then
			if TPTPNormal == true and not TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] then--Normal plates were on when we pulled but aren't on now.
				TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] = true--Turn them back on
				TidyPlates:ReloadTheme()--Call the Tidy plates update methods
				TidyPlates:ForceUpdate()
			end
		end
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123059) and not args:GetDestCreatureID() == 62691 then--Only track debuffs on boss, constructs, or monstrosity, ignore oozes.
		warnDestabalize:Show(args.destName, args.amount or 1)
		if self:IsDifficulty("lfr25") then
			timerDestabalize:Start(60, args.destName)
		else
			timerDestabalize:Start(args.destName)
		end
	elseif args:IsSpellID(121949) then
		warnParasiticGrowth:Show(args.destName)
		specwarnParasiticGrowth:Show(args.destName)
		if args:IsPlayer() then
			specwarnParasiticGrowthYou:Show()
		end
		timerParasiticGrowth:Start(args.destName)
		timerParasiticGrowthCD:Start()
	elseif args:IsSpellID(122540) then
		Phase = 2
		warnAmberCarapace:Show(args.destName)
		specwarnAmberMonstrosity:Show()
		timerMassiveStompCD:Start(20)
		timerFlingCD:Start(33)
		warnAmberExplosionSoon:Schedule(50.5)
		timerAmberExplosionAMCD:Start(55.5, amberExplosion, Monstrosity)
	elseif args:IsSpellID(122395) and Phase < 3 then
		warnStruggleForControl:Show(args.destName)
		timerStruggleForControl:Start(args.destName)
	elseif args:IsSpellID(122784) then
		Constructs = Constructs + 1
		warnReshapeLife:Show(args.destName)
		if args:IsPlayer() then
			playerIsConstruct = true
			warnedWill = true -- fix bad low will special warning on entering Construct. After entering vehicle, this will be return to false. (on alt.power changes)
			specwarnReshape:Show()
			warnReshapeLifeTutor:Show()
			timerAmberExplosionCD:Start(15, args.destName)--Only player needs to see this, they are only person who can do anything about it.
			countdownAmberExplosion:Start(15)
		end
		if Phase < 3 then
			timerReshapeLifeCD:Start()
		else
			timerReshapeLifeCD:Start(15)--More often in phase 3
		end
	elseif args:IsSpellID(125502) then
		warnAmberGlob:Show(args.destName)
		if args:IsPlayer() then
			specwarnAmberGlob:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122754) then
		timerDestabalize:Cancel(args.destName)
	elseif args:IsSpellID(122370) then
		Constructs = Constructs - 1
		if args:IsPlayer() then
			countdownAmberExplosion:Cancel()
			playerIsConstruct = false
		end
		timerAmberExplosionCD:Cancel(args.destName)
	elseif args:IsSpellID(121994) then
		timerAmberScalpelCD:Start()
	elseif args:IsSpellID(121949) then
		timerParasiticGrowth:Cancel(args.destName)
	elseif args:IsSpellID(122540) then--Phase 3
		Phase = 3
		timerMassiveStompCD:Cancel()
		timerFlingCD:Cancel()
		timerAmberExplosionAMCD:Cancel()
		warnAmberExplosionSoon:Cancel()
		--He does NOT reset reshape live cd here, he finishes out last CD first, THEN starts using new one.
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122398) then
		warnAmberExplosion:Show(args.sourceName, args.spellName)
		if args:GetSrcCreatureID() == 62701 then--Cast by a wild construct not controlled by player
			--This doesn't work, for no logical reason what so ever.
			print("Debug: Wild Contruct casting Explosion", GetTime(), lastStrike or 0)--Lets see what get time return and what last strike returns
			if playerIsConstruct and GetTime() - lastStrike >= 4 then--Player is construct and Amber Strike will be available before cast ends.
				print("Debug: You're a construct with available interrupt.")--First logic check passed, this debug tells us we're good so far.
				specwarnAmberExplosionOther:Show(args.spellName, args.sourceName)
				if self:LatencyCheck() then--if you're too laggy we don't want you telling us you can interrupt it 2-3 seconds from now. we only care if you can interrupt it NOW
					print("Debug: You successfully sent sync to raid about that interrupt")--Latency check passed, this debug tells us we should have at least sent a sync now
					self:SendSync("InterruptAvailable", UnitGUID("player")..":122398")
				end
			end
			--^^
			timerAmberExplosionCD:Start(18, args.sourceName, args.sourceGUID)--Longer CD if it's a non player controlled construct. Everyone needs to see this bar because there is no way to interrupt these.
			if Constructs == 0 then--No constructs, thus no interrupt. Give a beware warning.
				specwarnAmberExplosion:Show(args.sourceName)
			else--There is a construct, lets pass it to interrupt checker to determine if we still fire specwarnAmberExplosion
				self:Unschedule(warnAmberExplosionCast)
				self:Schedule(0.5, warnAmberExplosionCast, 122398)
			end
		elseif args.sourceGUID == UnitGUID("player") then--Cast by YOU
			specwarnAmberExplosionYou:Show(args.spellName)
			timerAmberExplosionCD:Start(13, args.sourceName)--Only player needs to see this, they are only person who can do anything about it.
			countdownAmberExplosion:Start(13)
		end
	elseif args:IsSpellID(122402) then--Amber Monstrosity
		--This doesn't work, for no logical reason what so ever.
		if playerIsConstruct and GetTime() - lastStrike >= 4 then--Player is construct and Amber Strike will be available before cast ends.
			print("Debug: You're a construct with available interrupt.")
			specwarnAmberExplosionAM:Show(args.spellName, args.sourceName)--On heroic, not interrupting amber montrosity is an auto wipe. this is single handedly the most important special warning of all!!!!!!
			if self:LatencyCheck() then--if you're too laggy we don't want you telling us you can interrupt it 2-3 seconds from now. we only care if you can interrupt it NOW
				print("Debug: You successfully sent sync to raid about that interrupt")
				self:SendSync("InterruptAvailable", UnitGUID("player")..":122402")
			end
		end
		--^^
		warnAmberExplosion:Show(args.sourceName, args.spellName)
		warnAmberExplosionSoon:Cancel()
		warnAmberExplosionSoon:Schedule(41)
		timerAmberExplosionAMCD:Start(46, args.spellName, args.sourceName)
		if Constructs == 0 then--No constructs, thus no interrupt. Give a beware warning.
			specwarnAmberExplosion:Show(args.sourceName)
		else--There is a construct, lets pass it to interrupt checker to determine if we still fire specwarnAmberExplosion
			self:Unschedule(warnAmberExplosionCast)
			self:Schedule(0.5, warnAmberExplosionCast, 122402, "Contructs")
		end
	elseif args:IsSpellID(122408) then
		warnMassiveStomp:Show()
		specwarnMassiveStomp:Show()
		timerMassiveStompCD:Start()
	elseif args:IsSpellID(122413) then
		warnFling:Show()
		specwarnFling:Show()
		timerFlingCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(122348) then
		warnLivingAmber:Show()
	elseif args:IsSpellID(121994) then
		scansDone = 0
		self:ScheduleMethod(0.2, "ScalpelTarget")
	elseif args:IsSpellID(122532) then
		Puddles = Puddles + 1
		warnBurningAmber:Show(Puddles)
	elseif args:IsSpellID(123156) then
		Puddles = Puddles - 1
		warnBurningAmber:Show(Puddles)
	elseif args:IsSpellID(122389) and args.sourceGUID == UnitGUID("player") then--Amber Strike
		lastStrike = GetTime()
		print("Debug: You just used Amber Strike", lastStrike, args.sourceGUID, UnitGUID("player"))--Maybe GetTime() is messing up, so let see what it is. Also see if for some reason sourceguid doesn't match players GUID
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 122504 and destGUID == UnitGUID("player") and self:AntiSpam(3) then
		specwarnBurningAmber:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_POWER(uId)
	if uId ~= "player" then return end
	if UnitPower(uId, ALTERNATE_POWER_INDEX) < 28 and not warnedWill then
		warnedWill = true
		specwarnWillPower:Show()
	elseif UnitPower(uId, ALTERNATE_POWER_INDEX) >= 32 and warnedWill then
		warnedWill = false
	end
end

function mod:OnSync(msg, str)
--	print("Debug: DBM Sync", msg, str)--Pretty sure this part is already working so leaving commented out.
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	local guid, spellId
	if str then
		guid, spellId = string.split(":", str)
		spellId = tonumber(spellId or "")
--		print("Debug: String Split Successful", spellId, guid)--Pretty sure this part is already working so leaving commented out.
	end
	if msg == "InterruptAvailable" and guids[guid] and spellId then
		print("Debug: InterruptAvailable sync recieve successful")--We got the sync, so now we know we got this far.
		canInterrupt[#canInterrupt + 1] = guids[guid]
		self:Unschedule(warnAmberExplosionCast)
		self:Schedule(0.5, warnAmberExplosionCast, spellId, "Interrupt")
	end
end
