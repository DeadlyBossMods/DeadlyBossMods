local mod	= DBM:NewMod(1749, "DBM-BrokenIsles", nil, 822)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(107023)
mod:SetEncounterID(1880)
mod:SetReCombatTime(20)
mod:SetZone()
--mod:SetMinSyncRevision(11969)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 212867 212852",
	"SPELL_CAST_SUCCESS 212887",
	"SPELL_AURA_APPLIED 212887 212943 212852 212884",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED target focus mouseover"
)

--TODO, adjust specWarnCracklingJoltNear spam threshold as needed
local warnStaticCharge				= mod:NewTargetAnnounce(212887, 3)
local warnLightningRod				= mod:NewTargetAnnounce(212943, 2)

local specWarnCracklingJolt			= mod:NewSpecialWarningDodge(212841, nil, nil, nil, 1, 2)
local yellCracklingJolt				= mod:NewYell(212841, nil, false)
local specWarnCracklingJoltNear		= mod:NewSpecialWarningClose(212841, nil, nil, nil, 1, 2)
local specWarnStaticCharge			= mod:NewSpecialWarningYou(212887, nil, nil, nil, 1, 2)
local yellStaticCharge				= mod:NewFadesYell(212887)
local specWarnLightningRod			= mod:NewSpecialWarningRun(212943, nil, nil, nil, 4, 2)
local specWarnBreath				= mod:NewSpecialWarningDefensive(212852, nil, nil, nil, 1, 2)
local specWarnBreathSwap			= mod:NewSpecialWarningTaunt(212852, nil, nil, nil, 1, 2)
local specWarnStorm					= mod:NewSpecialWarningMove(212884, nil, nil, nil, 1, 2)

local timerCracklingJoltCD			= mod:NewCDTimer(11, 212837, nil, nil, nil, 3)
local timerLightningStormCD			= mod:NewCDTimer(30.5, 212867, nil, nil, nil, 3)
local timerStaticChargeCD			= mod:NewCDTimer(40.2, 212887, nil, "-Tank", nil, 3)
local timerStormBreathCD			= mod:NewCDTimer(23.1, 212852, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

local voiceCracklingJolt			= mod:NewVoice(212841)--watchstep
local voiceStaticCharge				= mod:NewVoice(212887)--runout
local voiceLightingRod				= mod:NewVoice(212943)--runaway
local voiceBreath					= mod:NewVoice(212852)--defensive/tauntboss
local voiceStorm					= mod:NewVoice(212884)--runaway

--mod:AddReadyCheckOption(37460, false)

local function checkTankSwap(self, targetName, spellName)
	if not UnitDebuff("player", spellName) then
		specWarnBreathSwap:Show(targetName)
		voiceBreath:Play("tauntboss")
	end
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then

	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 212867 then
		timerLightningStormCD:Start()
	elseif spellId == 212852 then
		local _, unitID = self:GetCurrentTank(args.sourceGUID)
		if unitID and UnitIsUnit("player", unitID) then
			specWarnBreath:Show()
			voiceBreath:Play("defensive")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 212887 then
		timerStaticChargeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212887 then
		if args:IsPlayer() then
			specWarnStaticCharge:Show()
			voiceStaticCharge:Play("runout")
			yellStaticCharge:Schedule(2, 3)
			yellStaticCharge:Schedule(3, 2)
			yellStaticCharge:Schedule(4, 1)
		else
			warnStaticCharge:Show(args.destName)
		end
	elseif spellId == 212943 then
		warnLightningRod:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnLightningRod:Show()
			voiceLightingRod:Play("runaway")
		end
	elseif spellId == 212852 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			self:Unschedule(checkTankSwap)
			self:Schedule(0.5, checkTankSwap, self, args.destName, args.spellName)
		end
	elseif spellId == 212884 and args:IsPlayer() then
		specWarnStorm:Show()
		voiceStorm:Play("runaway")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 212887 and args:IsPlayer() then
		if args:IsPlayer() then
			yellStaticCharge:Cancel()
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:212841") then
		specWarnCracklingJolt:Show()
		yellCracklingJolt:Yell()
		voiceCracklingJolt:Play("watchstep")
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:212841") then
		targetName = Ambiguate(targetName, "none")
		if self:CheckNearby(4, targetName) and self:AntiSpam(4, 1) then
			specWarnCracklingJoltNear:Show(targetName)
			voiceCracklingJolt:Play("watchstep")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 212837 and self:AntiSpam(4, 2) then--Only event. not targetting boss no timer sorry!
		--Could sync, but I don't want to spam comms for this, that's just stupid.
		timerCracklingJoltCD:Start()
	end
end

