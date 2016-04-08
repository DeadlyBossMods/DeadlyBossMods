local mod	= DBM:NewMod(1704, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(102679)--Ysondre, 102683 (Emeriss), 102682 (Lethon), 102681 (Taerar)
mod:SetEncounterID(1854)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 3, 2, 1)
--mod:SetHotfixNoticeRev(12324)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 203028 204767 203766 205300 203817 203888 204100 204078",
	"SPELL_CAST_SUCCESS 203153 203787 205298 205329 204040",
	"SPELL_AURA_APPLIED 203102 203125 203124 203121 203110 203770 203787 204040",
	"SPELL_AURA_APPLIED_DOSE 203102 203125 203124 203121",
	"SPELL_AURA_REMOVED 203102 203125 203124 203121 203787 204040",
--	"SPELL_DAMAGE",
--	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

--TODO, promote breath warning to special if it's impactful enough. FIgure out if timers are reasonable too
--TODO, check target scan on defiled spirit, if so can warn where it's going to spawn and players nearby to move away
--TODO, Wasting Dread spawn trigger, yell at ranged to switch to it
--TODO, if only one volatile infection goes out at a time, hide general alert if player affected
--TODO, remove combined show from any warnings that are only one target
--All
local warnSlumberingNightmare		= mod:NewTargetAnnounce(203110, 4, nil, false)--An option to announce fuckups
local warnBreath					= mod:NewSpellAnnounce(203028, 2)
--Ysondre
local warnCallDefiledSpirit			= mod:NewTargetAnnounce(203766, 4)
--Emeriss
local warnVolatileInfection			= mod:NewTargetAnnounce(203787, 3)
local warnEssenceOfCorruption		= mod:NewSpellAnnounce(205298, 2)
--Lethon
local warnGloom						= mod:NewSpellAnnounce(205329, 2)
local warnShadowBurst				= mod:NewTargetAnnounce(204040, 3)
--Taerar

--All
local specWarnYsondreMark			= mod:NewSpecialWarningStack(203102, nil, 7)
local specWarnEmerissMark			= mod:NewSpecialWarningStack(203125, nil, 7)
local specWarnLethonMark			= mod:NewSpecialWarningStack(203124, nil, 7)
local specWarnTaerarMark			= mod:NewSpecialWarningStack(203121, nil, 7)
--Ysondre
local specWarnNightmareBlast		= mod:NewSpecialWarningSpell(203153, nil, nil, nil, 2)
local specWarnDefiledSpirit			= mod:NewSpecialWarningYou(203766)
local yellSpirit					= mod:NewYell(203766)
local specWarnDefiledVines			= mod:NewSpecialWarningDispel(203766, "Healer", nil, nil, 1, 2)
--Emeriss
local specWarnVolatileInfection		= mod:NewSpecialWarningMoveAway(203787, nil, nil, nil, 1, 2)
local yellVolatileInfection			= mod:NewYell(203787)
local specWarnCorruptedBurst		= mod:NewSpecialWarningDodge(203817, "Melee", nil, nil, 1, 2)
local specWarnCorruption			= mod:NewSpecialWarningInterrupt(205300, "HasInterrupt", nil, nil, 1, 2)
--Lethon
local specWarnSiphonSpirit			= mod:NewSpecialWarningSwitch(203888, "Dps", nil, nil, 3, 2)
local specWarnShadowBurst			= mod:NewSpecialWarningYou(204040, nil, nil, nil, 1, 2)
local yellShadowBurst				= mod:NewFadesYell(204040)
--Taerar
local specWarnShadesOfTaerar		= mod:NewSpecialWarningSwitch(204100, "Tank", nil, nil, 1, 2)
local specWarnBellowingRoar			= mod:NewSpecialWarningSpell(204078, nil, nil, nil, 2, 6)

--Ysondre
local timerNightmareBlastCD			= mod:NewAITimer(16, 203153, nil, nil, nil, 3)
local timerDefiledSpiritCD			= mod:NewAITimer(16, 203766, nil, nil, nil, 3)
--Emeriss
local timerVolatileInfectionCD		= mod:NewAITimer(16, 203787, nil, nil, nil, 3)
local timerEssenceOfCorruptionCD	= mod:NewAITimer(16, 205298, nil, nil, nil, 1)
--Lethon
local timerSiphonSpiritCD			= mod:NewAITimer(16, 203888, nil, nil, nil, 1)
local timerShadowBurstCD			= mod:NewAITimer(16, 204040, nil, nil, nil, 3)
--Taerar
local timerBellowingRoarCD			= mod:NewAITimer(16, 204078, nil, nil, nil, 2)

--Ysondre
--local countdownMagicFire			= mod:NewCountdownFades(11.5, 162185)
--Emeriss
--Lethon
--Taerar

--Ysondre
--local voiceNightmareBlast			= mod:NewVoice(203153)--169613 (run over theh flower?)
--local voiceDefiledSpirit			= mod:NewVoice(203766)--watchstep
local voiceDefiledVines				= mod:NewVoice(203766, "Healer")--helpdispel
--Emeriss
local voiceVolatileInfection		= mod:NewVoice(203787)--scatter
local voiceCorruption				= mod:NewVoice(205300, "HasInterrupt")--kickcast
local voiceCorruptedBurst			= mod:NewVoice(203817, "Melee")--watchstep
--Lethon
local voiceSiphonSpirit				= mod:NewVoice(203817, "Dps")--killspirit
--Taerar
local voiceShadesOfTaerar			= mod:NewVoice(203817, "Tank")--mobsoon
local voiceBellowingRoar			= mod:NewVoice(204078)--fearsoon

mod:AddRangeFrameOption(10, 203787)
--mod:AddSetIconOption("SetIconOnMC", 163472, false)
--mod:AddHudMapOption("HudMapOnMC", 163472)

function mod:SpiritTarget(targetname, uId)
	if not targetname then
		warnCallDefiledSpirit:Show(DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnDefiledSpirit:Show()
		yellSpirit:Yell()
	else
		warnCallDefiledSpirit:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	timerNightmareBlastCD:Start(1-delay)
	timerDefiledSpiritCD:Start(1-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.FelArrow then
--		DBM.Arrow:Hide()
--	end
--	if self.Options.HudMapOnMC then
--		DBMHudMap:Disable()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203028 or spellId == 204767 then--204767 is weaker version used by Shade of Taerar
		local targetName, uId, bossuid = self:GetBossTarget(args.sourceGUID)
		if not bossuid then
			DBM:Debug("GetBossTarget failed, no bossuid")
			return
		end
		local tanking, status = UnitDetailedThreatSituation("player", bossuid)
		if tanking or (status == 3) then--Player is current target
			warnBreath:Show()
		end
	elseif spellId == 203766 then
		timerDefiledSpiritCD:Start()
		self:BossTargetScanner(args.sourceGUID, "SpiritTarget", 0.2, 15, true, nil, nil, nil, true)
	elseif spellId == 205300 and self:CheckInterruptFilter(args.sourceGUID) then
		specWarnCorruption:Show(args.sourceName)
		voiceCorruption:Play("kickcast")
	elseif spellId == 203817 then
		specWarnCorruptedBurst:Show()
		voiceCorruptedBurst:Play("watchstep")
	elseif spellId == 203888 then
		specWarnSiphonSpirit:Show()
		voiceSiphonSpirit:Play("killspirit")
		timerSiphonSpiritCD:Start()
	elseif spellId == 204100 then
		specWarnShadesOfTaerar:Show()
		voiceShadesOfTaerar:Play("mobsoon")
	elseif spellId == 204078 then
		specWarnBellowingRoar:Show()
		voiceBellowingRoar:Play("fearsoon")
		timerBellowingRoarCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 203153 then
		specWarnNightmareBlast:Show()
		timerNightmareBlastCD:Start()
	elseif spellId == 203787 then
		timerVolatileInfectionCD:Start()
	elseif spellId == 205298 then
		warnEssenceOfCorruption:Show()
		timerEssenceOfCorruptionCD:Start()
	elseif spellId == 205329 then
		warnGloom:Show()
	elseif spellId == 204040 then
		timerShadowBurstCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 203102 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnYsondreMark:Show(amount)
		end
	elseif spellId == 203125 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnEmerissMark:Show(amount)
		end
	elseif spellId == 203124 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnLethonMark:Show(amount)
		end
	elseif spellId == 203121 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 then
			specWarnTaerarMark:Show(amount)
		end
	elseif spellId == 203110 then
		warnSlumberingNightmare:CombinedShow(0.5, args.destName)
	elseif spellId == 203770 then
		specWarnDefiledVines:CombinedShow(0.5, args.destName)
		if self:AntiSpam(2, 1) then
			voiceDefiledVines:Play("helpdispel")
		end
	elseif spellId == 203787 then
		warnVolatileInfection:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnVolatileInfection:Show()
			yellVolatileInfection:Yell()
			voiceVolatileInfection:Play("scatter")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 204040 then
		warnShadowBurst:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnShadowBurst:Show()
			yellShadowBurst:Schedule(5, 1)
			yellShadowBurst:Schedule(4, 2)
			yellShadowBurst:Schedule(3, 3)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 203787 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	elseif spellId == 204040 and args:IsPlayer() then
		yellShadowBurst:Cancel()
	end
end

--[[

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 200666 then--Spider Form
	
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 205611 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnMiasma:Show()
--		voiceMiasma:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, _, _, _, target)
	if msg:find(L.supressionTarget1) then
--		self:SendSync("ChargeTo", target)
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "ChargeTo" then
		
	end
end
--]]
