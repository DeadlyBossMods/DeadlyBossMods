local mod	= DBM:NewMod(2116, "DBM-Party-BfA", 7, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(129232)
mod:SetEncounterID(2108)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 260189 262515 260190",
	"SPELL_AURA_REMOVED 260189 262515",
	"SPELL_AURA_REMOVED_DOSE 260189",
	"SPELL_CAST_START 260280 271456",
	"SPELL_CAST_SUCCESS 260813 271456 276212",
	"RAID_BOSS_WHISPER"
)

--TODO: Maybe general range 6 for Micro Missiles from BOOMBA?
--TODO, video this boss to track faster way to drill smash
local warnDrill						= mod:NewStackAnnounce(260189, 2)
local warnHomingMissile				= mod:NewTargetAnnounce(260811, 3)
local warnDrillSmashCast			= mod:NewCastAnnounce(271456, 2)
local warnDrillSmash				= mod:NewTargetNoFilterAnnounce(271456, 2)
local warnSummonBooma				= mod:NewSpellAnnounce(276212, 2)

--Stage One: Big Guns
local specWarnGatlingGun			= mod:NewSpecialWarningDodge(260280, nil, nil, nil, 3, 2)
local specWarnHomingMissile			= mod:NewSpecialWarningMoveAway(260811, nil, nil, nil, 1, 2)
local yellHomingMissile				= mod:NewYell(260811)
local specWarnHomingMissileNear		= mod:NewSpecialWarningClose(260811, nil, nil, nil, 1, 2)
--Stage Two: Drill
local specWarnDrillSmash			= mod:NewSpecialWarningMoveTo(271456, nil, nil, nil, 1, 2)
local yellDrillSmash				= mod:NewYell(271456)
local specWarnHeartseeker			= mod:NewSpecialWarningYou(262515, nil, nil, nil, 1, 2)
local specWarnHeartseekerOther		= mod:NewSpecialWarningTarget(262515, "Tank", nil, nil, 1, 2)
local yellHeartseeker				= mod:NewYell(262515)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--local timerReapSoulCD				= mod:NewAITimer(13, 194956, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
--Stage One: Big Guns
local timerGatlingGunCD				= mod:NewCDTimer(20.1, 260280, nil, nil, nil, 3)
local timerHomingMissileCD			= mod:NewCDTimer(22, 260811, nil, nil, nil, 3)
--Stage Two: Drill
local timerDrillSmashCD				= mod:NewCDTimer(8.4, 271456, nil, nil, nil, 3)--8.4--9.9
--local timerBigRedRocketCD			= mod:NewAITimer(13, 270282, nil, nil, nil, 3)

--mod:AddRangeFrameOption(6, 276234)

local bigRedRocket = DBM:GetSpellInfo(270282)

function mod:OnCombatStart(delay)
	timerHomingMissileCD:Start(4.9-delay)
	timerGatlingGunCD:Start(14.9-delay)
--	if self.Options.RangeFrame and not self:IsNormal() then
--		DBM.RangeCheck:Show(6)
--	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
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
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 260189 then
		local amount = args.amount or 0
		warnDrill:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_REMOVED = mod.SPELL_AURA_REMOVED_DOSE

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 260280 then
		specWarnGatlingGun:Show()
		specWarnGatlingGun:Play("shockwave")
		timerGatlingGunCD:Start()
	elseif spellId == 271456 then
		warnDrillSmashCast:Show()
		--TODO, target scan? Unit aura scan?
		timerDrillSmashCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 260813 then
		timerHomingMissileCD:Start()
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
	elseif spellId == 271456 and self:AntiSpam(6, args.destName) then--Backup, should only trigger if OnTranscriptorSync didn't run
		if args:IsPlayer() then
			specWarnDrillSmash:Show(bigRedRocket)
			specWarnDrillSmash:Play("targetyou")
			yellDrillSmash:Yell()
		else
			warnDrillSmash:Show(args.destName)
		end
	elseif spellId == 276212 then
		warnSummonBooma:Show()
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("260838") then
		specWarnDrillSmash:Show(bigRedRocket)
		specWarnDrillSmash:Play("targetyou")
		yellDrillSmash:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("260838") then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(6, targetName) then
			warnDrillSmash:Show(targetName)
		end
	end
end


--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
