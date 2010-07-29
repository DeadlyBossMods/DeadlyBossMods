local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39863)--40141 (twilight form)
mod:SetMinSyncRevision(4358)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warningShadowConsumption		= mod:NewTargetAnnounce(74792, 4)
local warningFieryConsumption		= mod:NewTargetAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningShadowBreath			= mod:NewSpellAnnounce(75954, 2, nil, mod:IsTank() or mod:IsHealer())
local warningFieryBreath			= mod:NewSpellAnnounce(74526, 2, nil, mod:IsTank() or mod:IsHealer())
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 77844)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792)
local specWarnFieryConsumption		= mod:NewSpecialWarningRun(74562)
local specWarnMeteorStrike			= mod:NewSpecialWarningMove(75952)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(77844)

local timerShadowConsumptionCD		= mod:NewNextTimer(25, 74792)
local timerFieryConsumptionCD		= mod:NewNextTimer(25, 74562)
local timerMeteorCD					= mod:NewNextTimer(40, 74648)
local timerMeteorCast				= mod:NewCastTimer(7, 74648)--7-8 seconds from boss yell the meteor impacts.
local timerTwilightCutterCast		= mod:NewCastTimer(5, 77844)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 77844)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 77844)
local timerShadowBreathCD			= mod:NewCDTimer(19, 75954, nil, mod:IsTank() or mod:IsHealer())--Same as debuff timers, same CD, can be merged into 1.
local timerFieryBreathCD			= mod:NewCDTimer(19, 74526, nil, mod:IsTank() or mod:IsHealer())--But unique icons are nice pertaining to phase you're in ;)

local berserkTimer					= mod:NewBerserkTimer(480)

local soundConsumption 				= mod:NewSound(74562, "SoundOnConsumption")

mod:AddBoolOption("YellOnConsumption", true, "announce")
mod:AddBoolOption("AnnounceAlternatePhase", true, "announce")
mod:AddBoolOption("WhisperOnConsumption", false, "announce")
mod:AddBoolOption("SetIconOnConsumption", true)

local warned_preP2 = false
local warned_preP3 = false
local phase2Started = 0
local lastflame = 0

function mod:OnCombatStart(delay)--These may still need retuning too, log i had didn't have pull time though.
	warned_preP2 = false
	warned_preP3 = false
	phase2Started = 0
	lastflame = 0
	berserkTimer:Start(-delay)
	timerMeteorCD:Start(20-delay)
	timerFieryConsumptionCD:Start(15-delay)
	timerFieryBreathCD:Start(10-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then
		warningShadowBreath:Show()
		timerShadowBreathCD:Start()
	elseif args:IsSpellID(74525, 74526, 74527, 74528) then
		warningFieryBreath:Show()
		timerFieryBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	if args:IsSpellID(74792) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerShadowConsumptionCD:Start(20)
		else
			timerShadowConsumptionCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("ShadowCD")
		end
	elseif args:IsSpellID(74562) then
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerFieryConsumptionCD:Start(20)
		else
			timerFieryConsumptionCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("FieryCD")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(74792) then
		if not self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(args.destName)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperConsumption, "WHISPER", "COMMON", args.destName)
			end
		end
		if mod:LatencyCheck() then
			self:SendSync("ShadowTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			soundConsumption:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellConsumption, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(74562) then
		if not self.Options.AnnounceAlternatePhase then
			warningFieryConsumption:Show(args.destName)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperCombustion, "WHISPER", "COMMON", args.destName)
			end
		end
		if mod:LatencyCheck() then
			self:SendSync("FieryTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnFieryConsumption:Show()
			soundConsumption:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellCombustion, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(74792) then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(74562) then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if (args:IsSpellID(75952, 75951, 75950, 75949) or args:IsSpellID(75948, 75947)) and args:IsPlayer() and time() - lastflame > 2 then
		specWarnMeteorStrike:Show() --Standing in meteor, not part of aggro detection.
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
	elseif not warned_preP3 and (self:GetUnitCreatureId(uId) == 40141 or self:GetUnitCreatureId(uId) == 39863) and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		phase2Started = GetTime()
		timerFieryBreathCD:Cancel()
		timerMeteorCD:Cancel()
		timerFieryConsumptionCD:Cancel()
		warnPhase2:Show()
		timerShadowBreathCD:Start(25)
		timerShadowConsumptionCD:Start(20)--not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then --These i'm not sure if they start regardless of drake aggro, or if it should be moved too.
			timerTwilightCutterCD:Start(30)
		else
			timerTwilightCutterCD:Start(35)
		end
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		self:SendSync("Phase3")
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell
		if not self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()
		end
		if mod:LatencyCheck() then
			self:SendSync("Meteor")
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.twilightcutter or msg:find(L.twilightcutter) then
			specWarnTwilightCutter:Schedule(5)
		if not self.Options.AnnounceAlternatePhase then
			warningTwilightCutter:Show()
			timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
		end
		if mod:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" then
		if self.Options.AnnounceAlternatePhase then
			warningTwilightCutter:Show()
			timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
		end
	elseif msg == "Meteor" then
		if self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()
			timerMeteorCD:Start()
		end
	elseif msg == "ShadowTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(target)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperConsumption, "WHISPER", "COMMON", target)
			end
		end
	elseif msg == "FieryTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningFieryConsumption:Show(target)
			if DBM:GetRaidRank() >= 1 and self.Options.WhisperOnConsumption then
				SendChatMessage(L.WhisperCombustion, "WHISPER", "COMMON", target)
			end
		end
	elseif msg == "ShadowCD" then
		if self.Options.AnnounceAlternatePhase then
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				timerShadowConsumptionCD:Start(20)
			else
				timerShadowConsumptionCD:Start()
			end
		end
	elseif msg == "FieryCD" then
		if self.Options.AnnounceAlternatePhase then
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
				timerFieryConsumptionCD:Start(20)
			else
				timerFieryConsumptionCD:Start()
			end
		end
	elseif msg == "Phase3" then
		warnPhase3:Show()
		timerMeteorCD:Start(30) --These i'm not sure if they start regardless of drake aggro, or if it should be moved too.
		timerFieryConsumptionCD:Start(20)--not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
	end
end
