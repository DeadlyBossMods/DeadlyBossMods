local mod	= DBM:NewMod(2328, "DBM-CrucibleofStorms", nil, 1177)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(146497, 146495)--146497 Zaxasj, 146495 Fa'thuul
mod:SetEncounterID(2269)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(1, 2, 3, 6)--Refine when max number of doubt targets is known
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282675 282589 283524 282386 282515 282517 282407 285416 282617",
	"SPELL_CAST_SUCCESS 282561 282384 282432 287762",
	"SPELL_AURA_APPLIED 282741 286755 282914 283524 282386 282540 282561 282384 282432 287876",
	"SPELL_AURA_APPLIED_DOSE 282384",
	"SPELL_AURA_REFRESH 282384",
	"SPELL_AURA_REMOVED 282741 286755 282386 282561 282384 282432",
--	"SPELL_PERIODIC_DAMAGE 287876",
--	"SPELL_PERIODIC_MISSED 287876",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--Relics assumed, if not boss unitIDs, remove boss3-5
)

--TODO: add general announce for embrace of the void? it seems pretty given, it's more of a healer track on raid frames thing than a DBM thing
--TODO, correct cast ID for custody of the deep to warn tank to move boss into bubble
--TODO, refine AbyssalCollapse for situations like do we cancel bar if shield gets completely depleted, etc
--TODO, verify Aphotic Blast target scanning
--TODO, can tank dodge Cerebral Assault too? or does it face tank regardless and used as a sudo tank swap?
--TODO, see if relics hard reset boss cd timers or if they just get paused, or if nothing affects them at all
--TODO, custom info frame that tracks who has herald, personal promises of power, probably other crap
--TODO, fine tune tank swap stacks
--TODO, figure out what triggers severed anguish, does it just happen when shearmind is expiring?
--TODO, detect void crash bounces, use general announce for cast and first bounce, special warning for one that needs soaking?
--TODO, verify cast spell ID for crushing Doubt
--local warnXorothPortal				= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
--Relics of Power
local warnUmbralShell					= mod:NewFadesAnnounce(282741, 1)
--General
local warnPact							= mod:NewCastAnnounce(282675, 4)
--Zaxasj the Speaker
local warnDarkHeraldFaded				= mod:NewFadesAnnounce(282589, 1)
local warnDarkHerald					= mod:NewTargetNoFilterAnnounce(282589, 3)
--Fa'thuul the Feared
local warnShearMind						= mod:NewStackAnnounce(282384, 2, nil, "Tank")
local warnVoidCrash						= mod:NewSpellAnnounce(285416, 2)

--Relics of Power
local specWarnUmbralShell				= mod:NewSpecialWarningSwitch(282741, "Dps", nil, nil, 1, 2)
local specWarnCustodyoftheDeep			= mod:NewSpecialWarningMoveTo(284772, "Tank", nil, nil, 1, 2)
local specWarnStormofAnnihilation		= mod:NewSpecialWarningSpell(286755, nil, nil, nil, 2, 2)
local specWarnPowerOverwhelming			= mod:NewSpecialWarningTarget(282914, nil, nil, nil, 3)--A wipe basically
--Zaxasj the Speaker
local specWarnAphoticBlast				= mod:NewSpecialWarningYou(282386, nil, nil, nil, 3, 2)
local yellAphoticBlast					= mod:NewFadesYell(282386)
local specWarnAgentofDemise				= mod:NewSpecialWarningTargetChange(282540, "-Healer", nil, nil, 1, 2)
local yellAgentofDemise					= mod:NewYell(282540, nil, nil, nil, "YELL")
local specWarnCustodyoftheDeep			= mod:NewSpecialWarningMoveTo(284772, "Tank", nil, nil, 1, 2)
local specWarnCerebralAssault			= mod:NewSpecialWarningDodge(282589, nil, nil, nil, 2, 2)
local specWarnDarkherald				= mod:NewSpecialWarningYou(282561, nil, nil, nil, 1, 2)
local yellDarkherald					= mod:NewYell(282561)
local specWarnVisagefromBeyond			= mod:NewSpecialWarningSwitch(282515, "-Healer", nil, nil, 1, 2)
--Fa'thuul the Feared
local specWarnShearMind					= mod:NewSpecialWarningStack(282384, nil, 7, nil, nil, 1, 6)
local specWarnShearMindTaunt			= mod:NewSpecialWarningTaunt(282384, nil, nil, nil, 1, 2)
local yellShearMindFades				= mod:NewFadesYell(282384)
local specSeveredAnguish				= mod:NewSpecialWarningSwitch(282817, "-Healer", nil, nil, 1, 2)
local specWarnCrushingDoubt				= mod:NewSpecialWarningYouPos(282432, nil, nil, nil, 1, 2)
local yellCrushingDoubt					= mod:NewPosYell(282432)
local yellCrushingDoubtFades			= mod:NewIconFadesYell(282432)
local specWarnEldritchRevelation		= mod:NewSpecialWarningSwitch(282617, "-Healer", nil, nil, 1, 2)
local specWarnWitnesstheEnd				= mod:NewSpecialWarningInterrupt(282621, nil, nil, nil, 1, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(287876, nil, nil, nil, 1, 8)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
local timerAbyssalCollapse				= mod:NewCastTimer(20, 282886, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON)
local timerStormofAnnihilation			= mod:NewCastTimer(15, 286755, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerPact							= mod:NewCastSourceTimer(12, 282675, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON)
--Zaxasj the Speaker
local timerAphoticBlastCD				= mod:NewAITimer(55, 282386, nil, nil, nil, 3)
local timerCerebralAssaultCD			= mod:NewAITimer(55, 282589, nil, nil, nil, 3)
local timerDarkherald					= mod:NewTargetTimer(20, 282589, nil, nil, nil, 5)
local timerDarkheraldCD					= mod:NewAITimer(55, 282589, nil, nil, nil, 3)
local timerTerrifyingEcho				= mod:NewCastTimer(15, 282517, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Fa'thuul the Feared
local timerShearMindCD					= mod:NewAITimer(14.1, 282384, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerVoidCrashCD					= mod:NewAITimer(55, 285416, nil, nil, nil, 3)
local timerCrushingDoubtCD				= mod:NewAITimer(55, 282432, nil, nil, nil, 3)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownShearMind				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

mod:AddSetIconOption("SetIconCrushingDoubt", 282432, true)
mod:AddSetIconOption("SetIconDarkherald", 282561, true)
mod:AddRangeFrameOption(6, 282386, "Ranged")
mod:AddInfoFrameOption(282741, true)
mod:AddNamePlateOption("NPAuraOnEcho", 282517)

--mod.vb.phase = 1
mod.vb.CrushingDoubtIcon = 1

function mod:OnCombatStart(delay)
	self.vb.CrushingDoubtIcon = 1
	--Z
	timerAphoticBlastCD:Start(1-delay)--START
	timerCerebralAssaultCD:Start(1-delay)
	timerDarkheraldCD:Start(1-delay)--SUCCESS
	--F
	timerShearMindCD:Start(1-delay)
	timerVoidCrashCD:Start(1-delay)
	timerCrushingDoubtCD:Start(1-delay)
	if self.Options.NPAuraOnPresence then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPresence then
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
	elseif spellId == 283524 or spellId == 282386 then
		timerAphoticBlastCD:Start()
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
	elseif spellId == 282407 or spellId == 285416 then
		warnVoidCrash:Show()
		timerVoidCrashCD:Start()
	elseif (spellId == 283540 or spellId == 282621) and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnWitnesstheEnd:Show(args.sourceName)
		specWarnWitnesstheEnd:Play("kickcast")
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
		timerDarkheraldCD:Start()--Move to cast start, if target scanable
	elseif spellId == 282384 then
		timerShearMindCD:Start()
	elseif spellId == 282432 or spellId == 287762 then
		self.vb.CrushingDoubtIcon = 1
		timerCrushingDoubtCD:Start()
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
	elseif spellId == 286755 then
		specWarnStormofAnnihilation:Show()
		specWarnStormofAnnihilation:Play("aesoon")
		timerStormofAnnihilation:Start()
	elseif spellId == 282914 then
		specWarnPowerOverwhelming:Show()
	elseif spellId == 283524 or spellId == 282386 then
		if args:IsPlayer() then
			specWarnAphoticBlast:Show()
			specWarnAphoticBlast:Play("targetyou")
			if spellId == 282386 then--Heroic/Mythic
				yellAphoticBlast:Countdown(20)
			end
		end
	elseif spellId == 282540 then
		if not args:IsPlayer() then
			specWarnAgentofDemise:Show()
			specWarnAgentofDemise:Play("targetchange")
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
			self:SetIcon(args.destName, 6)
		end
	elseif spellId == 282384 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 7 then
				if args:IsPlayer() then
					specWarnShearMind:Show(amount)
					specWarnShearMind:Play("stackhigh")
				else
					if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
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
	elseif spellId == 286755 then
		timerStormofAnnihilation:Stop()
	elseif spellId == 282386 then
		if args:IsPlayer() then
			yellAphoticBlast:Cancel()
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
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 286696 or spellId == 284772) and self:AntiSpam(5, 1) then--Custody of the Deep
		specWarnCustodyoftheDeep:Show(DBM_CORE_SHIELD)
		specWarnCustodyoftheDeep:Play("moveboss")
		timerAbyssalCollapse:Start()
	elseif spellId == 282814 then--Severed Anguish
		if not DBM:UnitDebuff("player", 282384) then--Cannot allow tank that currently has that boss to take this add, it must be tanked by someone with no stacks
			specSeveredAnguish:Show()
			specSeveredAnguish:Play("killmob")
		end
	end
end
