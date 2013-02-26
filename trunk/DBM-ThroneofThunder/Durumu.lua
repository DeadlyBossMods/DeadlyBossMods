if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(818, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68036)--Crimson Fog 69050, 
mod:SetModelID(47189)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnHardStare					= mod:NewSpellAnnounce(133765, 3, nil, mod:IsTank() or mod:IsHealer())--Announce CAST not debuff, cause it misses a lot, plus we have 1 sec to hit an active mitigation
local warnForceOfWill				= mod:NewSpellAnnounce(136413, 4)
local warnLingeringGaze				= mod:NewTargetAnnounce(138467, 3)--Seems highly variable Cd so no timer for this yet
local warnBlueBeam					= mod:NewTargetAnnounce(133677, 2)
local warnRedBeam					= mod:NewTargetAnnounce(133732, 2)
local warnYellowBeam				= mod:NewTargetAnnounce(133738, 2)
local warnCrimsonLeft				= mod:NewAddsLeftAnnounce("ej6892", 2, 134123)
local warnDisintegrationBeam		= mod:NewSpellAnnounce("ej6882", 4)
local warnLifeDrain					= mod:NewTargetAnnounce(133795, 3, nil, mod:IsTank() or mod:IsHealer())
local warnDarkParasite				= mod:NewTargetAnnounce(133597, 3, nil, mod:IsHealer())--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, mod:IsTank(), 4)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTarget(133767, mod:IsTank())
local specWarnForceOfWill			= mod:NewSpecialWarningYou(136413, nil, nil, nil, 3)--VERY important, if you get hit by this you are out of fight for rest of pull.
local specWarnForceOfWillNear		= mod:NewSpecialWarningClose(136413, nil, nil, nil, 3)
local yellForceOfWill				= mod:NewYell(136413)
local specWarnLingeringGaze			= mod:NewSpecialWarningYou(134044)
local yellLingeringGaze				= mod:NewYell(134044, nil, false)
local specWarnLingeringGazeMove		= mod:NewSpecialWarningMove(134044)
local specWarnBlueBeam				= mod:NewSpecialWarningYou(133677)
local specWarnRedBeam				= mod:NewSpecialWarningYou(133732)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(133738)
local specWarnDisintegrationBeam	= mod:NewSpecialWarning("specWarnDisintegrationBeam", nil, nil, nil, 2)
local specWarnEyeSore				= mod:NewSpecialWarningMove(140502)
local specWarmLifeDrain				= mod:NewSpecialWarningTarget(133795, mod:IsTank())--Pretty much exhale all over again from zorlok. Tank intercepts beam to take damage instead

local timerHardStareCD				= mod:NewCDTimer(12, 133765, mod:IsTank() or mod:IsHealer())--10 second cd but delayed by everything else. Example variation, 12, 15, 9, 25, 31
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(45, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewCDTimer(60, "ej6891")--Don't know when 2nd one is cast.
local timerDarkParasite				= mod:NewTargetTimer(30, 136413, mod:IsHealer())--Only healer/dispeler needs to know this.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598)--EVERYONE needs to know this, if dispeler messed up and dispelled parasite too early you're going to get a new add every 3 seconds for remaining duration of this bar.
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(60, "ej6882")
local timerDisintegrationBeamCD		= mod:NewNextTimer(131, "ej6882")

local crimsonFogs = 3
local lingeringGazeTargets = {}

mod:AddBoolOption("ArrowOnBeam", true)

local function warnLingeringGazeTargets()
	warnLingeringGaze:Show(table.concat(lingeringGazeTargets, "<, >"))
	table.wipe(lingeringGazeTargets)
end

local function BeamEnded()
	if mod.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end
	timerForceOfWillCD:Start(19)
	timerLingeringGazeCD:Start(25)
	timerLightSpectrumCD:Start(37)
	timerDisintegrationBeamCD:Start()
end

function mod:OnCombatStart(delay)
	crimsonFogs = 3
	table.wipe(lingeringGazeTargets)
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(30.5-delay)
	timerLightSpectrumCD:Start(41-delay)
	timerDisintegrationBeamCD:Start(135-delay)
end

function mod:OnCombatEnd()
	if self.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(133765) then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif args:IsSpellID(138467) then
		warnLingeringGaze:Show()
		timerLingeringGazeCD:Start()
	elseif args:IsSpellID(134587) and self:AntiSpam(3, 3) then
		warnIceWall:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(133795) then
		warnLifeDrain:Show(args.destName)
		specWarmLifeDrain:Show(args.destName)
--[[Blizz disabled this from combat log in latest build, wtf? so now we HAVE to use emote for it
	elseif args:IsSpellID(136932) then--Force of Will Precast
		warnForceOfWill:Show(args.destName)
		if args:IsPlayer() then
			specWarnForceOfWill:Show()
			yellForceOfWill:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 11 then--Guessed range.
					specWarnForceOfWillNear:Show(args.destName)
				end
			end
		end--]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(133767) then
		timerSeriousWound:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 4 then
				specWarnSeriousWound:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(133767)) and not UnitIsDeadOrGhost("player") then
				specWarnSeriousWoundOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(133597) then--Dark Parasite
		warnDarkParasite:Show(args.destName)
		local _, _, _, _, _, duration, expires = UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration)
	elseif args:IsSpellID(133598) then--Dark Plague
		local _, _, _, _, _, duration, expires = UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration)
	elseif args:IsSpellID(134626) then
		lingeringGazeTargets[#lingeringGazeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnLingeringGaze:Show()
			yellLingeringGaze:Yell()
		end
		self:Unschedule(warnLingeringGazeTargets)
		if #lingeringGazeTargets >= 5 and self:IsDifficulty("normal25", "heroic25") or #lingeringGazeTargets >= 2 and self:IsDifficulty("normal10", "heroic10") then--TODO, add LFR number of targets
			warnLingeringGazeTargets()
		else
			self:Schedule(0.5, warnLingeringGazeTargets)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(133767) then
		timerSeriousWound:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 140502 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnEyeSore:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Blizz doesn't like combat log anymore
--Currently very bugged too so warnings aren't working right (since fight isn't working right)
--Beams wildly jump targets and don't give new target a warning at all nor does it even show in damn combat log.
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find("spell:136932") then--Force of Will
		warnForceOfWill:Show(target)
		if target == UnitName("player") then
			specWarnForceOfWill:Show()
			yellForceOfWill:Yell()
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 11 then--Guessed range.
					specWarnForceOfWillNear:Show(target)
				end
			end
		end
	elseif msg:find("spell:134122") then--Blue Rays
		timerForceOfWillCD:Cancel()
		warnBlueBeam:Show(target)
		if target == UnitName("player") then
			warnBlueBeam:Show()
		end
	elseif msg:find("spell:134123") then--Infrared Light (red)
		crimsonFogs = 3
		warnRedBeam:Show(target)
		if target == UnitName("player") then
			warnRedBeam:Show()
		end
	elseif msg:find("spell:134124") and self:IsDifficulty("heroic10", "heroic25", "lfr25") then--useful only on heroic and LFR since there are only amber adds in them. Normal 10 and normal 25 do not have amber adds (why LFR does is beyond me)
		warnYellowBeam:Show(target)
		if target == UnitName("player") then
			specWarnYellowBeam:Show()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69050 then--Crimson Fog
		crimsonFogs = crimsonFogs - 1
		if crimsonFogs >= 1 and not self:IsDifficulty("lfr25") then--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
			warnCrimsonLeft:Show(crimsonFogs)
		else--No adds left, force ability is re-enabled
			timerForceOfWillCD:Start()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 136316 and self:AntiSpam(2, 2) then--Disintegration Beam (clockwise)
		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_LEFT)
		timerDisintegrationBeam:Start()
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(90)
		end
		self:Schedule(60, BeamEnded)
	elseif spellId == 133775 and self:AntiSpam(2, 2) then--Disintegration Beam (counter-clockwise)
		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_RIGHT)
		timerDisintegrationBeam:Start()
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(270)
		end
		self:Schedule(60, BeamEnded)
	end
end
