local mod	= DBM:NewMod("TirnaScitheTrash", "DBM-Party-Shadowlands", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 321968 324909 324923 324914 324776 340305 340304 340300 340160 340189 326046 325418",
	"SPELL_CAST_SUCCESS 325418",
	"SPELL_AURA_APPLIED 322557 322938 324914 324776 325224 340288 326046 340544",
	"SPELL_AURA_APPLIED_DOSE 340288"
)

--All warnings/recommendations drycoded from https://www.wowhead.com/guides/mists-of-tirna-scithe-shadowlands-dungeon-strategy-guide
--TODO, adjust triple bite stack warnings? More often, less often?
--TODO, target scan crushing leap? If it can be done, and if the two aoe abilities come from leap target destination, fine tune those warnings too
--TODO, see if Pool of Radiance is too early to warn, might need to warn at 340191/rejuvenating-radiance instead
local warnOvergrowth					= mod:NewTargetAnnounce(322486, 4)
local warnFuriousThrashing				= mod:NewSpellAnnounce(324909, 3)
local warnTripleBite					= mod:NewStackAnnounce(340288, 2, nil, "Tank|Healer|RemovePoison")
local warnCrushingLeap					= mod:NewSpellAnnounce(340305, 3)--Change to target warning if target scan debug checks out
local warnVolatileAcid					= mod:NewTargetAnnounce(325418, 3)

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Ingra Maloch Trash
local specWarnSoulSplit					= mod:NewSpecialWarningDispel(322557, "RemoveMagic", nil, nil, 1, 2)
local specWarnHarvestEssence			= mod:NewSpecialWarningInterrupt(322938, "HasInterrupt", nil, nil, 1, 2)
local specWarnBewilderingPollen			= mod:NewSpecialWarningDodge(321968, "Tank", nil, nil, 1, 2)
local specWarnOvergrowth				= mod:NewSpecialWarningMoveTo(322486, nil, nil, nil, 1, 11)
local specWarnBrambleBurst				= mod:NewSpecialWarningDodge(324923, nil, nil, nil, 2, 2)
--Notable Mistcaller Trash
local specWarnNourishtheForest			= mod:NewSpecialWarningInterrupt(324914, "HasInterrupt", nil, nil, 1, 2)
local specWarnNourishtheForestDispel	= mod:NewSpecialWarningDispel(324914, "MagicDispeller", nil, nil, 1, 2)
local specWarnBramblethornCoat			= mod:NewSpecialWarningInterrupt(324776, "HasInterrupt", nil, nil, 1, 2)
local specWarnBramblethornCoatDispel	= mod:NewSpecialWarningDispel(324776, "MagicDispeller", nil, nil, 1, 2)
local specWarnAnimaInjection			= mod:NewSpecialWarningDispel(325224, "RemoveMagic", nil, nil, 1, 2)
local specWarnPoisonousSecretions		= mod:NewSpecialWarningDodge(340304, nil, nil, nil, 2, 2)
local specWarnTongueLashing				= mod:NewSpecialWarningDodge(340300, nil, nil, nil, 2, 2)
local specWarnRadiantBreath				= mod:NewSpecialWarningDodge(340160, nil, nil, nil, 2, 2)
local specWarnPoolOfRadiance			= mod:NewSpecialWarningMove(340189, "Tank", nil, nil, 1, 10)
--Notable Tred'ova Trash
local specWarnStimulateResistance		= mod:NewSpecialWarningInterrupt(326046, "HasInterrupt", nil, nil, 1, 2)
local specWarnStimulateResistanceDispel	= mod:NewSpecialWarningDispel(326046, "MagicDispeller", nil, nil, 1, 2)
local specWarnStimulateRegeneration		= mod:NewSpecialWarningInterrupt(340544, "HasInterrupt", nil, nil, 1, 2)
local specWarnVolatileAcid				= mod:NewSpecialWarningMoveAway(325418, nil, nil, nil, 1, 2)
local yellVolatileAcid					= mod:NewYell(325418)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role

function mod:CrushingLeap(targetname, uId)
	if not targetname then return end
	DBM:Debug("Crushing Leap on "..targetname)
--	warnRicochetingThrow:Show(targetname)
--	if targetname == UnitName("player") then
--		yellRicochetingThrow:Yell()
--	end
end

--About 1 second faster than debuff
function mod:VolatileAcid(targetname, uId)
	if not targetname then return end
	if self:AntiSpam(3, targetname) then
		if targetname == UnitName("player") then
			specWarnVolatileAcid:Show()
			specWarnVolatileAcid:Play("runout")
			yellVolatileAcid:Yell()
		else
			warnVolatileAcid:Show(targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	if not self:IsValidWarning(args.sourceGUID) then return end--Filter all casts done by mobs in combat with npcs/other mobs.
	local spellId = args.spellId
	if spellId == 321968 and self:AntiSpam(3, 2) then
		specWarnBewilderingPollen:Show()
		specWarnBewilderingPollen:Play("shockwave")
	elseif spellId == 324909 and self:AntiSpam(3, 4) then
		warnFuriousThrashing:Show()
	elseif spellId == 324923 and self:AntiSpam(3, 2) then
		specWarnBrambleBurst:Show()
		specWarnBrambleBurst:Play("watchfeet")
	elseif spellId == 324914 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnNourishtheForest:Show(args.sourceName)
		specWarnNourishtheForest:Play("kickcast")
	elseif spellId == 324776 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnBramblethornCoat:Show(args.sourceName)
		specWarnBramblethornCoat:Play("kickcast")
	elseif spellId == 326046 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStimulateResistance:Show(args.sourceName)
		specWarnStimulateResistance:Play("kickcast")
	elseif spellId == 340305 then
		warnCrushingLeap:Show()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "CrushingLeap", 0.1, 4)
	elseif spellId == 340304 and self:AntiSpam(3, 2) then
		specWarnPoisonousSecretions:Show()
		specWarnPoisonousSecretions:Play("watchstep")
	elseif spellId == 340300 and self:AntiSpam(3, 2) then
		specWarnTongueLashing:Show()
		specWarnTongueLashing:Play("watchstep")
	elseif spellId == 340160 and self:AntiSpam(3, 2) then
		specWarnRadiantBreath:Show()
		specWarnRadiantBreath:Play("watchstep")
	elseif spellId == 340189 then--No Antispam, not to be throttled against other types
		specWarnPoolOfRadiance:Show()
		specWarnPoolOfRadiance:Play("mobout")
	elseif spellId == 325418 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "CrushingLeap", 0.1, 4)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 325418 and self:AntiSpam(3, args.destName) then--Backup, in case no one in party was targetting mob casting Volatile Acid (ie target scanning would fail)
		if args:IsPlayer() then
			specWarnVolatileAcid:Show()
			specWarnVolatileAcid:Play("runout")
			yellVolatileAcid:Yell()
		else
			warnVolatileAcid:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 322557 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnSoulSplit:Show(args.destName)
		specWarnSoulSplit:Play("helpdispel")
	elseif spellId == 325224 and args:IsDestTypePlayer() and self:CheckDispelFilter() and self:AntiSpam(3, 5) then
		specWarnAnimaInjection:Show(args.destName)
		specWarnAnimaInjection:Play("helpdispel")
	elseif spellId == 322938 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnHarvestEssence:Show(args.sourceName)
		specWarnHarvestEssence:Play("kickcast")
	elseif spellId == 340544 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnStimulateRegeneration:Show(args.sourceName)
		specWarnStimulateRegeneration:Play("kickcast")
	elseif spellId == 322486 then
		if args:IsPlayer() then
			specWarnOvergrowth:Show()
			specWarnOvergrowth:Play("movemelee")--Eh most accurate way to say move into melee for now, TODO, switch to movemelee
		else
			warnOvergrowth:Show(args.destName)
		end
	elseif spellId == 322557 and self:IsValidWarning(args.destGUID) and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnNourishtheForestDispel:Show(args.destName)
		specWarnNourishtheForestDispel:Play("helpdispel")
	elseif spellId == 324776 and self:IsValidWarning(args.destGUID) and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnBramblethornCoatDispel:Show(args.destName)
		specWarnBramblethornCoatDispel:Play("helpdispel")
	elseif spellId == 326046 and self:IsValidWarning(args.destGUID) and args:IsDestTypeHostile() and self:AntiSpam(3, 5) then
		specWarnStimulateResistanceDispel:Show(args.destName)
		specWarnStimulateResistanceDispel:Play("helpdispel")
	elseif spellId == 340288 and args:IsDestTypePlayer() then
		local amount = args.amount or 1
		if amount % 2 == 0 then
			warnTripleBite:Show(args.destName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
