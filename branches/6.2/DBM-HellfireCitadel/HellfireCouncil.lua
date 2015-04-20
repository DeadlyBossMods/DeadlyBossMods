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
	"SPELL_CAST_START 184657 184476",
--	"SPELL_CAST_SUCCESS,
	"SPELL_AURA_APPLIED 183701 184847 184360 184356 184365",
	"SPELL_AURA_APPLIED_DOSE 184847",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, see if 183016 is valid Fel Blade cast and if it can be target scanned. If not, probably not worth adding.
--TODO, see how mirror images (183734) works and how frequent it is. Not adding until I know whether spammy or not.
--TODO, figure out windwalk too (183480). Spellids for pretty much all of Blademaster Jubei'thos lack definitive clarity and have too many IDs for drycode
--TODO, windstrike ends windwalk. Probalby need that too
--TODO, Figure out what damn spellid Mark of the Nacromancer uses, cause it has like 8 of them. This is a MUST HAVE warning.
--TODO, add GTFO for standing in fire left on ground by marks, after reap, again after figure out which is right spellid, can't add now, wrong spellid and it'll spam bad warnings.
--TODO, Figure out rest of darkness
--TODO, add bloodboil. mythic only?
--TODO, figure out swaps for Acidic Wound and add appropriate stack/taunt warnings.
--TODO, at time of this drycode, insignificance didn't exist yet. But it does have an ID in journal so drycoding it anyways, it MIGHT work.
--TODO< verify Demolishing Leap spellid/event
--Blademaster Jubei'thos
--Things
--Dia Darkwhisper
local warnReap						= mod:NewSpellAnnounce(184476, 4)--Generic warning if you don't have reap, just to know it's going on
--Gurtogg Bloodboil
local warnAcidicWound				= mod:NewStackAnnounce(184847, 2, nil, "Tank")
local warnFelRage					= mod:NewTargetAnnounce(184360, 4)

--Blademaster Jubei'thos
local specWarnFelstorm				= mod:NewSpecialWarningSpell(183701, nil, nil, nil, 2, nil, 2)
--Dia Darkwhisper
local specWarnNightmareVisage		= mod:NewSpecialWarningSpell(184657)--Doesn't option default, only warns highest threat
local specWarnReap					= mod:NewSpecialWarningMoveAway(184476, nil, nil, nil, 3)--Everyone with Mark of Necromancer is going to drop void zones that last forever, they MUST get the hell out
local yellReap						= mod:NewYell(184476)
local specWarnDarkness				= mod:NewSpecialWarningSpell(184674, nil, nil, nil, 2)--30% version I believe. Don't know how the above 30% version yet, can't find a valid castID for it, just damage ID
--Gurtogg Bloodboil
local specWarnFelRage				= mod:NewSpecialWarningYou(184360)
local specWarnInsignificance		= mod:NewSpecialWarningTaunt(184356)
local specWarnDemolishingLeap		= mod:NewSpecialWarningRun(184366, nil, nil, nil, 4)--Damage reduced by distance, run away from boss

--Blademaster Jubei'thos
--local timerFelstormCD				= mod:NewCDTimer(107, 183701)
--Dia Darkwhisper
--local timerReapCD					= mod:NewCDTimer(107, 184476)
--local timerDarknessCD				= mod:NewCDTimer(107, 184681)

--local berserkTimer				= mod:NewBerserkTimer(360)

local countdownReap					= mod:NewCountdownFades("Alt4", 184476)

local voiceFelstorm					= mod:NewVoice(183701)--aesoon

--mod:AddRangeFrameOption(8, 155530)
--mod:AddHudMapOption("HudMapOnShatter", 155530, false)

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

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.HudMapOnShatter then
--		DBMHudMap:Disable()
--	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 184657 then
		for i = 1, 5 do--Maybe only 1-3 needed, but don't know if any adds take boss IDs, plus, it'll abort when it finds right one anyways
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnNightmareVisage:Show()--Show warning only to the tank she's on, not both tanks, avoid confusion
				break
			end
		end
	elseif spellId == 184476 then
		if UnitDebuff("player", markofNecroDebuff) then
			specWarnReap:Show()
			yellReap:Yell()
			countdownReap:Start()
		else
			warnReap:Show()
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155326 then

	end
end--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 183701 then
		specWarnFelstorm:Show()
		voiceFelstorm:Play("aesoon")
	elseif spellId == 155323 then
		if args:IsPlayer() then

			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 184847 and self:AntiSpam(3.5, 1) then--Probably stacks very rapidly, so using antispam for now until better method constructed
		local amount = args.amount or 1
		warnAcidicWound:Show(args.destName, amount)
	elseif spellId == 184356 and not args:IsPlayer() then
		specWarnInsignificance:Show(args.destName)
	elseif spellId == 184360 then
		if args:IsPlayer() then
			specWarnFelRage:Show()
		else
			warnFelRage:Show(args.destName)
		end
	elseif spellId == 184365 then
		specWarnDemolishingLeap:Show()
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


function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 184682 then--Just a guess, but doesn't look like a spell that shows in combat log. they didn't bother to localize spellid or give it an icon or tooltip. Looks like 30% version of spell, that cancels reap and lasts rest of fight.
--		timerReapCD:Cancel()
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
