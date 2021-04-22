local mod	= DBM:NewMod(2445, "DBM-SanctumOfDomination", nil, 1193)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(175727)
mod:SetEncounterID(2434)
mod:SetUsedIcons(1, 2, 3, 4)
--mod:SetHotfixNoticeRev(20201222000000)
--mod:SetMinSyncRevision(20201222000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 351779 350648 350422",
	"SPELL_CAST_SUCCESS 349985",
	"SPELL_AURA_APPLIED 352158 350650 354055 353429 350422 350448 350411 348985 350851 350647",
	"SPELL_AURA_APPLIED_DOSE 350422 350448",
	"SPELL_AURA_REMOVED 350650 354055 353429 350411 350647"
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, verify torment stuff and add faded warning if it doesn't go right into the recall
--TODO, Encore of torment may not have a valid timer. It's energy based but energy gains may be inconsistent based on mechanics?
--TODO, https://ptr.wowhead.com/spell=353137/summon-defiance-acolyte and https://ptr.wowhead.com/spell=350615/call-mawsworn
--TODO, https://ptr.wowhead.com/spell=352658/torment-shackles?
--TODO, add torment icons if it's not too many targets and a consistent behavior
--TODO, see how garrosh phases affect boss timers
--TODO, hellscream durations
--TODO, https://ptr.wowhead.com/spell=354231/soul-manacles tracking in some way?, depends how important it is (how many players are affected by it late fight)
--TODO, do more with rendered soul? https://ptr.wowhead.com/spell=351229/rendered-soul
--BOSS
--local warnExsanguinated					= mod:NewStackAnnounce(328897, 2, nil, "Tank|Healer")
local warnDefiance							= mod:NewTargetNoFilterAnnounce(350650, 3, nil, false)--Even with 1 second aggregation might be spammy based on add count, plus mythic
local warnBrandofTorment					= mod:NewTargetNoFilterAnnounce(350647, 3)
local warnRuinblade							= mod:NewStackAnnounce(350422, 2, nil, "Tank|Healer")
--Adds
local warnVesselofTorment					= mod:NewTargetNoFilterAnnounce(350851, 4)

--BOSS
local specWarnTorment						= mod:NewSpecialWarningDodge(352158, nil, nil, nil, 2, 2)
local specWarnEncoreofTorment				= mod:NewSpecialWarningDodge(349985, nil, nil, nil, 2, 2)
local specWarnBrandofTorment				= mod:NewSpecialWarningYou(350647, nil, nil, nil, 1, 2)
local yellBrandofTorment					= mod:NewYell(350647)
local specWarnRuinblade						= mod:NewSpecialWarningStack(350422, nil, 2, nil, nil, 1, 6)
local specWarnRuinbladeTaunt				= mod:NewSpecialWarningTaunt(350422, nil, nil, nil, 1, 2)
--Mawsworn Agonizer
local specWarnAgonizingSpike				= mod:NewSpecialWarningInterrupt(351779, false, nil, nil, 1, 2)--Opt in
--Garrosh Hellscream
local specWarnWarmongerShackles				= mod:NewSpecialWarningSwitch(348985, nil, nil, nil, 1, 2)
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(340324, nil, nil, nil, 1, 8)

--mod:AddTimerLine(BOSS)
local timerTormentCD						= mod:NewAITimer(23, 352158, nil, nil, nil, 3)
local timerEncoreofTormentCD				= mod:NewAITimer(23, 349985, nil, nil, nil, 3)
local timerBrandofTormentCD					= mod:NewAITimer(23, 350648, nil, nil, nil, 3)
local timerRuinbladeCD						= mod:NewAITimer(17.8, 350422, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
--Hellscream
local timerHellscream						= mod:NewCastTimer(23, 350411, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)

--local berserkTimer						= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("8")
mod:AddInfoFrameOption(352158, true)
mod:AddSetIconOption("SetIconOnBrandofTorment", 342077, true, false, {1, 2, 3, 4})
mod:AddNamePlateOption("NPAuraOnDefiance", 350650)
mod:AddNamePlateOption("NPAuraOnTormented", 353429)

mod.vb.brandIcon = 1

function mod:OnCombatStart(delay)
	self.vb.brandIcon = 1
	timerTormentCD:Start(1-delay)
	timerEncoreofTormentCD:Start(1-delay)
	timerBrandofTormentCD:Start(1-delay)
	timerRuinbladeCD:Start(1-delay)
--	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_L.INFOFRAME_POWER)
		DBM.InfoFrame:Show(3, "enemypower", 2)
	end
	if self.Options.NPAuraOnDefiance or self.Options.NPAuraOnTormented then
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
	if self.Options.NPAuraOnDefiance or self.Options.NPAuraOnTormented then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 351779 and self:CheckInterruptFilter(args.sourceGUID, false, false) then
		specWarnAgonizingSpike:Show(args.sourceName)
		specWarnAgonizingSpike:Play("kickcast")
	elseif spellId == 350648 then
		self.vb.brandIcon = 1
		timerBrandofTormentCD:Start()
	elseif spellId == 350422 then
		timerRuinbladeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 349985 then
		specWarnEncoreofTorment:Show()
		specWarnEncoreofTorment:Play("watchstep")
		timerEncoreofTormentCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 352158 then
		specWarnTorment:Show()
		specWarnTorment:Play("watchstep")
		timerTormentCD:Start()
	elseif spellId == 350650 or spellId == 354055 then--Reg adds, Mythic Adds
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
	elseif spellId == 353429 then--Tormented
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
	elseif spellId == 350411 then--Hellscream
		--TODO, hard code values when known for all difficulties
		local garroshUnitId = self:GetUnitIdFromGUID(args.destGUID)
		if garroshUnitId then
			local duration = DBM:UnitAura(garroshUnitId, spellId)
			timerHellscream:Start(duration or 50)
		end
	elseif spellId == 348985 then--Warmonger Shackles
		specWarnWarmongerShackles:Show()
		specWarnWarmongerShackles:Play("targetchange")
	elseif spellId == 350851 then
		warnVesselofTorment:CombinedShow(0.5, args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 350650 or spellId == 354055 then--Reg adds, Mythic Adds
		if self.Options.NPAuraOnDefiance then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 353429 then--Tormented
		if self.Options.NPAuraOnTormented then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 350411 then--Hellscream
		timerHellscream:Stop()
	elseif spellId == 350647 then
		if self.Options.SetIconOnBrandofTorment then
			self:SetIcon(args.destName, 0)
		end
--	elseif spellId == 348985 then--Warmonger Shackles

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 177594 then--mawsworn-agonizer

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

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 342074 then

	end
end
--]]
