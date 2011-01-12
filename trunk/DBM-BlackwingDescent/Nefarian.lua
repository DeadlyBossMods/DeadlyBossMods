local mod	= DBM:NewMod("Nefarian-BD", "DBM-BlackwingDescent", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41376, 41270)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnOnyTailSwipe			= mod:NewAnnounce("OnyTailSwipe", 3, 77827)--we only care about onyxia's tailswipe. Nefarian's shouldn't get in the way or you're doing it wrong.
local warnNefTailSwipe			= mod:NewAnnounce("NefTailSwipe", 3, 77827, false)--but for those that might care for whatever reason, we include his too, off by default.
local warnOnyShadowflameBreath	= mod:NewAnnounce("OnyBreath", 3, 94124, mod:IsTank())
local warnNefShadowflameBreath	= mod:NewAnnounce("NefBreath", 3, 94124, mod:IsTank())
local warnShadowflameBarrage	= mod:NewSpellAnnounce(78621, 3, nil, false)--Phase 2 spam.
local warnBlastNova				= mod:NewSpellAnnounce(80734, 3)
local warnShadowBlaze			= mod:NewSpellAnnounce(94085, 4)--May be quirky
local warnHailBones				= mod:NewSpellAnnounce(94104, 3, nil, false)	-- spams a lot (every ~2sec a new one spawns)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase3				= mod:NewPhaseAnnounce(3)

local timerBlastNova			= mod:NewCastTimer(1.5, 80734)
local timerElectrocute			= mod:NewCastTimer(5, 81198)
local timerLightningDischarge	= mod:NewCDTimer(20, 77942)--92456, every 20-25 seconds. Need to emphesise this is a CD timer not a next timer. It will also only trigger if it hits something (including pets).
local timerShadowflameBarrage	= mod:NewBuffActiveTimer(180, 78621)
local timerShadowBlazeCD		= mod:NewCDTimer(10, 94085)
local timerOnySwipeCD			= mod:NewTimer(10, "OnySwipeTimer", 77827)--10-20 second cd (18 being the most consistent)
local timerNefSwipeCD			= mod:NewTimer(10, "NefSwipeTimer", 77827, false)--Same as hers, but not synced.
local timerOnyBreathCD			= mod:NewTimer(12, "OnyBreathTimer", 94124, mod:IsTank())--12-20 second variations
local timerNefBreathCD			= mod:NewTimer(12, "NefBreathTimer", 94124, mod:IsTank())--same as above

local specWarnElectrocute		= mod:NewSpecialWarningSpell(81198)
local specWarnShadowblaze		= mod:NewSpecialWarningMove(94085)
local specWarnBlastsNova		= mod:NewSpecialWarningInterrupt(80734)

local deaths = 0
local spamHailBones = 0
local spamShadowblaze = 0
local spamLightningDischarge = 0
local shadowblazeTimer = 30

function mod:ShadowBlazeTimer()
	if shadowblazeTimer >= 10 then--Keep it from dropping below 5
		shadowblazeTimer = shadowblazeTimer - 5
	end
	warnShadowBlaze:Show()
	timerShadowBlazeCD:Start(shadowblazeTimer)
	self:ScheduleMethod(shadowblazeTimer, "ShadowBlazeTimer")
end

function mod:OnCombatStart(delay)
	deaths = 0
	spamHailBones = 0
	spamShadowblaze = 0
	spamLightningDischarge = 0
	shadowblazeTimer = 30
	timerLightningDischarge:Start(30-delay)--First one seems pretty precise
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(77826, 94124, 94125, 94126) and args:GetSrcCreatureID() == 41270 then--Onyxia's Breath
		if self:GetUnitCreatureId("target") == 41270 then--Only warn you for ony's breath, if you are Targeting Ony
			warnOnyShadowflameBreath:Show()
			timerOnyBreathCD:Start()
		end
	elseif args:IsSpellID(77826, 94124, 94125, 94126) and args:GetSrcCreatureID() == 41376 then--Nefarians Breath
		if self:GetUnitCreatureId("target") == 41376 then--Only warn you for Nef's breath, if you are Targeting Nef
			warnNefShadowflameBreath:Show()
			timerNefBreathCD:Start()
		end
	elseif args:IsSpellID(80734) then
		warnBlastNova:Show()
		if args.sourceGUID == UnitGUID("target") then--Only show warning/timer for your own target.
			specWarnBlastsNova:Show()
			timerBlastNova:Start()
		end
	elseif args:IsSpellID(78621, 94121, 94122, 94123) then
		warnShadowflameBarrage:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(77827, 94128, 94129, 94130) and args:GetSrcCreatureID() == 41270 then
		warnOnyTailSwipe:Show()
		timerOnySwipeCD:Start()
	elseif args:IsSpellID(77827, 94128, 94129, 94130) and args:GetSrcCreatureID() == 41376 then
		warnNefTailSwipe:Show()
		timerNefSwipeCD:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsPlayer() and args:IsSpellID(81007, 94085, 94086, 94087) and GetTime() - spamShadowblaze > 5 then--Drycodes
		specWarnShadowblaze:Show()
		spamShadowblaze = GetTime()
	elseif (args:IsSpellID(77939, 77942, 77943, 77944) or args:IsSpellID(94107, 94108, 94109, 94110) or args:IsSpellID(94111, 94112, 94113, 94114) or args:IsSpellID(94115, 94116, 94117, 94118)) and GetTime() - spamLightningDischarge > 15 then--Nost most ideal solution but difficult with an ability that has no cast trigger to speak of.
		timerLightningDischarge:Start()
		spamLightningDischarge = GetTime()
	end
end

function mod:SPELL_MISSED(args)
	if args:IsSpellID(77833, 77838, 77919) and GetTime() - spamLightningDischarge > 15 then--Same as above only these are unique spellids for misses/immunities.
		timerLightningDischarge:Start()
		spamLightningDischarge = GetTime()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(78684, 94104, 94105, 94106) and GetTime() - spamHailBones > 5 then		-- reduces spam a little, still spamming a lot
		warnHailBones:Show()
		spamHailBones = GetTime()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then
		warnPhase2:Show()
		timerShadowflameBarrage:Start()
		timerLightningDischarge:Cancel()
		timerOnySwipeCD:Cancel()
		timerNefSwipeCD:Cancel()
		timerOnyBreathCD:Cancel()
		timerNefBreathCD:Cancel()
	elseif msg == L.ShadowblazeCast then
		timerShadowBlazeCD:Start(shadowblazeTimer)
		self:ScheduleMethod(shadowblazeTimer, "ShadowBlazeTimer")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if (msg == L.NefAoe or msg:find(L.NefAoe)) and self:IsInCombat() then
		specWarnElectrocute:Show()
		timerElectrocute:Start()
	end
end

function mod:UNIT_DIED(args)
	if args.destName == L.ChromaticPrototype then
		deaths = deaths + 1
		if deaths == 3 then
			warnPhase3:Show()
			timerShadowflameBarrage:Cancel()
			timerShadowBlazeCD:Start()
		end
	end
end