local mod	= DBM:NewMod(2367, "DBM-Nyalotha", nil, 1180)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(157231)
mod:SetEncounterID(2335)
mod:SetZone()
mod:SetUsedIcons(4, 3, 2, 1)
--mod:SetHotfixNoticeRev(20190716000000)--2019, 7, 16
--mod:SetMinSyncRevision(20190716000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 312528 306928 312529 306929 312530 306930 307260 306953",
	"SPELL_CAST_SUCCESS 307471",
	"SPELL_AURA_APPLIED 312328 312329 307471 307472 307358 306942 307260 308157 308177 308149",
	"SPELL_AURA_APPLIED_DOSE 312328 307358",
	"SPELL_AURA_REMOVED 312328 307358 308157",
	"SPELL_AURA_REMOVED_DOSE 312328 307358 308177",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_CHANNEL_START boss2 boss3"
)

local warnHunger							= mod:NewStackAnnounce(312328, 2)--Mythic
local warnVolatileSlurry					= mod:NewSpellAnnounce(306447, 2)
local warnBubblingSlurry					= mod:NewSpellAnnounce(306931, 2)
local warnEntropicSlurry					= mod:NewSpellAnnounce(306933, 2)
local warnCrush								= mod:NewTargetNoFilterAnnounce(307471, 3, nil, "Tank|Healer")
local warnDissolve							= mod:NewTargetNoFilterAnnounce(307472, 3, nil, "Tank|Healer")
local warnDebilitatingSpit					= mod:NewTargetNoFilterAnnounce(307358, 3, nil, false)
local warnFrenzy							= mod:NewTargetNoFilterAnnounce(306942, 2)
local warnFixate							= mod:NewTargetAnnounce(307260, 2)
local warnEntropicBuildup					= mod:NewCountAnnounce(308177, 2)

local specWarnUncontrollablyRavenous		= mod:NewSpecialWarningSpell(312329, nil, nil, nil, 3, 2)--Mythic
local specWarnCrushTaunt					= mod:NewSpecialWarningTaunt(307471, nil, nil, nil, 3, 2)
local specWarnDissolveTaunt					= mod:NewSpecialWarningTaunt(307472, nil, nil, nil, 1, 2)
local specWarnSlurryBreath					= mod:NewSpecialWarningDodge(306736, nil, nil, nil, 2, 2)
local specWarnDebilitatingSpit				= mod:NewSpecialWarningYou(307358, nil, nil, nil, 1, 2)
local specWarnFixate						= mod:NewSpecialWarningRun(307260, nil, nil, nil, 4, 2)
local yellFixate							= mod:NewYell(307260, nil, false)
local specWarnVolatileEruption				= mod:NewSpecialWarningDodge(308157, nil, nil, nil, 2, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(308149, nil, nil, nil, 1, 8)

local timerCrushCD							= mod:NewCDTimer(25.5, 307471, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON, nil, 2, 4)
local timerSlurryBreathCD					= mod:NewCDTimer(17, 306736, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerDebilitatingSpitCD				= mod:NewCDTimer(30.1, 306953, nil, nil, nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerFixateCD							= mod:NewNextTimer(31, 307260, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)
local timerVolatileEruptionCD				= mod:NewNextTimer(10, 308157, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON)
local timerEntropicBuildupCD				= mod:NewNextTimer(10, 308177, nil, nil, nil, 5, nil, DBM_CORE_HEROIC_ICON)

local berserkTimer							= mod:NewBerserkTimer(360)

--mod:AddRangeFrameOption(6, 264382)
mod:AddInfoFrameOption(307358, true)
mod:AddSetIconOption("SetIconOnDebilitating", 306953, true, false, {1, 2, 3, 4})

mod.vb.phase = 0
mod.vb.eruptionCount = 0
mod.vb.buildupCount = 0
local SpitStacks = {}
local orbTimers = {0, 25, 25, 37, 20}

local function volatileEruptionLoop(self)
	self.vb.eruptionCount = self.vb.eruptionCount + 1
	specWarnVolatileEruption:Show()
	--15, 10, 10, 10, 10, 8+
	local timer = (self.vb.eruptionCount < 4) and 10 or 8
	timerVolatileEruptionCD:Start(10)
	self:Schedule(10, volatileEruptionLoop, self)
end

local function entropicBuildupLoop(self)
	self.vb.buildupCount = self.vb.buildupCount + 1
	warnEntropicBuildup:Show(self.vb.buildupCount)
	local timer = orbTimers[self.vb.buildupCount+1]
	if timer then
		timerEntropicBuildupCD:Start(timer)
		self:Schedule(timer, entropicBuildupLoop, self)
	end
end

function mod:ZapTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(5, 5) then
		specWarnDebilitatingSpit:Show()
		specWarnDebilitatingSpit:Play("targetyou")
	else
		warnDebilitatingSpit:Show(self.vb.zapCount, targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	table.wipe(SpitStacks)
	timerDebilitatingSpitCD:Start(10.7-delay)--START
	timerCrushCD:Start(18.1-delay)--SUCCESS
	timerSlurryBreathCD:Start(29.5-delay)
	timerFixateCD:Start(31-delay)
	berserkTimer:Start(360-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 312528 or spellId == 306928 or spellId == 312529 or spellId == 306929 or spellId == 312530 or spellId == 306930 then
		specWarnSlurryBreath:Show()
		specWarnSlurryBreath:Play("breathsoon")
		local timer = (self.vb.phase < 2) and 24.3 or (self.vb.phase == 2) and 18.2 or 17
		timerSlurryBreathCD:Start(timer)
	elseif spellId == 307260 and self:AntiSpam(5, 3) then
		timerFixateCD:Start()
	elseif spellId == 306953 then
		timerDebilitatingSpitCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 307471 then
		timerCrushCD:Start()
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
			if args:IsPlayer() and self:AntiSpam(4, 5) then
				specWarnDebilitatingSpit:Show()
				specWarnDebilitatingSpit:Play("targetyou")
			end
			if self.Options.SetIconOnDebilitating then
				self:SetIcon(args.destName, #SpitStacks)
			end
		end
		if self.Options.InfoFrame then
			if #SpitStacks == 1 then
				DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(307358))
				DBM.InfoFrame:Show(10, "table", SpitStacks, 1)
			else
				DBM.InfoFrame:UpdateTable(SpitStacks)
			end
		end
	elseif spellId == 306942 then
		warnFrenzy:Show(args.destName)
	elseif spellId == 307260 then
		warnFixate:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("justrun")
				yellFixate:Yell()
			end
		end
	elseif spellId == 308157 then
		self.vb.eruptionCount = 0
		timerVolatileEruptionCD:Start(12)
		self:Schedule(12, volatileEruptionLoop, self)
	elseif spellId == 308177 then
		self.vb.buildupCount = 0
		entropicBuildupLoop(self)--Might need adjusting, harder to verifiy in transcriptor
	elseif spellId == 308149 and args:IsPlayer() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 312328 then
		warnHunger:Show(args.amount or 0)
	elseif spellId == 307358 then
		local amount = args.amount or 0
		if amount == 0 then
			SpitStacks[args.destName] = nil
			if self.Options.SetIconOnDebilitating then
				self:SetIcon(args.destName, 0)
			end
		else
			SpitStacks[args.destName] = args.amount
		end
		if self.Options.InfoFrame then
			if #SpitStacks == 0 then
				DBM.InfoFrame:Hide()
			else
				DBM.InfoFrame:UpdateTable(SpitStacks)
			end
		end
	elseif spellId == 308157 then
		timerVolatileEruptionCD:Stop()
		self:Unschedule(volatileEruptionLoop)
	elseif spellId == 308177 then
		timerEntropicBuildupCD:Stop()
		self:Unschedule(entropicBuildupLoop)
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 270290 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:306448") then--Volatile Slurry
		self.vb.phase = self.vb.phase + 1
		warnVolatileSlurry:Show()
	elseif msg:find("spell:306934") then--Entropic Slurry
		self.vb.phase = self.vb.phase + 1
		warnEntropicSlurry:Show()
	elseif msg:find("spell:306932") then--Bubbling Slurry
		self.vb.phase = self.vb.phase + 1
		warnBubblingSlurry:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 309725 or spellId == 309730 or spellId == 309724 or spellId == 308652) and self:AntiSpam(5, 1) then--All the slurry Visuals
		if spellId == 309725 then--Bubbling Slurry Visual
			warnBubblingSlurry:Show(self.vb.slurryCount)
		elseif spellId == 309730 then--Entropic Slurry Visual
			warnEntropicSlurry:Show(self.vb.slurryCount)
		else--309724 or 308652 (Volatile Slurry Visual)
			warnVolatileSlurry:Show(self.vb.slurryCount)
		end
	elseif spellId == 306736 then--Slurry Breath

	end
end

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 306953 then
		self:BossUnitTargetScanner(uId, "ZapTarget")
	end
end

--One second faster than debuff. 10 to 1 this is a bug, and backup debuff code is still in place.
--"<43.72 16:10:22> [UNIT_SPELLCAST_CHANNEL_START] Unknown(Shamarangg) - Fixate - 1s [[boss2:nil:307260]]", -- [681]
--"<44.69 16:10:23> [CLEU] SPELL_AURA_APPLIED#Creature-0-3198-2217-1118-157229-000020E1AE#Living Chow#Player-3296-001C3B1B#Shamarangg#307260#Fixate#DEBUFF#nil", -- [725]
function mod:UNIT_SPELLCAST_CHANNEL_START(uId, _, spellId)
	if spellId == 307260 and UnitExists(uId.."target") then--Fixate
		--local targetName = DBM:GetUnitFullName(uId.."target")
		--warnFixate:CombinedShow(0.3, targetName)
		if UnitIsUnit("player", uId.."target") then
			if self:AntiSpam(3, 2) then
				specWarnFixate:Show()
				specWarnFixate:Play("runout")
				yellFixate:Yell()
			end
		end
	end
end
