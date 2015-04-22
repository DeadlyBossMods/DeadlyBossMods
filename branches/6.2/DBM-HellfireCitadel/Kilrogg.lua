local mod	= DBM:NewMod(1396, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90378)
mod:SetEncounterID(1786)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
--mod:SetRespawnTime(20)

mod:RegisterCombat("combat")


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180199 180224 182428 180163 183917",
	"SPELL_CAST_SUCCESS 181113",
	"SPELL_AURA_APPLIED 180313 180200 180372 181488 187089",
	"SPELL_AURA_APPLIED_DOSE 180200",
	"SPELL_AURA_REMOVED 181488",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_ABSORBED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, maybe icon option for MC, if it's not everyone at once
--TODO, a way to detect hulking terror evolution.
--TODO, verify if Encounter Spawn is used, if not, find timing to use repeater.
--TODO, visions phase warnings, when better undrestood, drycoding them now would be too much guesswork
--TODO, more stuff for the digest phase adds if merited
--Boss
local warnDemonicPossession			= mod:NewTargetAnnounce(180313, 4)
local warnShreddedArmor				= mod:NewStackAnnounce(180200, 4, nil, "Tank|Healer")--Shouldn't happen, but is going to.
local warnHeartseeker				= mod:NewTargetAnnounce(180372, 4)
local warnVisionofDeath				= mod:NewTargetAnnounce(181488, 2)--The targets that got picked
local warnCleansingAura				= mod:NewTargetAnnounce(187089, 1)
--Adds
local warnSavageStrikes				= mod:NewSpellAnnounce(180163, 3, nil, "Tank")--Need to assess damage amount on special vs non special warning

--Boss
local specWarnShred					= mod:NewSpecialWarningSpell(180199, nil, nil, nil, 3, nil, 2)--Block, or get nasty debuff that probably kills you. Warning filtered by threat, no need to disable
local specWarnHeartSeeker			= mod:NewSpecialWarningRun(180372, nil, nil, nil, 4, nil, 2)--Must run as far from boss as possible
local yellHeartSeeker				= mod:NewYell(180372)
local specWarnDeathThroes			= mod:NewSpecialWarningSpell(180224, nil, nil, nil, 2, nil, 2)
local specWarnVisionofDeath			= mod:NewSpecialWarningSpell(182428)--Seems everyone goes down at some point, dps healers and off tank. Each getting different abiltiy when succeed
--Adds
local specWarnBloodGlob				= mod:NewSpecialWarningSwitch(180459, "Dps", nil, nil, 1, nil, 2)
local specWarnFelBloodGlob			= mod:NewSpecialWarningSwitch(180199, "Dps", nil, nil, 3, nil, 2)
local specWarnBloodthirster			= mod:NewSpecialWarningSwitch("ej11266", "Dps", nil, nil, 1, nil, 2)
local specWarnRendingHowl			= mod:NewSpecialWarningInterrupt(183917, "-Healer")

--Boss
--local timerShredCD					= mod:NewCDTimer(107, 180199)
--local timerHeartseekerCD				= mod:NewCDTimer(107, 180372)
--local timerVisionofDeathCD			= mod:NewCDTimer(107, 181488)
--Adds
--local timerBloodthirsterCD			= mod:NewCDTimer(30, ej11266)
--local timerRendingHowlCD				= mod:NewCDTimer(30, 183917)

--local berserkTimer					= mod:NewBerserkTimer(360)

local countdownVisionofDeath			= mod:NewCountdown("Alt60", 181488)

local voiceShred						= mod:NewVoice(180199)--defensive
local voiceHeartSeeker					= mod:NewVoice(180372)--runout
local voiceDeathThroes					= mod:NewVoice(180224)--aesoon
local voiceBloodGlob					= mod:NewVoice(180459)--killmob
local voiceFelBloodGlob					= mod:NewVoice(180199)--killmob
local voiceBloodthirster				= mod:NewVoice("ej11266")--killmob

mod:AddInfoFrameOption("ej11280")--ej better description than spellid
--mod:AddRangeFrameOption(8, 155530)

local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local felCorruption = GetSpellInfo(182159)

local function addsRepeater(self)--In case blizzard sucks and doesn't use the Encounter Spawn event
	specWarnBloodthirster:Show()
	voiceBloodthirster:Play("killmob")
	--timerBloodthirsterCD:Start()
	self:Schedule(30, addsRepeater, self)
end

function mod:OnCombatStart(delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(felCorruption)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
	--self:Schedule(30, addsRepeater, self)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180199 then
		for i = 1, 5 do--Maybe only 1 needed, but don't know if any adds take boss IDs
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnShred:Show()--Show warning only to the tank he's on, not both tanks, avoid confusion
				voiceShred:Play("defensive")
				break
			end
		end
	elseif spellId == 180224 then
		specWarnDeathThroes:Show()
		voiceDeathThroes:Play("aesoon")
	elseif spellId == 182428 then
		specWarnVisionofDeath:Show()
	elseif spellId == 180163 then
		warnSavageStrikes:Show()
	elseif spellId == 183917 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnRendingHowl:Show(args.sourceName)
		--timerRendingHowlCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 181113 then--Encounter Spawn (probably won't exist, but here's hoping no scheduled add repeater needed)
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 92038 or cid == 90521 or cid == 93369 then
			specWarnBloodthirster:Show()
			voiceBloodthirster:Play("killmob")
			--timerBloodthirsterCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 180372 and args:IsDestTypePlayer() then
		warnHeartseeker:Show(args.destName)
		if args:IsPlayer() then
			specWarnHeartSeeker:Show()
			yellHeartSeeker:Yell()
			voiceHeartSeeker:Play("runout")
		end
	elseif spellId == 181488 then
		warnVisionofDeath:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			countdownVisionofDeath:Start()
		end
	elseif spellId == 180313 then
		warnDemonicPossession:CombinedShow(0.5, args.destName)
	elseif spellId == 180200 then
		local amount = args.amount or 1
		warnShreddedArmor:Show(args.destName, amount)
	elseif spellId == 187089 then
		warnCleansingAura:Show(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 181488 then
		if args:IsPlayer() then
			countdownVisionofDeath:Cancel()
		end
	end
end

--If these don't work, will have to scheudle them on player debuff :\
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 180459 then--Blood Globule Spawn
		specWarnBloodGlob:Show()
		voiceBloodGlob:Play("killmob")
	elseif spellId == 181757 then--Fel Blood Globule Spawn
		specWarnFelBloodGlob:Show()
		voiceFelBloodGlob:Play("killmob")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 90523 then--Hulking Terror
		--timerRendingHowlCD:Cancel(args.destGUID)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 173192 and destGUID == UnitGUID("player") and self:AntiSpam(2) then

	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE
--]]
