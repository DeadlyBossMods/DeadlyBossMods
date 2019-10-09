local mod	= DBM:NewMod(2367, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157231)
mod:SetEncounterID(2335)
mod:SetZone()
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 312528 306928 312529 306929 312530 306930",
	"SPELL_CAST_SUCCESS 307471 307472 306953 306692",
	"SPELL_AURA_APPLIED 312328 312329 307471 307472 307358 306942 296524",
	"SPELL_AURA_APPLIED_DOSE 312328 307358",
	"SPELL_AURA_REMOVED 312328 307358 296524",
	"SPELL_AURA_REMOVED_DOSE 312328 307358",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"SPELL_INTERRUPT",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, set slurry icon based on what one is next, if it's a fixed order
--TODO, move more to CLEU if it's in there, but blizzards history is anything but CLEU so this mod is drycoded assuming worst of blizzard
--TODO, eliminate dissolve timer if it's not needed. blizzard journal might be loose in interpretting when "right after" is
--TODO, assumed the sub breath IDs in combat log not 306736, but if 306736 is in there use that instead of 6 spellIds
--TODO, more data on Debilitating spit to know what to do, icons, target warnings etc, right now it's unsafe to drycode and could result in spam
--TODO, add warnings for living chow, find their fixate ID, add personal fixate run away warning and nameplate auras
local warnHunger							= mod:NewStackAnnounce(312328, 2)--Mythic
local warnVolatileSlurry					= mod:NewCountAnnounce(306447, 2)
local warnBubblingSlurry					= mod:NewCountAnnounce(306931, 2)
local warnEntropicSlurry					= mod:NewCountAnnounce(306933, 2)
local warnCrush								= mod:NewTargetNoFilterAnnounce(307471, 3, nil, "Tank|Healer")
local warnDissolve							= mod:NewTargetNoFilterAnnounce(307472, 3, nil, "Tank|Healer")
local warnDebilitatingSpit					= mod:NewTargetNoFilterAnnounce(307358, 3, nil, false)
local warnFrenzy							= mod:NewTargetNoFilterAnnounce(306942, 2)
local warnFixate							= mod:NewTargetAnnounce(296524, 2)

local specWarnUncontrollablyRavenous		= mod:NewSpecialWarningSpell(312329, nil, nil, nil, 3, 2)--Mythic
local specWarnCrushTaunt					= mod:NewSpecialWarningTaunt(307471, nil, nil, nil, 3, 2)
local specWarnDissolveTaunt					= mod:NewSpecialWarningTaunt(307472, nil, nil, nil, 1, 2)
local specWarnSlurryBreath					= mod:NewSpecialWarningDodge(306736, nil, nil, nil, 2, 2)
local specWarnDebilitatingSpit				= mod:NewSpecialWarningYou(307358, nil, nil, nil, 1, 2)
--local specWarnDesensitizingSting			= mod:NewSpecialWarningStack(298156, nil, 9, nil, nil, 1, 6)
local specWarnFixate						= mod:NewSpecialWarningRun(296524, nil, nil, nil, 4, 2)
local yellFixate							= mod:NewYell(296524, nil, false)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(270290, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerSlurryCD							= mod:NewAITimer(30.1, "ej20617", nil, nil, nil, 6, 306932)--Bubbling slurry icon used for now
local timerCrushCD							= mod:NewAITimer(5.3, 307471, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerDissolveCD						= mod:NewAITimer(5.3, 307472, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSlurryBreathCD					= mod:NewAITimer(84, 306736, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerDebilitatingSpitCD				= mod:NewAITimer(5.3, 306953, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerLivingChowCD						= mod:NewAITimer(5.3, 306692, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307358, true)
--mod:AddSetIconOption("SetIconOnEyeBeam", 264382, true, false, {1, 2})
mod:AddNamePlateOption("NPAuraOnFixate", 296524)

mod.vb.slurryCount = 0
local SpitStacks = {}

function mod:OnCombatStart(delay)
	self.vb.slurryCount = 0
	table.wipe(SpitStacks)
	--timerSlurryCD:Start(1-delay)--Probably used on pull
	timerCrushCD:Start(1-delay)
	timerDissolveCD:Start(1-delay)
	timerSlurryBreathCD:Start(1-delay)
	timerDebilitatingSpitCD:Start(1-delay)--SUCCESS
	timerLivingChowCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307358))
		DBM.InfoFrame:Show(10, "table", SpitStacks, 1)
	end
	if self.Options.NPAuraOnFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 312528 or spellId == 3306928 or spellId == 3312529 or spellId == 3306929 or spellId == 3312530 or spellId == 3306930 then
		specWarnSlurryBreath:Show()
		specWarnSlurryBreath:Play("breathsoon")
		timerSlurryBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307471 then
		timerCrushCD:Start()
	elseif spellId == 307472 then
		timerDissolveCD:Start()
	elseif spellId == 306953 then
		timerDebilitatingSpitCD:Start()
	elseif spellId == 306692 then
		timerLivingChowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 312328 then
		warnHunger:Show(args.amount or 1)
	elseif spellId == 312329 then
		specWarnUncontrollablyRavenous:Show()
		specWarnUncontrollablyRavenous:Play("stilldanger")
	elseif spellId == 307471 then
		if args:IsPlayer() then
			warnCrush:Show(args.destName)
		--Not dead, and the nearby tank in a 3 tank setup (or any tank in 2 tank setup)
		elseif self:IsTank() and (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not UnitIsDeadOrGhost("player") then
			specWarnCrushTaunt:Show(args.destName)
			specWarnCrushTaunt:Play("tauntboss")
		else
			warnCrush:Show(args.destName)
		end
	elseif spellId == 307472 then
		if args:IsPlayer() then
			warnDissolve:Show(args.destName)
		--Not dead, and the nearby tank in a 3 tank setup (or any tank in 2 tank setup)
		elseif self:IsTank() and (self:CheckNearby(8, args.destName) or self:GetNumAliveTanks() < 3) and not UnitIsDeadOrGhost("player") then
			specWarnDissolveTaunt:Show(args.destName)
			specWarnDissolveTaunt:Play("tauntboss")
		else
			warnDissolve:Show(args.destName)
		end
	elseif spellId == 307358 then
		local amount = args.amount or 1
		SpitStacks[args.destName] = amount
		if amount == 1 then
			warnDebilitatingSpit:CombinedShow(0.5, args.destName)
			if args:IsPlayer() then
				specWarnDebilitatingSpit:Show()
				specWarnDebilitatingSpit:Play("targetyou")
			end
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SpitStacks)
		end
	elseif spellId == 306942 then
		warnFrenzy:Show(args.destName)
	elseif spellId == 296524 then
		warnFixate:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("justrun")
				yellFixate:Yell()
			end
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 312328 then
		warnHunger:Show(args.amount or 0)
	elseif spellId == 307358 then
		SpitStacks[args.destName] = args.amount or nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(SpitStacks)
		end
	elseif spellId == 296524 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 298548 then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 152311 then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 309725 or spellId == 309730 or spellId == 309724 or spellId == 308652) and self:AntiSpam(5, 1) then--All the slurry Visuals
		self.vb.slurryCount = self.vb.slurryCount + 1
		timerSlurryCD:Start()
		if spellId == 309725 then--Bubbling Slurry Visual
			warnBubblingSlurry:Show(self.vb.slurryCount)
		elseif spellId == 309730 then--Entropic Slurry Visual
			warnEntropicSlurry:Show(self.vb.slurryCount)
		else--309724 or 308652 (Volatile Slurry Visual)
			warnVolatileSlurry:Show(self.vb.slurryCount)
		end
	end
end
