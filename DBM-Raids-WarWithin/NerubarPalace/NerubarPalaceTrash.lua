local mod	= DBM:NewMod("NerubarPalaceTrash", "DBM-Raids-WarWithin", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod.isTrashMod = true
mod:SetZone(2657)
mod:RegisterZoneCombat(2657)

mod:RegisterEvents(
	"SPELL_CAST_START 439873 459952 463104 441747 443138 436679 440184 441097 463176 444000 454831 439012 448269",
	"SPELL_AURA_APPLIED 445553 436784",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"GOSSIP_SHOW"
)

--TODO, add https://www.wowhead.com/spell=446760/slobbering-grasp in some capacity?
--TODO, add https://www.wowhead.com/spell=436698/ravaging-spikes (which also has a 20.6 second CD)
--local warnShadowflameBomb					= mod:NewTargetAnnounce(425300, 3)

local specWarnStagFlip						= mod:NewSpecialWarningDefensive(463176, nil, nil, nil, 3, 2)
local specWarnFixate						= mod:NewSpecialWarningYou(445553, nil, nil, nil, 1, 2)
local specWarnGossemerWeave					= mod:NewSpecialWarningDodge(444000, nil, nil, nil, 2, 15)
local specWarnImpale						= mod:NewSpecialWarningDodge(459952, nil, nil, nil, 2, 15)
local specWarnBlackCleave					= mod:NewSpecialWarningDodge(440184, nil, nil, nil, 2, 15)
local specWarnHeavingRetch					= mod:NewSpecialWarningDodge(441097, nil, nil, nil, 2, 15)
local specWarnPoisonBreath					= mod:NewSpecialWarningDodge(454831, nil, nil, nil, 2, 15)
local specWarnToxicBlast					= mod:NewSpecialWarningDodge(439012, nil, nil, nil, 2, 15)
local specWarnBorrowingCharge				= mod:NewSpecialWarningDodge(448269, nil, nil, nil, 2, 2)
local specwarnInfestingSwarm				= mod:NewSpecialWarningMoveAway(436784, nil, nil, nil, 1, 2)
local yellInfestingSwarm					= mod:NewYell(436784)
--local yellShadowflameBombFades			= mod:NewShortFadesYell(425300)
local specWarnDeafeningRoar					= mod:NewSpecialWarningCast(436679, "SpellCaster", nil, nil, 1, 2)
local specWarnPsychicScream					= mod:NewSpecialWarningInterrupt(439873, "HasInterrupt", nil, nil, 1, 2)
local specWarnVoidBoltVolley				= mod:NewSpecialWarningInterrupt(463104, "HasInterrupt", nil, nil, 1, 2)--No real cd, even when kicked, just spammed
local specWarnDarkMending					= mod:NewSpecialWarningInterrupt(441747, "HasInterrupt", nil, nil, 1, 2)--CD possibly 14-15 seconds, but not confirmed
local specWarnEnshroudingPulse				= mod:NewSpecialWarningInterrupt(443138, "HasInterrupt", nil, nil, 1, 2)

local timerGossemereWeaveCD					= mod:NewCDNPTimer(17, 444000, nil, nil, nil, 3)
local timerImpaleCD							= mod:NewCDNPTimer(17, 459952, nil, nil, nil, 3)--17-20
local timerStagFlipCD						= mod:NewCDNPTimer(17, 463176, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDarkMendingCD					= mod:NewCDNPTimer(15.3, 441747, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerPoisonBreathCD					= mod:NewCDNPTimer(13.4, 454831, nil, nil, nil, 3)
local timerDeafeningRoarCD					= mod:NewCDNPTimer(20.6, 436679, nil, nil, nil, 2)
local timerBlackCleaveCD					= mod:NewCDNPTimer(16.2, 440184, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

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
		timerBlackCleaveCD:Start(nil, args.sourceGUID)
		if self:AntiSpam(3, 2) then
			specWarnBlackCleave:Show()
			specWarnBlackCleave:Play("frontal")
		end
	elseif spellId == 441097 then
		if self:AntiSpam(3, 2) then
			specWarnHeavingRetch:Show()
			specWarnHeavingRetch:Play("frontal")
		end
	elseif spellId == 444000 then
		timerGossemereWeaveCD:Start(nil, args.sourceGUID)
		if self:AntiSpam(3, 2) then
			specWarnGossemerWeave:Show()
			specWarnGossemerWeave:Play("frontal")
		end
	elseif spellId == 463104 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnVoidBoltVolley:Show(args.sourceName)
		specWarnVoidBoltVolley:Play("kickcast")
	elseif spellId == 441747 then
		timerDarkMendingCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDarkMending:Show(args.sourceName)
			specWarnDarkMending:Play("kickcast")
		end
	elseif spellId == 443138 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEnshroudingPulse:Show(args.sourceName)
		specWarnEnshroudingPulse:Play("kickcast")
	elseif spellId == 436679 then
		timerDeafeningRoarCD:Start(nil, args.sourceGUID)
		specWarnDeafeningRoar:Show()
		specWarnDeafeningRoar:Play("stopcast")
	elseif spellId == 463176 then
		timerStagFlipCD:Start(nil, args.sourceGUID)
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnStagFlip:Show()
			specWarnStagFlip:Play("carefly")
		end
	elseif spellId == 454831 then
		timerPoisonBreathCD:Start(nil, args.sourceGUID)
		if self:AntiSpam(3, 2) then
			specWarnPoisonBreath:Show()
			specWarnPoisonBreath:Play("frontal")
		end
	elseif spellId == 439012 then
		if self:AntiSpam(3, 2) then
			specWarnToxicBlast:Show()
			specWarnToxicBlast:Play("frontal")
		end
	elseif spellId == 448269 then
		if self:AntiSpam(3, 2) then
			specWarnBorrowingCharge:Show()
			specWarnBorrowingCharge:Play("chargemove")
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
	elseif cid == 222145 then--Voracious Stagshell
		timerStagFlipCD:Stop(args.destGUID)
	elseif cid == 218320 then--Web Acolyte
		timerDarkMendingCD:Stop(args.destGUID)
	elseif cid == 218317 then--Woven Threadmancer
		timerGossemereWeaveCD:Stop(args.destGUID)
	elseif cid == 229918 then--Caustic Skyrazor
		timerPoisonBreathCD:Stop(args.destGUID)
	elseif cid == 218306 then--Scarab Captain Vul'akan
		timerDeafeningRoarCD:Stop(args.destGUID)
	elseif cid == 219725 then--Chitin Knight
		timerBlackCleaveCD:Stop(args.destGUID)
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

--All timers subject to a ~0.5 second clipping due to ScanEngagedUnits
function mod:StartEngageTimers(guid, cid)
	if cid == 222305 then
		timerImpaleCD:Start(12.3, guid)
	elseif cid == 222145 then
		timerStagFlipCD:Start(2.8, guid)
	elseif cid == 218320 then
		timerDarkMendingCD:Start(3.3, guid)
--	elseif cid == 218317 then
--		timerGossemereWeaveCD:Start(17, guid)--Cast instantly on engage
	elseif cid == 229918 then
		timerPoisonBreathCD:Start(4, guid)
	elseif cid == 218306 then
		timerDeafeningRoarCD:Start(10, guid)
	end
end

--Abort timers when all players out of combat, so NP timers clear on a wipe
--Caveat, it won't calls top with GUIDs, so while it might terminate bar objects, it may leave lingering nameplate icons
function mod:LeavingZoneCombat()
	self:Stop()
end
