local mod	= DBM:NewMod(2500, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(190496)
mod:SetEncounterID(2639)
mod:SetUsedIcons(1, 2, 3, 4, 5)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 380487 377166 377505 383073 376279",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 386352 381253 376276",
	"SPELL_AURA_APPLIED_DOSE 376276",
	"SPELL_AURA_REMOVED 386352 381253",
	"SPELL_PERIODIC_DAMAGE 382458",
	"SPELL_PERIODIC_MISSED 382458"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Note: https://www.wowhead.com/beta/spell=380557/rock-blast indicates target counts, up to 5 on mythic
--TODO, verify Brutal Reverberation placement. maybe an actual event or something to use
--TODO, auto mark awakened Earth (after spawn)?
--TODO, keep an eye on https://www.wowhead.com/beta/spell=391570/reactive-dust . not sure what to do with it yet, since this tooltip says something diff than journal
--[[
(ability.id = 380487 or ability.id = 377166 or ability.id = 377505 or ability.id = 383073 or ability.id = 376279) and type = "begincast"
--]]
local warnRockBlast								= mod:NewTargetNoFilterAnnounce(380487, 3)
local warnAwakenedEarth							= mod:NewTargetNoFilterAnnounce(381253, 3)
local warnConcussiveSlam						= mod:NewStackAnnounce(372158, 2, nil, "Tank|Healer")

local specWarnRockBlast							= mod:NewSpecialWarningYouPos(380487, nil, nil, nil, 1, 2)
local yellRockBlast								= mod:NewShortPosYell(380487)
local yellRockBlastFades						= mod:NewIconFadesYell(380487)
local specWarnBrutalReverberation				= mod:NewSpecialWarningDodge(386400, nil, nil, nil, 2, 2)
local specWarnAwakenedEarth						= mod:NewSpecialWarningYou(381253, nil, nil, nil, 1, 2)
local yellAwakenedEarthFades					= mod:NewShortFadesYell(381253)
local specWarnResonatingAnnihilation			= mod:NewSpecialWarningCount(377166, nil, nil, nil, 2, 2)
local specWarnShatteringImpact					= mod:NewSpecialWarningDodge(383073, nil, nil, nil, 2, 2)
local specWarnConcussiveSlam					= mod:NewSpecialWarningDefensive(376279, nil, nil, nil, 1, 2)
local specWarnConcussiveSlamTaunt				= mod:NewSpecialWarningTaunt(376279, nil, nil, nil, 1, 2)
local specWarnFrenziedDevastation				= mod:NewSpecialWarningSpell(377505, nil, nil, nil, 3, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(382458, nil, nil, nil, 1, 8)

local timerRockBlastCD							= mod:NewNextCountTimer(35, 380487, nil, nil, nil, 3)
local timerResonatingAnnihilationCD				= mod:NewNextCountTimer(96.4, 377166, nil, nil, nil, 3)
local timerShatteringImpactCD					= mod:NewNextCountTimer(35, 383073, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerConcussiveSlamCD						= mod:NewNextCountTimer(35, 376279, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFrenziedDevastationCD				= mod:NewNextTimer(387.9, 377505, nil, nil, nil, 2)--Berserk timer basically

--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
--mod:AddInfoFrameOption(361651, true)--Likely will be used for dust
mod:AddSetIconOption("SetIconOnRockBlast", 380487, true, false, {1, 2, 3, 4, 5})

mod.vb.DebuffIcon = 1
mod.vb.annihilationCount = 0
mod.vb.rockCount = 0
mod.vb.slamCount = 0
mod.vb.impactCount = 0
mod.vb.frenziedStarted = false
local difficultyName = "heroic"
local allTimers = {
	["normal"] = {
		--Concussive Slam
		[376279] = {},
		--Rock Blast
		[326707] = {},
		--Shattering Impact
		[383073] = {},
	},
	["heroic"] = {
		--Concussive Slam
		[376279] = {14.0, 19.9, 22.0, 19.9, 34.5, 20.0, 22.0, 20.0, 34.4, 20.0, 22.0, 20.0, 34.5, 19.9, 22.0, 20.0},
		--Rock Blast
		[326707] = {6.0, 42.0, 54.5, 42.0, 54.5, 42.0, 54.5, 42.0},
		--Shattering Impact
		[383073] = {27.0, 42.0, 54.5, 42.0, 54.5, 42.0, 54.5, 42.0},
	},
	["mythic"] = {
		--Concussive Slam
		[376279] = {},
		--Rock Blast
		[326707] = {},
		--Shattering Impact
		[383073] = {},
	},
}

function mod:OnCombatStart(delay)
	difficultyName = "heroic"--Temp setting to only difficult untl know for sure if other difficulties have faster or slower timers
	self.vb.annihilationCount = 0
	self.vb.rockCount = 0
	self.vb.slamCount = 0
	self.vb.impactCount = 0
	self.vb.frenziedStarted = false
	timerRockBlastCD:Start(6-delay, 1)
	timerConcussiveSlamCD:Start(14-delay, 1)
	timerShatteringImpactCD:Start(27-delay, 1)
	timerResonatingAnnihilationCD:Start(90-delay, 1)
	timerFrenziedDevastationCD:Start(387.9-delay)
end

--function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--end

function mod:OnTimerRecovery()
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	else
--		difficultyName = "normal"
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 380487 then
		self.vb.DebuffIcon = 1
		self.vb.rockCount = self.vb.rockCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.rockCount+1)
		if timer then
			timerRockBlastCD:Start(timer, self.vb.rockCount+1)
		end
	elseif spellId == 377166 then
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		specWarnResonatingAnnihilation:Show(self.vb.annihilationCount)
		specWarnResonatingAnnihilation:Play("specialsoon")
		timerResonatingAnnihilationCD:Start()--Doesn't need table, it's static
	elseif spellId == 377505 and not self.vb.frenziedStarted then
		self.vb.frenziedStarted = true
		specWarnFrenziedDevastation:Show()
		specWarnFrenziedDevastation:Play("stilldanger")
	elseif spellId == 383073 then
		self.vb.impactCount = self.vb.impactCount + 1
		specWarnShatteringImpact:Show()
		specWarnShatteringImpact:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.impactCount+1)
		if timer then
			timerShatteringImpactCD:Start(timer, self.vb.impactCount+1)
		end
	elseif spellId == 376279 then
		self.vb.slamCount = self.vb.slamCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnConcussiveSlam:Show()
			specWarnConcussiveSlam:Play("defensive")
		end
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.slamCount+1)
		if timer then
			timerConcussiveSlamCD:Start(timer, self.vb.slamCount+1)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 362805 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 386352 and self:AntiSpam(4, args.destName.."1") then
		local icon = self.vb.DebuffIcon
		if self.Options.SetIconOnRockBlast then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnRockBlast:Show(self:IconNumToTexture(icon))
			specWarnRockBlast:Play("mm"..icon)
			yellRockBlast:Yell(icon, icon)
			yellRockBlastFades:Countdown(5, nil, icon)
		end
		warnRockBlast:CombinedShow(0.5, args.destName)
		self.vb.DebuffIcon = self.vb.DebuffIcon + 1
	elseif spellId == 381253 and self:AntiSpam(4, args.destName.."2") then
		warnAwakenedEarth:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnAwakenedEarth:Show()
			specWarnAwakenedEarth:Play("targetyou")
			yellAwakenedEarthFades:Countdown(spellId)
		end
	elseif spellId == 376276 and not args:IsPlayer() then
		local amount = args.amount or 1
		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 376279, self.vb.slamCount+1) or 20) - 2.5
		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
			specWarnConcussiveSlamTaunt:Show(args.destName)
			specWarnConcussiveSlamTaunt:Play("tauntboss")
		else
			warnConcussiveSlam:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 386352 then
		if self:AntiSpam(3, 1) then
			specWarnBrutalReverberation:Show()
			specWarnBrutalReverberation:Play("watchstep")
		end
		if self.Options.SetIconOnRockBlast then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellRockBlastFades:Cancel()
		end
	elseif spellId == 381253 then
		if args:IsPlayer() then
			yellAwakenedEarthFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 382458 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Not currently in combat log so we run same code we would as backup from transcriptor comms
function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("380485") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."1") then
			local icon = self.vb.DebuffIcon
			if self.Options.SetIconOnRockBlast then
				self:SetIcon(targetName, icon)
			end
			if targetName == UnitName("player") then
				specWarnRockBlast:Show(self:IconNumToTexture(icon))
				specWarnRockBlast:Play("mm"..icon)
				yellRockBlast:Yell(icon, icon)
				yellRockBlastFades:Countdown(5, nil, icon)
			end
			warnRockBlast:CombinedShow(0.5, targetName)
			self.vb.DebuffIcon = self.vb.DebuffIcon + 1
		end
	elseif msg:find("381253") and targetName then
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName.."2") then
			if targetName == UnitName("player") then
				specWarnAwakenedEarth:Show()
				specWarnAwakenedEarth:Play("targetyou")
				yellAwakenedEarthFades:Countdown(5)
			end
			warnAwakenedEarth:CombinedShow(0.5, targetName)
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 353193 then

	end
end
--]]
