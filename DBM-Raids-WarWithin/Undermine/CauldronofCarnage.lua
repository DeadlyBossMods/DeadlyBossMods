if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2640, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(229181, 229177)
mod:SetEncounterID(3010)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473650 472233 1214190 473994 463840 466178",
	"SPELL_CAST_SUCCESS 465833 1213994",
	"SPELL_AURA_APPLIED 465872 465863 472222 472225 471660 471557 1213690 472231 1214009",
	"SPELL_AURA_APPLIED_DOSE 472222 472225 471557",
	"SPELL_AURA_REMOVED 465872 465863 471660 1213690 472231 1214009",
	"SPELL_PERIODIC_DAMAGE 1214039",
	"SPELL_PERIODIC_MISSED 1214039",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_POWER_UPDATE player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTE: Possibly use these two. https://www.wowhead.com/ptr-2/spell=473202/colossal-clash https://www.wowhead.com/ptr-2/spell=473201/colossal-clash
--TODO, finetune crash audio to match watch wave instead of it's more prominant than the lightning bolts
--TODO, do more with spite when we know swap stacks and other factors
--TODO, possible automarking for scrapbomb using https://www.wowhead.com/ptr-2/spell=1217753/scrapbomb if automarking is still possible in 11.1
--TODO, boss creatureIds are critical to completing the mods functionality
--TODO, see if https://www.wowhead.com/ptr-2/spell=1213688/molten-phlegm still exists or if only the 30 second non dispelable version remains
--TODO, auto set icons on blastburn if possible
--TODO, see if you can sidestep https://www.wowhead.com/ptr-2/spell=1214190/eruption-stomp if you are the target of it
--TODO, see if https://www.wowhead.com/ptr-2/spell=1218088/tempest-unleashed can be detected for timer purposes?
--TODO, infoframe for static charge alt power? figure out accuracy of how it works then also create personal alert if stacks too high
--TODO, any kind of marking for https://www.wowhead.com/ptr-2/spell=1213992/voltaic-image ?
--TODO, do timers rest when bosses fued in the middle?
--TODO, possible auto marking using spell summon event for toys using https://www.wowhead.com/ptr-2/spell=1215869/tiny-tussle https://www.wowhead.com/ptr-2/spell=471219/tiny-tussle and https://www.wowhead.com/ptr-2/spell=471218/tiny-tussle
--General
local warnTinyTussle								= mod:NewCountAnnounce(1221826, 3)
local warnKingofCarnage								= mod:NewCountAnnounce(471557, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(471557))--Boss

local specWarnColossalClash							= mod:NewSpecialWarningDodgeCount(465833, nil, nil, nil, 2, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1214039, nil, nil, nil, 1, 8)

local timerColossalClashCD							= mod:NewAITimer(97.3, 465833, nil, nil, nil, 6)
local timerTinyTussleCD								= mod:NewAITimer(97.3, 1221826, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddNamePlateOption("NPAuraOnRaisedGuard", 471660, true)
mod:AddBoolOption("AdvancedBossFiltering", true, "misc")--May be default to off on live, but for testing purposes it needs to be forced
--mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)
--Flarendo the Furious
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30339))
local warnBlisteringSpite							= mod:NewCountAnnounce(472222, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(472222))--Player
local warnBlastburnRoarcannon						= mod:NewTargetNoFilterAnnounce(472233, 4)

local specWarnScrapBomb								= mod:NewSpecialWarningSoakCount(473650, nil, nil, nil, 2, 2)
local specWarnMoltenPhlegm							= mod:NewSpecialWarningMoveAway(1213690, nil, nil, nil, 1, 2, 3)
local yellMoltenPhlegmFades							= mod:NewShortFadesYell(1213690)
local specWarnBlastburnRoarcannon					= mod:NewSpecialWarningMoveAway(472233, nil, nil, nil, 3, 2)
local yellBlastburnRoarcannon						= mod:NewShortYell(472233)
local yellBlastburnRoarcannonFades					= mod:NewShortFadesYell(472233)
local specWarnEruptionStomp							= mod:NewSpecialWarningDodgeCount(1214190, nil, nil, nil, 1, 2)

local timerScrapBombCD								= mod:NewAITimer(97.3, 473650, nil, nil, nil, 3)
local timerBlastburnRoarcannonCD					= mod:NewAITimer(97.3, 472233, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerEruptionStompCD							= mod:NewAITimer(97.3, 1214190, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Torq the Tempest
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30344))
local warnGalvanizedSpite							= mod:NewCountAnnounce(472225, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(472225))--Player
local warnVoltaicImage								= mod:NewTargetNoFilterAnnounce(1213994, 3)

local specWarnStaticChargeHigh						= mod:NewSpecialWarningStack(473994, nil, 75, nil, nil, 1, 6)
local yellStaticChargeHigh							= mod:NewIconRepeatYell(473994, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnThundderdrumSalvo						= mod:NewSpecialWarningDodgeCount(463840, nil, nil, nil, 2, 2)
local specWarnVoltaicImage							= mod:NewSpecialWarningRun(1213994, nil, nil, nil, 4, 2)
local specWarnLightningBash							= mod:NewSpecialWarningDefensive(466178, nil, nil, nil, 1, 2)

local timerStaticChargeCD							= mod:NewAITimer(97.3, 473994, nil, nil, nil, 3)
local timerThunderdrumSalvoCD						= mod:NewAITimer(97.3, 463840, nil, nil, nil, 3)
local timerVoltaicImageCD							= mod:NewAITimer(97.3, 1213994, nil, nil, nil, 3)
local timerLightningBashCD							= mod:NewAITimer(97.3, 466178, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddInfoFrameOption(473994, true)
mod:AddNamePlateOption("NPFixate", 1213994, true)

local nearTorq, nearFlare = true, true
local lastCharge = 0
mod.vb.crashCount = 0
mod.vb.tussleCount = 0
--Flarendo the Furious
mod.vb.scrapbombCount = 0
mod.vb.cannonCount = 0
mod.vb.stompCount = 0
--Torq the Tempest
mod.vb.staticChargeCount = 0
mod.vb.salvoCount = 0
mod.vb.imagesCount = 0
mod.vb.bashCount = 0

--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
---@param self DBMMod
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Torq
	if self:CheckBossDistance(229177, true, 32825, 60) then
		if not nearTorq then
			nearTorq = true
			timerScrapBombCD:SetFade(false)--, self.vb.scrapbombCount+1
			timerBlastburnRoarcannonCD:SetFade(false)--, self.vb.cannonCount+1
			timerEruptionStompCD:SetFade(false)--, self.vb.stompCount+1
		end
	else
		if nearTorq then
			nearTorq = false
			timerScrapBombCD:SetFade(true)--, self.vb.scrapbombCount+1
			timerBlastburnRoarcannonCD:SetFade(true)--, self.vb.cannonCount+1
			timerEruptionStompCD:SetFade(true)--, self.vb.stompCount+1
		end
	end
	--Check if near or far from Flarendo
	if self:CheckBossDistance(229181, true, 32825, 60) then
		if not nearFlare then
			nearFlare = true
			timerStaticChargeCD:SetFade(false)--, self.vb.staticChargeCount+1
			timerThunderdrumSalvoCD:SetFade(false)--, self.vb.salvoCount+1
			timerVoltaicImageCD:SetFade(false)--, self.vb.imagesCount+1
			timerLightningBashCD:SetFade(false)--, self.vb.bashCount+1
		end
	else
		if nearFlare then
			nearFlare = false
			timerStaticChargeCD:SetFade(true)--, self.vb.staticChargeCount+1
			timerThunderdrumSalvoCD:SetFade(true)--, self.vb.salvoCount+1
			timerVoltaicImageCD:SetFade(true)--, self.vb.imagesCount+1
			timerLightningBashCD:SetFade(true)--, self.vb.bashCount+1
		end
	end
	self:Schedule(2, updateBossDistance, self)
end

function mod:OnCombatStart(delay)
	nearTorq, nearFlare = true, true
	lastCharge = 0
	self.vb.crashCount = 0
	self.vb.tussleCount = 0
	self.vb.scrapbombCount = 0
	self.vb.cannonCount = 0
	self.vb.stompCount = 0
	self.vb.staticChargeCount = 0
	self.vb.salvoCount = 0
	self.vb.imagesCount = 0
	self.vb.bashCount = 0
	timerColossalClashCD:Start(1-delay)
	if self:IsMythic() then
		timerTinyTussleCD:Start(1-delay)
	end
	--Flarendo the Furious
	timerScrapBombCD:Start(1-delay)
	timerBlastburnRoarcannonCD:Start(1-delay)
	timerEruptionStompCD:Start(1-delay)
	--Torq the Tempest
	timerStaticChargeCD:Start(1-delay)
	timerThunderdrumSalvoCD:Start(1-delay)
	timerVoltaicImageCD:Start(1-delay)
	timerLightningBashCD:Start(1-delay)
	if self.Options.NPAuraOnRaisedGuard or self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("The Amalgamation Chamber was merely a setback")
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	self:Schedule(2, updateBossDistance, self)
	--Reset Fades
	timerScrapBombCD:SetFade(false)--, 1
	timerBlastburnRoarcannonCD:SetFade(false)--, 1
	timerEruptionStompCD:SetFade(false)--, 1
	timerStaticChargeCD:SetFade(false)--, 1
	timerThunderdrumSalvoCD:SetFade(false)--, 1
	timerVoltaicImageCD:SetFade(false)--, 1
	timerLightningBashCD:SetFade(false)--, 1
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellName(473994))
		DBM.InfoFrame:Show(8, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, 1)--Sorting highest to lowest
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnRaisedGuard or self.Options.NPFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 473650 then
		self.vb.scrapbombCount = self.vb.scrapbombCount + 1
		if nearFlare then
			specWarnScrapBomb:Show(self.vb.scrapbombCount)
			specWarnScrapBomb:Play("helpsoak")
		end
		timerScrapBombCD:Start()--97.3, self.vb.scrapbombCount+1
	elseif spellId == 472233 then
		self.vb.cannonCount = self.vb.cannonCount + 1
		timerBlastburnRoarcannonCD:Start()--97.3, self.vb.cannonCount+1
	elseif spellId == 1214190 then
		self.vb.stompCount = self.vb.stompCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEruptionStomp:Show(self.vb.stompCount)
			specWarnEruptionStomp:Play("watchstep")
		end
		timerEruptionStompCD:Start()--97.3, self.vb.stompCount+1
	elseif spellId == 473994 then
		self.vb.staticChargeCount = self.vb.staticChargeCount + 1
		timerStaticChargeCD:Start()--97.3, self.vb.staticChargeCount+1
	elseif spellId == 463840 then
		self.vb.salvoCount = self.vb.salvoCount + 1
		if nearTorq then
			specWarnThundderdrumSalvo:Show(self.vb.salvoCount)
			specWarnThundderdrumSalvo:Play("watchstep")
		end
		timerThunderdrumSalvoCD:Start()--97.3, self.vb.salvoCount+1
	elseif spellId == 466178 then
		self.vb.bashCount = self.vb.bashCount + 1
		timerLightningBashCD:Start()--97.3, self.vb.bashCount+1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnLightningBash:Show()
			specWarnLightningBash:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 465833 and self:AntiSpam(10, 1) then
		self.vb.crashCount = self.vb.crashCount + 1
		specWarnColossalClash:Show(self.vb.crashCount)
		specWarnColossalClash:Play("watchstep")
		timerColossalClashCD:Start()--97.3, self.vb.crashCount+1
		--Stop all timers
		--Flarendo the Furious
		timerTinyTussleCD:Stop()
		timerScrapBombCD:Stop()
		timerBlastburnRoarcannonCD:Stop()
		--Torq the Tempest
		timerEruptionStompCD:Stop()
		timerStaticChargeCD:Stop()
		timerThunderdrumSalvoCD:Stop()
		timerVoltaicImageCD:Stop()
		timerLightningBashCD:Stop()
--	elseif spellId == 472039 and self:AntiSpam(5, 2) then
--		self.vb.tussleCount = self.vb.tussleCount + 1
--		warnTinyTussle:Show(self.vb.tussleCount)
--		timerTinyTussleCD:Start()--97.3, self.vb.tussleCount+1
	elseif spellId == 1213994 then
		self.vb.imagesCount = self.vb.imagesCount + 1
		timerVoltaicImageCD:Start()--97.3, self.vb.imagesCount+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 465872 or spellId == 465863) and self:AntiSpam(10, 1) then--Torq Zaps / Flarendo Waves
		self.vb.crashCount = self.vb.crashCount + 1
		specWarnColossalClash:Show(self.vb.crashCount)
		specWarnColossalClash:Play("watchstep")
		timerColossalClashCD:Start()--97.3, self.vb.crashCount+1
		--Stop all timers
		--Flarendo the Furious
		timerTinyTussleCD:Stop()
		timerScrapBombCD:Stop()
		timerBlastburnRoarcannonCD:Stop()
		--Torq the Tempest
		timerEruptionStompCD:Stop()
		timerStaticChargeCD:Stop()
		timerThunderdrumSalvoCD:Stop()
		timerVoltaicImageCD:Stop()
		timerLightningBashCD:Stop()
	elseif spellId == 472222 and args:IsPlayer() then--Blistering
		local amount = args.amount or 1
		if (amount >= 4) and amount % 2 == 0 then
			warnBlisteringSpite:Show(amount)
		end
	elseif spellId == 472225 and args:IsPlayer() then--Galvanized
		local amount = args.amount or 1
		if (amount >= 4) and amount % 2 == 0 then
			warnGalvanizedSpite:Show(amount)
		end
	elseif spellId == 471660 then
		if self.Options.NPAuraOnRaisedGuard then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 471557 then
		warnKingofCarnage:Show(args.amount or 1)
	elseif spellId == 1213690 and args:IsPlayer() then
		specWarnMoltenPhlegm:Schedule(25)
		specWarnMoltenPhlegm:ScheduleVoice(25, "runout")
		yellMoltenPhlegmFades:Countdown(spellId)
	elseif spellId == 472231 then
		warnBlastburnRoarcannon:PreciseShow(self:IsMythic() and 3 or 1, args.destName)
		if args:IsPlayer() then
			specWarnBlastburnRoarcannon:Show()
			specWarnBlastburnRoarcannon:Play("runout")
			yellBlastburnRoarcannon:Yell()
			yellBlastburnRoarcannonFades:Countdown(spellId)
		end
	elseif spellId == 1214009 then
		warnVoltaicImage:PreciseShow(3, args.destName)
		if args:IsPlayer() then
			specWarnVoltaicImage:Show()
			specWarnVoltaicImage:Play("justrun")
			if self.Options.NPFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, nil, nil, true)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 465872 or spellId == 465863 then--Torq Zaps / Flarendo Waves
		--Restart all timers
		--Flarendo the Furious
		timerTinyTussleCD:Start(2)
		timerScrapBombCD:Start(2)
		timerBlastburnRoarcannonCD:Start(2)
		--Torq the Tempest
		timerEruptionStompCD:Start(2)
		timerStaticChargeCD:Start(2)
		timerThunderdrumSalvoCD:Start(2)
		timerVoltaicImageCD:Start(2)
		timerLightningBashCD:Start(2)
	elseif spellId == 471660 then
		if self.Options.NPAuraOnRaisedGuard then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 1213690 and args:IsPlayer() then
		specWarnMoltenPhlegm:Cancel()
		specWarnMoltenPhlegm:CancelVoice()
		yellMoltenPhlegmFades:Cancel()
	elseif spellId == 472231 then
		if args:IsPlayer() then
			yellBlastburnRoarcannonFades:Cancel()
		end
	elseif spellId == 1214009 then
		if args:IsPlayer() then
			if self.Options.NPFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1214039 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_POWER_UPDATE(uId)
	local currentCharge = UnitPower(uId, ALTERNATE_POWER_INDEX)
	--if current power lower than last power, update tracking
	if currentCharge < lastCharge then
		lastCharge = currentCharge
		return
	end
	if self:AntiSpam(2, 4) then
		if currentCharge >= 90 and lastCharge < 90 then
			lastCharge = 90
			specWarnStaticChargeHigh:Show(lastCharge)
			specWarnStaticChargeHigh:Play("stackhigh")
			yellStaticChargeHigh:Yell(lastCharge)
		elseif currentCharge >= 80 and lastCharge < 80 then
			lastCharge = 80
			yellStaticChargeHigh:Yell(lastCharge)
		elseif currentCharge >= 70 and lastCharge < 70 then
			lastCharge = 70
			specWarnStaticChargeHigh:Show(lastCharge)
			specWarnStaticChargeHigh:Play("stackhigh")
			yellStaticChargeHigh:Yell(lastCharge)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 1215933 and self:AntiSpam(5, 2) then
		self.vb.tussleCount = self.vb.tussleCount + 1
		warnTinyTussle:Show(self.vb.tussleCount)
		timerTinyTussleCD:Start()--97.3, self.vb.tussleCount+1
	end
end

