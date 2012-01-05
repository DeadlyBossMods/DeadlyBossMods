local mod	= DBM:NewMod(324, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(55308)
mod:SetModelID(39138)
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnVoidofUnmaking		= mod:NewSpellAnnounce(103571, 4, 103527)
local warnVoidDiffusion			= mod:NewStackAnnounce(106836, 2)
local warnFocusedAnger			= mod:NewStackAnnounce(104543, 3, nil, false)
local warnPsychicDrain			= mod:NewSpellAnnounce(104322, 4)
local warnShadows				= mod:NewSpellAnnounce(103434, 3)

local specWarnVoidofUnmaking	= mod:NewSpecialWarningSpell(103571, nil, nil, nil, true)
local specWarnBlackBlood		= mod:NewSpecialWarningSpell(104378, nil, nil, nil, true)
local specWarnPsychicDrain		= mod:NewSpecialWarningSpell(104322, false)
local specWarnShadows			= mod:NewSpecialWarningYou(103434)
local yellShadows				= mod:NewYell(103434, nil, false, L.ShadowYell)--Requested by 10 man guilds, but a spammy mess in 25s, so off by default. With the option to enable when desired.

local timerVoidofUnmakingCD		= mod:NewCDTimer(90.3, 103571, nil, nil, nil, 103527)
local timerVoidDiffusionCD		= mod:NewCDTimer(5, 106836)--Can not be triggered more then once per 5 seconds.
local timerFocusedAngerCD		= mod:NewCDTimer(6, 104543, nil, false)--Off by default as it may not be entirely useful information to know, but an option just for heck of it. You know SOMEONE is gonna request it
local timerPsychicDrainCD		= mod:NewCDTimer(20, 104322)--Every 20-25 seconds, variates.
local timerShadowsCD			= mod:NewCDTimer(25, 103434)--Every 25-30, variates
local timerBlackBlood			= mod:NewBuffActiveTimer(30, 104378)

local berserkTimer				= mod:NewBerserkTimer(360)

mod:AddDropdownOption("CustomRangeFrame", {"Never", "Normal", "DynamicPhase2", "DynamicAlways"}, "Dynamic3Always", "misc")

local shadowsTargets = {}
local phase2Started = false
local voidWarned = false

--[[
local voidTimers = { -- all timers is guessed and can't find in my logs (: please check this,
	[0] = 48, --Unknown
	[1] = 43, --Confirmed 25 lfr
	[2] = 38, --Unknown
	[3] = 33, --Confirmed 33 on 10 man heroic and 10 man normal
	[4] = 28, --Unknown
	[5] = 22, --Confirmed 22 normal 10 and normal 25
	[6] = 9.5, --Questionable 9.5 on 10 man normal. Had one log with this timing but it makes no sense. I'd like to verify it further. This makes no sense in the pattern. maybe a bad time stamp, 19.5 would make more sense IMO
	[7] = 12, --Confirmed, 3 seconds earlier then heroic in both 10 and 25 normal.
	[8] = 6, --Confirmed, 25 lfr.. in sometimes Void Diffusion comes slowly. He absorbs orb at 8 stacks.
	[9] = 6, --Assumed, maybe 8 >= stacks fixed to 6 sec?
	[10]= 6 --Confirmed
}
local heroicvoidTimers = { -- all timers is guessed and can't find in my logs (: please check this,
	[0] = 48, --Unknown
	[1] = 43, --Unknown
	[2] = 38, --Unknown
	[3] = 33, --Confirmed 33 on 10 man heroic and 10 man normal
	[4] = 28, --Unknown
	[5] = 22, --Unknown for heroic, could be 22, or 25. the 9 7 7 5 strategy lacks the luxury of seeing the 4th black phase end :(
	[6] = 15, --Unknown. assumed no lower then 15 though.
	[7] = 15, --Confirmed in 10 heroic and 25 man heroic
	[8] = 15, --Unknown, but unlikely changed being in the middle of 7 and 9
	[9] = 15, --Confirmed in 10 heroic and 25 man heroic
	[10]= 15, --Assumed, maybe heroic min time is 15 sec.
}
]]

local function warnShadowsTargets()
	warnShadows:Show(table.concat(shadowsTargets, "<, >"))
	timerShadowsCD:Start()
	table.wipe(shadowsTargets)
end

local shadowsDebuffFilter
do
	shadowsDebuffFilter = function(uId)
		return UnitDebuff(uId, (GetSpellInfo(103434)))
	end
end

--"Never", "Normal", "DynamicPhase2", "DynamicAlways"
function mod:updateRangeFrame()
	if self:IsDifficulty("normal10", "normal25", "lfr25") or self.Options.CustomRangeFrame == "Never" then return end
	if self.Options.CustomRangeFrame == "Normal" or UnitDebuff("player", GetSpellInfo(103434)) or self.Options.CustomRangeFrame == "DynamicPhase2" and not phase2started then--You have debuff or only want normal range frame or it's phase 1 and you only want dymanic in phase 2
		DBM.RangeCheck:Show(10, nil)--Show everyone.
	else
		DBM.RangeCheck:Show(10, shadowsDebuffFilter)--Show only people who have debuff.
	end
end

local function blackBloodEnds()
	voidWarned = false
	phase2Started = false
	timerFocusedAngerCD:Start(6)
	timerShadowsCD:Start(6)
	--it's timer depends on Void Diffusion stacks. But since timer not confirmed, temporarly commented it.
	--It DOES appear to be difficulty based to a minor extent, i've verified it through MANY guilds 10 and 25 herioc logs. particularly the 7-9 stack on heroic without a doubt being 3 seconds later then normal in every log.
	--Still need data for the following (0, 2, 4, 6, 8 stacks in all difficulties. 1, 10 for heroic difficulties. 8 and 9 for normal difficulties)
end

function mod:OnCombatStart(delay)
	voidWarned = false
	phase2Started = false
	table.wipe(shadowsTargets)
	timerVoidofUnmakingCD:Start(5.5-delay)
	timerFocusedAngerCD:Start(10.5-delay)
	timerPsychicDrainCD:Start(16.5-delay)
	timerShadowsCD:Start(-delay)
	self:updateRangeFrame()
	if not self:IsDifficulty("lfr25") then--Can confirm what others saw, LFR definitely doesn't have a 6 min berserk. It's either much longer or not there.
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.CustomRangeFrame ~= "Never" then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104322, 104606, 104607, 104608) then--104378 confirmed 10 man normal
		warnPsychicDrain:Show()
		specWarnPsychicDrain:Show()
		timerPsychicDrainCD:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104377, 104378, 110322, 110306) and not phase2Started then--All spellids Confirmed
		phase2Started = true
		timerFocusedAngerCD:Cancel()
		timerPsychicDrainCD:Cancel()
		timerShadowsCD:Cancel()
		specWarnBlackBlood:Show()
		timerBlackBlood:Start()
		self:Schedule(30, blackBloodEnds)--More accurate way then tracking spell aura removed of black blood. Players dying in the phase were falsely triggering the phase ending early.
		--GetTime() Method returns elapsed values. so this will be working intended?
		if self:IsDifficulty("heroic10", "heroic25") then
			if timerVoidofUnmakingCD:GetTime() > 45.3 then--Heroic has a failsafe in place, if CD exausts before 15 seconds after black phase ending, it's extended, probably to allow raid more time to repositoin vs normal
				timerVoidofUnmakingCD:Update(45.3, 90.3)
			end
		else
			if timerVoidofUnmakingCD:GetTime() > 54.3 then--Normal also has a failsafe but much smaller, if it comes off CD before 6 seconds has passed after dark, it gets delayed until 6 seconds have passed
				timerVoidofUnmakingCD:Update(54.3, 90.3)
			end
		end
	elseif args:IsSpellID(104543, 109409, 109410, 109411) then--104543 confirmed 10 man normal
		warnFocusedAnger:Show(args.destName, args.amount or 1)
		timerFocusedAngerCD:Start()
	elseif args:IsSpellID(106836) then--106836 confirmed 10/25 man normal, do NOT add 103527 to this, that's a seperate spellid for when BOSS is affected by diffusion, this warning is counting the ball stacks.
		warnVoidDiffusion:Show(args.destName, args.amount or 1)
		timerVoidDiffusionCD:Start()
	elseif args:IsSpellID(103434, 104599, 104600, 104601) then--103434 confirmed 10 man normal.
		shadowsTargets[#shadowsTargets + 1] = args.destName
		if args:IsPlayer() and self:IsDifficulty("heroic10", "heroic25") then
			specWarnShadows:Show()
			yellShadows:Yell()
			self:updateRangeFrame()
		end
		self:Unschedule(warnShadowsTargets)
		if (self:IsDifficulty("normal10") and #shadowsTargets >= 3) then--Don't know the rest yet, will tweak as they are discovered
			warnShadowsTargets()
		else
			self:Schedule(0.3, warnShadowsTargets)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104600, 104601) and args:IsPlayer() then--Only heroic spellids here, no reason to call functions that aren't needed on normal or LFR
		self:updateRangeFrame()
	end
end

--It looks this event doesn't fire in raid finder. It seems to still fire in normal and heroic modes.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellID)
	if uId ~= "boss1" then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	--Void of the unmaking cast, do not use spellname because we want to ignore events using spellid 103627 which fires when the sphere dispurses on the boss.
	if spellID == 103571 and not voidWarned then--This spellid is same in 10/25 and raid finder, and assuming also same in heroic. No reason to use spellname, or other IDs.
		if timerPsychicDrainCD:GetTime() == 0 then--Just a hack to prevent this from overriding first timer on pull, which is only drain that doesn't follow this rule
			timerPsychicDrainCD:Start(8.5)
		end
		timerVoidofUnmakingCD:Start()
		voidWarned = true
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
	end
end

--"<10.8> [UNIT_SPELLCAST_SUCCEEDED] Warlord Zon'ozz:Possible Target<Erej>:boss1:Void of the Unmaking::0:103571", -- [371]
--"<11.0> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Gul'kafh an'qov N'Zoth.#Warlord Zon'ozz###Warlord Zon'ozz##0#0##0#3201##0#false", -- [413]
--Backup trigger for LFR where UNIT_SPELLCAST_SUCCEEDED doesn't fire for void cast
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.voidYell or msg:find(L.voidYell)) and not voidWarned then
		timerPsychicDrainCD:Start(8.3)--Yell comes .2 after unit event, so we adjust the timers.
		timerVoidofUnmakingCD:Start(90.1)
		voidWarned = true
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
	end
end