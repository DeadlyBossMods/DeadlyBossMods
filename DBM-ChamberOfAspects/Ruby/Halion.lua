local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(39863)--40141 (twilight form)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH"
)

local warnPhase2Soon				= mod:NewAnnounce("WarnPhase2Soon", 2)
local warnPhase3Soon				= mod:NewAnnounce("WarnPhase3Soon", 2)
local warningShadowConsumption		= mod:NewTargetAnnounce(74792, 4)
local warningFieryConsumption		= mod:NewTargetAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningShadowBreath			= mod:NewSpellAnnounce(75954, 2, nil, mod:IsTank() or mod:IsHealer())
local warningFieryBreath			= mod:NewSpellAnnounce(74526, 2, nil, mod:IsTank() or mod:IsHealer())
local warningTwilightCutter			= mod:NewSpellAnnounce(77844, 3)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792)
local specWarnFieryConsumption		= mod:NewSpecialWarningRun(74562)

local timerShadowConsumptionCD		= mod:NewCDTimer(20, 74792)--may not need both of these
local timerFieryConsumptionCD		= mod:NewCDTimer(20, 74562)--if they are on same CD.
local timerMeteorCD					= mod:NewNextTimer(35, 74648)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 77844)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 77844)
local timerShadowBreathCD			= mod:NewCDTimer(8, 75954, nil, mod:IsTank() or mod:IsHealer())--may not need both of these
local timerFieryBreathCD			= mod:NewCDTimer(8, 74526, nil, mod:IsTank() or mod:IsHealer())--if they are on same CD.

local soundConsumption 			= mod:NewSound(74562, "SoundOnConsumption")
mod:AddBoolOption("SetIconOnConsumption", true)

local warned_preP2 = false
local warned_preP3 = false

function mod:OnCombatStart(delay)
		timerMeteorCD:Start(30-delay)
		timerFieryConsumptionCD:Start(17-delay)
		timerFieryBreathCD:Start(5.5-delay)
	warned_preP2 = false
	warned_preP3 = false
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

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(74648, 75877, 75878, 75879) then--Meteor Strike
		warningMeteor:Show()
		timerMeteorCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(74792) then
		warningShadowConsumption:Show(args.destName)
		timerShadowConsumptionCD:Start()
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			soundConsumption:Play()
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(74562) then
		warningFieryConsumption:Show(args.destName)
		timerFieryConsumptionCD:Start()
		if args:IsPlayer() then
			specWarnFieryConsumption:Show()
			soundConsumption:Play()
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

function mod:OnSync(msg)
	if msg == "TwilightCutter" then
		warningTwilightCutter:Show()
		timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
		timerTwilightCutterCD:Schedule(15)
	end
end
