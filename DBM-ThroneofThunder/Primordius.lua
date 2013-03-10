local mod	= DBM:NewMod(820, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(69017)--69070 Viscous Horror, 69069 good ooze, 70579 bad ooze
mod:SetModelID(47009)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_TARGETICONS",
	"UNIT_TARGET",
	"UPDATE_MOUSEOVER_UNIT"
)

local warnMalformedBlood			= mod:NewStackAnnounce(136050, 2, nil, mod:IsTank() or mod:IsHealer())--No cd bars for this because it's HIGHLY variable (lowest priority spell so varies wildly depending on bosses 3 buffs)
local warnPrimordialStrike			= mod:NewSpellAnnounce(136037, 3, nil, mod:IsTank() or mod:IsHealer())
local warnGasBladder				= mod:NewTargetAnnounce(136215, 4)--Stack up in front for (but not too close or cleave will get you)
local warnCausticGas				= mod:NewCastAnnounce(136216, 3)
local warnEruptingPustules			= mod:NewTargetAnnounce(136246, 4)
local warnPustuleEruption			= mod:NewSpellAnnounce(136247, 3, nil, false)--Spammy
local warnPathogenGlands			= mod:NewTargetAnnounce(136225, 3)
local warnVolatilePathogen			= mod:NewTargetAnnounce(136228, 4)
local warnMetabolicBoost			= mod:NewTargetAnnounce(136245, 3)--Makes Malformed Blood, Primordial Strike and melee 50% more often
local warnVentralSacs				= mod:NewTargetAnnounce(136210, 2)--This one is a joke, if you get it, be happy.
local warnAcidicSpines				= mod:NewTargetAnnounce(136218, 3)
local warnBlackBlood				= mod:NewStackAnnounce(137000, 2, nil, mod:IsTank() or mod:IsHealer())

local specWarnFullyMutated			= mod:NewSpecialWarningYou(140546)
local specWarnCausticGas			= mod:NewSpecialWarningSpell(136216, nil, nil, nil, 2)--All must be in front for this.
local specWarnPustuleEruption		= mod:NewSpecialWarningSpell(136247, false, nil, nil, 2)--off by default since every 5 sec, very spammy for special warning
local specWarnVolatilePathogen		= mod:NewSpecialWarningYou(136228)
local specWarnViscousHorror			= mod:NewSpecialWarningSwitch("ej6969", mod:IsTank())

local timerMalformedBlood			= mod:NewTargetTimer(60, 136050, nil, mod:IsTank() or mod:IsHealer())
local timerPrimordialStrikeCD		= mod:NewCDTimer(24, 136037)
local timerCausticGasCD				= mod:NewCDTimer(14, 136216)
local timerPustuleEruptionCD		= mod:NewCDTimer(5, 136247, nil, false)
local timerVolatilePathogenCD		= mod:NewCDTimer(28, 136228)--Too cute blizzard, too cute. (those who get the 28 reference for pathogen get an A+)
local timerBlackBlood				= mod:NewTargetTimer(60, 137000, nil, mod:IsTank() or mod:IsHealer())
local timerViscousHorrorCD			= mod:NewNextTimer(30, "ej6969", nil, nil, nil, 137000)

local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddBoolOption("RangeFrame", true)--Right now, EVERYTHING targets melee. If blizz listens to feedback, it may change to just ranged.
mod:AddBoolOption("SetIconOnBadOoze", true)

local metabolicBoost = false
local acidSpinesActive = false--Spread of 5 yards
local postulesActive = false
local oozeGUIDS = {}
local oozeIcon = 8

function mod:BigOoze()
	specWarnViscousHorror:Show()
	timerViscousHorrorCD:Start()
	self:ScheduleMethod(30, "BigOoze")
end

function mod:OnCombatStart(delay)
	table.wipe(oozeGUIDS)
	metabolicBoost = false
	acidSpinesActive = false
	postulesActive = false
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerViscousHorrorCD:Start(12-delay)
		self:ScheduleMethod(12-delay, "BigOoze")
	end
end

function mod:OnCombatEnd()
	table.wipe(oozeGUIDS)--Table may get large, so lets wipe it on kill/wipe too to clear memory
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(136216) then
		warnCausticGas:Show()
		specWarnCausticGas:Show()
		timerCausticGasCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(136037) then
		warnPrimordialStrike:Show()
		if metabolicBoost then--Only issue is updating current bar when he gains buff in between CDs, it does seem to affect it to a degree
			timerPrimordialStrikeCD:Start(20)
		else
			timerPrimordialStrikeCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136050) then
		warnMalformedBlood:Show(args.destName, args.amount or 1)
		timerMalformedBlood:Start(args.destName)
	elseif args:IsSpellID(137000) then
		warnBlackBlood:Show(args.destName, args.amount or 1)
		timerBlackBlood:Start(args.destName)
	elseif args:IsSpellID(136215) then
		warnGasBladder:Show(args.destName)
	elseif args:IsSpellID(136246) then
		postulesActive = true
		warnEruptingPustules:Show(args.destName)
		timerPustuleEruptionCD:Start()--not affected by metabolicBoost?
		if self.Options.RangeFrame and not acidSpinesActive then--Check if acidSpinesActive is active, if they are, we should already have range 5 up
			DBM.RangeCheck:Show(2)
		end
	elseif args:IsSpellID(136225) then
		warnPathogenGlands:Show(args.destName)
	elseif args:IsSpellID(136228) then
		warnVolatilePathogen:Show(args.destName)
		timerVolatilePathogenCD:Start()
		if args:IsPlayer() then
			specWarnVolatilePathogen:Show()
		end
	elseif args:IsSpellID(136245) then
		metabolicBoost = true
		warnMetabolicBoost:Show(args.destName)
	elseif args:IsSpellID(136210) then
		warnVentralSacs:Show(args.destName)
	elseif args:IsSpellID(136218) then
		acidSpinesActive = true
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	elseif args:IsSpellID(140546) and args:IsPlayer() then
		specWarnFullyMutated:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(136050) then
		timerMalformedBlood:Cancel(args.destName)
	elseif args:IsSpellID(136215) then
		timerCausticGasCD:Cancel()
	elseif args:IsSpellID(136246) then
		postulesActive = false
		timerPustuleEruptionCD:Cancel()
		if self.Options.RangeFrame and not acidSpinesActive then--Check if acidSpinesActive is active, if they are, leave range frame alone
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(136225) then
		timerVolatilePathogenCD:Cancel()
	elseif args:IsSpellID(136245) then
		metabolicBoost = false
	elseif args:IsSpellID(136218) then
		acidSpinesActive = false
		if self.Options.RangeFrame then
			if postulesActive then
				DBM.RangeCheck:Show(2)
			else
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 136248 and self:AntiSpam(2, 1) then--Pustule Eruption
		warnPustuleEruption:Show()
		specWarnPustuleEruption:Show()
		timerPustuleEruptionCD:Start()
	elseif spellId == 136050 and self:AntiSpam(2, 2) then--Malformed Blood
		
	end
end

--This function will have issues with people running old version of mod spamming icon 3.
function mod:CHAT_MSG_TARGETICONS(msg)
	--TARGET_ICON_SET = "|Hplayer:%s|h[%s]|h sets |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t on %s.";
	local icon = tonumber(string.sub(string.match(msg, "RaidTargetingIcon_%d"), -1))
	if icon then
		oozeIcon = icon - 1--Try to sync up to what others oozeIcon are at to do our best job to keep all mods on same page
	end
end

function mod:TrySetTarget()
	for i = 1, DBM:GetNumGroupMembers() do
		local guid = UnitGUID("raid"..i.."target")
		local cid = self:GetCIDFromGUID(guid)
		if cid == 70579 and not oozeGUIDS[guid] then
			SetRaidTarget("raid"..i.."target", oozeIcon)
			oozeGUIDS[guid] = true
			self:SendSync("iconSet", guid)
			oozeIcon = oozeIcon - 1
			if oozeIcon == 0 then oozeIcon = 8 end
		end
	end
end

function mod:UNIT_TARGET()
	local cid = self:GetCIDFromGUID(UnitGUID("target"))
	if DBM:GetRaidRank() >= 1 and self.Options.SetIconOnBadOoze and (cid == 70579 or cid == 69069) then--Because not everyone has assist, lets just fire a check of all raid targets if EITHER ooze ID is up and targeted to see if someone else is targeting the bad one
		self:TrySetTarget()
	end
end

function mod:UPDATE_MOUSEOVER_UNIT()
	local guid = UnitGUID("mouseover")
	local cid = self:GetCIDFromGUID(guid)
	if DBM:GetRaidRank() >= 1 and self.Options.SetIconOnBadOoze and cid == 70579 and not oozeGUIDS[guid] then--Because not everyone has assist, lets just fire a check of all raid targets if EITHER ooze ID is up and targeted to see if someone else is targeting the bad one
		SetRaidTarget("mouseover", oozeIcon)
		oozeGUIDS[guid] = true
		self:SendSync("iconSet", guid)
		oozeIcon = oozeIcon - 1
		if oozeIcon == 0 then oozeIcon = 8 end
	end
end

function mod:OnSync(msg, guid)
	if msg == "iconSet" and guid then
		oozeGUIDS[guid] = true--Again, try to avoid setting icons on mobs others already set icons on by adding it to our ignore list through sync
	end
end
