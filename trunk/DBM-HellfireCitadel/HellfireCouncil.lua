local mod	= DBM:NewMod(1432, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(92142, 92144, 92146)--Blademaster Jubei'thos (92142). Dia Darkwhisper (92144). Gurthogg Bloodboil (92146) 
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(13990)
mod:SetBossHPInfoToHighest()
--mod.respawnTime = 20

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

local Dia		= EJ_GetSectionInfo(11489)
local Jubei		= EJ_GetSectionInfo(11488)
local Gurtogg	= EJ_GetSectionInfo(11490)

--(ability.id = 184657 or ability.id = 184476 or ability.id = 184355) and type = "begincast" or (ability.id = 184449 or ability.id = 183480 or ability.id = 184357) and type = "cast" or (ability.id = 183701 or ability.id = 184360 or ability.id = 184365) and type = "applydebuff" or (target.id = 92142 or target.id = 92144 or target.id = 92146) and type = "death" or ability.id = 184674
--TODO, add bloodboil. mythic only?
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
local specWarnReapGTFO				= mod:NewSpecialWarningMove(30533, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move:format(184652), nil, 1, 2)--On the ground version (GTFO)
local yellReap						= mod:NewYell(184476)
local specWarnDarkness				= mod:NewSpecialWarningSpell(184681, nil, nil, nil, 2)
--Gurtogg Bloodboil
local specWarnFelRage				= mod:NewSpecialWarningYou(184360)
local specWarnDemolishingLeap		= mod:NewSpecialWarningDodge(184366, nil, nil, nil, 2, 2)--Jumps around room, from side to side

mod:AddTimerLine(Jubei)
--Blademaster Jubei'thos
--local timerFelstormCD				= mod:NewCDTimer(30.5, 183701, nil, nil, nil, 2)
local timerMirrorImageCD			= mod:NewCDTimer(75, 183885, nil, nil, nil, 1)
mod:AddTimerLine(Dia)
--Dia Darkwhisper
local timerMarkofNecroCD			= mod:NewCDTimer(60.5, 184449, nil, "Healer", nil, 5)
local timerReapCD					= mod:NewCDTimer(61.6, 184476, nil, nil, nil, 3)--61-71
local timerNightmareVisageCD		= mod:NewCDTimer(30, 184657, nil, "Tank", nil, 5)
local timerDarknessCD				= mod:NewCDTimer(75, 184681, nil, nil, nil, 2)
mod:AddTimerLine(Gurtogg)
--Gurtogg Bloodboil
local timerRelRageCD				= mod:NewCDCountTimer(62, 184360, nil, nil, nil, 3)--62-84 (maybe this is HP based, cause this variation is stupid)
local timerDemoLeapCD				= mod:NewCDTimer(75, 184366, nil, nil, nil, 2)--Most will never see this ability since he's 3rd in the special rotation and he dies first in most strats
local timerTaintedBloodCD			= mod:NewNextCountTimer(15.8, 184357)
local timerBloodBoilCD				= mod:NewCDTimer(7.3, 184355, nil, false, nil, 3)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownSpecial				= mod:NewCountdown(75, 184681)--spellid is only one of 3 specials but whatever
local countdownReap					= mod:NewCountdownFades("Alt4", 184476)

local voiceFelstorm					= mod:NewVoice(183701)--aesoon
local voiceReap						= mod:NewVoice(184476)--runout/runaway
local voiceDemolishingLeap			= mod:NewVoice(184366)--runaway (Stll not sure I like run away for this. You may not have to move at all, run away implies you need to react, but this boss jumps to random spot in room, you have to check ground whether or not you need to move)

--mod:AddRangeFrameOption(8, 155530)

mod.vb.DiaPushed = false
mod.vb.taintedBloodCount = 0
mod.vb.felRageCount = 0
mod.vb.diaDead = false
mod.vb.jubeiDead = false
mod.vb.bloodboilDead = false
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
	self.vb.diaDead = false
	self.vb.jubeiDead = false
	self.vb.bloodboilDead = false
	self.vb.taintedBloodCount = 0
	self.vb.felRageCount = 0
	timerMarkofNecroCD:Start(7-delay)--7-13
	timerNightmareVisageCD:Start(15-delay)
--	timerFelstormCD:Start(20.5-delay)--Review
	timerRelRageCD:Start(30.5-delay, 1)
	timerReapCD:Start(50-delay)--50-73 variation on pull, likely blizzard was tinkering/hotfixing it between pulls. verify on later testing
	timerDarknessCD:Start(75-delay)
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
	elseif spellId == 183480 and self:AntiSpam(8, 1) then
		warnMirrorImage:Show()
		countdownSpecial:Start()
		if not self.vb.bloodboilDead then--Leap is next if bloodboil not dead
			timerDemoLeapCD:Start()
		elseif not self.vb.diaDead then--Bloodboil is dead but dia isn't, darkness next
			timerDarknessCD:Start()
		else--Only Jubei left, mirror images will be next
			timerMirrorImageCD:Start()
		end
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
		voiceDemolishingLeap:Play("runaway")
		countdownSpecial:Start()
		if not self.vb.diaDead then--Dia is next in natural order, unless dead
			timerDarknessCD:Start()
		elseif not self.vb.jubeiDead then--Jubi if dia is dead.
			timerMirrorImageCD:Start()
		else--Only bloodboil is left, leap will repeat
			timerDemoLeapCD:Start()
		end
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
	if cid == 92144 then--Dia Darkwhisper
		self.vb.diaDead = true
		timerMarkofNecroCD:Cancel()
		timerNightmareVisageCD:Cancel()
		local elapsed, total = timerDarknessCD:GetTime()
		timerDarknessCD:Cancel()
		if elapsed > 0 then--Timer existed, which means it was next
			DBM:Debug("updating specials timer", 2)
			--So now we update next based on remaining bosses
			if not self.vb.jubeiDead then--Images next if jubei lives
				timerMirrorImageCD:Update(elapsed, total)
			else--Only bloodboil left, leap
				timerDemoLeapCD:Update(elapsed, total)
			end
		end
	elseif cid == 92142 then--Blademaster Jubei'thosr
		self.vb.jubeiDead = true
		--timerFelstormCD:Cancel()
		local elapsed, total = timerMirrorImageCD:GetTime()
		timerMirrorImageCD:Cancel()
		if elapsed > 0 then--Timer existed, which means it was next
			DBM:Debug("updating specials timer", 2)
			--So now we update next based on remaining bosses
			if not self.vb.bloodboilDead then--Leap is next if bloodboil not dead
				timerDemoLeapCD:Start(elapsed, total)
			else--Only dia left left, darkness will be next
				timerDarknessCD:Start(elapsed, total)
			end
		end
	elseif cid == 92146 then--Gurthogg Bloodboil
		self.vb.bloodboilDead = true
		timerRelRageCD:Cancel()
		timerTaintedBloodCD:Cancel()
		local elapsed, total = timerDemoLeapCD:GetTime()
		timerDemoLeapCD:Cancel()
		if elapsed > 0 then--Timer existed, which means it was next
			DBM:Debug("updating specials timer", 2)
			--So now we update next based on remaining bosses
			if not self.vb.diaDead then--Dia lives, darkness next
				timerDarknessCD:Start(elapsed, total)
			else--Only jubei left, images.
				timerMirrorImageCD:Start(elapsed, total)
			end
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:184681") then
		specWarnDarkness:Show()
		countdownSpecial:Start()
		if not self.vb.jubeiDead then--jubei is next in natural order, unless dead
			timerMirrorImageCD:Start()
		elseif not self.vb.bloodboilDead then--Bloodboil wasn't dead but jubei is, leap is next
			timerDemoLeapCD:Start()
		else--Only dia is left, darkness will repeat
			timerDarknessCD:Start()
		end
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
