local mod	= DBM:NewMod(333, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56173)
mod:SetModelID(40087)
mod:SetModelSound("sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_MAELSTROMEVENT_01.OGG", "sound\\CREATURE\\Deathwing\\VO_DS_DEATHWING_MAELSTROMSPELL_04.OGG")
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("yell", L.Pull)
mod:SetMinCombatTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnMutated				= mod:NewSpellAnnounce("ej4112", 3, 467)
local warnImpale				= mod:NewTargetAnnounce(106400, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElementiumBolt		= mod:NewSpellAnnounce(105651, 4)
local warnTentacle				= mod:NewSpellAnnounce(105551, 3)
local warnHemorrhage			= mod:NewSpellAnnounce(105863, 3)
local warnCataclysm				= mod:NewCastAnnounce(106523, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2, 3)
local warnFragments				= mod:NewSpellAnnounce("ej4115", 4, 106708)--This needs a custom spell icon, EJ doesn't have icons for entires that are mobs
local warnTerror				= mod:NewSpellAnnounce("ej4117", 4, 106765)--This needs a fitting spell icon, trigger spell only has a gear.
local warnShrapnel				= mod:NewTargetAnnounce(109598, 3, nil, false)
local warnParasite				= mod:NewTargetAnnounce(108649, 4)
local warnTetanus				= mod:NewStackAnnounce(109605, 4, nil, false)
local warnCongealingBloodSoon	= mod:NewSoonAnnounce("ej4350", 4, 109089)--15%, 10%, 5% on heroic. spellid is 109089.

local specWarnMutated			= mod:NewSpecialWarningSwitch("ej4112", not mod:IsHealer())--Because tanks need to switch to it too.
local specWarnImpale			= mod:NewSpecialWarningYou(106400)
local specWarnImpaleOther		= mod:NewSpecialWarningTarget(106400, mod:IsTank() or mod:IsHealer())
local specWarnElementiumBolt	= mod:NewSpecialWarningSpell(105651, nil, nil, nil, true)--Cast, helps you find the mark on ground and get into positions
local specWarnElementiumBoltDPS	= mod:NewSpecialWarningSwitch(105651, mod:IsDps())--Warning for when to switch to dps it, because i really felt one warning didn't serve both meanings, one is an aoe/damage warning for cast, other should be specifically yelling at dps to kill it.
local specWarnTentacle			= mod:NewSpecialWarningSwitch("ej4103", mod:IsDps())--Tanks not included in this one cause they may still have adds.
local specWarnHemorrhage		= mod:NewSpecialWarningSpell(105863, not mod:IsHealer())--Because tanks need to switch to it too.
local specWarnFragments			= mod:NewSpecialWarningSpell("ej4115", mod:IsDps())--Not a "switch" warning because on normal a lot of groups choose to ignore these if they can burn boss and just pop dream. Let the raid leader decide strat on this one, not DBM.
local specWarnTerror			= mod:NewSpecialWarningSpell("ej4117")--Same as fragments.
local specWarnShrapnel			= mod:NewSpecialWarningYou(109598)
local specWarnParasite			= mod:NewSpecialWarningYou(108649)
local specWarnParasiteDPS		= mod:NewSpecialWarningSwitch("ej4347", mod:IsDps())
local yellParasite				= mod:NewYell(108649)
local specWarnCongealingBlood	= mod:NewSpecialWarningSwitch("ej4350", mod:IsDps())--15%, 10%, 5% on heroic. spellid is 109089.
local specWarnTetanus			= mod:NewSpecialWarningStack(109605, mod:IsTank(), 4)
local specWarnTetanusOther		= mod:NewSpecialWarningTarget(109605, mod:IsTank())

local timerMutated				= mod:NewNextTimer(17, "ej4112", nil, nil, nil, 467)--use druid spell Thorns icon temporarily.
local timerImpale				= mod:NewTargetTimer(49.5, 106400, nil, mod:IsTank() or mod:IsHealer())--45 plus 4 second cast plus .5 delay between debuff ID swap.
local timerImpaleCD				= mod:NewCDTimer(35, 106400, nil, mod:IsTank() or mod:IsHealer())
local timerElementiumCast		= mod:NewCastTimer(7.5, 105651)
local timerElementiumBlast		= mod:NewCastTimer(8, 109600)--8-10 variation depending on where it's actually going to land. Use the min time.
local timerElementiumBoltCD		= mod:NewNextTimer(55.5, 105651)
local timerHemorrhageCD			= mod:NewCDTimer(100.5, 105863)
local timerCataclysm			= mod:NewCastTimer(60, 106523)
local timerCataclysmCD			= mod:NewCDTimer(130.5, 106523)--130.5-131.5 variations
local timerFragmentsCD			= mod:NewNextTimer(90, "ej4115", nil, nil, nil, 106708)--Gear icon for now til i find something more suitable
local timerTerrorCD				= mod:NewNextTimer(90, "ej4117", nil, nil, nil, 106765)--^
local timerShrapnel				= mod:NewBuffFadesTimer(6, 109598)
local timerParasite				= mod:NewTargetTimer(10, 108649)
local timerParasiteCD			= mod:NewCDTimer(60, 108649)
--local timerUnstableCorruption	= mod:NewCastTimer(10, 108813)
local timerTetanus				= mod:NewTargetTimer(6, 109605, nil, mod:IsHealer())
local timerTetanusCD			= mod:NewCDTimer(3.5, 109605, nil, mod:IsTank())

local berserkTimer				= mod:NewBerserkTimer(900)

local countdownBoltBlast		= mod:NewCountdown(8, 109600)
local countdownShrapnel			= mod:NewCountdown(6, 109598, not mod:IsTank())

mod:AddBoolOption("RangeFrame", true)--For heroic parasites, with debuff filtering.
mod:AddBoolOption("SetIconOnParasite", true)

local firstAspect = true
local engageCount = 0
--local playerGUID = 0
local shrapnelTargets = {}
local warnedCount = 0
local hemorrhage = GetSpellInfo(105863)
local fragment = GetSpellInfo(109568)
local activateTetanusTimers = false

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, GetSpellInfo(108649))
	end
end

function mod:updateRangeFrame()
	if not self.Options.RangeFrame then return end
	if UnitDebuff("player", GetSpellInfo(108649)) then
		DBM.RangeCheck:Show(10, nil)--Show everyone.
	else
		DBM.RangeCheck:Show(10, debuffFilter)--Show only people who have debuff.
	end
end

local function warnShrapnelTargets()
	warnShrapnel:Show(table.concat(shrapnelTargets, "<, >"))
	table.wipe(shrapnelTargets)
end

function mod:OnCombatStart(delay)
	firstAspect = true
	activateTetanusTimers = false
	engageCount = 0
	warnedCount = 0
	table.wipe(shrapnelTargets)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(107018) then
		if firstAspect then--The abilities all come 15seconds earlier for first one only
			firstAspect = false
			timerMutated:Start(11)
			warnMutated:Schedule(11)
			specWarnMutated:Schedule(11)
			timerImpaleCD:Start(22)
			timerElementiumBoltCD:Start(40.5)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerHemorrhageCD:Start(55.5)--Appears to be 30 seconds earlier in heroic
				timerParasiteCD:Start(11)
			else
				timerHemorrhageCD:Start(85.5)
			end
			timerCataclysmCD:Start(115.5)
		else
			timerMutated:Start()
			warnMutated:Schedule(17)
			specWarnMutated:Schedule(17)
			timerImpaleCD:Start(27.5)
			timerElementiumBoltCD:Start()
			if self:IsDifficulty("heroic10", "heroic25") then
				timerHemorrhageCD:Start(70.5)
				timerParasiteCD:Start(22)
			else
				timerHemorrhageCD:Start()
			end
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(106523, 110042, 110043, 110044) then
		warnCataclysm:Show()
		timerCataclysm:Start()
--[[	elseif args:IsSpellID(108813) then
		if UnitDebuff(playerGUID, GetSpellInfo(108646)) then--Check if player that got the debuff is in nozdormu's bubble at time of cast.
			timerUnstableCorruption:Start(15.5)
		else
			timerUnstableCorruption:Start()
		end--]]
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105651) then
		warnElementiumBolt:Show()
		specWarnElementiumBolt:Show()
		if not UnitBuff("player", GetSpellInfo(109624)) and not UnitIsDeadOrGhost("player") then--Check for Nozdormu's Presence
			timerElementiumBlast:Start()
			countdownBoltBlast:Start()
			specWarnElementiumBoltDPS:Schedule(10)
		else
			timerElementiumCast:Start()
			timerElementiumBlast:Start(20)
			specWarnElementiumBoltDPS:Schedule(7.5)
		end
	elseif args:IsSpellID(110063) then--Astral Recall. Thrall teleports off back platform back to front on defeat.
		self:SendSync("MadnessDown")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(106548) then--Arm/Wing Transition
		timerElementiumBoltCD:Cancel()
		timerHemorrhageCD:Cancel()--Does this one cancel in event you super overgear this and stomp his ass this fast?
		timerCataclysm:Cancel()
		timerCataclysmCD:Cancel()
	elseif args:IsSpellID(109592, 109593, 106834, 109594) then--Phase 2
		warnPhase2:Show()
		timerFragmentsCD:Start(10.5)
		timerTerrorCD:Start(35.5)
		if self:IsDifficulty("heroic10", "heroic25") then--Only register on heroic, we don't need on normal.
			self:RegisterShortTermEvents(
				"UNIT_HEALTH_FREQUENT"
			)
		end
	elseif args:IsSpellID(106400) then
		warnImpale:Show(args.destName)
		timerImpale:Start(args.destName)
		timerImpaleCD:Start()
		if args:IsPlayer() then
			specWarnImpale:Show()
		else
			specWarnImpaleOther:Show(args.destName)
		end
	elseif args:IsSpellID(106794, 110139, 110140, 110141) then
		shrapnelTargets[#shrapnelTargets + 1] = args.destName
		self:Unschedule(warnShrapnelTargets)
		if args:IsPlayer() then
			specWarnShrapnel:Show()
			timerShrapnel:Start() -- Shrapnel debuff lasts 7 secs. But Shrapnel damages 1 sec early before debuff fades. So 6 sec timer will be more good.
			countdownShrapnel:Start(6)
		end
		if (self:IsDifficulty("normal10", "heroic10") and #shrapnelTargets >= 3) or (self:IsDifficulty("normal25", "heroic25", "lfr25") and #shrapnelTargets >= 8) then
			warnShrapnelTargets()
		else
			self:Schedule(0.3, warnShrapnelTargets)
		end
	elseif args:IsSpellID(108649) then
		warnParasite:Show(args.destName)
		timerParasite:Start(args.destName)
		timerParasiteCD:Start()
		self:updateRangeFrame()
		if args:IsPlayer() then
			specWarnParasite:Show()
			yellParasite:Yell()
		end
--		playerGUID = args.destGUID
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 8)
		end
	elseif args:IsSpellID(106730, 109603, 109604, 109605) then -- Debuffs from adds
		warnTetanus:Show(args.destName, args.amount or 1)
		timerTetanus:Start(args.destName)
		if (args.amount or 1) >= 4 then
			if args:IsPlayer() then
				specWarnTetanus:Show(args.amount)
			else
				if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", GetSpellInfo(109603)) then--You have no debuff and not dead
					specWarnTetanusOther:Show(args.destName)--So stop being a tool and taunt off other tank who has 4 stacks.
				end
			end
		end
		if activateTetanusTimers then -- Only track them when there is no Time Zone down (since we have no way to accurate track/detect whether or not they are tanked in it, ie slowed)
			timerTetanusCD:Start(args.sourceGUID)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106444, 109631, 109632, 109633) then
		timerImpale:Cancel(args.destName)
	elseif args:IsSpellID(106794, 110139, 110140, 110141) and args:IsPlayer() then
		timerShrapnel:Cancel()
		countdownShrapnel:Cancel()
	elseif args:IsSpellID(108649) then
		specWarnParasiteDPS:Show()
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(109091) and self:AntiSpam(10) then--They spawn over like 8 seconds, not at same time, so we need a large anti spam.
		specWarnCongealingBlood:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56471 then--Mutated Corruption
		timerImpaleCD:Cancel()
		timerParasiteCD:Cancel()
		timerImpale:Cancel()--Cancel impale debuff timers since they don't matter anymore until next platform (well after they cleared)
	elseif cid == 56311 then --Phase 2 Time Zone bubbles (yes it's an npc heh)
		activateTetanusTimers = true
	elseif cid == 56710 then
		timerTetanusCD:Cancel(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if spellId == 110663 then--Elementium Meteor Transform (apparently this doesn't fire UNIT_DIED anymore, need to use this alternate method)
		self:SendSync("BoltDied")--Send sync because Elementium bolts do not have a bossN arg, which means event only fires if it's current target/focus.
	end
	if not uId:find("boss") then return end--Anti spam to ignore all other args (like target/focus/mouseover)
	if spellName == hemorrhage then
		warnHemorrhage:Show()
		specWarnHemorrhage:Show()
	elseif spellId == 105551 then--Spawn Blistering Tentacles
		if not UnitBuff("player", GetSpellInfo(106028)) then--Check for Alexstrasza's Presence
			warnTentacle:Show()
			specWarnTentacle:Show()
		end
	elseif spellName == fragment then--Summon Impaling Tentacle (Fragments summon)
		warnFragments:Show()
		specWarnFragments:Show()
		timerFragmentsCD:Start()
	elseif spellId == 106765 then--Summon Elementium Terror (Big angry add)
		activateTetanusTimers = false
		warnTerror:Show()
		specWarnTerror:Show()
		timerTerrorCD:Start()
	end
end

function mod:OnSync(msg)
	if msg == "BoltDied" then
		timerElementiumBlast:Cancel()--Lot of work just to cancel a timer, why the heck did blizz break this mob firing UNIT_DIED when it dies? Sigh.
	elseif msg == "MadnessDown" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	if uId == "boss1" then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if hp > 15 and hp < 16.5 and warnedCount == 0 then
			warnedCount = 1
			warnCongealingBloodSoon:Show()
		elseif hp > 10 and hp < 11.5 and warnedCount == 1 then
			warnedCount = 2
			warnCongealingBloodSoon:Show()
		elseif hp > 5 and hp < 6.5 and warnedCount == 2 then
			warnedCount = 3
			warnCongealingBloodSoon:Show()
			self:UnregisterShortTermEvents()
		end
	end
end
