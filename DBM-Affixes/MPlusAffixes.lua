local mod	= DBM:NewMod("MPlusAffixes", "DBM-Affixes")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)
mod:SetZone(2516, 2526, 2515, 2521, 1477, 1571, 1176, 960)--All of the S1 DF M+ Dungeons

mod.isTrashMod = true
mod.isTrashModBossFightAllowed = true

mod:RegisterEvents(
	"SPELL_CAST_START 240446",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 240447 226510 226512 350209 396369 396364",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 396369 396364 226510",
	"SPELL_DAMAGE 209862",
	"SPELL_MISSED 209862",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED"
)

--TODO, fine tune tank stacks/throttle?
--[[
(ability.id = 240446) and type = "begincast"
--]]
local warnExplosion							= mod:NewCastAnnounce(240446, 4)
local warnThunderingFades					= mod:NewFadesAnnounce(396363, 1)

local specWarnQuake							= mod:NewSpecialWarningMoveAway(240447, nil, nil, nil, 1, 2)
local specWarnSpitefulFixate				= mod:NewSpecialWarningYou(350209, nil, nil, nil, 1, 2)
local specWarnPositiveCharge				= mod:NewSpecialWarningYou(396369, nil, 391990, nil, 1, 13)--Short name is using Positive Charge instead of Mark of Lightning
local specWarnNegativeCharge				= mod:NewSpecialWarningYou(396364, nil, 391991, nil, 1, 13)--Short name is using Netative Charge instead of Mark of Winds
local yellThundering						= mod:NewIconRepeatYell(396363, DBM_CORE_L.AUTO_YELL_ANNOUNCE_TEXT.shortyell)--15-9
local yellThunderingFades					= mod:NewIconFadesYell(396363, nil, nil, nil, "YELL")--8 to 0
local specWarnGTFO							= mod:NewSpecialWarningGTFO(209862, nil, nil, nil, 1, 8)--Volcanic and Sanguine

local timerQuakingCD						= mod:NewNextTimer(20, 240447, nil, nil, nil, 3)
local timerThunderingCD						= mod:NewNextTimer(70, 396363, nil, nil, nil, 3)
local timerPositiveCharge					= mod:NewBuffFadesTimer(15, 396369, 391990, nil, 2, 5, nil, nil, nil, 1, 4)
local timerNegativeCharge					= mod:NewBuffFadesTimer(15, 396364, 391991, nil, 2, 5, nil, nil, nil, 1, 4)
mod:GroupSpells(396363, 396369, 396364)--Thundering with the two charge spells

mod:AddNamePlateOption("NPSanguine", 226510, "Tank", true)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 misc, 7 gtfo, 8 personal aggregated alert

local playerThundering = false

local function yellRepeater(self, text, total)
	total = total + 1
	if total < 4 then
		yellThundering:Yell(text)
		self:Schedule(1.5, yellRepeater, self, text, total)
	end
end

local function checkThunderin(self)
	local thunderingNTotal, thunderingPTotal = 0, 0
	for uId in DBM:GetGroupMembers() do
		if DBM:UnitDebuff(uId, 396364) then
			thunderingNTotal = thunderingPTotal + 1
		end
		if DBM:UnitDebuff(uId, 396369) then
			thunderingPTotal = thunderingPTotal + 1
		end
	end
	--No possible clears left (ie only 1 or more debuff left of a single type). Force clear them all
	if (thunderingNTotal == 0 and thunderingPTotal >= 1) or (thunderingNTotal >= 1 and thunderingPTotal == 0) then
		if playerThundering then--Avoid double message from SAR clear
			warnThunderingFades:Show()
			playerThundering = false
			yellThundering:Yell(DBM_COMMON_L.CLEAR)
		end
		timerPositiveCharge:Stop()
		timerNegativeCharge:Stop()
		self:Unschedule(yellRepeater)
		yellThunderingFades:Cancel()
	else
		self:Schedule(1, checkThunderin, self)
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240446 and self:AntiSpam(3, "aff6") then
		warnExplosion:Show()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 373370 then
		timerNightmareCloudCD:Start(30.5, args.sourceGUID)
	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 240447 then
		if self:AntiSpam(3, "aff5") then
			timerQuakingCD:Start()
		end
		if args:IsPlayer() then
			specWarnQuake:Show()
			specWarnQuake:Play("range5")
		end
	elseif spellId == 226512 and args:IsPlayer() and self:AntiSpam(3, "aff7") then--Sanguine Ichor on player
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 226510 then--Sanguine Ichor on mob
		if self.Options.NPSanguine then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, nil, nil, true)
		end
	elseif spellId == 350209 and args:IsPlayer() and self:AntiSpam(3, "aff8") then
		specWarnSpitefulFixate:Show()
		specWarnSpitefulFixate:Play("targetyou")
	elseif spellId == 396369 or spellId == 396364 then
		if self:AntiSpam(20, "affseasonal") then
			playerThundering = false
			if DBM.Options.DebugMode then
				timerThunderingCD:Start()
			end
			self:Unschedule(checkThunderin)
			self:Schedule(1, checkThunderin, self)
		end
		if args:IsPlayer() then
			playerThundering = true
			self:Unschedule(yellRepeater)
			local icon
			if spellId == 396364 then
				specWarnNegativeCharge:Show()
				specWarnNegativeCharge:Play("negative")
				timerNegativeCharge:Start()
				icon = 7
			else
				specWarnPositiveCharge:Show()
				specWarnPositiveCharge:Play("positive")
				timerPositiveCharge:Start()
				icon = 6
			end
			local formatedIcon = DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION:format(icon, "")
			yellRepeater(self, formatedIcon, 0)
			yellThunderingFades:Cancel()
			yellThunderingFades:Countdown(15, 8, icon)--Start icon spam with count at 8 remaining
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 396369 or spellId == 396364 then
		if args:IsPlayer() then
			if playerThundering then--Avoid double message from unit aura clear
				warnThunderingFades:Show()
				playerThundering = false
				yellThundering:Yell(DBM_COMMON_L.CLEAR)
			end
			timerPositiveCharge:Stop()
			timerNegativeCharge:Stop()
			self:Unschedule(yellRepeater)
			yellThunderingFades:Cancel()
		end
	elseif spellId == 226510 then--Sanguine Ichor on mob
		if self.Options.NPSanguine then
			DBM.Nameplate:Hide(true, args.destGUID, spellId, nil, nil, nil, nil, true)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 209862 and destGUID == UnitGUID("player") and self:AntiSpam(3, "aff7") then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--Function to make sure GROUP is out of combat, can't just trust player leaving combat as being fully out of combat in case player dies.
local function checkForCombatEnd(self, runTimes)
	runTimes = runTimes + 1
	local combatFound = false
	if IsEncounterInProgress() then
		combatFound = true
	end
	if not combatFound then
		for uId in self:GetGroupMembers() do
			if UnitAffectingCombat(uId) and not UnitIsDeadOrGhost(uId) then
				combatFound = true
				break
			end
		end
	end
	if combatFound then
		self:Schedule(1, checkForCombatEnd, self, runTimes)
	else
		timerThunderingCD:RemoveTime(runTimes)
		timerThunderingCD:Pause()
	end
end

function mod:PLAYER_REGEN_DISABLED()
	if DBM.Options.DebugMode then
		timerThunderingCD:Resume()
	end
end

function mod:PLAYER_REGEN_ENABLED()
	if DBM.Options.DebugMode then
		self:Unschedule(checkForCombatEnd)
		checkForCombatEnd(self, 0)
	end
end
