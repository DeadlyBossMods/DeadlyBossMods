local mod	= DBM:NewMod(2532, "DBM-Raids-Dragonflight", 2, 1208)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(202375)
mod:SetEncounterID(2689)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20230718000000)
--mod:SetMinSyncRevision(20221215000000)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 406678 405812 405919 403978 405886",
	"SPELL_CAST_SUCCESS 404007 406725 405736 181113",
	"SPELL_AURA_APPLIED 405592 404010 404942",
	"SPELL_AURA_APPLIED_DOSE 404942",
	"SPELL_AURA_REMOVED 404010",
	"SPELL_DAMAGE 404955",
	"SPELL_MISSED 404955",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED"
)

--[[
(ability.id = 406678 or ability.id = 406725 or ability.id = 403978 or ability.id = 405812 or ability.id = 405919 or ability.id = 405886) and type = "begincast"
 or (ability.id = 404007 or ability.id = 406725 or ability.id = 405736) and type = "cast"
--]]
--TODO, icon method for golems will likely be changed to broodkeeper method since that's what BW is likely to use, but for testing purposes a basic incremental apply per set is probably fine
--TODO, GTFO for standing in fire traps
local warnSoakedShrapnal						= mod:NewAddsLeftAnnounce(406725, 2)
local warnScatterTraps							= mod:NewCountAnnounce(406725, 2)
local warnSalvageParts							= mod:NewTargetNoFilterAnnounce(405592, 1)
local warnSearingClaws							= mod:NewStackAnnounce(404942, 2, nil, "Tank|Healer")

local specWarnTacticalDestruction				= mod:NewSpecialWarningDodgeCount(406678, nil, nil, nil, 1, 2)
local specWarnDragonDeezTraps					= mod:NewSpecialWarningDodgeCount(405736, nil, nil, nil, 1, 2)
local specWarnAnimateGolems						= mod:NewSpecialWarningSwitchCount(405812, nil, nil, nil, 1, 2)
local specWarnActivateTrap						= mod:NewSpecialWarningInterruptCount(405919, "HasInterrupt", nil, nil, 1, 2)
local specWarnBlastWave							= mod:NewSpecialWarningCount(403978, nil, 149213, nil, 2, 2)
local specWarnUnstableEmbers					= mod:NewSpecialWarningMoveAway(404010, nil, nil, nil, 1, 2)
local yellUnstableEmbers						= mod:NewShortYell(404010)
local specWarnSearingClawsTaunt					= mod:NewSpecialWarningTaunt(404942, nil, nil, nil, 1, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(370648, nil, nil, nil, 1, 8)

local timerTacticalDestructionCD				= mod:NewCDCountTimer(61.5, 406678, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerShrapnalBombCD						= mod:NewCDCountTimer(42.5, 406725, 167180, nil, nil, 3)--"Bombs"
local timerShrapnalBomb							= mod:NewCastTimer(30, 406725, 185824, nil, nil, 2)--"Detonate"
local timerAnimateGolemsCD						= mod:NewCDCountTimer(60.2, 405812, nil, nil, nil, 1)
local timerBlastWaveCD							= mod:NewCDCountTimer(34, 403978, 149213, nil, nil, 2)--"Knockback"
local timerUnstableEmbersCD						= mod:NewCDCountTimer(20.7, 404010, 264364, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON)--"Embers"
local timerEliminationProtocol					= mod:NewCastTimer(10, 409942, 207544, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--"Beams"
local timerDragonDeezTrapsCD					= mod:NewCDCountTimer(32.2, 405736, nil, nil, nil, 3)
local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnGolems", 405812, true, 5, {8, 7, 6, 5})
mod:AddSetIconOption("SetIconOnEmbers", 404010, false, 0, {1, 2, 3, 4})

local castsPerGUID = {}
mod.vb.destructionCount = 0
mod.vb.shrapnalSoakCount = 0
mod.vb.trapCastCount = 0
mod.vb.golemsCount = 0
mod.vb.blastWaveCount = 0
mod.vb.embersCount = 0
mod.vb.dragonCount = 0
mod.vb.expectedBombs = 3
mod.vb.addIcon = 8

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.destructionCount = 0
	self.vb.shrapnalSoakCount = 0
	self.vb.trapCastCount = 0
	self.vb.golemsCount = 0
	self.vb.blastWaveCount = 0
	self.vb.embersCount = 0
	self.vb.dragonCount = 0
	timerBlastWaveCD:Start(10.7-delay, 1)--Same in All
	if self:IsMythic() then--Recheck
		self.vb.expectedBombs = 3
		timerUnstableEmbersCD:Start(9.1-delay, 1)
		timerDragonDeezTrapsCD:Start(19.2-delay, 1)
		timerAnimateGolemsCD:Start(26.2-delay, 1)
		timerTacticalDestructionCD:Start(31-delay, 1)
		timerShrapnalBombCD:Start(34-delay, 1)
	elseif self:IsHeroic() then--Validated
		self.vb.expectedBombs = 3
		timerUnstableEmbersCD:Start(7-delay, 1)
		timerDragonDeezTrapsCD:Start(19.3-delay, 1)
		timerShrapnalBombCD:Start(33.9-delay, 1)
		timerAnimateGolemsCD:Start(54.6-delay, 1)
		timerTacticalDestructionCD:Start(60.7-delay, 1)
	elseif self:IsNormal() then--Validated
		self.vb.expectedBombs = 2
		timerDragonDeezTrapsCD:Start(15.7-delay, 1)
		timerAnimateGolemsCD:Start(35-delay, 1)
		timerShrapnalBombCD:Start(45.1-delay, 1)
		timerTacticalDestructionCD:Start(70-delay, 1)
	else--Validated
		self.vb.expectedBombs = 2
		timerDragonDeezTrapsCD:Start(20.3-delay, 1)
		timerAnimateGolemsCD:Start(35-delay, 1)
		timerTacticalDestructionCD:Start(70-delay, 1)
	end
	berserkTimer:Start(510-delay)--Confirm in LFR
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 406678 then
		self.vb.destructionCount = self.vb.destructionCount + 1
		specWarnTacticalDestruction:Show(self.vb.destructionCount)
		specWarnTacticalDestruction:Play("watchstep")
		timerTacticalDestructionCD:Start(71.6, self.vb.destructionCount+1)--Mythic might be 72.8 now
	elseif spellId == 405812 then
		self.vb.addIcon = 8
		self.vb.golemsCount = self.vb.golemsCount + 1
		specWarnAnimateGolems:Show(self.vb.golemsCount)
		specWarnAnimateGolems:Play("killmobs")
		timerAnimateGolemsCD:Start(73, self.vb.golemsCount+1)--Can get spell queued up to 78
	elseif spellId == 405919 or spellId == 405886 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
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
		timerBlastWaveCD:Start(self:IsEasy() and 38 or 33.2, self.vb.blastWaveCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 404007 then
		self.vb.embersCount = self.vb.embersCount + 1
		timerUnstableEmbersCD:Start(15.7, self.vb.embersCount+1)
		if self:IsMythic() then
			timerEliminationProtocol:Start()
		end
	elseif spellId == 406725 then
		self.vb.shrapnalSoakCount = 0
		self.vb.trapCastCount = self.vb.trapCastCount + 1
		warnScatterTraps:Show(self.vb.trapCastCount)
		timerShrapnalBombCD:Start(self:IsMythic() and 45.3 or 30.3, self.vb.trapCastCount+1)
		timerShrapnalBomb:Start()
	elseif spellId == 405736 then
		self.vb.dragonCount = self.vb.dragonCount + 1
		specWarnDragonDeezTraps:Show(self.vb.dragonCount)
		specWarnDragonDeezTraps:Play("watchstep")
		timerDragonDeezTrapsCD:Start(self:IsMythic() and 34 or self:IsEasy() and 35 or 30.4, self.vb.dragonCount)
	elseif spellId == 181113 then--Encounter Spawn
		if self.Options.SetIconOnGolems then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, nil, 12, "SetIconOnGolems")
		end
		self.vb.addIcon = self.vb.addIcon - 1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 405592 then
		warnSalvageParts:Show(args.destName)--Aggregate?
	elseif spellId == 404010 then
		if args:IsPlayer() then
			specWarnUnstableEmbers:Show()
			specWarnUnstableEmbers:Play("range5")
			yellUnstableEmbers:Yell()
		end
		if self.Options.SetIconOnEmbers then
			self:SetUnsortedIcon(0.3, args.destName, 1, 4, false)
		end
	elseif spellId == 404942 and not args:IsPlayer() then
		local amount = args.amount or 1
		if amount % 3 == 0 then--Guessed, Filler
			if amount >= 6 and not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
				specWarnSearingClawsTaunt:Show(args.destName)
				specWarnSearingClawsTaunt:Play("tauntboss")
			else
				warnSearingClaws:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 404010 then
		if self.Options.SetIconOnEmbers then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 404955 then
		self.vb.shrapnalSoakCount = self.vb.shrapnalSoakCount + 1
		warnSoakedShrapnal:Show(self.vb.expectedBombs - self.vb.shrapnalSoakCount)
		if self.vb.shrapnalSoakCount == self.vb.expectedBombs then
			timerShrapnalBomb:Stop()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

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
