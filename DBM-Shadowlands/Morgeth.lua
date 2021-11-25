local mod	= DBM:NewMod(2456, "DBM-Shadowlands", nil, 1192)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(178958)
mod:SetEncounterID(2496)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 356430 353741 355456",
	"SPELL_CAST_SUCCESS 353800",
	"SPELL_AURA_APPLIED 353800",
	"SPELL_AURA_APPLIED_DOSE 353800",
	"SPELL_PERIODIC_DAMAGE 353183 356382",
	"SPELL_PERIODIC_MISSED 353183 356382"
)

local warnCriesofAnquish			= mod:NewCastAnnounce(353741, 2)
local warnTorment					= mod:NewStackAnnounce(353800, 2, nil, "Tank|Healer")

local specWarnIronGolem				= mod:NewSpecialWarningSwitch(356430, "Dps", nil, nil, 1, 2)
local specWarnTorment				= mod:NewSpecialWarningStack(353800, nil, 2, nil, nil, 1, 6)
local specWarnTormentSwap			= mod:NewSpecialWarningTaunt(353800, nil, nil, nil, 1, 2)
local specWarnDamnation				= mod:NewSpecialWarningDodge(355456, nil, nil, nil, 2, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(353183, nil, nil, nil, 1, 8)

--All timers are delayed when damnation is cast.
--If anything comes off CD during Damnation, it just queues up and he casts everything queued right away after damn is over
local timerIronGolemCD				= mod:NewCDTimer(49.7, 356430, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--49.7-113.1
local timerCriesofAnquishCD			= mod:NewCDTimer(11, 353741, nil, nil, nil, 3)--11.3-99.1
local timerTormentCD				= mod:NewCDTimer(9.4, 353800, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--9.9-44.4
local timerDamnationCD				= mod:NewCDTimer(53.7, 355456, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDamnation				= mod:NewBuffActiveTimer(32, 355456, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerIronGolemCD:Start(13-delay)
		timerCriesofAnquishCD:Start(15.7-delay)
		timerTormentCD:Start(18.5-delay)
		timerDamnationCD:Start(29.1-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 338858 then
		specWarnIronGolem:Show()
		timerIronGolemCD:Start()
	elseif spellId == 353741 then
		warnCriesofAnquish:Show()
		timerCriesofAnquishCD:Start()
	elseif spellId == 355456 then
		specWarnDamnation:Show()
		specWarnDamnation:Play("shockwave")
		specWarnDamnation:ScheduleVoice(1, "keepmove")
		timerDamnation:Start()
		timerDamnationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 353800 then
		timerTormentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 353800 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				--Shared antispam with tank defensive warning, just to avoid tank feeling spammed, especially since this could also trigger twice in a single bite
				specWarnTorment:Show(amount)
				specWarnTorment:Play("stackhigh")
			else
				local _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 9.9) then
					specWarnTormentSwap:Show(args.destName)
					specWarnTormentSwap:Play("tauntboss")
				else
					warnTorment:Show(args.destName, amount)
				end
			end
		else
			warnTorment:Show(args.destName, amount)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 356382 or spellId == 353183) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
