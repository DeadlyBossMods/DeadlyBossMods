local mod	= DBM:NewMod(2166, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134442)--135016 Plague Amalgam
mod:SetEncounterID(2134)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267242 265217",
	"SPELL_CAST_SUCCESS 265178 265212 266926",
	"SPELL_AURA_APPLIED 265178 265129 265212",
	"SPELL_AURA_APPLIED_DOSE 265178",
	"SPELL_AURA_REMOVED 265178 265129 265212",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, determine highest tolerable tank stacks. Need a better idea of raid numbers/tuning. 3 drycoded for now
--TODO, Contagion timer to a count timer when not AI
--TODO, figure out correct event for stage changes between solid and liquid stage.
--TODO, figure out proper spellID for detecting Hypergenesis soaks
--TODO, figure out right non spammy event for Blood Geyser
--local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnMutagenicPathogen					= mod:NewStackAnnounce(265178, 2, nil, "Tank")
local warnGestate							= mod:NewTargetAnnounce(265212, 3)
local warnHypergenesis						= mod:NewSpellAnnounce(266926, 3)

local specWarnMutagenicPathogen				= mod:NewSpecialWarningStack(265178, nil, 3, nil, nil, 1, 6)
--local specWarnMutagenicPathogenOther		= mod:NewSpecialWarningTaunt(265178, nil, nil, nil, 1, 2)--TEMP disabled, don't want to tell tanks to taunt too early and wipe people
local yellMutagenicPathogen					= mod:NewShortFadesYell(265178)
local specWarnOmegaVector					= mod:NewSpecialWarningYou(265129, nil, nil, nil, 1, 2)
local yellOmegaVector						= mod:NewYell(265129)
local yellOmegaVectorFades					= mod:NewShortFadesYell(265129)
local specWarnGestate						= mod:NewSpecialWarningYou(265212, nil, nil, nil, 1, 2)
local yellGestate							= mod:NewYell(265212)
local specWarnGestateNear					= mod:NewSpecialWarningClose(265212, nil, nil, nil, 1, 2)
local specWarnAmalgam						= mod:NewSpecialWarningSwitch("ej18007", "Dps", nil, nil, 1, 2)
local specWarnContagion						= mod:NewSpecialWarningCount(267242, nil, nil, nil, 2, 2)
local specWarnLiquefy						= mod:NewSpecialWarningRun(265217, nil, nil, nil, 4, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(Nexus)
local timerMutagenicPathogenCD				= mod:NewAITimer(12.1, 265178, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerGestateCD						= mod:NewAITimer(12.1, 265212, nil, nil, nil, 3)
local timerContagionCD						= mod:NewAITimer(12.1, 267242, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

--local countdownMutagenicPathogen			= mod:NewCountdown("Alt12", 265178, "Tank", 2, 3)

mod:AddSetIconOption("SetIconVector", 265129, true)
mod:AddRangeFrameOption(8, 265212)
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddInfoFrameOption(265127, true)

mod.vb.ContagionCount = 0
local lingeringInfectino = DBM:GetSpellInfo(265127)
local availableRaidIcons = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}

function mod:OnCombatStart(delay)
	self.vb.ContagionCount = 0
	lingeringInfectino = DBM:GetSpellInfo(265127)
	availableRaidIcons = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
	timerMutagenicPathogenCD:Start(1-delay)
	timerGestateCD:Start(1-delay)
	timerContagionCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(lingeringInfectino)
		DBM.InfoFrame:Show(6, "playerdebuffstacks", lingeringInfectino)
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
		specWarnContagion:Show(self.vb.ContagionCount)
		specWarnContagion:Play("aesoon")
		timerContagionCD:Start()
	elseif spellId == 265217 then
		specWarnLiquefy:Show()
		specWarnLiquefy:Play("justrun")
		--Assumed
		timerGestateCD:Stop()
		timerMutagenicPathogenCD:Stop()
		timerContagionCD:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 265178 then
		timerMutagenicPathogenCD:Start()
	elseif spellId == 265212 then
		timerGestateCD:Start()
	elseif spellId == 266926 then
		warnHypergenesis:Show()		
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265178 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnMutagenicPathogen:Show(amount)
					specWarnMutagenicPathogen:Play("stackhigh")
					yellMutagenicPathogen:Cancel()
					yellMutagenicPathogen:Countdown(12)
				else
					local _, _, _, _, _, _, expireTime = UnitDebuff("player", args.spellName)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					--if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
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
				DBM.RangeCheck:Hide()
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 257939 then

	end
end
--]]
