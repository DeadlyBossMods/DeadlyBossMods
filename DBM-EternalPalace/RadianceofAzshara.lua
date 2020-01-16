local mod	= DBM:NewMod(2353, "DBM-EternalPalace", nil, 1179)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(152364)
mod:SetEncounterID(2305)
mod:SetZone()
mod:SetUsedIcons(1, 2)
mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 296459 296894 295916 296701 296566",
	"SPELL_CAST_SUCCESS 296737",
	"SPELL_AURA_APPLIED 296566 296737",
	"SPELL_AURA_REMOVED 296737",
	"SPELL_INTERRUPT",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 296566 or ability.id = 296459 or ability.id = 296894 or ability.id = 302465 or ability.id = 295916 or ability.id = 296701 or ability.id = 304098) and type = "begincast"
 or ability.id = 296737 and type = "cast"
 or type = "death" and target.id = 152512
 or type = "interrupt"
--]]
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
local specWarnGaleBuffet				= mod:NewSpecialWarningSpell(304098, nil, nil, nil, 2, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--Rising Fury
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20076))
local timerTideFistCD					= mod:NewNextCountTimer(58.2, 296546, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, mod:IsTank() and 2, 4)
local timerArcanadoBurstCD				= mod:NewNextCountTimer(58.2, 296430, nil, nil, nil, 3)
local timerArcaneBombCD					= mod:NewNextCountTimer(58.2, 296737, nil, "-Tank", nil, 3, nil, nil, nil, 3, 4)
local timerUnshacklingPowerCD			= mod:NewNextCountTimer(58.2, 296894, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON, nil, 1, 4)
local timerAncientTempestCD				= mod:NewNextTimer(95.9, 295916, nil, nil, nil, 6)
--Raging Storm
mod:AddTimerLine(DBM:EJ_GetSectionInfo(20078))
local timerGaleBuffetCD					= mod:NewCDTimer(22.6, 304098, nil, nil, nil, 2)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnArcaneBomb", 296737, true, false, {1, 2})

mod.vb.unshackledCount = 0
mod.vb.arcanadoCount = 0
mod.vb.tideFistCount = 0
mod.vb.arcaneBombCount = 0
mod.vb.arcaneBombicon = 1
mod.vb.tempestStage = false
mod.vb.addsLeft = 1
local arcanadoTimers = {5.9, 12.0, 13.1, 10.5, 12.0, 13.1, 10.6}
local tideFistTimers = {15.1, 20.0, 19.0, 20.0}
local unshackledPowerTimers = {10.0, 18.0, 18.0, 18.0, 18.0}
local arcaneBombTimers = {7.1, 19.9, 22.1, 18.0, 25.5}

function mod:OnCombatStart(delay)
	self.vb.unshackledCount = 0
	self.vb.arcanadoCount = 0
	self.vb.tideFistCount = 0
	self.vb.arcaneBombCount = 0
	self.vb.arcaneBombicon = 1
	self.vb.tempestStage = false
	--Seem same in heroic and mythic thus far
	timerArcanadoBurstCD:Start(6-delay, 1)
	timerArcaneBombCD:Start(7-delay, 1)
	timerUnshacklingPowerCD:Start(10-delay, 1)
	timerTideFistCD:Start(15-delay, 1)
	timerAncientTempestCD:Start(95.6)
	berserkTimer:Start(self:IsMythic() and 540 or 720-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 296566 then
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
	elseif spellId == 296894 then--296894 verified all difficulties, 302465 is unknown
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
		if self:IsMythic() then
			self.vb.addsLeft = 2
		else
			self.vb.addsLeft = 1
		end
		timerTideFistCD:Stop()
		timerArcanadoBurstCD:Stop()
		timerArcaneBombCD:Stop()
		timerUnshacklingPowerCD:Stop()
		specWarnAncientTempest:Show()
		specWarnAncientTempest:Play("phasechange")
	elseif spellId == 296701 then--296701 verified all difficulties. 304098 is unknown
		if self:CheckBossDistance(args.sourceGUID, true, 34471) then--43 yards
			specWarnGaleBuffet:Show()
			specWarnGaleBuffet:Play("carefly")
		end
		timerGaleBuffetCD:Start(nil, args.sourceGUID)
		if not self:CheckBossDistance(args.sourceGUID, true) then
			timerGaleBuffetCD:SetSTFade(true, args.sourceGUID)
		end
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
			yellArcaneBombFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destname, self.vb.arcaneBombicon)
		end
		self.vb.arcaneBombicon = self.vb.arcaneBombicon + 1
	end
end

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

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 304951 then--Focus Power
		--First arcane bomb is cast immediately after spell lock ends
		--This means if mage interrupts, 6 seconds after interrupt, hunter, 3 seconds later.
		timerGaleBuffetCD:Start(11, args.destGUID)
		if not self:CheckBossDistance(args.destGUID, true) then
			timerGaleBuffetCD:SetSTFade(true, args.destGUID)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152512 then--Stormwraith
		timerGaleBuffetCD:Stop(args.destGUID)
		self.vb.addsLeft = self.vb.addsLeft - 1
		if self.vb.addsLeft == 0 then
			self.vb.tempestStage = false
			self.vb.unshackledCount = 0
			self.vb.arcanadoCount = 0
			self.vb.tideFistCount = 0
			self.vb.arcaneBombCount = 0
			timerArcaneBombCD:Stop()
			timerArcanadoBurstCD:Start(9, 1)
			timerArcaneBombCD:Start(10, 1)
			timerUnshacklingPowerCD:Start(13, 1)
			timerTideFistCD:Start(18, 1)
			timerAncientTempestCD:Start(98.8)
		end
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
