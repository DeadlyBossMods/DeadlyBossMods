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
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Conduits (All phases)
local warnStaticShock					= mod:NewTargetAnnounce(135695, 4)
local warnDiffusionChain				= mod:NewTargetAnnounce(135991, 3)--More informative than actually preventative. (you need to just spread out, and that's it. can't control who it targets only that it doesn't spread)
local warnOvercharged					= mod:NewTargetAnnounce(136295, 3)
local warnBouncingBolt					= mod:NewSpellAnnounce(136361, 3)
--Phase 1
local warnDecapitate					= mod:NewTargetAnnounce(135000, 4, nil, mod:IsTank() or mod:IsHealer())
local warnThunderstruck					= mod:NewSpellAnnounce(135095, 3)--Target scanning seems to not work
--Phase 2
local warnFusionSlash					= mod:NewSpellAnnounce(136478, 4, nil, mod:IsTank() or mod:IsHealer())
local warnLightningWhip					= mod:NewSpellAnnounce(136850, 3)
local warnSummonBallLightning			= mod:NewSpellAnnounce(136543, 3)--This seems to be VERY important to spread for. It spawns an orb for every person who takes damage. MUST range 6 this.
--Phase 3

--Conduits (All phases)
local specWarnStaticShock				= mod:NewSpecialWarningYou(135695)
local yellOvercharged					= mod:NewYell(136295)--Person it's on is snared and can't move. Personal Special warning not useful since they don't react to it, everyone else does
local specWarnOvercharged				= mod:NewSpecialWarningSpell(136295, false)--Maybe this though to alert everyone else it was cast.
local specWarnBouncingBolt				= mod:NewSpecialWarningSpell(136361, false)
--Phase 1
local specWarnDecapitate				= mod:NewSpecialWarningRun(135000, mod:IsTank())
local specWarnDecapitateOther			= mod:NewSpecialWarningTarget(135000, mod:IsTank())
local specWarnThunderstruck				= mod:NewSpecialWarningSpell(135095, nil, nil, nil, 2)
--Phase 2
local specWarnFusionSlash				= mod:NewSpecialWarningSpell(136478, mod:IsTank(), nil, nil, 3)--Cast (394514 is debuff. We warn for cast though because it knocks you off platform if not careful)
local specWarnLightningWhip				= mod:NewSpecialWarningSpell(136850, nil, nil, nil, 2)
local specWarnSummonBallLightning		= mod:NewSpecialWarningSpell(136543, nil, nil, nil, 2)
--Phase 3

--Conduits (All phases)
local timerStaticchargeCD				= mod:NewCDTimer(50, 135695)--Unknown actual cd, besides when first one is in intermission
local timerDiffusionChainCD				= mod:NewCDTimer(50, 135991)--Unknown actual cd, besides when first one is in intermission
local timerOverchargeCD					= mod:NewCDTimer(50, 136295)--Unknown actual cd, besides when first one is in intermission
local timerBouncingBoltCD				= mod:NewCDTimer(50, 136361)--Unknown actual cd, besides when first one is in intermission
local timerSuperChargedConduits			= mod:NewBuffActiveTimer(50, 137045)--Actually intermission only, but it fits best with conduits
--Phase 1
local timerDecapitateCD					= mod:NewCDTimer(50, 135000)--Cooldown with some variation. 50-57ish or so.
local timerThunderstruckCD				= mod:NewNextTimer(46, 135095)--Seems like an exact bar
--Phase 2
local timerFussionSlashCD				= mod:NewCDTimer(50, 136478)--Clearly blizz messed up. Debuff lasts 45 seconds but cd is 50. This makes it a one tank fight despite debuff. I fully expect this to be shortened or debuff increased
local timerLightningWhipCD				= mod:NewNextTimer(46, 136850)--Also an exact bar
local timerSummonBallLightningCD		= mod:NewCDTimer(46, 136543)--VERY variable, also need more data. but so far i've observed 46-64 second variation :\
--Phase 3

mod:AddBoolOption("RangeFrame")


local intermission = 0
local phase = 1
local northDestroyed = false
local eastDestroyed = false
local southDestroyed = false
local westDestroyed = false
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
	northDestroyed = false
	eastDestroyed = false
	southDestroyed = false
	westDestroyed = false
	timerThunderstruckCD:Start(25-delay)
	timerDecapitateCD:Start(45-delay)--First seems to be 45, rest 50. it's a CD though, not a "next"
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(135095) then
		warnThunderstruck:Show()
		specWarnThunderstruck:Show()
		timerThunderstruckCD:Start()
	--"<206.2 20:38:58> [UNIT_SPELLCAST_SUCCEEDED] Lei Shen [[boss1:Lightning Whip::0:136845]]", -- [13762] --This event comes about .5 seconds earlier than SPELL_CAST_START. Maybe worth using?
	elseif args:IsSpellID(136850) then
		warnLightningWhip:Show()
		specWarnLightningWhip:Show()
		timerLightningWhipCD:Start()
	elseif args:IsSpellID(136478) then
		warnFusionSlash:Show()
		specWarnFusionSlash:Show()
		timerFussionSlashCD:Start()
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
	elseif args:IsSpellID(135680) and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--start timers here when we have em
	elseif args:IsSpellID(135681) and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
		if self.Options.RangeFrame and self:IsRanged() then--Shouldn't target melee during a normal pillar, only during intermission when all melee are with ranged and out of melee range of boss
			DBM.RangeCheck:Show(10)--Assume 10 since spell tooltip has no info
		end
	elseif args:IsSpellID(135682) and args:GetDestCreatureID() == 68397 then--South (Overcharge)
	
	elseif args:IsSpellID(135683) and args:GetDestCreatureID() == 68397 then--West (Bouncing Bolt)
		
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(135991) then
		warnDiffusionChain:Show(args.destName)
	elseif args:IsSpellID(136543) and self:AntiSpam(2, 1) then
		warnSummonBallLightning:Show()
		specWarnSummonBallLightning:Show()
		timerSummonBallLightningCD:Start()
	end
end


function mod:SPELL_AURA_REMOVED(args)
	--Conduit deactivations
	if args:IsSpellID(135680) and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--Cancel timers here when we have them
	elseif args:IsSpellID(135681) and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
		if self.Options.RangeFrame and self:IsRanged() then--Shouldn't target melee during a normal pillar, only during intermission when all melee are with ranged and out of melee range of boss
			if phase == 1 then
				DBM.RangeCheck:Hide()
			else
				DBM.RangeCheck:Show(6)--Switch back to Summon Lightning Orb spell range
			end
		end
	elseif args:IsSpellID(135682) and args:GetDestCreatureID() == 68397 then--South (Overcharge)
	
	elseif args:IsSpellID(135683) and args:GetDestCreatureID() == 68397 then--West (Bouncing Bolt)
		
	--Conduit deactivations
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137176") then--Overloaded Circuits (Intermission ending and next phase beginning)
		phase = phase + 1
		--"<174.8 20:38:26> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\spell_nature_unrelentingstorm.blp:20|t The |cFFFF0000|Hspell:135683|h[West Conduit]|h|r has burned out and caused |cFFFF0000|Hspell:137176|h[Overloaded Circuits]|h|r!#Bouncing Bolt Conduit
		if msg:find("spell:135680") then--North (Static Shock)
			northDestroyed = true
		elseif msg:find("spell:135681") then--East (Diffusion Chain)
			eastDestroyed = true
		elseif msg:find("spell:135682") then--South (Overcharge)
			southDestroyed = true
		elseif msg:find("spell:135683") then--West (Bouncing Bolt)
			westDestroyed = true
		end
		if phase == 2 then--Start Phase 2 timers
			timerSummonBallLightningCD:Start(18)--18-29 second variation. This spell blows for timing. Hopefully they refine it somewhat.
			timerLightningWhipCD:Start(32)
			timerFussionSlashCD:Start(45)--Just like decapitate, first one is 45 sec, rest are 50. It's also a "CD" bar, not a "next" bar
			if self.Options.RangeFrame and self:IsRanged() then--Only ranged need it in phase 2 and 3
				DBM.RangeCheck:Show(6)--Needed for phase 2 AND phase 3
			end
		elseif phase == 3 then--Start Phase 3 timers
			--timerLightningWhipCD:Start(32)--Still used in phase 3, but don't know timing. no phase 3 logs
		end
	end
end

local function rangeFrameDelay()
	if mod.Options.RangeFrame then--Both melee and ranged need to spread until Diffusion Chain is cast or we get too many adds.
		DBM.RangeCheck:Hide()
	end
end

--"<128.1 20:37:39> [UNIT_SPELLCAST_SUCCEEDED] Static Shock Conduit [[boss2:Supercharge Conduits::0:137146]]", -- [9562]
--"<178.8 20:38:30> [CLEU] SPELL_AURA_REMOVED#false#0xF1310B2D00008052#Lei Shen#2632#0#0xF1310B2D00008052#Lei Shen#2632#0#137045#Supercharge Conduits#8#BUFF#0xF1310B2D00008052#183111986#1284#66#1#1#0", -- [11497]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137146 and self:AntiSpam(2, 2) then--Supercharge Conduits (comes earlier than other events so we use this one)
		intermission = intermission + 1
		if intermission == 1 then--Cancel Phase 1 timers
			timerThunderstruckCD:Cancel()
			timerDecapitateCD:Cancel()
		elseif intermission == 2 then--Cancel Phase 2 timers
			timerFussionSlashCD:Cancel()
			timerLightningWhipCD:Cancel()
			timerSummonBallLightningCD:Cancel()
		end
		timerSuperChargedConduits:Start()
		if not northDestroyed then--This is a dirty trick. Evil Blizzard
			timerStaticchargeCD:Start(6)--This is cast first, BUT, you absoslutely DO NOT GROUP UP FOR THIS or you'll wipe to Diffusion Chain spread. Debuff last 8 seconds so it's really 6+8
		end--In other words, you SPREAD for diffusion chain and ignore this debuff until after, then group up for staticcharge debuff within last 3 seconds.
		if not eastDestroyed then
			timerDiffusionChainCD:Start(11)--Does not show in combat log, but have a pretty good idea on timing. maybe off 1 second (timer could be 10)
			if self.Options.RangeFrame then--Both melee and ranged need to spread until Diffusion Chain is cast or we get too many adds.
				DBM.RangeCheck:Show(10)--Range not known for this one, assumed 10, may only be 6 though, like the other similar mechanic Summon Lightning Orb
				self:Schedule(15, rangeFrameDelay)--Hide it after it's no longer useful
			end
		end
		if not southDestroyed then
			timerOverchargeCD:Start(15)
		end
		if not westDestroyed then
			timerBouncingBoltCD:Start(30)--This is probably off 1-2 seconds. need to do a /yell and log it later
		end
	elseif spellId == 136395 and self:AntiSpam(2, 3) then--Bouncing Bolt (think it's right trigger, could be wrong though)
		warnBouncingBolt:Show()
		specWarnBouncingBolt:Show()
	end
end
