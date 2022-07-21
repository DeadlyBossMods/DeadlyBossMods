local mod	= DBM:NewMod(2489, "DBM-Party-Dragonflight", 4, 1199)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(189478)--Forgemaster Gorek
mod:SetEncounterID(2612)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 374969",
	"SPELL_CAST_SUCCESS 374635 374842 374534",
	"SPELL_AURA_APPLIED 374842 374534",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 374534"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[
(ability.id = 374969) and type = "begincast"
 or (ability.id = 374635 or ability.id = 374842 or ability.id = 374534) and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnVolcanicAxe							= mod:NewTargetNoFilterAnnounce(374842, 3)
local warnHeatedSwings							= mod:NewTargetNoFilterAnnounce(374534, 3)

local specWarnMightoftheForge					= mod:NewSpecialWarningSpell(374635, nil, nil, nil, 2, 2)
local specWarnVolcanicAxe						= mod:NewSpecialWarningMoveAway(374842, nil, nil, nil, 1, 2)
local yellVolcanicAxe							= mod:NewYell(374842)
local specWarnHeatedSwings						= mod:NewSpecialWarningMoveAway(374534, nil, nil, nil, 1, 2)
local yellHeatedSwings							= mod:NewYell(374534)
local yellHeatedSwingsFades						= mod:NewShortFadesYell(374534)
local specWarnForgestorm						= mod:NewSpecialWarningDodge(374969, nil, nil, nil, 2, 2)
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--All timers are 30-31 ish
local timerMightoftheForgeCD					= mod:NewNextTimer(30.3, 374635, nil, nil, nil, 6, nil, DBM_COMMON_L.HEALER_ICON)--Technically Blazing Hammer is healer icon, but it's passive of this stage
local timerVolcanicAxeCD						= mod:NewNextTimer(30.3, 374842, nil, nil, nil, 3)
local timerHeatedSwingsCD						= mod:NewNextTimer(30.3, 374534, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tracked by all since it has 8 yard splash damage
local timerForgestormCD							= mod:NewNextTimer(30.3, 374969, nil, nil, nil, 2)

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)
--mod:AddSetIconOption("SetIconOnStaggeringBarrage", 361018, true, false, {1, 2, 3})

function mod:OnCombatStart(delay)
	timerMightoftheForgeCD:Start(3.2-delay)
	timerVolcanicAxeCD:Start(11.5-delay)
	timerHeatedSwingsCD:Start(20.2-delay)
	timerForgestormCD:Start(26.7-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 374969 then
		specWarnForgestorm:Show()
		specWarnForgestorm:Play("watchstep")
		timerForgestormCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 374635 then
		specWarnMightoftheForge:Show()
		specWarnMightoftheForge:Play("specialsoon")
		timerMightoftheForgeCD:Start()
	elseif spellId == 374842 then
		timerVolcanicAxeCD:Start()
	elseif spellId == 374534 then
		timerHeatedSwingsCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 374842 then
		if args:IsPlayer() then
			specWarnVolcanicAxe:Show()
			specWarnVolcanicAxe:Play("runout")
			yellVolcanicAxe:Yell()
		else
			warnVolcanicAxe:Show(args.destName)
		end
	elseif spellId == 374534 then
		if args:IsPlayer() then
			specWarnHeatedSwings:Show()
			specWarnHeatedSwings:Play("runout")
			yellHeatedSwings:Yell()
			yellHeatedSwingsFades:Countdown(spellId)
		else
			warnHeatedSwings:Show(args.destName)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 374534 then
		if args:IsPlayer() then
			yellHeatedSwingsFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
