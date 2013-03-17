local mod	= DBM:NewMod(819, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68476)
mod:SetModelID(47325)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--[[
TODO: See if this has some target scanning. On heroic these can one shot non tanks
"<431.7 15:32:55> [CLEU] SPELL_CAST_SUCCESS#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128##Unknown#-2147483648#-2147483648#136487#Lightning Nova Totem#1", -- [67956]
"<431.7 15:32:55> [CLEU] SPELL_SUMMON#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128#0xF1310E5F00002779#Lightning Nova Totem#2600#0#136487#Lightning Nova Totem#1", -- [67957]
--]]
local warnCharge				= mod:NewTargetAnnounce(136769, 4)
local warnPuncture				= mod:NewStackAnnounce(136767, 2, nil, mod:IsTank() or mod:IsHealer())
local warnDoubleSwipe			= mod:NewSpellAnnounce(136741, 3)
local warnAdds					= mod:NewAnnounce("warnAdds", 2, 43712)--Some random troll icon
local warnDino					= mod:NewSpellAnnounce("ej7086", 3, 137237)
local warnMending				= mod:NewSpellAnnounce(136797, 4)
local warnVenomBolt				= mod:NewSpellAnnounce(136587, 3, nil, false)
local warnChainLightning		= mod:NewSpellAnnounce(136480, 3, nil, false)
local warnFireball				= mod:NewSpellAnnounce(136465, 3, nil, false)
local warnBestialCry			= mod:NewStackAnnounce(136817, 3)
local warnRampage				= mod:NewTargetAnnounce(136821, 4, nil, mod:IsTank() or mod:IsHealer())
local warnDireCall				= mod:NewSpellAnnounce(137458, 3)
local warnDireFixate			= mod:NewTargetAnnounce(140946, 4)

local specWarnCharge			= mod:NewSpecialWarningYou(136769)--Maybe add a near warning later. person does have 3.4 seconds to react though and just move out of group.
local yellCharge				= mod:NewYell(136769)
local specWarnDoubleSwipe		= mod:NewSpecialWarningSpell(136741, nil, nil, nil, 2)
local specWarnPuncture			= mod:NewSpecialWarningStack(136767, mod:IsTank(), 9)--9 seems like a good number, we'll start with that. Timing wise the swap typically comes when switching gates though.
local specWarnPunctureOther		= mod:NewSpecialWarningTarget(136767, mod:IsTank())
local specWarnSandTrap			= mod:NewSpecialWarningMove(136723)
local specWarnDino				= mod:NewSpecialWarningSwitch("ej7086", not mod:IsHealer())
local specWarnMending			= mod:NewSpecialWarningInterrupt(136797, mod:IsDps())--High priority interrupt. All dps needs warning because boss heals 1% per second it's not interrupted.
local specWarnVenomBolt			= mod:NewSpecialWarningInterrupt(136587)--Can be on for all since it only triggers off target/focus
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(136480)--Can be on for all since it only triggers off target/focus
local specWarnFireball			= mod:NewSpecialWarningInterrupt(136465)--Can be on for all since it only triggers off target/focus
local specWarnLivingPoison		= mod:NewSpecialWarningMove(136646)
local specWarnFrozenBolt		= mod:NewSpecialWarningMove(136573)--Debuff used by Frozen Orbs
local specWarnLightningNova		= mod:NewSpecialWarningMove(136490)--Mainly for LFR or normal. On heroic you're going to die.
local specWarnJalak				= mod:NewSpecialWarningSwitch("ej7087", mod:IsTank())--To pick him up (and maybe dps to switch, depending on strat)
local specWarnRampage			= mod:NewSpecialWarningTarget(136821, mod:IsTank() or mod:IsHealer())--Dog is pissed master died, need more heals and cooldowns. Maybe warn dps too? his double swipes and charges will be 100% worse too.
local specWarnDireCall			= mod:NewSpecialWarningSpell(137458, nil, nil, nil, 2)--Heroic
local specWarnDireFixate		= mod:NewSpecialWarningRun(140946)--Heroic

local timerDoor					= mod:NewTimer(113.5, "timerDoor", 2457)--They seem to be timed off last door start, not last door end. They MAY come earlier if you kill off all first doors adds though not sure yet. If they do, we'll just start new timer anyways
local timerAdds					= mod:NewTimer(18.91, "timerAdds", 43712)
local timerDinoCD				= mod:NewNextTimer(56.75, "ej7086", nil, nil, nil, 137237)--It's between 55 and 60 seconds, I will need a more thorough log to verify by yelling when they spawn
local timerCharge				= mod:NewCastTimer(3.4, 136769)
local timerChargeCD				= mod:NewCDTimer(50, 136769)--50-60 second depending on i he's casting other stuff or stunned
local timerDoubleSwipeCD		= mod:NewCDTimer(18, 136741)--18 second cd unless delayed by a charge triggered double swipe, then it's extended by failsafe code
local timerPuncture				= mod:NewTargetTimer(90, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerPunctureCD			= mod:NewCDTimer(11, 136767, nil, mod:IsTank() or mod:IsHealer())
local timerJalakCD				= mod:NewNextTimer(10, "ej7087", nil, nil, nil, 2457)--Maybe it's time for a better worded spawn timer than "Next mobname". Maybe NewSpawnTimer with "mobname activates" or something.
local timerBestialCryCD			= mod:NewNextCountTimer(10, 136817)
local timerDireCallCD			= mod:NewCDTimer(62, 137458)--Heroic (every 62-70 seconds)

local berserkTimer				= mod:NewBerserkTimer(720)

local soundDireFixate			= mod:NewSound(140946)

local doorNumber = 0
local jalakEngaged = false
local Farraki	= EJ_GetSectionInfo(7081)
local Gurubashi	= EJ_GetSectionInfo(7082)
local Drakkari	= EJ_GetSectionInfo(7083)
local Amani		= EJ_GetSectionInfo(7084)

function mod:OnCombatStart(delay)
	doorNumber = 0
	jalakEngaged = false
	timerPunctureCD:Start(-delay)
	timerDoubleSwipeCD:Start(16-delay)--16-17 second variation
	timerDoor:Start(16.5-delay)
	timerChargeCD:Start(31-delay)--31-35sec variation
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDireCallCD:Start(-delay)
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

--[[
Back to backs, as expected
"<244.6 15:11:23> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [17383]
"<262.7 15:11:42> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [19036]
Delayed by Charge version
"<59.8 15:08:19> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [4747]
"<70.7 15:08:30> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136769#Charge#1", -- [5273]
"<74.8 15:08:34> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136770#Double Swipe#1", -- [5452]
"<86.4 15:08:45> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#2632#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [6003]
--]]
function mod:SPELL_CAST_START(args)
	if args:IsSpellID(136741) then--Regular double swipe
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		--The only flaw is charge is sometimes delayed by unexpected events like using an orb, we may fail to start timer once in a while when it DOES come before a charge.
		if timerChargeCD:GetTime() < 32 then--Check if charge is less than 18 seconds away, if it is, double swipe is going tobe delayed by quite a bit and we'll trigger timer after charge
			timerDoubleSwipeCD:Start()
		end
	elseif args:IsSpellID(136770) then--Double swipe that follows a charge (136769)
		warnDoubleSwipe:Show()
		specWarnDoubleSwipe:Show()
		timerDoubleSwipeCD:Start(11.5)--Hard coded failsafe. 136741 version is always 11.5 seconds after 136770 version
	elseif args:IsSpellID(137458) then
		warnDireCall:Show()
		specWarnDireCall:Show()
		timerDireCallCD:Start()--CD is reset when he breaks a door though.
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(136767) then
		warnPuncture:Show(args.destName, args.amount or 1)
		timerPuncture:Start(args.destName)
		timerPunctureCD:Start()
		if args:IsPlayer() then
			if (args.amount or 1) >= 9 then
				specWarnPuncture:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 9 and not UnitDebuff("player", GetSpellInfo(136767)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnPunctureOther:Show(args.destName)--So nudge you to taunt it off other tank already.
			end
		end
	--"<317.2 15:12:36> [CLEU] SPELL_AURA_APPLIED_DOSE#false#0xF1310B7C0000383C#Horridon#68168#0#0xF1310B7C0000383C#Horridon#68168#0#137240#Cracked Shell#1#BUFF#4", -- [21950]
	--"<327.0 15:12:46> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000383C#elite#261178058#1#1#War-God Jalak <--War-God Jalak jumps down
	--He jumps down 10 seconds after 4th door is smashed, or when Horridon reaches 30%
	elseif args:IsSpellID(136817) then
		warnBestialCry:Show(args.destName, args.amount or 1)
		timerBestialCryCD:Start(10, (args.amount or 1)+1)
	elseif args:IsSpellID(136821) then
		warnRampage:Show(args.destName)
		specWarnRampage:Show(args.destName)
	elseif args:IsSpellID(136797) then
		warnMending:Show()
		specWarnMending:Show(args.sourceName)
	elseif args:IsSpellID(136587) then
		warnVenomBolt:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnVenomBolt:Show(args.sourceName)
		end
	elseif args:IsSpellID(136480) then
		warnChainLightning:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnChainLightning:Show(args.sourceName)
		end
	elseif args:IsSpellID(136465) then
		warnFireball:Show()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnFireball:Show(args.sourceName)
		end
	elseif args:IsSpellID(140946) then
		warnDireFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnDireFixate:Show()
			soundDireFixate:Play()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(136767) then
		timerPuncture:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 136723 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnSandTrap:Show()
	elseif spellId == 136646 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnLivingPoison:Show()
	elseif spellId == 136573 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnFrozenBolt:Show()
	elseif spellId == 136490 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnLightningNova:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE


--"<372.2 21:39:53> [RAID_BOSS_EMOTE] RAID_BOSS_EMOTE#Amani forces pour from the Amani Tribal Door!#War-God Jalak#0#false", -- [77469]
--"<515.3 21:42:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000467C#elite#522686397#1#1#War-God Jalak
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if UnitExists("boss2") and tonumber(UnitGUID("boss2"):sub(6, 10), 16) == 69374 and not jalakEngaged then--Jalak is jumping down
		jalakEngaged = true--Set this so we know not to concern with 4th door anymore (plus so we don't fire extra warnings when we wipe and ENGAGE fires more)
		timerJalakCD:Cancel()
		specWarnJalak:Show()
		timerBestialCryCD:Start(5, 1)
		self:UnregisterShortTermEvents()--TODO, maybe add unit health checks to warn dog is close to 40% if we aren't done with doors yet. If it's added, we can unregister health here as well
	end
end

local function addsDelay(addsType)
	timerAdds:Start(18.9, addsType)
	warnAdds:Schedule(18.9, addsType)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.chargeTarget) then
		self:SendSync("Charge", target)
	elseif msg:find(L.newForces) then
		self:SendSync("Door")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69374 then
		timerBestialCryCD:Cancel()
	end
end

function mod:OnSync(msg, target)
	if msg == "Phase2" then
		warnCharge:Show(target)
		timerCharge:Start()
		timerChargeCD:Start()
		if target == UnitName("player") then
			specWarnCharge:Show()
			yellCharge:Yell()
		end
	elseif msg == "Door" then
	--Doors spawn every 131.5 seconds
	--Halfway through it (literlaly exact center) Dinomancers spawn at 56.75
	--Then, before the dinomancer, lesser adds spawn twice splitting that timer into 3rds
	--So it goes, door, 18.91 seconds later, 1 add jumps down. 18.91 seconds later, next 2 drop down. 18.91 seconds later, dinomancer drops down, then 56.75 seconds later, next door starts.
		doorNumber = doorNumber + 1
		timerDinoCD:Start()
		warnDino:Schedule(56.75)
		specWarnDino:Schedule(56.75)
		if doorNumber == 1 then
			timerAdds:Start(18.9, Farraki)
			warnAdds:Schedule(18.9, Farraki)
			self:Schedule(18.9, addsDelay, Farraki)
		elseif doorNumber == 2 then
			timerAdds:Start(18.9, Gurubashi)
			warnAdds:Schedule(18.9, Gurubashi)
			self:Schedule(18.9, addsDelay, Gurubashi)
		elseif doorNumber == 3 then
			timerAdds:Start(18.91, Drakkari)
			warnAdds:Schedule(18.9, Drakkari)
			self:Schedule(18.9, addsDelay, Drakkari)
		elseif doorNumber == 4 then
			timerAdds:Start(18.9, Amani)
			warnAdds:Schedule(18.9, Amani)
			self:Schedule(18.9, addsDelay, Amani)
		end
		if doorNumber < 4 then
			timerDoor:Start()
		else
			if not jalakEngaged then
				timerJalakCD:Start(143)
			end
		end
	end
end
