local mod	= DBM:NewMod(2373, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157602)
mod:SetEncounterID(2343)
mod:SetZone()
mod:SetHotfixNoticeRev(20200112000000)--2020, 1, 12
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 308941 310246 310329 310396",
	"SPELL_CAST_SUCCESS 310277 310478 315712",
	"SPELL_AURA_APPLIED 310277 310358 310361 310552 310563 312595",
	"SPELL_AURA_APPLIED_DOSE 310563",
	"SPELL_AURA_REMOVED 310277 310358 312595",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_POWER_UPDATE boss1"
)

--TODO, track add count, show on infoframe, as well as only show Unleashed Insanity cast timer if add count was > 0
--TODO, personal https://ptr.wowhead.com/spell=308377/void-infused-ichor tracker when infoframe code added
--TODO, target scan acid splash?
--TODO, Add spawn timers
--TODO, all adds of same name still have same GUID, so nameplate auras and icons still not reliable. If this ever changes, nameplate aura will work.
--[[
(ability.id = 308941 or ability.id = 310246 or ability.id = 310329 or ability.id = 310396) and type = "begincast"
 or (ability.id = 310277 or ability.id = 310478) and type = "cast"
 or ability.id = 310358 and type = "applydebuff"
--]]
--Drest'agath
local warnVoidGrip							= mod:NewSpellAnnounce(310246, 2, nil, "Tank")--If Tank isn't in range of boss
local warnVolatileSeed						= mod:NewTargetNoFilterAnnounce(310277, 2)
local warnUnleashedInsanity					= mod:NewTargetAnnounce(310361, 4)--People stunned by muttering of Insanity
local warnThrowsSoon						= mod:NewSoonAnnounce(308941, 4)
--Tentacle of Drest'agath
local warnObscuringCloud					= mod:NewSpellAnnounce(310478, 2)
local warnThroesofDismemberment				= mod:NewTargetNoFilterAnnounce(315712, 4)

--Drest'agath
local specWarnThrowsofAgony					= mod:NewSpecialWarningDodgeCount(308941, nil, nil, nil, 2, 2)--Acts as warning for All abilities triggered at 100 Energy
local specWarnVolatileSeed					= mod:NewSpecialWarningYou(310277, nil, nil, nil, 1, 2)
local yellolatileSeed						= mod:NewYell(310277)
local yellolatileSeedFades					= mod:NewFadesYell(310277)
local specWarnEntropicCrash					= mod:NewSpecialWarningDodge(310329, nil, nil, nil, 2, 2)
local specWarnMutteringsofInsanity			= mod:NewSpecialWarningTarget(310358, nil, nil, nil, 1, 2)
local yellMutteringsofInsanity				= mod:NewShortFadesYell(310358)
local specWarnVoidGlare						= mod:NewSpecialWarningDodge(310406, nil, nil, nil, 3, 2)
--Eye of Drest'agath
local specWarnErrantBlast					= mod:NewSpecialWarningDodge(308953, false, nil, 2, 2, 2, 4)--For mythic
local specWarnMindFlay						= mod:NewSpecialWarningInterrupt(310552, "HasInterrupt", nil, nil, 1, 2)
--Tentacle of Drest'agath
local specWarnTentacleSlam					= mod:NewSpecialWarningDodge(308995, false, nil, 2, 2, 2, 4)--For mythic
--Maw of Dresta'gath
local specWarnSpineEruption					= mod:NewSpecialWarningDodge(310078, false, nil, 2, 2, 2, 4)--For mythic
local specWarnMutteringsofBetrayal			= mod:NewSpecialWarningStack(310563, nil, 3, nil, nil, 1, 6)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
--Drest'agath
local timerVolatileSeedCD					= mod:NewCDTimer(16.6, 310277, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 3)--16.6-26.8 (boss has some channeled abilities, spell queuing)
local timerEntropicCrashCD					= mod:NewCDTimer(44.3, 310329, nil, nil, nil, 2)
local timerMutteringsofInsanityCD			= mod:NewCDTimer(50.2, 310358, nil, nil, nil, 3)--45-60, it's almost always 50.3+ but have to use the 46
local timerUnleashedInsanity				= mod:NewCastTimer(5, 310361, nil, nil, nil, 3)
local timerVoidGlareCD						= mod:NewCDTimer(45, 310406, nil, nil, nil, 3)

local berserkTimer							= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("18/4")--Sadly, choices are 13 or 18, 13 too small so have to round 15 up to 18
mod:AddInfoFrameOption(308377, false)
mod:AddSetIconOption("SetIconOnVolatileSeed", 310277, true, false, {1})
mod:AddNamePlateOption("NPAuraOnVolatileCorruption", 312595)

mod.vb.agonyCount = 0
local warnedSoon = false

function mod:OnCombatStart(delay)
	self.vb.agonyCount = 0
	warnedSoon = false
	timerVolatileSeedCD:Start(7.2-delay)
	timerEntropicCrashCD:Start(15.5-delay)
	timerMutteringsofInsanityCD:Start(30.1-delay)
	timerVoidGlareCD:Start(45.2-delay)--45.2-53.2
	if self.Options.NPAuraOnVolatileCorruption then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(4)--For Acid Splash
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(308377))
		DBM.InfoFrame:Show(10, "playerdebuffremaining", 308377)
	end
	berserkTimer:Start(self:IsMythic() and 600 or 900-delay)--Confirmed normal and heroic
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.NPAuraOnVolatileCorruption then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 308941 then
		self.vb.agonyCount = self.vb.agonyCount + 1
		specWarnThrowsofAgony:Show(self.vb.agonyCount)
		specWarnThrowsofAgony:Play("specialsoon")
	elseif spellId == 310246 then
		warnVoidGrip:Show()
	elseif spellId == 310329  then--Antispam, in case all tentacles echo it, or cast it at once
		specWarnEntropicCrash:Show()
		specWarnEntropicCrash:Play("watchstep")
		timerEntropicCrashCD:Start()
	elseif spellId == 310396 and self:AntiSpam(10, 1) then
		specWarnVoidGlare:Show()
		specWarnVoidGlare:Play("farfromline")
		timerVoidGlareCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 310277 then
		timerVolatileSeedCD:Start()
	elseif spellId == 310478 and self:AntiSpam(5, 5) then
		warnObscuringCloud:Show()
	elseif spellId == 315712 then
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if self:AntiSpam(3, cid) then
			if cid == 157612 then--eye-of-drestagath
				--only time this isn't synced up to Throws of Agony
				if self.Options.SpecWarn308953dodge then
					specWarnErrantBlast:Show()
					specWarnErrantBlast:Play("watchstep")
				else
					warnThroesofDismemberment:Show(args.sourceName)
				end
			elseif cid == 157614 then--tentacle-of-drestagath
				--only time this isn't synced up to Throws of Agony
				if self.Options.SpecWarn308995dodge then
					specWarnTentacleSlam:Show()
					specWarnTentacleSlam:Play("watchstep")
				else
					warnThroesofDismemberment:Show(args.sourceName)
				end
			elseif cid == 157613 then--maw-of-drestagath
				--only time this isn't synced up to Throws of Agony
				if self.Options.SpecWarn310078dodge then
					specWarnSpineEruption:Show()
					specWarnSpineEruption:Play("watchorb")
				else
					warnThroesofDismemberment:Show(args.sourceName)
				end
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 310277 then
		if args:IsPlayer() then
			specWarnVolatileSeed:Show()
			specWarnVolatileSeed:Play("targetyou")
			yellolatileSeed:Yell()
			yellolatileSeedFades:Countdown(spellId)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(18)
			end
		else
			warnVolatileSeed:Show(args.destName)
		end
		if self.Options.SetIconOnVolatileSeed then
			self:SetIcon(args.destName, 1)
		end
	elseif spellId == 312595 then
		if self.Options.NPAuraOnVolatileCorruption then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 15)
		end
	elseif spellId == 310358 then
		specWarnMutteringsofInsanity:CombinedShow(0.3, args.destName)
		specWarnMutteringsofInsanity:ScheduleVoice(0.3, "runaway")
		if args:IsPlayer() then
			yellMutteringsofInsanity:Countdown(spellId)
			timerUnleashedInsanity:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(18)
			end
		end
	elseif spellId == 310361 then
		warnUnleashedInsanity:CombinedShow(0.3, args.destName)
	--All mobs with same name now have same GUID, this basically makes CheckInterruptFilter half useless, thus the AntiSpam need.
	elseif spellId == 310552 and self:CheckInterruptFilter(args.sourceGUID, false, true) and self:AntiSpam(3, 6) then
		specWarnMindFlay:Show(args.sourceName)
		specWarnMindFlay:Play("kickcast")
	elseif spellId == 310563 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			if (amount >= 3) and (amount < 5) then--Have to do this way because initial application doesn't report stacks, it reports absorb amount (obnoxious high number)
				specWarnMutteringsofBetrayal:Show(amount)
				specWarnMutteringsofBetrayal:Play("stackhigh")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 310277 then
		if args:IsPlayer() then
			yellolatileSeedFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(4)
			end
		end
		if self.Options.SetIconOnVolatileSeed then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 312595 then
		if self.Options.NPAuraOnVolatileCorruption then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 310358 then
		if args:IsPlayer() then
			yellMutteringsofInsanity:Cancel()
			timerUnleashedInsanity:Stop()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(4)
			end
		end
	end
end

--This code probably doesn't work, do to GUID obfuscation on fight, because fight is stupid
--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 157612 then--eye-of-drestagath
		--only time this isn't synced up to Throws of Agony
		if self:IsMythic() and self:AntiSpam(5, 2) then
			specWarnErrantBlast:Show()
			specWarnErrantBlast:Play("watchstep")
		end
	elseif cid == 157614 then--tentacle-of-drestagath
		--only time this isn't synced up to Throws of Agony
		if self:IsMythic() and self:AntiSpam(5, 3) then
			specWarnTentacleSlam:Show()
			specWarnTentacleSlam:Play("watchstep")
		end
	elseif cid == 157613 then--maw-of-drestagath
		--only time this isn't synced up to Throws of Agony
		if self:IsMythic() and self:AntiSpam(5, 4) then
			specWarnSpineEruption:Show()
			specWarnSpineEruption:Play("watchorb")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--Has success event, but only if a maw-of-drestagath is up, this script runs regardless
	if spellId == 310351 then--Mutterings of Insanity
		timerMutteringsofInsanityCD:Start(50.2)
	end
end

do
	local lastPower = 0
	function mod:UNIT_POWER_UPDATE(uId)
		local bossPower = UnitPower("boss1") --Get Boss Power
		if (lastPower > bossPower) and bossPower < 85 then
			warnedSoon = false
		elseif not warnedSoon and bossPower >= 85 then--One 15 energy tentacle away, or 2 10 energy ones
			warnedSoon = true
			warnThrowsSoon:Show()
		end
		lastPower = bossPower
	end
end
