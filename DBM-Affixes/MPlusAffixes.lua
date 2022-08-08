local mod	= DBM:NewMod("MPlusAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2441, 2097, 1651, 1208, 1195)--All of the S4 SL M+ Dungeons

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 373513 240446 373513 373429 373370",
	"SPELL_AURA_APPLIED 240447 226512 373552 373509",
	"SPELL_AURA_APPLIED_DOSE 373509",
	"SPELL_AURA_REMOVED 373724",
	"SPELL_DAMAGE 209862",
	"SPELL_MISSED 209862",
	"UNIT_DIED"
)

--TODO, fine tune tank stacks/throttle?
--[[
(ability.id = 373552 or ability.id = 373724) and type = "cast" or (ability.id = 373513 or ability.id = 373370 or ability.id = 373429) and type = "begincast"
--]]
local warnExplosion							= mod:NewCastAnnounce(240446, 4)
local warnNightmareCloud					= mod:NewCastAnnounce(373370, 4)--S4
local warnHypnosisBat						= mod:NewTargetNoFilterAnnounce(373552, 3)--S4
local warnBloodBarrier						= mod:NewTargetNoFilterAnnounce(373552, 4)--S4
local warnShadowClaws						= mod:NewStackAnnounce(373509, 2, nil, "Tank|Healer")--S4

local specWarnQuake							= mod:NewSpecialWarningMoveAway(240447, nil, nil, nil, 1, 2)
--local yellSharedAgony						= mod:NewYell(327401)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)--Volcanic and Sanguine
local specWarnCarrionSwarm					= mod:NewSpecialWarningDodge(373429, nil, nil, nil, 2, 2)--S4
local specWarnShadowEruption				= mod:NewSpecialWarningDodge(373513, nil, nil, nil, 2, 2)--S4
local specWarnBloodSiphon					= mod:NewSpecialWarningInterrupt(373729, nil, nil, nil, 1, 2)--S4

local timerCarrionSwarmCD					= mod:NewCDTimer(23, 373429, nil, nil, nil, 3)--S4, 23-27
local timerNightmareCloudCD					= mod:NewCDTimer(32.5, 373370, nil, nil, nil, 3)--S4, 32-36
local timerHypnosisBatCD					= mod:NewCDTimer(23, 373552, nil, nil, nil, 3)--S4, 23-27
local timerShadowEruptionCD					= mod:NewCDTimer(24, 373729, nil, nil, nil, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 gtfo

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 373429 then
		if self:AntiSpam(3, 2) then
			specWarnCarrionSwarm:Show()
			specWarnCarrionSwarm:Play("shockwave")
		end
		timerCarrionSwarmCD:Start()
	elseif spellId == 373513 then
		if self:AntiSpam(3, 2) then
			specWarnShadowEruption:Show()
			specWarnShadowEruption:Play("watchstep")
		end
		timerShadowEruptionCD:Start()
	elseif spellId == 240446 and self:AntiSpam(3, 6) then
		warnExplosion:Show()
	elseif spellId == 373370 then
		warnNightmareCloud:Show()
		timerNightmareCloudCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240447 then
		if args:IsPlayer() then
			specWarnQuake:Show()
			specWarnQuake:Play("range5")
		end
	elseif spellId == 226512 and args:IsPlayer() and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 373552 then
		warnHypnosisBat:Show(args.destName)
		timerHypnosisBatCD:Start()
	elseif spellId == 373724 then
		warnBloodBarrier:Show(args.destName)
	elseif spellId == 373509 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 and self:AntiSpam(5, 5) then
				warnShadowClaws:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 373724 and self:CheckInterruptFilter(args.destGUID, false, true) then
		specWarnBloodSiphon:Show(args.destName)
		specWarnBloodSiphon:Play("kickcast")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 190128 then--Zul'gamux
		timerHypnosisBatCD:Stop()
		timerShadowEruptionCD:Stop()
	elseif cid == 189878 then--Nathrezim Infiltrator
		timerCarrionSwarmCD:Stop()
		timerNightmareCloudCD:Stop()
	end
end
