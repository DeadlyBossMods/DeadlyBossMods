local mod	= DBM:NewMod(2328, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(string.sub("@file-date-integer@", 1, -5))
mod:SetCreatureID(146497, 146495)--146497 Zaxasj, 146495 Fa'thuul
mod:SetEncounterID(2269)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)--Refine when max number of doubt targets is known
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282675 282589 282515 282517 282617 282818",
	"SPELL_CAST_SUCCESS 282561 282384 282407 285416",
	"SPELL_AURA_APPLIED 282741 282742 282914 283524 282386 282540 282561 282384 282432 287876 282817",
	"SPELL_AURA_APPLIED_DOSE 282384",
	"SPELL_AURA_REFRESH 282384 282386 283524",
	"SPELL_AURA_REMOVED 282741 282742 282386 282561 282384 282432",
--	"SPELL_PERIODIC_DAMAGE 287876",
--	"SPELL_PERIODIC_MISSED 287876",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Relics assumed, if not boss unitIDs, remove boss3-5
)

--TODO: add general announce for embrace of the void? it seems pretty given, it's more of a healer track on raid frames thing than a DBM thing
--TODO, correct cast ID for custody of the deep to warn tank to move boss into bubble
--TODO, refine AbyssalCollapse for situations like do we cancel bar if shield gets completely depleted, etc
--TODO, see if relics hard reset boss cd timers or if they just get paused, or if nothing affects them at all
--TODO, custom info frame that tracks who has herald, personal promises of power, probably other crap
--TODO, fine tune tank swap stacks (changed to 3, but many strats may favor doing 2-5 to reduce add spawn complexity and tank damage. Probably will just add a drop down)
--TODO, detect void crash bounces, use general announce for cast and first bounce, special warning for one that needs soaking?
--[[
(ability.id = 282675 or ability.id = 282589 or ability.id = 282515 or ability.id = 282617 or ability.id = 282517 or ability.id = 283540 or ability.id = 282621 or ability.id = 282818) and type = "begincast"
 or (ability.id = 282561 or ability.id = 282384 or ability.id = 282407 or ability.id = 285416) and type = "cast"
 or (ability.id = 282817 or ability.id = 282432) and type = "applydebuff"
--]]
--Relics of Power
local warnUmbralShell					= mod:NewFadesAnnounce(282741, 1)
--General
local warnPact							= mod:NewCastAnnounce(282675, 4)
--Zaxasj the Speaker
local warnDarkHeraldFaded				= mod:NewFadesAnnounce(282561, 1)
local warnDarkHerald					= mod:NewTargetNoFilterAnnounce(282561, 3)
--Fa'thuul the Feared
local warnShearMind						= mod:NewStackAnnounce(282384, 2, nil, "Tank")
local warnVoidCrash						= mod:NewSpellAnnounce(285416, 2)
local warnCrushingDoubt					= mod:NewTargetAnnounce(282432, 2)

--Relics of Power
local specWarnUmbralShell				= mod:NewSpecialWarningSwitch(282741, "Dps", nil, nil, 1, 2)
local specWarnCustodyoftheDeep			= mod:NewSpecialWarningMoveTo(284772, "Tank", nil, nil, 1, 2)
local specWarnStormofAnnihilation		= mod:NewSpecialWarningSpell(286755, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelming			= mod:NewSpecialWarningTarget(282914, nil, nil, nil, 3)--A wipe basically
--Zaxasj the Speaker
local specWarnAphoticBlast				= mod:NewSpecialWarningYou(282386, false, nil, 2, 1, 2)
local yellAphoticBlast					= mod:NewFadesYell(282386)
local specWarnAgentofDemise				= mod:NewSpecialWarningTargetChange(282540, "-Healer", nil, nil, 1, 2)
local yellAgentofDemise					= mod:NewYell(282540, nil, nil, nil, "YELL")
local specWarnCerebralAssault			= mod:NewSpecialWarningDodge(282589, nil, nil, nil, 3, 2)
local specWarnDarkherald				= mod:NewSpecialWarningYou(282561, nil, nil, nil, 1, 2)
local yellDarkherald					= mod:NewYell(282561)
local specWarnVisagefromBeyond			= mod:NewSpecialWarningSwitch(282515, "-Healer", nil, nil, 1, 2)
--Fa'thuul the Feared
local specWarnShearMind					= mod:NewSpecialWarningStack(282384, nil, 3, nil, nil, 1, 6)
local specWarnShearMindTaunt			= mod:NewSpecialWarningTaunt(282384, nil, nil, nil, 1, 2)
local yellShearMindFades				= mod:NewFadesYell(282384, nil, false)--useful but optional
--local specSeveredAnguish				= mod:NewSpecialWarningTaunt(282817, nil, nil, nil, 1, 2)
local specWarnCrushingDoubt				= mod:NewSpecialWarningYouPos(282432, nil, nil, nil, 1, 2)
local yellCrushingDoubt					= mod:NewPosYell(282432)
local yellCrushingDoubtFades			= mod:NewIconFadesYell(282432)
local specWarnEldritchRevelation		= mod:NewSpecialWarningSwitch(282617, false, nil, 2, 1, 2)
local specWarnWitnesstheEnd				= mod:NewSpecialWarningInterruptCount(282621, false, nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(287876, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerAbyssalCollapse				= mod:NewCastTimer(20, 282886, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerStormofAnnihilation			= mod:NewCastTimer(15, 286755, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerPact							= mod:NewCastSourceTimer(12, 282675, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
--Zaxasj the Speaker
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18974))
local timerCerebralAssaultCD			= mod:NewCDTimer(31.5, 282589, nil, nil, nil, 3)
local timerDarkherald					= mod:NewTargetTimer(20, 282589, nil, nil, nil, 5)
local timerDarkheraldCD					= mod:NewCDTimer(32.7, 282589, nil, nil, nil, 3)
local timerTerrifyingEcho				= mod:NewCastTimer(15, 282517, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Fa'thuul the Feared
mod:AddTimerLine(DBM:EJ_GetSectionInfo(18983))
local timerShearMindCD					= mod:NewCDTimer(8.4, 282384, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
--local timerDevourThoughtsCD				= mod:NewCDTimer(9.8, 282818, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerVoidCrashCD					= mod:NewCDTimer(13.3, 285416, nil, nil, nil, 3)
local timerCrushingDoubtCD				= mod:NewCDTimer(40.1, 282432, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownShearMind				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconCrushingDoubt", 282432, true)
mod:AddSetIconOption("SetIconDarkherald", 282561, true)
mod:AddSetIconOption("SetIconOnAdds", 282621, true, true)
mod:AddRangeFrameOption(6, 283524)
mod:AddInfoFrameOption(282741, true)
mod:AddNamePlateOption("NPAuraOnEcho", 282517)
mod:AddNamePlateOption("NPAuraOnWitness", 282621)

--mod.vb.phase = 1
mod.vb.CrushingDoubtIcon = 1
--mod.vb.tankAddsActive = 0
mod.vb.addIcon = 4--4-6
local castsPerGUID = {}
local interruptTextures = {[1] = 2178508, [2] = 2178501, [3] = 2178502, [4] = 2178503, [5] = 2178504, [6] = 2178505, [7] = 2178506, [8] = 2178507,}--Fathoms Deck

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.CrushingDoubtIcon = 1
	--self.vb.tankAddsActive = 0
	self.vb.addIcon = 4
	--Zaxasj the Speaker
	timerDarkheraldCD:Start(10.2-delay)--SUCCESS
	timerCerebralAssaultCD:Start(15.5-delay)
	--Fa'thuul the Feared
	timerShearMindCD:Start(8.5-delay)--SUCCESS
	timerVoidCrashCD:Start(13-delay)--SUCCESS
	timerCrushingDoubtCD:Start(18.1-delay)
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnWitness then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence or self.Options.NPAuraOnWitness then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282675 then
		warnPact:Show()
		local cid = self:GetCIDFromGUID(args.sourceGUID)
		--146497 Zaxasj, 146495 Fa'thuul
		if cid == 146497 then
			timerPact:Start(12, L.Zaxasj)
		else
			timerPact:Start(12, L.Fathuul)
		end
	elseif spellId == 282589 then
		specWarnCerebralAssault:Show()
		specWarnCerebralAssault:Play("shockwave")
		timerCerebralAssaultCD:Start()
	elseif spellId == 282515 then
		specWarnVisagefromBeyond:Show()
		specWarnVisagefromBeyond:Play("bigmob")
	elseif spellId == 282617 then
		specWarnEldritchRevelation:Show()
		specWarnEldritchRevelation:Play("bigmob")
	elseif spellId == 282517 then
		timerTerrifyingEcho:Start()
		if self.Options.NPAuraOnEcho then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 15)
		end
	elseif (spellId == 283540 or spellId == 282621) then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnAdds then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.addIcon, 1, 0.2, 10)
			end
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon == 7 then--4-6
				self.vb.addIcon = 4
			end
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnWitnesstheEnd:Show(args.sourceName, count)
			if count == 1 then
				specWarnWitnesstheEnd:Play("kick1r")
			elseif count == 2 then
				specWarnWitnesstheEnd:Play("kick2r")
			elseif count == 3 then
				specWarnWitnesstheEnd:Play("kick3r")
			elseif count == 4 then
				specWarnWitnesstheEnd:Play("kick4r")
			elseif count == 5 then
				specWarnWitnesstheEnd:Play("kick5r")
			else--Shouldn't happen, but fallback rules never hurt
				specWarnWitnesstheEnd:Play("kickcast")
			end
		end
		if self.Options.NPAuraOnWitness then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, interruptTextures[count])
		end
--	elseif spellId == 282818 then
		--timerDevourThoughtsCD:Start(9.8, args.sourceGUID)
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 282517 then
		timerTerrifyingEcho:Stop()
		if self.Options.NPAuraOnEcho then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 282561 then
		timerDarkheraldCD:Start()--Kept here because boss can stutter cast so START is bad place to start timer
	elseif spellId == 282384 then
		timerShearMindCD:Start()
	elseif spellId == 282407 or spellId == 285416 then
		warnVoidCrash:Show()
		timerVoidCrashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 282741 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		--146497 Zaxasj, 146495 Fa'thuul
		if cid == 146497 then
			specWarnUmbralShell:Show(L.Zaxasj)
		else
			specWarnUmbralShell:Show(L.Fathuul)
		end
		specWarnUmbralShell:Play("attackshield")
		if self.Options.InfoFrame then
			--for i = 1, 2 do
				--local bossUnitID = "boss"..i
				--if UnitGUID(bossUnitID) == args.sourceGUID then--Identify correct unit ID
					DBM.InfoFrame:SetHeader(args.spellName)
					--DBM.InfoFrame:Show(2, "enemyabsorb", nil, UnitGetTotalAbsorbs(bossUnitID))
					DBM.InfoFrame:Show(2, "enemyabsorb")
					--break
				--end
			--end
		end
	elseif spellId == 282742 then
		specWarnStormofAnnihilation:Show()
		specWarnStormofAnnihilation:Play("aesoon")
		timerStormofAnnihilation:Start()
	elseif spellId == 282914 then
		specWarnPowerOverwhelming:Show()
	elseif spellId == 283524 or spellId == 282386 then
		if args:IsPlayer() then
			if spellId == 282386 then--Heroic/Mythic
				specWarnAphoticBlast:Show()
				specWarnAphoticBlast:Play("targetyou")
				yellAphoticBlast:Cancel()
				yellAphoticBlast:Countdown(20)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
		end
	elseif spellId == 282540 then
		if not args:IsPlayer() then
			specWarnAgentofDemise:CombinedShow(1, args.destName)
			specWarnAgentofDemise:ScheduleVoice(1, "targetchange")
		else
			yellAgentofDemise:Yell()
		end
	elseif spellId == 282561 then
		timerDarkherald:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkherald:Show()
			specWarnDarkherald:Play("targetyou")
			yellDarkherald:Yell()
		else
			warnDarkHerald:Show(args.destName)
		end
		if self.Options.SetIconDarkherald then
			self:SetIcon(args.destName, 7)
		end
	elseif spellId == 282384 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnShearMind:Show(amount)
					specWarnShearMind:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off and aren't dealing with an add
						specWarnShearMindTaunt:Show(args.destName)
						specWarnShearMindTaunt:Play("tauntboss")
					else
						warnShearMind:Show(args.destName, amount)
					end
				end
			else
				warnShearMind:Show(args.destName, amount)
			end
		end
		if args:IsPlayer() then
			yellShearMindFades:Cancel()
			yellShearMindFades:Countdown(12)
		end
	elseif spellId == 282432 then
		warnCrushingDoubt:CombinedShow(1, args.destName)
		local icon = self.vb.CrushingDoubtIcon
		if args:IsPlayer() then
			specWarnCrushingDoubt:Show(self:IconNumToTexture(icon))
			specWarnCrushingDoubt:Play("mm"..icon)
			yellCrushingDoubt:Yell(icon, icon, icon)
			yellCrushingDoubtFades:Countdown(10, nil, icon)
		end
		if self.Options.SetIconCrushingDoubt then
			self:SetIcon(args.destName, icon)
		end
		self.vb.CrushingDoubtIcon = self.vb.CrushingDoubtIcon + 1
	elseif spellId == 287876 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")--This particular case it's not a watch feet GTFO, it's a run away since you're too far into darkness
	--[[elseif spellId == 282817 then
		self.vb.tankAddsActive = self.vb.tankAddsActive + 1
		local _, _, _, _, expireTime = DBM:UnitDebuff("player", 282384)
		local remaining
		if expireTime then
			remaining = expireTime-GetTime()
		end
		--Taunt add, you don't have debuff, or your debuff will fade before devour thoughts finishes and you aren't currently tanking either of bosses
		if not UnitDetailedThreatSituation("player", "boss1") and not UnitDetailedThreatSituation("player", "boss2") and (not remaining or remaining and remaining < 5.5) then
			specSeveredAnguish:Show()
			specSeveredAnguish:Play("killmob")
		end
		timerDevourThoughtsCD:Start(4.5, args.destGUID)--START--]]
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 282741 then
		warnUmbralShell:Show()
		if self.Options.InfoFrame then
			--DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_POWER)
			--DBM.InfoFrame:Show(4, "enemypower", 2)
			DBM.InfoFrame:Hide()
		end
	elseif spellId == 282742 then
		timerStormofAnnihilation:Stop()
	elseif spellId == 282386 then
		if args:IsPlayer() then
			yellAphoticBlast:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 282561 then
		timerDarkherald:Stop(args.destName)
		if args:IsPlayer() then
			warnDarkHeraldFaded:Show()
		end
		if self.Options.SetIconDarkherald then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 282384 then
		if args:IsPlayer() then
			yellShearMindFades:Cancel()
		end
	elseif spellId == 282432 then
		if self.Options.SetIconCrushingDoubt then
			self:SetIcon(args.destName, 0)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 287876 and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 144996 then--Visage from beyond
		timerTerrifyingEcho:Stop()
		if self.Options.NPAuraOnEcho then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
--	elseif cid == 145275 then--Manifestation of Anguish
--		self.vb.tankAddsActive = self.vb.tankAddsActive - 1
		--timerDevourThoughtsCD:Stop(args.destGUID)
	elseif cid == 145053 then--Eldritch Abomination
		castsPerGUID[args.destGUID] = nil
		if self.Options.NPAuraOnWitness then
			DBM.Nameplate:Hide(true, args.destGUID)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 286696 or spellId == 284772) and self:AntiSpam(5, 1) then--Custody of the Deep
		specWarnCustodyoftheDeep:Show(DBM_CORE_SHIELD)
		specWarnCustodyoftheDeep:Play("moveboss")
		timerAbyssalCollapse:Start()
	elseif spellId == 287762 then--Crushing Doubt
		self.vb.CrushingDoubtIcon = 1
		timerCrushingDoubtCD:Start()
	end
end
