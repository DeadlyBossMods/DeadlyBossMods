local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39863)--40141 (twilight form)
mod:SetUsedIcons(7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH"
)

local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warningSoulConsumption		= mod:NewTargetAnnounce(74792, 4)
local warningFieryCombustion		= mod:NewTargetAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningDarkBreath				= mod:NewSpellAnnounce(75954, 2, nil, mod:IsTank() or mod:IsHealer())
local warningFlameBreath			= mod:NewSpellAnnounce(74526, 2, nil, mod:IsTank() or mod:IsHealer())
local warningTwilightCutter			= mod:NewSpellAnnounce(77844, 3)

local specWarnSoulConsumption		= mod:NewSpecialWarningRun(74792)
local specWarnFieryCombustion		= mod:NewSpecialWarningRun(74562)

local timerSoulConsumptionCD		= mod:NewCDTimer(20, 74792)
local timerFieryCombustionCD		= mod:NewCDTimer(20, 74562)
local timerMeteorCD					= mod:NewNextTimer(35, 74648)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 77844)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 77844)
local timerDarkBreathCD				= mod:NewCDTimer(17, 75954, nil, mod:IsTank() or mod:IsHealer())
local timerFlameBreathCD			= mod:NewCDTimer(17, 74526, nil, mod:IsTank() or mod:IsHealer())

local soundConsumption 				= mod:NewSound(74562, "SoundOnConsumption")
mod:AddBoolOption("SetIconOnConsumption", true)
mod:AddBoolOption("YellOnConsumption", true, "announce")

local warned_preP2 = false
local warned_preP3 = false

function mod:OnCombatStart(delay)
		timerMeteorCD:Start(20-delay)
		timerFieryCombustionCD:Start(15-delay)
		timerFlameBreathCD:Start(8-delay)
	warned_preP2 = false
	warned_preP3 = false
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then
		warningDarkBreath:Show()
		timerDarkBreathCD:Start()
	elseif args:IsSpellID(74525, 74526, 74527, 74528) then
		warningFlameBreath:Show()
		timerFlameBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(74648, 75877, 75878, 75879) then--Meteor Strike
		warningMeteor:Show()
		timerMeteorCD:Start()
	elseif args:IsSpellID(74792) then
		timerSoulConsumptionCD:Start()
		--if mod:LatencyCheck() then
			self:SendSync("SoulTarget", args.destName)
		--end
		if args:IsPlayer() then
			specWarnSoulConsumption:Show()
			soundConsumption:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellConsumption, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(74562) then
		timerFieryCombustionCD:Start()
		--if mod:LatencyCheck() then
			self:SendSync("FieryTarget", args.destName)
		--end
		if args:IsPlayer() then
			specWarnFieryCombustion:Show()
			soundConsumption:Play()
			if self.Options.YellOnConsumption then
				SendChatMessage(L.YellCombustion, "SAY")
			end
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 7)
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

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		warned_preP2 = true
		warnPhase2Soon:Show()	
	elseif not warned_preP3 and (self:GetUnitCreatureId(uId) == 40141 or self:GetUnitCreatureId(uId) == 39863) and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		warned_preP3 = true
		warnPhase3Soon:Show()	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:match(L.twilightcutter) then
		self:SendSync("TwilightCutter")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:match(L.phase2) then
		self:SendSync("phase2")
	elseif msg:match(L.phase3) then
		self:SendSync("phase3")
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" then
		warningTwilightCutter:Show()
		timerTwilightCutter:Schedule(5)
		timerTwilightCutterCD:Schedule(15)
	elseif msg == "phase2" then
		timerDarkBreathCD:Start(20)
		timerSoulConsumptionCD:Start(20)
		timerTwilightCutterCD:Start(35)
	elseif msg == "phase3" then
		timerMeteorCD:Start(30)
		timerFieryCombustionCD:Start(20)
	elseif msg == "SoulTarget" then
		warningSoulConsumption:Show(target)
	elseif msg == "FieryTarget" then
		warningFieryCombustion:Show(target)
	end
end
