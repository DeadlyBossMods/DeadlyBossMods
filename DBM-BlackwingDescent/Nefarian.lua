local mod	= DBM:NewMod("Nefarian-BD", "DBM-BlackwingDescent")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(41376, 41270)
mod:SetZone()

mod:SetBossHealthInfo(
	41376, L.Nefarian,		-- L.name = "Nefarian"
	41270, L.Onyxia
)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
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
local warnBlastNova				= mod:NewSpellAnnounce(80734, 3, nil, false)--Can be spammy so now off by default.
local warnShadowBlaze			= mod:NewSpellAnnounce(94085, 4)--May be quirky
local warnHailBones				= mod:NewSpellAnnounce(94104, 3, nil, false)--spams a lot (every ~2sec a new one spawns, 5 adds 10 man 12 adds 25 man)
local warnCinder				= mod:NewTargetAnnounce(79339, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warnDominion				= mod:NewTargetAnnounce(79318, 3)

local specWarnElectrocute		= mod:NewSpecialWarningSpell(81198)
local specWarnShadowblaze		= mod:NewSpecialWarningMove(94085)
local specWarnShadowblazeSoon	= mod:NewSpecialWarning("specWarnShadowblazeSoon", mod:IsTank())
local specWarnBlastsNova		= mod:NewSpecialWarningInterrupt(80734)
local specWarnCinder			= mod:NewSpecialWarningYou(79339)
local specWarnDominion			= mod:NewSpecialWarningYou(79318)
local specWarnStolenPower		= mod:NewSpecialWarningStack(80626, nil, 150)

local timerBlastNova			= mod:NewCastTimer(1.5, 80734)
local timerElectrocute			= mod:NewCastTimer(5, 81198)
local timerLightningDischarge	= mod:NewCDTimer(20, 77942)--92456, every 20-25 seconds. Need to emphesise this is a CD timer not a next timer. It will also only trigger if it hits something (including pets).
local timerShadowflameBarrage	= mod:NewBuffActiveTimer(150, 78621)
local timerShadowBlazeCD		= mod:NewCDTimer(10, 94085)
local timerOnySwipeCD			= mod:NewTimer(10, "OnySwipeTimer", 77827)--10-20 second cd (18 being the most consistent)
local timerNefSwipeCD			= mod:NewTimer(10, "NefSwipeTimer", 77827, false)--Same as hers, but not synced.
local timerOnyBreathCD			= mod:NewTimer(12, "OnyBreathTimer", 94124, mod:IsTank() or mod:IsHealer())--12-20 second variations
local timerNefBreathCD			= mod:NewTimer(12, "NefBreathTimer", 94124, mod:IsTank() or mod:IsHealer())--same as above
local timerCinder				= mod:NewBuffActiveTimer(8, 79339)--Heroic Ability
local timerDominionCD			= mod:NewNextTimer(15, 79318)

local berserkTimer				= mod:NewBerserkTimer(630)

mod:AddBoolOption("SetIconOnCinder", true)
mod:AddBoolOption("YellOnCinder", true, "announce")
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("InfoFrame")
mod:AddBoolOption("SetWater", false)

local deaths = 0
local spamShadowblaze = 0
local spamLightningDischarge = 0
local shadowblazeTimer = 35
local phase2ended = false
local cinderIcons = 8
local cinderTargets	= {}
local dominionTargets = {}

--Credits to Bigwigs for original, modified when blizz nerfed it.
function mod:ShadowBlazeFunction()
	if shadowblazeTimer > 10 then--Keep it from dropping below 10
		shadowblazeTimer = shadowblazeTimer - 5
	end
	warnShadowBlaze:Show()
	specWarnShadowblazeSoon:Schedule(shadowblazeTimer - 5)--Want the pre warning to stop warning once they are every 5 seconds.
	timerShadowBlazeCD:Start(shadowblazeTimer)
	self:ScheduleMethod(shadowblazeTimer, "ShadowBlazeFunction")
end

local function warnCinderTargets()
	warnCinder:Show(table.concat(cinderTargets, "<, >"))
	timerCinder:Start()
	table.wipe(cinderTargets)
	cinderIcons = 8
end

local function warnDominionTargets()
	warnDominion:Show(table.concat(dominionTargets, "<, >"))
	timerDominionCD:Start()
	table.wipe(dominionTargets)
end

function mod:OnCombatStart(delay)
	deaths = 0
	spamShadowblaze = 0
	spamLightningDischarge = 0
	shadowblazeTimer = 35
	phase2ended = false
	table.wipe(cinderTargets)
	table.wipe(dominionTargets)
	timerLightningDischarge:Start(30-delay)--First one seems pretty precise (it happens at same time nef lands.)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		berserkTimer:Start(-delay)
		timerDominionCD:Start(50-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.Charge)
		DBM.InfoFrame:Show(2, "enemypower", 5, ALTERNATE_POWER_INDEX)
	end
	if self.Options.SetWater and GetCVarBool("cameraWaterCollision") then
		SetCVar("cameraWaterCollision", 0)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.SetWater and not GetCVarBool("cameraWaterCollision") then
		SetCVar("cameraWaterCollision", 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(77826, 94124, 94125, 94126) and args:GetSrcCreatureID() == 41270 then--Onyxia's Breath
		warnOnyShadowflameBreath:Show()
		timerOnyBreathCD:Start()
	elseif args:IsSpellID(77826, 94124, 94125, 94126) and args:GetSrcCreatureID() == 41376 then--Nefarians Breath
		warnNefShadowflameBreath:Show()
		timerNefBreathCD:Start()
	elseif args:IsSpellID(80734) then
		warnBlastNova:Show()
		if args.sourceGUID == UnitGUID("target") then--Only show warning/timer for your own target.
			specWarnBlastsNova:Show()
			timerBlastNova:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(79339) then--Completedly drycoded off wowhead, don't know CD, or even how many targets, when I have logs this will be revised.
		cinderTargets[#cinderTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnCinder:Show()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)--according to in game tooltip for 79347, this has a 10 yard splash damage
			end
			if self.Options.YellOnCinder then
				SendChatMessage(L.YellCinder, "SAY")
			end
		end
		if self.Options.SetIconOnCinder then
			self:SetIcon(args.destName, cinderIcons)
			cinderIcons = cinderIcons - 1
		end
		self:Unschedule(warnCinderTargets)
		self:Schedule(0.3, warnCinderTargets)
	elseif args:IsSpellID(79318) then
		dominionTargets[#dominionTargets + 1] = args.destName
		self:Unschedule(warnDominionTargets)
		self:Schedule(0.3, warnDominionTargets)
		if args:IsPlayer() then
			specWarnDominion:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(80626, 80627) and args:IsPlayer() and (args.amount or 1) >= 150 then
		specWarnStolenPower:Show(args.amount)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(79339) then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.SetIconOnCinder then
			self:SetIcon(args.destName, 0)
		end
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
	if args:IsSpellID(78684, 94104, 94105, 94106) then
		warnHailBones:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		warnPhase2:Show()
		timerLightningDischarge:Cancel()
		timerOnySwipeCD:Cancel()
		timerNefSwipeCD:Cancel()
		timerOnyBreathCD:Cancel()
		timerNefBreathCD:Cancel()
		timerDominionCD:Cancel()
		timerShadowflameBarrage:Start()
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then
		warnPhase3:Show()
		timerShadowBlazeCD:Start(12)--Seems to vary some, from 11-13 so 12 should be a happy medium, it'll always be about 1 second off in either direction though.
		self:ScheduleMethod(12, "ShadowBlazeFunction")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if (msg == L.NefAoe or msg:find(L.NefAoe)) and self:IsInCombat() then
		specWarnElectrocute:Show()
		timerElectrocute:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 41948 then
		deaths = deaths + 1
		if (deaths == 3 or mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) and not phase2ended then
			timerShadowflameBarrage:Cancel()
			phase2ended = true
		end
	elseif cid == 41270 then
		DBM.BossHealth:RemoveBoss(cid)
	end
end