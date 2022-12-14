local mod	= DBM:NewMod(2482, "DBM-VaultoftheIncarnates", nil, 1200)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(187967)
mod:SetEncounterID(2592)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20221213000000)
mod:SetMinSyncRevision(20221013000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 371976 372082 373405 374112 373027 371983 372539",
	"SPELL_CAST_SUCCESS 372238 181113 181089 396792",
	"SPELL_SUMMON 372242 372843",
	"SPELL_AURA_APPLIED 371976 372082 372030 372044 385083 373048",
	"SPELL_AURA_APPLIED_DOSE 372030 385083",
	"SPELL_AURA_REMOVED 371976 372082 372030 373048",
	"SPELL_AURA_REMOVED_DOSE 372030",
--	"SPELL_INTERRUPT",
--	"SPELL_PERIODIC_DAMAGE 372055",
--	"SPELL_PERIODIC_MISSED 372055",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, GTFO for icy Ground?
--TODO, I cannot be bothered to do these timers. After 3 hours on boss logs (yet again), decided not to bother with more accurate approach. Half assed will have to be good enough
--TODO, timers need more work, but it'll be helpful when phase change events added to combat log or at very least transcriptor for easier table reading.
--[[
(ability.id = 371976 or ability.id = 372082 or ability.id = 373405 or ability.id = 372539 or ability.id = 373027 or ability.id = 371983) and type = "begincast"
 or (ability.id = 372238 or ability.id = 372648) and type = "cast"
 or ability.id = 181113 and source.id = 189234
 or ability.id = 372539 and type = "interrupt"
 or ability.id = 181089 and type = "cast"
--]]
--General
--local specWarnGTFO							= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--local berserkTimer							= mod:NewBerserkTimer(600)
--Stage One: Ice Climbers
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24883))
local warnChillingBlast							= mod:NewTargetAnnounce(371976, 2)
local warnEnvelopingWebs						= mod:NewTargetNoFilterAnnounce(372082, 3)
local warnWrappedInWebs							= mod:NewTargetNoFilterAnnounce(372044, 4)
local warnCallSpiderlings						= mod:NewCountAnnounce(372238, 2)

local specWarnChillingBlast						= mod:NewSpecialWarningMoveAway(371976, nil, nil, nil, 1, 2)
local yellChillingBlast							= mod:NewYell(371976)
local yellChillingBlastFades					= mod:NewShortFadesYell(371976)
local specWarnEnvelopingWebs					= mod:NewSpecialWarningYouPos(372082, nil, nil, nil, 1, 2)
local yellEnvelopingWebs						= mod:NewShortPosYell(372082)
local yellEnvelopingWebsFades					= mod:NewIconFadesYell(372082)
local specWarnStickyWebbing						= mod:NewSpecialWarningStack(372030, nil, 3, nil, nil, 1, 6)
local specWarnGossamerBurst						= mod:NewSpecialWarningSpell(373405, nil, nil, nil, 2, 12)
local specWarnWebBlast							= mod:NewSpecialWarningTaunt(385083, nil, nil, nil, 1, 2)
local specWarnGustingRime						= mod:NewSpecialWarningDodgeCount(396792, nil, nil, nil, 2, 2, 4)

local timerChillingBlastCD						= mod:NewCDCountTimer(18.5, 371976, nil, nil, nil, 3)--18.5-54.5
local timerEnvelopingWebsCD						= mod:NewCDCountTimer(24, 372082, nil, nil, nil, 3)--24-46.9
local timerGossamerBurstCD						= mod:NewCDCountTimer(36.9, 373405, nil, nil, nil, 2)--36.9-67.6
local timerGustingrimeCD						= mod:NewAITimer(38.8, 396792, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerCallSpiderlingsCD					= mod:NewCDCountTimer(25.1, 372238, nil, nil, nil, 1)--17.6-37
local timerFrostbreathArachnidCD				= mod:NewCDCountTimer(98.9, "ej24899", nil, nil, nil, 1)
local timerPhaseCD								= mod:NewPhaseTimer(30)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(372030, false)--Useful raid leader tool, but not needed by everyone
mod:AddSetIconOption("SetIconOnWeb", 372082, true, false, {1, 2, 3})
--Intermission: Guardians of Frost
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24898))
local warnFrostbreathArachnid						= mod:NewSpellAnnounce("ej24899", 2)

local specWarnFreezingBreath						= mod:NewSpecialWarningDefensive(374112, nil, nil, nil, 1, 2)

local timerFreezingBreathCD							= mod:NewCDTimer(11.1, 374112, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--Stage Two: Cold Peak
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24885))
local warnApexofIce									= mod:NewCastAnnounce(372539, 3)
local warnSuffocatinWebs							= mod:NewTargetNoFilterAnnounce(373027, 3)

local specWarnSuffocatingWebs						= mod:NewSpecialWarningYouPos(373027, nil, nil, nil, 1, 2)
local yellSuffocatingWebs							= mod:NewShortPosYell(373027)
local yellSuffocatingWebsFades						= mod:NewIconFadesYell(373027)
local specWarnRepellingBurst						= mod:NewSpecialWarningSpell(371983, nil, nil, nil, 2, 12)

local timerSuffocatingWebsCD						= mod:NewCDCountTimer(38.8, 373027, nil, nil, nil, 3)--38-45
local timerRepellingBurstCD							= mod:NewCDCountTimer(33.9, 371983, nil, nil, nil, 2)--33-37 (unknown on normal

mod:AddSetIconOption("SetIconOnSufWeb", 373027, true, false, {1, 2, 3})

local stickyStacks = {}
mod.vb.webIcon = 1
mod.vb.blastCount = 0
mod.vb.webCount = 0
mod.vb.burstCount = 0--Both bursts
mod.vb.rimeCast = 0
mod.vb.spiderlingsCount = 0
mod.vb.bigAddCount = 0
--P1 being one giant sequenced table is more of a temporary stopgap until CLEU is fixed up and boss movements (start and stop) more visible.
--Likley still use sequencing but borken down by each movement versuses all P1 together
local difficultyName = "mythic"
local allTimers = {
	["mythic"] = {
		[1] = {
			--Chilling Blast
			[371976] = {15.5, 37.6, 37.4, 29.1, 37.2, 37.5, 21.9, 36.5, 37.3},
			--Enveloping Webs
			[372082] = {18.1, 26.7, 30.5, 44.8, 26.7, 30.4, 38.9, 26.4, 30.4},
			--Gossamer Burst
			[373405] = {32.8, 37.7, 65.5, 36.5, 59.6, 37.6},
			--Call Spiderlings
			[372238] = {0, 25.5, 25.5, 26.7, 38.8, 25.5, 25.5, 25.5, 20.7, 26.7, 26.7},--5th has largest variance, 14-23 because sequencing isn't right way to do this, just the lazy way
			--Gusting Rime
			[396792] = {},
		},
		--[2] = {
		--	--Chilling Blast
		--	[371976] = {15.7, 17.0, 32.8, 32.8, 34.1, 34, 34.0, 35.2, 34.0},--Unused for now
		--	--Call Spiderlings
		--	[372238] = {12.8, 30.4, 30.5, 32.8, 35.2},--Unused for now
		--},
	},
	["heroic"] = {
		[1] = {
			--Chilling Blast
			[371976] = {15.5, 37.6, 37.4, 29.1, 37.2, 37.5, 21.9, 36.5, 37.3},
			--Enveloping Webs
			[372082] = {18.1, 26.7, 30.5, 44.8, 26.7, 30.4, 38.9, 26.4, 30.4},
			--Gossamer Burst
			[373405] = {32.8, 37.7, 65.5, 36.5, 59.6, 37.6},
			--Call Spiderlings
			[372238] = {0, 25.5, 25.5, 26.7, 38.8, 25.5, 25.5, 25.5, 20.7, 26.7, 26.7},--5th has largest variance, 14-23 because sequencing isn't right way to do this, just the lazy way
			--Gusting Rime
			[396792] = {},
		},
		--[2] = {
		--	--Chilling Blast
		--	[371976] = {15.7, 17.0, 32.8, 32.8, 34.1, 34, 34.0, 35.2, 34.0},--Unused for now
		--	--Call Spiderlings
		--	[372238] = {12.8, 30.4, 30.5, 32.8, 35.2},--Unused for now
		--},
	},
	--[[["heroic"] = {--Not used cause frankly doing it this way for more accuracy sucks BALLS. I'd rather have inaccurate timers
		[1] = {--Pull (first Encounter Event is ignored that fires 4-5 sec in)
			--Chilling Blast
			[371976] = {15.7},
			--Enveloping Webs
			[372082] = {18.2},
			--Gossamer Burst
			[373405] = {33.2},
			--Call Spiderlings
			[372238] = {0, 25.5},
		},
		[2] = {--First Move
			--Chilling Blast
			[371976] = {10.9, 36.4},
			--Enveloping Webs
			[372082] = {2.4, 31.6},
			--Gossamer Burst
			[373405] = {27.9},
			--Call Spiderlings
			[372238] = {8.4, 25.5, 25.5},
		},
		[3] = {--First Move Ending
			--Chilling Blast
			[371976] = {17},
			--Enveloping Webs
			[372082] = {19.4},
			--Gossamer Burst
			[373405] = {34.1},
			--Call Spiderlings
			[372238] = {12.1},
		},
		[4] = {--Second move
			--Chilling Blast
			[371976] = {15.7, 36.4},
			--Enveloping Webs
			[372082] = {7.2, 31.5},
			--Gossamer Burst
			[373405] = {32.7},
			--Call Spiderlings
			[372238] = {3.6, 26.6, 26.7},
		},
		[5] = {--second move ending
			--Chilling Blast
			[371976] = {17},
			--Enveloping Webs
			[372082] = {19.5},
			--Gossamer Burst
			[373405] = {34.1},
			--Call Spiderlings
			[372238] = {12.1},
		},
		[6] = {--third move (reaching top and beginning p2)
			--Chilling Blast
			[371976] = {14.6, 37.7},
			--Enveloping Webs
			[372082] = {7.3, 30.4},
			--Gossamer Burst
			[373405] = {31.6},
			--Call Spiderlings
			[372238] = {2.4, 25.6},
		},
--		[7] = {--third move ending (reaching top and beginning p2)
--			--Chilling Blast
--			[371976] = {13.3, 32.9},
--			--Suffocating Webs
--			[372082] = {7.3, 30.4},
--			--Repelling Burst
--			[373405] = {30.4},
--			--Call Spiderlings
--			[372238] = {9.7, 30.5},
--		},--]]
	},
	["normal"] = {
		[1] = {
			--Chilling Blast
			[371976] = {16.1, 36.5, 37.7, 30.4, 36.5, 36.5, 26.6, 40.1},
			--Enveloping Webs
			[372082] = {18.5, 28, 29.1, 26.7, 20.6, 26.7, 30.3, 42.5, 27.9, 32.8},
			--Gossamer Burst
			[373405] = {33.2, 36.5, 68.1, 36.4, 64.8, 38.4},
			--Call Spiderlings
			[372238] = {2.7, 20.6, 20.7, 21.9, 20.6, 31.6, 26.7, 21.8, 20.7, 27.9, 20.6, 20.7, 20.6},
		},
		[2] = {
			--Chilling Blast
			[371976] = {16.6, 32.8},--Unused for now
			--Call Spiderlings
			[372238] = {14.2, 25.5, 25.5},--Unused for now
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(stickyStacks)
	self.vb.webIcon = 1
	self.vb.blastCount = 0
	self.vb.webCount = 0
	self.vb.burstCount = 0
	self.vb.rimeCast = 0
	self.vb.spiderlingsCount = 0
	self.vb.bigAddCount = 1--Starts at 1 because 1 is up with boss on pull
--	timerCallSpiderlingsCD:Start(1-delay, 1)--cast on engage
	timerChillingBlastCD:Start(15.2-delay, 1)
	timerEnvelopingWebsCD:Start(17.9-delay, 1)
	timerGossamerBurstCD:Start(33.9-delay, 1)
	timerPhaseCD:Start(43-delay)
	timerFrostbreathArachnidCD:Start(103.9, 2)--First one engages with boss
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(372030))
		DBM.InfoFrame:Show(20, "table", stickyStacks, 1)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	else
		difficultyName = "normal"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 371976 then
		self.vb.blastCount = self.vb.blastCount + 1
		--Seems to be cast 3 casts per movement, minus first, first started at movement, 2nd after first with longer cd then 3rd cast shorter cd after 2nd
		--Repeats on next movement
		--More consistent in stage 2
		--timerChillingBlastCD:Start(self.vb.phase == 2 and 32 or self.vb.blastCount == 1 and 36 or 22, self.vb.blastCount+1)
		if self.vb.phase == 2 then
			timerChillingBlastCD:Start(self:IsMythic() and self.vb.blastCount == 1 and 17 or 32, self.vb.blastCount+1)
		else
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.blastCount+1)
			if timer then
				timerChillingBlastCD:Start(timer, self.vb.blastCount+1)
			end
		end
	elseif spellId == 372082 then
		self.vb.webIcon = 1
		self.vb.webCount = self.vb.webCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.webCount+1)
		if timer then
			timerEnvelopingWebsCD:Start(timer, self.vb.webCount+1)
		end
	elseif spellId == 373405 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnGossamerBurst:Show(self.vb.burstCount)
		specWarnGossamerBurst:Play("pullin")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.burstCount+1)
		if timer then
			timerGossamerBurstCD:Start(timer, self.vb.burstCount+1)
		end
	elseif spellId == 374112 then
		if self:IsTanking("player", nil, nil, nil, args.sourceGUID) then
			specWarnFreezingBreath:Show()
			specWarnFreezingBreath:Play("defensive")
		end
		timerFreezingBreathCD:Start(nil, args.sourceGUID)
	elseif spellId == 372539 then
		warnApexofIce:Show()
	elseif spellId == 373027 then
		self.vb.webIcon = 1
		self.vb.webCount = self.vb.webCount + 1
		timerSuffocatingWebsCD:Start(nil, self.vb.webCount+1)
	elseif spellId == 371983 then
		self.vb.burstCount = self.vb.burstCount + 1
		specWarnRepellingBurst:Show(self.vb.burstCount)
		specWarnRepellingBurst:Play("carefly")
		timerRepellingBurstCD:Start(nil, self.vb.burstCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 372238 then
		self.vb.spiderlingsCount = self.vb.spiderlingsCount + 1
		warnCallSpiderlings:Show(self.vb.spiderlingsCount)
		if self.vb.phase == 2 then
			timerCallSpiderlingsCD:Start(self:IsMythic() and 30 or 25, self.vb.spiderlingsCount+1)
		else
			local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.spiderlingsCount+1)
			if timer then
				timerCallSpiderlingsCD:Start(timer, self.vb.spiderlingsCount+1)
			end
		end
	elseif spellId == 181113 then--Encounter Spawn
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		if cid == 189234 then--Frostbreath Arachnid
			self.vb.bigAddCount = self.vb.bigAddCount + 1
			warnFrostbreathArachnid:Show(self.vb.bigAddCount)
			timerFreezingBreathCD:Start(6, args.sourceGUID)
			if self.vb.bigAddCount < 3 then
				timerFrostbreathArachnidCD:Start(nil, self.vb.bigAddCount+1)--98.9
			end
		end
	elseif spellId == 396792 then
		self.vb.rimeCast = self.vb.rimeCast + 1
		specWarnGustingRime:Show(self.vb.rimeCast)
		specWarnGustingRime:Play("watchstep")
		timerGustingrimeCD:Start()
		--if self.vb.phase == 2 then
		--	timerGustingrimeCD:Start(25, self.vb.rimeCast+1)
		--else
		--	local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId, self.vb.rimeCast+1)
		--	if timer then
		--		timerGustingrimeCD:Start(timer, self.vb.rimeCast+1)
		--	end
		--end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 371976 then
		if args:IsPlayer() then
			specWarnChillingBlast:Show()
			specWarnChillingBlast:Play("runout")
			yellChillingBlast:Yell()
			yellChillingBlastFades:Countdown(spellId)
		end
		warnChillingBlast:CombinedShow(0.3, args.destName)
	elseif spellId == 372082 then
		local icon = self.vb.webIcon
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnEnvelopingWebs:Show(self:IconNumToTexture(icon))
			specWarnEnvelopingWebs:Play("mm"..icon)
			yellEnvelopingWebs:Yell(icon, icon)
			yellEnvelopingWebsFades:Countdown(spellId, nil, icon)
		end
		warnEnvelopingWebs:CombinedShow(0.5, args.destName)
		self.vb.webIcon = self.vb.webIcon + 1
	elseif spellId == 373048 then
		local icon = self.vb.webIcon
		if self.Options.SetIconOnSufWeb then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnSuffocatingWebs:Show(self:IconNumToTexture(icon))
			specWarnSuffocatingWebs:Play("mm"..icon)
			yellSuffocatingWebs:Yell(icon, icon)
			yellSuffocatingWebsFades:Countdown(spellId, nil, icon)
		end
		warnSuffocatinWebs:CombinedShow(0.5, args.destName)
		self.vb.webIcon = self.vb.webIcon + 1
	elseif spellId == 372030 then
		local amount = args.amount or 1
		stickyStacks[args.destName] = amount
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
		if args:IsPlayer() and (amount % 3 == 0) and amount >= 3 then
			specWarnStickyWebbing:Show(amount)
			specWarnStickyWebbing:Play("stackhigh")
		end
	elseif spellId == 372044 or spellId == 374104 then--Hard version, Easy version
		warnWrappedInWebs:CombinedShow(0.5, args.destName)
	elseif spellId == 385083 and not args:IsPlayer() and not DBM:UnitDebuff("player", spellId) then
		specWarnWebBlast:Show(args.destName)
		specWarnWebBlast:Play("tauntboss")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 371976 then
		if args:IsPlayer() then
			yellChillingBlastFades:Cancel()
		end
	elseif spellId == 372082 then
		if self.Options.SetIconOnWeb then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellEnvelopingWebsFades:Cancel()
		end
	elseif spellId == 373048 then
		if self.Options.SetIconOnSufWeb then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellSuffocatingWebsFades:Cancel()
		end
	elseif spellId == 372030 then
		stickyStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 372030 then
		stickyStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(stickyStacks, 0.2)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 372055 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 372539 then
		--announce interrupt
	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 189234 then--Frostbreath Arachnid
		self:SetStage(1)--Likely totally wrong
		timerFreezingBreathCD:Stop(args.destGUID)
	end
end

--"<2.19 23:28:07> [ENCOUNTER_START] 2592#Sennarth, The Cold Breath#15#20", -- [26]
--"<45.37 23:28:50> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<146.08 23:30:31> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<245.88 23:32:10> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\ICONS\\INV_MineSpider2_Crystal.blp:20|t %s begins to ascend!
--"<300.23 23:33:05> [CLEU] SPELL_CAST_START#Creature-0-2085-2522-14007-187967-000040998B#Sennarth<12.0%-3.0%>##nil#372539#Apex of Ice#nil#nil", -- [23406]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("INV_MineSpider2_Crystal.blp") then
--		self.vb.blastCount = 0
--		timerGossamerBurstCD:Stop()
--		timerChillingBlastCD:Stop()
		if self.vb.stageTotality == 1 then--First movement
			self:SetStage(1.25)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop stage 1 timers and basically restart them
			--Only first movement has delay on spiderlings, other movements summon them immediately
--			timerCallSpiderlingsCD:Stop()
--			timerChillingBlastCD:Start(10, 1)
--			timerCallSpiderlingsCD:Start(20)
--			timerGossamerBurstCD:Start(27.4, self.vb.burstCount+1)
--			timerPhaseCD:Start(99.8)--Til next movement
		elseif self.vb.stageTotality == 2 then--Second movement
			self:SetStage(1.5)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop stage 1 timers and basically restart them
--			timerChillingBlastCD:Start(16, 1)
--			timerGossamerBurstCD:Start(33, self.vb.burstCount+1)
--			timerPhaseCD:Start(98.5)--Til next movement
		else--Last movement
			self:SetStage(1.75)--Arbritrary phase numbers since journal classifies movements as intermissions and top as true stage 2
			--Stop them for last time, and not restart them, stage 2 soon
--			timerChillingBlastCD:Start(16, 1)
--			timerGossamerBurstCD:Start(33, self.vb.burstCount+1)
--			timerPhaseCD:Start(53.8)--Til Stage 2
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 372497 then--Eight Legs of Fury
		self:SetStage(2)
		self.vb.blastCount = 0
		self.vb.burstCount = 0
		self.vb.webCount = 0
		self.vb.spiderlingsCount = 0
		timerChillingBlastCD:Stop()
		timerEnvelopingWebsCD:Stop()
		timerGossamerBurstCD:Stop()
		timerCallSpiderlingsCD:Stop()
		timerFrostbreathArachnidCD:Stop()
		--Stage 2 timers start here, but if she's not interrupted within 12 seconds, they start to queue up and become messy
		--These may be wrong on several difficulties due to no viewable CLEU event on WCL yet to verify them
		timerCallSpiderlingsCD:Start(12.8, 1)
		timerChillingBlastCD:Start(15.3, 1)
		timerSuffocatingWebsCD:Start(22.7, 1)
		timerRepellingBurstCD:Start(32.7, 1)
		if self:IsMythic() then
			self.vb.rimeCast = 0
			timerGustingrimeCD:Start()
		end
	end
end
