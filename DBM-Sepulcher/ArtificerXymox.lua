local mod	= DBM:NewMod(2470, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(175730)
mod:SetEncounterID(2553)
mod:SetUsedIcons(1, 2, 3, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(20210902000000)
--mod:SetMinSyncRevision(20210706000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 363520 363485 365682 362841 362801 362849",
	"SPELL_CAST_SUCCESS 362885",
	"SPELL_SUMMON 364021 364052 364049 364047",
	"SPELL_AURA_APPLIED 365577 365681 365701 363034 363139 364030 362615 362614 362803",
	"SPELL_AURA_APPLIED_DOSE 365681",
	"SPELL_AURA_REMOVED 365577 365701 363034 363139 362615 362614 362803"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, I know rings is probably a mess, need to figure out which script is activator to make sure it's not spammy
--TODO adjust remaining for Add tank debuff
--TODO, what to really do with https://ptr.wowhead.com/spell=365745/rotary-body-armor
--TODO, auto mark Hyperlight reinforcmements based on kill priority using correct ID assignments, right now they have placeholder marking
--TODO, how does Gunship/hyperlight barrage work? Probably https://ptr.wowhead.com/spell=364376/hyperlight-barrage 3 sec periodic trigger
--local warnGrimPortent							= mod:NewTargetNoFilterAnnounce(354365, 4)--Mythic
local warnForerunnerRings						= mod:NewSpellAnnounce(363520, 3)--Probalby be upgraded to SW if it's not frequent
--Xy Decipherers
----Cartel Overseer
local warnSystemShock							= mod:NewStackAnnounce(365681, 2, nil, "Tank|Healer")
--Boss
local warnInterdimensionalWormhole				= mod:NewTargetNoFilterAnnounce(362615, 3, nil, nil, 67833)

--Xy Decipherers
local specWarnXyDecipherers						= mod:NewSpecialWarningSwitch(363485, "-Healer", nil, nil, 1, 2, 4)
----Cartel Overseer
local specWarnSystemShock						= mod:NewSpecialWarningDefensive(365682, nil, nil, nil, 1, 2)
local specWarnSystemShockTaunt					= mod:NewSpecialWarningTaunt(365681, nil, nil, nil, 1, 2)
--Boss
local specWarnFracturingRiftBlasts				= mod:NewSpecialWarningDodge(362841, 355331, nil, nil, 2, 2)
local specWarnInterdimensionalWormhole			= mod:NewSpecialWarningYouPos(362615, 67833, nil, nil, 1, 2)
local yellInterdimensionalWormhole				= mod:NewPosYell(362615, 67833)
local yellInterdimensionalWormholeFades			= mod:NewIconFadesYell(362615, 67833)
local specWarnGlyphofRelocation					= mod:NewSpecialWarningMoveAway(362803, nil, nil, nil, 1, 2)
local yellGlyphofRelocation						= mod:NewYell(362803)
local yellGlyphofRelocationFades				= mod:NewShortFadesYell(362803)
local specWarnGlyphofRelocationTaunt			= mod:NewSpecialWarningTaunt(362803, nil, nil, nil, 1, 2)
local specWarnHyperlightSpark					= mod:NewSpecialWarningCount(362849, nil, nil, nil, 2, 2)
local specWarnStasisTrap						= mod:NewSpecialWarningDodge(362885, nil, nil, nil, 2, 2)
--Hyperlight Adds
local specWarnDebilitatingRay					= mod:NewSpecialWarningInterruptCount(364030, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerForerunnerRingsCD					= mod:NewAITimer(28.8, 363520, nil, nil, nil, 3)
--Xy Decipherers
local timerXyDecipherersCD						= mod:NewAITimer(28.8, 363485, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)
----Cartel Overseer
--local timerSystemShockCD						= mod:NewAITimer(28.8, 365682, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Boss
local timerFracturingRiftBlastsCD				= mod:NewAITimer(28.8, 362841, 355331, nil, nil, 3)
local timerInterdimensionalWormholeCD			= mod:NewAITimer(28.8, 362615, 67833, nil, nil, 3)
local timerGlyphofRelocationCD					= mod:NewAITimer(28.8, 362801, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHyperlightSparknovaCD				= mod:NewAITimer(28.8, 362849, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerStasisTrapCD							= mod:NewAITimer(28.8, 362885, nil, nil, nil, 3)
--Hyperlight Adds
--local timerDebilitatingRayCD					= mod:NewAITimer(28.8, 364030, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnHyperlightAdds", 364021, true, true, {5, 6, 7, 8})
mod:AddSetIconOption("SetIconOnWormhole", 362615, true, false, {1, 2})
mod:AddSetIconOption("SetIconGlyphofRelocation", 362803, false, false, {3})
mod:AddNamePlateOption("NPAuraOnDecipherRelic", 365577, true)
mod:AddNamePlateOption("NPAuraOnOverseersOrders", 365701, true)

local castsPerGUID = {}
mod.vb.tearIcon = 1
mod.vb.sparkCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.sparkCount = 0
	timerForerunnerRingsCD:Start(1-delay)
	timerXyDecipherersCD:Start(1-delay)
	timerFracturingRiftBlastsCD:Start(1-delay)
	timerInterdimensionalWormholeCD:Start(1-delay)
	timerGlyphofRelocationCD:Start(1-delay)
	timerHyperlightSparknovaCD:Start(1-delay)
	timerStasisTrapCD:Start(1-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 363520 and self:AntiSpam(10, 1) then--Antispam for good measure, literally have no idea how this is scripted
		warnForerunnerRings:Show()
		timerForerunnerRingsCD:Start()
	elseif spellId == 363485 then
		specWarnXyDecipherers:Show()
		specWarnXyDecipherers:Play("killadd")
		timerXyDecipherersCD:Start()
	elseif spellId == 365682 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then
			specWarnSystemShock:Show()
			specWarnSystemShock:Play("defensive")
		end
--		timerSystemShockCD:Start(nil, args.sourceGUID)
	elseif spellId == 362841 then
		specWarnFracturingRiftBlasts:Show()
		specWarnFracturingRiftBlasts:Play("farfromline")
		timerFracturingRiftBlastsCD:Start()
	elseif spellId == 362801 then
		timerGlyphofRelocationCD:Start()
	elseif spellId == 362849 then
		self.vb.sparkCount = self.vb.sparkCount + 1
		specWarnHyperlightSpark:Show(self.vb.sparkCount)
		specWarnHyperlightSpark:Play("aesoon")
		timerHyperlightSparknovaCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if args:IsSpellID(364021, 364052, 364049, 364047) then--184119, 184149, 184147, 184146 (Hyperlight Reinforcment summons)
		if spellId == 364021 then--184119
			if self.Options.SetIconOnHyperlightAdds then
				self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnHyperlightAdds")
			end
		elseif spellId == 364052 then--184149
			if self.Options.SetIconOnHyperlightAdds then
				self:ScanForMobs(args.sourceGUID, 2, 7, 1, nil, 12, "SetIconOnHyperlightAdds")
			end
		elseif spellId == 364049 then--184147
			if self.Options.SetIconOnHyperlightAdds then
				self:ScanForMobs(args.sourceGUID, 2, 6, 1, nil, 12, "SetIconOnHyperlightAdds")
			end
		else--184146
			if self.Options.SetIconOnHyperlightAdds then
				self:ScanForMobs(args.sourceGUID, 2, 5, 1, nil, 12, "SetIconOnHyperlightAdds")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362885 and self:AntiSpam(10, 3) then
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 365577 then
		if self.Options.NPAuraOnDecipherRelic then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 25)
		end
	elseif spellId == 365701 then
		if self.Options.NPAuraOnOverseersOrders then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 365681 then
		local amount = args.amount or 1
		if amount >= 2 then
			if not args:IsPlayer() then
				local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if (not remaining or remaining and remaining < 3) and not UnitIsDeadOrGhost("player") then
					specWarnSystemShockTaunt:Show(args.destName)
					specWarnSystemShockTaunt:Play("tauntboss")
				else
					warnSystemShock:Show(args.destName, amount)
				end
			end
		else
			warnSystemShock:Show(args.destName, amount)
		end
	elseif spellId == 363034 or spellId == 363139 then--Decipher Relic 1 min (boss casts)
		--Stop timers here?
		timerForerunnerRingsCD:Stop()
		timerXyDecipherersCD:Stop()
		timerFracturingRiftBlastsCD:Stop()
		timerInterdimensionalWormholeCD:Stop()
		timerGlyphofRelocationCD:Stop()
		timerHyperlightSparknovaCD:Stop()
		timerStasisTrapCD:Stop()
	elseif spellId == 364030 then
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but failsafe
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
--		timerDebilitatingRayCD:Start(17, count, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnDebilitatingRay:Show(args.sourceName, count)
			if count == 1 then
				specWarnDebilitatingRay:Play("kick1r")
			elseif count == 2 then
				specWarnDebilitatingRay:Play("kick2r")
			elseif count == 3 then
				specWarnDebilitatingRay:Play("kick3r")
			elseif count == 4 then
				specWarnDebilitatingRay:Play("kick4r")
			elseif count == 5 then
				specWarnDebilitatingRay:Play("kick5r")
			else
				specWarnDebilitatingRay:Play("kickcast")
			end
		end
	elseif spellId == 362615 or spellId == 362614 then
		if self:AntiSpam(10, 2) then--Move to casts event if there is one
			self.vb.tearIcon = 1
			timerInterdimensionalWormholeCD:Start()
		end
		local icon = self.vb.tearIcon
		if self.Options.SetIconOnWormhole then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnInterdimensionalWormhole:Show(self:IconNumToTexture(icon))
			specWarnInterdimensionalWormhole:Play("mm"..icon)
			yellInterdimensionalWormhole:Yell(icon, icon, icon)
			yellInterdimensionalWormholeFades:Countdown(spellId, nil, icon)
		end
		warnInterdimensionalWormhole:CombinedShow(1, args.destName)
		self.vb.tearIcon = self.vb.tearIcon + 1
	elseif spellId == 362803 then
		if self.Options.SetIconGlyphofRelocation then
			self:SetIcon(args.destName, 3)
		end
		if args:IsPlayer() then
			specWarnGlyphofRelocation:Show(self.vb.destructionCount)
			specWarnGlyphofRelocation:Play("runout")
			yellGlyphofRelocation:Yell()
			yellGlyphofRelocationFades:Countdown(spellId)
		else
			specWarnGlyphofRelocationTaunt:Show(args.destName)
			specWarnGlyphofRelocationTaunt:Play("tauntboss")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 365577 then
		if self.Options.NPAuraOnDecipherRelic then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 365701 then
		if self.Options.NPAuraOnOverseersOrders then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 363034 or spellId == 363139 then--Decipher Relic 1 min (boss casts)
		self:SetStage(0)
		--Might not be how this works at all, complete guess
		if self.vb.phase == 2 then
			timerForerunnerRingsCD:Start(2)
			timerXyDecipherersCD:Start(2)
			timerFracturingRiftBlastsCD:Start(2)
			timerInterdimensionalWormholeCD:Start(2)
			timerGlyphofRelocationCD:Start(2)
			timerHyperlightSparknovaCD:Start(2)
			timerStasisTrapCD:Start(2)
		elseif self.vb.phase == 3 then
			timerForerunnerRingsCD:Start(3)
			timerXyDecipherersCD:Start(3)
			timerFracturingRiftBlastsCD:Start(3)
			timerInterdimensionalWormholeCD:Start(3)
			timerGlyphofRelocationCD:Start(3)
			timerHyperlightSparknovaCD:Start(3)
			timerStasisTrapCD:Start(3)
		else--Phase = 4
			timerForerunnerRingsCD:Start(4)
			timerXyDecipherersCD:Start(4)
			timerFracturingRiftBlastsCD:Start(4)
			timerInterdimensionalWormholeCD:Start(4)
			timerGlyphofRelocationCD:Start(4)
			timerHyperlightSparknovaCD:Start(4)
			timerStasisTrapCD:Start(4)
		end
	elseif spellId == 362615 or spellId == 362614 then
		if self.Options.SetIconOnWormhole then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellInterdimensionalWormholeFades:Cancel()
		end
	elseif spellId == 362803 then
		if self.Options.SetIconGlyphofRelocation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellGlyphofRelocationFades:Cancel()
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 184119 then

	elseif cid == 184149 then

	elseif cid == 184147 then

	elseif cid == 184146 then

	end
end
-]]

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
