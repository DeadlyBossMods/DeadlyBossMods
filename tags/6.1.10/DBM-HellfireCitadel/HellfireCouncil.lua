local mod	= DBM:NewMod(1432, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(92142, 92144, 92146)--Blademaster Jubei'thos (92142). Dia Darkwhisper (92144). Gurthogg Bloodboil (92146) 
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetBossHPInfoToHighest()
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184657 184476",
	"SPELL_CAST_SUCCESS 184449 183480 184357 184355",
	"SPELL_AURA_APPLIED 183701 184847 184360 184365 184449",
	"SPELL_AURA_APPLIED_DOSE 184847",
--	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE 184652",
	"SPELL_ABSORB 184652",
	"UNIT_DIED",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local Jubei		= EJ_GetSectionInfo(11488)
local Dia		= EJ_GetSectionInfo(11489)
local Gurtogg	= EJ_GetSectionInfo(11490)

--TODO, add bloodboil. mythic only?
--TODO, All 3 150 second cooldown abilities are silly and unpredictable. I don't think they will go live this way. Timers disabled for them all for now. ESPECIALLy mirror image which goes from being 150 second cd to NO cd below 30%
--Blademaster Jubei'thos
local warnMirrorImage				= mod:NewSpellAnnounce(183885, 2)
--Dia Darkwhisper
local warnMarkoftheNecromancer		= mod:NewTargetAnnounce(184449, 4, nil, false)--Off by default until i verify sp ellid, i don't want announce spam cause i guessed wrong one
local warnReap						= mod:NewSpellAnnounce(184476, 4)--Generic warning if you don't have reap, just to know it's going on
--Gurtogg Bloodboil
local warnAcidicWound				= mod:NewStackAnnounce(184847, 2, nil, "Tank")--As of PTR, this required no swaps, just the person with fel rage pulling boss away from tank long enough to clear stacks
local warnFelRage					= mod:NewTargetCountAnnounce(184360, 4)

--Blademaster Jubei'thos
local specWarnFelstorm				= mod:NewSpecialWarningSpell(183701, nil, nil, nil, 2, 2)
--Dia Darkwhisper
local specWarnNightmareVisage		= mod:NewSpecialWarningSpell(184657)--Doesn't option default, only warns highest threat
local specWarnReap					= mod:NewSpecialWarningMoveAway(184476, nil, nil, nil, 3, 2)--Everyone with Mark of Necromancer is going to drop void zones that last forever, they MUST get the hell out
local specWarnReapGTFO				= mod:NewSpecialWarningMove(184652, nil, nil, nil, 1, 2)--On the ground version (GTFO)
local yellReap						= mod:NewYell(184476)
local specWarnDarkness				= mod:NewSpecialWarningSpell(184681, nil, nil, nil, 2)
--Gurtogg Bloodboil
local specWarnFelRage				= mod:NewSpecialWarningYou(184360)
local specWarnDemolishingLeap		= mod:NewSpecialWarningDodge(184366, nil, nil, nil, 2, 2)--Jumps around room, from side to side

mod:AddTimerLine(Jubei)
--Blademaster Jubei'thos
--local timerFelstormCD				= mod:NewCDTimer(30.5, 183701)
local timerMirrorImageCD			= mod:NewCDTimer(150, 183885)--Same as demo leap. the cd is so long that the timer is quite useless.
mod:AddTimerLine(Dia)
--Dia Darkwhisper
local timerMarkofNecroCD			= mod:NewCDTimer(60.5, 184449, nil, "Healer")
local timerReapCD					= mod:NewCDTimer(64.6, 184476)--66-71
local timerNightmareVisageCD		= mod:NewCDTimer(30, 184657, nil, "Tank")
local timerDarknessCD				= mod:NewCDTimer(150, 184681)--Also bleh in consistency. I suspect all the 150 second abilities are undertuned and will all need fixing.
mod:AddTimerLine(Gurtogg)
--Gurtogg Bloodboil
local timerRelRageCD				= mod:NewCDCountTimer(62, 184360)--62-84 (maybe this is HP based, cause this variation is stupid)
local timerDemoLeapCD				= mod:NewCDTimer(150, 184366)--I think ability was flat broken, he used it like 1 out of 6 pulls. and when he did it was 2 and a half minute cd?
local timerTaintedBloodCD			= mod:NewNextCountTimer(15.8, 184357)
local timerBloodBoilCD				= mod:NewCDTimer(7.3, 184355, nil, false)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownReap					= mod:NewCountdownFades("Alt4", 184476)

local voiceFelstorm					= mod:NewVoice(183701)--aesoon
local voiceReap						= mod:NewVoice(184476)--runout/runaway
local voiceDemolishingLeap			= mod:NewVoice(184366)--runaway (Stll not sure I like run away for this. You may not have to move at all, run away implies you need to react, but this boss jumps to random spot in room, you have to check ground whether or not you need to move)

--mod:AddRangeFrameOption(8, 155530)

mod.vb.DiaPushed = false
mod.vb.taintedBloodCount = 0
mod.vb.felRageCount = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local markofNecroDebuff = GetSpellInfo(184449)--Spell name should work, without knowing what right spellid is, For this anyways.

--[[
local debuffFilter
do
	local debuffName = GetSpellInfo(155323)
	local UnitDebuff = UnitDebuff
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end--]]

function mod:OnCombatStart(delay)
	self.vb.DiaPushed = false
	self.vb.taintedBloodCount = 0
	self.vb.felRageCount = 0
	timerMarkofNecroCD:Start(7-delay)--7-13
	timerNightmareVisageCD:Start(15-delay)
--	timerFelstormCD:Start(20.5-delay)--Review
	timerRelRageCD:Start(30.5-delay, 1)
	timerReapCD:Start(50-delay)--50-73 variation on pull, likely blizzard was tinkering/hotfixing it between pulls. verify on later testing
	timerDarknessCD:Start(76.5-delay)
	timerMirrorImageCD:Start(-delay)--First one is 150-160 into fight, unless he hits 30% first, then he uses it earlier and spams rest of fight.
	timerDemoLeapCD:Start(230-delay)--First one 230 into fight. if you kill him first you NEVER see it.
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 184657 then
		timerNightmareVisageCD:Start()
		for i = 1, 5 do--Maybe only 1-3 needed, but don't know if any adds take boss IDs, plus, it'll abort when it finds right one anyways
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnNightmareVisage:Show()--Show warning only to the tank she's on, not both tanks, avoid confusion
				break
			end
		end
	elseif spellId == 184476 then
		if not self.vb.DiaPushed then--Don't start cd timer for her final reap she casts at 30%
			timerReapCD:Start()
		end
		if UnitDebuff("player", markofNecroDebuff) then
			specWarnReap:Show()
			yellReap:Yell()
			countdownReap:Start()
			voiceReap:Play("runout")
		else
			warnReap:Show()
		end
	elseif spellId == 184355 then
		timerBloodBoilCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 184449 then--Confirmed correct CAST spellid for heroic
		timerMarkofNecroCD:Start()
	elseif spellId == 183480 and self:AntiSpam(8, 1) then--Once he pushes 30%, he just spams this, so stop warning
		warnMirrorImage:Show()
		timerMirrorImageCD:Cancel()--Just cancel it first time he casts it, after he starts using ability he keeps using it Timer is strictly for when he starts using it
	elseif spellId == 184357 then
		self.vb.taintedBloodCount = self.vb.taintedBloodCount + 1
		timerTaintedBloodCD:Start(nil, self.vb.taintedBloodCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 183701 and args:GetDestCreatureID() == 92142 then--Only warn when jubei uses, not mirror image spam
		specWarnFelstorm:Show()
		voiceFelstorm:Play("aesoon")
--		timerFelstormCD:Start()
	elseif spellId == 184847 and self:AntiSpam(4, 2) then--Probably stacks very rapidly, so using antispam for now until better method constructed
		local amount = args.amount or 1
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			warnAcidicWound:Show(args.destName, amount)
		end
	elseif spellId == 184360 then
		self.vb.felRageCount = self.vb.felRageCount + 1
		timerRelRageCD:Start(nil, self.vb.felRageCount+1)
		if args:IsPlayer() then
			specWarnFelRage:Show()
		else
			warnFelRage:Show(self.vb.felRageCount, args.destName)
		end
	elseif spellId == 184365 and not args:IsDestTypePlayer() then--IsDestTypePlayer because it could be wrong spellid and one applied to players when he lands on them, so to avoid spammy mess, filter
		specWarnDemolishingLeap:Show()
		--timerDemoLeapCD:Start()
		voiceDemolishingLeap:Play("runaway")
	elseif spellId == 184449 then--Confirmed correct CAST spellid for heroic.
		warnMarkoftheNecromancer:CombinedShow(0.3, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--[[
function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155323 then
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 92142 then--Blademaster Jubei'thosr
		--timerFelstormCD:Cancel()
		timerMirrorImageCD:Cancel()
	elseif cid == 92144 then--Dia Darkwhisper
		timerMarkofNecroCD:Cancel()
		timerNightmareVisageCD:Cancel()
	elseif cid == 92146 then--Gurthogg Bloodboil
		timerRelRageCD:Cancel()
		timerDemoLeapCD:Cancel()
		timerTaintedBloodCD:Cancel()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:184681") then
		specWarnDarkness:Show()
		timerDarknessCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 187183 then--Mark of the Necromancer (30% version that marks half of enemies, Dia)
		self.vb.DiaPushed = true
		timerReapCD:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 184652 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnReapGTFO:Show()
		voiceReap:Play("runaway")
	end
end
mod.SPELL_ABSORB = mod.SPELL_PERIODIC_DAMAGE
