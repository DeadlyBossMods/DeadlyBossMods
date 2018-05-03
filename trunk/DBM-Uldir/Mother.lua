local mod	= DBM:NewMod(2167, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(135452)--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
mod:SetEncounterID(2141)
mod:SetZone()
--mod:SetHotfixNoticeRev(16950)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267787 268198",
	"SPELL_CAST_SUCCESS 267795 267945 267885 267878 269827 269051 268089",
	"SPELL_AURA_APPLIED 267787 274205",
	"SPELL_AURA_APPLIED_DOSE 267787"
)

--TODO, if tanks are still able to dodge scalpel in next test, refactor warning to be a shockwave/dodge instead of tank swap mechanic
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnSunderingScalpelCast			= mod:NewCastAnnounce(267787, 2, nil, "Tank")
local warnSunderingScalpel				= mod:NewStackAnnounce(267787, 2, nil, "Tank")
local warnWindTunnel					= mod:NewSpellAnnounce(267945, 2)
local warnDepletedEnergy				= mod:NewSpellAnnounce(274205, 1)
local warnCleansingPurgeFinish			= mod:NewTargetNoFilterAnnounce(268089, 4)

local specWarnSunderingScalpel			= mod:NewSpecialWarningStack(267787, nil, 2, nil, nil, 1, 6)
local specWarnSunderingScalpelOther		= mod:NewSpecialWarningTaunt(267787, nil, nil, nil, 1, 2)
local specWarnPurifyingFlame			= mod:NewSpecialWarningDodge(267787, nil, nil, nil, 2, 2)
local specWarnClingingCorruption		= mod:NewSpecialWarningInterrupt(268198, "HasInterrupt", nil, nil, 1, 2)
local specWarnSurgicalBeam				= mod:NewSpecialWarningDodge(269827, nil, nil, nil, 3, 2)

--mod:AddTimerLine(Nexus)
local timerSunderingScalpelCD			= mod:NewNextTimer(23.1, 267787, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerPurifyingFlameCD				= mod:NewNextTimer(23.1, 267795, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerWindTunnelCD					= mod:NewNextTimer(40.1, 267945, nil, nil, nil, 2)
local timerSurgicalBeamCD				= mod:NewNextTimer(30, 269827, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON)
local timerCleansingFlameCD				= mod:NewCastSourceTimer(180, 268089, nil, nil, nil, 6)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownPurifyingFlame			= mod:NewCountdown(50, 267795, true, 3, 3)
local countdownSunderingScalpel			= mod:NewCountdown("Alt23", 267787, "Tank", 2, 3)
local countdownSurgicalBeam				= mod:NewCountdown("AltTwo30", 269827, nil, nil, 4)

mod:AddInfoFrameOption(268095, true)

function mod:OnCombatStart(delay)
	timerSunderingScalpelCD:Start(5.9-delay)
	countdownSunderingScalpel:Start(5.9-delay)
	timerPurifyingFlameCD:Start(10.8-delay)
	countdownPurifyingFlame:Start(10.8-delay)
	timerWindTunnelCD:Start(20.6-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(4, "enemypower", 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267787 then
		warnSunderingScalpelCast:Show()
		timerSunderingScalpelCD:Start()
		countdownSunderingScalpel:Start()
	elseif spellId == 268198 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnClingingCorruption:Show(args.sourceName)
		specWarnClingingCorruption:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 267795 then
		specWarnPurifyingFlame:Show()
		specWarnPurifyingFlame:Play("watchstep")
		timerPurifyingFlameCD:Start()
		countdownPurifyingFlame:Start()
	elseif spellId == 267878 then--Directional IDs for winds (Coming from east blowing to west?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267885 then--Directional IDs for winds (Coming from west blowing to east?)
		--warnWindTunnel:Show()
		DBM:Debug("what way is wind blowing for spellId :"..spellId)
	elseif spellId == 267945 then--Global Id for winds
		warnWindTunnel:Show()
		timerWindTunnelCD:Show()
	elseif spellId == 269827 then
		specWarnSurgicalBeam:Show()
		specWarnSurgicalBeam:Play("laserrun")
		specWarnSurgicalBeam:ScheduleVoice(1.5, "keepmove")
		timerSurgicalBeamCD:Start()
		countdownSurgicalBeam:Start()
	elseif spellId == 269051 then--Begin Cast of Cleansing Purge
		--136429 Chamber 01, 137022 Chamber 02, 137023 Chamber 03
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 136429 then
			timerCleansingFlameCD:Start(180, 1)
		elseif cid == 137022 then
			timerCleansingFlameCD:Start(180, 2)
		else
			timerCleansingFlameCD:Start(180, 3)
		end
	elseif spellId == 268089 then--End Cast of Cleansing Purge
		warnCleansingPurgeFinish:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 267787 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnSunderingScalpel:Show(amount)
					specWarnSunderingScalpel:Play("stackhigh")
				else
					local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 30) then--30 is placeholder until CD is known
						specWarnSunderingScalpelOther:Show(args.destName)
						specWarnSunderingScalpelOther:Play("tauntboss")
					else
						warnSunderingScalpel:Show(args.destName, amount)
					end
				end
			else
				warnSunderingScalpel:Show(args.destName, amount)
			end
		end
	elseif spellId == 274205 then
		warnDepletedEnergy:Show()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
