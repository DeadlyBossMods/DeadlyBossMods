local mod	= DBM:NewMod(2169, "DBM-Uldir", nil, 1031)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(134445)--Zek'vhozj, 134503/qiraji-warrior
mod:SetEncounterID(2136)
--mod:DisableESCombatDetection()
mod:SetZone()
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(17776)
--mod:SetMinSyncRevision(16950)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 267180 267239 270620 265231 265530",
	"SPELL_CAST_SUCCESS 264382",
	"SPELL_AURA_APPLIED 265264 265360 265662 265646 265237",
	"SPELL_AURA_APPLIED_DOSE 265264",
	"SPELL_AURA_REMOVED 265360 265662",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

--TODO, icons for Roiling Deceit if applied to more than one target at a time
--TODO, mark mind controlled players?
--TODO, find a log that drags out P1 so can see timer between eye beams/warrior adds. Or wait til mythic when P1 mechanics don't disable
--TODO, maybe a "next bounce" timer
--[[
(ability.id = 267239 or ability.id = 265231 or ability.id = 265530) and type = "begincast"
 or ability.id = 264382 and type = "cast"
 or ability.id = 265360 and type = "applydebuff"
 or (ability.id = 267180 or ability.id = 270620) and type = "begincast"
--]]
--local warnXorothPortal					= mod:NewSpellAnnounce(244318, 2, nil, nil, nil, nil, nil, 7)
local warnVoidLash						= mod:NewStackAnnounce(265264, 2, nil, "Tank")
--Stage One: Chaos
local warnEyeBeam						= mod:NewTargetAnnounce(264382, 2)
--local warnFixate						= mod:NewTargetAnnounce(264219, 2)
--Stage Two: Deception
local warnRoilingDeceit					= mod:NewTargetAnnounce(265360, 4)
--Stage Three: Corruption
local warnCorruptorsPact				= mod:NewTargetAnnounce(265662, 2)
local warnWillofCorruptor				= mod:NewTargetAnnounce(265646, 4, nil, false)

--General
local specWarnSurgingDarkness			= mod:NewSpecialWarningDodge(265451, nil, nil, nil, 3, 2)
local specWarnMightofVoid				= mod:NewSpecialWarningDefensive(267312, nil, nil, nil, 1, 2)
local specWarnShatter					= mod:NewSpecialWarningTaunt(265237, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage One: Chaos
local specWarnEyeBeam					= mod:NewSpecialWarningMoveAway(264382, nil, nil, nil, 1, 2)
local yellEyeBeam						= mod:NewYell(264382)
--local specWarnFixate					= mod:NewSpecialWarningRun(264219, nil, nil, nil, 4, 2)
--Stage Two: Deception
local specWarnRoilingDeceit				= mod:NewSpecialWarningMoveTo(265360, nil, nil, nil, 3, 7)
local yellRoilingDeceit					= mod:NewYell(265360)
local yellRoilingDeceitFades			= mod:NewFadesYell(265360)
local specWarnVoidbolt					= mod:NewSpecialWarningInterrupt(267180, "HasInterrupt", nil, nil, 1, 2)
--Stage Three: Corruption
local specWarnOrbOfCorruption			= mod:NewSpecialWarningCount(267239, nil, nil, nil, 2, 7)
local yellCorruptorsPact				= mod:NewFadesYell(265662)
local specWarnWillofCorruptorSoon		= mod:NewSpecialWarningSoon(265646, nil, nil, nil, 3, 2)
local specWarnWillofCorruptor			= mod:NewSpecialWarningSwitch(265646, "RangedDps", nil, nil, 1, 2)
local specWarnEntropicBlast				= mod:NewSpecialWarningInterrupt(270620, "HasInterrupt", nil, nil, 1, 2)

mod:AddTimerLine(GENERAL)
local timerSurgingDarknessCD			= mod:NewCDTimer(64.3, 265451, nil, "Melee", nil, 2, nil, DBM_CORE_DEADLY_ICON)--60 based on energy math
local timerMightofVoidCD				= mod:NewCDTimer(37.6, 267312, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerTitanSparkCD					= mod:NewCDTimer(37.6, 264954, nil, "Healer", nil, 2)
mod:AddTimerLine(SCENARIO_STAGE:format(1))
local timerQirajiWarriorCD				= mod:NewCDTimer(60, "ej18071", nil, nil, nil, 1, 31700)--UNKNOWN, TODO
local timerEyeBeamCD					= mod:NewCDTimer(40, 264382, nil, nil, nil, 3)
mod:AddTimerLine(SCENARIO_STAGE:format(2))
local timerAnubarCasterCD				= mod:NewCDTimer(80, "ej18397", nil, nil, nil, 1, 31700)--82
local timerRoilingDeceitCD				= mod:NewCDTimer(45, 265360, nil, nil, nil, 3)--61
--local timerVoidBoltCD					= mod:NewAITimer(19.9, 267180, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
mod:AddTimerLine(SCENARIO_STAGE:format(3))
local timerOrbofCorruptionCD			= mod:NewCDCountTimer(50, 267239, nil, nil, nil, 5)

--local berserkTimer					= mod:NewBerserkTimer(600)

local countdownSurgingDarkness			= mod:NewCountdown(64, 265451, true, nil, 3)
local countdownMightofVoid				= mod:NewCountdown("Alt37", 267312, "Tank", nil, 3)
--local countdownFelstormBarrage		= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddRangeFrameOption("8/10")
--mod:AddBoolOption("ShowAllPlatforms", false)
mod:AddSetIconOption("SetIconOnAdds", 267192, true, true)
mod:AddInfoFrameOption(265451, true)

mod.vb.phase = 1
mod.vb.orbCount = 0
mod.vb.addIcon = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.orbCount = 0
	self.vb.addIcon = 1
	timerTitanSparkCD:Start(10-delay)
	timerMightofVoidCD:Start(15-delay)
	countdownMightofVoid:Start(15-delay)
	timerSurgingDarknessCD:Start(25-delay)
	countdownSurgingDarkness:Start(25)
	timerEyeBeamCD:Start(52-delay)--Despite what journal says, this is always 52-54 regardless
	timerQirajiWarriorCD:Start(56-delay)--Despite what journal says, this is always 56-58 regardless
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
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 267180 then
		--timerVoidBoltCD:Start(args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnVoidbolt:Show(args.sourceName)
			specWarnVoidbolt:Play("kickcast")
		end
	elseif spellId == 267239 and self:AntiSpam(15, 4) then--Backup, in case emote doesn't fire for more than first one
		self.vb.orbCount = self.vb.orbCount + 1
		specWarnOrbOfCorruption:Show(self.vb.orbCount)
		specWarnOrbOfCorruption:Play("161612")--catch balls
		timerOrbofCorruptionCD:Start(50, self.vb.orbCount+1)
	elseif spellId == 270620 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnEntropicBlast:Show(args.sourceName)
		specWarnEntropicBlast:Play("kickcast")
	elseif spellId == 265231 then--First Void Lash
		timerMightofVoidCD:Start()
		countdownMightofVoid:Start()
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnMightofVoid:Show()
			specWarnMightofVoid:Play("defensive")
		end
	elseif spellId == 265530 then
		specWarnSurgingDarkness:Show()
		specWarnSurgingDarkness:Play("watchstep")
		if not self:IsMythic() then
			timerSurgingDarknessCD:Start(84)
			countdownSurgingDarkness:Start(84)
		else
			timerSurgingDarknessCD:Start()
			countdownSurgingDarkness:Start(64)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 264382 then
		if args:IsPlayer() then
			specWarnEyeBeam:Show()
			specWarnEyeBeam:Play("runout")
			yellEyeBeam:Yell()
		else
			warnEyeBeam:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 265264 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			warnVoidLash:Show(args.destName, amount)
		end
	elseif spellId == 265237 and not args:IsPlayer() then
		specWarnShatter:Schedule(4.5, args.destName)
		specWarnShatter:ScheduleVoice(4.5, "tauntboss")
	elseif spellId == 265360 then
		if args:IsPlayer() then
			specWarnRoilingDeceit:Show(DBM_CORE_ROOM_EDGE)
			specWarnRoilingDeceit:Play("runtoedge")
			yellRoilingDeceit:Yell()
			yellRoilingDeceitFades:Countdown(12)
		else
			warnRoilingDeceit:Show(args.destName)
		end
	elseif spellId == 265662 then
		warnCorruptorsPact:CombinedShow(0.5, args.destName)--Combined in case more than one soaks same ball (will happen in lfr/normal for sure or farm content for dps increases)
		if args:IsPlayer() then
			yellCorruptorsPact:Countdown(20)
			specWarnWillofCorruptorSoon:Schedule(16)
			specWarnWillofCorruptorSoon:ScheduleVoice(16, "takedamage")--use this voice? can you off yourself before the MC?
		end
	elseif spellId == 265646 then
		warnWillofCorruptor:CombinedShow(0.5, args.destName)
		if not DBM:UnitDebuff("player", args.spellName) then
			specWarnWillofCorruptor:Show()
			specWarnWillofCorruptor:Play("findmc")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 265360 then
		if args:IsPlayer() then
			yellRoilingDeceitFades:Cancel()
		end
	elseif spellId == 265662 then
		if args:IsPlayer() then
			yellCorruptorsPact:Cancel()
			specWarnWillofCorruptorSoon:Cancel()
			specWarnWillofCorruptorSoon:CancelVoice()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 134503 then--Qiraji Warrior

	elseif cid == 135083 then--Guardian of Yogg-Saron
	
	elseif cid == 135824 then--Anub'ar Voidweaver
		--timerVoidBoltCD:Stop(args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if not self:LatencyCheck() then return end
	if (msg == L.CThunDisc or msg:find(L.CThunDisc)) then
		self:SendSync("CThunDisc")
	elseif (msg == L.YoggDisc or msg:find(L.YoggDisc)) then
		self:SendSync("YoggDisc")
	elseif (msg == L.CorruptedDisc or msg:find(L.CorruptedDisc)) then
		self:SendSync("NzothDisc")
	end
end

--"<257.01 22:44:22> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\SPELL_PRIEST_SHADOWORBS.BLP:20|t The %s begins casting |cFFFF0000|Hspell:267334|h[Orb of Corruption]|h|r!#Warped Projection###N'Zoth Disc St
--"<260.26 22:44:25> [CLEU] SPELL_CAST_START#Creature-0-4028-1861-2952-135888-000075FF54#Warped Projection##nil#267239#Orb of Corruption#nil#nil", -- [3146]
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:267334") and self:AntiSpam(15, 4) then
		self.vb.orbCount = self.vb.orbCount + 1
		specWarnOrbOfCorruption:Show(self.vb.orbCount)
		specWarnOrbOfCorruption:Play("161612")--catch balls
		timerOrbofCorruptionCD:Start(50, self.vb.orbCount+1)
	elseif msg:find("spell:264382") then
		timerEyeBeamCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 266913 then--Spawn Qiraji Warrior
		timerQirajiWarriorCD:Start()
	elseif spellId == 267192 then--Spawn Anub'ar Caster
		timerAnubarCasterCD:Start()--80
	elseif spellId == 265437 then--Roiling Deceit
		--here because this spell ID fires at beginning of each set ONCE
		if self:IsMythic() then
			timerRoilingDeceitCD:Start()--45
		else
			timerRoilingDeceitCD:Start(60)
		end
	elseif spellId == 267019 then--Titan Spark
		if self:IsMythic() and self.vb.phase < 2 or self.vb.phase < 3 then
			timerTitanSparkCD:Start(20)
		else
			timerTitanSparkCD:Start(10)
		end
	elseif spellId == 267191 then--Anub'ar Caster Summon Cosmetic Beam
		if not GetRaidTargetIndex(uId) then--Not already marked
			if self.Options.SetIconOnAdds then
				SetRaidTarget(uId, self.vb.addIcon)
			end
			self.vb.addIcon = self.vb.addIcon + 1
			if self.vb.addIcon == 4 then
				self.vb.addIcon = 1
			end
		end
	end
end

function mod:OnSync(msg, targetname)
	if not self:IsInCombat() then return end
	if msg == "CThunDisc" and self:AntiSpam(5, 1) then
		--timerQirajiWarriorCD:Start(7)
		--timerEyeBeamCD:Start(31.1)
	elseif msg == "YoggDisc" and self:AntiSpam(5, 2) then
		self.vb.phase = 2
		if not self:IsMythic() then
			timerQirajiWarriorCD:Stop()
			timerEyeBeamCD:Stop()
		end
		timerAnubarCasterCD:Start(15.5)
		timerRoilingDeceitCD:Start(27.2)
	elseif msg == "NzothDisc" and self:AntiSpam(5, 3) then
		if not self:IsMythic() then
			self.vb.phase = 3
			timerAnubarCasterCD:Stop()
			timerRoilingDeceitCD:Stop()
		else
			self.vb.phase = 2
		end
		timerOrbofCorruptionCD:Start(14.1, 1)
	end
end
