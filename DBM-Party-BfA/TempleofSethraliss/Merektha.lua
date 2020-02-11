local mod	= DBM:NewMod(2143, "DBM-Party-BfA", 6, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(133384)
mod:SetEncounterID(2125)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267050 263957 263958",
	"SPELL_AURA_REMOVED 267050",
	"SPELL_CAST_START 272657 263914 264239 264233",
	"SPELL_CAST_SUCCESS 263957",
	"SPELL_PERIODIC_DAMAGE 263927",
	"SPELL_PERIODIC_MISSED 263927",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, can eggs be attacked during hatch to reduce add spawns? if so change to special switch warning
--TODO, remove hatch nameplate aura if they don't have nameplates
--TODO, add new class info for "HasStun" so can be used on specWarnKnotofSnakes
--TODO, timers for breath and blind are inconsistent with burrows.
local warnHatch						= mod:NewCastAnnounce(264239, 3)
local warnBurrow					= mod:NewSpellAnnounce(264206, 2, nil, nil, nil, nil, nil, nil, true)

local specWarnHadotoxinOther		= mod:NewSpecialWarningDispel(263957, "RemovePoison", nil, nil, 1, 2)
local specWarnNoxiousBreath			= mod:NewSpecialWarningDodge(272657, nil, nil, nil, 2, 2)
local specWarnBlindingSand			= mod:NewSpecialWarningLookAway(263914, nil, nil, nil, 2, 2)
local specWarnKnotofSnakes			= mod:NewSpecialWarningSwitch(263958, "-Healer", nil, nil, 1, 2)
local specWarnKnotofSnakesYou		= mod:NewSpecialWarningYou(263958, nil, nil, nil, 1, 2)
local yellKnotofSnakes				= mod:NewYell(263958)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(263927, nil, nil, nil, 1, 8)

local timerHadotoxinCD				= mod:NewAITimer(13, 263957, nil, "Tank|Healer|RemovePoison", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_POISON_ICON)
local timerNoxiousBreathCD			= mod:NewCDTimer(89.3, 272657, nil, nil, nil, 3)
--local timerBlindingSandCD			= mod:NewCDTimer(51, 263914, nil, nil, nil, 2)
--local timerHatchCD					= mod:NewCDTimer(43.9, 264239, nil, nil, nil, 1)--even need a CD bar or just cast bar?
--local timerBurrowCD					= mod:NewCDTimer(13, 264206, nil, nil, nil, 6)--Health based apparently
--local timerBurrowEnds				= mod:NewBuffActiveTimer(13, 264206, nil, nil, nil, 6)

mod:AddNamePlateOption("NPAuraOnObscured", 267050)


function mod:OnCombatStart(delay)
	timerHadotoxinCD:Start(1-delay)
	timerNoxiousBreathCD:Start(6-delay)
	--timerBurrowCD:Start(15.2-delay)
	if self.Options.NPAuraOnObscured then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnObscured then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 263957 and self:CheckDispelFilter() then
		specWarnHadotoxinOther:Show(args.destName)
		specWarnHadotoxinOther:Play("helpdispel")
	elseif spellId == 267050 then--Obscured
		if self.Options.NPAuraOnObscured then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 263958 then
		if args:IsPlayer() then
			specWarnKnotofSnakesYou:Show()
			specWarnKnotofSnakesYou:Play("targetyou")
			yellKnotofSnakes:Yell()
		else
			specWarnKnotofSnakes:Show()
			specWarnKnotofSnakes:Play("killmob")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 267050 then--Obscured
		if self.Options.NPAuraOnObscured then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 272657 then
		specWarnNoxiousBreath:Show()
		specWarnNoxiousBreath:Play("watchstep")
		--timerNoxiousBreathCD:Start()
	elseif spellId == 263914 then
		specWarnBlindingSand:Show(args.sourceName)
		specWarnBlindingSand:Play("turnaway")
	elseif (spellId == 264239 or spellId == 264233) then--Hatch
		if self:AntiSpam(3, 1) then
			warnHatch:Show()--Cast instantly when burrow ends
			--timerBlindingSandCD:Start(6)
			--timerBurrowCD:Start(18)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 263957 then
		timerHadotoxinCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 263927 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 264172 then--Summon (cast when he burrows)
		timerHadotoxinCD:Stop()
		timerNoxiousBreathCD:Stop()
		--timerBlindingSandCD:Stop()
		warnBurrow:Show()
		warnBurrow:Play("phasechange")
	end
end
