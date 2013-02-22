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
local warnForceOfWill				= mod:NewSpellAnnounce(136932, 4)
local warnLingeringGaze				= mod:NewSpellAnnounce(138467, 3)--Seems highly variable Cd so no timer for this yet
local warnBlueBeam					= mod:NewTargetAnnounce(134122, 2)
local warnRedBeam					= mod:NewTargetAnnounce(134123, 2)
local warnYellowBeam				= mod:NewTargetAnnounce(134124, 2)
local warnCrimsonLeft				= mod:NewAddsLeftAnnounce("ej6892", 2, 134123)
local warnLifeDrain					= mod:NewTargetAnnounce(133795, 3, nil, mod:IsTank() or mod:IsHealer())
local warnDarkParasite				= mod:NewTargetAnnounce(133597, 3, nil, mod:IsHealer())--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, mod:IsTank(), 4)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTarget(133767, mod:IsTank())
local specWarnForceOfWill			= mod:NewSpecialWarningYou(136932, nil, nil, nil, 3)--VERY important, if you get hit by this you are out of fight for rest of pull.
local specWarnForceOfWillNear		= mod:NewSpecialWarningClose(136932)
local yellForceOfWill				= mod:NewYell(136932)
local specWarnLingeringGaze			= mod:NewSpecialWarningMove(134044)
local specWarnBlueBeam				= mod:NewSpecialWarningYou(134122)
local specWarnRedBeam				= mod:NewSpecialWarningYou(134123)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(134124)
local specWarnDisintegrationBeam	= mod:NewSpecialWarning("specWarnDisintegrationBeam", nil, nil, nil, true)
local specWarmLifeDrain				= mod:NewSpecialWarningTarget(133795, mod:IsTank())--Pretty much exhale all over again from zorlok. Tank intercepts beam to take damage instead

local timerHardStareCD				= mod:NewCDTimer(12, 133765, mod:IsTank() or mod:IsHealer())--10 second cd but delayed by everything else. Example variation, 12, 15, 9, 25, 31
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(25, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(60, 136932)
local timerLightSpectrumCD			= mod:NewCDTimer(60, "ej6891")--Don't know when 2nd one is cast.
local timerDarkParasite				= mod:NewTargetTimer(30, 136932, mod:IsHealer())--Only healer/dispeler needs to know this.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598)--EVERYONE needs to know this, if dispeler fucked up and dispelled parasite too early you're going to get a new add every 3 seconds for remaining duration of this bar.
local timerDisintegrationBeamCD		= mod:NewNextTimer(135, 133775)

local crimsonFogs = 3

mod:AddBoolOption("ArrowOnBeam", true)

function mod:OnCombatStart(delay)
	crimsonFogs = 3
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15-delay)
	timerForceOfWillCD:Start(30.5-delay)
	timerLightSpectrumCD:Start(42-delay)
	timerDisintegrationBeamCD:Start(-delay)
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
	if args:IsSpellID(136932) then--Force of Will Precast
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
		end
	elseif args:IsSpellID(133795) then
		warnLifeDrain:Show(args.destName)
		specWarmLifeDrain:Show(args.destName)
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
		specWarnLingeringGaze:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--Blizz doesn't like combat log anymore
--Currently very bugged too so warnings aren't working right (since fight isn't working right)
--Beams wildly jump targets and don't give new target a warning at all nor does it even show in damn combat log.
function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find("spell:134122") then--Blue Rays
		timerForceOfWillCD:Cancel()
		warnBlueBeam:Show(target)
		if target == UnitName("player") then
			warnBlueBeam:Show()
		end
	elseif msg:find("spell:134123") then--Infrared Light (red)
		warnRedBeam:Show(target)
		if target == UnitName("player") then
			warnRedBeam:Show()
		end
	elseif msg:find("spell:134124") and self:IsDifficulty("heroic10", "heroic25") then--useful only on heroic since there are only amber adds on heroic (therefor where we initially position the beam before it untethers is VERY important)
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
		if crimsonFogs >= 1 then
			warnCrimsonLeft:Show(crimsonFogs)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 136316 and self:AntiSpam(2, 2) then--Disintegration Beam (clockwise)
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_LEFT)
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(90)
		end
		print("Mod beyond this point is incomplete and most timers will be unavailable")
	elseif spellId == 133775 and self:AntiSpam(2, 2) then--Disintegration Beam (counter-clockwise)
		specWarnDisintegrationBeam:Show(spellName, DBM_CORE_RIGHT)
		if self.Options.ArrowOnBeam then
			DBM.Arrow:ShowStatic(270)
		end
		print("Mod beyond this point is incomplete and most timers will be unavailable")
	end
end
