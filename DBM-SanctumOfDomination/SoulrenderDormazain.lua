local mod	= DBM:NewMod(2445, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175727)
mod:SetEncounterID(2434)
mod:SetUsedIcons(1, 2, 3, 4)
mod:SetHotfixNoticeRev(20210706000000)--2021-07-06
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 351779 350422 350615 350411 350415",
	"SPELL_CAST_SUCCESS 349985 350648",
	"SPELL_AURA_APPLIED 350650 354055 350649 350422 350448 350647 351773",
	"SPELL_AURA_APPLIED_DOSE 350422 350448",
	"SPELL_AURA_REMOVED 350650 354055 350649 350647 351773 350415",
	"SPELL_AURA_REMOVED_DOSE 350415",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, https://ptr.wowhead.com/spell=353137/summon-defiance-acolyte and https://ptr.wowhead.com/spell=350615/call-mawsworn
--TODO, https://ptr.wowhead.com/spell=352658/torment-shackles?
--TODO, hellscream durations for all difficulties
--TODO, https://ptr.wowhead.com/spell=354231/soul-manacles tracking in some way?, depends how important it is (how many players are affected by it late fight)
--TODO, do more with rendered soul? https://ptr.wowhead.com/spell=351229/rendered-soul
--TODO, do anything with Vessle of Torment?
--TODO, keep eye on timers. sequencing doesn't work. this may need SLG treatment if fight merits it. It's kind of an easy fight though so it may not be worth the effort
--[[
(ability.id = 350422 or ability.id = 350615 or ability.id = 350411 or ability.id = 350415) and type = "begincast"
 or (ability.id = 350648 or ability.id = 349985) and type = "cast"
 or ability.id = 351194 and type = "applydebuff"
 or ability.id = 350415 and type = "removebuff"
--]]
--BOSS
local warnDefiance							= mod:NewTargetNoFilterAnnounce(350650, 3, nil, false)--Even with 1 second aggregation might be spammy based on add count, plus mythic
local warnBrandofTorment					= mod:NewTargetNoFilterAnnounce(350647, 3)
local warnRuinblade							= mod:NewStackAnnounce(350422, 2, nil, "Tank|Healer")
local warnShacklesRemaining					= mod:NewCountAnnounce(350415, 1)
--Adds
local warnSpawnMawsworn						= mod:NewCountAnnounce(350615, 3)
--local warnVesselofTorment					= mod:NewTargetNoFilterAnnounce(350851, 4)--FIXME

--BOSS
local specWarnTorment						= mod:NewSpecialWarningDodge(352158, nil, nil, nil, 2, 2)
local specWarnTormentedEruptions			= mod:NewSpecialWarningDodge(349985, nil, nil, nil, 2, 2)
local specWarnBrandofTorment				= mod:NewSpecialWarningYou(350647, nil, nil, nil, 1, 2)
local yellBrandofTorment					= mod:NewYell(350647)
local specWarnRuinblade						= mod:NewSpecialWarningStack(350422, nil, 2, nil, nil, 1, 6)
local specWarnRuinbladeTaunt				= mod:NewSpecialWarningTaunt(350422, nil, nil, nil, 1, 2)
--Mawsworn Agonizer
local specWarnAgonizingSpike				= mod:NewSpecialWarningInterruptCount(351779, "false", nil, nil, 1, 2)--Opt in
--Garrosh Hellscream
local specWarnWarmongerShackles				= mod:NewSpecialWarningSwitch(348985, nil, nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerTormentCD						= mod:NewCDTimer(35, 352158, nil, nil, nil, 3, nil, nil, true)--Ability is reset by eruption
local timerTormentedEruptionsCD				= mod:NewCDTimer(160.7, 349985, nil, nil, nil, 3, nil, nil, true)--Tied to bosses energy cycle
local timerSpawnMawswornCD					= mod:NewCDTimer(57.5, 350615, nil, nil, nil, 1, nil, nil, true)--Ability is reset by eruption
local timerBrandofTormentCD					= mod:NewCDCountTimer(16, 350648, nil, nil, nil, 3)--Secondary ability cast in 3s after each spawn mawsworn
local timerRuinbladeCD						= mod:NewCDTimer(32.9, 350422, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Ability is reset by eruption
--local timerShacklesCD						= mod:NewCDTimer(161, 350415, nil, nil, nil, 6)--Tied to bosses energy cycle
--Hellscream
local timerHellscream						= mod:NewCastTimer(35, 350411, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(352158, true)
mod:AddSetIconOption("SetIconOnBrandofTorment", 342077, true, false, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnMawsworn", 350615, true, true, {5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnDefiance", 350650)
mod:AddNamePlateOption("NPAuraOnTormented", 350649)

local castsPerGUID = {}
--"Warmonger's Shackles-350415-npc:175727 = pull:35.3, 134.0, 64.4, 62.0", -- [6]
--TODO, sequencing is NOT the final answer. This may be temporary. there is a better way.
--What's known
--eruption resets timers
--Shackles probably affects timers in some way but can't determine it since the affect is more than just "resets on applied/removed"
--However, duration of the phase DOES matter yet the timers don't pause either
mod.vb.shacklesCount = 0
mod.vb.brandIcon = 1
mod.vb.mawswornSpawn = 0
mod.vb.mawswornIcon = 8
mod.vb.brandCount = 0

--Assume these won't be exposed forever
--"<7453.53 00:02:38> [CLEU] SPELL_CAST_SUCCESS#Creature-0-2012-2450-10555-178915-000015B87A#Cosmetic Anima Missile Stalker##nil#353048#Torment Missile C#nil#nil", -- [131256]
--"<7408.51 00:01:53> [CLEU] SPELL_CAST_SUCCESS#Creature-0-2012-2450-10555-178915-000015B87A#Cosmetic Anima Missile Stalker##nil#353049#Torment Missile D#nil#nil", -- [129907]

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.shacklesCount = 0
	self.vb.brandIcon = 1
	self.vb.mawswornSpawn = 0
	self.vb.mawswornIcon = 8
	self.vb.brandCount = 0
	timerRuinbladeCD:Start(8.1-delay)
	timerTormentCD:Start(11.8-delay)
	timerBrandofTormentCD:Start(31.4-delay)
--	timerShacklesCD:Start(78.4-delay, 1)--Probably only one in entirety of fight that's somewhat consistent, but don't want to have timer for first and not rest, only leads to more questions
	timerTormentedEruptionsCD:Start(130.5-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnDefiance or self.Options.NPAuraOnTormented then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	DBM:AddMsg("There is no Hellscream/shackles timer because it wouldn't be accurate. If blizz scripts fight better, I'll add a timer")
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.NPAuraOnDefiance or self.Options.NPAuraOnTormented then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351779 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
--			if self.Options.SetIconOnMawsworn and self.vb.addIcon > 3 then--Only use up to 5 icons
--				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 12, "SetIconOnMawsworn")
--			end
--			self.vb.addIcon = self.vb.addIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnAgonizingSpike:Show(args.sourceName, count)
			if count == 1 then
				specWarnAgonizingSpike:Play("kick1r")
			elseif count == 2 then
				specWarnAgonizingSpike:Play("kick2r")
			elseif count == 3 then
				specWarnAgonizingSpike:Play("kick3r")
			elseif count == 4 then
				specWarnAgonizingSpike:Play("kick4r")
			elseif count == 5 then
				specWarnAgonizingSpike:Play("kick5r")
			else
				specWarnAgonizingSpike:Play("kickcast")
			end
		end
	elseif spellId == 350422 then
		timerRuinbladeCD:Start()
	elseif spellId == 350615 then
		self.vb.mawswornIcon = 8
		self.vb.brandCount = 0
		self.vb.mawswornSpawn = self.vb.mawswornSpawn + 1
		warnSpawnMawsworn:Show(self.vb.mawswornSpawn)
		timerSpawnMawswornCD:Start(self:IsMythic() and 47.7 or 57.5)
		if self.Options.SetIconOnMawsworn then--This icon method may be faster than GUID matching, but also risks being slower and less consistent if marker has nameplates off
			self:ScanForMobs(177594, 0, 8, 4, 0.2, 12, "SetIconOnMawsworn")
		end
	elseif spellId == 350411 then--Hellscream
		timerHellscream:Start(self:IsHeroic() and 35 or self:IsMythic() and 25 or 50)--Heroic and mythic known, other difficulties not yet
	elseif spellId == 350415 then--Warmonger Shackles
		self.vb.shacklesCount = self.vb.shacklesCount + 1
		specWarnWarmongerShackles:Show(self.vb.shacklesCount)
		specWarnWarmongerShackles:Play("targetchange")
--		timerShacklesCD:Start(999, self.vb.shacklesCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 349985 then
		specWarnTormentedEruptions:Show()
		specWarnTormentedEruptions:Play("watchstep")
		timerTormentedEruptionsCD:Start()
		timerSpawnMawswornCD:Stop()
		timerTormentCD:Stop()
		timerRuinbladeCD:Stop()
		timerBrandofTormentCD:Stop()
		timerBrandofTormentCD:Start(32.8)
		timerRuinbladeCD:Start(38.9)
		timerTormentCD:Start(41.3)--42-51 after eruption
		timerSpawnMawswornCD:Start(53.7)--53.7-60 after an eruption
	elseif spellId == 350648 then
		self.vb.brandIcon = 1
		self.vb.brandCount = self.vb.brandCount + 1
		timerBrandofTormentCD:Start(15.7, self.vb.brandCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 350650 or spellId == 351773 or spellId == 354055 then--Reg adds, reg adds, Mythic Adds (351773 heroic confirmed, 354055 mythic confirmed)
		warnDefiance:CombinedShow(0.5, args.destName)
		if self.Options.NPAuraOnDefiance then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350647 then
		local icon = self.vb.brandIcon
		if self.Options.SetIconOnBrandofTorment then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnBrandofTorment:Show()
			specWarnBrandofTorment:Play("targetyou")
			yellBrandofTorment:Yell()--icon, icon
		end
		warnBrandofTorment:CombinedShow(0.3, args.destName)
		self.vb.brandIcon = self.vb.brandIcon + 1
	elseif spellId == 350649 then--Tormented
		if self.Options.NPAuraOnTormented then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350422 or spellId == 350448 then
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnRuinblade:Show(amount)
				specWarnRuinblade:Play("stackhigh")
			else
				if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then
					specWarnRuinbladeTaunt:Show(args.destName)
					specWarnRuinbladeTaunt:Play("tauntboss")
				else
					warnRuinblade:Show(args.destName, amount)
				end
			end
		else
			warnRuinblade:Show(args.destName, amount)
		end
--	elseif spellId == 350851 then
--		warnVesselofTorment:CombinedShow(0.5, args.destName)
--	elseif spellId == 350766 then--Pain (earliest CLEU torment detection)
--		specWarnTorment:Show()
--		specWarnTorment:Play("watchstep")
--		timerTormentCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350650 or spellId == 351773 or spellId == 354055 then--Reg adds, Mythic Adds
		if self.Options.NPAuraOnDefiance then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350649 then--Tormented
		if self.Options.NPAuraOnTormented then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350411 then--Hellscream
		timerHellscream:Stop()
	elseif spellId == 350647 then
		if self.Options.SetIconOnBrandofTorment then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 350415 then--Warmonger Shackles
		timerHellscream:Stop()
		warnShacklesRemaining:Show(0)
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 350415 then
		warnShacklesRemaining:Show(args.amount)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177594 then--mawsworn-agonizer
		castsPerGUID[args.destGUID] = nil
	end
end

--https://ptr.wowhead.com/npc=177594/mawsworn-agonizer

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 340324 and destGUID == UnitGUID("player") and not playerDebuff and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 349873 then--Torment (Script Activation)
		specWarnTorment:Show()
		specWarnTorment:Play("watchstep")
		timerTormentCD:Start(self:IsMythic() and 30 or 45)--Mythic can be anywhere between 30-49 outside of the eruption reset
	end
end
