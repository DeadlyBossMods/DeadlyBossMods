local mod	= DBM:NewMod(1896, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118460, 118462, 119072)--118460 Engine of Souls, 118462 Soul Queen Dajahna, 119072 The Desolate Host
mod:SetEncounterID(2054)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 235989 235927 238627 235968 236340 241566 236542 236544",
	"SPELL_CAST_SUCCES 236449 235933 235907 236138 236131 235969 236515",
	"SPELL_AURA_APPLIED 236459 235924 238018 236513 236138 236131 235969 236515 236361 239923 236548",
	"SPELL_AURA_APPLIED_DOSE 236548",
	"SPELL_AURA_REMOVED 236459 235924 236513 235969 236515",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, see if syncing is needed. for time being it's assumed the two phases don't share information
--TODO, bone shards needed? Seems lke a basic spammed ability that targets tank
--TODO, collapsing Fissure event/spellid probably wrong. only not script spell id was damage, so probably UNIT_SPELLCAST event/script needed for timer/warning
--TODO, improve tormenting cries voice
--TODO, evalulate adds warnings/timers, because need to keep unimportant stuff out of clutter
--TODO, interrupt count/rotation setup? Of course that might be a mess with realm swaps.
--TODO, new voice "switchphase" (Switch Phase). I suspect it'l be used on a lot of warnings here like wither, tank swaps, etc.
--TODO, figure out when withered souls casts. right now based on interaction and both having 1 minute duration I highly suspect it always follows withered
--TODO, what to do with spirit chains?
--TODO, infoframe add tracker? or infoframe debuff tracker (adds with bone armor count and players with screach count, etc)
--Corporeal Realm
local warnSpearofAnguish			= mod:NewTargetAnnounce(235924, 3)
local warnCollapsingFissure			= mod:NewSpellAnnounce(235907, 3)--Upgrade to special, if needed
local warnTormentingCries			= mod:NewTargetAnnounce(238018, 3)
----Adds
local warnRupturingSlam				= mod:NewSpellAnnounce(235927, 3)
local warnGraspingDarkness			= mod:NewSpellAnnounce(235968, 3)
local warnBonecageArmor				= mod:NewTargetAnnounce(236513, 3)
--Spirit Realm
local warnSoulbind					= mod:NewTargetAnnounce(228003, 4)
local warnWither					= mod:NewTargetAnnounce(236138, 3)
local warnShatteringScream			= mod:NewTargetAnnounce(235969, 4)--This warning DOES need to be cross phase
local warnSpiritChains				= mod:NewTargetAnnounce(236361, 3)
--Desolate Host
local warnTorment					= mod:NewStackAnnounce(236548, 3)

--Corporeal Realm
local specWarnSpearofAnguish		= mod:NewSpecialWarningYou(235924, nil, nil, nil, 1, 2)
local yellSpearofAnguish			= mod:NewFadesYell(235924)
local specWarnTormentingCries		= mod:NewSpecialWarningYou(238018, nil, nil, nil, 1, 2)
--Spirit Realm
local specWarnCrushMind				= mod:NewSpecialWarningInterrupt(236340, "HasInterrupt", nil, nil, 1, 2)
local specWarnSoulbind				= mod:NewSpecialWarningYou(236459, nil, nil, nil, 3, 2)
local yellSoulbind					= mod:NewYell(236459)
local specWarnWither				= mod:NewSpecialWarningYou(236138, nil, nil, nil, 1, 7)
local specWarnShatteringScream		= mod:NewSpecialWarningMoveTo(235969, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(235969), nil, 3, 2)
--The Desolate Host
local specWarnSunderingDoomGather	= mod:NewSpecialWarningMoveTo(236542, nil, nil, nil, 1, 2)
local specWarnSunderingDoomRun		= mod:NewSpecialWarningRun(236542, nil, nil, nil, 4, 2)
local specWarnDoomedSunderingGather	= mod:NewSpecialWarningMoveTo(236544, nil, nil, nil, 1, 2)
local specWarnDoomedSunderingRun	= mod:NewSpecialWarningRun(236544, nil, nil, nil, 4, 2)

--Corporeal Realm
local timerSpearofAnquishCD			= mod:NewAITimer(31, 235924, nil, nil, nil, 3)
local timerCollapsingFissureCD		= mod:NewAITimer(31, 235907, nil, nil, nil, 3)
local timerTormentedCriesCD			= mod:NewAITimer(31, 235989, nil, nil, nil, 3)
--Spirit Realm
local timerSoulbindCD				= mod:NewAITimer(31, 236459, nil, nil, nil, 3)--Should be shown to both phases, cause it picks targets from both
local timerWitherCD					= mod:NewAITimer(31, 236138, nil, nil, nil, 3)
local timerShatteringScreamCD		= mod:NewAITimer(31, 235969, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Corporeal Realm
local voiceSpearofAnguish			= mod:NewVoice(235924)--runout
local voiceTormentingCries			= mod:NewVoice(238018)--targetyou (another generic until I know what to do with these). Might be a "keepmove" event
--Spirit Realm
local voiceCrushMind				= mod:NewVoice(236340, "HasInterrupt")--kickcast
local voiceSoulbind					= mod:NewVoice(236459)--targetyou (should give at least one of the players "switchphase" but not both of them)
local voiceWither					= mod:NewVoice(236138)--switchphase
local voiceShatteringScream			= mod:NewVoice(235969)--getboned (kinda close enough? maybe custom new one later)

local voiceSunderingDoom			= mod:NewVoice(236542)--gathershare/justrun
local voiceDoomedSunderin			= mod:NewVoice(236544)--gathershare/justrun

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
mod:AddRangeFrameOption(5, 236459)
mod:AddNamePlateOption("NPAuraOnSpearofAnguish", 235924)
mod:AddNamePlateOption("NPAuraOnSoulbind", 236459)
mod:AddNamePlateOption("NPAuraOnBonecageArmor", 236513)
mod:AddNamePlateOption("NPAuraOnShatteringScream", 235969)

local spiritRealm = GetSpellInfo(235621)

function mod:OnCombatStart(delay)
	timerSoulbindCD:Start(1-delay)
	timerSpearofAnquishCD:Start(1-delay)
	timerTormentedCriesCD:Start(1-delay)
	timerCollapsingFissureCD:Start(1-delay)
	timerWitherCD:Start(1-delay)
	if self.Options.NPAuraOnSoulbind or self.Options.NPAuraOnSpearofAnguish or self.Options.NPAuraOnShatteringScream then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
	if self.Options.NPAuraOnBonecageArmor then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnSoulbind or self.Options.NPAuraOnSpearofAnguish or self.Options.NPAuraOnBonecageArmor or self.Options.NPAuraOnShatteringScream then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true, true)--Uses both hostile and friendly
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	--Looks like it'd be excessive comms but the spellid filter will make sure it isn't.
	self:SendSync("SpellCastStart", spellId, args.sourceGUID)
	if spellId == 235927 or spellId == 238627 then
		warnRupturingSlam:Show()
	elseif spellId == 235968 then
		warnGraspingDarkness:Show()
	elseif (spellId == 236340 or spellId == 241566) then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnCrushMind:Show(args.sourceName)
			voiceCrushMind:Play("kickcast")
		end
	elseif spellId == 236542 then
		if UnitBuff("player", spiritRealm) or UnitDebuff("player", spiritRealm) then--Figure out which it is
			specWarnSunderingDoomRun:Show()
			voiceSunderingDoom:Play("justrun")
		else
			specWarnSunderingDoomGather:Show(COMPACT_UNIT_FRAME_PROFILE_SORTBY_GROUP)
			voiceSunderingDoom:Play("gathershare")
		end
	elseif spellId == 236544 then
		if UnitBuff("player", spiritRealm) or UnitDebuff("player", spiritRealm) then--Figure out which it is
			specWarnDoomedSunderingGather:Show(COMPACT_UNIT_FRAME_PROFILE_SORTBY_GROUP)
			voiceDoomedSunderin:Play("gathershare")
		else
			specWarnDoomedSunderingRun:Show()
			voiceDoomedSunderin:Play("justrun")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	--Looks like it'd be excessive comms but the spellid filter will make sure it isn't.
	self:SendSync("SpellCastSuccess", spellId, args.sourceGUID)
	if spellId == 235907 then
		warnCollapsingFissure:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	--Looks like it'd be excessive comms but the spellid filter will make sure it isn't.
	self:SendSync("SpellAuraApplied", spellId, args.destGUID)
	--Continue to handle personal warnings via direct combat log, not syncs.
	if spellId == 236459 and args:IsPlayer() then
		specWarnSoulbind:Show()
		voiceSoulbind:Play("targetyou")
		yellSoulbind:Yell()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	elseif spellId == 235924 then
		if args:IsPlayer() then
			specWarnSpearofAnguish:Show()
			voiceSpearofAnguish:Play("runout")
			yellSpearofAnguish:Schedule(5, 1)
			yellSpearofAnguish:Schedule(4, 2)
			yellSpearofAnguish:Schedule(3, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		else
			warnSpearofAnguish:Show(args.destName)
		end
	elseif spellId == 238018 then
		if args:IsPlayer() then
			specWarnTormentingCries:Show()
			voiceTormentingCries:Play("targetyou")
		else
			warnTormentingCries:CombinedShow(0.3, args.destName)--Uncombine if only 1 target
		end
	elseif spellId == 236513 then
		warnBonecageArmor:Show(args.destName)
	elseif (spellId ==  236138 or spellId == 236131) then
		warnWither:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWither:Show()
			voiceWither:Play("switchphase")
		end
	elseif (spellId == 235969 or spellId == 236515) and args:IsPlayer() then
		specWarnShatteringScream:Show()
		voiceShatteringScream:Play("getboned")
	elseif spellId == 236361 or spellId == 239923 then
		warnSpiritChains:CombinedShow(0.3, args.destName)
	elseif spellId == 236548 then
		local amount = args.amount or 1
		warnTorment:Cancel()
		warnTorment:Schedule(0.5, args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	--Looks like it'd be excessive comms but the spellid filter will make sure it isn't.
	self:SendSync("SpellAuraRemoved", spellId, args.destGUID)
	if spellId == 236459 and args:IsPlayer() then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 235924 and args:IsPlayer() then
		yellSpearofAnguish:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 119938 then--Reanimated templar
	
	elseif cid == 119939 then--Ghastly Bonewarden
	
	elseif cid == 119940 then--Fallen Priestess
		self:SendSync("UnitDied", cid, args.destGUID)
	end
end

local playerName = UnitName("player")
function mod:OnSync(msg, stringSpellId, targetGUID)
	if not self:IsInCombat() or not stringSpellId then return end
	local spellId = tonumber(stringSpellId)
	local target = DBM:GetFullPlayerNameByGUID(targetGUID)
	if msg == "SpellAuraApplied" and targetGUID then
		if spellId == 236459 then--Soulbind
			warnSoulbind:CombinedShow(0.5, target)
			if self.Options.NPAuraOnSoulbind then
				DBM.Nameplate:Show(true, targetGUID, spellId, nil, 60)
			end
		elseif spellId == 235924 then--Spear of Anguish
			if self.Options.NPAuraOnSpearofAnguish then
				DBM.Nameplate:Show(true, targetGUID, spellId, nil, 6)
			end
		elseif spellId == 236513 then--Bonecage Armor
			if self.Options.NPAuraOnBonecageArmor then
				DBM.Nameplate:Show(true, targetGUID, spellId, nil, 60)
			end
		elseif spellId == 235969 or spellId == 236515 then--Shattering Scream
			warnShatteringScream:CombinedShow(0.5, target)
			if self.Options.NPAuraOnShatteringScream then
				DBM.Nameplate:Show(true, targetGUID, spellId, nil, 7.5)
			end
		end
	elseif msg == "SpellAuraRemoved" and targetGUID then
		if spellId == 236459 then
			if self.Options.NPAuraOnSoulbind then
				DBM.Nameplate:Hide(true, targetGUID, spellId)
			end
		elseif spellId == 235924 then--Spear of Anguish
			if self.Options.NPAuraOnSpearofAnguish then
				DBM.Nameplate:Hide(true, targetGUID, spellId)
			end
		elseif spellId == 236513 then--Bonecage Armor
			if self.Options.NPAuraOnBonecageArmor then
				DBM.Nameplate:Hide(true, targetGUID, spellId)
			end
		elseif spellId == 235969 or spellId == 236515 then--Shattering Scream
			if self.Options.NPAuraOnShatteringScream then
				DBM.Nameplate:Hide(true, targetGUID, spellId)
			end
		end
	elseif msg == "SpellCastStart" then
		if spellId == 235989 then--Tormented Cries
			timerTormentedCriesCD:Start()
		end
	elseif msg == "SpellCastSuccess" then
		if spellId == 236449 then--Soulbind Cast
			timerSoulbindCD:Start()
		elseif spellId == 235933 then--Spear of Anquish
			timerSpearofAnquishCD:Start()
		elseif spellId == 235907 then
			timerCollapsingFissureCD:Start()
		elseif spellId ==  236138 or spellId == 236131 then
			timerWitherCD:Start()
		elseif spellId == 235969 or spellId == 236515 then--Shattering Scream
			timerShatteringScreamCD:Start(nil, targetGUID)
		end
	elseif msg == "UnitDied" then
		if spellId == 119940 then--Not technically spellid but passed in same arg and already tonumbered so perfect arg
			timerShatteringScreamCD:Stop(targetGUID)
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
--		specWarnDancingBlade:Show()
--		voiceDancingBlade:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 227503 then

	end
end
--]]
