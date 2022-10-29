local mod	= DBM:NewMod(2393, "DBM-CastleNathria", nil, 1190)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(164406)
mod:SetEncounterID(2398)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20201222000000)--2020, 12, 22
mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 328857 345936 330711 343005 342863 345397",
	"SPELL_CAST_SUCCESS 328857 329362",
	"SPELL_AURA_APPLIED 328897 342077 341684 328921 343024",
	"SPELL_AURA_APPLIED_DOSE 328897",
	"SPELL_AURA_REMOVED 328921 342077 328897",
	"SPELL_AURA_REMOVED_DOSE 328897",
	"SPELL_PERIODIC_DAMAGE 340324",
	"SPELL_PERIODIC_MISSED 340324",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, need fresh transcriptor log to verify icon resetting/timer event for Scent for Blood
--TODO, icons or auras for 341684?
--TODO, add mor counts to abilities/timers
--[[
(ability.id = 328857 or ability.id = 345936 or ability.id = 330711 or ability.id = 342863 or ability.id = 343005 or ability.id = 345397) and type = "begincast"
 or (ability.id = 342074) and type = "cast"
 or ability.id = 328921
 or ability.id = 342077 and type = "applydebuff"
--]]
--Stage One - Thirst for Blood
local warnExsanguinated							= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnEcholocation							= mod:NewTargetAnnounce(342074, 3)
local warnWaveofBlood							= mod:NewCountAnnounce(345397, 3)
--Stage Two - Terror of Castle Nathria
local warnDeadlyDescent							= mod:NewTargetNoFilterAnnounce(343024, 4)
local warnBloodshroudOver						= mod:NewEndAnnounce(328921, 1)
local warnEarsplittingShriek					= mod:NewCastAnnounce(345936, 2)
local warnEchoingSonar							= mod:NewCastAnnounce(329362, 2, 6)
local warnBloodLantern							= mod:NewTargetNoFilterAnnounce(341684, 1)--Mythic


--Stage One - Thirst for Blood
local specWarnExsanguinated						= mod:NewSpecialWarningStack(328897, nil, 2, nil, nil, 1, 6)
local specWarnExsanguinatingBite				= mod:NewSpecialWarningDefensive(328857, nil, 17253, nil, 1, 2)
local specWarnExsanguinatingBiteOther			= mod:NewSpecialWarningTaunt(328857, nil, 17253, nil, 1, 2)
local specWarnEcholocation						= mod:NewSpecialWarningMoveAway(342074, nil, nil, nil, 1, 2)
local yellEcholocation							= mod:NewPosYell(342074)
local yellEcholocationFades						= mod:NewIconFadesYell(342074)
local specWarnEarsplittingShriek				= mod:NewSpecialWarningMoveTo(330711, nil, 251719, nil, 1, 2)
local specWarnBlindSwipe						= mod:NewSpecialWarningDefensive(343005, "Tank", nil, nil, 1, 2)
local specWarnEchoingScreech					= mod:NewSpecialWarningDodge(342863, nil, 252538, nil, 2, 2)
--Stage Two - Terror of Castle Nathria
local specWarnBloodshroud						= mod:NewSpecialWarningSpell(328921, nil, nil, nil, 2, 2)
local specWarnDeadlyDescent						= mod:NewSpecialWarningYou(343021, nil, nil, nil, 1, 2)--1 because you can't do anything about it
local yellDeadlyDescent							= mod:NewYell(343021, nil, false)--Useless with only 1 second to avoid
local specWarnGTFO								= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--Stage One - Thirst for Blood
local timerExsanguinatingBiteCD					= mod:NewCDTimer(17.8, 328857, 17253, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--10-22.9 (too varaible for a countdown by default)
local timerEcholocationCD						= mod:NewCDTimer(23, 342074, nil, nil, nil, 3, nil, nil, nil, 1, 3)--Seems to be 42.7 without a hitch
local timerEarsplittingShriekCD					= mod:NewCDTimer(47.1, 330711, 251719, nil, nil, 2)--Shortname "Shriek"
local timerEarsplittingShriek					= mod:NewCastTimer(4, 345936, 251719, false, nil, 5)--For users to see cast bar if boss remains untargetable in intermission
local timerWaveofBloodCD						= mod:NewCDCountTimer(24.8, 345397, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--24-30
local timerBlindSwipeCD							= mod:NewCDTimer(44.4, 343005, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEchoingScreechCD						= mod:NewCDTimer(48, 342863, 252538, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerBloodshroudCD						= mod:NewCDTimer(112, 328921, nil, nil, nil, 6)--100-103
--Stage Two - Terror of Castle Nathria
--local timerBloodshroud						= mod:NewBuffActiveTimer(47.5, 328921, nil, nil, nil, 6)--43.4-47.5, more to it than this? or just fact blizzards energy code always proves to be dogshit
local timerEchoingSonar							= mod:NewCastTimer(6, 329362, nil, false, nil, 5)
--local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(328897, true)
mod:AddSetIconOption("SetIconOnEcholocation", 342074, true, false, {1, 2, 3})

mod:GroupSpells(328857, 328897)

local ExsanguinatedStacks = {}
local playerDebuff = false
mod.vb.EchoIcon = 1
mod.vb.waveCount = 0

function mod:OnCombatStart(delay)
	table.wipe(ExsanguinatedStacks)
	playerDebuff = false
	self:SetStage(1)
	self.vb.EchoIcon = 1
	self.vb.waveCount = 0
	timerExsanguinatingBiteCD:Start(8.1-delay)
	timerWaveofBloodCD:Start(12-delay, 1)
	timerEcholocationCD:Start(14.2-delay)
	timerBlindSwipeCD:Start(20.3-delay)
	if not self:IsEasy() then
		timerEchoingScreechCD:Start(28-delay)
	end
	timerEarsplittingShriekCD:Start(48.3-delay)
	timerBloodshroudCD:Start(112-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(328897))
		DBM.InfoFrame:Show(10, "table", ExsanguinatedStacks, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 328857 then
		if self:IsTanking("player", "boss1", nil, true) and self:AntiSpam(3, 1) then
			specWarnExsanguinatingBite:Show()
			specWarnExsanguinatingBite:Play("defensive")
		end
		timerExsanguinatingBiteCD:Start()
	elseif spellId == 330711 or spellId == 345936  then--Phase 1/Phase 2
		if self.Options.SpecWarn330711moveto then
			specWarnEarsplittingShriek:Show(DBM_COMMON_L.BREAK_LOS)
			specWarnEarsplittingShriek:Play("findshelter")
		else
			warnEarsplittingShriek:Show()
		end
		timerEarsplittingShriekCD:Start(spellId == 330711 and 47.4 or 8.5)
		timerEarsplittingShriek:Start(spellId == 330711 and 6 or 4)
	elseif spellId == 343005 then
		specWarnBlindSwipe:Show()
		specWarnBlindSwipe:Play("shockwave")
		timerBlindSwipeCD:Start()
	elseif spellId == 342863 then
		specWarnEchoingScreech:Show()
		specWarnEchoingScreech:Play("watchstep")--Maybe shockwave?
		timerEchoingScreechCD:Start()
	elseif spellId == 345397 then
		self.vb.waveCount = self.vb.waveCount + 1
		warnWaveofBlood:Show(self.vb.waveCount)
		timerWaveofBloodCD:Start(24.8, self.vb.waveCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 328857 then
		if not args:IsPlayer() then
			specWarnExsanguinatingBiteOther:Show(args.destName)
			specWarnExsanguinatingBiteOther:Play("tauntboss")
		end
	elseif spellId == 329362 then
		warnEchoingSonar:Show()
		timerEchoingSonar:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 328897 then
		local amount = args.amount or 1
		ExsanguinatedStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
		if args:IsPlayer() then
			playerDebuff = true
			if (amount % 3 == 0) and self:AntiSpam(3, 1) then
				--Shared antispam with tank defensive warning, just to avoid tank feeling spammed, especially since this could also trigger twice in a single bite
				specWarnExsanguinated:Show(amount)
				specWarnExsanguinated:Play("stackhigh")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then
				warnExsanguinated:Show(args.destName, amount)
			end
		end
	elseif spellId == 343024 then
		if args:IsPlayer() then
			specWarnDeadlyDescent:Show()
			specWarnDeadlyDescent:Play("targetyou")
			yellDeadlyDescent:Yell()
		else
			warnDeadlyDescent:CombinedShow(1, args.destName)
		end
	elseif spellId == 342077 then
		local icon = self.vb.EchoIcon
		if self.Options.SetIconOnEcholocation then
			self:SetIcon(args.destName, self.vb.EchoIcon)
		end
		if args:IsPlayer() then
			specWarnEcholocation:Show()
			specWarnEcholocation:Play("runout")
			yellEcholocation:Yell(icon, icon, icon)
			yellEcholocationFades:Countdown(spellId, nil, icon)
		end
		warnEcholocation:CombinedShow(0.5, args.destName)
		self.vb.EchoIcon = self.vb.EchoIcon + 1
	elseif spellId == 341684 then
		warnBloodLantern:Show(args.destName)
	elseif spellId == 328921 then
		self:SetStage(2)
		if self:IsFated() then
			self:AffixEvent(0)--Stop Affix Bars
		end
		specWarnBloodshroud:Show()
		specWarnBloodshroud:Play("phasechange")
		timerExsanguinatingBiteCD:Stop()
		timerEarsplittingShriekCD:Stop()
		timerEcholocationCD:Stop()
		timerBlindSwipeCD:Stop()
		timerWaveofBloodCD:Stop()
		timerEchoingScreechCD:Stop()
		timerEarsplittingShriekCD:Start(10.9)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 328921 then--Bloodshroud removed
		self.vb.waveCount = 0
		if self:IsFated() then
			--Purposely uses stage 2 table entry
			self:AffixEvent(1, 2)--Restart Affix Bars
		end
		self:SetStage(1)
		timerEarsplittingShriekCD:Stop()
		timerEchoingSonar:Stop()
		timerEarsplittingShriek:Stop()
		warnBloodshroudOver:Show()
		--Looks same as pull timers
		timerExsanguinatingBiteCD:Start(8.1)
		timerWaveofBloodCD:Start(12, 1)
		timerEcholocationCD:Start(14.2)
		timerBlindSwipeCD:Start(20.3)
		if not self:IsEasy() then
			timerEchoingScreechCD:Start(28)
		end
		timerEarsplittingShriekCD:Start(48.3)
		timerBloodshroudCD:Start(112)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 342077 then
		if args:IsPlayer() then
			yellEcholocationFades:Cancel()
		end
		if self.Options.SetIconOnEcholocation then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 328897 then
		ExsanguinatedStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
		if args:IsPlayer() then
			playerDebuff = false
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 328897 then
		ExsanguinatedStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(ExsanguinatedStacks)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then
		self.vb.EchoIcon = 1
		timerEcholocationCD:Start()
	end
end
