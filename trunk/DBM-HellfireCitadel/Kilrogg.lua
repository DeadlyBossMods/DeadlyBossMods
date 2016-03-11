local mod	= DBM:NewMod(1396, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90378)
mod:SetEncounterID(1786)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod:SetHotfixNoticeRev(14286)
mod.respawnTime = 15

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180199 180224 182428 180163 183917",
	"SPELL_CAST_SUCCESS 180410 180413",
	"SPELL_AURA_APPLIED 180313 180200 188929 181488",
	"SPELL_AURA_APPLIED_DOSE 180200",
	"SPELL_AURA_REMOVED 181488",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--(ability.id = 180199 or ability.id = 180224 or ability.id = 182428 or ability.id = 180163 or ability.id = 183917) and type = "begincast" or (ability.id = 180410 or ability.id = 180413) and type = "cast" or ability.id = 188929 and type = "applydebuff"
--TODO, more stuff for the eyes phase adds if merited
--Boss
local warnDemonicPossession			= mod:NewTargetAnnounce(180313, 4)
local warnShreddedArmor				= mod:NewStackAnnounce(180200, 4, nil, "Tank|Healer")--Shouldn't happen, but is going to.
local warnHeartseeker				= mod:NewTargetAnnounce(180372, 4)
local warnVisionofDeath				= mod:NewTargetAnnounce(181488, 2)--The targets that got picked
--Adds
local warnBloodthirster				= mod:NewSpellAnnounce("ej11266", 3, 131150)

--Boss
local specWarnShred					= mod:NewSpecialWarningSpell(180199, nil, nil, nil, 3, 2)--Block, or get debuff
local specWarnHeartSeeker			= mod:NewSpecialWarningRun(180372, nil, nil, nil, 4, 2)--Must run as far from boss as possible
local yellHeartSeeker				= mod:NewYell(180372)
local specWarnDeathThroes			= mod:NewSpecialWarningCount(180224, nil, nil, nil, 2, 2)
local specWarnVisionofDeath			= mod:NewSpecialWarningCount(182428)--Seems everyone goes down at some point, dps healers and off tank. Each getting different abiltiy when succeed
--Adds
local specWarnSavageStrikes			= mod:NewSpecialWarningSpell(180163, nil, nil, nil, 1, 2)
local specWarnBloodGlob				= mod:NewSpecialWarningSwitch(180459, "Dps", nil, nil, 1, 5)
local specWarnFelBloodGlob			= mod:NewSpecialWarningSwitch(180413, "Dps", nil, nil, 3, 5)
local specWarnBloodthirster			= mod:NewSpecialWarningSwitch("ej11266", "Dps", nil, 2, 1, 5)--Very frequent, let specwarn be an option
local specWarnHulkingTerror			= mod:NewSpecialWarningSwitch("ej11269", "Tank", nil, 2, 1, 5)
local specWarnRendingHowl			= mod:NewSpecialWarningInterruptCount(183917, "HasInterrupt", nil, 2, 1, 5)

--Boss
--Next timers that are delayed by other next timers. how annoying
--CDs used for all of them because of them screwing with eachother.
--Coding them perfectly is probably possible but VERY ugly, would require tones of calculating on the overlaps and lots of on fly adjusting.
--Adjusting one timer like blackhand no big deal, checking time remaining on THREE other abilities any time one of these are cast, and on fly adjusting, no
local timerShredCD					= mod:NewCDTimer(17, 180199, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerHeartseekerCD			= mod:NewCDTimer(25, 180372, nil, nil, nil, 3)
local timerVisionofDeathCD			= mod:NewCDCountTimer(75, 181488, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerDeathThroesCD			= mod:NewCDCountTimer(40, 180224, nil, nil, nil, 2)
--Adds
local timerBloodthirsterCD			= mod:NewCDCountTimer(70.3, "ej11266", nil, nil, nil, 1, 131150, DBM_CORE_DAMAGE_ICON)--55969 is an iffy short name for bloodthirster since "bloodthirst" is all I could find that was close
local timerRendingHowlCD			= mod:NewNextTimer(6, 183917, nil, "HasInterrupt", 2, 4, nil, DBM_CORE_INTERRUPT_ICON)

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownVisionofDeathCD		= mod:NewCountdown(75, 181488, "Tank")
local countdownShred				= mod:NewCountdown("Alt17", 180199, "Tank")
local countdownVisionofDeath		= mod:NewCountdownFades("Alt60", 181488)

local voiceShred					= mod:NewVoice(180199)--defensive
local voiceSavageStrikes			= mod:NewVoice(180163)--defensive
local voiceHeartSeeker				= mod:NewVoice(180372)--runout
local voiceDeathThroes				= mod:NewVoice(180224)--aesoon
local voiceBloodGlob				= mod:NewVoice(180459)--180459
local voiceFelBloodGlob				= mod:NewVoice(180413)--180199 (wrong spellID for voice do to my mistake)
local voiceBloodthirster			= mod:NewVoice("ej11266", "Dps", nil, 2)--ej11266
local voiceHulkingTerror			= mod:NewVoice("ej11269", "Tank", nil, 2)--ej11269
local voiceRendingHowl				= mod:NewVoice(183917, "HasInterrupt")

mod:AddInfoFrameOption("ej11280")

mod.vb.berserkerCount = 0
mod.vb.deathThrowsCount = 0
mod.vb.visionsCount = 0
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local felCorruption = GetSpellInfo(182159)
local Bloodthirster = EJ_GetSectionInfo(11266)
local AddsSeen = {}
local HowlByGUID = {}--Not syncable, but keeps separate count for each add cleanly

function mod:OnCombatStart(delay)
	table.wipe(HowlByGUID)
	self.vb.berserkerCount = 0
	self.vb.deathThrowsCount = 0
	self.vb.visionsCount = 0
	timerBloodthirsterCD:Start(6-delay, 1)
	timerShredCD:Start(10-delay)
	countdownShred:Start(10-delay)
	timerHeartseekerCD:Start(-delay)
	timerDeathThroesCD:Start(39-delay, 1)
	timerVisionofDeathCD:Start(61-delay, 1)
	countdownVisionofDeathCD:Start(61-delay)
	berserkTimer:Start(-delay)
	table.wipe(AddsSeen)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(felCorruption)
		DBM.InfoFrame:Show(5, "playerpower", 5, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180199 then
		timerShredCD:Start()
		countdownShred:Start()
		for i = 1, 5 do--Maybe only 1 needed, but don't know if any adds take boss IDs
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnShred:Show()--Show warning only to the tank he's on, not both tanks, avoid confusion
				voiceShred:Play("defensive")
				break
			end
		end
	elseif spellId == 180224 then
		self.vb.deathThrowsCount = self.vb.deathThrowsCount + 1
		specWarnDeathThroes:Show(self.vb.deathThrowsCount)
		voiceDeathThroes:Play("aesoon")
		timerDeathThroesCD:Start(nil, self.vb.deathThrowsCount+1)
	elseif spellId == 182428 then
		self.vb.visionsCount = self.vb.visionsCount + 1
		specWarnVisionofDeath:Show(self.vb.visionsCount)
		timerVisionofDeathCD:Start(nil, self.vb.visionsCount+1)
		countdownVisionofDeathCD:Start()
	elseif spellId == 180163 then
		timerRendingHowlCD:Start(9.8, args.sourceGUID)--Savage strikes, replaces either 2nd or 3rd Howl. When it does, next howl is always 10 seconds later
		for i = 1, 5 do--Maybe only 1 needed, but don't know if any adds take boss IDs
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				specWarnSavageStrikes:Show()--Show warning only to the tank he's on, not both tanks, avoid confusion
				voiceSavageStrikes:Play("defensive")
				break
			end
		end
	elseif spellId == 183917 then
		if not HowlByGUID[args.sourceGUID] then HowlByGUID[args.sourceGUID] = 0 end
		HowlByGUID[args.sourceGUID] = HowlByGUID[args.sourceGUID] + 1
		local count = HowlByGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnRendingHowl:Show(args.sourceName, count)
			if count == 1 then
				voiceRendingHowl:Play("kick1r")
			elseif count == 2 then
				voiceRendingHowl:Play("kick2r")
			elseif count == 3 then
				voiceRendingHowl:Play("kick3r")
			elseif count == 4 then
				voiceRendingHowl:Play("kick4r")
			elseif count == 5 then
				voiceRendingHowl:Play("kick5r")
			else
				voiceRendingHowl:Play("kickcast")
			end
		end
		timerRendingHowlCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180410 and self:AntiSpam(2, 2) then--Blood Globule
		specWarnBloodGlob:Show()
		voiceBloodGlob:Play("180459")
	elseif spellId == 180413 and self:AntiSpam(2, 3) then--Fel Blood Globule
		specWarnFelBloodGlob:Show()
		voiceFelBloodGlob:Play("180199")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 188929 and args:IsDestTypePlayer() then
		warnHeartseeker:CombinedShow(0.3, args.destName)--Multiple targets on mythic
		timerHeartseekerCD:Cancel()
		timerHeartseekerCD:Start()
		if args:IsPlayer() then
			specWarnHeartSeeker:Show()
			yellHeartSeeker:Yell()
			voiceHeartSeeker:Play("runout")
		elseif self:IsMelee() and self:AntiSpam(2, 4) then
			voiceHeartSeeker:Play("158078")--farawayfromline
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

--Boss always pre yells before the 3 adds jump down
--3 adds always jump down rougly about 8 seconds after yell first two jump down together, one in back and one directly into puddle, gaurenteeing at least one hulking always.
--Last add tends to wait about 8-12 seconds (variable) before it jumps down in back as well.
--Maybe add separate timer for adds jumping down, but reviewing videos they wouldn't be all too accurate do to variation, so for now i'm omitting that.
function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
	if msg == L.BloodthirstersSoon then
		self:SendSync("BloodthirstersSoon")
	end
end

--Adds jumping down, we can detect/announce this way
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitGUID = UnitGUID("boss"..i)
		if unitGUID and not AddsSeen[unitGUID] then
			AddsSeen[unitGUID] = true
			local cid = self:GetCIDFromGUID(unitGUID)
			if (cid == 92038 or cid == 90521 or cid == 93369) and self:AntiSpam(3, 1) and not self:IsTank() then--Salivating Bloodthirster. Antispam should filter the two that jump down together
				if self.Options.SpecWarnej11266switch then
					specWarnBloodthirster:Show()
				else
					warnBloodthirster:Show()
				end
				voiceBloodthirster:Play("ej11266")
			end
		end
	end
end

--INSTANCE_ENCOUNTER_ENGAGE_UNIT cannot be used accurately because cid and guid doesn't change from when it was a Salivating Bloodthirster
--However, RAID_BOSS_EMOTE fires for one thing and one thing only on this fight. This will also detect if one of the two that didn't jump directly into puddle, makes it to puddle as well
function mod:RAID_BOSS_EMOTE(msg, npc)
	if npc == Bloodthirster then
		specWarnHulkingTerror:Show()
		voiceHulkingTerror:Play("ej11269")
	end
end

function mod:OnSync(msg)
	if msg == "BloodthirstersSoon" and self:IsInCombat() then
		self.vb.berserkerCount = self.vb.berserkerCount + 1
		timerBloodthirsterCD:Start(nil, self.vb.berserkerCount+1)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 90523 or cid == 92744 then--Hulking Terror
		HowlByGUID[args.sourceGUID] = nil
		timerRendingHowlCD:Cancel(args.destGUID)
	end
end
