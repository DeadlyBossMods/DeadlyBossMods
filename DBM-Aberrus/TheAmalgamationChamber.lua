local mod	= DBM:NewMod(2529, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201774, 201773, 201934)--Krozgoth, Moltannia, Molgoth
mod:SetEncounterID(2687)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230406000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 403459 405016 407640 403699 404732 403101 404896 405437 405641 408193 405914 406783 403203 409385",
	"SPELL_CAST_SUCCESS 406730 409385",
	"SPELL_AURA_APPLIED 401809 402617 405036 405394 405642 405914",
	"SPELL_AURA_APPLIED_DOSE 401809 402617 405394",
	"SPELL_AURA_REMOVED 401809 402617 405036 405642",
	"SPELL_PERIODIC_DAMAGE 405084 405645",
	"SPELL_PERIODIC_MISSED 405084 405645"
)

--[[
(ability.id = 403459 or ability.id = 405016 or ability.id = 407640 or ability.id = 403699 or ability.id = 404732 or ability.id = 403101 or ability.id = 404896 or ability.id = 403203 or ability.id = 405437 or ability.id = 405641 or ability.id = 408193 or ability.id = 405914 or ability.id = 406783) and type = "begincast"
 or (ability.id = 406730 or ability.id = 406780) and type = "cast"
--]]
--TODO, also target scan Swirling Flame?
--TODO, secondary alert for Swirling Shadowflame ?
--TODO, if both tank abilities in P2 are a combo, just use generic tank combo timer
--General
local specWarnGTFO								= mod:NewSpecialWarningGTFO(405084, nil, nil, nil, 1, 8)

mod:AddBoolOption("AdvancedBossFiltering", true, "misc")--May be default to off on live, but for testing purposes it needs to be forced
--Krozgoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26336))
local warnCorruptingShadow						= mod:NewCountAnnounce(401809, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(401809))
local warnCorruptingShadowFades					= mod:NewFadesAnnounce(401809, 1)
local warnUmbralDetonation						= mod:NewTargetCountAnnounce(405016, 3, nil, nil, nil, nil, nil, nil, true)

local specWarnCoalescingVoid					= mod:NewSpecialWarningCount(403459, nil, nil, nil, 2, 2)--Possibly use a run away warning if idea is to actualy move away? Something tells me falloff is just designed to scope damage to players on THIS boss only
local specWarnUmbralDetonation					= mod:NewSpecialWarningYou(405016, nil, nil, nil, 1, 2)
local yellUmbralDetonation						= mod:NewShortYell(405016)
local yellUmbralDetonationFades					= mod:NewShortFadesYell(405016)
local specWarnShadowsConvergence				= mod:NewSpecialWarningDodgeCount(407640, nil, nil, nil, 2, 2)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

local timerCoalescingVoidCD						= mod:NewCDCountTimer(21.9, 403459, nil, nil, nil, 2)
local timerUmbralDetonationCD					= mod:NewCDCountTimer(21.9, 405016, nil, nil, nil, 3)
local timerShadowsConvergenceCD					= mod:NewCDCountTimer(20.7, 407640, nil, nil, nil, 3)
local timerShadowSpikeCD						= mod:NewCDCountTimer(11, 403699, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
mod:AddSetIconOption("SetIconOnUmbral", 405016, false, 0, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--mod:GroupSpells(390715, 396094)
--Moltannia
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26337))
local warnBlazingHeat							= mod:NewCountAnnounce(402617, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(401809))
local warnBlazingHeatFades						= mod:NewFadesAnnounce(402617, 1)

local specWarnFieryMeteor						= mod:NewSpecialWarningCount(404732, nil, nil, nil, 2, 2)
local specWarnMoltenEruption					= mod:NewSpecialWarningCount(403101, nil, nil, nil, 2, 2)
local specWarnSwirlingFlame						= mod:NewSpecialWarningDodgeCount(404896, nil, nil, nil, 2, 2)

local timerFieryMeteorCD						= mod:NewCDCountTimer(31.7, 404732, nil, nil, nil, 3)
local timerMoltenEruptionCD						= mod:NewCDCountTimer(22.3, 403101, nil, nil, nil, 5)
local timerSwirlingFlameCD						= mod:NewCDCountTimer(20.7, 404896, nil, nil, nil, 3)
local timerFlameSlashCD							= mod:NewCDCountTimer(11, 403203, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Molgoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26338))
local warnShadowandFlame						= mod:NewCastAnnounce(409385, 4)
local warnShadowflame							= mod:NewCountAnnounce(405394, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(405394))
local warnBlisteringTwilight					= mod:NewTargetCountAnnounce(405641, 3, nil, nil, nil, nil, nil, nil, true)
local warnShadowflameBurst						= mod:NewCountAnnounce(406783, 3)

local specWarnGloomConflag						= mod:NewSpecialWarningCount(405437, nil, nil, nil, 2, 2)
local specWarnBlisteringTwilight				= mod:NewSpecialWarningYou(405641, nil, nil, nil, 1, 2)
local yellBlisteringTwilight					= mod:NewShortYell(405641)
local yellBlisteringTwilightFades				= mod:NewShortFadesYell(405641)
local specWarnConvergentEruption				= mod:NewSpecialWarningCount(408193, nil, nil, nil, 2, 2)
local specWarnWitheringVulnerability				= mod:NewSpecialWarningDefensive(405914, nil, nil, nil, 1, 2)
local specWarnWitheringVulnerabilityTaunt		= mod:NewSpecialWarningTaunt(405914, nil, nil, nil, 1, 2)

local timerShadowandFlameCD						= mod:NewCDCountTimer(47.4, 409385, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerGloomConflagCD						= mod:NewCDCountTimer(40, 405437, nil, nil, nil, 3)
local timerBlisteringTwilightCD					= mod:NewCDCountTimer(40, 405641, nil, nil, nil, 3)
local timerConvergentEruptionCD					= mod:NewCDCountTimer(40, 408193, nil, nil, nil, 5)
local timerWitheringVulnerabilityCD				= mod:NewCDCountTimer(35.3, 405914, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--35-40
local timerShadowflameBurstCD					= mod:NewCDCountTimer(35.3, 406783, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Might be redundant if always after crushing

mod:AddSetIconOption("SetIconOnBlistering", 405641, false, 0, {1, 2, 3, 4})
mod:AddRangeFrameOption(6, 409385)

local nearKroz, nearMolt = true, true
mod.vb.coalescingCount = 0
mod.vb.umbralCount = 0
mod.vb.umbralIcon = 1
mod.vb.shadowConvergeCount = 0
mod.vb.shadowStrikeCount = 0

mod.vb.meteorCast = 0
mod.vb.swirlingCount = 0
mod.vb.moltenEruptionCast = 0
mod.vb.flameSlashCast = 0

mod.vb.witheringVulnCount = 0
mod.vb.shadowflameBurstCount = 0
mod.vb.SandFCount = 0

--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Krozgoth
	if self:CheckBossDistance(201774, true, 32698, 48) then
		if not nearKroz then
			nearKroz = true
			timerCoalescingVoidCD:SetFade(false, self.vb.coalescingCount+1)
			timerUmbralDetonationCD:SetFade(false, self.vb.umbralCount+1)
			timerShadowsConvergenceCD:SetFade(false, self.vb.shadowConvergeCount+1)
			timerShadowSpikeCD:SetFade(false, self.vb.shadowStrikeCount+1)
		end
	else
		if nearKroz then
			nearKroz = false
			timerCoalescingVoidCD:SetFade(true, self.vb.coalescingCount+1)
			timerUmbralDetonationCD:SetFade(true, self.vb.umbralCount+1)
			timerShadowsConvergenceCD:SetFade(true, self.vb.shadowConvergeCount+1)
			timerShadowSpikeCD:SetFade(true, self.vb.shadowStrikeCount+1)
		end
	end
	--Check if near or far from Moltannia
	if self:CheckBossDistance(201773, true, 32698, 48) then
		if not nearMolt then
			nearMolt = true
			timerFieryMeteorCD:SetFade(false, self.vb.meteorCast+1)
			timerMoltenEruptionCD:SetFade(false, self.vb.moltenEruptionCast+1)
			timerSwirlingFlameCD:SetFade(false, self.vb.swirlingCount+1)
			timerFlameSlashCD:SetFade(false, self.vb.flameSlashCast+1)
		end
	else
		if nearMolt then
			nearMolt = false
			timerFieryMeteorCD:SetFade(true, self.vb.meteorCast+1)
			timerMoltenEruptionCD:SetFade(true, self.vb.moltenEruptionCast+1)
			timerSwirlingFlameCD:SetFade(true, self.vb.swirlingCount+1)
			timerFlameSlashCD:SetFade(true, self.vb.flameSlashCast+1)
		end
	end
	self:Schedule(2, updateBossDistance, self)
end

function mod:OnCombatStart(delay)
	nearKroz, nearMolt = true, true
	self:SetStage(1)
	--Krozgoth
	self.vb.coalescingCount = 0
	self.vb.umbralCount = 0
	self.vb.umbralIcon = 1
	self.vb.shadowConvergeCount = 0
	self.vb.shadowStrikeCount = 0
	if self:IsMythic() then
		timerShadowSpikeCD:Start(9.5-delay, 1)
		timerUmbralDetonationCD:Start(14.3-delay, 1)
		timerShadowsConvergenceCD:Start(22.8-delay, 1)
		timerCoalescingVoidCD:Start(36.2-delay, 1)
	else
		timerShadowSpikeCD:Start(5.9-delay, 1)
		timerUmbralDetonationCD:Start(19.3-delay, 1)
		timerShadowsConvergenceCD:Start(22.8-delay, 1)
		timerCoalescingVoidCD:Start(30.3-delay, 1)
	end
	--Reset Fades
	timerCoalescingVoidCD:SetFade(false, 1)
	timerUmbralDetonationCD:SetFade(false, 1)
	timerShadowsConvergenceCD:SetFade(false, 1)
	timerShadowSpikeCD:SetFade(false, 1)
	--Moltannia
	self.vb.meteorCast = 0
	self.vb.moltenEruptionCast = 0
	self.vb.swirlingCount = 0
	self.vb.SandFCount = 0
	self.vb.flameSlashCast = 0
	if self:IsMythic() then
		timerFlameSlashCD:Start(7-delay, 1)
		timerSwirlingFlameCD:Start(10.7-delay, 1)
		timerMoltenEruptionCD:Start(16.7-delay, 1)
		timerFieryMeteorCD:Start(36.2-delay, 1)
	else
		timerFlameSlashCD:Start(5.9-delay, 1)
		timerSwirlingFlameCD:Start(9.5-delay, 1)
		timerMoltenEruptionCD:Start(23-delay, 1)
		timerFieryMeteorCD:Start(32.7-delay, 1)
	end
	--Reset Fades
	timerFieryMeteorCD:SetFade(false, 1)
	timerMoltenEruptionCD:SetFade(false, 1)
	timerSwirlingFlameCD:SetFade(false, 1)
	timerFlameSlashCD:SetFade(false, 1)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	self:Schedule(2, updateBossDistance, self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	--Krozgoth Spells
	if spellId == 403459 then
		self.vb.coalescingCount = self.vb.coalescingCount + 1
		if nearKroz then
			specWarnCoalescingVoid:Show(self.vb.coalescingCount)
			specWarnCoalescingVoid:Play("aesoon")
		end
		timerCoalescingVoidCD:Start(self:IsMythic() and 35.3 or 21.9, self.vb.coalescingCount+1)
	elseif spellId == 405016 then
		self.vb.umbralCount = 0
		self.vb.umbralIcon = 1
		--14.3, 43.8, 35.4
		timerUmbralDetonationCD:Start(self:IsMythic() and (self.vb.umbralCount == 1 and 43.8 or 35.3) or 21.9, self.vb.umbralCount+1)
	elseif spellId == 407640 then
		self.vb.shadowConvergeCount = self.vb.shadowConvergeCount + 1
		if nearKroz then
			specWarnShadowsConvergence:Show()
			specWarnShadowsConvergence:Play("watchstep")
		end
		--22.8, 42.7, 35.3
		timerShadowsConvergenceCD:Start(self:IsMythic() and (self.vb.shadowConvergeCount == 1 and 42.7 or 35.3) or 20.7, self.vb.shadowConvergeCount+1)
	elseif spellId == 403699 then
		self.vb.shadowStrikeCount = self.vb.shadowStrikeCount + 1
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		--9.5, 15.8, 15.8, 12.2, 15.8, 19.5, 15.8
		timerShadowSpikeCD:Start(self:IsMythic() and 12.2 or 20.7, self.vb.shadowStrikeCount+1)
	--Moltannia Spells
	elseif spellId == 404732 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		if nearMolt then
			specWarnFieryMeteor:Show(self.vb.meteorCast)
			specWarnFieryMeteor:Play("helpsoak")
		end
		timerFieryMeteorCD:Start(self:IsMythic() and 35.3 or 31.7, self.vb.meteorCast+1)
	elseif spellId == 403101 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		if nearMolt then
			specWarnMoltenEruption:Show(self.vb.moltenEruptionCast)
			specWarnMoltenEruption:Play("helpsoak")
		end
		--16.7, 42.6, 35.4
		timerMoltenEruptionCD:Start(self:IsMythic() and (self.vb.moltenEruptionCast == 1 and 41.5 or 35.3) or 31.7, self.vb.moltenEruptionCast+1)
	elseif spellId == 404896 then
		self.vb.swirlingCount = self.vb.swirlingCount + 1
		if nearMolt then
			specWarnSwirlingFlame:Show()
			specWarnSwirlingFlame:Play("watchwave")
		end
		local timer = 20.7--Heroic timer, TODO, see if it's still this way
		if self:IsMythic() then
			--10.7, 14.6, 28.0, 14.6, 20.7, 14.6
			timer = self.vb.swirlingCount == 2 and 27 or (self.vb.swirlingCount % 2 == 0 and 20.7 or 14.6)
		end
		timerSwirlingFlameCD:Start(timer, self.vb.swirlingCount+1)
	elseif spellId == 403203 then
		self.vb.flameSlashCast = self.vb.flameSlashCast + 1
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		local timer = 11--Heroic timer, TODO, see if it's still this way
		if self:IsMythic() then
			--7.0, 15.7, 26.8, 15.9, 19.5, 15.8
			timer = self.vb.flameSlashCast == 2 and 26.8 or (self.vb.flameSlashCast % 2 == 0 and 19.5 or 15.8)
		end
		timerFlameSlashCD:Start(timer, self.vb.flameSlashCast+1)
	--Molgoth
	elseif spellId == 405437 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		specWarnGloomConflag:Show(self.vb.meteorCast)
		specWarnGloomConflag:Play("helpsoak")
		timerGloomConflagCD:Start(self:IsMythic() and 47.4 or 40, self.vb.meteorCast+1)
	elseif spellId == 405641 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		self.vb.umbralIcon = 1
		timerBlisteringTwilightCD:Start(self:IsMythic() and 47.4 or 40, self.vb.umbralCount+1)
	elseif spellId == 408193 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		specWarnConvergentEruption:Show()
		specWarnConvergentEruption:Play("helpsoak")
		timerConvergentEruptionCD:Start(self:IsMythic() and 47.4 or 40, self.vb.moltenEruptionCast+1)
	elseif spellId == 405914 then
		self.vb.witheringVulnCount = self.vb.witheringVulnCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnWitheringVulnerability:Show()
			specWarnWitheringVulnerability:Play("defensive")
		end
		if self:IsMythic() then
			timerWitheringVulnerabilityCD:Start(23.1, self.vb.witheringVulnCount+1)
		else
			--Likely a clearer explanation for this later like a spell queue that delays it later fight
			if self.vb.witheringVulnCount >= 5 then
				timerWitheringVulnerabilityCD:Start(40, self.vb.witheringVulnCount+1)
			else
				timerWitheringVulnerabilityCD:Start(35, self.vb.witheringVulnCount+1)
			end
		end
	elseif spellId == 406783 then
		self.vb.shadowflameBurstCount = self.vb.shadowflameBurstCount + 1
		warnShadowflameBurst:Show(self.vb.shadowflameBurstCount)
		if self:IsMythic() then
			timerShadowflameBurstCD:Start(23.1, self.vb.shadowflameBurstCount+1)
		else
			if self.vb.shadowflameBurstCount >= 5 then
				timerShadowflameBurstCD:Start(40, self.vb.shadowflameBurstCount+1)
			else
				timerShadowflameBurstCD:Start(35, self.vb.shadowflameBurstCount+1)
			end
		end
	elseif spellId == 409385 then
		self.vb.SandFCount = self.vb.SandFCount + 1
		warnShadowandFlame:Show(self.vb.SandFCount)
		timerShadowandFlameCD:Start(nil, self.vb.SandFCount+1)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 406730 and self.vb.phase == 1 then--Crucible Instability
		self:SetStage(2)
		self.vb.bossLeft = self.vb.bossLeft - 2--Stage 1 bosses don't actually die, they fuse. This just updates mods internal count
		self.vb.meteorCast = 0--Reused for Gloom Conflagration
		self.vb.umbralCount = 0--Reused for Blistering Twilight
		self.vb.moltenEruptionCast = 0--Reused for Converging Eruption
		self.vb.witheringVulnCount = 0
		self.vb.shadowflameBurstCount = 0
		self:Unschedule(updateBossDistance)
		timerCoalescingVoidCD:Stop()
		timerUmbralDetonationCD:Stop()
		timerShadowsConvergenceCD:Stop()
		timerShadowSpikeCD:Stop()
		timerFieryMeteorCD:Stop()
		timerMoltenEruptionCD:Stop()
		timerSwirlingFlameCD:Stop()
		timerFlameSlashCD:Stop()
		timerWitheringVulnerabilityCD:Start(17.3, 1)
		timerShadowflameBurstCD:Start(19.4, 1)
		timerBlisteringTwilightCD:Start(22.2, 1)
		timerGloomConflagCD:Start(self:IsMythic() and 50 or 31.9, 1)
		timerConvergentEruptionCD:Start(self:IsMythic() and 35.8 or 46.5, 1)
		if self:IsMythic() then
			timerShadowandFlameCD:Start(29.6, 1)
		end
	elseif spellId == 409385 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 401809 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnCorruptingShadow:Show(amount)
		end
	elseif spellId == 402617 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnBlazingHeat:Show(amount)
		end
	elseif spellId == 405394 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount % 3 == 0) and amount >= 18 then--Adjust as needed
			warnShadowflame:Show(amount)
		end
	elseif spellId == 405036 then
		local icon = self.vb.umbralIcon
		if self.Options.SetIconOnUmbral then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnUmbralDetonation:Show()
			specWarnUmbralDetonation:Play("targetyou")
			yellUmbralDetonation:Yell()
			yellUmbralDetonationFades:Countdown(spellId)
		end
		if nearKroz then
			warnUmbralDetonation:CombinedShow(0.5, self.vb.umbralCount, args.destName)
		end
		self.vb.umbralIcon = self.vb.umbralIcon + 1
	elseif spellId == 405642 then
		local icon = self.vb.umbralIcon
		if self.Options.SetIconOnBlistering then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBlisteringTwilight:Show()
			specWarnBlisteringTwilight:Play("targetyou")
			yellBlisteringTwilight:Yell()
			yellBlisteringTwilightFades:Countdown(spellId)
		end
		if nearKroz then
			warnBlisteringTwilight:CombinedShow(0.5, self.vb.umbralCount, args.destName)
		end
		self.vb.umbralIcon = self.vb.umbralIcon + 1
	elseif spellId == 405914 and not args:IsPlayer() then
		specWarnWitheringVulnerabilityTaunt:Show(args.destName)
		specWarnWitheringVulnerabilityTaunt:Play("tauntboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 401809 and args:IsPlayer() then
		warnCorruptingShadowFades:Show()
	elseif spellId == 402617 and args:IsPlayer() then
		warnBlazingHeatFades:Show()
	elseif spellId == 405036 then
		if self.Options.SetIconOnUmbral then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellUmbralDetonationFades:Cancel()
		end
	elseif spellId == 405642 then
		if self.Options.SetIconOnBlistering then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBlisteringTwilightFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 405084 or spellId == 405645) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
