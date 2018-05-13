local mod	= DBM:NewMod(2166, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134442)--135016 Plague Amalgam
mod:SetEncounterID(2134)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267242 265217",
	"SPELL_CAST_SUCCESS 265178 265212 266459",
	"SPELL_AURA_APPLIED 265178 265129 265212",
	"SPELL_AURA_APPLIED_DOSE 265178 265127",
	"SPELL_AURA_REMOVED 265178 265129 265212 265217",
	"SPELL_SUMMON 275055",
	"RAID_BOSS_WHISPER"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
)

--TODO, determine highest tolerable tank stacks. Need a better idea of raid numbers/tuning. Was wildly variable between 4 and 11 in testing, so leaving at 6 for now
--TODO, Immunosuppression Timer for big adds??
--local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnMutagenicPathogen					= mod:NewStackAnnounce(265178, 2, nil, "Tank")
local warnGestate							= mod:NewTargetAnnounce(265212, 3)
local warnHypergenesis						= mod:NewSpellAnnounce(266926, 3)
local warnContagion							= mod:NewCountAnnounce(267242, 3)

--local specWarnMutagenicPathogen				= mod:NewSpecialWarningStack(265178, nil, 6, nil, nil, 1, 6)
--local specWarnMutagenicPathogenOther		= mod:NewSpecialWarningTaunt(265178, nil, nil, nil, 1, 2)
local yellMutagenicPathogen					= mod:NewShortFadesYell(265178)
local specWarnOmegaVector					= mod:NewSpecialWarningYou(265129, nil, nil, nil, 1, 2)
local yellOmegaVector						= mod:NewYell(265129)
local yellOmegaVectorFades					= mod:NewShortFadesYell(265129)
local specWarnGestate						= mod:NewSpecialWarningYou(265212, nil, nil, nil, 1, 2)
local yellGestate							= mod:NewYell(265212)
local specWarnGestateNear					= mod:NewSpecialWarningClose(265212, nil, nil, nil, 1, 2)
local specWarnAmalgam						= mod:NewSpecialWarningSwitch("ej18007", "-Healer", nil, 2, 1, 2)
local specWarnSpawnParasite					= mod:NewSpecialWarningSwitch(275055, "Dps", nil, nil, 1, 2)--Mythic
--local specWarnContagion						= mod:NewSpecialWarningCount(267242, nil, nil, nil, 2, 2)
local specWarnLiquefy						= mod:NewSpecialWarningRun(265217, nil, nil, nil, 4, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(Nexus)
local timerMutagenicPathogenCD				= mod:NewCDTimer(8.5, 265178, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerGestateCD						= mod:NewCDTimer(30.4, 265212, nil, nil, nil, 3)
local timerContagionCD						= mod:NewCDCountTimer(13.4, 267242, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerLiquefyCD						= mod:NewCDTimer(90.9, 265217, nil, nil, nil, 6)
local timerHypergenesisCD					= mod:NewCDCountTimer(11.4, 266459, nil, nil, nil, 5)--11.4 or 12.2, not sure which one blizz decided on, find out later

--local berserkTimer						= mod:NewBerserkTimer(600)

local countdownGestate						= mod:NewCountdown(30, 265212, true, nil, 4)
--local countdownMutagenicPathogen			= mod:NewCountdown("Alt12", 265178, "Tank", 2, 3)
local countdownLiquefy						= mod:NewCountdown("AltTwo90", 265217, nil, nil, 3)

mod:AddSetIconOption("SetIconVector", 265129, true)
mod:AddRangeFrameOption("5/8")
mod:AddInfoFrameOption(265127, true)
mod:AddBoolOption("ShowHighestFirst", true)--The priority for mythic, non mythic will probably turn off

mod.vb.ContagionCount = 0
mod.vb.hyperGenesisCount = 0
local availableRaidIcons = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
local playerHasTen = false

function mod:OnCombatStart(delay)
	self.vb.ContagionCount = 0
	availableRaidIcons = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
	--timerMutagenicPathogenCD:Start(1-delay)--Instantly on engage
	timerContagionCD:Start(10.7-delay, 1)
	timerGestateCD:Start(14.3-delay)--Start
	countdownGestate:Start(17.3-delay)
	timerLiquefyCD:Start(91-delay)
	countdownLiquefy:Start(91-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(265127))
		DBM.InfoFrame:Show(8, "playerdebuffstacks", 265127, self.Options.ShowHighestFirst and 1 or 2)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267242 then
		self.vb.ContagionCount = self.vb.ContagionCount + 1
		warnContagion:Show(self.vb.ContagionCount)
		--specWarnContagion:Play("aesoon")
		timerContagionCD:Start(nil, self.vb.ContagionCount+1)
	elseif spellId == 265217 then
		specWarnLiquefy:Show()
		specWarnLiquefy:Play("justrun")
		self.vb.ContagionCount = 0
		self.vb.hyperGenesisCount = 0
		timerGestateCD:Stop()
		countdownGestate:Cancel()
		timerMutagenicPathogenCD:Stop()
		timerContagionCD:Stop()
		timerHypergenesisCD:Start(9.8, 1)
	elseif spellId == 265212 then
		timerGestateCD:Start()
		countdownGestate:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 265178 then
		timerMutagenicPathogenCD:Start()
	elseif spellId == 266459 then
		self.vb.hyperGenesisCount = self.vb.hyperGenesisCount + 1
		warnHypergenesis:Show(self.vb.hyperGenesisCount)
		if self.vb.hyperGenesisCount == 1 then
			timerHypergenesisCD:Start(nil, 2)
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 275055 and self:AntiSpam(5, 1) then
		specWarnSpawnParasite:Show()
		specWarnSpawnParasite:Play("killmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265178 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 then
				if args:IsPlayer() then
					warnMutagenicPathogen:Show(args.destName, amount)
					--specWarnMutagenicPathogen:Show(amount)
					--specWarnMutagenicPathogen:Play("stackhigh")
					yellMutagenicPathogen:Cancel()
					yellMutagenicPathogen:Countdown(12)
				else
					--local _, _, _, _, _, expireTime = UnitDebuff("player", spellId)
					--local remaining
					--if expireTime then
					--	remaining = expireTime-GetTime()
					--end
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 8) then
					--	specWarnMutagenicPathogenOther:Show(args.destName)
					--	specWarnMutagenicPathogenOther:Play("tauntboss")
					--else
						warnMutagenicPathogen:Show(args.destName, amount)
					--end
				end
			else
				warnMutagenicPathogen:Show(args.destName, amount)
			end
		end
	elseif spellId == 265129 then
		if args:IsPlayer() then
			specWarnOmegaVector:Show()
			specWarnOmegaVector:Play("targetyou")
			yellOmegaVector:Yell()
			yellOmegaVectorFades:Countdown(12, 3)
		end
		if self.Options.SetIconVector then
			local uId = DBM:GetRaidUnitId(args.destName)
			local currentIcon = GetRaidTargetIndex(uId) or 0
			if currentIcon == 0 then--Don't set icon i target already has one
				--Find first available icon
				for i = 1, 8 do
					if availableRaidIcons[i] then
						self:SetIcon(args.destName, i)
						availableRaidIcons[i] = false
						break
					end
				end
			end
		end
	elseif spellId == 265212 then
		if args:IsPlayer() then
			specWarnGestate:Show()
			specWarnGestate:Play("targetyou")
			yellGestate:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		elseif self:CheckNearby(8, args.destName) then
			specWarnGestateNear:Show(args.destName)
			specWarnGestateNear:Play("runaway")
		else
			warnGestate:Show(args.destName)
		end
	elseif spellId == 265127 then
		if args:IsPlayer() and self:IsMythic() then
			local amount = args.amount or 1
			if amount >= 10 and not playerHasTen then
				playerHasTen = true
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(5)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 265178 then
		if args:IsPlayer() then
			yellMutagenicPathogen:Cancel()
		end
	elseif spellId == 265129 then
		if args:IsPlayer() then
			yellOmegaVectorFades:Cancel()
		end
		if self.Options.SetIconVector then
			local uId = DBM:GetRaidUnitId(args.destName)
			local currentIcon = GetRaidTargetIndex(uId) or 0
			self:SetIcon(args.destName, 0)
			if currentIcon > 0 then
				availableRaidIcons[currentIcon] = true
			end
		end
	elseif spellId == 265212 then
		specWarnAmalgam:Show()
		specWarnAmalgam:Play("killmob")
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				if playerHasTen then
					DBM.RangeCheck:Show(5)
				else
					DBM.RangeCheck:Hide()
				end
			end
		end
	elseif spellId == 265217 then
		timerLiquefyCD:Start()
		countdownLiquefy:Start()
		timerMutagenicPathogenCD:Start(6)
		timerContagionCD:Start(15.5, 1)
		timerGestateCD:Start(19.1)--Start
		countdownGestate:Start(19.1)
	end
end

--2.5 seconds faster than APPLIED/SUCCESS, giving you a little time to move out of melee before stun
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("265212") then
		specWarnGestate:Show()
		specWarnGestate:Play("targetyou")
		yellGestate:Yell()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("265212") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
			if UnitName("player") == targetName then return end--Player already got warned
			if self:CheckNearby(8, targetName) then
				specWarnGestateNear:Show(targetName)
				specWarnGestateNear:Play("runaway")
			else
				warnGestate:Show(targetName)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 265291 then--Liquefy Cancel Cosmetic

	end
end
--]]
