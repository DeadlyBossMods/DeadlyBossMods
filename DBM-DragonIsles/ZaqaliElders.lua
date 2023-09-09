local mod	= DBM:NewMod(2531, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(199855, 199853)--Vakan, Gholna
mod:SetEncounterID(2696)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
mod:SetBossHPInfoToHighest()
mod:SetHotfixNoticeRev(20230516000000)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 403772 402793 403855 402887 404171 402985 404517 402983",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 407563 403779 402824",
	"SPELL_AURA_APPLIED_DOSE 403779 402824",
	"SPELL_AURA_REMOVED 407563",
	"SPELL_PERIODIC_DAMAGE 403384 403948",
	"SPELL_PERIODIC_MISSED 403384 403948",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--TODO, fine tune tanking stuff, maybe taunt warnings?
--TODO, target scan or alert Blazing pitch at all?
--General
local specWarnGTFO						= mod:NewSpecialWarningGTFO(403384, nil, nil, nil, 1, 8)
--Vakan
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26374))
local warnBurningShadows				= mod:NewStackAnnounce(403779, 2)--Auto alert for self, or other tanks if healer|tank role
local warnBlazingPitch					= mod:NewCastAnnounce(403855, 3)
local warnEnvelopingDarkness			= mod:NewTargetAnnounce(404171, 2)

local specWarnUmbralSmash				= mod:NewSpecialWarningYou(403772, nil, nil, nil, 1, 2)
local specWarnBurningShadows			= mod:NewSpecialWarningStack(403779, nil, 6, nil, nil, 1, 6)
--local specWarnBurningShadowsTaunt		= mod:NewSpecialWarningTaunt(403779, nil, nil, nil, 1, 2)
local specWarnEnvelopingDarkness		= mod:NewSpecialWarningMoveAway(404171, nil, nil, nil, 1, 2)
local specWarnScorchingEclipse			= mod:NewSpecialWarningDodge(404517, nil, nil, nil, 2, 2)

local timerUmbralSmashCD				= mod:NewAITimer(22.1, 403772, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerBlazingPitchCD				= mod:NewAITimer(22.1, 403855, nil, nil, nil, 3)
local timerEnvelopingDarknessCD			= mod:NewAITimer(22.1, 404171, nil, nil, nil, 3)
local timerScorchingEclipseCD			= mod:NewAITimer(22.1, 404517, nil, nil, nil, 3)

--Gholna
mod:AddTimerLine(DBM:EJ_GetSectionInfo(26383))
local warnSearingTouch					= mod:NewStackAnnounce(402824, 2, nil, "Tank|Healer")
local warnStokingtheFlames				= mod:NewCastAnnounce(402887, 3)
local warnLavaGeyser					= mod:NewTargetAnnounce(402985, 2)

local specWarnBurningStrike				= mod:NewSpecialWarningYou(402793, nil, nil, nil, 1, 2)
local specWarnSearingTouch				= mod:NewSpecialWarningStack(402824, nil, 6, nil, nil, 1, 6)
--local specWarnSearingTouchTaunt		= mod:NewSpecialWarningTaunt(402824, nil, nil, nil, 1, 2)
local specWarnLavaGeyser				= mod:NewSpecialWarningMoveAway(402985, nil, nil, nil, 1, 2)
local specWarnIncineration				= mod:NewSpecialWarningDodge(402983, nil, nil, nil, 2, 2)

local timerBurningStrikeCD				= mod:NewAITimer(22.1, 402793, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerStokingtheFlamesCD			= mod:NewAITimer(22.1, 402887, nil, nil, nil, 3)
local timerLavaGeyserCD					= mod:NewAITimer(22.1, 402985, nil, nil, nil, 3)
local timerIncinerationCD				= mod:NewAITimer(22.1, 402983, nil, nil, nil, 3)

--mod:AddRangeFrameOption(5, 361632)
mod:AddNamePlateOption("NPAuraOnRivalry", 407563)

function mod:EnvelopingDarknessTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnEnvelopingDarkness:Show()
		specWarnEnvelopingDarkness:Play("runout")
	else
		warnEnvelopingDarkness:Show(targetname)
	end
end

function mod:LavaGeyserTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnLavaGeyser:Show()
		specWarnLavaGeyser:Play("runout")
	else
		warnLavaGeyser:Show(targetname)
	end
end

function mod:OnCombatStart(delay, yellTriggered)
--	if yellTriggered then
		--Vakan
		--timerUmbralSmashCD:Start(1)
		--timerBlazingPitchCD:Start(1)
		--timerEnvelopingDarknessCD:Start(1)
		--timerScorchingEclipseCD:Start(1)
		--Gholna
		--timerBurningStrikeCD:Start(1)
		--timerStokingtheFlamesCD:Start(1)
		--timerLavaGeyserCD:Start(1)
		--timerIncinerationCD:Start(1)
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnRivalry then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnRivalry then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 403772 then
		timerUmbralSmashCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnUmbralSmash:Show()
			specWarnUmbralSmash:Play("carefly")
		end
	elseif spellId == 402793 then
		timerBurningStrikeCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnBurningStrike:Show()
			specWarnBurningStrike:Play("carefly")
		end
	elseif spellId == 403855 then
		warnBlazingPitch:Show()
		timerBlazingPitchCD:Start()
	elseif spellId == 402887 then
		warnStokingtheFlames:Show()
		timerStokingtheFlamesCD:Start()
	elseif spellId == 404171 then
		timerEnvelopingDarknessCD:Start()
		self:BossTargetScanner(args.sourceGUID, "EnvelopingDarknessTarget", 0.1, 15)
	elseif spellId == 402985 then
		timerLavaGeyserCD:Start()
		self:BossTargetScanner(args.sourceGUID, "LavaGeyserTarget", 0.1, 15)
	elseif spellId == 404517 then
		specWarnScorchingEclipse:Show()
		specWarnScorchingEclipse:Play("watchstep")
		timerScorchingEclipseCD:Start()
	elseif spellId == 402983 then
		specWarnIncineration:Show()
		specWarnIncineration:Play("watchstep")
		timerIncinerationCD:Start()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 389954 then

	end
end
--]]


function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 407563 then
		if self.Options.NPAuraOnRivalry then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 403779 then
		local amount = args.amount or 1
		if amount >= 2 and self:AntiSpam(3, 1) then--Adjust start stacks accordingly
			if args:IsPlayer() and amount >= 6 then--Adjust high stacks accordingly
				specWarnBurningShadows:Show(amount)
				specWarnBurningShadows:Play("stackhigh")
			else
				local uId = DBM:GetRaidUnitId(args.destName)
				--on self and less than 6 stacks, or not on self and any stack count on someone that's tanking and you're a tank/healer role yourself
				if args:IsPlayer() or (self:IsTanking(uId) and (self:IsTank() or self:IsHealer())) then
					warnBurningShadows:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 402824 then
		local amount = args.amount or 1
		if amount >= 2 and self:AntiSpam(3, 2) then--Adjust start stacks accordingly
			if args:IsPlayer() and amount >= 6 then--Adjust high stacks accordingly
				specWarnSearingTouch:Show(amount)
				specWarnSearingTouch:Play("stackhigh")
			else
				local uId = DBM:GetRaidUnitId(args.destName)
				--on self and less than 6 stacks, or not on self and any stack count on someone that's tanking and you're a tank/healer role yourself
				if args:IsPlayer() or (self:IsTanking(uId) and (self:IsTank() or self:IsHealer())) then
					warnSearingTouch:Show(args.destName, amount)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 407563 then
		if self.Options.NPAuraOnRivalry then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 203220 then--Vakan
		timerUmbralSmashCD:Stop()
		timerBlazingPitchCD:Stop()
		timerEnvelopingDarknessCD:Stop()
		timerScorchingEclipseCD:Stop()
	elseif cid == 203219 then--Gholna
		timerBurningStrikeCD:Stop()
		timerStokingtheFlamesCD:Stop()
		timerLavaGeyserCD:Stop()
		timerIncinerationCD:Stop()
	end
end

--Alerts if standing in stuff and you do not have opposite debuff that clears it
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 403384 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then--Molten Pool
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 403948 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then--Blistering Cyclone
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("spell:389762") then

	end
end
--]]
