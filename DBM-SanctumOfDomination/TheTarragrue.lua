local mod	= DBM:NewMod(2435, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175611)
mod:SetEncounterID(2423)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20210706000000)--2021-07-06
--mod:SetMinSyncRevision(20201222000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 346985 347283 347668 347679 350280 347490",
	"SPELL_CAST_SUCCESS 352368 352382 352389 352398 354080",
	"SPELL_AURA_APPLIED 346986 347269 347283 347490 347369 347274 352384 352387 352392",
	"SPELL_AURA_APPLIED_DOSE 352384 352387 352392"
--	"SPELL_AURA_REMOVED2"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, change chains to a "moveTo" warning?
--[[
(ability.id = 346985 or ability.id = 347283 or ability.id = 347668 or ability.id = 350280 or ability.id = 347490 or ability.id = 347679) and type = "begincast"
 or (ability.id = 352368 or ability.id = 352382 or ability.id = 352389 or ability.id = 352398 or ability.id = 354080) and type = "cast"
--]]
local warnChainsofEternity							= mod:NewTargetNoFilterAnnounce(347269, 2)
local warnAnnihilatingSmash							= mod:NewTargetAnnounce(347274, 4)
local warnPedatorsHowl								= mod:NewTargetAnnounce(347283, 2)
local warnForgottenTorments							= mod:NewSoonAnnounce(352368, 2)--When it's soon
local warnUpperReachesMight							= mod:NewSpellAnnounce(352382, 2)--When it's happening
local warnMortregarsEchoes							= mod:NewSpellAnnounce(352389, 2)--When it's happening
local warnSoulforgeHeat								= mod:NewSpellAnnounce(352398, 2)--When it's happening
local warnTheJailersGaze							= mod:NewTargetNoFilterAnnounce(347369, 4)
mod:AddBoolOption("warnRemnant", false, "announce", nil, nil, nil, 352368)--3 options are combined into 1, so they don't need bundling
local warnRemantPhysical							= mod:NewCountAnnounce(352384, 2, nil, nil, false)--Physical
local warnRemantShadow								= mod:NewCountAnnounce(352387, 2, nil, nil, false)--Shadow
local warnRemnantFire								= mod:NewCountAnnounce(352392, 2, nil, nil, false)--Fire

local specWarnOverpower								= mod:NewSpecialWarningDefensive(346985, nil, nil, nil, 1, 2)
local specWarnCrushedArmor							= mod:NewSpecialWarningTaunt(346986, nil, nil, nil, 1, 2)
local specWarnChainsofEternity						= mod:NewSpecialWarningYou(347269, nil, nil, nil, 1, 2)
local yellChainsofEternity							= mod:NewYell(347269)
local yellChainsofEternityFades						= mod:NewShortFadesYell(347269)
local specWarnAnnihilatingSmash						= mod:NewSpecialWarningYou(347274, nil, nil, nil, 1, 2)
local specWarnPredatorsHowl							= mod:NewSpecialWarningMoveAway(347283, nil, nil, nil, 1, 2)
local yellPredatorsHowl								= mod:NewYell(347283, nil, false)--Lots of targets, so opt in?
local specWarnHungeringMist							= mod:NewSpecialWarningDodge(347679, nil, nil, nil, 2, 2)
--local specWarnGraspofDeath						= mod:NewSpecialWarningInterrupt(347668, "HasInterrupt", nil, nil, 1, 2)
local specWarnFuryoftheAges							= mod:NewSpecialWarningDispel(347490, "RemoveEnrage", nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

local timerOverpowerCD								= mod:NewCDCountTimer(27.1, 346985, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerChainsofEternityCD						= mod:NewCDCountTimer(27.1, 347269, nil, nil, nil, 3, nil, nil, nil, 1, 3)
local timerPedatorsHowlCD							= mod:NewCDCountTimer(25.5, 347283, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)
local timerHungeringMistCD							= mod:NewNextCountTimer(92.4, 347679, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)
local timerHungeringMist							= mod:NewCastCountTimer(4.8, 347679, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON)
local timerRemnantofForgottenTormentsCD				= mod:NewCDCountTimer(30.4, 352368, L.Remnant, nil, nil, 2, nil, DBM_COMMON_L.HEROIC_ICON)
local timerGraspofDeathCD							= mod:NewCDCountTimer(26.7, 347668, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerFuryoftheAgesCD							= mod:NewCDCountTimer(36.4, 347490, nil, "Tank|RemoveEnrage", nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)

local berserkTimer									= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(6, 347283)
mod:AddSetIconOption("SetIconOnChains", 347269, true, false, {1})
mod:GroupSpells(352368, 352382, 352389, 352398)--Parent torment cast, 3 torment types activating, bool for the 3 remannt type ticks
mod:GroupSpells(346985, 346986)--Tank cast, tank debuff

mod.vb.graspCount = 0
mod.vb.mistCount = 0
mod.vb.mistsubCount = 0
mod.vb.remnantcount = 0
mod.vb.howlcount = 0
mod.vb.chainsCount = 0
mod.vb.overpowerCount = 0
mod.vb.furyCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.graspCount = 0
	self.vb.mistCount = 0
	self.vb.mistsubCount = 0
	self.vb.remnantcount = 0
	self.vb.howlcount = 0
	self.vb.chainsCount = 0
	self.vb.overpowerCount = 0
	self.vb.furyCount = 0
	if self:IsMythic() then--Mythic PTR timers, need checking on live
		timerPedatorsHowlCD:Start(5-delay, 1)
		timerGraspofDeathCD:Start(7-delay, 1)
		timerOverpowerCD:Start(10-delay, 1)
		timerChainsofEternityCD:Start(13.5-delay, 1)
		timerHungeringMistCD:Start(24.2-delay, 1)
	--	berserkTimer:Start(420-delay)
	else--Heroic verified on live, might be same as mythic PTR
		timerPedatorsHowlCD:Start(3.1-delay, 1)
		timerGraspofDeathCD:Start(8.1-delay, 1)
		timerOverpowerCD:Start(10.5-delay, 1)
		timerChainsofEternityCD:Start(13-delay, 1)
		timerHungeringMistCD:Start(24-delay, 1)--24-25
		berserkTimer:Start(420-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 346985 then
		self.vb.overpowerCount = self.vb.overpowerCount + 1
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnOverpower:Show()
			specWarnOverpower:Play("defensive")
		end
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= 27.9 then
			timerOverpowerCD:Start(nil, self.vb.overpowerCount+1)--27.9
		end
	elseif spellId == 347283 then
		self.vb.howlcount = self.vb.howlcount + 1
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= 25.5 then
			timerPedatorsHowlCD:Start(nil, self.vb.howlcount+1)--25.5
		end
	elseif spellId == 347668 then
		self.vb.graspCount = self.vb.graspCount + 1
		--Second cast of fight is fluke, two very fast then rest of fight about 28 sec between casts except ones delayed by mist
		local timer = self.vb.graspCount == 1 and 13.7 or 27
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= timer then
			timerGraspofDeathCD:Start(timer, self.vb.graspCount+1)--27.8
		end
--		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
--			specWarnGraspofDeath:Show(args.sourceName)
--			specWarnGraspofDeath:Play("kickcast")
--		end
	elseif spellId == 350280 then
		self.vb.chainsCount = self.vb.chainsCount + 1
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= 27.9 then
			timerChainsofEternityCD:Start(nil, self.vb.chainsCount+1)--27.9--29.2
		end
	elseif spellId == 347490 then
		self.vb.furyCount = self.vb.furyCount + 1
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= 46.2 then
			timerFuryoftheAgesCD:Start(nil, self.vb.furyCount+1)--46.2
		end
	elseif spellId == 347679 and self:AntiSpam(3, 1) then
		self.vb.mistCount = self.vb.mistCount + 1
		self.vb.mistsubCount = 0
		specWarnHungeringMist:Show()
		specWarnHungeringMist:Play("watchstep")
		--Start timers for after
		timerPedatorsHowlCD:Start(21.1, self.vb.howlcount+1)
		timerOverpowerCD:Start(24.3, self.vb.overpowerCount+1)
		timerGraspofDeathCD:Start(24.3, self.vb.graspCount+1)
		if self:IsHard() then
			timerRemnantofForgottenTormentsCD:Start(28.3, self.vb.remnantcount+1)--Activation, not pre warning for emote
		end
		timerChainsofEternityCD:Start(27.9, self.vb.chainsCount+1)
		timerFuryoftheAgesCD:Start(29.2, self.vb.furyCount+1)
		timerHungeringMistCD:Start(92.4, self.vb.mistCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 352368 then--Remnant of Forgotten Torments
		warnForgottenTorments:Show()
	elseif args:IsSpellID(352382, 352389, 352398) then--Upper Reaches' Might/Mort'regar's Echoes/Soulforge Heat
		self.vb.remnantcount = self.vb.remnantcount + 1
		if timerHungeringMistCD:GetRemaining(self.vb.mistCount+1) >= 30.4 then
			timerRemnantofForgottenTormentsCD:Start(nil, self.vb.remnantcount+1)--30.3 Timer syncs to when they actually happen
		end
		if spellId == 352382 then
			warnUpperReachesMight:Show(self.vb.remnantcount)
		elseif spellId == 352389 then
			warnMortregarsEchoes:Show(self.vb.remnantcount)
		elseif spellId == 352398 then
			warnSoulforgeHeat:Show(self.vb.remnantcount)
		end
	elseif spellId == 354080 then
		self.vb.mistsubCount = self.vb.mistsubCount + 1
		timerHungeringMist:Start(4.9, self.vb.mistsubCount)
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
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 347283 then
		warnPedatorsHowl:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnPredatorsHowl:Show()
			specWarnPredatorsHowl:Play("range5")
			yellPredatorsHowl:Yell()
		end
	elseif spellId == 347490 and args:IsDestTypeHostile() then
		specWarnFuryoftheAges:Show(args.destName)
		specWarnFuryoftheAges:Play("enrage")
	elseif spellId == 347369 then
		self:SetStage(2)
		warnTheJailersGaze:Show(args.destName)
		timerPedatorsHowlCD:Stop()
		timerOverpowerCD:Stop()
		timerGraspofDeathCD:Stop()
		timerRemnantofForgottenTormentsCD:Stop()--Activation, not pre warning for emote
		timerFuryoftheAgesCD:Stop()
		timerChainsofEternityCD:Stop()
		timerHungeringMistCD:Stop()
	elseif spellId == 347274 then
		if args:IsPlayer() then
			specWarnAnnihilatingSmash:Show()
			specWarnAnnihilatingSmash:Play("targetyou")
		else
			warnAnnihilatingSmash:Show(args.destName)
		end
	elseif spellId == 352384 or spellId == 352387 or spellId == 352392 then--Physical, Shadow, Fire
		if args:IsPlayer() and self.Options.warnRemnant then
			local amount = args.amount or 1
			if spellId == 352384 then
				warnRemantPhysical:Show(amount)
			elseif spellId == 352387 then
				warnRemantShadow:Show(amount)
			elseif spellId == 352392 then
				warnRemnantFire:Show(amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 347269 then
		if args:IsPlayer() then
			yellChainsofEternityFades:Cancel()
		end
		if self.Options.SetIconOnChains then
			self:SetIcon(args.destName, 0)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 352368 then--Remnant of Forgotten Torments

	end
end
--]]
