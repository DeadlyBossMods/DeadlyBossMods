local dungeonID, creatureID, creatureID2
if UnitFactionGroup("player") == "Alliance" then
	dungeonID, creatureID, creatureID2 = 2323, 144691, 144692--Ma'ra Grimfang and Anathos Firecaller
else--Horde
	dungeonID, creatureID, creatureID2 = 2341, 144693, 144690--Manceroy Flamefist and the Mestrah <the Illuminated>
end
local mod	= DBM:NewMod(dungeonID, "DBM-ZuldazarRaid", 1, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(creatureID, creatureID2)
mod:SetEncounterID(2266, 2285)--2266 horde, 2285 Alliance
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 284399 285428",
	"SPELL_CAST_SUCCESS 282030",
	"SPELL_AURA_APPLIED 282037 285632 286425 286988",
	"SPELL_AURA_APPLIED_DOSE 282037",
	"SPELL_AURA_REMOVED 282037 285632 286425 286988",
--	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, infoframe for showing balance of Harmonios Spirits?
--TODO, add Spinning Crane Kick? seems like an anti kite/no tank mechanic for most part
--TODO, Multi Sided Strike, figure out how to warn each image?
--TODO, improve spirits of Xuen warning when see how many go out, who has to switch, who should switch
--TODO, figure out optimal lowest stacks possible for swapping rising flames
--TODO, obviously boss swaps and stuff
--TODO, bomb spawn count and bombs remaining warning
--TODO, remaining transformations, kind of hard to drycode those as the triggers for those phases aren't same as abilities they spam during those phases.
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Monk
local warnSpiritsofXuen					= mod:NewSpellAnnounce(285647, 2)
--Mage
local warnRisingFlames					= mod:NewStackAnnounce(282037, 2, nil, "Tank")
local warnShield						= mod:NewTargetNoFilterAnnounce(286425, 4)
--local warnMagmaTrap						= mod:NewCountAnnounce(284374, 4)
--Team Attacks

local specWarnMultiSidedStrike			= mod:NewSpecialWarningYou(282030, nil, nil, nil, 3, 2)
local specWarnStalking					= mod:NewSpecialWarningYou(285632, nil, nil, nil, 1, 2)
local yellStalking						= mod:NewYell(285632)
--Mage
local specWarnRisingFlames				= mod:NewSpecialWarningStack(282037, nil, 2, nil, nil, 1, 6)
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(282037, nil, nil, nil, 1, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
local yellRisingFlamesFades				= mod:NewShortFadesYell(282037)
local specWarnShield					= mod:NewSpecialWarningTargetChange(286425, false, nil, nil, 1, 2)
local specWarnPyroblast					= mod:NewSpecialWarningInterrupt(286379, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingEmbers				= mod:NewSpecialWarningYou(286988, nil, nil, nil, 1, 2)
local yellSearingEmbers					= mod:NewYell(286988)
local yellSearingEmbersFades			= mod:NewShortFadesYell(286988)
--local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, false, nil, 4, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--Team Attacks
local specWarnFirefromMist				= mod:NewSpecialWarningSwitch(285428, nil, nil, nil, 2, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--local timerDarkRevolationCD			= mod:NewCDCountTimer(55, 273365, nil, nil, nil, 3)
local timerMultiSidedStrikeCD			= mod:NewCDTimer(35.2, 282030, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSpiritsofXuenCD				= mod:NewCDTimer(40.1, 285645, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
--Mage
local timerShieldCD						= mod:NewCDTimer(13.4, 286425, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)
local timerSearingEmbersCD				= mod:NewCDTimer(15.8, 286988, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_HEALER_ICON)--15.8-29.2?
--local timerMagmaTrapCD					= mod:NewAITimer(55, 284374, nil, nil, nil, 5)
--Team Attacks

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconEmbers", 286988, true)
--mod:AddRangeFrameOption("8/10")
mod:AddInfoFrameOption(281959, true)
mod:AddNamePlateOption("NPAuraOnFixate", 268074)
mod:AddNamePlateOption("NPAuraOnExplosion", 284399)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

mod.vb.phase = 1
mod.vb.shieldsActive = 0
mod.vb.embersIcon = 0
--mod.vb.magmaTrapCount = 0

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.shieldsActive = 0
	self.vb.embersIcon = 0
	--self.vb.magmaTrapCount = 0
	timerSearingEmbersCD:Start(9.5)
	timerShieldCD:Start(10.5-delay)
	timerMultiSidedStrikeCD:Start(15.6-delay)
	timerSpiritsofXuenCD:Start(25.5-delay)
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnExplosion then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
		DBM.InfoFrame:Show(4, "enemypower", 2)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnFixate or self.Options.NPAuraOnExplosion then
		DBM.Nameplate:Hide(false, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 284399 then
		if self.Options.NPAuraOnExplosion then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
		end
	elseif spellId == 285428 then
		specWarnFirefromMist:Show()
		specWarnFirefromMist:Play("attbomb")
--	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnBloodshard:Show(args.sourceName)
--		specWarnBloodshard:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282030 then
		if args:IsPlayer() then
			specWarnMultiSidedStrike:Show()--So show tank warning
			specWarnMultiSidedStrike:Play("targetyou")
		end
		timerMultiSidedStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282037 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 5 then
				if args:IsPlayer() then
					specWarnRisingFlames:Show(amount)
					specWarnRisingFlames:Play("stackhigh")
					yellRisingFlamesFades:Cancel()
					yellRisingFlamesFades:Countdown(10)
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
						specWarnRisingFlamesOther:Show(args.destName)
						specWarnRisingFlamesOther:Play("tauntboss")
					else
						warnRisingFlames:Show(args.destName, amount)
					end
				end
			else
				warnRisingFlames:Show(args.destName, amount)
			end
		end
	elseif spellId == 285632 then
		if args:IsPlayer() then
			specWarnStalking:Show()
			specWarnStalking:Play("targetyou")
			yellStalking:Yell()
			if self.Options.NPAuraOnFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 286425 then
		self.vb.shieldsActive = self.vb.shieldsActive + 1
		if self.Options.SpecWarn286425switch2 then
			specWarnShield:Show(args.destName)
			specWarnShield:Play("targetchange")
		else
			warnShield:Show(args.destName)
		end
		timerShieldCD:Start()
		if self.Options.InfoFrame and self.vb.shieldsActive == 1 then
			for i = 1, 2 do
				local bossUnitID = "boss"..i
				if UnitGUID(bossUnitID) == args.sourceGUID then--Identify correct unit ID
					DBM.InfoFrame:SetHeader(args.spellName)
					DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs(bossUnitID))
					break
				end
			end
		end
	elseif spellId == 286988 then
		self.vb.embersIcon = self.vb.embersIcon + 1
		if args:IsPlayer() then
			specWarnSearingEmbers:Show()
			specWarnSearingEmbers:Play("targetyou")
			yellSearingEmbers:Yell()
			yellSearingEmbersFades:Countdown(10)
		end
		if self.Options.SetIconEmbers then
			self:SetIcon(args.destName, self.vb.embersIcon)
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282037 then
		if args:IsPlayer() then
			yellRisingFlamesFades:Cancel()
		end
	elseif spellId == 285632 then
		if self.Options.NPAuraOnFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 286425 then
		self.vb.shieldsActive = self.vb.shieldsActive - 1
		specWarnPyroblast:Show(args.destName)
		specWarnPyroblast:Play("kickcast")
		if self.Options.InfoFrame and self.vb.shieldsActive == 0 then
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 286988 then
		if args:IsPlayer() then
			yellSearingEmbersFades:Cancel()
		end
		if self.Options.SetIconEmbers then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 147069 then--spirit-of-xuen

	elseif cid == 146107 then--Living Bomb
		if self.Options.NPAuraOnExplosion then
			DBM.Nameplate:Hide(true, args.destGUID, 284399)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 284373 then--Magma Trap
		--self.vb.magmaTrapCount = self.vb.magmaTrapCount + 1
		--warnMagmaTrap:Show(self.vb.magmaTrapCount)
		--timerMagmaTrapCD:Start()
	elseif spellId == 285645 then
		warnSpiritsofXuen:Show()
		timerSpiritsofXuenCD:Start()
	elseif spellId == 286987 then--Searing Embers
		self.vb.embersIcon = 0
		timerSearingEmbersCD:Start()
	end
end
