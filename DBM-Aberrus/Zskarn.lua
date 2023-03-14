local mod	= DBM:NewMod(2532, "DBM-Aberrus", nil, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetCreatureID(184972)
mod:SetEncounterID(2689)
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20230313000000)
--mod:SetMinSyncRevision(20221215000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 406678 405812 405919 403978",--406725
	"SPELL_CAST_SUCCESS 404007",
	"SPELL_SUMMON 405816",
	"SPELL_AURA_APPLIED 404955 405592 404010 404942",
	"SPELL_AURA_APPLIED_DOSE 404942",
	"SPELL_AURA_REMOVED 404010",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, figure out how to alert for https://www.wowhead.com/ptr/spell=405462/dragonfire-traps . This seems more like a unit frame thing right now and not a boss mod thing. it might also not even be in fight anymore
--TODO, tactical destruction seems to be a sequence of casts from 15 yards to 60 yards based on scripts. Maybe detect entire sequence and not just activation?
--TODO, Shrapnal debuff on all players (failed to tank soak) https://www.wowhead.com/ptr/spell=404959/shrapnel-bomb
--TODO, shrapnal 30 second counter? https://www.wowhead.com/ptr/spell=404957/shrapnel-bomb
--TODO, review tank swaps. I suspect they'll revolve around trap timer though and not debuff stacks. but it depends, could also end up that same tank always does traps cause 2 swaps per trap set or extreme case both tanks need to do traps so swaps come fast
--TODO, icon method for golems will likely be changed to broodkeeper method since that's what BW is likely to use, but for testing purposes a basic incremental apply per set is probably fine
--TODO, does Salvage parts get removed on using once, or lasts full 1 minute duration? Does the one without duration get used?
--TODO, taunt swap stacks.
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(26001))
local warnSoakedShrapnal						= mod:NewCountAnnounce(404955, 2)
local warnScatterTraps							= mod:NewCountAnnounce(404533, 2)
local warnSalvageParts							= mod:NewTargetNoFilterAnnounce(405592, 1)
local warnSearingClaws							= mod:NewStackAnnounce(404942, 2, nil, "Tank|Healer")

local specWarnTacticalDestruction				= mod:NewSpecialWarningDodgeCount(406678, nil, nil, nil, 1, 2)
local specWarnAnimateGolems						= mod:NewSpecialWarningSwitchCount(405812, nil, nil, nil, 1, 2)
local specWarnActivateTrap						= mod:NewSpecialWarningInterruptCount(405919, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlastWave							= mod:NewSpecialWarningCount(403978, nil, nil, nil, 2, 2)
local specWarnUnstableEmbers					= mod:NewSpecialWarningMoveAway(404007, nil, nil, nil, 1, 2)
local yellUnstableEmbers						= mod:NewShortYell(404007)
--local specWarnSearingClawsTaunt					= mod:NewSpecialWarningTaunt(404942, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerTacticalDestructionCD				= mod:NewAITimer(28.9, 406678, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerScatterTrapsCD						= mod:NewAITimer(29.9, 404533, nil, nil, nil, 3)
--local timerShrapnalBombCD						= mod:NewAITimer(29.9, 406725, nil, nil, nil, 3)--Backup
local timerAnimateGolemsCD						= mod:NewAITimer(29.9, 405812, nil, nil, nil, 1)
local timerBlastWaveCD							= mod:NewAITimer(29.9, 403978, nil, nil, nil, 2)
local timerUnstableEmbersCD						= mod:NewAITimer(29.9, 404007, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)
--local berserkTimer							= mod:NewBerserkTimer(600)

--mod:AddInfoFrameOption(405462, false)
mod:AddRangeFrameOption(5, 404007)
mod:AddSetIconOption("SetIconOnGolems", 404533, true, 5, {8, 7, 6})
mod:AddSetIconOption("SetIconOnEmbers", 404007, true, 0, {1, 2, 3, 4})
--mod:AddNamePlateOption("NPAuraOnAscension", 385541)
--mod:GroupSpells(390715, 396094)

local castsPerGUID = {}
mod.vb.destructionCount = 0
mod.vb.shrapnalSoakCount = 0
mod.vb.trapCastCount = 0
mod.vb.golemsCount = 0
mod.vb.addIcon = 8
mod.vb.blastWaveCount = 0

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.destructionCount = 0
	self.vb.shrapnalSoakCount = 0
	self.vb.trapCastCount = 0
	self.vb.golemsCount = 0
	self.vb.addIcon = 8
	self.vb.blastWaveCount = 0
	timerTacticalDestructionCD:Start(1-delay)
	timerScatterTrapsCD:Start(1-delay)
	--timerShrapnalBombCD:Start(1-delay)
	timerAnimateGolemsCD:Start(1-delay)
	timerBlastWaveCD:Start(1-delay)
	timerUnstableEmbersCD:Start(1-delay)
--	if self.Options.NPAuraOnAscension then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
--	if self.Options.NPAuraOnAscension then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end


function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 406678 then
		self.vb.destructionCount = self.vb.destructionCount + 1
		specWarnTacticalDestruction:Show(self.vb.destructionCount)
		specWarnTacticalDestruction:Play("watchstep")
		timerTacticalDestructionCD:Start()
--	elseif spellId == 406725 then
		--timerShrapnalBombCD:Start()
	elseif spellId == 405812 then
		self.vb.addIcon = 8
		self.vb.golemsCount = self.vb.golemsCount + 1
		specWarnAnimateGolems:Show(self.vb.golemsCount)
		specWarnAnimateGolems:Play("killmobs")
		timerAnimateGolemsCD:Start()
	elseif spellId == 405919 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnGolems  then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGolems")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnActivateTrap:Show(args.sourceName, count)
			if count < 6 then
				specWarnActivateTrap:Play("kick"..count.."r")
			else
				specWarnActivateTrap:Play("kickcast")
			end
		end
	elseif spellId == 403978 then
		self.vb.blastWaveCount = self.vb.blastWaveCount + 1
		specWarnBlastWave:Show(self.vb.blastWaveCount)
		specWarnBlastWave:Play("carefly")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 404007 then
		timerUnstableEmbersCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 405816 then--Dragonfire Golem
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnGolems then
				self:ScanForMobs(args.destGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGolems")
			end
			self.vb.addIcon = self.vb.addIcon - 1
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 404955 then
		self.vb.shrapnalSoakCount = self.vb.shrapnalSoakCount + 1
		warnSoakedShrapnal:Show(self.vb.shrapnalSoakCount)
	elseif spellId == 405592 then
		warnSalvageParts:Show(args.destName)--Aggregate?
	elseif spellId == 404010 then
		if args:IsPlayer() then
			specWarnUnstableEmbers:Show()
			specWarnUnstableEmbers:Play("range5")
			yellUnstableEmbers:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
		if self.Options.SetIconOnEmbers then
			self:SetUnsortedIcon(0.3, args.destName, 1, 4, false)
		end
	elseif spellId == 404942 and not args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 3 == 0 then--Guessed, Filler
--			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--			local remaining
--			if expireTime then
--				remaining = expireTime-GetTime()
--			end
--			if amount >= 2 and (not remaining or remaining and remaining < 6.1) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--				specWarnSearingClawsTaunt:Show(args.destName)
--				specWarnSearingClawsTaunt:Play("tauntboss")
--			else
				warnSearingClaws:Show(args.destName, amount)
--			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 404010 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.SetIconOnEmbers then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 370648 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 203230 then--Dragonfire Golem
		castsPerGUID[args.destGUID] = nil
	end
end

--https://www.wowhead.com/ptr/spell=404533/scatter-traps possibly this script for both bombs?
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 404533 and self:AntiSpam(5, 1) then
		self.vb.shrapnalSoakCount = 0
		self.vb.trapCastCount = self.vb.trapCastCount + 1
		warnScatterTraps:Show(self.vb.trapCastCount)
		timerScatterTrapsCD:Start()
	end
end
