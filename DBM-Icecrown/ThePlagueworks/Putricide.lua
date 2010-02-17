local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(36678)
mod:RegisterCombat("yell", L.YellPull)
mod:SetUsedIcons(1, 2, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH"
)

local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 3)
local warnUnstableExperimentSoon	= mod:NewSoonAnnounce(70351, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 3)
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 4)
local warnGaseousBloat				= mod:NewTargetAnnounce(70672, 4)
local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnTearGas					= mod:NewSpellAnnounce(71617)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnMalleableGoo				= mod:NewSpellAnnounce(72295, 3)		-- Phase 2 ability
local warnChokingGasBomb			= mod:NewSpellAnnounce(71255, 3)		-- Phase 2 ability
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnMutatedPlague				= mod:NewAnnounce("WarnMutatedPlague", 3) -- Phase 3 ability
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 4)
local warnOozeVariable				= mod:NewTargetAnnounce(70352)			-- Heroic Ability
local warnGasVariable				= mod:NewTargetAnnounce(70353)			-- Heroic Ability

local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447)
local specWarnGaseousBloat			= mod:NewSpecialWarningYou(70672)
local specWarnVolatileOozeOther		= mod:NewSpecialWarningTarget(70447, false)
local specWarnGaseousBloatOther		= mod:NewSpecialWarningTarget(70672, false)
local specWarnMalleableGoo			= mod:NewSpecialWarning("specWarnMalleableGoo")
local specWarnMalleableGooNear		= mod:NewSpecialWarning("specWarnMalleableGooNear")
local specWarnOozeVariable			= mod:NewSpecialWarningYou(70352)		-- Heroic Ability
local specWarnGasVariable			= mod:NewSpecialWarningYou(70353)		-- Heroic Ability
local specWarnUnboundPlague			= mod:NewSpecialWarning("specWarnUnboundPlague") -- you have to drop the debuff by staying very close to an other player
local specWarnNextUnboundPlageSelf	= mod:NewSpecialWarning("specWarnNextPlageSelf") -- you are the aquired target for the Plague, prepare yourself!

local timerGaseousBloat				= mod:NewTargetTimer(20, 70672)			-- Duration of debuff
local timerSlimePuddleCD			= mod:NewCDTimer(35, 70341)				-- Approx
local timerUnstableExperimentCD		= mod:NewNextTimer(38, 70351)			-- Used every 38 seconds exactly except after tear gas, it resets then it's 42-44seconds later (so using 43sec timer for there)
local timerChokingGasBombCD			= mod:NewNextTimer(35.5, 71255)
local timerMalleableGooCD			= mod:NewCDTimer(25, 72295)
local timerTearGas					= mod:NewBuffActiveTimer(19, 71615)
local timerMutatedPlague			= mod:NewTargetTimer(60, 72451)			-- 60 Seconds until expired
local timerMutatedPlagueCD			= mod:NewCDTimer(10, 72451)				-- 10 to 11
local timerUnboundPlague			= mod:NewBuffActiveTimer(10, 72856)		-- Heroic Ability: we can't keep the debuff 60 seconds, so we have to switch at 10 seconds. Otherwise the debuff does to much damage!

-- buffs from "Drink Me"
local timerMutatedSlash				= mod:NewTargetTimer(20, 70542)
local timerRegurgitatedOoze			= mod:NewTargetTimer(20, 70539)

local berserkTimer					= mod:NewBerserkTimer(600)

local soundGaseousBloat = mod:NewSound(72455)

mod:AddBoolOption("OozeAdhesiveIcon")
mod:AddBoolOption("GaseousBloatIcon")
mod:AddBoolOption("MalleableGooIcon")

mod:AddBoolOption("UnboundPlagueIcon")					-- icon on the player with active buff
mod:AddBoolOption("NextUnboundPlagueTargetIcon")		-- icon on the aquired target (will be requested via Sync)

mod:AddBoolOption("YellOnMalleableGoo", true, "announce")

local warned_preP2 = false
local warned_preP3 = false
local spamPuddle = 0
local phase = 0
local oozeVariableTargets	= {}
local gasVariableTargets	= {}

local function warnOozeVariableTargets()
	warnOozeVariable:Show(table.concat(oozeVariableTargets, "<, >"))
	table.wipe(oozeVariableTargets)
end

local function warnGasVariableTargets()
	warnGasVariable:Show(table.concat(gasVariableTargets, "<, >"))
	table.wipe(gasVariableTargets)
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
	warnUnstableExperimentSoon:Schedule(25-delay)
	warned_preP2 = false
	warned_preP3 = false
	phase = 1
end

function mod:MalleableGooTarget()--. Great for 10 man, but only marks/warns 1 of the 2 people in 25 man
	local targetname = self:GetBossTarget(36678)
	if not targetname then return end
		if self.Options.MalleableGooIcon then
			self:SetIcon(targetname, 6, 10)
		end
	if targetname == UnitName("player") then
		specWarnMalleableGoo:Show()
		if self.Options.YellOnMalleableGoo then
			SendChatMessage(L.YellMalleableGoo, "YELL")
		end
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnMalleableGooNear:Show()
			end
		end
	end
end

local function isDebuffed(unitId)
	for i=1, 15 do	-- don't think we have to check for 40 debuffs,.. (correct me if i'm wrong, but want to save some cpu)
		local spellId = select(11, UnitDebuff(unitId, i))
		if spellId == 73117 or 		-- Plague Sickness
		   spellId == 72838 or		-- Volatile Ooze Adhesive (Green Slime)
		   spellId == 72833 then	-- Gaseous Bloat (Red Slime)
			return true
		end
	end
	return false
end

function mod:AquireTargetForUnboundPlague()
	local myX, myY = GetPlayerMapPosition("player")
	local mytarget = "player"
	local mydistance = 0
	local temprange = 0
	for i=1, GetNumRaidMembers(), 1 do
		if not UnitIsUnit("player", "raid"..i) then
			temprange = DBM.RangeCheck:GetDistance("raid"..i, myX, myY)
			if temprange > 0 and temprange < 30 and temprange < mydistance then
				if not isDebuffed("raid"..i) then	-- don't aquire targets with debuffs like "Plage Sickness", Red/Green Slime,..
					mytarget = "raid"..i
					mydistance = temprange
				end
			end
		end
	end
	DBM.Arrow:ShowRunTo(mytarget)
	self:SendSync("IconUnboundPlagueNext", UnitName(mytarget))
	self:ScheduleMethod(1, "AquireTargetForUnboundPlague")
end

do 
	local lastsyncself = 0
	function mod:OnSync(msg, arg)
		if msg == "IconUnboundPlagueNext" then
			if self.Options.NextUnboundPlagueTargetIcon then
				self:SetIcon(arg, 1, 20)
			end
			if arg and arg == UnitName("player") then		-- you are the next target for Unbound Plague 
				if GetTime() - 10 > lastsyncself then
					lastsyncself = GetTime()
					specWarnNextUnboundPlageSelf:Show()
				end
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70351, 71966) then
		warnUnstableExperimentSoon:Cancel()
		warnUnstableExperiment:Show()
		timerUnstableExperimentCD:Start()
		warnUnstableExperimentSoon:Schedule(33)
	elseif args:IsSpellID(71617) then
		warnTearGas:Show()
		if phase == 1 then
			warnUnstableExperimentSoon:Cancel()
			timerUnstableExperimentCD:Start(43)--Casting tear gas also resets experiment cooldown
			timerSlimePuddleCD:Start()--Casting tear gas resets slime puddle CD too
			warnUnstableExperimentSoon:Schedule(38)
			if mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25") then
				timerChokingGasBombCD:Start()--normal 35-36 seconds
			else
				timerChokingGasBombCD:Start(37)--37 seconds on 10 man
			end
		end
		if phase == 2 then
			timerUnstableExperimentCD:Cancel()--Casting tear gas second time before phase 3 which means no more experiments
			warnUnstableExperimentSoon:Cancel()
			timerSlimePuddleCD:Start()
			if mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25") then
				timerChokingGasBombCD:Start(40)--40 seconds after second tear gas on 25 man
			else
				timerChokingGasBombCD:Start(30)--30 seconds after second tear gas on 10 man
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70341) and GetTime() - spamPuddle > 5 then
		warnSlimePuddle:Show()
		timerSlimePuddleCD:Start()
		spamPuddle = GetTime()
	elseif args:IsSpellID(71255) then
		warnChokingGasBomb:Show()
		timerChokingGasBombCD:Start()
	elseif args:IsSpellID(72295, 72615, 72295, 72296) then
		warnMalleableGoo:Show()
		timerMalleableGooCD:Start()
		self:ScheduleMethod(0.1, "MalleableGooTarget")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then--Green Slime
		warnVolatileOozeAdhesive:Show(args.destName)
		specWarnVolatileOozeOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnVolatileOozeAdhesive:Show()
		end
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(70672, 72455, 72833) then	--Red Slime
		warnGaseousBloat:Show(args.destName)
		specWarnGaseousBloatOther:Show(args.destName)
		timerGaseousBloat:Start(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
			soundGaseousBloat:Play()
		end
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 7, 20)
		end
	elseif args:IsSpellID(71615, 71618) then	--71615 used in 10 and 25 normal, 71618 heroic ID maybe?(this id doesn't make immune, only stuns)
		timerTearGas:Start()
	elseif args:IsSpellID(71603) then	-- Mutated Strength
		warnPhase3:Show()
	elseif args:IsSpellID(72451) then	-- Mutated Plague
		warnMutatedPlague:Show(args.spellName, args.destName, args.amount or 1)
		timerMutatedPlague:Start(args.destName)
		timerMutatedPlagueCD:Start()
	elseif args:IsSpellID(70542) then
		timerMutatedSlash:Show(args.destName)
	elseif args:IsSpellID(70539) then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args:IsSpellID(70352, 74118) then	--Ooze Variable
		oozeVariableTargets[#oozeVariableTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnOozeVariable:Show()
		end
		self:Unschedule(warnOozeVariableTargets)
		self:Schedule(0.3, warnOozeVariableTargets)
	elseif args:IsSpellID(70353, 74119) then	-- Gas Variable
		gasVariableTargets[#gasVariableTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnGasVariable:Show()
		end
		self:Unschedule(warnGasVariableTargets)
		self:Schedule(0.3, warnGasVariableTargets)
	elseif args:IsSpellID(72856) then			 -- Unbound Plague
		timerUnboundPlague:Start(args.destName)
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 2, 20)
		end
		if args:IsPlayer() then
			specWarnUnboundPlague:Schedule(10)
			self:ScheduleMethod(3, "AquireTargetForUnboundPlague")		-- we aquire target after 3 sec, 7 sec to get the target positioned must be enough ^^^
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		if self.Options.OozeAdhesiveIcon then
			mod:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70672, 72455) then
		timerGaseousBloat:Cancel(args.destName)
		if self.Options.GaseousBloatIcon then
			mod:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(71615, 71618) and phase == 1 then	-- only show one time
		phase = 2
		warnPhase2:Show()
	elseif args:IsSpellID(72856) then 						-- Unbound Plague
		timerUnboundPlague:Stop(args.destName)
		if args:IsPlayer() then
			specWarnUnboundPlague:UnSchedule()
			self:UnScheduleMethod("AquireTargetForUnboundPlague")
		end
		if self.Options.UnboundPlagueIcon then
			mod:SetIcon(args.destName, 0)
		end
	end
end

--values subject to tuning depending on dps and his health pool
function mod:UNIT_HEALTH(uId)
	if phase == 1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.83 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
	elseif phase == 2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end



