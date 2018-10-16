local dungeonID, creatureID
local breathId, strikeId, gtfoId
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID = 2345, 148295--Ivus the Decayed
	breathId, strikeId, gtfoId = 287537, 287549, 287538
else--Horde
	dungeonID, creatureID = 2329, 144946--Ivus the Forest Lord
	breathId, strikeId, gtfoId = 282404, 282486, 282414
end
local mod	= DBM:NewMod(dungeonID, "DBM-Azeroth-BfA", nil, 1028)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(creatureID)
--mod:SetEncounterID(2263)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282404 287537 282463 282486 287549 282615",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 282414 287538",
	"SPELL_AURA_REMOVED 282615"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnPetrify						= mod:NewSpellAnnounce(282615, 2, nil, nil, nil, nil, nil, 2)
local warnPetrifyEnded					= mod:NewEndAnnounce(282615, 2, nil, nil, nil, nil, nil, 2)

local specWarnBreath					= mod:NewSpecialWarningSpell(breathId, nil, nil, nil, 1, 2)
local specWarnShockwave					= mod:NewSpecialWarningDodge(282463, nil, nil, nil, 2, 2)
local specWarnGroundSpell				= mod:NewSpecialWarningSpell(strikeId, nil, nil, nil, 2, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(gtfoId, nil, nil, nil, 1, 2)

local timerBreathCD						= mod:NewAITimer(20.1, breathId, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerShockwaveCD					= mod:NewAITimer(23.1, 282463, nil, nil, nil, 3)
local timerGroundSpellCD				= mod:NewAITimer(23.1, strikeId, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddReadyCheckOption(37460, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerBreathCD:Start(1-delay)
		--timerShockwaveCD:Start(1-delay)
		--timerGroundSpellCD:Start(1-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282404 or spellId == 287537 then
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		timerBreathCD:Start()
	elseif spellId == 282463 then
		specWarnShockwave:Show()
		specWarnShockwave:Play("shockwave")
		timerShockwaveCD:Start()
	elseif spellId == 282486 or spellId == 287549 then
		specWarnGroundSpell:Show()
		specWarnGroundSpell:Play("watchstep")
		timerGroundSpellCD:Start()
	elseif spellId == 282615 then
		warnPetrify:Show()
		warnPetrify:Play("pchange")
		timerShockwaveCD:Stop()
		timerBreathCD:Stop()
		timerGroundSpellCD:Stop()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282543 or spellId == 282179 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if (spellId == 282414 or spellId == 287538) and args:IsPlayer() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282615 then
		warnPetrifyEnded:Show()
		warnPetrifyEnded:Play("pchange")
		timerShockwaveCD:Start(2)
		timerBreathCD:Start(2)
		timerGroundSpellCD:Start(2)
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144998 or cid == 144876 then--Death Specter/Apetagonizer 3000
		castsPerGUID[args.destGUID] = nil
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--Backup add spawn triggers in case CLEU stuff gets purged
	if spellId == 286450 or spellId == 282082 then

	end
end
--]]
