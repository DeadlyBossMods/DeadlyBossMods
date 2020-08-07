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
	"SPELL_CAST_START 328437 335013 325399 327887 329770 328789 340758 329834 328880",
	"SPELL_CAST_SUCCESS 325361 326271",
	"SPELL_AURA_APPLIED 328448 328468 325236 327902 327414",
	"SPELL_AURA_REMOVED 328448 328468 327902"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, add https://shadowlands.wowhead.com/spell=340842/soul-singe ?
--TODO, non mythic and mythic weapon changes/phase changes and their impact on timers
--TODO, find the remaining like 20 conditions affecting timers
--[[
(ability.id = 328437 or ability.id = 335013 or ability.id = 325399 or ability.id = 327887 or ability.id = 340758 or ability.id = 329770 or ability.id = 329834 or ability.id = 328880 or ability.id = 328789) and type = "begincast"
 or (ability.id = 326271 or ability.id = 325361) and type = "cast"
--]]
local warnDimensionalTear							= mod:NewTargetNoFilterAnnounce(328437, 3)
local warnHyperlightSpark							= mod:NewCountAnnounce(325399, 2, nil, false, 2)
--Sire Denathrius' Private Collection
local warnCrystalofPhantasmsActivation				= mod:NewSpellAnnounce(327887, 2)
local warnFixate									= mod:NewTargetAnnounce(327902, 3)
local warnPossession								= mod:NewTargetNoFilterAnnounce(327414, 4)
local warnRootActivation							= mod:NewSpellAnnounce(329770, 2)--Activation
local warnRootofExtinction							= mod:NewSpellAnnounce(329834, 3, nil, nil, 130924)--Shortname "Root"
local warnAnnihilationActivation					= mod:NewSpellAnnounce(328880, 2)--Activation

local specWarnDimensionalTear						= mod:NewSpecialWarningYouPos(328437, nil, nil, nil, 1, 2)
local yellDimensionalTear							= mod:NewPosYell(328437)
local yellDimensionalTearFades						= mod:NewIconFadesYell(328437)
local specWarnGlyphofDestruction					= mod:NewSpecialWarningMoveAway(325361, nil, nil, nil, 1, 2)
local yellGlyphofDestruction						= mod:NewYell(325361)
local yellGlyphofDestructionFades					= mod:NewFadesYell(325361)
local specWarnGlyphofDestructionTaunt				= mod:NewSpecialWarningTaunt(325361, nil, nil, nil, 1, 2)
local specWarnStasisTrap							= mod:NewSpecialWarningDodge(326271, nil, nil, nil, 2, 2)
local specWarnRiftBlast								= mod:NewSpecialWarningDodge(335013, nil, nil, nil, 2, 2)
--Sire Denathrius' Private Collection
local specWarnFixate								= mod:NewSpecialWarningRun(327902, nil, nil, nil, 4, 2)
local specWarnEdgeofAnnihilation					= mod:NewSpecialWarningRun(328789, nil, 307421, nil, 4, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

mod:AddTimerLine(BOSS)
local timerDimensionalTearCD						= mod:NewCDTimer(45.7, 328437, nil, nil, nil, 3)--just the mean average, timer is actually COMPLETELY unknown since it's reset by so many mechanics
local timerGlyphofDestructionCD						= mod:NewCDTimer(27.9, 325361, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--27.9-58.6 for now
local timerStasisTrapCD								= mod:NewCDTimer(30.3, 326271, nil, nil, nil, 3)--30, except when its 24
local timerRiftBlastCD								= mod:NewCDTimer(36.3, 335013, nil, nil, nil, 3)--36.3 except when it's 26.8
--local timerHyperlightSparkCD						= mod:NewCDTimer(20.9, 325399, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON)--Too all over place, 6.7-30, even when not affected by phase changes
--Sire Denathrius' Private Collection
mod:AddTimerLine(DBM:EJ_GetSectionInfo(22119))
local timerFleetingSpiritsCD						= mod:NewCDTimer(45.3, 340758, nil, nil, nil, 3)
local timerRootofExtinctionCD						= mod:NewNextTimer(46.3, 329770, 130924, nil, nil, 5)--Shortname "Root"
local timerEdgeofAnnihilationCD						= mod:NewCDTimer(44.3, 328789, 307421, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)--Shortname "Annihilation"

--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(10, 310277)
--mod:AddInfoFrameOption(308377, true)
mod:AddSetIconOption("SetIconOnCypher", 328437, true, false, {1, 2})
--mod:AddNamePlateOption("NPAuraOnFixate", 327902)

mod.vb.spartCount = 0
mod.vb.annihilationCount = 0

function mod:OnCombatStart(delay)
	self.vb.spartCount = 0
	self.vb.annihilationCount = 0
--	timerHyperlightSparkCD:Start(5.7-delay)
	timerStasisTrapCD:Start(10.5-delay)
	timerDimensionalTearCD:Start(13-delay)
	timerRiftBlastCD:Start(20.3-delay)
	timerGlyphofDestructionCD:Start(27.7-delay)--SUCCESS
	DBM:AddMsg("Timers on this fight are incomplete. It may take a good bit of time to figure out every condition. I am working on it though, it'll just take some time")
--	if self.Options.NPAuraOnFixate then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Show(4)
--	end
--	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.NPAuraOnFixate then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328437 then
		timerDimensionalTearCD:Start()
	elseif spellId == 335013 then
		specWarnRiftBlast:Show()
		specWarnRiftBlast:Play("farfromline")
		timerRiftBlastCD:Start()
	elseif spellId == 325399 then
		self.vb.spartCount = self.vb.spartCount + 1
		warnHyperlightSpark:Show(self.vb.spartCount)
--		timerHyperlightSparkCD:Start()
	elseif spellId == 327887 then
		warnCrystalofPhantasmsActivation:Show()
		--Start first timer
		timerFleetingSpiritsCD:Start(37.6)
		timerDimensionalTearCD:Stop()
		timerDimensionalTearCD:Start(20)--regardless of what was left on timer, it's cancelled and set to 20 seconds
	elseif spellId == 340758 then
		timerFleetingSpiritsCD:Start()
		timerDimensionalTearCD:Stop()
		timerDimensionalTearCD:Start(20)--regardless of what was left on timer, it's cancelled and set to 20-30 seconds, or something. i don't fucking know anymore. This script only runs sometimes so I'm missing part of condition
	elseif spellId == 329770 then
		warnRootofExtinction:Show()
		timerRootofExtinctionCD:Start(4.5)
		timerDimensionalTearCD:Stop()
		timerDimensionalTearCD:Start(30)--regardless of what was left on timer, it's cancelled and set to 30 seconds
		if not self:IsMythic() then
			timerFleetingSpiritsCD:Stop()
		--else
			--Does timer start over/change?
		end
	elseif spellId == 329834 then
		timerRootofExtinctionCD:Start()
		timerDimensionalTearCD:Stop()
		timerDimensionalTearCD:Start(19.1)--regardless of what was left on timer, it's cancelled and set to 19.1 seconds
	elseif spellId == 328880 then
		warnAnnihilationActivation:Show()
		timerEdgeofAnnihilationCD:Start(8.1)
		--timerDimensionalTearCD:Stop()
		--timerDimensionalTearCD:Start(19.1)--regardless of what was left on timer, it's cancelled and set to 19.1 seconds
		if not self:IsMythic() then
			timerRootofExtinctionCD:Stop()
		--else
			--Does timer start over/change?
		end
	elseif spellId == 328789 then
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		specWarnEdgeofAnnihilation:Show(self.vb.annihilationCount)
		specWarnEdgeofAnnihilation:Play("justrun")
		specWarnEdgeofAnnihilation:ScheduleVoice(2, "keepmove")
		--"Edge of Annihilation-328789-npc:169062 = pull:253.0, 36.2, 45.7, 46.8, 46.1", -- [4]
		timerEdgeofAnnihilationCD:Start(self.vb.annihilationCount == 1 and 36.2 or 45.7)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 325361 then
		timerGlyphofDestructionCD:Start()
	elseif spellId == 326271 then
		specWarnStasisTrap:Show()
		specWarnStasisTrap:Play("watchstep")
		timerStasisTrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328448 or spellId == 328468 then
		warnDimensionalTear:CombinedShow(1, args.destName)
		local icon = 328448 and 1 or 2--This is better way to do it, but needs confirmation of combat log using both events first
		if args:IsPlayer() then
			specWarnDimensionalTear:Show(self:IconNumToTexture(icon))
			specWarnDimensionalTear:Play("mm"..icon)
			yellDimensionalTear:Yell(icon, icon, icon)
			yellDimensionalTearFades:Countdown(spellId, nil, icon)
		end
		if self.Options.SetIconOnCypher then
			self:SetIcon(args.destName, icon)
		end
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
--			if self.Options.NPAuraOnFixate then
--				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 12)
--			end
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
		if self.Options.SetIconOnCypher then
			self:SetIcon(args.destName, 0)
		end
--	elseif spellId == 327902 and args:IsPlayer() then
--		if self.Options.NPAuraOnFixate then
--			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
--		end
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
