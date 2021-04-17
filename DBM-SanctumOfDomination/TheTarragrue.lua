local mod	= DBM:NewMod(2435, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(164406)
mod:SetEncounterID(2423)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 346985 347283 347668",
	"SPELL_CAST_SUCCESS 347269 347671",
	"SPELL_AURA_APPLIED 346986 347269 347283 347490 347369",
--	"SPELL_AURA_APPLIED_DOSE",
--	"SPELL_AURA_REMOVED",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, change chains to a "moveTo" warning?
--TODO, chains of eternity need icon marking? is it multiple targets? if so, icon fades too
--TODO, figure out how remnants work, fixed order? random on a shared CD? maybe works same as Varimathras
local warnChainsofEternity							= mod:NewTargetNoFilterAnnounce(347269, 2)
local warnPedatorsHowl								= mod:NewTargetAnnounce(347283, 2)
local warnForgottenTorments							= mod:NewSpellAnnounce(352368, 2)
local warnUpperReachesMight							= mod:NewSpellAnnounce(352382, 2)
local warnMortregarsEchoes							= mod:NewSpellAnnounce(352389, 2)
local warnSoulforgeHeat								= mod:NewSpellAnnounce(352398, 2)
local warnTheJailersGaze							= mod:NewTargetNoFilterAnnounce(347369, 4)

local specWarnOverpower								= mod:NewSpecialWarningDefensive(346985, nil, nil, nil, 1, 2)
local specWarnCrushedArmor							= mod:NewSpecialWarningTaunt(346986, nil, nil, nil, 1, 2)
local specWarnChainsofEternity						= mod:NewSpecialWarningYou(347269, nil, nil, nil, 1, 2)
local yellChainsofEternity							= mod:NewYell(347269)
local yellChainsofEternityFades						= mod:NewShortFadesYell(347269)
local specWarnPredatorsHowl							= mod:NewSpecialWarningMoveAway(347283, nil, nil, nil, 1, 2)
local yellPredatorsHowl								= mod:NewYell(347283, nil, false)--Lots of targets, so opt in?
local specWarnHungeringMist							= mod:NewSpecialWarningDodge(347671, nil, nil, nil, 2, 2)
local specWarnGraspofDeath							= mod:NewSpecialWarningInterrupt(347668, "HasInterrupt", nil, nil, 1, 2)
local specWarnFuryoftheAges							= mod:NewSpecialWarningDispel(347490, "RemoveEnrage", nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerOverpowerCD								= mod:NewAITimer(17.8, 346985, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerChainsofEternityCD						= mod:NewAITimer(23, 347269, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerPedatorsHowlCD							= mod:NewAITimer(17.8, 347283, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)
local timerHungeringMistCD							= mod:NewAITimer(23, 347671, nil, nil, nil, 1)
--local timerRemnantofForgottenTormentsCD			= mod:NewAITimer(23, 347671, nil, nil, nil, 6, nil, DBM_CORE_L.HEROIC_ICON)
local timerGraspofDeathCD							= mod:NewAITimer(23, 347668, nil, nil, nil, 4, nil, DBM_CORE_L.INTERRUPT_ICON)

local berserkTimer									= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 347283)
--mod:AddInfoFrameOption(328897, true)
--mod:AddSetIconOption("SetIconOnEcholocation", 342077, true, false, {1, 2, 3})

function mod:OnCombatStart(delay)
	timerOverpowerCD:Start(1-delay)
	timerChainsofEternityCD:Start(1-delay)
	timerPedatorsHowlCD:Start(1-delay)
	timerHungeringMistCD:Start(1-delay)
	timerGraspofDeathCD:Start(1-delay)
	berserkTimer:Start(420-delay)
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
--		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
--	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 346985 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnOverpower:Show()
			specWarnOverpower:Play("defensive")
		end
		timerOverpowerCD:Start()
	elseif spellId == 347283 then
		timerPedatorsHowlCD:Start()
	elseif spellId == 347668 then
		timerGraspofDeathCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnGraspofDeath:Show(args.sourceName)
			specWarnGraspofDeath:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 347269 then
		timerChainsofEternityCD:Start()
	elseif spellId == 347671 and self:AntiSpam(3, 1) then
		specWarnHungeringMist:Show()
		specWarnHungeringMist:Play("watchstep")
		timerHungeringMistCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 346986 then
		if not args:IsPlayer() then
			specWarnCrushedArmor:Show(args.destName)
			specWarnCrushedArmor:Play("tauntboss")
		end
	elseif spellId == 347269 then
		if args:IsPlayer() then
			specWarnChainsofEternity:Show()
			specWarnChainsofEternity:Play("targetyou")
			yellChainsofEternity:Yell()
			yellChainsofEternityFades:Countdown(spellId)
		else
			warnChainsofEternity:Show(args.destName)
		end
	elseif spellId == 347283 then
		warnPedatorsHowl:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPredatorsHowl:Show()
			specWarnPredatorsHowl:Play("range5")
			yellPredatorsHowl:Yell()
		end
	elseif spellId == 347490 then
		specWarnFuryoftheAges:Show(args.destName)
		specWarnFuryoftheAges:Play("enrage")
	elseif spellId == 347369 then
		warnTheJailersGaze:Show(args.destName)
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 347269 then
		if args:IsPlayer() then
			yellChainsofEternityFades:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 352368 then--Remnant of Forgotten Torments
		warnForgottenTorments:Show()
	elseif spellId == 352382 then--Upper Reaches' Might
		warnUpperReachesMight:Show()
	elseif spellId == 352389 then--Mort'regar's Echoes
		warnMortregarsEchoes:Show()
	elseif spellId == 352398 then
		warnSoulforgeHeat:Show()
	end
end

