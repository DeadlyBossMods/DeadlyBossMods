local mod	= DBM:NewMod(2353, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152364)
mod:SetEncounterID(2305)
mod:SetZone()
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 296546 296459 296894 302465 295916 296701",
	"SPELL_CAST_SUCCESS 296737",
	"SPELL_AURA_APPLIED 296566 296737",
	"SPELL_AURA_REMOVED 296737",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify correct unshackled power spellid for LFR or mythic
local warnArcanadoBurst					= mod:NewSpellAnnounce(296430, 2)
local warnSquallTrap					= mod:NewSpellAnnounce(296459, 4)
local warnArcaneBomb					= mod:NewTargetNoFilterAnnounce(296737, 4)

--Rising Fury
local specWarnTideFistCast				= mod:NewSpecialWarningDefensive(296566, nil, nil, nil, 1, 2)
local specWarnTideFist					= mod:NewSpecialWarningTaunt(296566, nil, nil, nil, 1, 2)
local specWarnArcaneBomb				= mod:NewSpecialWarningMoveAway(296737, nil, nil, nil, 1, 2)
local yellArcaneBomb					= mod:NewPosYell(296737)
local yellArcaneBombFades				= mod:NewIconFadesYell(296737)
local specWarnUnshackledPower			= mod:NewSpecialWarningCount(296894, nil, nil, nil, 2, 2)
--Raging Storm
local specWarnAncientTempest			= mod:NewSpecialWarningSpell(295916, nil, nil, nil, 2, 2)
local specWarnGaleBuffet				= mod:NewSpecialWarningSpell(296701, nil, nil, nil, 2, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--Rising Fury
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20076))
local timerTideFistCD					= mod:NewNextCountTimer(58.2, 296546, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerArcanadoBurstCD				= mod:NewNextCountTimer(58.2, 296430, nil, nil, nil, 3)
local timerArcaneBombCD					= mod:NewNextCountTimer(58.2, 296737, nil, "-Tank", nil, 3, nil, nil, nil, 3, 4)
local timerUnshacklingPowerCD			= mod:NewNextCountTimer(58.2, 296894, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON, nil, 1, 4)
local timerAncientTempestCD				= mod:NewNextTimer(95.9, 152364, nil, nil, nil, 6)
--Raging Storm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20078))
local timerGaleBuffetCD					= mod:NewCDTimer(23.1, 296701, nil, nil, nil, 2)

--local berserkTimer					= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
--mod:AddInfoFrameOption(275270, true)
mod:AddSetIconOption("SetIconOnArcaneBomb", 296737, true, false, {1, 2})

mod.vb.unshackledCount = 0
mod.vb.arcanadoCount = 0
mod.vb.tideFistCount = 0
mod.vb.arcaneBombCount = 0
mod.vb.arcaneBombicon = 1
mod.vb.tempestStage = false
local arcanadoTimers = {6.0, 12.0, 13.1, 10.9, 17.1, 6.9, 12.0}
local tideFistTimers = {17.0, 20.0, 22.1, 17.9}
local unshackledPowerTimers = {10.0, 18.0, 9.1, 17.0, 18.0}
local arcaneBombTimers = {7.0, 20.0, 20.0, 20.0, 26.2}

function mod:OnCombatStart(delay)
	self.vb.unshackledCount = 0
	self.vb.arcanadoCount = 0
	self.vb.tideFistCount = 0
	self.vb.arcaneBombCount = 0
	self.vb.arcaneBombicon = 1
	self.vb.tempestStage = false
	timerArcanadoBurstCD:Start(6-delay, 1)
	timerArcaneBombCD:Start(7-delay, 1)
	timerUnshacklingPowerCD:Start(10-delay, 1)
	timerTideFistCD:Start(15-delay, 1)
	timerAncientTempestCD:Start(95.8)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 296546 then
		self.vb.tideFistCount = self.vb.tideFistCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnTideFistCast:Show()
			specWarnTideFistCast:Play("defensive")
		end
		local timer = tideFistTimers[self.vb.tideFistCount+1]
		if timer then
			timerTideFistCD:Start(timer, self.vb.tideFistCount+1)
		end
	elseif spellId == 296459 then
		warnSquallTrap:Show()
	elseif spellId == 296894 or spellId == 302465 then--296894 verified, 302465 unknown (maybe lfr or mythic)
		self.vb.unshackledCount = self.vb.unshackledCount + 1
		specWarnUnshackledPower:Show(self.vb.unshackledCount)
		specWarnUnshackledPower:Play("aesoon")
		local timer = unshackledPowerTimers[self.vb.unshackledCount+1]
		if timer then
			timerUnshacklingPowerCD:Start(timer, self.vb.unshackledCount+1)
		end
	elseif spellId == 295916 then--Ancient Tempest (phase change)
		self.vb.tempestStage = true
		self.vb.arcaneBombCount = 0
		timerTideFistCD:Stop()
		timerArcanadoBurstCD:Stop()
		timerArcaneBombCD:Stop()
		timerUnshacklingPowerCD:Stop()
		specWarnAncientTempest:Show()
		specWarnAncientTempest:Play("phasechange")
		timerArcaneBombCD:Start(17.1, 1)
		timerGaleBuffetCD:Start(22)
	elseif spellId == 296701 then
		specWarnGaleBuffet:Show()
		specWarnGaleBuffet:Play("carefly")
		timerGaleBuffetCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 296737 and self:AntiSpam(5, 1) then
		self.vb.arcaneBombicon = 1
		self.vb.arcaneBombCount = self.vb.arcaneBombCount + 1
		local timer = self.vb.tempestStage and 20 or arcaneBombTimers[self.vb.arcaneBombCount+1]
		if timer then
			timerArcaneBombCD:Start(timer, self.vb.arcaneBombCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 296566 then
		if not args:IsPlayer() then
			specWarnTideFist:Show(args.destName)
			specWarnTideFist:Play("tauntboss")
		end
	elseif spellId == 296737 then
		warnArcaneBomb:CombinedShow(0.3, args.destName)
		local icon = self.vb.arcaneBombicon
		if args:IsPlayer() then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell(icon, icon, icon)
			yellArcaneBombFades:Countdown(10, nil, icon)
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destname, self.vb.arcaneBombicon)
		end
		self.vb.arcaneBombicon = self.vb.arcaneBombicon + 1
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 296737 then
		if args:IsPlayer() then
			yellArcaneBombFades:Cancel()
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destname, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152512 then--Stormwraith
		self.vb.tempestStage = false
		self.vb.unshackledCount = 0
		self.vb.arcanadoCount = 0
		self.vb.tideFistCount = 0
		self.vb.arcaneBombCount = 0
		timerGaleBuffetCD:Stop()
		timerArcaneBombCD:Stop()
		timerArcanadoBurstCD:Start(6, 1)
		timerArcaneBombCD:Start(7, 1)
		timerUnshacklingPowerCD:Start(10, 1)
		timerTideFistCD:Start(15, 1)
		timerAncientTempestCD:Start(95.8)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 296428 then--Arcanado Burst
		self.vb.arcanadoCount = self.vb.arcanadoCount + 1
		warnArcanadoBurst:Show(self.vb.arcanadoCount)
		local timer = arcanadoTimers[self.vb.arcanadoCount+1]
		if timer then
			timerArcanadoBurstCD:Start(timer, self.vb.arcanadoCount+1)
		end
	end
end
