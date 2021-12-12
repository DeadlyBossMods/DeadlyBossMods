local mod	= DBM:NewMod(2470, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(183501)
mod:SetEncounterID(2553)
mod:SetUsedIcons(1, 2, 3, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20211211000000)
mod:SetMinSyncRevision(20211211000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 363485 365682 362841 362801 362849 364040",
	"SPELL_CAST_SUCCESS 362885 364040 366752 362721 363258 364465 364030",
	"SPELL_AURA_APPLIED 365577 365681 365701 362615 362614 362803 362882",
	"SPELL_AURA_APPLIED_DOSE 365681",
	"SPELL_AURA_REMOVED 365577 365701 363034 363139 362615 362614 362803",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, what to really do with https://ptr.wowhead.com/spell=365745/rotary-body-armor
--TODO, how does Gunship/hyperlight barrage work? Probably https://ptr.wowhead.com/spell=364376/hyperlight-barrage 3 sec periodic trigger
--[[
(ability.id = 363485 or ability.id = 362841 or ability.id = 362801 or ability.id = 362849) and type = "begincast"
 or (ability.id = 362885 or ability.id = 366752 or ability.id = 364040 or ability.id = 362721 or ability.id = 363258 or ability.id = 364465) and type = "cast"
 or (ability.id = 363034 or ability.id = 363139) and type = "removebuff"
 or (ability.id = 365682 or ability.id = 364040) and type = "begincast"
 or ability.id = 364030 and type = "cast"
--]]
--Xy Decipherers
----Cartel Overseer
local warnSystemShock							= mod:NewStackAnnounce(365681, 2, nil, "Tank|Healer")
local warnHyperlightAscension					= mod:NewCastAnnounce(364040, 3)
--Boss
local warnDecipherRelic							= mod:NewSpellAnnounce(363139, 2)
local warnDecipherRelicOver						= mod:NewEndAnnounce(363139, 2)
local warnInterdimensionalWormhole				= mod:NewTargetNoFilterAnnounce(362615, 3, nil, nil, 67833)
local warnStasisTrap							= mod:NewTargetNoFilterAnnounce(362882, 2)--Failing to dodge it

--Xy Decipherers
local specWarnXyDecipherers						= mod:NewSpecialWarningSwitch(363485, "-Healer", nil, nil, 1, 2, 4)
----Cartel Overseer
local specWarnSystemShock						= mod:NewSpecialWarningDefensive(365682, nil, nil, nil, 1, 2)
local specWarnSystemShockTaunt					= mod:NewSpecialWarningTaunt(365681, nil, nil, nil, 1, 2)
--Boss
local specWarnForerunnerRings					= mod:NewSpecialWarningDodge(363520, nil, nil, nil, 2, 2)
local specWarnFracturingRiftBlasts				= mod:NewSpecialWarningDodge(362841, 355331, nil, nil, 2, 2, 4)--Mythic only
local specWarnInterdimensionalWormhole			= mod:NewSpecialWarningYouPos(362615, 67833, nil, nil, 1, 2)
local yellInterdimensionalWormhole				= mod:NewPosYell(362615, 67833)
local yellInterdimensionalWormholeFades			= mod:NewIconFadesYell(362615, 67833)
local specWarnGlyphofRelocation					= mod:NewSpecialWarningMoveAway(362803, nil, nil, nil, 1, 2)
local yellGlyphofRelocation						= mod:NewYell(362803)
local yellGlyphofRelocationFades				= mod:NewShortFadesYell(362803)
local specWarnGlyphofRelocationTaunt			= mod:NewSpecialWarningTaunt(362803, nil, nil, nil, 1, 2)
local specWarnHyperlightSpark					= mod:NewSpecialWarningCount(362849, nil, nil, nil, 2, 2)
local specWarnStasisTrap						= mod:NewSpecialWarningDodge(362885, nil, nil, nil, 2, 2)
local yellStasisTrap							= mod:NewYell(362882)--Failing to dodge it
--Hyperlight Adds
local specWarnDebilitatingRay					= mod:NewSpecialWarningInterruptCount(364030, "HasInterrupt", nil, nil, 1, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerForerunnerRingsCD					= mod:NewCDTimer(30, 363520, nil, nil, nil, 3)
--Xy Decipherers
local timerXyDecipherersCD						= mod:NewAITimer(28.8, 363485, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)
----Cartel Overseer
local timerSystemShockCD						= mod:NewCDTimer(11.5, 365682, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--11.5-12.2
--Boss
local timerFracturingRiftBlastsCD				= mod:NewAITimer(28.8, 362841, 355331, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerInterdimensionalWormholeCD			= mod:NewNextTimer(30, 362615, 67833, nil, nil, 3)
local timerGlyphofRelocationCD					= mod:NewNextTimer(30, 362801, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHyperlightSparknovaCD				= mod:NewNextCountTimer(30, 362849, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerStasisTrapCD							= mod:NewNextTimer(30, 362885, nil, nil, nil, 3)
--Hyperlight Adds
--local timerDebilitatingRayCD					= mod:NewAITimer(28.8, 364030, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnHyperlightAdds", 364021, true, true, {4, 5, 6, 7, 8})
mod:AddSetIconOption("SetIconOnWormhole", 362615, true, false, {1, 2})
mod:AddSetIconOption("SetIconGlyphofRelocation", 362803, false, false, {3})
mod:AddNamePlateOption("NPAuraOnDecipherRelic", 365577, true)
mod:AddNamePlateOption("NPAuraOnOverseersOrders", 365701, true)
mod:AddNamePlateOption("NPAuraOnAscension", 364040, true)

local castsPerGUID = {}
mod.vb.tearIcon = 1
mod.vb.sparkCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.sparkCount = 0
	timerInterdimensionalWormholeCD:Start(8-delay)
	timerHyperlightSparknovaCD:Start(14-delay, 1)
	timerStasisTrapCD:Start(21-delay)
	timerForerunnerRingsCD:Start(26-delay)
	timerGlyphofRelocationCD:Start(40-delay)
	if self:IsMythic() then
		timerXyDecipherersCD:Start(1-delay)
		timerFracturingRiftBlastsCD:Start(1-delay)
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder or self.Options.NPAuraOnAscension then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder or self.Options.NPAuraOnAscension then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--[[
function mod:OnTimerRecovery()

end
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 363485 then
		specWarnXyDecipherers:Show()
		specWarnXyDecipherers:Play("killadd")
		timerXyDecipherersCD:Start()
	elseif spellId == 365682 then
		if self:IsTanking("player", nil, nil, nil, args.sourseGUID) then
			specWarnSystemShock:Show()
			specWarnSystemShock:Play("defensive")
		end
		timerSystemShockCD:Start(11.5, args.sourceGUID)
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
	elseif spellId == 364040 then
		if self:AntiSpam(2, 2) then
			warnHyperlightAscension:Show()
		end
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 362885 or spellId == 366752) and self:AntiSpam(10, 3) then--362885 verified on heroic
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	elseif spellId == 364040 then
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 362721 then
		self.vb.tearIcon = 1
--		timerInterdimensionalWormholeCD:Start()--Not used second time per phase?
	elseif spellId == 363258 then--Slightly faster than SPELL_CAST_START/APPLIED
		warnDecipherRelic:Show()
		--Stop timers
		timerForerunnerRingsCD:Stop()
		timerXyDecipherersCD:Stop()
		timerFracturingRiftBlastsCD:Stop()
		timerInterdimensionalWormholeCD:Stop()
		timerGlyphofRelocationCD:Stop()
		timerHyperlightSparknovaCD:Stop()
		timerStasisTrapCD:Stop()
		--Only scan for acolytes and mark them with skull and cross, then stop scanning
		if self.Options.SetIconOnHyperlightAdds then
			self:ScanForMobs(184140, 0, 8, 2, {184140, 184143}, 12, "SetIconOnHyperlightAdds")
		end
		--Secondary scan that's marking Debilitators with 6 5 and 4
		if self.Options.SetIconOnHyperlightAdds then
			self:ScanForMobs(183707, 0, 6, 3, nil, 12, "SetIconOnHyperlightAdds")
		end
	elseif spellId == 364465 then
		specWarnForerunnerRings:Show()
		specWarnForerunnerRings:Play("watchwave")
		timerForerunnerRingsCD:Start()
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
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if not args:IsPlayer() then
					--Because multiple adds up on diff CDs, can't do fancy debuff remaining checks, it just needs to be gone
					if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
						specWarnSystemShockTaunt:Show(args.destName)
						specWarnSystemShockTaunt:Play("tauntboss")
					else
						warnSystemShock:Show(args.destName, amount)
					end
				end
			else
				warnSystemShock:Show(args.destName, amount)
			end
		end
	elseif spellId == 362615 or spellId == 362614 then
		local icon = self.vb.tearIcon
		if self.Options.SetIconOnWormhole then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnInterdimensionalWormhole:Show(self:IconNumToTexture(icon))
			specWarnInterdimensionalWormhole:Play("mm"..icon)
			yellInterdimensionalWormhole:Yell(icon, icon, icon)
			yellInterdimensionalWormholeFades:Countdown(spellId, 7, icon)
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
	elseif spellId == 362882 then
		warnStasisTrap:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			yellStasisTrap:Yell()
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
		warnDecipherRelicOver:Show()
		--Restart Timers (exactly same as pull)
		timerInterdimensionalWormholeCD:Start(8)
		timerHyperlightSparknovaCD:Start(14)
		timerStasisTrapCD:Start(21)
		timerForerunnerRingsCD:Start(26)
		timerGlyphofRelocationCD:Start(40)
		if self:IsMythic() then
			timerXyDecipherersCD:Start(2)
			timerFracturingRiftBlastsCD:Start(2)
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 184140 or cid == 184143 then--Hyperlight Acolyte, Hyperlight Archon
		timerSystemShockCD:Stop(args.destGUID)
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Hide(true, args.destGUID, 364040)
		end
--	elseif cid == 183707 then--Cartel Xy Debilitator

	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 5) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--"<19.51 22:08:21> [UNIT_SPELLCAST_SUCCEEDED] Artificer Xy'mox(Bookaine) -Hyperlight Reinforcements- boss1:Cast-3-4170-2481-12807-364046-006FB27045:364046
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 364046 then

	end
end
--]]
