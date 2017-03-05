local mod	= DBM:NewMod(1896, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(118460, 118462, 119072)--118460 Engine of Souls, 118462 Soul Queen Dajahna, 119072 The Desolate Host
mod:SetEncounterID(2054)
mod:SetZone()
mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 40

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 238570 235927 236542 236544",
	"SPELL_CAST_SUCCESS 236449 235933 236138 236131 235969",
	"SPELL_AURA_APPLIED 236459 235924 238018 236513 236138 236131 235969 236361 239923 236548",
	"SPELL_AURA_APPLIED_DOSE 236548",
	"SPELL_AURA_REMOVED 236459 235924 236513 235969",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"UNIT_AURA_UNFILTERED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, improve tormenting cries voice
--TODO, interrupt count/rotation setup? Of course that might be a mess with realm swaps.
--TODO, new voice "switchphase" (Switch Phase). I suspect it'l be used on a lot of warnings here like wither, tank swaps, etc.
--TODO, figure out when withered souls casts. right now based on interaction and both having 1 minute duration I highly suspect it always follows withered
--TODO, what to do with spirit chains?
--TODO, 235907 (Collapsing Fissure) has all over the place timers, fixiable?
--TODO, adds timers (not incombat log, robably need videos/scheduling
--TODO, range frame probably won't work cross phase since it relies on item checks which would return false cross realms. 
--TODO more work on tormenting cries and resuming/restarting timers when it's over. have no pull logs where it ended. maybe LFR can fix
--[[
(ability.id = 238570 or ability.id = 235927 or ability.id = 236542 or ability.id = 236544) and type = "begincast" or
(ability.id = 235907 or ability.id = 236072 or ability.id = 236507 or ability.id = 235969 or ability.id = 236449 or ability.id =  236138 or ability.id = 236131) and type = "cast" or
(ability.id = 235924) and type = "applydebuff" or
ability.id = 236072 and (type = "applybuff" or type = "removebuff") or
(ability.id = 236459 or ability.id = 235969 or ability.id = 236513) and (type = "applydebuff" or type = "removedebuff" or type = "applybuff" or type = "removebuff")
--]]
--Corporeal Realm
local warnSpearofAnguish			= mod:NewTargetAnnounce(235924, 3)
local warnCollapsingFissure			= mod:NewSpellAnnounce(235907, 3)--Upgrade to special, if needed
local warnTormentingCries			= mod:NewTargetAnnounce(238018, 3)--Spammy? off by default?
----Adds
local warnRupturingSlam				= mod:NewSpellAnnounce(235927, 3)
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
local specWarnSoulbind				= mod:NewSpecialWarningYou(236459, nil, nil, nil, 3, 2)
local yellSoulbind					= mod:NewYell(236459)
local specWarnWither				= mod:NewSpecialWarningYou(236138, nil, nil, nil, 1, 7)
local specWarnShatteringScream		= mod:NewSpecialWarningMoveTo(235969, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(235969), nil, 3, 2)
local specWarnWailingSouls			= mod:NewSpecialWarningCount(236072, nil, nil, nil, 2, 2)
--The Desolate Host
local specWarnSunderingDoomGather	= mod:NewSpecialWarningMoveTo(236542, nil, nil, nil, 1, 2)
local specWarnSunderingDoomRun		= mod:NewSpecialWarningRun(236542, nil, nil, nil, 4, 2)
local specWarnDoomedSunderingGather	= mod:NewSpecialWarningMoveTo(236544, nil, nil, nil, 1, 2)
local specWarnDoomedSunderingRun	= mod:NewSpecialWarningRun(236544, nil, nil, nil, 4, 2)

--Corporeal Realm
local timerSpearofAnquishCD			= mod:NewCDTimer(20, 235924, nil, nil, nil, 3)
--local timerCollapsingFissureCD		= mod:NewAITimer(31, 235907, nil, nil, nil, 3)
local timerTormentedCriesCD			= mod:NewCDTimer(31, 238570, nil, nil, nil, 3)
local timerRupturingSlamCD			= mod:NewCDTimer(23, 235927, nil, nil, nil, 3)--23 seconds, per add
--Spirit Realm
local timerSoulbindCD				= mod:NewCDCountTimer(24, 236459, nil, nil, nil, 3)
local timerWitherCD					= mod:NewCDTimer(9.4, 236138, nil, nil, nil, 3)
local timerShatteringScreamCD		= mod:NewCDTimer(12, 235969, nil, nil, nil, 3)--12 seconds, per add
local timerWailingSoulsCD			= mod:NewCDCountTimer(60, 236072, nil, nil, nil, 2)

--local berserkTimer				= mod:NewBerserkTimer(300)

--local countdownDrawPower			= mod:NewCountdown(33, 227629)

--Corporeal Realm
local voiceSpearofAnguish			= mod:NewVoice(235924)--runout
local voiceTormentingCries			= mod:NewVoice(238018)--targetyou (another generic until I know what to do with these). Might be a "keepmove" event
--Spirit Realm
local voiceSoulbind					= mod:NewVoice(236459)--targetyou (should give at least one of the players "switchphase" but not both of them)
local voiceWither					= mod:NewVoice(236138)--switchphase
local voiceShatteringScream			= mod:NewVoice(235969)--getboned (kinda close enough? maybe custom new one later)
local voiceWailingSouls				= mod:NewVoice(236072)--aesoon

local voiceSunderingDoom			= mod:NewVoice(236542)--gathershare/justrun
local voiceDoomedSunderin			= mod:NewVoice(236544)--gathershare/justrun

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
mod:AddInfoFrameOption(235621, true)
mod:AddRangeFrameOption(5, 236459)
mod:AddNamePlateOption("NPAuraOnBonecageArmor", 236513)

mod.vb.soulboundCast = 0
mod.vb.wailingSoulsCast = 0
mod.vb.boneArmorCount = 0
local spiritRealm, corpRealm = GetSpellInfo(235621), EJ_GetSectionInfo(14856)
local boneArmor = GetSpellInfo(236513)
local playersInSpirit = {}
local playersNotInSpirit = {}

local spiritFilter, regularFilter
local UnitDebuff = UnitDebuff
do
	spiritFilter = function(uId)
		if UnitDebuff(uId, spiritRealm) then
			return true
		end
	end
	regularFilter = function(uId)
		if not UnitDebuff(uId, spiritRealm) then
			return true
		end
	end
end

local updateInfoFrame, sortInfoFrame
do
	local lines = {}
	--[[sortInfoFrame = function(a, b)
		local a = lines[a]
		local b = lines[b]
		if not tonumber(a) then a = -1 end
		if not tonumber(b) then b = -1 end
		if a > b then return true else return false end
	end--]]

	updateInfoFrame = function()
		table.wipe(lines)
		lines[spiritRealm] = #playersInSpirit
		lines[corpRealm] = #playersNotInSpirit
		lines[boneArmor] = mod.vb.boneArmorCount
		return lines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(playersInSpirit)
	table.wipe(playersNotInSpirit)
	self.vb.soulboundCast = 0
	self.vb.wailingSoulsCast = 0
	self.vb.boneArmorCount = 0
	--timerCollapsingFissureCD:Start(9.7-delay)
	timerSoulbindCD:Start(14.2-delay, 1)
	timerSpearofAnquishCD:Start(22-delay)
	timerWitherCD:Start(23-delay)
	timerWailingSoulsCD:Start(59.4-delay, 1)
	timerTormentedCriesCD:Start(119-delay)
	if self.Options.NPAuraOnBonecageArmor then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self.Options.InfoFrame then
		self:RegisterShortTermEvents(
			"UNIT_AURA_UNFILTERED"
		)
		for uId in DBM:GetGroupMembers() do
			local name = DBM:GetUnitFullName(uId)
			if UnitDebuff(uId, spiritRealm) then
				playersInSpirit[#playersInSpirit+1] = name
			else
				playersNotInSpirit[#playersNotInSpirit+1] = name
			end
		end
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(5, "function", updateInfoFrame, false)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnBonecageArmor then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, false, true)--Uses both hostile and friendly
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 238570 then--Tormented Cries
		timerSpearofAnquishCD:Stop()
		--timerTormentedCriesCD:Start()
	elseif spellId == 235927 then
		warnRupturingSlam:Show()
		timerRupturingSlamCD:Start(nil, args.sourceGUID)
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
	elseif spellId == 236072 then
		self.vb.wailingSoulsCast = self.vb.wailingSoulsCast + 1
		timerSoulbindCD:Stop()
		timerWitherCD:Stop()
		specWarnWailingSouls:Show(self.vb.wailingSoulsCast)
		voiceWailingSouls:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 235907 then
		warnCollapsingFissure:Show()
	elseif spellId == 236449 then--Soulbind Cast
		self.vb.soulboundCast = self.vb.soulboundCast + 1
		--Uusally casts 2 between cries, but sometimes only 1 even when it's off cd
		--Never seen cast a 3rd, but for time being starting 3rd timer and canceling it if wails is cast
		--if self.vb.soulboundCast < 2 then
			timerSoulbindCD:Start(nil, self.vb.soulboundCast+1)
		--end
	elseif spellId == 235933 then--Spear of Anquish
		timerSpearofAnquishCD:Start()
	elseif spellId ==  236138 or spellId == 236131 then
		timerWitherCD:Start()
	elseif spellId == 235969 then--Shattering Scream
		timerShatteringScreamCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 236459 then
		warnSoulbind:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnSoulbind:Show()
			voiceSoulbind:Play("targetyou")
			yellSoulbind:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 235924 then
		warnSpearofAnguish:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSpearofAnguish:Show()
			voiceSpearofAnguish:Play("runout")
			yellSpearofAnguish:Schedule(5, 1)
			yellSpearofAnguish:Schedule(4, 2)
			yellSpearofAnguish:Schedule(3, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	elseif spellId == 238018 then
		if args:IsPlayer() then
			specWarnTormentingCries:Show()
			voiceTormentingCries:Play("targetyou")
		else
			warnTormentingCries:Show(args.destName)
		end
	elseif spellId == 236513 then
		self.vb.boneArmorCount = self.vb.boneArmorCount + 1
		warnBonecageArmor:Show(args.destName)
		if self.Options.NPAuraOnBonecageArmor then
			DBM.Nameplate:Show(true, args.destGUID, spellId, nil, 60)
		end
	elseif (spellId ==  236138 or spellId == 236131) then
		warnWither:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnWither:Show()
			voiceWither:Play("switchphase")
		end
	elseif spellId == 235969 then
		if args:IsPlayer() then
			specWarnShatteringScream:Show(boneArmor)
			voiceShatteringScream:Play("getboned")
		end
		warnShatteringScream:CombinedShow(0.5, args.destName)
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
	if spellId == 236459 then
		if self.Options.RangeFrame and args:IsPlayer() then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 235924 then
		if args:IsPlayer() then
			yellSpearofAnguish:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 236513 then--Bonecage Armor
		self.vb.boneArmorCount = self.vb.boneArmorCount - 1
		if self.Options.NPAuraOnBonecageArmor then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 235969 then--Shattering Scream
		
	elseif spellId == 236072 then
		self.vb.soulboundCast = 0
		timerSoulbindCD:Start(12, 1)
		timerWitherCD:Start(19.7)
		timerWailingSoulsCD:Start(58, self.vb.wailingSoulsCast+1)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 119938 then--Reanimated templar
		timerRupturingSlamCD:Stop(args.destName)
--	elseif cid == 119939 then--Ghastly Bonewarden
	
	elseif cid == 119940 then--Fallen Priestess
		timerShatteringScreamCD:Stop(args.destGUID)
	end
end

--If this debuff was in combat log wouldn't have to waste cpu doing it this way.
function mod:UNIT_AURA_UNFILTERED(uId)
	local inSpiritRealm = UnitDebuff(uId, spiritRealm)
	local name = DBM:GetUnitFullName(uId)
	if not tContains(playersNotInSpirit, name) and not inSpiritRealm then--Not Spirit Realm
		playersNotInSpirit[#playersNotInSpirit+1] = name
		tDeleteItem(playersInSpirit, name)
		--[[if UnitIsUnit("player", uId) then
			DBM.RangeCheck:Show(5, regularFilter)
		end--]]
	elseif not tContains(playersInSpirit, name) and inSpiritRealm then--Spirit Realm
		playersInSpirit[#playersInSpirit+1] = name
		tDeleteItem(playersNotInSpirit, name)
		--[[if UnitIsUnit("player", uId) then
			DBM.RangeCheck:Show(5, spiritFilter)
		end--]]
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
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	--["235907-Collapsing Fissure"] = "pull:9.7, 31.5, 10.4, 2.4, 4.7, 22.2, 1.8, 9.8, 2.3, 0.9, 41.4"
	if spellId == 235907 then--Collapsing Fissure
		--timerCollapsingFissureCD:Start()
	end
end

