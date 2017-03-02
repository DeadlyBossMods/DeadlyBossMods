local mod	= DBM:NewMod(1856, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116407)
mod:SetEncounterID(2036)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 232174 231904 234194 240319 241590",
	"SPELL_CAST_SUCCES 231854 231729 232061 234129",
	"SPELL_AURA_APPLIED 231998 231729 231904 234016 241600 233429",
	"SPELL_AURA_APPLIED_DOSE 231998",
	"SPELL_AURA_REMOVED 233429 234016 241600",
	"SPELL_AURA_REMOVED_DOSE 233429",
	"SPELL_PERIODIC_DAMAGE 231768",
	"SPELL_PERIODIC_MISSED 231768",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
--	"UNIT_POWER_FREQUENT boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, splashy cleave for Gladiator?
--TODO, escalate Frosty Spittle warning to special warning from taskmaster?
--TODO, Improve mythic stuff with better warnings, still going through logs but raid soon
--TODO, see if hatching is affected by draw in when it does succeed in pulling Frost stacks
--[[
(ability.id = 232174 or ability.id = 231904) and type = "begincast" or
(ability.id = 231854 or ability.id = 232061) and type = "cast" or
ability.id = 233429 and (type = "applybuff" or type = "removebuff") or
(target.id = 116569 or target.id = 117596 or target.id = 117522 or target.id = 120545) and type = "death" or
(ability.id = 241590 or ability.id = 240319 or ability.id = 234194) and type = "begincast" or (abilty.id = 231729 or ability.id = 234129 or ability.id = 234016) and type = "cast"
--]]
--Harjatan
local warnJaggedAbrasion			= mod:NewStackAnnounce(231998, 2, nil, "Tank")
local warnDrawIn					= mod:NewSpellAnnounce(232061, 2)
local warnFrigidBlows				= mod:NewStackAnnounce(233429, 2, nil, false)
local warnFrostyDischarge			= mod:NewSpellAnnounce(232174, 2)
--Razorjaw Wavemender
local warnAqueousBurst				= mod:NewTargetAnnounce(231729, 2)
--Razorjaw Gladiator
local warnDrivenAssault				= mod:NewTargetAnnounce(234016, 3)
--Darkscale Taskmaster
local warnFrostySpittle				= mod:NewSpellAnnounce(234194, 2)
--Mythic (Eggs and tadpoles)
local warnHatching					= mod:NewCastAnnounce(240319, 4)
local warnSicklyFixate				= mod:NewTargetAnnounce(241600, 4)

--Harjatan
local specWarnJaggedAbrasion		= mod:NewSpecialWarningStack(231998, nil, 6, nil, nil, 1, 2)
local specWarnJaggedAbrasionOther	= mod:NewSpecialWarningTaunt(231998, nil, nil, nil, 1, 2)
local specWarnUncheckedRage			= mod:NewSpecialWarningCount(231854, nil, nil, nil, 2, 2)
local specWarnDrenchingWaters		= mod:NewSpecialWarningMove(231768, nil, nil, nil, 1, 2)
local specWarnCommandingroar		= mod:NewSpecialWarningSwitch(232192, nil, nil, nil, 1, 2)
--Razorjaw Wavemender
local specWarnAqueousBurst			= mod:NewSpecialWarningMoveAway(231729, nil, nil, nil, 1, 2)
local yellAqueousBurst				= mod:NewYell(231729)
local specWarnTendWounds			= mod:NewSpecialWarningInterrupt(231904, "HasInterrupt")
local specWarnTendWoundsDispel		= mod:NewSpecialWarningDispel(231904, "MagicDispeller")
--Razorjaw Gladiator
local specWarnDrivenAssault			= mod:NewSpecialWarningRun(234016, nil, nil, nil, 4, 2)
--Darkscale Taskmaster
--Mythic (Eggs and tadpoles)
local specWarnSicklyFixate			= mod:NewSpecialWarningRun(241600, nil, nil, nil, 4, 2)
local specWarnTantrum				= mod:NewSpecialWarningSpell(241590, nil, nil, nil, 2, 2)

--Harjatan
local timerUncheckedRageCD			= mod:NewNextCountTimer(20, 231998, nil, nil, nil, 2)--5 power per second heroic, 20 seconds for 100 energy
local timerDrawInCD					= mod:NewNextTimer(60.8, 232061, nil, nil, nil, 6)
local timerCommandingRoarCD			= mod:NewNextTimer(31.8, 232192, nil, nil, nil, 1)
--Razorjaw Wavemender
local timerAqueousBurstCD			= mod:NewCDTimer(6, 231729, nil, false, nil, 3)--6-8
local timerTendWoundsCD				= mod:NewAITimer(15, 231904, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Razorjaw Gladiator
local timerDrivenAssault			= mod:NewTargetTimer(10, 234016, nil, false, nil, 3)--Too many spawn, this would be spammy so off by default
local timerSplashCleaveCD			= mod:NewCDTimer(12, 234129, nil, false, nil, 5, nil, DBM_CORE_TANK_ICON)
--Darkscale Taskmaster
local timerFrostySpittleCD			= mod:NewCDTimer(12, 234194, nil, nil, nil, 3)
--Mythic
local timerHatchingCD				= mod:NewCDTimer(40.6, 240319, nil, nil, nil, 1)--40.6-42
--local berserkTimer				= mod:NewBerserkTimer(300)

--Harjatan
local countdownUncheckedRage		= mod:NewCountdown(20, 231998)

--Harjatan
local voiceJaggedAbrasion			= mod:NewVoice(231998)--tauntboss/stackhigh
local voiceUncheckedRage			= mod:NewVoice(231854)--gathershare
local voiceDrenchingWaters			= mod:NewVoice(231768)--runaway
local voiceCommandingroar			= mod:NewVoice(232192)--killmob
--Razorjaw Wavemender
local voiceAqueousBurst				= mod:NewVoice(231729)--runout
local voiceTendWounds				= mod:NewVoice(231904)--kickcast/dispelnow
--Razorjaw Gladiator
local voiceDrivenAssault			= mod:NewVoice(234016)--justrun/keepmove
--Darkscale Taskmaster
--Mythic (Eggs and tadpoles)
local voiceSicklyFixate				= mod:NewVoice(241600)--justrun/keepmove
local voiceTantrum					= mod:NewVoice(241590)--aesoon

--mod:AddSetIconOption("SetIconOnShield", 228270, true)
--mod:AddInfoFrameOption(227503, true)
--mod:AddRangeFrameOption("5/8/15")
mod:AddNamePlateOption("NPAuraOnSicklyFixate", 241600)
mod:AddNamePlateOption("NPAuraOnDrivenAssault", 234016)

mod.vb.rageWarned = false
mod.vb.rageCount = 0
local seenMobs = {}

function mod:OnCombatStart(delay)
	self.vb.rageWarned = false
	self.vb.rageCount = 0
	table.wipe(seenMobs)
	timerCommandingRoarCD:Start(6.3-delay)
	timerUncheckedRageCD:Start(-delay)
	countdownUncheckedRage:Start()
	specWarnUncheckedRage:Schedule(16-delay, 1)
	voiceUncheckedRage:Schedule(16-delay, "gathershare")
	timerDrawInCD:Start(-delay)
	if self.Options.NPAuraOnSicklyFixate and self:IsMythic() or self.Options.NPAuraOnDrivenAssault then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
	if self:IsMythic() then
		timerHatchingCD:Start(30.5-delay)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnSicklyFixate and self:IsMythic() or self.Options.NPAuraOnDrivenAssault then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, false, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 232174 then
		warnFrostyDischarge:Show()
		self.vb.rageCount = 0
		timerCommandingRoarCD:Start(19.8)--Assumed, but likely
		timerUncheckedRageCD:Start(21.1, 1)--21.1-23.5
		countdownUncheckedRage:Start(21)
		specWarnUncheckedRage:Show(17, 1)
		voiceUncheckedRage:Play(17, "gathershare")
	elseif spellId == 231904 then
		timerTendWoundsCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnTendWounds:Show(args.sourceName)
			voiceTendWounds:Play("kickcast")
		end
	elseif spellId == 234194 then
		warnFrostySpittle:Show()
		timerFrostySpittleCD:Start(nil, args.sourceGUID)
	elseif spellId == 241590 then
		specWarnTantrum:Show()
		voiceTantrum:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 231729 then
		timerAqueousBurstCD:Start(nil, args.sourceGUID)
	elseif spellId == 231854 then
		local remaining = timerDrawInCD:GetRemaining()
		if remaining > 20 then
			timerUncheckedRageCD:Start(nil, self.vb.rageCount+1)
			countdownUncheckedRage:Start()
			specWarnUncheckedRage:Schedule(17, self.vb.rageCount+1)
			voiceUncheckedRage:Schedule(17, "gathershare")
		else
			--It'll be cast immediately after 10 second cast of draw in + 1, unless draw in successfully absorbs pools
			timerUncheckedRageCD:Start(remaining+11, self.vb.rageCount+1)
			countdownUncheckedRage:Start(remaining+11)
			specWarnUncheckedRage:Schedule(remaining+7, self.vb.rageCount+1)
			voiceUncheckedRage:Schedule(remaining+7, "gathershare")
		end
	elseif spellId == 232061 then
		warnDrawIn:Show()
		timerDrawInCD:Start()
	elseif spellId == 234129 then
		timerSplashCleaveCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 231998 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 then--Lasts 30 seconds, cast every 5 seconds, swapping will be at 6
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnJaggedAbrasion:Show(amount)
					voiceJaggedAbrasion:Play("stackhigh")
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnJaggedAbrasionOther:Show(args.destName)
						voiceJaggedAbrasion:Play("tauntboss")
					else
						warnJaggedAbrasion:Show(args.destName, amount)
					end
				end
			else
				if amount % 2 == 0 then
					warnJaggedAbrasion:Show(args.destName, amount)
				end
			end
		end
	elseif spellId == 231729 then
		warnAqueousBurst:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnAqueousBurst:Show()
			voiceAqueousBurst:Play("runout")
			yellAqueousBurst:Yell()
		end
	elseif spellId == 231904 then
		specWarnTendWoundsDispel:Show(args.destName)
		if self.Options.SpecWarn231904dispel then
			voiceTendWounds:Play("dispelnow")
		end
	elseif spellId == 234016 then
		timerDrivenAssault:Start(10, args.destName)
		if args:IsPlayer() then
			specWarnDrivenAssault:Show()
			voiceDrivenAssault:Play("justrun")
			voiceDrivenAssault:Schedule(1, "keepmove")
		else
			warnDrivenAssault:Show(args.destName)
		end
		if self.Options.NPAuraOnDrivenAssault then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 241600 then
		if args:IsPlayer() then
			specWarnSicklyFixate:Show()
			voiceSicklyFixate:Play("justrun")
			voiceSicklyFixate:Schedule(1, "keepmove")
		else
			warnSicklyFixate:Show(args.destName)
		end
		if self.Options.NPAuraOnSicklyFixate then
			DBM.Nameplate:Show(true, args.sourceGUID, spellId)
		end
	elseif spellId == 233429 then
		timerUncheckedRageCD:Stop()
		countdownUncheckedRage:Cancel()
		specWarnUncheckedRage:Cancel()
		voiceUncheckedRage:Cancel()
		timerCommandingRoarCD:Stop()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233429 then
		local amount = args.amount or 0
		if amount < 5 or self:AntiSpam(5, 1) then
		--Every 5 seconds or every stack under 5
			warnFrigidBlows:Show(amount)
		end
	elseif spellId == 234016 then
		timerDrivenAssault:Stop(args.destName)
		if self.Options.NPAuraOnDrivenAssault then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	elseif spellId == 241600 then
		if self.Options.NPAuraOnSicklyFixate then
			DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 231768 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnDrenchingWaters:Show()
		voiceDrenchingWaters:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 116569 then--Razorjaw Wavemender
		timerAqueousBurstCD:Stop(args.destGUID)
		timerTendWoundsCD:Stop(args.destGUID)
	elseif cid == 117596 then--Razorjaw Gladiator
		timerSplashCleaveCD:Stop(args.destGUID)
	elseif cid == 117522 then--Darkscale Taskmaster
		timerFrostySpittleCD:Stop(args.destGUID)
	elseif cid == 120545 then--Incubated Egg
		
	end
end

--"<26.92 17:09:49> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#boss1#false#false#false#??#nil#normal#0#boss2#false#false#false#??#nil#normal#0#boss3#false#false#false#??#nil#normal#0#boss4#false#false#false#??#nil#normal#0#boss5#false#false#false#??#nil#normal#0#Real Args:", -- [74]
--"<26.93 17:09:49> [UNIT_TARGETABLE_CHANGED] nameplate3#false#false#true#Razorjaw Gladiator#Creature-0-2083-1676-7590-117596-00011E36EB#elite#10751230", -- [75]
--"<26.93 17:09:49> [UNIT_TARGETABLE_CHANGED] nameplate4#false#false#true#Razorjaw Gladiator#Creature-0-2083-1676-7590-117596-00009E36EB#elite#10751230", -- [76]
--Didn't live long enough to see if IEEU would work for these, based on above it wouldn't or it wouldn't be as fast as UNIT_TARGETABLE_CHANGED. However UNIT_TARGETABLE_CHANGED might rely on nameplate unitIDs
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenMobs[GUID] then
			seenMobs[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 116569 then--Razorjaw Wavemender
				--timerAqueousBurstCD:Start(1, GUID)
				timerTendWoundsCD:Start(1, GUID)
			elseif cid == 117596 then--Razorjaw Gladiator

			elseif cid == 117522 then--Darkscale Taskmaster
				--timerFrostySpittleCD:Start(1, GUID)
			end
		end
	end
end

--[[
function mod:UNIT_POWER_FREQUENT(uId)
	local bossPower = UnitPower("boss1") --Get Boss Power
	if bossPower >= 80 and not self.vb.rageWarned then--Fine tune numbers? Right now it gives 4 second warning
		self.vb.rageWarned = true
		self.vb.rageCount = self.vb.rageCount + 1
		specWarnUncheckedRage:Show(self.vb.rageCount)
		voiceUncheckedRage:Play("gathershare")
	elseif bossPower < 10 and self.vb.rageWarned then--Should catch 0, if not, at least 1-4 will fire it but then timer may be a second or so off
		self.vb.rageWarned = false
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 232192 then--Commanding Roar
		specWarnCommandingroar:Show()
		voiceCommandingroar:Play("killmob")
		local remaining = timerDrawInCD:GetRemaining()
		if remaining > 32 or remaining < 22 then--Should come off cd not during a draw In
			timerCommandingRoarCD:Start()
		else
			--He'll be casting draw in when this is cast, so adjust timer around draw in cast finish
			timerCommandingRoarCD:Start(remaining+11)
		end
	elseif spellId == 240347 then--Warn Players of Hatching Eggs
		warnHatching:Show()
		timerHatchingCD:Start()
	elseif spellId == 240360 then--Red Murloc Tadpole
	
	elseif spellId == 241562 then--Blue Murloc Tadpole
	
	end
end

