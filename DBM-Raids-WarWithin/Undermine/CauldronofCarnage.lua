if DBM:GetTOC() < 110100 then return end
local mod	= DBM:NewMod(2640, "DBM-Raids-WarWithin", 1, 1296)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(229181, 229177)
mod:SetEncounterID(3010)
mod:SetHotfixNoticeRev(20250123000000)
mod:SetMinSyncRevision(20250123000000)
mod:SetZone(2769)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 473650 472233 1214190 473994 466178",
	"SPELL_CAST_SUCCESS 463900",
	"SPELL_AURA_APPLIED 472222 472225 471660 471557 1213690 472231 1214009",
	"SPELL_AURA_APPLIED_DOSE 472222 472225 471557",
	"SPELL_AURA_REMOVED 471660 1213690 472231 1214009",
	"SPELL_PERIODIC_DAMAGE 1214039 463925",
	"SPELL_PERIODIC_MISSED 1214039 463925",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UNIT_POWER_UPDATE player",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, finetune crash audio to match watch wave instead of it's more prominant than the lightning bolts
--TODO, do more with spite when we know swap stacks and other factors
--TODO, possible automarking for scrapbomb using https://www.wowhead.com/ptr-2/spell=1217753/scrapbomb if automarking is still possible in 11.1
--TODO, see if https://www.wowhead.com/ptr-2/spell=1213688/molten-phlegm still exists or if only the 30 second non dispelable version remains
--TODO, auto set icons on blastburn if possible
--TODO, see if you can sidestep https://www.wowhead.com/ptr-2/spell=1214190/eruption-stomp if you are the target of it
--TODO, see if https://www.wowhead.com/ptr-2/spell=1218088/tempest-unleashed can be detected for timer purposes?
--TODO, infoframe for static charge alt power? figure out accuracy of how it works then also create personal alert if stacks too high
--TODO, any kind of marking for https://www.wowhead.com/ptr-2/spell=1213992/voltaic-image ?
--TODO, possible auto marking using spell summon event for toys using https://www.wowhead.com/ptr-2/spell=1215869/tiny-tussle https://www.wowhead.com/ptr-2/spell=471219/tiny-tussle and https://www.wowhead.com/ptr-2/spell=471218/tiny-tussle
--General
local warnTinyTussle								= mod:NewCountAnnounce(1221826, 3)
local warnKingofCarnage								= mod:NewCountAnnounce(471557, 4, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(471557))--Boss

local specWarnColossalClash							= mod:NewSpecialWarningDodgeCount(465833, nil, nil, nil, 2, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1214039, nil, nil, nil, 1, 8)

local timerColossalClashCD							= mod:NewCDCountTimer(95, 465833, nil, nil, nil, 6)
local timerTinyTussleCD								= mod:NewAITimer(95, 1221826, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)

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

local timerScrapBombCD								= mod:NewCDCountTimer(97.3, 473650, nil, nil, nil, 3)
local timerBlastburnRoarcannonCD					= mod:NewCDCountTimer(97.3, 472233, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerEruptionStompCD							= mod:NewCDCountTimer(97.3, 1214190, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Torq the Tempest
mod:AddTimerLine(DBM:EJ_GetSectionInfo(30344))
local warnGalvanizedSpite							= mod:NewCountAnnounce(472225, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(472225))--Player
local warnVoltaicImage								= mod:NewTargetNoFilterAnnounce(1213994, 3)

local specWarnStaticChargeHigh						= mod:NewSpecialWarningStack(473994, nil, 75, nil, nil, 1, 6)
local yellStaticChargeHigh							= mod:NewIconRepeatYell(473994, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)
local specWarnThundderdrumSalvo						= mod:NewSpecialWarningDodgeCount(463840, nil, nil, nil, 2, 2)
local specWarnVoltaicImage							= mod:NewSpecialWarningRun(1213994, nil, nil, nil, 4, 2)
local specWarnLightningBash							= mod:NewSpecialWarningDefensive(466178, nil, nil, nil, 1, 2)

local timerStaticChargeCD							= mod:NewCDCountTimer(97.3, 473994, nil, nil, nil, 3)
local timerThunderdrumSalvoCD						= mod:NewCDCountTimer(97.3, 463840, nil, nil, nil, 3)
local timerVoltaicImageCD							= mod:NewCDCountTimer(97.3, 1213994, nil, nil, nil, 3)
local timerLightningBashCD							= mod:NewCDCountTimer(97.3, 466178, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

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
mod.vb.crashGone = false

--As computational as this looks, it's purpose is to just filter information overload.
--Basically, it solves for what should or shouldn't be shown, not what a player should or shouldn't do.
---@param self DBMMod
local function updateBossDistance(self)
	if not self.Options.AdvancedBossFiltering then return end
	--Check if near or far from Torq
	if self:CheckBossDistance(229177, true, 32825, 60) then
		if not nearTorq then
			nearTorq = true
			timerScrapBombCD:SetFade(false, self.vb.scrapbombCount+1)
			timerBlastburnRoarcannonCD:SetFade(false, self.vb.cannonCount+1)
			timerEruptionStompCD:SetFade(false, self.vb.stompCount+1)
		end
	else
		if nearTorq then
			nearTorq = false
			timerScrapBombCD:SetFade(true, self.vb.scrapbombCount+1)
			timerBlastburnRoarcannonCD:SetFade(true, self.vb.cannonCount+1)
			timerEruptionStompCD:SetFade(true, self.vb.stompCount+1)
		end
	end
	--Check if near or far from Flarendo
	if self:CheckBossDistance(229181, true, 32825, 60) then
		if not nearFlare then
			nearFlare = true
			timerStaticChargeCD:SetFade(false, self.vb.staticChargeCount+1)
			timerThunderdrumSalvoCD:SetFade(false, self.vb.salvoCount+1)
			timerVoltaicImageCD:SetFade(false, self.vb.imagesCount+1)
			timerLightningBashCD:SetFade(false, self.vb.bashCount+1)
		end
	else
		if nearFlare then
			nearFlare = false
			timerStaticChargeCD:SetFade(true, self.vb.staticChargeCount+1)
			timerThunderdrumSalvoCD:SetFade(true, self.vb.salvoCount+1)
			timerVoltaicImageCD:SetFade(true, self.vb.imagesCount+1)
			timerLightningBashCD:SetFade(true, self.vb.bashCount+1)
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
	self.vb.crashGone = false
	timerColossalClashCD:Start(71.6-delay, 1)
	if self:IsMythic() then
		timerTinyTussleCD:Start(1-delay)
	end
	--Flarendo the Furious
	timerScrapBombCD:Start(9-delay, 1)
	timerBlastburnRoarcannonCD:Start(15.1-delay, 1)
	timerEruptionStompCD:Start(27-delay, 1)
	--Torq the Tempest
	timerStaticChargeCD:Start(6.1-delay, 1)
	timerThunderdrumSalvoCD:Start(10-delay, 1)
	if self:IsHard() then
		timerVoltaicImageCD:Start(29-delay, 1)
	end
	timerLightningBashCD:Start(21-delay, 1)
	if self.Options.NPAuraOnRaisedGuard or self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("The Amalgamation Chamber was merely a setback")
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	self:Schedule(2, updateBossDistance, self)
	--Reset Fades
	timerScrapBombCD:SetFade(false, 1)
	timerBlastburnRoarcannonCD:SetFade(false, 1)
	timerEruptionStompCD:SetFade(false, 1)
	timerStaticChargeCD:SetFade(false, 1)
	timerThunderdrumSalvoCD:SetFade(false, 1)
	timerVoltaicImageCD:SetFade(false, 1)
	timerLightningBashCD:SetFade(false)--
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
		--pull:10.0, 30.0, 65.2, 29.9, 65.0, 30.0, 65.0, 30.0",
		if not self.vb.crashGone and self.vb.scrapbombCount % 2 == 0 then
			timerScrapBombCD:Start(65, self.vb.scrapbombCount+1)
		else
			timerScrapBombCD:Start(30, self.vb.scrapbombCount+1)
		end
	elseif spellId == 472233 then
		self.vb.cannonCount = self.vb.cannonCount + 1
		--pull:20.0, 30.0, 65.0, 30.0, 65.1, 30.0, 65.0, 30.0",
		if not self.vb.crashGone and self.vb.cannonCount % 2 == 0 then
			timerBlastburnRoarcannonCD:Start(65, self.vb.cannonCount+1)
		else
			timerBlastburnRoarcannonCD:Start(30, self.vb.cannonCount+1)
		end
	elseif spellId == 1214190 then
		self.vb.stompCount = self.vb.stompCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnEruptionStomp:Show(self.vb.stompCount)
			specWarnEruptionStomp:Play("watchstep")
		end
		--pull:30.0, 30.0, 65.1, 30.0, 65.0, 95.1, 30.0",
		if not self.vb.crashGone and self.vb.cannonCount % 2 == 0 then
			timerEruptionStompCD:Start(30, self.vb.stompCount+1)
		else
			timerEruptionStompCD:Start(65, self.vb.stompCount+1)
		end
	elseif spellId == 473994 then
		self.vb.staticChargeCount = self.vb.staticChargeCount + 1
		--pull:6.0, 95.0, 95.0, 95.1, 95.0",
		timerStaticChargeCD:Start(nil, self.vb.staticChargeCount+1)--95
	elseif spellId == 466178 then
		self.vb.bashCount = self.vb.bashCount + 1
		--pull:21.1, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0",
		if not self.vb.crashGone and self.vb.bashCount % 2 == 0 then
			timerLightningBashCD:Start(65, self.vb.bashCount+1)
		else
			timerLightningBashCD:Start(30, self.vb.bashCount+1)
		end
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnLightningBash:Show()
			specWarnLightningBash:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 463900 then
		self.vb.salvoCount = self.vb.salvoCount + 1
		if nearTorq then
			specWarnThundderdrumSalvo:Show(self.vb.salvoCount)
			specWarnThundderdrumSalvo:Play("watchstep")
		end
		--pull:20.0, 25.0, 70.0, 25.0, 70.1, 24.9, 70.1, 25.0",
		if not self.vb.crashGone and self.vb.salvoCount % 2 == 0 then
			timerThunderdrumSalvoCD:Start(70, self.vb.salvoCount+1)
		else
			timerThunderdrumSalvoCD:Start(25, self.vb.salvoCount+1)
		end
--	elseif spellId == 472039 and self:AntiSpam(5, 2) then
--		self.vb.tussleCount = self.vb.tussleCount + 1
--		warnTinyTussle:Show(self.vb.tussleCount)
--		timerTinyTussleCD:Start()--97.3, self.vb.tussleCount+1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 472222 and args:IsPlayer() then--Blistering
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
	if spellId == 471660 then
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
	if (spellId == 1214039 or spellId == 463925) and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 229181 then--Flarendo the Furious
		self.vb.crashGone = true
		timerStaticChargeCD:Stop()
		timerThunderdrumSalvoCD:Stop()
		timerVoltaicImageCD:Stop()
		timerLightningBashCD:Stop()
	elseif cid == 229177 then--Torq the Tempest
		self.vb.crashGone = true
		timerScrapBombCD:Stop()
		timerBlastburnRoarcannonCD:Stop()
		timerEruptionStompCD:Stop()
	end
end

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
	elseif spellId == 1213994 then
		self.vb.imagesCount = self.vb.imagesCount + 1
		--pull:29.0, 30.0, 65.0, 30.0, 65.0, 30.0, 65.1, 30.0, 65.0, 30.0, 65.0, 30.0, 65.0, 30.0",
		if not self.vb.crashGone and self.vb.imagesCount % 2 == 0 then
			timerVoltaicImageCD:Start(65, self.vb.imagesCount+1)
		else
			timerVoltaicImageCD:Start(30, self.vb.imagesCount+1)
		end
	--"<70.84 18:11:13> [UNIT_SPELLCAST_SUCCEEDED] Flarendo(76.0%-100.0%){Target:Meeresbarrel} -Colossal Clash- [[boss2:Cast-3-5770-2769-7194-465833-00D78BE0B1:
	--"<74.89 18:11:17> [CLEU] SPELL_CAST_SUCCESS#Creature-0-5770-2769-7194-229181-00000BDD7C#Flarendo(74.9%-100.0%)#Creature-0-5770-2769-7194-229177-00000BDD7C#Torq#465863#Colossal Clash#nil#nil#nil#nil#nil#nil
	elseif spellId == 465833 then--pre crash warning, 4 seconds before CLEU event
		self.vb.crashCount = self.vb.crashCount + 1
		specWarnColossalClash:Show(self.vb.crashCount)
		specWarnColossalClash:Play("watchstep")
		timerColossalClashCD:Start(nil, self.vb.crashCount+1)
	end
end

