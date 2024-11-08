local mod	= DBM:NewMod("NerubarPalaceTrash", "DBM-Raids-WarWithin", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true
mod:SetZone(2657)

mod:RegisterEvents(
	"SPELL_CAST_START 439873 459952 463104 441747 443138 436679 440184 441097 463176",
	"SPELL_AURA_APPLIED 445553 436784",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"GOSSIP_SHOW"
)

--TODO, add https://www.wowhead.com/spell=446760/slobbering-grasp in some capacity?
--local warnShadowflameBomb					= mod:NewTargetAnnounce(425300, 3)

local specWarnStagFlip						= mod:NewSpecialWarningDefensive(463176, nil, nil, nil, 3, 2)
local specWarnFixate						= mod:NewSpecialWarningYou(445553, nil, nil, nil, 1, 2)
local specWarnImpale						= mod:NewSpecialWarningDodge(459952, nil, nil, nil, 2, 15)
local specWarnBlackCleave					= mod:NewSpecialWarningDodge(440184, nil, nil, nil, 2, 15)
local specWarnHeavingRetch					= mod:NewSpecialWarningDodge(441097, nil, nil, nil, 2, 15)
local specwarnInfestingSwarm				= mod:NewSpecialWarningMoveAway(436784, nil, nil, nil, 1, 2)
local yellInfestingSwarm					= mod:NewYell(436784)
--local yellShadowflameBombFades			= mod:NewShortFadesYell(425300)
local specWarnDeafeningRoar					= mod:NewSpecialWarningCast(436679, "SpellCaster", nil, nil, 1, 2)
local specWarnPsychicScream					= mod:NewSpecialWarningInterrupt(439873, "HasInterrupt", nil, nil, 1, 2)
local specWarnVoidBoltVolley				= mod:NewSpecialWarningInterrupt(463104, "HasInterrupt", nil, nil, 1, 2)--No real cd, even when kicked, just spammed
local specWarnDarkMending					= mod:NewSpecialWarningInterrupt(441747, "HasInterrupt", nil, nil, 1, 2)--CD possibly 14-15 seconds, but not confirmed
local specWarnEnshroudingPulse				= mod:NewSpecialWarningInterrupt(443138, "HasInterrupt", nil, nil, 1, 2)

local timerImpaleCD							= mod:NewCDNPTimer(17, 459952, nil, nil, nil, 3)--17-20

mod:AddGossipOption(true, "Buff")

--local playerName = UnitName("player")

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 439873 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnPsychicScream:Show(args.sourceName)
		specWarnPsychicScream:Play("kickcast")
	elseif spellId == 459952 then
		if self:AntiSpam(3, 2) then
			specWarnImpale:Show()
			specWarnImpale:Play("frontal")
		end
		timerImpaleCD:Start(nil, args.sourceGUID)
	elseif spellId == 440184 then
		if self:AntiSpam(3, 2) then
			specWarnBlackCleave:Show()
			specWarnBlackCleave:Play("frontal")
		end
	elseif spellId == 441097 then
		if self:AntiSpam(3, 2) then
			specWarnHeavingRetch:Show()
			specWarnHeavingRetch:Play("frontal")
		end
	elseif spellId == 463104 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnVoidBoltVolley:Show(args.sourceName)
		specWarnVoidBoltVolley:Play("kickcast")
	elseif spellId == 441747 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDarkMending:Show(args.sourceName)
		specWarnDarkMending:Play("kickcast")
	elseif spellId == 443138 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEnshroudingPulse:Show(args.sourceName)
		specWarnEnshroudingPulse:Play("kickcast")
	elseif spellId == 436679 then
		specWarnDeafeningRoar:Show()
		specWarnDeafeningRoar:Play("stopcast")
	elseif spellId == 463176 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnStagFlip:Show()
			specWarnStagFlip:Play("carefly")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 445553 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnFixate:Show()
		specWarnFixate:Play("targetyou")
	elseif spellId == 436784 then
		if args:IsPlayer() then
			specwarnInfestingSwarm:Show()
			specwarnInfestingSwarm:Play("scatter")
			yellInfestingSwarm:Yell()
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 428765 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 222305 then--Palace Guardian
		timerImpaleCD:Stop(args.destGUID)
	end
end

function mod:GOSSIP_SHOW()
	local gossipOptionID = self:GetGossipID()
	if gossipOptionID then
		if self.Options.AutoGossipBuff and gossipOptionID == 123878 then--Potion at entrance
			self:SelectGossip(gossipOptionID)
		end
	end
end
