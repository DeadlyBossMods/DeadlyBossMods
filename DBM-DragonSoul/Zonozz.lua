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

local timerVoidofUnmakingCD		= mod:NewCDTimer(6, 103571, nil, nil, nil, 103527)
local timerVoidDiffusionCD		= mod:NewCDTimer(5, 106836)--Can not be triggered more then once per 5 seconds.
local timerFocusedAngerCD		= mod:NewCDTimer(6, 104543, nil, false)--Off by default as it may not be entirely useful information to know, but an option just for heck of it. You know SOMEONE is gonna request it
local timerPsychicDrainCD		= mod:NewCDTimer(20, 104322)--Every 20-25 seconds, variates.
local timerShadowsCD			= mod:NewCDTimer(25, 103434)--Every 25-30, variates
local timerBlackBlood			= mod:NewBuffActiveTimer(30, 104378)

local berserkTimer				= mod:NewBerserkTimer(360)

mod:AddBoolOption("RangeFrame", true)--For heroic shadows, with debuff filtering.
mod:AddBoolOption("NoFilterRangeFrame", false)--For those that want the range frame to simply work as it used to, always show everyone.

local shadowsTargets = {}
local phase2Started = false
local voidWarned = false
--local voidStacks = 0

--[[
local voidTimers = { -- all timers is guessed and can't find in my logs (: please check this,
	[0] = 48,
	[1] = 43, -- confirmed in my latest lfr.
	[2] = 38,
	[3] = 33,
	[4] = 28,
	[5] = 22.5,
	[6] = 18,
	[7] = 15,
	[8] = 12,
	[9] = 9,
	[10]= 6
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

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end -- only update/show if this is enabled
	if not self:IsDifficulty("heroic10", "heroic25") then return end--Not needed on normal or LFR
	if self.Options.NoFilterRangeFrame or UnitDebuff("player", GetSpellInfo(103434)) then
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
	--absolutely not difficulty based. it's timer depends on Void Diffusion stacks. But since timer not confirmed, temporarly commented it.
	--My guild does 9 7 7 5 on heroic, i'll run a new transcriptor log to confirm there is any diff between the 9 and the 7s for you. I don't remember one though.
	--[[
	timerVoidofUnmakingCD:Start(voidTimers[voidStacks])
	timerPsychicDrainCD:Start(voidTimers[voidStacks] + 8.5)
	voidStacks = 0
	]]
	if mod:IsDifficulty("lfr25") then -- absoultely 10 stacks
		timerVoidofUnmakingCD:Start()
		timerPsychicDrainCD:Start(14.5)
	elseif mod:IsDifficulty("normal25") then -- maybe 8 stacks?
		timerVoidofUnmakingCD:Start(12)
		timerPsychicDrainCD:Start(20.5)
	elseif mod:IsDifficulty("heroic10", "heroic25") then -- maybe 7 stacks?
		timerVoidofUnmakingCD:Start(15)
		timerPsychicDrainCD:Start(23.5)
	elseif mod:IsDifficulty("normal10") then -- maybe 5 stacks?
		timerVoidofUnmakingCD:Start(22.5)
		timerPsychicDrainCD:Start(31)
	end
end

function mod:OnCombatStart(delay)
	voidWarned = false
	phase2Started = false
--	voidStacks = 0
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
	if self.Options.RangeFrame then
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
	elseif args:IsSpellID(104543, 109409, 109410, 109411) then--104543 confirmed 10 man normal
		warnFocusedAnger:Show(args.destName, args.amount or 1)
		timerFocusedAngerCD:Start()
	elseif args:IsSpellID(106836) then--106836 confirmed 10/25 man normal, do NOT add 103527 to this, that's a seperate spellid for when BOSS is affected by diffusion, this warning is counting the ball stacks.
		warnVoidDiffusion:Show(args.destName, args.amount or 1)
		timerVoidDiffusionCD:Start()
--		if args.amount or 1 < 11 then
--			voidStacks = args.amount or 1
--		end
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
		timerVoidofUnmakingCD:Cancel()
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
		timerVoidofUnmakingCD:Cancel()
		voidWarned = true
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
	end
end