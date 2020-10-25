local mod	= DBM:NewMod(2430, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(167524)
mod:SetEncounterID(2411)
mod:SetUsedIcons(8)
mod:SetReCombatTime(20)
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 327274 327280",
	"SPELL_CAST_SUCCESS 327256 327255 339278",
	"SPELL_AURA_APPLIED 327255 339278",
	"SPELL_AURA_APPLIED_DOSE 327255",
	"SPELL_AURA_REMOVED 327280"
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
local yellChargedAnimaBlast					= mod:NewYell(327262)
local yellChargedAnimaBlastFades			= mod:NewFadesYell(327262)
local specWarnChargedAnimaBlastNear			= mod:NewSpecialWarningClose(327262, nil, nil, nil, 3, 2)

local timerVentAnimaCD						= mod:NewAITimer(82.0, 327256, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
local timerUnleashedAnimaCD					= mod:NewAITimer(82.0, 327274, nil, nil, nil, 3)
local timerRechargeAnima					= mod:NewBuffActiveTimer(30, 327274, nil, nil, nil, 6)
local timerMarkofPenitenceCD				= mod:NewAITimer(82.0, 327255, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerLysoniasCallCD					= mod:NewAITimer(82.0, 339278, nil, nil, nil, 3)
local timerChargedAnimaBlastCD				= mod:NewAITimer(82.0, 327262, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 1, 5)

mod:AddRangeFrameOption(10, 327262)--TODO, update range if it's too big or too small
mod:AddSetIconOption("SetIconOnAnimaBlast", 327262, true, false, {8})

function mod:EmberBlastTarget(targetname, uId, bossuid, scanningTime)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnChargedAnimaBlast:Show()
		specWarnChargedAnimaBlast:Play("runout")
		yellChargedAnimaBlast:Yell()
		yellChargedAnimaBlastFades:Countdown(4-scanningTime)
	elseif self:CheckNearby(8, targetname) then
		specWarnChargedAnimaBlastNear:Show(targetname)
		specWarnChargedAnimaBlastNear:Play("runaway")
	else
		warnChargedAnimaBlast:Show(targetname)
	end
	if self.Options.SetIconOnAnimaBlast then
		self:SetIcon(targetname, 8, 4-scanningTime)--So icon clears 1 second after blast
	end
end

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
		self:BossTargetScanner(args.sourceGUID, "EmberBlastTarget", 0.15, 13)--Scans for 1.95 of 4.0 second cast, will adjust later
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
