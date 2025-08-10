local mod	= DBM:NewMod(2691, "DBM-Raids-WarWithin", 1, 1302)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(214503)
mod:SetEncounterID(3135)
--mod:SetHotfixNoticeRev(20240921000000)
--mod:SetMinSyncRevision(20240921000000)
mod:SetZone(2810)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1230087 1248240 1229038 1230979 1243690",
--	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 1231005 1228206 1228207 1230168 1229674 1243699 1243577 1243609 1235114 1246930",
	"SPELL_AURA_APPLIED_DOSE 1228207 1230168 1229674",
	"SPELL_AURA_REMOVED 1228207 1229038 1243577 1243609",
	"SPELL_AURA_REMOVED_DOSE 1228207",
	"SPELL_PERIODIC_DAMAGE 1231002",
	"SPELL_PERIODIC_MISSED 1231002",
	"UNIT_DIED"
--	"CHAT_MSG_RAID_BOSS_WHISPER",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, who should be warned about massive smash and what should it say?
--TODO, add antimatter to GTFO if you soak too long
--TODO, get true spellcast for reverse gravity
--TODO, Stellar Core counter for intermission 1?
--TODO, https://www.wowhead.com/ptr-2/spell=1232888/phenomenal-cosmic-power might be a phase change event
--Stage One: Critical Mass
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32292))
local warnExcessMass								= mod:NewTargetNoFilterAnnounce(1228206, 1)
local warnMortalFragility							= mod:NewYouAnnounce(1230168, 4)
local warnDevourOver								= mod:NewEndAnnounce(1229038, 1)
local warnSpatialFragment							= mod:NewTargetNoFilterAnnounce(1243699, 1)
local warnAirbornRemoved							= mod:NewFadesAnnounce(1243609, 1)

local specWarnMassiveSmash							= mod:NewSpecialWarningCount(1230087, nil, nil, nil, 2, 2)
local specWarnExcessMass							= mod:NewSpecialWarningYou(1228206, nil, nil, nil, 1, 2)
local specWarnMortalFragility						= mod:NewSpecialWarningTaunt(1230168, nil, nil, nil, 1, 2)
local specWarnDevour								= mod:NewSpecialWarningCount(1229038, nil, nil, nil, 3, 2)
local specWarnDarkMatter							= mod:NewSpecialWarningCount(1230979, nil, nil, nil, 1, 2)
local specWarnShatteredSpace						= mod:NewSpecialWarningDodgeCount(1243690, nil, nil, nil, 2, 2)
local specWarnReverseGravity						= mod:NewSpecialWarningMoveAwayCount(1243577, nil, nil, nil, 1, 2)
local yellReverseGravity							= mod:NewShortYell(1243577)
local yellReverseGravityFades						= mod:NewShortFadesYell(1243577)
local specWarnAirborn								= mod:NewSpecialWarningYou(1243609, nil, nil, nil, 1, 2)
--local specWarnReverseGravityDispel				= mod:NewSpecialWarningDispel(1243577, nil, nil, nil, 1, 2)
local specWarnGTFO									= mod:NewSpecialWarningGTFO(1231002, nil, nil, nil, 1, 8)

--local timerMassiveSmashCD							= mod:NewCDCountTimer(97.3, 1230087, nil, nil, nil, 2)
local timerInfinitePossibilities					= mod:NewCastNPTimer(8, 1248240, nil, nil, nil, 5)
--local timerDevourCD								= mod:NewCDCountTimer(97.3, 1229038, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
--local timerDarkMatterCD							= mod:NewCDCountTimer(97.3, 1230979, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--local timerShatteredSpaceCD						= mod:NewCDCountTimer(97.3, 1243690, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
--local timerReverseGravityCD						= mod:NewCDCountTimer(97.3, 1243577, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnLivingMass", -33474, true, 5, {6, 1, 2, 4, 7})
--mod:AddPrivateAuraSoundOption(433517, true, 433517, 1)
--Intermission: Event Horizon
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32735))
local warnSoaringReshii								= mod:NewYouAnnounce(1235114, 1)
local warnStellarCore								= mod:NewYouAnnounce(1246930, 1)
--Stage Two: The Dark Heart
mod:AddTimerLine(DBM:EJ_GetSectionInfo(32477))


--BW Compatible Icon Marking
local livingMassMarkerMapTable = {6, 1, 2, 4, 7}

local playerStacks, bossStacks = 0, 0

mod.vb.massiveSmashCount = 0
mod.vb.massSpawns = 0
mod.vb.devourCount = 0
mod.vb.darkMatterCount = 0
mod.vb.shatteredSpaceCount = 0
mod.vb.reverseGravityCount = 0

local savedDifficulty = "normal"
local allTimers = {
	["mythic"] = {
		[1] = {
			[1230087] = {},--Massive Smash
			[1229038] = {},--Devour P1
			[1230979] = {},--Dark Matter
			[1243690] = {},--Shattered Space
			[1243577] = {},--Reverse Gravity
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.massiveSmashCount = 0
	self.vb.massSpawns = 0
	self.vb.devourCount = 0
	self.vb.darkMatterCount = 0
	self.vb.shatteredSpaceCount = 0
	self.vb.reverseGravityCount = 0
	--self:EnablePrivateAuraSound(433517, "runout", 2)
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	--timerMassiveSmashCD:Start(allTimers[savedDifficulty][1][1230087][1]-delay, 1)
	--timerDevourCD:Start(allTimers[savedDifficulty][1][1229038][1]-delay, 1)
	--timerDarkMatterCD:Start(allTimers[savedDifficulty][1][1230979][1]-delay, 1)
	--timerShatteredSpaceCD:Start(allTimers[savedDifficulty][1][1243690][1]-delay, 1)
	--timerReverseGravityCD:Start(allTimers[savedDifficulty][1][1243577][1]-delay, 1)
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		savedDifficulty = "mythic"
	elseif self:IsHeroic() then
		savedDifficulty = "heroic"
	else--Combine LFR and Normal
		savedDifficulty = "normal"
	end
	if DBM:UnitDebuff("player", 1228207) then
		local _, _, stack = DBM:UnitDebuff("player", 1228207)
		playerStacks = stack or 0
	end
end

local function extraWarnDevour(self)
	if playerStacks < bossStacks then
		specWarnDevour:Show(self.vb.devourCount)
		specWarnDevour:Play("gather")
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1230087 then
		self.vb.massiveSmashCount = self.vb.massiveSmashCount + 1
		specWarnMassiveSmash:Show(self.vb.massiveSmashCount)
		specWarnMassiveSmash:Play("carefly")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.massiveSmashCount+1)
		--if timer then
		--	timerMassiveSmashCD:Start(timer, self.vb.massiveSmashCount+1)
		--end
	elseif spellId == 1248240 then
		timerInfinitePossibilities:Start(nil, args.sourceGUID)
	elseif spellId == 1229038 then
		self.vb.devourCount = self.vb.devourCount + 1
		specWarnDevour:Show(self.vb.devourCount)
		specWarnDevour:Play("gather")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.devourCount+1)
		--if timer then
		--	timerDevourCD:Start(timer, self.vb.devourCount+1)
		--end
		self:Schedule(2.5, extraWarnDevour, self)
	elseif spellId == 1230979 then
		self.vb.darkMatterCount = self.vb.darkMatterCount + 1
		specWarnDarkMatter:Show(self.vb.darkMatterCount)
		specWarnDarkMatter:Play("aesoon")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.darkMatterCount+1)
		--if timer then
		--	timerDarkMatterCD:Start(timer, self.vb.darkMatterCount+1)
		--end
	elseif spellId == 1243690 then
		self.vb.shatteredSpaceCount = self.vb.shatteredSpaceCount + 1
		specWarnShatteredSpace:Show(self.vb.shatteredSpaceCount)
		specWarnShatteredSpace:Play("aesoon")
		specWarnShatteredSpace:ScheduleVoice(4, "helpsoak")
		--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.shatteredSpaceCount+1)
		--if timer then
		--	timerShatteredSpaceCD:Start(timer, self.vb.shatteredSpaceCount+1)
		--end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 439559 then

	end
end
--]]

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 1231005 then
		self.vb.massSpawns = self.vb.massSpawns + 1
		if self.Options.SetIconOnLivingMass and self.vb.massSpawns < 6 then
			self:ScanForMobs(args.destGUID, 2, livingMassMarkerMapTable[self.vb.massSpawns], 1, nil, 12, "SetIconOnLivingMass")
		end
	elseif spellId == 1228206 then
		if args:IsPlayer() then
			specWarnExcessMass:Show()
			specWarnExcessMass:Play("runout")
		else
			warnExcessMass:Show(args.destName)
		end
	elseif spellId == 1228207 then
		if args:IsPlayer() then
			playerStacks = args.amount or 1
		end
	elseif spellId == 1230168 then
		if args:IsPlayer() then
			warnMortalFragility:Show()
		else
			specWarnMortalFragility:Show(args.destName)
			specWarnMortalFragility:Play("tauntboss")
		end
	elseif spellId == 1229674 then
		bossStacks = args.amount or 1
	elseif spellId == 1243699 then
		warnSpatialFragment:CombinedShow(1, args.destName)
	elseif spellId == 1243577 then
		if self:AntiSpam(5, 1) then
			self.vb.reverseGravityCount = self.vb.reverseGravityCount + 1
			--local timer = self:GetFromTimersTable(allTimers, savedDifficulty, self.vb.phase, spellId, self.vb.reverseGravityCount)
			--if timer then
			--	timerReverseGravityCD:Start(timer, self.vb.reverseGravityCount)
			--end
			if DBM:UnitDebuff("player", 1228206) then--Excess Mass

			end
		end
		if args:IsPlayer() then
			specWarnReverseGravity:Show(self.vb.reverseGravityCount)
			specWarnReverseGravity:Play("scatter")
			yellReverseGravity:Yell()
			yellReverseGravityFades:Countdown(spellId)
		end
	elseif spellId == 1243609 then
		if args:IsPlayer() then
			specWarnAirborn:Show()
			specWarnAirborn:Play("targetyou")--Record goofy audio later?
		end
	elseif spellId == 1235114 then
		if self:AntiSpam(5, 2) then
			self:SetStage(1.5)
			--timerMassiveSmashCD:Stop()
			--timerSoaringReshiiCD:Stop()
			--timerInfinitePossibilitiesCD:Stop()
			--timerDevourCD:Stop()
			--timerDarkMatterCD:Stop()
		end
		if args:IsPlayer() then
			warnSoaringReshii:Show()
		end
	elseif spellId == 1246930 then
		if args:IsPlayer() then
			warnStellarCore:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 1228207 then
		if args:IsPlayer() then
			playerStacks = args.amount or 0
		end
	elseif spellId == 1229038 then
		warnDevourOver:Show()
		self:Unschedule(extraWarnDevour)
	elseif spellId == 1243577 then
		if args:IsPlayer() then
			yellReverseGravityFades:Cancel()
		end
	elseif spellId == 1243609 and args:IsPlayer() then
		warnAirbornRemoved:Show()
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 1231002 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 242587 then--Living Mass
		timerInfinitePossibilities:Stop(args.destGUID)
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 433475 then

	end
end
--]]
