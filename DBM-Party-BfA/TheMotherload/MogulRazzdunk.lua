local mod	= DBM:NewMod(2116, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(129232)
mod:SetEncounterID(2108)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260189 262515 260190 260829",
	"SPELL_AURA_REMOVED 260189 262515",
	"SPELL_AURA_REMOVED_DOSE 260189",
	"SPELL_CAST_START 260280 271456",
	"SPELL_CAST_SUCCESS 260813 271456 276212"
)

--TODO: Maybe general range 6 for Micro Missiles from BOOMBA?
local warnDrill						= mod:NewStackAnnounce(260189, 2)
local warnHomingMissile				= mod:NewTargetAnnounce(260811, 3)
--local warnDrillSmashCast			= mod:NewCastAnnounce(271456, 2)
local warnDrillSmash				= mod:NewTargetNoFilterAnnounce(271456, 2)
local warnSummonBooma				= mod:NewSpellAnnounce(276212, 2)

--Stage One: Big Guns
local specWarnGatlingGun			= mod:NewSpecialWarningDodge(260280, nil, nil, nil, 3, 8)
local specWarnHomingMissile			= mod:NewSpecialWarningMoveAway(260811, nil, nil, nil, 1, 2)
local yellHomingMissile				= mod:NewYell(260811)
local specWarnHomingMissileNear		= mod:NewSpecialWarningClose(260811, nil, nil, nil, 1, 2)
--Stage Two: Drill
local specWarnDrillSmash			= mod:NewSpecialWarningMoveTo(271456, nil, nil, nil, 1, 2)
local yellDrillSmash				= mod:NewYell(271456)
local specWarnHeartseeker			= mod:NewSpecialWarningYou(262515, nil, nil, nil, 1, 2)
local specWarnHeartseekerOther		= mod:NewSpecialWarningTarget(262515, "Tank", nil, nil, 1, 2)
local yellHeartseeker				= mod:NewYell(262515)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)

--Stage One: Big Guns
local timerGatlingGunCD				= mod:NewCDTimer(20.1, 260280, nil, nil, nil, 3)
local timerHomingMissileCD			= mod:NewCDTimer(22, 260811, nil, nil, nil, 3)
--Stage Two: Drill
local timerDrillSmashCD				= mod:NewCDTimer(8.4, 271456, nil, nil, nil, 3)--8.4--9.9

local bigRedRocket = DBM:GetSpellInfo(270282)

function mod:DrillTarget(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(4, targetname) then--Antispam to lock out redundant later warning from firing if this one succeeds
		if targetname == UnitName("player") then
			specWarnDrillSmash:Show()
			specWarnDrillSmash:Play("targetyou")
			yellDrillSmash:Yell()
		else
			warnDrillSmash:Show(targetname)
		end
	end
end

function mod:OnCombatStart(delay)
	timerHomingMissileCD:Start(4.9-delay)
	timerGatlingGunCD:Start(14.9-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 260189 then--Configuration: Drill
		timerGatlingGunCD:Stop()
		timerHomingMissileCD:Stop()
		timerDrillSmashCD:Start(22.4)
	elseif spellId == 260190 then--Configuration: Combat
		timerDrillSmashCD:Stop()
		timerHomingMissileCD:Start(7)
		timerGatlingGunCD:Start(17)
	elseif spellId == 262515 then
		if args:IsPlayer() then
			specWarnHeartseeker:Show()
			specWarnHeartseeker:Play("targetyou")
			yellHeartseeker:Yell()
		else
			specWarnHeartseekerOther:Show(args.destName)
			specWarnHeartseekerOther:Play("gathershare")
		end
	elseif spellId == 260829 then
		if args:IsPlayer() then
			specWarnHomingMissile:Show()
			specWarnHomingMissile:Play("runout")
			yellHomingMissile:Yell()
		elseif self:CheckNearby(20, args.destName) then
			specWarnHomingMissileNear:Show(args.destName)
			specWarnHomingMissileNear:Play("watchstep")
		else
			warnHomingMissile:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 260189 then
		local amount = args.amount or 0
		warnDrill:Cancel()
		warnDrill:Schedule(0.5, args.destName, amount)
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_REMOVED_DOSE

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260280 then
		specWarnGatlingGun:Show()
		specWarnGatlingGun:Play("behindboss")
		specWarnGatlingGun:ScheduleVoice(1.5, "keepmove")
		timerGatlingGunCD:Start()
	elseif spellId == 271456 then
		self:ScheduleMethod(0.5, "BossTargetScanner", args.sourceGUID, "DrillTarget", 0.1, 12, true)
		timerDrillSmashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260813 then
		timerHomingMissileCD:Start()
	elseif spellId == 271456 and self:AntiSpam(6, args.destName) then--Backup, should only trigger if targetscan failed
		warnDrillSmash:Show(args.destName)
	elseif spellId == 276212 then
		warnSummonBooma:Show()
	end
end
