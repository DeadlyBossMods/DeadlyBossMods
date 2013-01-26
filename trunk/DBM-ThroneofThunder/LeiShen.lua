if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(832, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68397)
--[[
Diffusion Chain Conduit 68696
Static Shock Conduit 68398
Bouncing Bolt conduit 68698
Overcharge conduit 68697
--]]
mod:SetModelID(46770)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Conduits
local warnStaticShock					= mod:NewTargetAnnounce(135695, 4)
local warnDiffusionChain				= mod:NewTargetAnnounce(135991, 3)--More informative than actually preventative. (you need to just spread out, and that's it. can't control who it targets only that it doesn't spread)
local warnOvercharged					= mod:NewTargetAnnounce(136295, 3)
local warnBouncingBolt					= mod:NewSpellAnnounce(136395, 3)

--Phase 1
local warnThunderstruck					= mod:NewSpellAnnounce(135095, 3)--Target scanning seems to not work
local warnDecapitate					= mod:NewTargetAnnounce(135000, 4, nil, mod:IsTank() or mod:IsHealer())

--Conduits
local specWarnStaticShock				= mod:NewSpecialWarningYou(135695)
local yellOvercharged					= mod:NewYell(136295)--Person it's on is snared and can't move. Special warning not useful since they don't react to it, everyone else does
local specWarnOvercharged				= mod:NewSpecialWarningSpell(136295, false)--Maybe this though to alert everyone else it was cast.
local specWarnBouncingBolt				= mod:NewSpecialWarningSpell(136395, false)

--Phase 1
local specWarnDecapitate				= mod:NewSpecialWarningRun(135000, mod:IsTank())
local specWarnDecapitateOther			= mod:NewSpecialWarningTarget(135000, mod:IsTank())
local specWarnThunderstruck				= mod:NewSpecialWarningSpell(135095, nil, nil, nil, true)

--Conduits
---No timers, since we rotated platforms so often in our strat, we never learned any ability cooldown.

--Phase 1
local timerDecapitateCD					= mod:NewCDTimer(50, 135000)
local timerThunderstruckCD				= mod:NewCDTimer(46, 135095)

local timerSuperChargedConduits			= mod:NewBuffActiveTimer(45, 137146)

local intermission = 0
local phase = 1
local conduitsDestroyed = 0000--NESW(North, East, South, West)
local staticshockTargets = {}
local overchargeTarget = {}

local function warnStaticShockTargets()
	warnStaticShock:Show(table.concat(staticshockTargets, "<, >"))
	table.wipe(staticshockTargets)
end

local function warnOverchargeTargets()
	warnOvercharged:Show(table.concat(overchargeTarget, "<, >"))
	table.wipe(overchargeTarget)
end

function mod:OnCombatStart(delay)
	table.wipe(staticshockTargets)
	table.wipe(overchargeTarget)
	intermission = 0
	phase = 1
	conduitsDestroyed = 0000
	timerThunderstruckCD:Start(25-delay)
	timerDecapitateCD:Start(45-delay)--Either it comes earlier than reg cd on rare occasions, or i have CD wrong.
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(135095) then
		warnThunderstruck:Show()
		specWarnThunderstruck:Show()
		timerThunderstruckCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(135000) then
		warnDecapitate:Show(args.destName)
		timerDecapitateCD:Start()
		if args:IsPlayer() then
			specWarnDecapitate:Show()
		else
			specWarnDecapitateOther:Show(args.destName)
		end
	--Conduit activations
	elseif args:IsSpellID(135695) then
		staticshockTargets[#staticshockTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnStaticShock:Show()
		end
		self:Unschedule(warnStaticShockTargets)
		self:Schedule(0.3, warnStaticShockTargets)
	elseif args:IsSpellID(136295) then
		overchargeTarget[#overchargeTarget + 1] = args.destName
		if args:IsPlayer() then
			yellOvercharged:Yell()
		end
		self:Unschedule(warnOverchargeTargets)
		self:Schedule(0.3, warnOverchargeTargets)
--[[
	elseif args:IsSpellID(135680) and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--start timers here when we have em
	elseif args:IsSpellID(135681) and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
	
	elseif args:IsSpellID(135682) and args:GetDestCreatureID() == 68397 then--South (Overcharge)
	
	elseif args:IsSpellID(135683) and args:GetDestCreatureID() == 68397 then--West (Bouncing Bolt)
		
	--Conduit activations--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(135991) then
		warnDiffusionChain:Show(args.destName)
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	--Conduit deactivations
	if args:IsSpellID(135680) and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--Cancel timers here when we have them
	elseif args:IsSpellID(135681) and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
	
	elseif args:IsSpellID(135682) and args:GetDestCreatureID() == 68397 then--South (Overcharge)
	
	elseif args:IsSpellID(135683) and args:GetDestCreatureID() == 68397 then--West (Bouncing Bolt)
		
	--Conduit deactivations
	end
end--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137176") then--Overloaded Circuits (Intermission ending and next phase beginning)
		phase = phase + 1
		timerSuperChargedConduits:Start()
		--"<174.8 20:38:26> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\spell_nature_unrelentingstorm.blp:20|t The |cFFFF0000|Hspell:135683|h[West Conduit]|h|r has burned out and caused |cFFFF0000|Hspell:137176|h[Overloaded Circuits]|h|r!#Bouncing Bolt Conduit
		if msg:find("spell:135680") then--North (Static Shock)
			conduitsDestroyed = conduitsDestroyed + 1000--NESW(North, East, South, West)
		elseif msg:find("spell:135681") then--East (Diffusion Chain)
			conduitsDestroyed = conduitsDestroyed + 0100--NESW(North, East, South, West)
		elseif msg:find("spell:135682") then--South (Overcharge)
			conduitsDestroyed = conduitsDestroyed + 0010--NESW(North, East, South, West)
		elseif msg:find("spell:135683") then--West (Bouncing Bolt)
			conduitsDestroyed = conduitsDestroyed + 0001--NESW(North, East, South, West)
		end
		if phase == 2 then--Start Phase 2 timers
		
		elseif phase == 3 then--Start Phase 3 timers
		
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137146 and self:AntiSpam(2, 1) then--Supercharge Conduits
		intermission = intermission + 1
		if intermission == 1 then--Cancel Phase 1 timers
			timerThunderstruckCD:Cancel()
			timerDecapitateCD:Cancel()
		elseif intermission == 2 then--Cancel Phase 2 timers
		
		end
	elseif spellId == 136395 and self:AntiSpam(2, 2) then--Bouncing Bolt
		warnBouncingBolt:Show()
		specWarnBouncingBolt:Show()
	end
end
