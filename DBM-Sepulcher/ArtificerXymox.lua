local mod	= DBM:NewMod(2470, "DBM-Sepulcher", nil, 1195)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(183501)
mod:SetEncounterID(2553)
mod:SetUsedIcons(1, 2, 3, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220308000000)
mod:SetMinSyncRevision(20220123000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 363485 365682 362841 362801 362849 364040",
	"SPELL_CAST_SUCCESS 362885 364040 366752 362721 363258 364465 364030 367711",
	"SPELL_AURA_APPLIED 365577 365681 365701 362615 362614 362803 362882",
	"SPELL_AURA_APPLIED_DOSE 365681",
	"SPELL_AURA_REMOVED 365577 365701 363034 363139 362615 362614 362803",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, how does Gunship/hyperlight barrage work? Probably https://ptr.wowhead.com/spell=364376/hyperlight-barrage 3 sec periodic trigger
--[[
(ability.id = 363485 or ability.id = 362841 or ability.id = 362801 or ability.id = 362849) and type = "begincast"
 or (ability.id = 367711 or ability.id = 362885 or ability.id = 366752 or ability.id = 364040 or ability.id = 362721 or ability.id = 363258 or ability.id = 364465) and type = "cast"
 or (ability.id = 363034 or ability.id = 363139) and type = "removebuff"
 or (ability.id = 365682 or ability.id = 364040) and type = "begincast"
 or ability.id = 364030 and type = "cast"
--]]
--Forerunner Relic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24215))
local specWarnForerunnerRings					= mod:NewSpecialWarningDodgeCount(363520, nil, nil, nil, 2, 2)

local timerForerunnerRingsCD					= mod:NewNextCountTimer(30, 363520, nil, nil, nil, 3)
--Stage One: Cartel Xy
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24588))
local warnDimensionalTear						= mod:NewTargetNoFilterAnnounce(362615, 3, nil, nil, 67833)
local warnStasisTrap							= mod:NewTargetNoFilterAnnounce(362882, 2)--Failing to dodge it

local specWarnDimensionalTear					= mod:NewSpecialWarningYouPos(362615, nil, 67833, nil, 1, 2)
local yellDimensionalTear						= mod:NewPosYell(362615, 67833)
local yellDimensionalTearFades					= mod:NewIconFadesYell(362615, 67833)
local specWarnCartelElite						= mod:NewSpecialWarningSwitch(363485, "-Healer", nil, nil, 1, 2, 4)
local specWarnGlyphofRelocation					= mod:NewSpecialWarningMoveAway(362803, nil, nil, nil, 1, 2)
local yellGlyphofRelocation						= mod:NewYell(362803)
local yellGlyphofRelocationFades				= mod:NewShortFadesYell(362803)
local specWarnGlyphofRelocationTaunt			= mod:NewSpecialWarningTaunt(362803, nil, nil, nil, 1, 2)
local specWarnStasisTrap						= mod:NewSpecialWarningDodgeCount(362882, nil, nil, nil, 2, 2)
local yellStasisTrap							= mod:NewYell(362882)--Failing to dodge it
local specWarnHyperlightSpark					= mod:NewSpecialWarningCount(362849, nil, 206794, nil, 2, 2)--Short Text "Nova"

local timerDimensionalTearCD					= mod:NewNextCountTimer(8, 362615, 67833, nil, nil, 3)
local timerCartelEliteCD						= mod:NewCDTimer(28.8, 363485, nil, nil, nil, 1, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerGlyphofRelocationCD					= mod:NewCDCountTimer(60, 362801, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerGlyphExplostion						= mod:NewTargetTimer(5, 362803, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerStasisTrapCD							= mod:NewCDCountTimer(30, 362882, nil, nil, nil, 3)--28-32. it attemts to average 30 but has ~2 in either direction for some reason
local timerHyperlightSparknovaCD				= mod:NewCDCountTimer(30, 362849, 206794, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--28-34
local berserkTimer								= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnWormhole", 362615, true, false, {1, 2})
mod:AddSetIconOption("SetIconGlyphofRelocation", 362803, false, false, {3})
--Stage Two: Secrets of the Relic
mod:AddTimerLine(DBM:EJ_GetSectionInfo(24589))
local warnDecipherRelic							= mod:NewSpellAnnounce(363139, 2)
local warnDecipherRelicOver						= mod:NewEndAnnounce(363139, 2)

--Xy Reinforcements
local warnRiftBlasts							= mod:NewSpellAnnounce(362841, 2)
local warnMassiveBlast							= mod:NewStackAnnounce(365681, 2, nil, "Tank|Healer")
local warnHyperlightAscension					= mod:NewCastAnnounce(364040, 3)

local specWarnFracturingRiftBlasts				= mod:NewSpecialWarningDodge(362841, false, nil, nil, 2, 2, 4)--Mythic only, kinda spammy so off by default
local specWarnMassiveBlast						= mod:NewSpecialWarningDefensive(365681, nil, nil, nil, 1, 2)
local specWarnMassiveBlastTaunt					= mod:NewSpecialWarningTaunt(365681, nil, nil, nil, 1, 2)
local specWarnDebilitatingRay					= mod:NewSpecialWarningInterruptCount(364030, "HasInterrupt", nil, nil, 1, 2)

local timerRiftBlastsCD							= mod:NewCDTimer(6, 362841, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--Initial ones only on phasing, after that they can get kinda desynced plus very frequent
local timerMassiveBlastCD						= mod:NewCDTimer(11.5, 365681, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--11.5-12.2

mod:AddSetIconOption("SetIconOnHyperlightAdds", 364021, true, true, {4, 5, 6, 7, 8})
mod:AddNamePlateOption("NPAuraOnDecipherRelic", 363139, true)
mod:AddNamePlateOption("NPAuraOnOverseersOrders", 365701, true)
mod:AddNamePlateOption("NPAuraOnAscension", 364040, true)

mod:GroupSpells(362801, 362803)--Group relocation with explosion
mod:GroupSpells(362885, 362885)--Group statis trap cast with stasis trap debuff

local castsPerGUID = {}
mod.vb.tearIcon = 1
mod.vb.sparkCount = 0
mod.vb.ringCount = 0
mod.vb.glyphCount = 0
mod.vb.trapCount = 0
local difficultyName = mod:IsMythic() and "mythic" or mod:IsHeroic() and "heroic" or mod:IsNormal() and "normmal" or "lfr"
--This table may seem excessive, especially in phasess where they are all same (why not just go if phase 2 = then timer == 37)
--The reason being they aren't ALWAYS the same, case and point glyph in stage 1, rings in stage 4 heroic
--Want to be able to update timers faster on fly if fight continues to get hotfixes, this gives most rapidly changable knobs
local allTimers = {
	["lfr"] = {
		[1] = {--Unchanged
			--Rings
			[364465] = 42.8,
			--Glyph of Relocation
			[362801] = 42.8,
			--Stasis Trap
			[362885] = 42.8,
			--Hyperlight Sparknova
			[362849] = 42.8,
		},
		[2] = {--Gets a little slower
			--Rings
			[364465] = 42.8,
			--Glyph of Relocation
			[362801] = 42.8,
			--Stasis Trap
			[362885] = 42.8,
			--Hyperlight Sparknova
			[362849] = 42.8,
		},
		[3] = {--Gets even slower
			--Rings
			[364465] = 42.8,
			--Glyph of Relocation
			[362801] = 42.8,
			--Stasis Trap
			[362885] = 42.8,
			--Hyperlight Sparknova
			[362849] = 42.8,
		},
		[4] = {
			--Rings
			[364465] = 42.8,
			--Glyph of Relocation
			[362801] = 42.8,
			--Stasis Trap
			[362885] = 42.8,
			--Hyperlight Sparknova
			[362849] = 42.8,
		},
	},
	["normal"] = {
		[1] = {--Unchanged
			--Rings
			[364465] = 30,
			--Glyph of Relocation
			[362801] = 60,--It's supposed to be 30 too, but when other abilities are also 30, it causes this spell to skip casts
			--Stasis Trap
			[362885] = 30,
			--Hyperlight Sparknova
			[362849] = 30,
		},
		[2] = {--Gets a little slower
			--Rings
			[364465] = 37.4,
			--Glyph of Relocation
			[362801] = 37.4,
			--Stasis Trap
			[362885] = 37.4,
			--Hyperlight Sparknova
			[362849] = 37.4,
		},
		[3] = {--Gets even slower
			--Rings
			[364465] = 37.4,
			--Glyph of Relocation
			[362801] = 37.4,
			--Stasis Trap
			[362885] = 37.4,
			--Hyperlight Sparknova
			[362849] = 37.4,
		},
		[4] = {
			--Rings
			[364465] = 42.8,
			--Glyph of Relocation
			[362801] = 42.8,
			--Stasis Trap
			[362885] = 42.8,
			--Hyperlight Sparknova
			[362849] = 42.8,
		},
	},
	["heroic"] = {
		[1] = {--Unchanged
			--Rings
			[364465] = 30,
			--Glyph of Relocation
			[362801] = 60,--It's supposed to be 30 too, but when other abilities are also 30, it causes this spell to skip casts
			--Stasis Trap
			[362885] = 30,
			--Hyperlight Sparknova
			[362849] = 30,
		},
		[2] = {--Gets a little slower
			--Rings
			[364465] = 33.3,
			--Glyph of Relocation
			[362801] = 33.3,
			--Stasis Trap
			[362885] = 33.3,
			--Hyperlight Sparknova
			[362849] = 33.3,
		},
		[3] = {--Gets even slower
			--Rings
			[364465] = 33.3,
			--Glyph of Relocation
			[362801] = 33.3,
			--Stasis Trap
			[362885] = 33.3,
			--Hyperlight Sparknova
			[362849] = 33.3,
		},
		[4] = {
			--Rings
			[364465] = 40,
			--Glyph of Relocation
			[362801] = 40,--assumed not confirmed
			--Stasis Trap
			[362885] = 40,
			--Hyperlight Sparknova
			[362849] = 38.6,--Shorter than others?
		},
	},
	["mythic"] = {
		[1] = {--Original
			--Rings
			[364465] = 30,
			--Glyph of Relocation
			[362801] = 30,
			--Stasis Trap
			[362885] = 30,
			--Hyperlight Sparknova
			[362849] = 30,
		},
		[2] = {--Assumed unchanged, hotfixes said non mythic
			--Rings
			[364465] = 30,
			--Glyph of Relocation
			[362801] = 30,
			--Stasis Trap
			[362885] = 30,
			--Hyperlight Sparknova
			[362849] = 30,
		},
		[3] = {--Assumed unchanged, hotfixes said non mythic
			--Rings
			[364465] = 30,
			--Glyph of Relocation
			[362801] = 30,
			--Stasis Trap
			[362885] = 30,
			--Hyperlight Sparknova
			[362849] = 30,
		},
		[4] = {--Assumed has original change to 33 that was applied to all difficulties
			--Rings
			[364465] = 33,
			--Glyph of Relocation
			[362801] = 33,
			--Stasis Trap
			[362885] = 33,
			--Hyperlight Sparknova
			[362849] = 33,
		},
	},
}

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.sparkCount = 0
	self.vb.ringCount = 0
	self.vb.glyphCount = 0
	self.vb.trapCount = 0
	--For the time being, initial pull timers stil same on all difficulties
	--This will probably be changed soon enough :D
	if not self:IsLFR() then
		--These are same in 3 modes
		timerDimensionalTearCD:Start(7.9-delay, 1)
		timerHyperlightSparknovaCD:Start(14-delay, 1)
		timerStasisTrapCD:Start(21-delay, 1)
		timerForerunnerRingsCD:Start(26-delay, 1)
		timerGlyphofRelocationCD:Start(39.9-delay, 1)
	end
	if self:IsMythic() then
		difficultyName = "mythic"
		timerCartelEliteCD:Start(13.4-delay)
		timerRiftBlastsCD:Start(13.6-delay)
		berserkTimer:Start(600-delay)
	else
		if self:IsHeroic() then
			difficultyName = "heroic"
			berserkTimer:Start(480-delay)
		elseif self:IsNormal() then
			difficultyName = "normal"
			berserkTimer:Start(540-delay)
		else
			difficultyName = "lfr"
			timerDimensionalTearCD:Start(11-delay, 1)
			timerHyperlightSparknovaCD:Start(20-delay, 1)
			timerStasisTrapCD:Start(30-delay, 1)
			timerForerunnerRingsCD:Start(37.1-delay, 1)
			timerGlyphofRelocationCD:Start(57.1-delay, 1)
		end

	end
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder or self.Options.NPAuraOnAscension then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(castsPerGUID)
	if self.Options.NPAuraOnDecipherRelic or self.Options.NPAuraOnOverseersOrder or self.Options.NPAuraOnAscension then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if self:IsMythic() then
		difficultyName = "mythic"
	elseif self:IsHeroic() then
		difficultyName = "heroic"
	elseif self:IsNormal() then
		difficultyName = "normal"
	else
		difficultyName = "lfr"
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 363485 then
		DBM:AddMsg("The Cartel Elite added to combat log, notify DBM authors")
	elseif spellId == 365682 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnMassiveBlast:Show()
			specWarnMassiveBlast:Play("defensive")
		end
		timerMassiveBlastCD:Start(11.5, args.sourceGUID)
	elseif spellId == 362841 and self:AntiSpam(3, 1) then
		if self.Options.SpecWarn362841dodge then
			specWarnFracturingRiftBlasts:Show()
			specWarnFracturingRiftBlasts:Play("farfromline")
		else
			warnRiftBlasts:Show()
		end
--		timerRiftBlastsCD:Start()
	elseif spellId == 362801 then
		self.vb.glyphCount = self.vb.glyphCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId)
		if timer then
			timerGlyphofRelocationCD:Start(timer, self.vb.glyphCount+1)
		end
	elseif spellId == 362849 then
		self.vb.sparkCount = self.vb.sparkCount + 1
		specWarnHyperlightSpark:Show(self.vb.sparkCount)
		specWarnHyperlightSpark:Play("aesoon")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId)
		if timer then
			timerHyperlightSparknovaCD:Start(timer, self.vb.sparkCount+1)
		end
	elseif spellId == 364040 then
		if self:AntiSpam(2, 2) then
			warnHyperlightAscension:Show()
		end
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 10)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if (spellId == 362885 or spellId == 366752) and self:AntiSpam(10, 3) then--362885 verified on heroic
		self.vb.trapCount = self.vb.trapCount + 1
		specWarnStasisTrap:Show(self.vb.trapCount)
		specWarnStasisTrap:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, 362885)
		if timer then
			timerStasisTrapCD:Start(timer, self.vb.trapCount+1)
		end
	elseif spellId == 364040 then
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 362721 then
		self.vb.tearIcon = 1
	elseif spellId == 363258 then--Decipher Relic, Slightly faster than SPELL_CAST_START/APPLIED
		warnDecipherRelic:Show()
		--Stop timers
		timerForerunnerRingsCD:Stop()
		timerCartelEliteCD:Stop()
		timerRiftBlastsCD:Stop()
		timerDimensionalTearCD:Stop()
		timerGlyphofRelocationCD:Stop()
		timerHyperlightSparknovaCD:Stop()
		timerStasisTrapCD:Stop()
		--Only scan for acolytes and overseers and mark them with skull and cross, then stop scanning
		if self.Options.SetIconOnHyperlightAdds then
			self:ScanForMobs(184140, 0, 8, 2, {184140, 184143, 184792}, 12, "SetIconOnHyperlightAdds")
		end
		--Secondary scan that's marking Debilitators with 6 5 and 4
		if self.Options.SetIconOnHyperlightAdds then
			self:ScanForMobs(183707, 0, 6, 3, nil, 12, "SetIconOnHyperlightAdds")
		end
	elseif spellId == 364465 then
		self.vb.ringCount = self.vb.ringCount + 1
		specWarnForerunnerRings:Show(self.vb.ringCount)
		specWarnForerunnerRings:Play("watchwave")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, self.vb.phase, spellId)
		if timer then
			timerForerunnerRingsCD:Start(timer, self.vb.ringCount+1)
		end
	elseif spellId == 364030 then
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but failsafe
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then
			specWarnDebilitatingRay:Show(args.sourceName, count)
			if count < 6 then
				specWarnDebilitatingRay:Play("kick"..count.."r")
			else
				specWarnDebilitatingRay:Play("kickcast")
			end
		end
	elseif spellId == 367711 then--Decipher Relic (Stage 4 version)
		self:SetStage(4)
		self.vb.sparkCount = 0
		self.vb.ringCount = 0
		self.vb.glyphCount = 0
		self.vb.trapCount = 0
		warnDecipherRelic:Show()
		--Stop timers
		timerForerunnerRingsCD:Stop()
		timerCartelEliteCD:Stop()
		timerRiftBlastsCD:Stop()
		timerDimensionalTearCD:Stop()
		timerGlyphofRelocationCD:Stop()
		timerHyperlightSparknovaCD:Stop()
		timerStasisTrapCD:Stop()
		if self:IsMythic() then
			timerHyperlightSparknovaCD:Start(15.5, 1)
			timerDimensionalTearCD:Start(22, 4)
			timerStasisTrapCD:Start(23, 1)
			timerForerunnerRingsCD:Start(28, 1)
			timerGlyphofRelocationCD:Start(44, 1)
			--TODO: Could be changed since other stuff was, review!
			timerCartelEliteCD:Start(12)
			timerRiftBlastsCD:Start(12.2)
		elseif self:IsHeroic() then
			--Timers on non mythic even more altered on P4 start with march 3rd hotfixes
			timerHyperlightSparknovaCD:Start(18.6, 1)
			timerStasisTrapCD:Start(28, 1)
			timerDimensionalTearCD:Start(33.3, 4)
			timerForerunnerRingsCD:Start(36, 1)
			timerGlyphofRelocationCD:Start(53.3, 1)
		else--Normal, LFR are same here
			--Timers on non mythic even more altered on P4 start with march 3rd hotfixes
			timerHyperlightSparknovaCD:Start(20, 1)
			timerStasisTrapCD:Start(30, 1)
			timerDimensionalTearCD:Start(35.7, 4)
			timerForerunnerRingsCD:Start(38.5, 1)
			timerGlyphofRelocationCD:Start(57.1, 1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 365577 then
		if self.Options.NPAuraOnDecipherRelic then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId, nil, 25)
		end
	elseif spellId == 365701 then
		if self.Options.NPAuraOnOverseersOrders then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 365681 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 2 then
				if not args:IsPlayer() then
					--Because multiple adds up on diff CDs, can't do fancy debuff remaining checks, it just needs to be gone
					if not DBM:UnitDebuff("player", spellId) and not UnitIsDeadOrGhost("player") then
						specWarnMassiveBlastTaunt:Show(args.destName)
						specWarnMassiveBlastTaunt:Play("tauntboss")
					else
						warnMassiveBlast:Show(args.destName, amount)
					end
				end
			else
				warnMassiveBlast:Show(args.destName, amount)
			end
		end
	elseif spellId == 362615 or spellId == 362614 then
		local icon = self.vb.tearIcon
		if self.Options.SetIconOnWormhole then
			self:SetIcon(args.destName, icon)
		end
		if args:IsPlayer() then
			specWarnDimensionalTear:Show(self:IconNumToTexture(icon))
			specWarnDimensionalTear:Play("mm"..icon)
			yellDimensionalTear:Yell(icon, icon, icon)
			yellDimensionalTearFades:Countdown(spellId, 7, icon)
		end
		warnDimensionalTear:CombinedShow(1, args.destName)
		self.vb.tearIcon = self.vb.tearIcon + 1
	elseif spellId == 362803 then
		if self.Options.SetIconGlyphofRelocation then
			self:SetIcon(args.destName, 3)
		end
		if args:IsPlayer() then
			specWarnGlyphofRelocation:Show(self.vb.destructionCount)
			specWarnGlyphofRelocation:Play("runout")
			yellGlyphofRelocation:Yell()
			yellGlyphofRelocationFades:Countdown(spellId)
		else
			specWarnGlyphofRelocationTaunt:Show(args.destName)
			specWarnGlyphofRelocationTaunt:Play("tauntboss")
		end
		timerGlyphExplostion:Start(args.destName)
	elseif spellId == 362882 then
		warnStasisTrap:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			yellStasisTrap:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 365577 then
		if self.Options.NPAuraOnDecipherRelic then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 365701 then
		if self.Options.NPAuraOnOverseersOrders then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 363034 or spellId == 363139 then--Decipher Relic 1 min (boss casts)
		self:SetStage(0)
		self.vb.sparkCount = 0
		self.vb.ringCount = 0
		self.vb.glyphCount = 0
		self.vb.trapCount = 0
		warnDecipherRelicOver:Show()
		if self:IsMythic() then
			--Restart Timers (exactly same as pull)
			timerDimensionalTearCD:Start(8, self.vb.phase)
			timerHyperlightSparknovaCD:Start(14, 1)
			timerStasisTrapCD:Start(21, 1)
			timerForerunnerRingsCD:Start(26, 1)
			timerGlyphofRelocationCD:Start(40, 1)
			--Mythic Only
			timerCartelEliteCD:Start(12)
			timerRiftBlastsCD:Start(12.2)
		elseif self:IsHeroic() then
			--Initial timers are slowed now as of march 3rd hotfixe
			timerDimensionalTearCD:Start(8.8, self.vb.phase)
			timerHyperlightSparknovaCD:Start(15.5, 1)
			timerStasisTrapCD:Start(23.3, 1)
			timerForerunnerRingsCD:Start(28.8, 1)
			timerGlyphofRelocationCD:Start(44.4, 1)
		elseif self:IsNormal() then
			--Initial timers are even more slowed as of march 3rd hotfixe
			timerDimensionalTearCD:Start(10, self.vb.phase)
			timerHyperlightSparknovaCD:Start(17.5, 1)
			timerStasisTrapCD:Start(26.2, 1)
			timerForerunnerRingsCD:Start(32.5, 1)
			timerGlyphofRelocationCD:Start(50, 1)
		else--LFR
			--Initial timers are even more slowed as of march 3rd hotfixe
			timerDimensionalTearCD:Start(11.4, self.vb.phase)
			timerHyperlightSparknovaCD:Start(20, 1)
			timerStasisTrapCD:Start(30, 1)
			timerForerunnerRingsCD:Start(37.1, 1)
			timerGlyphofRelocationCD:Start(57.1, 1)
		end
	elseif spellId == 362615 or spellId == 362614 then
		if self.Options.SetIconOnWormhole then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellDimensionalTearFades:Cancel()
		end
	elseif spellId == 362803 then
		if self.Options.SetIconGlyphofRelocation then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellGlyphofRelocationFades:Cancel()
		end
		timerGlyphExplostion:Stop(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 184140 or cid == 184143 then--Xy Acolyte, Xy Archon
		timerMassiveBlastCD:Stop(args.destGUID)
		if self.Options.NPAuraOnAscension then
			DBM.Nameplate:Hide(true, args.destGUID, 364040)
		end
	end
end

--"<19.51 22:08:21> [UNIT_SPELLCAST_SUCCEEDED] Artificer Xy'mox(Bookaine) -Hyperlight Reinforcements- boss1:Cast-3-4170-2481-12807-364046-006FB27045:364046
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 365428 then
		specWarnCartelElite:Show()
		specWarnCartelElite:Play("killmob")
	end
end

