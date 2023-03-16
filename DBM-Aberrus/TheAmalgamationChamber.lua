local mod	= DBM:NewMod(2529, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(201774, 201773, 201934)--Krozgoth, Moltannia, Molgoth
mod:SetEncounterID(2687)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230315000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 403459 405016 407640 403699 404732 403101 404896 405437 405641 408193 405914 406783",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 401809 402617 405036 405394 406780 405642",
	"SPELL_AURA_APPLIED_DOSE 401809 402617 405394",
	"SPELL_AURA_REMOVED 401809 402617 405036 405642",
	"SPELL_PERIODIC_DAMAGE 405084 405645",
	"SPELL_PERIODIC_MISSED 405084 405645"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, the concensus on good swap timing, maybe based off tank stacks or maybe after a certain boss spell that's a great time to criss cross bosses
--TODO, how often are shadow spike and Flame Slash cast? they don't seem damage heavy frontloaded so I have a feeling they are cast often/spammed even
--TODO, meteor target? have a yell if target scan or emote exist for it?
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
local specWarnUmbralDetonation					= mod:NewSpecialWarningYouPos(405016, nil, nil, nil, 1, 2)
local yellUmbralDetonation						= mod:NewShortPosYell(405016)
local yellUmbralDetonationFades					= mod:NewIconFadesYell(405016)
local specWarnShadowsConvergence				= mod:NewSpecialWarningDodgeCount(407640, nil, nil, nil, 2, 2)
--local specWarnPyroBlast							= mod:NewSpecialWarningInterrupt(396040, "HasInterrupt", nil, nil, 1, 2)

local timerCoalescingVoidCD						= mod:NewAITimer(29.9, 403459, nil, nil, nil, 2)
local timerUmbralDetonationCD					= mod:NewAITimer(29.9, 405016, nil, nil, nil, 3)
local timerShadowsConvergenceCD					= mod:NewAITimer(29.9, 407640, nil, nil, nil, 3)
local timerShadowSpikeCD						= mod:NewAITimer(28.9, 403699, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(361651, true)
--mod:AddRangeFrameOption(5, 390715)
mod:AddSetIconOption("SetIconOnUmbral", 405016, true, 0, {1, 2, 3})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--mod:GroupSpells(390715, 396094)
--Moltannia
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26337))
local warnBlazingHeat							= mod:NewCountAnnounce(402617, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(401809))
local warnBlazingHeatFades						= mod:NewFadesAnnounce(402617, 1)

local specWarnFieryMeteor						= mod:NewSpecialWarningCount(404732, nil, nil, nil, 2, 2)
local yellFieryMeteor							= mod:NewShortYell(404732, nil, nil, nil, "YELL")
local yellFieryMeteorFades						= mod:NewShortFadesYell(404732, nil, nil, nil, "YELL")
local specWarnMoltenEruption					= mod:NewSpecialWarningCount(403101, nil, nil, nil, 2, 2)
local specWarnSwirlingFlame						= mod:NewSpecialWarningDodgeCount(404896, nil, nil, nil, 2, 2)

local timerFieryMeteorCD						= mod:NewAITimer(29.9, 404732, nil, nil, nil, 3)
local timerMoltenEruptionCD						= mod:NewAITimer(29.9, 403101, nil, nil, nil, 5)
local timerSwirlingFlameCD						= mod:NewAITimer(29.9, 404896, nil, nil, nil, 3)
local timerFlameSlashCD							= mod:NewAITimer(28.9, 403203, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Molgoth
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26338))
local warnShadowflame							= mod:NewCountAnnounce(405394, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(405394))
local warnBlisteringTwilight					= mod:NewTargetCountAnnounce(405641, 3, nil, nil, nil, nil, nil, nil, true)
local warnShadowflameBurst						= mod:NewCastAnnounce(406783, 3)

local specWarnGloomConflag						= mod:NewSpecialWarningCount(405437, nil, nil, nil, 2, 2)
local yellGloomConflag							= mod:NewShortYell(405437, nil, nil, nil, "YELL")
local yellGloomConflagFades						= mod:NewShortFadesYell(405437, nil, nil, nil, "YELL")
local specWarnBlisteringTwilight				= mod:NewSpecialWarningYouPos(405641, nil, nil, nil, 1, 2)
local yellBlisteringTwilight					= mod:NewShortPosYell(405641)
local yellBlisteringTwilightFades				= mod:NewIconFadesYell(405641)
local specWarnConvergentEruption				= mod:NewSpecialWarningCount(408193, nil, nil, nil, 2, 2)
local specWarnCrushingVulnerability				= mod:NewSpecialWarningDefensive(405914, nil, nil, nil, 1, 2)
local specWarnCrushingVulnerabilityTaunt		= mod:NewSpecialWarningTaunt(405914, nil, nil, nil, 1, 2)

local timerGloomConflagCD						= mod:NewAITimer(29.9, 405437, nil, nil, nil, 3)
local timerBlisteringTwilightCD					= mod:NewAITimer(29.9, 405641, nil, nil, nil, 3)
local timerConvergentEruptionCD					= mod:NewAITimer(29.9, 408193, nil, nil, nil, 5)
local timerCrushingVulnerabilityCD				= mod:NewAITimer(28.9, 405914, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShadowflameBurstCD					= mod:NewAITimer(28.9, 406783, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Might be redundant if always after crushing

mod:AddSetIconOption("SetIconOnBlistering", 405641, true, 0, {1, 2, 3, 4})

local nearKroz, nearMolt = true, true
mod.vb.coalescingCount = 0
mod.vb.umbralCount = 0
mod.vb.umbralIcon = 1
mod.vb.shadowConvergeCount = 0

mod.vb.meteorCast = 0
mod.vb.moltenEruptionCast = 0



--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Krozgoth
	if self:CheckBossDistance(201774, true, 32698, 48) then
		if not nearKroz then
			nearKroz = true
			timerCoalescingVoidCD:SetFade(false)
			timerUmbralDetonationCD:SetFade(false)
			timerShadowsConvergenceCD:SetFade(false)
			timerShadowSpikeCD:SetFade(false)
		end
	else
		if nearKroz then
			nearKroz = false
			timerCoalescingVoidCD:SetFade(true)
			timerUmbralDetonationCD:SetFade(true)
			timerShadowsConvergenceCD:SetFade(true)
			timerShadowSpikeCD:SetFade(true)
		end
	end
	--Check if near or far from Moltannia
	if self:CheckBossDistance(201773, true, 32698, 48) then
		if not nearMolt then
			nearMolt = true
			timerFieryMeteorCD:SetFade(false)
			timerMoltenEruptionCD:SetFade(false)
			timerSwirlingFlameCD:SetFade(false)
			timerFlameSlashCD:SetFade(false)
		end
	else
		if nearMolt then
			nearMolt = false
			timerFieryMeteorCD:SetFade(true)
			timerMoltenEruptionCD:SetFade(true)
			timerSwirlingFlameCD:SetFade(true)
			timerFlameSlashCD:SetFade(true)
		end
	end
	self:Schedule(2, updateBossDistance, self)
end

function mod:MeteorTarget(targetname, _, _, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellFieryMeteor:Yell()
		yellFieryMeteorFades:Countdown(5-scanningTime)
	end
end

function mod:GloomTarget(targetname, _, _, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellGloomConflag:Yell()
		yellGloomConflagFades:Countdown(5-scanningTime)
	end
end

function mod:OnCombatStart(delay)
	nearKroz, nearMolt = true, true
	self:SetStage(1)
	--Krozgoth
	self.vb.coalescingCount = 0
	self.vb.umbralCount = 0
	self.vb.umbralIcon = 1
	self.vb.shadowConvergeCount = 0
	timerCoalescingVoidCD:Start(1-delay)
	timerUmbralDetonationCD:Start(1-delay)
	timerShadowsConvergenceCD:Start(1-delay)
	timerShadowSpikeCD:Start(1-delay)
	--Reset Fades
	timerCoalescingVoidCD:SetFade(false)
	timerUmbralDetonationCD:SetFade(false)
	timerShadowsConvergenceCD:SetFade(false)
	timerShadowSpikeCD:SetFade(false)
	--Moltannia
	self.vb.meteorCast = 0
	self.vb.moltenEruptionCast = 0
	timerFieryMeteorCD:Start(1-delay)
	timerMoltenEruptionCD:Start(1-delay)
	timerSwirlingFlameCD:Start(1-delay)
	timerFlameSlashCD:Start(1-delay)
	--Reset Fades
	timerFieryMeteorCD:SetFade(false)
	timerMoltenEruptionCD:SetFade(false)
	timerSwirlingFlameCD:SetFade(false)
	timerFlameSlashCD:SetFade(false)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	self:Schedule(2, updateBossDistance, self)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
--end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	--Krozgoth Spells
	if spellId == 403459 then
		self.vb.coalescingCount = self.vb.coalescingCount + 1
		if nearKroz then
			specWarnCoalescingVoid:Show(self.vb.coalescingCount)
			specWarnCoalescingVoid:Play("aesoon")
		end
		timerCoalescingVoidCD:Start()
	elseif spellId == 405016 then
		self.vb.umbralCount = 0
		self.vb.umbralIcon = 1
		timerUmbralDetonationCD:Start()
	elseif spellId == 407640 then
		self.vb.shadowConvergeCount = self.vb.shadowConvergeCount + 1
		if nearKroz then
			specWarnShadowsConvergence:Show()
			specWarnShadowsConvergence:Play("watchstep")
		end
		timerShadowsConvergenceCD:Start()
	elseif spellId == 403699 then
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		timerShadowSpikeCD:Start()
	--Moltannia Spells
	elseif spellId == 404732 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		if nearMolt then
			specWarnFieryMeteor:Show(self.vb.meteorCast)
			specWarnFieryMeteor:Play("helpsoak")
		end
		timerFieryMeteorCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "MeteorTarget", 0.2, 8, true, nil, nil, nil, true)--Filter tank for now, that way we omit bad target scanning in PTR since if it doesn't work it'll always report tank
	elseif spellId == 403101 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		if nearMolt then
			specWarnMoltenEruption:Show(self.vb.moltenEruptionCast)
			specWarnMoltenEruption:Play("helpsoak")
		end
		timerMoltenEruptionCD:Start()
	elseif spellId == 404896 then
		if nearMolt then
			specWarnSwirlingFlame:Show()
			specWarnSwirlingFlame:Play("watchwave")
		end
		timerSwirlingFlameCD:Start()
	elseif spellId == 403203 then
		--if self:IsTanking("player", nil, nil, true, args.sourceGUID) then

		--end
		timerFlameSlashCD:Start()
	--Molgoth
	elseif spellId == 405437 then
		self.vb.meteorCast = self.vb.meteorCast + 1
		specWarnGloomConflag:Show(self.vb.meteorCast)
		specWarnGloomConflag:Play("helpsoak")
		timerGloomConflagCD:Start()
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "GloomTarget", 0.2, 8, true, nil, nil, nil, true)--Filter tank for now, that way we omit bad target scanning in PTR since if it doesn't work it'll always report tank
	elseif spellId == 405641 then
		self.vb.umbralCount = self.vb.umbralCount + 1
		self.vb.umbralIcon = 1
		timerBlisteringTwilightCD:Start()
	elseif spellId == 408193 then
		self.vb.moltenEruptionCast = self.vb.moltenEruptionCast + 1
		specWarnConvergentEruption:Show()
		specWarnConvergentEruption:Play("helpsoak")
		timerConvergentEruptionCD:Start()
	elseif spellId == 405914 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnCrushingVulnerability:Show()
			specWarnCrushingVulnerability:Play("defensive")
		end
		timerCrushingVulnerabilityCD:Start()
	elseif spellId == 406783 then
		warnShadowflameBurst:Show()
		timerShadowflameBurstCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 394917 then

	end
end
--]]

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
			specWarnUmbralDetonation:Show(self:IconNumToTexture(icon))
			specWarnUmbralDetonation:Play("mm"..icon)
			yellUmbralDetonation:Yell(icon, icon)
			yellUmbralDetonationFades:Countdown(spellId, nil, icon)
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
			specWarnBlisteringTwilight:Show(self:IconNumToTexture(icon))
			specWarnBlisteringTwilight:Play("mm"..icon)
			yellBlisteringTwilight:Yell(icon, icon)
			yellBlisteringTwilightFades:Countdown(spellId, nil, icon)
		end
		if nearKroz then
			warnBlisteringTwilight:CombinedShow(0.5, self.vb.umbralCount, args.destName)
		end
		self.vb.umbralIcon = self.vb.umbralIcon + 1
	elseif spellId == 405914 and not args:IsPlayer() then
		specWarnCrushingVulnerabilityTaunt:Show(args.destName)
		specWarnCrushingVulnerabilityTaunt:Play("tauntboss")
	elseif spellId == 406780 and self.vb.phase == 1 then--Shadowflame on boss (Assumed)
		self:SetStage(2)
		self.vb.meteorCast = 0--Reused for Gloom Conflagration
		self.vb.umbralCount = 0--Reused for Blistering Twilight
		self.vb.moltenEruptionCast = 0--Reused for Converging Eruption
		self:Unschedule(updateBossDistance)
		timerCoalescingVoidCD:Stop()
		timerUmbralDetonationCD:Stop()
		timerShadowsConvergenceCD:Stop()
		timerShadowSpikeCD:Stop()
		timerFieryMeteorCD:Stop()
		timerMoltenEruptionCD:Stop()
		timerSwirlingFlameCD:Stop()
		timerFlameSlashCD:Stop()
		timerGloomConflagCD:Start(2)
		timerBlisteringTwilightCD:Start(2)
		timerConvergentEruptionCD:Start(2)
		timerCrushingVulnerabilityCD:Start(2)
		timerShadowflameBurstCD:Start(2)
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

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 201774 then--Krozgoth

	elseif cid == 201773 then--Moltannia

	elseif cid == 201934 then--Molgoth

	end
end
--]]

--function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	if spellId == 396734 then
--
--	end
--end
