local mod	= DBM:NewMod(1432, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(94455, 92144, 92146)--Blademaster Jubei'thos (94455). Dia Darkwhisper (92144). Gurthogg Bloodboil (92146) 
mod:SetEncounterID(1778)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetBossHPInfoToHighest()
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 184657 184476 183016",
	"SPELL_CAST_SUCCESS 184449 183480",
	"SPELL_AURA_APPLIED 183701 184847 184360 184365 184449",
	"SPELL_AURA_APPLIED_DOSE 184847",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, see if 183016 is valid Fel Blade cast and if it can be target scanned. If not, probably not worth adding.
--TODO, see how mirror images (183734) works and how frequent it is. Not adding until I know whether spammy or not.
--TODO, figure out windwalk too (183480). Spellids for pretty much all of Blademaster Jubei'thos lack definitive clarity and have too many IDs for drycode
--TODO, Figure out what damn spellid Mark of the Nacromancer uses, cause it has like 8 of them. This is a MUST HAVE warning.
--TODO, add GTFO for standing in fire left on ground by marks, after reap, again after figure out which is right spellid, can't add now, wrong spellid and it'll spam bad warnings.
--TODO, Figure out rest of darkness
--TODO, add bloodboil. mythic only?
--TODO, figure out swaps for Acidic Wound and add appropriate stack/taunt warnings.
--TODO< verify Demolishing Leap spellid/event
--Blademaster Jubei'thos
--Things
--Dia Darkwhisper
local warnMarkoftheNecromancer		= mod:NewTargetAnnounce(184449, 4, nil, false)--Off by default until i verify sp ellid, i don't want announce spam cause i guessed wrong one
local warnReap						= mod:NewSpellAnnounce(184476, 4)--Generic warning if you don't have reap, just to know it's going on
--Gurtogg Bloodboil
local warnAcidicWound				= mod:NewStackAnnounce(184847, 2, nil, "Tank")
local warnFelRage					= mod:NewTargetAnnounce(184360, 4)

--Blademaster Jubei'thos
local specWarnFelstorm				= mod:NewSpecialWarningSpell(183701, nil, nil, nil, 2, nil, 2)
local specWarnMirrorImage			= mod:NewSpecialWarningSwitch(183885, "Dps")--Triggered by windwalk
--Dia Darkwhisper
local specWarnNightmareVisage		= mod:NewSpecialWarningSpell(184657)--Doesn't option default, only warns highest threat
local specWarnReap					= mod:NewSpecialWarningMoveAway(184476, nil, nil, nil, 3)--Everyone with Mark of Necromancer is going to drop void zones that last forever, they MUST get the hell out
local yellReap						= mod:NewYell(184476)
local specWarnDarkness				= mod:NewSpecialWarningSpell(184674, nil, nil, nil, 2)--30% version I believe. Don't know how the above 30% version yet, can't find a valid castID for it, just damage ID
--Gurtogg Bloodboil
local specWarnFelRage				= mod:NewSpecialWarningYou(184360)
local specWarnDemolishingLeap		= mod:NewSpecialWarningRun(184366, nil, nil, nil, 4)--Damage reduced by distance, run away from boss

--Blademaster Jubei'thos
local timerFelBladeCD				= mod:NewAITimer(107, 183016)
local timerMarkofNecroCD			= mod:NewAITimer(107, 184449, nil, false)
local timerWindwalkCD				= mod:NewAITimer(107, 183480, nil, "-Healer")
--Dia Darkwhisper
local timerFelstormCD				= mod:NewAITimer(107, 183701)
local timerReapCD					= mod:NewAITimer(107, 184476)
local timerNightmareVisageCD		= mod:NewAITimer(107, 184657, nil, "Tank")
--Gurtogg Bloodboil
local timerRelRageCD				= mod:NewAITimer(107, 184360)
local timerDemoLeapCD				= mod:NewAITimer(107, 184366)

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownReap					= mod:NewCountdownFades("Alt4", 184476)

local voiceFelstorm					= mod:NewVoice(183701)--aesoon

--mod:AddRangeFrameOption(8, 155530)

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
	timerFelBladeCD:Start(1-delay)
	timerFelstormCD:Start(1-delay)
	timerWindwalkCD:Start(1-delay)
	timerReapCD:Start(1-delay)
	timerMarkofNecroCD:Start(1-delay)
	timerNightmareVisageCD:Start(1-delay)
	timerRelRageCD:Start(1-delay)
	timerDemoLeapCD:Start(1-delay)
end

function mod:OnCombatEnd()
	DBM:AddMsg(DBM_CORE_COMBAT_STARTED_AI_TIMER)
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
		timerReapCD:Start()
		if UnitDebuff("player", markofNecroDebuff) then
			specWarnReap:Show()
			yellReap:Yell()
			countdownReap:Start()
		else
			warnReap:Show()
		end
	elseif spellId == 183016 then
		timerFelBladeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 184449 then
		timerMarkofNecroCD:Start()
	elseif spellId == 183480 then
		specWarnMirrorImage:Show()
		timerWindwalkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 183701 then
		specWarnFelstorm:Show()
		voiceFelstorm:Play("aesoon")
		timerFelstormCD:Start()
	elseif spellId == 184847 and self:AntiSpam(3.5, 1) then--Probably stacks very rapidly, so using antispam for now until better method constructed
		local amount = args.amount or 1
		warnAcidicWound:Show(args.destName, amount)
	elseif spellId == 184360 then
		timerRelRageCD:Start()
		if args:IsPlayer() then
			specWarnFelRage:Show()
		else
			warnFelRage:Show(args.destName)
		end
	elseif spellId == 184365 and not args:IsDestTypePlayer() then--IsDestTypePlayer because it could be wrong spellid and one applied to players when he lands on them, so to avoid spammy mess, filter
		specWarnDemolishingLeap:Show()
		timerDemoLeapCD:Start()
	elseif spellId == 184449 then--Could be any number of spellids, has like 10 of the damn things
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
	if cid == 94455 then--Blademaster Jubei'thosr
		timerFelBladeCD:Cancel()
		timerFelstormCD:Cancel()
		timerWindwalkCD:Cancel()
	elseif cid == 92144 then--Dia Darkwhisper
		timerReapCD:Cancel()
		timerMarkofNecroCD:Cancel()
		timerNightmareVisageCD:Cancel()
	elseif cid == 92146 then--Gurthogg Bloodboil
		timerRelRageCD:Cancel()
		timerDemoLeapCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 184682 then--Just a guess, but doesn't look like a spell that shows in combat log. they didn't bother to localize spellid or give it an icon or tooltip. Looks like 30% version of spell, that cancels reap and lasts rest of fight.
		timerReapCD:Cancel()
		specWarnDarkness:Show()
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
