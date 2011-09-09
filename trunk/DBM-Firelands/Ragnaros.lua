local mod	= DBM:NewMod(198, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetModelID(37875)
mod:SetZone()
mod:SetUsedIcons(1, 2)
mod:SetModelSound("Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_AGGRO.wav", "Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_KILL_03.wav")
--Long: blah blah blah (didn't feel like transcribing it)
--Short: This is my realm

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH",
	"UNIT_AURA"
)

local warnHandRagnaros		= mod:NewSpellAnnounce(98237, 3, nil, mod:IsMelee())--Phase 1 only ability
local warnWrathRagnaros		= mod:NewSpellAnnounce(98263, 3, nil, mod:IsRanged())--Phase 1 only ability
local warnBurningWound		= mod:NewStackAnnounce(99399, 3, nil, mod:IsTank() or mod:IsHealer())
local warnSulfurasSmash		= mod:NewSpellAnnounce(98710, 4)--Phase 1-3 ability.
local warnMoltenSeed		= mod:NewSpellAnnounce(98520, 4)--Phase 2 only ability
local warnLivingMeteor		= mod:NewCountAnnounce(99268, 4)--Phase 3 only ability
local warnBreadthofFrost	= mod:NewSpellAnnounce(100479, 2)--Heroic phase 4 ability
local warnCloudBurst		= mod:NewSpellAnnounce(100714, 2)--Heroic phase 4 ability (only casts this once, doesn't seem to need a timer)
local warnEntrappingRoots	= mod:NewSpellAnnounce(100646, 3)--Heroic phase 4 ability
local warnEmpoweredSulf		= mod:NewSpellAnnounce(100997, 4)--Heroic phase 4 ability
local warnSplittingBlow		= mod:NewAnnounce("warnSplittingBlow", 3, 100877)
local warnSonsLeft			= mod:NewAnnounce("WarnRemainingAdds", 2, 99014)
local warnEngulfingFlame	= mod:NewAnnounce("warnEngulfingFlame", 4, 99171)
local warnAggro				= mod:NewAnnounce("warnAggro", 4, 99601, nil, false)
local warnNoAggro			= mod:NewAnnounce("warnNoAggro", 1, 99601, nil, false)
mod:AddBoolOption("ElementalAggroWarn", true, "announce")
local warnBlazingHeat		= mod:NewTargetAnnounce(100460, 4)--Second transition adds ability.
local warnMagmaTrap			= mod:NewTargetAnnounce(98164, 3)--Second transition adds ability.
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3, 3)

local specWarnSulfurasSmash	= mod:NewSpecialWarningSpell(98710, false)
local specWarnSplittingBlow	= mod:NewSpecialWarningSpell(100877)
local specWarnMoltenSeed	= mod:NewSpecialWarningSpell(98520, nil, nil, nil, true)
local specWarnBlazingHeat	= mod:NewSpecialWarningYou(100460)
local specWarnMagmaTrap		= mod:NewSpecialWarningMove(98164)
local yellMagmaTrap			= mod:NewYell(98164)--May Return false tank yells
local specWarnEngulfing		= mod:NewSpecialWarningMove(99171)
local specWarnMeteor		= mod:NewSpecialWarningYou(99849)
local yellMeteor			= mod:NewYell(99849)
local specWarnWorldofFlames	= mod:NewSpecialWarningSpell(100171, nil, nil, nil, true)
local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, mod:IsTank(), 4)
local specWarnEmpoweredSulf	= mod:NewSpecialWarningSpell(100997, mod:IsTank())--Heroic ability Asuming only the tank cares about this? seems like according to tooltip 5 seconds to hide him into roots?

local timerMagmaTrap		= mod:NewCDTimer(25, 98164)		-- Phase 1 only ability. 25-30sec variations.
local timerSulfurasSmash	= mod:NewCDTimer(30, 98710)		-- might even be a "next" timer
local timerHandRagnaros		= mod:NewCDTimer(25, 98237, nil, mod:IsMelee())-- might even be a "next" timer
local timerWrathRagnaros	= mod:NewCDTimer(30, 98263, nil, mod:IsRanged())--It's always 12 seconds after smash.
local timerBurningWound		= mod:NewTargetTimer(20, 99399, nil, mod:IsTank() or mod:IsHealer())
local timerFlamesCD			= mod:NewCDTimer(40, 99171)
local timerMoltenSeedCD		= mod:NewCDTimer(60, 98520)--60 seconds CD in between from seed to seed. 50 seconds using the molten inferno trigger.
local timerMoltenInferno	= mod:NewBuffActiveTimer(10, 100254)--Cast bar for molten Inferno (seeds exploding)
local timerLivingMeteorCD	= mod:NewNextCountTimer(45, 99268)
local timerInvokeSons		= mod:NewCastTimer(17, 99014)--8 seconds for splitting blow, about 8-10 seconds after for them landing, using the average, 9.
local timerPhaseSons		= mod:NewTimer(45, "TimerPhaseSons", 99014)	-- lasts 45secs or till all sons are dead
local timerCloudBurstCD		= mod:NewCDTimer(50, 100714)--No idea what it is
local timerBreadthofFrostCD	= mod:NewCDTimer(45, 100479)--No idea what it is
local timerEntrapingRootsCD	= mod:NewCDTimer(56, 100646)--Always cast before empowered sulf, varies between 3 sec before and like 11 sec before.
local timerEmpoweredSulfCD	= mod:NewCDTimer(56, 100997)--No idea what it is

local SeedsCountdown		= mod:NewCountdown(60, 98520)

local berserkTimer			= mod:NewBerserkTimer(1080)

local soundBlazingHeat		= mod:NewSound(100460)
local soundMeteor			= mod:NewSound(99849)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("BlazingHeatIcons", true)
mod:AddBoolOption("InfoHealthFrame", false)
mod:AddBoolOption("InfoFrame", true)

local wrathRagSpam = 0
local meteorSpawned = 0
local sonsLeft = 8
local trapScansDone = 0
local phase = 1
local prewarnedPhase2 = false
local prewarnedPhase3 = false
local phase2Started = false
local phase3Started = false
local blazingHeatIcon = 2
local seedsActive = false
local seedsScheduled = false
local meteorWarned = false
local meteorTarget = GetSpellInfo(99849)

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	-- 4. anyone with 180k+ health
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	if UnitHealthMax(unit) >= 180000 then return true end--Will need tuning or removal for new expansions or maybe even new tiers.
	return false
end

local function showRangeFrame()
	if mod.Options.RangeFrame then
		if phase == 1 and mod:IsRanged() then
			DBM.RangeCheck:Show(6)--For wrath of rag, only for ranged.
		elseif phase == 2 then
			DBM.RangeCheck:Show(6)--For seeds
		elseif phase == 3 then
			DBM.RangeCheck:Show(5)--For meteors (honestly i still cannot fathom why this is useful still. the idea for meteors is to stack up not spread out, unless you're kiting it.
		elseif phase == 4 then
			DBM.RangeCheck:Show(6)--maybe useful for setting up your triforce but i'm not entirely sure we need a range frame in phase 4 either.
		end
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function clearSeedsActive()
	seedsActive = false
	seedsScheduled = false
end

local function showAggroWarning()
	if mod:IsTank() or not mod.Options.ElementalAggroWarn then return end--IF you're a tank it's 50/50 you have rag aggro. I could check this but i don't think in any situation it's relevent anyways (ie the tank isn't actually gonna run away from it, he'll tank it if using spread method, or it'll be dead already if using aoe method)
	if UnitThreatSituation("player") == 3 then
		warnAggro:Show()
	else
		warnNoAggro:Show()
	end
end

local function warnSeeds()
	warnMoltenSeed:Show()
	specWarnMoltenSeed:Show()
	timerMoltenInferno:Start()
end


local function TransitionEnded()
	timerPhaseSons:Cancel()
	if phase == 2 and not phase2Started then
		if mod:IsDifficulty("heroic10", "heroic25") then
			timerSulfurasSmash:Start(6)
			timerMoltenSeedCD:Start(15)
		else
			timerSulfurasSmash:Start(15.5)
			timerMoltenSeedCD:Start(22)
		end
		timerFlamesCD:Start()--Probably the only thing that's really consistent.
		showRangeFrame()--Range 6 for seeds
		if mod.Options.InfoHealthFrame then
			DBM.InfoFrame:Hide()
		end
	elseif phase == 3 and not phase3Started then
		phase3Started = true
		showRangeFrame()--Range 5 for meteors (should it be 8 instead?) Conflicting tooltip information.
		timerSulfurasSmash:Start(15.5)--Also a variation.
		timerFlamesCD:Start(30)
		timerLivingMeteorCD:Start(45, 1)
		if mod.Options.InfoFrame then--This is probably the best way to do it without spam. Does not show in combat log, only unitdebuff/unit_aura will probaby work. will have to find a way to give personal warnings without spam later.
			DBM.InfoFrame:SetHeader(L.MeteorTargets)
			DBM.InfoFrame:Show(6, "playerbaddebuff", 99849)--Maybe need more then 6? 8 or 10 if things go real shitty heh.
		end
	elseif phase == 4 then
		timerLivingMeteorCD:Cancel()
		--Start other timers here later for heroic stuffs!
		--timerEmpoweredSulfCD:Start()
		--timerEntrapingRootsCD:Start()
		--timerBreadthofFrostCD:Start()
		showRangeFrame()
		timerBreadthofFrostCD:Start(33)
		timerCloudBurstCD:Start()
		timerEntrapingRootsCD:Start(67)
		timerEmpoweredSulfCD:Start(89)
	end
end

function mod:MagmaTrapTarget()
	trapScansDone = trapScansDone + 1
	if UnitExists("boss1target") then--Check if he actually has a target.
		local targetname = UnitName("boss1target")
		local uId = DBM:GetRaidUnitId(targetname)
		if isTank(uId) then--He's targeting his highest threat target or someone that's definitely a tank.
			if trapScansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.025, "MagmaTrapTarget")--Check again for right target, tanks don't get magma traps.
			end
		else--He's not targeting highest threat target so this has to be right target.
			self:UnscheduleMethod("MagmaTrapTarget")--Unschedule all checks just to be sure none are running, we are done.
			warnMagmaTrap:Show(targetname)
			if targetname == UnitName("player") then
				specWarnMagmaTrap:Show()
				yellMagmaTrap:Yell()
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if trapScansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.025, "MagmaTrapTarget")
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerWrathRagnaros:Start(6-delay)--People complained about not having this timer, even though it's practically cast on the pull, so here it is.
	timerMagmaTrap:Start(16-delay)
	timerHandRagnaros:Start(-delay)
	timerSulfurasSmash:Start(-delay)
	wrathRagSpam = 0
	meteorSpawned = 0
	sonsLeft = 8
	trapScansDone = 0
	phase = 1
	prewarnedPhase2 = false
	prewarnedPhase3 = false
	blazingHeatIcon = 2
	phase2Started = false
	phase3Started = false
	seedsActive = false
	meteorWarned = false
	seedsScheduled = false
	showRangeFrame()
	if self:IsDifficulty("normal10", "normal25") then--register alternate kill detection, he only dies on heroic.
		self:RegisterKill("yell", L.Defeat)
	end
	if self.Options.InfoHealthFrame then
		DBM.InfoFrame:SetHeader(L.HealthInfo)
		DBM.InfoFrame:Show(5, "health", 90000)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame or self.Options.InfoHealthFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99399, 101238, 101239, 101240) then
		previousTank = args.destName
		warnBurningWound:Show(args.destName, args.amount or 1)
		if (args.amount or 0) >= 4 and args:IsPlayer() then
			specWarnBurningWound:Show(args.amount)
		end
		timerBurningWound:Start(args.destName)
	elseif args:IsSpellID(100171, 100190) then--World of Flames, heroic trigger for engulfing flames. CD timing seems same as normal.
		specWarnWorldofFlames:Show()
		if phase == 3 then
			timerFlamesCD:Start(30)--30 second CD in phase 3
		else
			timerFlamesCD:Start()--40 second CD in phase 2
		end
	elseif args:IsSpellID(100997) then
		warnEmpoweredSulf:Show()
		specWarnEmpoweredSulf:Show()
		timerEmpoweredSulfCD:Start()
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99399, 101238, 101239, 101240) then
		timerBurningWound:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98710, 100890, 100891, 100892) then
		warnSulfurasSmash:Show()
		specWarnSulfurasSmash:Show()
		if phase == 1 or phase == 3 then
			timerSulfurasSmash:Start()--30 second cd in phase 1 and phase 3
			if phase == 1 and not self:IsDifficulty("heroic10") then--10 man heroic seems to have it's own rule while other 3 all work this way
				timerWrathRagnaros:Update(18, 30)--This is most accurate place to put it so we use auto correction here.
			end
		else
			timerSulfurasSmash:Start(40)--40 seconds in phase 2
			if not phase2Started then
				phase2Started = true
				if self:IsDifficulty("heroic10", "heroic25") then
					self:Schedule(9, warnSeeds)--Schedule the warnings here for more accuracy
					timerMoltenSeedCD:Update(6, 15)--Update the timer here if it's off, but timer still starts at yell so it has more visability sooner.
					SeedsCountdown:Start(9)
				else
					self:Schedule(6.5, warnSeeds)
					timerMoltenSeedCD:Update(15.5, 22)
					SeedsCountdown:Start(6.5)
				end
			end
		end
	elseif args:IsSpellID(98951, 98952, 98953, 100877) or args:IsSpellID(100878, 100879, 100880, 100881) or args:IsSpellID(100882, 100883, 100884, 100885) then--This has 12 spellids, 1 for each possible location for hammer.
		sonsLeft = 8
		phase = phase + 1
		self:Unschedule(warnSeeds)
		SeedsCountdown:Cancel()
		timerMoltenSeedCD:Cancel()
		timerMagmaTrap:Cancel()
		timerSulfurasSmash:Cancel()
		timerHandRagnaros:Cancel()
		timerWrathRagnaros:Cancel()
		hideRangeFrame()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerPhaseSons:Start(60)--Longer on heroic
		else
			timerPhaseSons:Start(47)--45 sec plus the 2 or so seconds he takes to actually come up and yell.
		end
		specWarnSplittingBlow:Show()
		timerInvokeSons:Start()
		--Middle: 98952 (10N), 100877 (25N) (Guessed: 100878, 100879)
		--East: 98953 (10N), 100880 (25N) (Guessed: 100881, 100882)
		--West: 98951 (10N), 100883 (25N) (Guessed: 100884, 100885)
		if args:IsSpellID(98952, 100877) then--Middle
			warnSplittingBlow:Show(args.spellName, L.Middle)
		elseif args:IsSpellID(98953, 100880) then--East
			warnSplittingBlow:Show(args.spellName, L.East)
		elseif args:IsSpellID(98951, 100883) then--West
			warnSplittingBlow:Show(args.spellName, L.West)
		end
	elseif args:IsSpellID(99172, 100175) or args:IsSpellID(99235, 100178) or args:IsSpellID(99236, 100181) then--Another scripted spell with a ton of spellids based on location of room. heroic purposely excluded do to different mechanic linked to World of Flames that will be used instead.
		if phase == 3 then
			timerFlamesCD:Start(30)--30 second CD in phase 3
		else
			timerFlamesCD:Start()--40 second CD in phase 2
		end
		--North: 99172 (10N), 100175 (25N)
		--Middle: 99235 (10N), 100178 (25N)
		--South: 99236 (10N), 100181 (25N)
		if args:IsSpellID(99172, 100175) then--North
			warnEngulfingFlame:Show(args.spellName, L.North)
			if self:IsMelee() or seedsActive then--Always warn melee classes if it's in melee (duh), warn everyone if seeds are active since 90% of strats group up in melee
				specWarnEngulfing:Show()
			end
		elseif args:IsSpellID(99235, 100178) then--Middle
			warnEngulfingFlame:Show(args.spellName, L.Middle)
		elseif args:IsSpellID(99236, 100181) then--South
			warnEngulfingFlame:Show(args.spellName, L.South)
		end
	elseif args:IsSpellID(100646) then
		warnEntrappingRoots:Show()
		timerEntrapingRootsCD:Start()
	elseif args:IsSpellID(100479) then
		warnBreadthofFrost:Show()
		timerBreadthofFrostCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98237, 100383, 100384, 100387) and not args:IsSrcTypePlayer() then -- can be stolen which triggers a new SPELL_CAST_SUCCESS event...
		warnHandRagnaros:Show()
		timerHandRagnaros:Start()
	elseif args:IsSpellID(98164) then	--98164 confirmed
		trapScansDone = 0
		timerMagmaTrap:Start()
		self:MagmaTrapTarget()
	elseif args:IsSpellID(98263, 100113, 100114, 100115) and GetTime() - wrathRagSpam >= 4 then
		wrathRagSpam = GetTime()
		warnWrathRagnaros:Show()
		if self:IsDifficulty("heroic10") then--it has a 25 second cd on 10 man heroic, the other 3 (including 10 man normal) are 30seconds, strange.
			timerWrathRagnaros:Start(25)
		else
			timerWrathRagnaros:Start()--Start a timer here for most visability, all but one started from here will be accurate. the one that isn't will be fixed by smash update function.
		end
	elseif args:IsSpellID(100460, 100981, 100982, 100983) then	-- Blazing heat, drycoded.
		warnBlazingHeat:Show(args.destName)
		if args:IsPlayer() then
			specWarnBlazingHeat:Show()
			soundBlazingHeat:Play()
		end
		if self.Options.BlazingHeatIcons then
			self:SetIcon(args.destName, blazingHeatIcon, 8)
			if blazingHeatIcon == 2 then-- Alternate icons, they are cast too far apart to sort in a table or do icons at once, and there are 2 adds up so we need to do it this way.
				blazingHeatIcon = 1
			else
				blazingHeatIcon = 2
			end
		end
	elseif args:IsSpellID(99268) then
		meteorSpawned = meteorSpawned + 1
		warnLivingMeteor:Cancel()--Unschedule the first warning in the 2 spawn sets before it goes off.
		timerLivingMeteorCD:Cancel()--Cancel timer
		warnLivingMeteor:Schedule(1, meteorSpawned)--Schedule with delay for the sets of 2, so we only warn once.
		timerLivingMeteorCD:Start(45, meteorSpawned+1)--Start new one with new count.
	elseif args:IsSpellID(100714) then
		warnCloudBurst:Show()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(98498, 100579, 100580, 100581) and not seedsActive then--Update seedsActive on earliest possible for engulfing melee warning for normal mode.
		seedsActive = true
	elseif args:IsSpellID(98518, 100252, 100253, 100254) then--Molten Inferno. This is seed exploding at end, we use it to schedule warnings for next seeds
		if not seedsActive then--In case no one took damage on normal mode from cast, activate seedsActive variable here for the melee engulfing warning.
			seedsActive = true
		end
		if not seedsScheduled then--Only schedule once.
			seedsScheduled = true
			self:Schedule(49, warnSeeds)
			SeedsCountdown:Start(49)
			timerMoltenSeedCD:Start(49)
			self:Schedule(15, clearSeedsActive)--Clear active/warned seeds after they have all blown up.
			--[22:58:04.965] Molten Elemental Molten Inferno Melissii Miss
			--[22:58:05.692] Molten Elemental Molten Inferno Magicmoose 3553 (R: 2160)
			self:Schedule(2.5, showAggroWarning)--Not sure fastest timing for this, gotta wait for them all to spawn. or if they fixate immediately on spawn in time stamps above or we need an additional second or two.
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE--Improve the accuracy by tracking aborbs too since the timers are entirely based on the first one going off.


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then
		sonsLeft = sonsLeft - 1
		if sonsLeft < 3 then
			warnSonsLeft:Show(sonsLeft)
		end
	elseif cid == 53500 then
		meteorSpawned = meteorSpawned - 1
		if meteorSpawned == 0 and self.Options.InfoFrame then--Meteors all gone, hide info frame
			DBM.InfoFrame:Hide()
		end	
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.TransitionEnded1 or msg:find(L.TransitionEnded1) or msg == L.TransitionEnded2 or msg:find(L.TransitionEnded2) or msg == L.TransitionEnded3 or msg:find(L.TransitionEnded3) then--This is more reliable then adds which may or may not add up to 8 cause blizz sucks. Plus it's more precise anyways, timers seem more consistent with this method.
		TransitionEnded()
	elseif (msg == L.Phase4 or msg:find(L.Phase4)) and self:IsInCombat() then
		phase = 4
		TransitionEnded()--Easier to just trigger this and keep all phase change stuff in one place.
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 52409 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 80 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 72 and h < 75 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		elseif h > 50 and prewarnedPhase3 then
			prewarnedPhase3 = false
		elseif h > 42 and h < 45 and not prewarnedPhase3 then
			prewarnedPhase3 = true
			warnPhase3Soon:Show()
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", meteorTarget) and not meteorWarned then--Warn you that you have a meteor
		specWarnMeteor:Show()
		yellMeteor:Yell()
		soundMeteor:Play()
		meteorWarned = true
	elseif not UnitDebuff("player", meteorTarget) and meteorWarned then--reset warned status if you don't have debuff
		meteorWarned = false
	end
end