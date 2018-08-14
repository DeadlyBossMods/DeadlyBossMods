local mod	= DBM:NewMod(2143, "DBM-Party-BfA", 6, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(133384)
mod:SetEncounterID(2125)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 267050 263957 263958",
	"SPELL_AURA_REMOVED 267050 263958",
	"SPELL_CAST_START 272657 263914 264239",
	"SPELL_CAST_SUCCESS 263957 264206",
	"SPELL_PERIODIC_DAMAGE 263927",
	"SPELL_PERIODIC_MISSED 263927"
)

--TODO, breath a tank only target or any target?
--TODO, can eggs be attacked during hatch to reduce add spawns? if so change to special switch warning
--TODO, verify burrow event/fix it
--TODO, remove hatch nameplate aura if they don't have nameplates
--TODO, add new class info for "HasStun" so can be used on specWarnKnotofSnakes
local warnHatch						= mod:NewCastAnnounce(264239, 3)
local warnBurrow					= mod:NewSpellAnnounce(264206, 2, nil, nil, nil, nil, nil, nil, true)

local specWarnHadotoxinOther		= mod:NewSpecialWarningDispel(263957, "RemovePoison", nil, nil, 1, 2)
local specWarnNoxiousBreath			= mod:NewSpecialWarningDodge(272657, nil, nil, nil, 2, 2)
local specWarnBlindingSand			= mod:NewSpecialWarningLookAway(263914, nil, nil, nil, 2, 2)
local specWarnKnotofSnakes			= mod:NewSpecialWarningSwitch(263914, "-Healer", nil, nil, 1, 2)
local specWarnKnotofSnakesYou		= mod:NewSpecialWarningYou(263914, nil, nil, nil, 1, 2)
local yellKnotofSnakes				= mod:NewYell(263958)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(263927, nil, nil, nil, 1, 2)

local timerHadotoxinCD				= mod:NewAITimer(13, 263957, nil, "Tank|Healer|RemovePoison", nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_POISON_ICON)
local timerNoxiousBreathCD			= mod:NewAITimer(13, 272657, nil, nil, nil, 3)
local timerBlindingSandCD			= mod:NewAITimer(13, 263914, nil, nil, nil, 2)
local timerHatchCD					= mod:NewAITimer(13, 264239, nil, nil, nil, 1)--even need a CD bar or just cast bar?
local timerBurrowCD					= mod:NewAITimer(13, 264206, nil, nil, nil, 6)
--local timerBurrowEnds				= mod:NewBuffActiveTimer(13, 264206, nil, nil, nil, 6)

--mod:AddRangeFrameOption(5, 194966)
mod:AddNamePlateOption("NPAuraOnObscured", 267050)
mod:AddNamePlateOption("NPAuraOnHatch", 264233)


function mod:OnCombatStart(delay)
	timerHadotoxinCD:Start(1-delay)
	timerNoxiousBreathCD:Start(1-delay)
	timerBlindingSandCD:Start(1-delay)
	timerHatchCD:Start(1-delay)
	timerBurrowCD:Start(1-delay)
	if self.Options.NPAuraOnObscured or self.Options.NPAuraOnHatch then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnObscured or self.Options.NPAuraOnHatch then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 263957 then
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
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 267050 then--Obscured
		if self.Options.NPAuraOnObscured then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 263958 then
		
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 272657 then
		specWarnNoxiousBreath:Show()
		specWarnNoxiousBreath:Play("watchstep")
		timerNoxiousBreathCD:Start()
	elseif spellId == 263914 then
		specWarnBlindingSand:Show()
		specWarnBlindingSand:Play("turnaway")
		timerBlindingSandCD:Start()
	elseif spellId == 264239 then--Hatch
		if self.Options.NPAuraOnHatch then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 35)
		end
		if self:AntiSpam(3, 1) then
			warnHatch:Show()
			timerHatchCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 263957 then
		timerHadotoxinCD:Start()
	elseif spellId == 264206 then
		timerHadotoxinCD:Stop()
		timerNoxiousBreathCD:Stop()
		timerBlindingSandCD:Stop()
		warnBurrow:Show()
		warnBurrow:Play("phasechange")
		timerBurrowCD:Start()--move to ended event
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 263927 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 135562 then--venomous-ophidian
	
	elseif cid == 134390 then--sand-crusted-striker
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
