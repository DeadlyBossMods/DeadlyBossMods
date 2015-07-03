local mod	= DBM:NewMod(1394, "DBM-HellfireCitadel", nil, 669)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(90269)
mod:SetEncounterID(1784)
mod:SetZone()
--mod:SetUsedIcons(8, 7, 6, 4, 2, 1)
mod.respawnTime = 39--Def less than 40 but much greater than 30. i have a video of a 38 second respawn

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180260 180004 180533 180025 180608 180300",
	"SPELL_CAST_SUCCESS 179986 179991 180600 180526",
	"SPELL_AURA_APPLIED 182459 185241 180166 180164 185237 185238 180526 180025 180000",
	"SPELL_AURA_APPLIED_DOSE 180000",
	"SPELL_AURA_REMOVED 182459 185241",
	"SPELL_PERIODIC_DAMAGE 180604",
	"SPELL_ABSORBED 180604",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--(ability.id = 180260 or ability.id = 180004 or ability.id = 180025 or ability.id = 180608 or ability.id = 180300 or ability.id = 180533) and type = "begincast" or (ability.id = 179986 or ability.id = 179991 or ability.id = 180600 or ability.id = 180526) and type = "cast" or (ability.id = 182459 or ability.id = 185241 or ability.id = 180166 or ability.id = 185237) and type = "applydebuff" or ability.id = 180000 and not type = "removedebuff"
--All
local warnEdictofCondemnation				= mod:NewTargetCountAnnounce(182459, 3)
local warnTouchofHarm						= mod:NewTargetAnnounce(180166, 3, nil, "Healer")--Todo, split new cast and jump into two different warnings?
local warnSealofDecay						= mod:NewStackAnnounce(180000, 2, nil, "Tank|Healer")
--Stage One: Oppression
local warnAnnihilationStrike				= mod:NewTargetCountAnnounce(180260, 4)
--Stage Two: Contempt
local warnAuraofContempt					= mod:NewSpellAnnounce(179986, 3)
local warnTaintedShadows					= mod:NewSpellAnnounce(180533, 2, nil, false)--Every 5 seconds, spammy
local warnFontofCorruption					= mod:NewTargetAnnounce(180526, 3)
--Stage Three: Malice
local warnAuraofMalice						= mod:NewSpellAnnounce(179991, 3)
local warnBulwarkoftheTyrant				= mod:NewTargetCountAnnounce(180600, 2)

--All
local specWarnEdictofCondemnation			= mod:NewSpecialWarningYou(182459, nil, nil, nil, 1, 2)
local specWarnEdictofCondemnationOther		= mod:NewSpecialWarningMoveTo(185241, "Ranged")--Mythic, they can't run in, you have to run to them, they are rooted.
local yellEdictofCondemnation				= mod:NewFadesYell(182459)
local specWarnTouchofHarm					= mod:NewSpecialWarningTarget(180166, false)
local specWarnSealofDecay					= mod:NewSpecialWarningStack(180000, nil, 2)
local specWarnSealofDecayOther				= mod:NewSpecialWarningTaunt(180000, nil, nil, nil, nil, 2)
--Stage One: Oppression
local specWarnAnnihilatingStrike			= mod:NewSpecialWarningYou(180260)
local specWarnAnnihilatingStrikeNear		= mod:NewSpecialWarningClose(180260)
local yellAnnihilatingStrike				= mod:NewYell(180260)
local specWarnInfernalTempest				= mod:NewSpecialWarningCount(180300, nil, nil, nil, 2, 2)
----Ancient Enforcer
local specWarnAncientEnforcer				= mod:NewSpecialWarningSwitch("ej11155", "-Healer")
local specWarnEnforcersOnslaught			= mod:NewSpecialWarningDodge(180004, nil, nil, nil, 1, 5)
--Stage Two: Contempt
local specWarnFontofCorruption				= mod:NewSpecialWarningYou(180526)
local yellFontofCorruption					= mod:NewYell(180526)
----Ancient Harbinger
local specWarnAncientHarbinger				= mod:NewSpecialWarningSwitch("ej11163", "-Healer")
local specWarnHarbingersMending				= mod:NewSpecialWarningInterrupt(180025, "-Healer", nil, nil, 1, 2)
local specWarnHarbingersMendingDispel		= mod:NewSpecialWarningDispel(180025, "MagicDispeller")--if interrupt is missed (likely at some point, cast gets faster each time). Then it MUST be dispelled
--Stage Three: Malice
local specWarnDespoiledGround				= mod:NewSpecialWarningMove(180604)
local specWarnGaveloftheTyrant				= mod:NewSpecialWarningCount(180608, nil, nil, nil, 2, 2)
----Ancient Sovereign
local specWarnAncientSovereign				= mod:NewSpecialWarningSwitch("ej11170", "-Healer")

mod:AddTimerLine(ALL)--All
local timerSealofDecayCD					= mod:NewCDTimer(6, 180000, nil, false)--I don't think it's really needed, but at least make it an option
local timerEdictofCondemnationCD			= mod:NewNextCountTimer(60, 182459)
local timerTouchofHarmCD					= mod:NewNextCountTimer(45, 180166, nil, "Healer")
mod:AddTimerLine(SCENARIO_STAGE:format(1))--Stage One: Oppression
local timerAnnihilatingStrikeCD				= mod:NewNextCountTimer(10, 180260)
local timerInfernalTempestCD				= mod:NewNextCountTimer(10, 180300)
----Ancient Enforcer
local timerEnforcersOnslaughtCD				= mod:NewCDTimer(18, 180004, nil, "Tank")
mod:AddTimerLine(SCENARIO_STAGE:format(2))--Stage Two: Contempt
local timerTaintedShadowsCD					= mod:NewNextTimer(5, 180533, nil, "Tank")
local timerFontofCorruptionCD				= mod:NewNextTimer(20, 180526)
----Ancient Harbinger
local timerHarbingersMendingCD				= mod:NewCDTimer(11, 180025)
mod:AddTimerLine(SCENARIO_STAGE:format(3))--Stage Three: Malice
local timerBulwarkoftheTyrantCD				= mod:NewNextCountTimer(10, 180600)
local timerGaveloftheTyrantCD				= mod:NewNextCountTimer(10, 180608)

--local berserkTimer						= mod:NewBerserkTimer(360)

local countdownAnnihilatingStrike			= mod:NewCountdown(10, 180260, nil, nil, 3)--It's same cd as Infernal tempest so going to use countdown for both. Starting count at 3 to avoid so much spam. every 10 seconds, 5-1 would be bit much. 3-1 important though

local voicePhaseChange						= mod:NewVoice(nil, nil, DBM_CORE_AUTO_VOICE2_OPTION_TEXT)
local voiceInfernalTempest					= mod:NewVoice(180300)--scatter
local voiceEdictofCondemnation				= mod:NewVoice(182459)--runin or gather (mythic)
local voiceHarbingersMending				= mod:NewVoice(180025)--kickcast/dispelboss
local voiceGaveloftheTyrant					= mod:NewVoice(180608)--carefly
local voiceEnforcerOnslaught				= mod:NewVoice(180004)--watchorb
local voiceSealofDecay						= mod:NewVoice(180000)--tauntboss

mod:AddRangeFrameOption(5)--Seems like range 5 for all spells. I think for this fight it's basically a constant spread out fight when possible to avoid extra damage.
mod:AddHudMapOption("HudMapOnStrike", 180260)
mod:AddHudMapOption("HudMapEdict", 182459)

mod.vb.touchofHarmCount = 0
mod.vb.edictCount = 0
mod.vb.infernalTempestCount = 0
mod.vb.annihilationCount = 0
mod.vb.bulwarkCount = 0
mod.vb.gavelCount = 0
local AncientEnforcer = EJ_GetSectionInfo(11155)
local AncientHarbinger = EJ_GetSectionInfo(11163)
local AncientSovereign = EJ_GetSectionInfo(11170)
local TyrantVelhari = EJ_GetEncounterInfo(1394)

function mod:AnnTarget(targetname, uId)
	if not targetname then
		warnAnnihilationStrike:Show(self.vb.annihilationCount, DBM_CORE_UNKNOWN)
		return
	end
	if targetname == UnitName("player") then
		specWarnAnnihilatingStrike:Show()
		yellAnnihilatingStrike:Yell()
	elseif self:CheckNearby(5, targetname) then
		specWarnAnnihilatingStrikeNear:Show(targetname)
	else
		warnAnnihilationStrike:Show(self.vb.annihilationCount, targetname)
	end
	if self.Options.HudMapOnStrike then
		DBMHudMap:RegisterRangeMarkerOnPartyMember(180260, "highlight", targetname, 5, 4, 1, 0, 0, 0.5, nil, true, 2):Pulse(0.5, 0.5)
	end
end

function mod:OnCombatStart(delay)
	self.vb.touchofHarmCount = 0
	self.vb.edictCount = 0
	self.vb.annihilationCount = 0
	self.vb.infernalTempestCount = 0
	self.vb.bulwarkCount = 0
	self.vb.gavelCount = 0
	timerSealofDecayCD:Start(3.5-delay)
	timerAnnihilatingStrikeCD:Start(10-delay, 1)
	timerTouchofHarmCD:Start(16.8-delay, 1)
	timerEdictofCondemnationCD:Start(57-delay, 1)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnStrike or self.Options.HudMapEdict then
		DBMHudMap:Disable()
	end
end 

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180260 then
		self.vb.annihilationCount = self.vb.annihilationCount + 1
		if self.vb.annihilationCount == 3 then--Infernal tempest next
			timerInfernalTempestCD:Start(10, self.vb.infernalTempestCount+1)
		else
			timerAnnihilatingStrikeCD:Start(nil, self.vb.annihilationCount+1)
		end
		countdownAnnihilatingStrike:Start()
		self:BossTargetScanner(90269, "AnnTarget", 0.05, 20, true)
	elseif spellId == 180004 then
		specWarnEnforcersOnslaught:Show()
		voiceEnforcerOnslaught:Play("watchorb")
		timerEnforcersOnslaughtCD:Start()
	elseif spellId == 180025 then--No target filter, it's only interrupt onfight and it's VERY important
		specWarnHarbingersMending:Show(args.sourceName)
		timerHarbingersMendingCD:Start()
		if not self:IsHealer() then
			voiceHarbingersMending:Play("kickcast")
		end
	elseif spellId == 180608 then
		self.vb.gavelCount = self.vb.gavelCount+1
		specWarnGaveloftheTyrant:Show(self.vb.gavelCount)
		voiceGaveloftheTyrant:Play("carefly")
		timerBulwarkoftheTyrantCD:Start(nil, 1)
	elseif spellId == 180300 then
		self.vb.infernalTempestCount = self.vb.infernalTempestCount + 1
		specWarnInfernalTempest:Show(self.vb.infernalTempestCount)
		voiceInfernalTempest:Play("scatter")
		self.vb.annihilationCount = 0
		timerAnnihilatingStrikeCD:Start(nil, 1)
		countdownAnnihilatingStrike:Start()
	elseif spellId == 180533 then
		warnTaintedShadows:Show()
		timerTaintedShadowsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 179986 then--Aura of Contempt (phase 2)
		warnAuraofContempt:Show()
		--Cancel phase 1 abilities
		timerAnnihilatingStrikeCD:Cancel()
		countdownAnnihilatingStrike:Cancel()
		timerInfernalTempestCD:Cancel()
		timerTaintedShadowsCD:Start()
		timerFontofCorruptionCD:Start(22)
		voicePhaseChange:Play("ptwo")
	elseif spellId == 179991 then--Aura of Malice (phase 3)
		warnAuraofMalice:Show()
		timerFontofCorruptionCD:Cancel()
		timerBulwarkoftheTyrantCD:Start(nil, 1)
		voicePhaseChange:Play("pthree")
	elseif spellId == 180600 then
		self.vb.bulwarkCount = self.vb.bulwarkCount + 1
		warnBulwarkoftheTyrant:Show(self.vb.bulwarkCount, args.destName)
		if self.vb.bulwarkCount == 3 then
			timerGaveloftheTyrantCD:Start(nil, self.vb.gavelCount+1)
		else
			timerBulwarkoftheTyrantCD:Start(nil, self.vb.bulwarkCount+1)
		end
	elseif spellId == 180526 then
		timerFontofCorruptionCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 182459 or spellId == 185241 then--185241 mythic root version
		self.vb.edictCount = self.vb.edictCount + 1
		warnEdictofCondemnation:Show(self.vb.edictCount, args.destName)
		timerEdictofCondemnationCD:Start(nil, self.vb.edictCount+1)
		if args:IsPlayer() then
			specWarnEdictofCondemnation:Show()
			if not self:IsMythic() then
				--If not mythic, just run it into melee, like flamebender
				--Movement does damage to players so 1 person moving better than many
				voiceEdictofCondemnation:Play("runin")
			end
			yellEdictofCondemnation:Schedule(8, 1)
			yellEdictofCondemnation:Schedule(7, 2)
			yellEdictofCondemnation:Schedule(6, 3)
			yellEdictofCondemnation:Schedule(5, 4)
			yellEdictofCondemnation:Schedule(4, 5)
		elseif self:IsMythic() then
			--Good delay? More adjusting needed? probably don't want to run in and stand there 9 seconds
			--you want to spread. for too many mechanics, so currently runs you in at 4.5 seconds remaining
			specWarnEdictofCondemnationOther:Schedule(5, args.destName)
			if self.Options.SpecWarn185241moveto then--This specific voice only meant for specWarnEdictofCondemnationOther
				voiceEdictofCondemnation:Schedule(5, "gather")
			end
		end
		if self.Options.HudMapEdict then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(spellId, "highlight", args.destName, 3, 9, 1, 1, 0, 0.5, nil, true, 1):Pulse(0.5, 0.5)
		end
	elseif args:IsSpellID(180166, 185237) then--Casts
		self.vb.touchofHarmCount = self.vb.touchofHarmCount + 1
		timerTouchofHarmCD:Start(nil, self.vb.touchofHarmCount+1)
		if self.Options.SpecWarn180166target then
			specWarnTouchofHarm:Show(0.3, args.destName)--Only one target, but combined show in case you do something crazy like mass dispel or something and trigger a bunch of jumps
		else
			warnTouchofHarm:CombinedShow(0.3, args.destName)
		end
	elseif args:IsSpellID(180164, 185238) then--Jumps
		if self.Options.SpecWarn180166target then
			specWarnTouchofHarm:CombinedShow(0.3, args.destName)--Only one target, but combined show in case you do something crazy like mass dispel or something and trigger a bunch of jumps
		else
			warnTouchofHarm:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 180526 then
		warnFontofCorruption:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnFontofCorruption:Show()
			yellFontofCorruption:Yell()
		end
	elseif spellId == 180025 then
		specWarnHarbingersMendingDispel:Show(args.destName)
		if self:IsMagicDispeller() then
			voiceHarbingersMending:Play("dispelboss")
		end
	elseif spellId == 180000 then
		warnSealofDecay:Show(args.destName, 1)
		timerSealofDecayCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 180000 then--Omitting 1 stack since this stacks frequently, so DBM only announces 2/3 instead of 1-3 on something cast every 5 seconds.
		timerSealofDecayCD:Start()
		local amount = args.amount
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnSealofDecay:Show(amount)
			else
				local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)
				local debuffTime = 0
				if expires then
					debuffTime = expires - GetTime()
				end
				--Swap at 2 WHEN POSSIBLE but sometimes you have to go to 3.
				if debuffTime < 6 and not UnitIsDeadOrGhost("player") then
					specWarnSealofDecayOther:Show(args.destName)
					voiceSealofDecay:Play("tauntboss")
				else
					warnSealofDecay:Show(args.destName, amount)
				end
			end
		else
			warnSealofDecay:Show(args.destName, amount)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 182459 or spellId == 185241 then
		--For icon option, or something.
		if self.Options.HudMapEdict then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 180604 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnDespoiledGround:Show()
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if npc == AncientEnforcer then
		specWarnAncientEnforcer:Show()
		timerEnforcersOnslaughtCD:Start()
	elseif target and target == TyrantVelhari and npc == AncientHarbinger then--Emotes with npc name as AncientHarbinger also fire for heals, but those emotes, target is nil or "". spawn emote, target is boss name
		specWarnAncientHarbinger:Show()
		timerHarbingersMendingCD:Start(19)
	elseif npc == AncientSovereign then
		specWarnAncientSovereign:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 91304 or cid == 90270 then--Ancient Enforcer
		timerEnforcersOnslaughtCD:Cancel()
	elseif cid == 91302 or cid == 90271 then--Ancient Harbinger
		timerHarbingersMendingCD:Cancel()
	elseif cid == 91303 or cid == 90272 then--Ancient Sovereign
		--Doesn't use anything interesting? Shield cd probably won't seem useful, but who knows
	end
end
