local mod	= DBM:NewMod(2430, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167524)
mod:SetEncounterID(2411)
mod:SetUsedIcons(8)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 327274 327280 327262",
	"SPELL_CAST_SUCCESS 327256 327255 339278",
	"SPELL_AURA_APPLIED 327255 339278",
	"SPELL_AURA_APPLIED_DOSE 327255",
	"SPELL_AURA_REMOVED 327280",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, verify swap stacks count for Mark, don't know it's CD so can't assess yet
--TODO, verify and adjust target scan for Charged Anima Blast
--TOODO, range of Charged Anima Blast is unknown
local warnVentAnima							= mod:NewSpellAnnounce(327256, 3)
local warnMarkofPenitence					= mod:NewStackAnnounce(327255, 2, nil, "Tank")
local warnLysoniasCall						= mod:NewTargetAnnounce(339278, 3)
local warnChargedAnimaBlast					= mod:NewTargetNoFilterAnnounce(327262, 4)

local specWarnUnleashedAnima				= mod:NewSpecialWarningDodge(327274, nil, nil, nil, 2, 2)
local specWarnMarkofPenitence				= mod:NewSpecialWarningStack(327255, nil, 3, nil, nil, 1, 6)
local specWarnMarkofPenitenceTaunt			= mod:NewSpecialWarningTaunt(327255, nil, nil, nil, 1, 2)
local specWarnLysoniasCall					= mod:NewSpecialWarningYou(339278, nil, nil, nil, 1, 2)
local specWarnChargedAnimaBlast				= mod:NewSpecialWarningMoveAway(327262, nil, nil, nil, 3, 2)
local specWarnChargedAnimaBlastNear			= mod:NewSpecialWarningClose(327262, nil, nil, nil, 3, 2)

local timerVentAnimaCD						= mod:NewAITimer(11.6, 327256, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerUnleashedAnimaCD					= mod:NewAITimer(82.0, 327274, nil, nil, nil, 3)
local timerRechargeAnima					= mod:NewBuffActiveTimer(30, 327274, nil, nil, nil, 6)
local timerMarkofPenitenceCD				= mod:NewAITimer(82.0, 327255, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerLysoniasCallCD					= mod:NewAITimer(82.0, 339278, nil, nil, nil, 3)
local timerChargedAnimaBlastCD				= mod:NewAITimer(82.0, 327262, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 5)

mod:AddRangeFrameOption(10, 327262)--TODO, update range if it's too big or too small
mod:AddSetIconOption("SetIconOnAnimaBlast", 327262, true, false, {8})

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerVentAnimaCD:Start(1-delay)
		--timerUnleashedAnimaCD:Start(1-delay)
		--timerMarkofPenitenceCD:Start(1-delay)
		--timerLysoniasCallCD:Start(1-delay)--Iffy, this might be something boss actually does during recharge
		--timerChargedAnimaBlastCD:Start(1-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 327274 then
		specWarnUnleashedAnima:Show()
		specWarnUnleashedAnima:Play("watchstep")
		timerUnleashedAnimaCD:Start()
	elseif spellId == 327280 then--Recharge Anima
		timerVentAnimaCD:Stop()
		timerUnleashedAnimaCD:Stop()
		timerMarkofPenitenceCD:Stop()
		timerLysoniasCallCD:Stop()--Iffy, this might be something boss actually does during recharge
		timerChargedAnimaBlastCD:Stop()
		timerRechargeAnima:Start()
	elseif spellId == 327262 then
		timerChargedAnimaBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 327256 then
		warnVentAnima:Show()
		timerVentAnimaCD:Start()
	elseif spellId == 327255 then
		timerMarkofPenitenceCD:Start()
	elseif spellId == 339278 then
		timerLysoniasCallCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 327255 then
		local amount = args.amount or 1
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnMarkofPenitence:Show(amount)
				specWarnMarkofPenitence:Play("stackhigh")
			else
				local _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12.7) then--TODO, input valid CD here
					specWarnMarkofPenitenceTaunt:Show(args.destName)
					specWarnMarkofPenitenceTaunt:Play("tauntboss")
				else
					warnMarkofPenitence:Show(args.destName, amount)
				end
			end
		else
			warnMarkofPenitence:Show(args.destName, amount)
		end
	elseif spellId == 339278 then
		if args:IsPlayer() then
			specWarnLysoniasCall:Show()
			specWarnLysoniasCall:Play("targetyou")
		else
			warnLysoniasCall:CombinedShow(0.5, args.destName)--TODO, verify it's more than one target
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 327280 then--Recharge Anima
		--Reactivate timers
		timerVentAnimaCD:Start(2)
		timerUnleashedAnimaCD:Start(2)
		timerMarkofPenitenceCD:Start(2)
		timerLysoniasCallCD:Start(2)--Iffy, this might be something boss actually does during recharge
		timerChargedAnimaBlastCD:Start(2)
	end
end

--"<54.60 11:04:21> [UNIT_SPELLCAST_START] Valinor(Zulrager) - Charged Anima Blast - 4s [[nameplate6:Cast-3-3883-2222-64-327262-0000EF4805:327262]]", -- [5166]
--"<54.61 11:04:21> [CLEU] SPELL_CAST_START#Creature-0-3883-2222-64-167524-00006F44AB#Valinor##nil#327262#Charged Anima Blast#nil#nil", -- [5168]
--"<54.72 11:04:21> [UNIT_TARGET] nameplate6#Valinor#Target: Disclaimz#TargetOfTarget: Valinor", -- [5175]
--"<54.96 11:04:21> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\Spell_AnimaBastion_Beam.blp:20|t Valinor targets Disclaimz with a |cFFFF0000|Hspell:327262|h[Charged Anima Blast]|h|r!#Valinor###
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:327262") then
		local targetname = DBM:GetUnitFullName(target) or target--For people not in group, GetUnitFullName fails so need to at least use blizz provided target as backup
		if targetname == UnitName("player") then
			specWarnChargedAnimaBlast:Show()
			specWarnChargedAnimaBlast:Play("runout")
		elseif self:CheckNearby(8, targetname) then
			specWarnChargedAnimaBlastNear:Show(targetname)
			specWarnChargedAnimaBlastNear:Play("runaway")
		else
			warnChargedAnimaBlast:Show(targetname)
		end
		if self.Options.SetIconOnAnimaBlast then
			self:SetIcon(targetname, 8, 5)--Icon clears 1 second after blast
		end
	end
end
