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
	"SPELL_CAST_START 284399 285428 282040 282030 285818",
	"SPELL_CAST_SUCCESS 282030",
	"SPELL_AURA_APPLIED 282037 285632 286425 286988 284656",
	"SPELL_AURA_APPLIED_DOSE 282037",
	"SPELL_AURA_REMOVED 282037 285632 286425 286988 284656",
	"CHAT_MSG_MONSTER_EMOTE",
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
--[[
(ability.id = 285428 or ability.id = 282040 or ability.id = 285818) and type = "begincast"
or ability.id = 282030 and type = "cast"
or ability.id = 286425 and type = "applybuff"
or ability.id = 284656
or (ability.id = 286988 or ability.id = 285632) and type = "applydebuff"
--]]
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Monk
local warnSpiritsofXuen					= mod:NewSpellAnnounce(285647, 2)
--Mage
local warnRisingFlames					= mod:NewStackAnnounce(282037, 2, nil, "Tank")
local warnShield						= mod:NewTargetNoFilterAnnounce(286425, 4)
local warnMagmaTrap						= mod:NewCountAnnounce(284374, 4)
--Team Attacks
local warnTransforms					= mod:NewSpellAnnounce(282040, 2)

local specWarnMultiSidedStrikeAll		= mod:NewSpecialWarningSpell(285818, nil, nil, nil, 3, 2)
local specWarnMultiSidedStrike			= mod:NewSpecialWarningYou(282030, nil, nil, nil, 3, 2)
local specWarnStalking					= mod:NewSpecialWarningYou(285632, nil, nil, nil, 1, 2)
local yellStalking						= mod:NewYell(285632)
--Mage
local specWarnRisingFlames				= mod:NewSpecialWarningStack(282037, nil, 6, nil, nil, 1, 6)
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(282037, nil, nil, nil, 1, 2)
--local yellDarkRevolation				= mod:NewPosYell(273365)
local yellRisingFlamesFades				= mod:NewShortFadesYell(282037)
local specWarnShield					= mod:NewSpecialWarningTargetChange(286425, false, nil, nil, 1, 2)
local specWarnPyroblast					= mod:NewSpecialWarningInterrupt(286379, "HasInterrupt", nil, nil, 1, 2)
local specWarnSearingEmbers				= mod:NewSpecialWarningYou(286988, false, nil, 2, 1, 2)
local yellSearingEmbers					= mod:NewYell(286988, nil, false)
--local yellSearingEmbersFades			= mod:NewShortFadesYell(286988)
--local specWarnBloodshard				= mod:NewSpecialWarningInterrupt(273350, false, nil, 4, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 8)
--Team Attacks
local specWarnFirefromMist				= mod:NewSpecialWarningSwitch(285428, nil, nil, nil, 2, 2)
local specWarnFlashofPhoenixes			= mod:NewSpecialWarningSpell(284388, nil, nil, nil, 2, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--local timerDarkRevolationCD			= mod:NewCDCountTimer(55, 273365, nil, nil, nil, 3)
local timerMultiSidedStrikeCD			= mod:NewCDTimer(55.5, 282030, nil, nil, 2, 5, nil, DBM_CORE_TANK_ICON)--35-60, cause variation is awesome
local timerSpiritsofXuenCD				= mod:NewCDTimer(61.7, 285645, nil, nil, nil, 1, nil, DBM_CORE_HEROIC_ICON)
local timerRollCD						= mod:NewCDTimer(40.1, 286427, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--Mage
local timerShieldCD						= mod:NewCDTimer(50.6, 286425, nil, nil, nil, 4, nil, DBM_CORE_DAMAGE_ICON..DBM_CORE_INTERRUPT_ICON)
local timerSearingEmbersCD				= mod:NewCDTimer(51.0, 286988, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_HEALER_ICON)--15.8-29.2?
--Combos
local timerFirefromMistCD				= mod:NewCDTimer(51, 285428, nil, nil, nil, 6)
local timerFlashofPhoenixesCD			= mod:NewCDTimer(133, 284388, nil, nil, nil, 6)
local timerBlazingPhoenixCD				= mod:NewCDTimer(270, 282040, nil, nil, nil, 6)
--local timerMagmaTrapCD				= mod:NewAITimer(55, 284374, nil, nil, nil, 5)--Timer all over the place
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

mod.vb.shieldsActive = false
mod.vb.embersIcon = 0
mod.vb.magmaTrapCount = 0

function mod:OnCombatStart(delay)
	self.vb.shieldsActive = false
	self.vb.embersIcon = 0
	self.vb.magmaTrapCount = 0
	timerSearingEmbersCD:Start(11.9-delay)--13.1 in LFR?
	if self:IsMythic() then
		timerRollCD:Start(8.6)
		timerShieldCD:Start(15.8-delay)
		timerSpiritsofXuenCD:Start(45-delay)
		timerMultiSidedStrikeCD:Start(30-delay)
		--Blizzards energy code is still utter shite
		timerFirefromMistCD:Start(56.9-delay)--Variable as fuck
		timerFlashofPhoenixesCD:Start(151-delay)--Variable as fuck
		timerBlazingPhoenixCD:Start(262-delay)--Only thing consistent
	elseif self:IsHeroic() then
		--timerRollCD:Start(20-delay)
		timerShieldCD:Start(20-delay)
		timerMultiSidedStrikeCD:Start(30-delay)
		timerSpiritsofXuenCD:Start(45-delay)
		--Blizzards energy code is still utter shite
		timerFirefromMistCD:Start(51-delay)
		timerFlashofPhoenixesCD:Start(133-delay)
		timerBlazingPhoenixCD:Start(262-delay)
	else
		timerRollCD:Start(20-delay)
		timerShieldCD:Start(20-delay)
		timerMultiSidedStrikeCD:Start(35-delay)
		--Blizzards energy code is still utter shite
		timerFirefromMistCD:Start(51-delay)
		timerFlashofPhoenixesCD:Start(130-delay)
		timerBlazingPhoenixCD:Start(271-delay)
	end
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
		--timerShieldCD:Stop()
		--timerMultiSidedStrikeCD:Stop()
		--timerRollCD:Stop()
		--timerSearingEmbersCD:Stop()
		--timerRollCD:Start()
		--timerSearingEmbersCD:Start(12)
		--timerShieldCD:Start(20)
		--timerMultiSidedStrikeCD:Start(39)--New evidience suggests it doesn't reset here (48.6 mythic)
--	elseif spellId == 273350 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
--		specWarnBloodshard:Show(args.sourceName)
--		specWarnBloodshard:Play("kickcast")
	elseif spellId == 282040 then--Blazing Phoenix
		warnTransforms:Show()
	elseif spellId == 285818 or spellId == 282030 then
		if spellId == 285818 then
			specWarnMultiSidedStrikeAll:Show()--Warn everyone, it's mythic
			specWarnMultiSidedStrikeAll:Play("specialsoon")
		end
		if self:IsMythic() then
			timerMultiSidedStrikeCD:Start(76.5)
		else
			timerMultiSidedStrikeCD:Start(55)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282030 then
		if args:IsPlayer() then
			specWarnMultiSidedStrike:Show()--So show tank warning
			specWarnMultiSidedStrike:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282037 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 and self:AntiSpam(4, 1) then
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
		self.vb.shieldsActive = true
		if self.Options.SpecWarn286425switch2 then
			specWarnShield:Show(args.destName)
			specWarnShield:Play("targetchange")
		else
			warnShield:Show(args.destName)
		end
		timerShieldCD:Start()
		if self.Options.InfoFrame then
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
			--yellSearingEmbersFades:Countdown(10)
		end
		if self.Options.SetIconEmbers then
			self:SetIcon(args.destName, self.vb.embersIcon)
		end
	elseif spellId == 284656 then--Ring of Hostility (Long intermission with traps)
		--May be wrong to stop timers instead of let them run, then add failsafe time if phase lasts longer than these timers
		timerSearingEmbersCD:Stop()
		timerMultiSidedStrikeCD:Stop()
		timerShieldCD:Stop()
		timerSpiritsofXuenCD:Stop()
		timerRollCD:Stop()
		specWarnFlashofPhoenixes:Show()
		specWarnFlashofPhoenixes:Play("phasechange")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
		self.vb.shieldsActive = false
		specWarnPyroblast:Show(args.destName)
		specWarnPyroblast:Play("kickcast")
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			DBM.InfoFrame:Show(4, "enemypower", 2)
		end
	elseif spellId == 286988 then
		--if args:IsPlayer() then
			--yellSearingEmbersFades:Cancel()
		--end
		if self.Options.SetIconEmbers then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 284656 then--Ring of Hostility ending
		--timerSearingEmbersCD:Start(7)--7-15 (wishy washy)
		timerMultiSidedStrikeCD:Start(8.4)--May not actually work this way
		timerShieldCD:Start(8.5)
		--timerRollCD:Start()
		if self:IsHard() then
			timerSpiritsofXuenCD:Start(25)
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

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find("spell:284374") then -- Not in combat log or unit events
		self.vb.magmaTrapCount = self.vb.magmaTrapCount + 1
		warnMagmaTrap:Show(self.vb.magmaTrapCount)
		--timerMagmaTrapCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 285645 and not self:IsEasy() then--User reported event still fires on normal/LFR even though it doesn't spawn
		warnSpiritsofXuen:Show()
		timerSpiritsofXuenCD:Start()
	elseif spellId == 286987 then--Searing Embers
		self.vb.embersIcon = 0
		if self:IsHard() then
			timerSearingEmbersCD:Start(37.4)
		else
			timerSearingEmbersCD:Start()--51
		end
	elseif spellId == 286427 then--Roll
		if self:IsMythic() then
			timerRollCD:start(31)
		else
			timerRollCD:Start(20.3)
		end
	end
end
