local mod	= DBM:NewMod(2408, "DBM-Party-Shadowlands", 7, 1188)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166473)
mod:SetEncounterID(2395)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 323064 322736",
	"SPELL_CAST_SUCCESS 322746",
	"SPELL_AURA_APPLIED 322773 322746 328987",
	"SPELL_AURA_REMOVED 322773 322746",
	"SPELL_PERIODIC_DAMAGE 323569",
	"SPELL_PERIODIC_MISSED 323569"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, blood barrier probably has a CD before it goes back up
--Hakkar the Soulflayer
local warnBloodBarrier				= mod:NewTargetNoFilterAnnounce(322773, 2)
local warnBloodBarrierEnded			= mod:NewEndAnnounce(322773, 1)
local warnCorruptedBlood			= mod:NewTargetAnnounce(322746, 3)
--Son of Hakkar:
local warnZealous					= mod:NewTargetAnnounce(328987, 2)

--Hakkar the Soulflayer
local specWarnBloodBarrage			= mod:NewSpecialWarningInterrupt(323064, "HasInterrupt", nil, nil, 1, 2)
local specWarnCorruptedBlood		= mod:NewSpecialWarningMoveAway(322746, nil, nil, nil, 3, 2)
local yellCorruptedBlood			= mod:NewYell(322746)
local specWarnPiercingBarb			= mod:NewSpecialWarningDefensive(322736, "Tank", nil, nil, 1, 2)
--Son of Hakkar:
local specWarnGTFO					= mod:NewSpecialWarningGTFO(323569, nil, nil, nil, 1, 8)
local specWarnZealous				= mod:NewSpecialWarningRun(328987, nil, nil, nil, 4, 2)

--Hakkar the Soulflayer
local timerBloodBarrierCD			= mod:NewAITimer(15.8, 322773, nil, nil, nil, 6)
local timerBloodBarrageCD			= mod:NewAITimer(13, 323064, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)
local timerCorruptedBloodCD			= mod:NewAITimer(13, 322746, nil, nil, nil, 3)
local timerPiercingBarbCD			= mod:NewAITimer(13, 322736, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Son of Hakkar:

mod:AddRangeFrameOption(8, 322746)--Spell is 7, but can't do 7 in api
mod:AddNamePlateOption("NPAuraOnFixate", 328987)

mod.vb.barrierActive = false
--local debuffFilter
--[[
do
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not DBM:UnitDebuff(uId, 322746) then
			return true
		end
	end
end
--]]

function mod:OnCombatStart(delay)
	self.vb.barrierActive = false
	timerBloodBarrierCD:Start(1-delay)
	timerBloodBarrageCD:Start(1-delay)
	timerCorruptedBloodCD:Start(1-delay)
	timerPiercingBarbCD:Start(1-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 322736 then
		specWarnPiercingBarb:Show()
		specWarnPiercingBarb:Play("defensive")
		timerPiercingBarbCD:Start()
	elseif spellId == 323064 then
		timerBloodBarrageCD:Start()
		if not self.vb.barrierActive and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBloodBarrage:Show(args.sourceName)
			specWarnBloodBarrage:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 322746 then
		timerCorruptedBloodCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 322773 then
		self.vb.barrierActive = true
		timerBloodBarrierCD:Start()
		warnBloodBarrier:Show(args.destName)
	elseif spellId == 322746 then
		if args:IsPlayer() then
			specWarnCorruptedBlood:Show()
			specWarnCorruptedBlood:Play("runout")
			yellCorruptedBlood:Yell()
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Show(8, debuffFilter)--Show everyone
			--end
		else
			warnCorruptedBlood:CombinedShow(0.5, args.destName)
		end
	elseif spellId == 328987 then
		if args:IsPlayer() then
			specWarnZealous:Show()
			specWarnZealous:Play("justrun")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 20)
			end
		else
			warnZealous:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 322773 then
		self.vb.barrierActive = false
		warnBloodBarrierEnded:Show()
	elseif spellId == 328987 then
		if args:IsPlayer() then
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	--elseif spellId == 322746 then
	--	if args:IsPlayer() then
			--if self.Options.RangeFrame then
			--	DBM.RangeCheck:Show(8, debuffFilter)--Show only those with debuff
			--end
	--	end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 323569 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 165905 then--Son of Hakkar

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257453  then

	end
end
--]]
