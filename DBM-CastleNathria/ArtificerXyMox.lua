local mod	= DBM:NewMod(2418, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(166644)
mod:SetEncounterID(2405)
mod:SetUsedIcons(1, 2)
--mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328437 329256 325399 327887 329770 328789",
	"SPELL_CAST_SUCCESS 325361 326271",
	"SPELL_AURA_APPLIED 328448 328468 325236 327902 327414",
	"SPELL_AURA_REMOVED 328448 328468 325236 327902"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify trap event, remove antispam if not needed
--TODO, hyperlight spark warning intensity?
--TODO, fix relic timers up further
--TODO, https://shadowlands.wowhead.com/spell=327901/summon-fleeting-spirit might be used instead for add spawns
--TODO, add https://shadowlands.wowhead.com/spell=340842/soul-singe ?
--TODO, non mythic and mythic weapon changes/phase changes and their impact on timers
local warnDimensionalTear							= mod:NewTargetNoFilterAnnounce(328437, 3)
local warnHyperlightSpark							= mod:NewCountAnnounce(325399, 2)
--Sire Denathrius' Private Collection
local warnCrystalofPhantasms						= mod:NewSpellAnnounce("ej22124", 3, 327887)
local warnFixate									= mod:NewTargetAnnounce(327902, 3)--Two bosses dead
local warnPossession								= mod:NewTargetNoFilterAnnounce(327414, 3)
local warnRootofExtinction							= mod:NewSpellAnnounce(329770, 3, nil, nil, 130924)--Shortname "Root"

local specWarnDimensionalTear						= mod:NewSpecialWarningYouPos(328437, nil, nil, nil, 1, 2)
local yellDimensionalTear							= mod:NewPosYell(328437)
local yellDimensionalTearFades						= mod:NewIconFadesYell(328437)
local specWarnGlyphofDestruction					= mod:NewSpecialWarningMoveAway(325361, nil, nil, nil, 1, 2)
local yellGlyphofDestruction						= mod:NewYell(325361)
local yellGlyphofDestructionFades					= mod:NewFadesYell(325361)
local specWarnGlyphofDestructionTaunt				= mod:NewSpecialWarningTaunt(325361, nil, nil, nil, 1, 2)
local specWarnStasisTrap							= mod:NewSpecialWarningDodge(326271, nil, nil, nil, 2, 2)
local specWarnRiftBlast								= mod:NewSpecialWarningDodge(329256, nil, nil, nil, 2, 2)
--Sire Denathrius' Private Collection
local specWarnFixate								= mod:NewSpecialWarningRun(327902, nil, nil, nil, 4, 2)
local specWarnEdgeofAnnihilation					= mod:NewSpecialWarningRun(328789, nil, 307421, nil, 4, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

mod:AddTimerLine(BOSS)
local timerDimensionalTearCD						= mod:NewAITimer(44.3, 328437, nil, nil, nil, 3)
local timerGlyphofDestructionCD						= mod:NewAITimer(16.6, 325361, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON, nil, 2, 3)
local timerStasisTrapCD								= mod:NewAITimer(44.3, 326271, nil, nil, nil, 3)
local timerRiftBlastCD								= mod:NewAITimer(44.3, 329256, nil, nil, nil, 3)
local timerHyperlightSparkCD						= mod:NewAITimer(44.3, 325399, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)
--Sire Denathrius' Private Collection
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22119))
--TODO, use parent timer if order is random, use sub timers if it's a fixed order
--local timerRelicsofCastleNathriaCD				= mod:NewAITimer(44.3, "ej22119", 254789, nil, nil, 6, 327887)--ShortName "Create Relic"
local timerCrystalofPhantasmsCD						= mod:NewAITimer(44.3, "ej22124", nil, nil, nil, 1, 327887)
local timerRootofExtinctionCD						= mod:NewAITimer(44.3, 329770, 130924, nil, nil, 5)--Shortname "Root"
local timerEdgeofAnnihilationCD						= mod:NewAITimer(44.3, 328789, 307421, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--Shortname "Annihilation"

--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconOnCypher", 328437, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnFixate", 327902)

local tempIconVariable = 1
mod.vb.spartCount = 0

function mod:OnCombatStart(delay)
	self.vb.spartCount = 0
	timerDimensionalTearCD:Start(1-delay)
	timerGlyphofDestructionCD:Start(1-delay)--SUCCESS
	timerStasisTrapCD:Start(1-delay)
	timerRiftBlastCD:Start(1-delay)
	timerHyperlightSparkCD:Start(1-delay)
	--Relics
--	timerCrystalofPhantasmsCD:Start(1-delay)
--	timerRootofExtinctionCD:Start(1-delay)
--	timerEdgeofAnnihilationCD:Start(1-delay)
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)--For Acid Splash
--	end
--	berserkTimer:Start(-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328437 then
		tempIconVariable = 1
		timerDimensionalTearCD:Start()
	elseif spellId == 329256 then--335013 alternate ID
		specWarnRiftBlast:Show()
		specWarnRiftBlast:Play("farfromline")
		timerRiftBlastCD:Start()
	elseif spellId == 325399 then
		self.vb.spartCount = self.vb.spartCount + 1
		warnHyperlightSpark:Show(self.vb.spartCount)
		timerHyperlightSparkCD:Start()
	elseif spellId == 327887 then
		warnCrystalofPhantasms:Show()
		timerCrystalofPhantasmsCD:Start()
	elseif spellId == 329770 then
		warnRootofExtinction:Show()
		timerRootofExtinctionCD:Start()
	elseif spellId == 328789 then
		specWarnEdgeofAnnihilation:Show()
		specWarnEdgeofAnnihilation:Play("justrun")
		specWarnEdgeofAnnihilation:ScheduleVoice(2, "keepmove")
		timerEdgeofAnnihilationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325361 then
		timerGlyphofDestructionCD:Start()
	elseif spellId == 326271 and self:AntiSpam(5, 1) then
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		warnDimensionalTear:CombinedShow(1, args.destName)
		--local icon = 328448 and 1 or 2--This is better way to do it, but needs confirmation of combat log using both events first
		local icon = tempIconVariable
		if args:IsPlayer() then
			specWarnDimensionalTear:Show(self:IconNumToTexture(icon))
			specWarnDimensionalTear:Play("mm"..icon)
			yellDimensionalTear:Yell(icon, icon, icon)
			yellDimensionalTearFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnCypher then
			self:SetIcon(args.destName, icon)
		end
		tempIconVariable = tempIconVariable + 1
	elseif spellId == 325236 then
		if args:IsPlayer() then
			specWarnGlyphofDestruction:Show()
			specWarnGlyphofDestruction:Play("runout")
			yellGlyphofDestruction:Yell()
			yellGlyphofDestructionFades:Countdown(spellId)
		else
			specWarnGlyphofDestructionTaunt:Show(args.destName)
			specWarnGlyphofDestructionTaunt:Play("tauntboss")
		end
	elseif spellId == 327902 then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 12)
			end
		end
	elseif spellId == 327414 then
		warnPossession:CombinedShow(1, args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		if args:IsPlayer() then
			yellDimensionalTearFades:Cancel()
		end
	elseif spellId == 327902 and args:IsPlayer() then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then

	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 310351 then

	end
end
--]]
