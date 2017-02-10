local mod	= DBM:NewMod(1856, "DBM-TombofSargeras", nil, 875)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(116407)
mod:SetEncounterID(2036)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1)
--mod:SetHotfixNoticeRev(15581)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 231854 232174 232192 231904 234194 240319 241590",
	"SPELL_CAST_SUCCES 231729",
	"SPELL_AURA_APPLIED 231998 231729 231904 234016 241600",
	"SPELL_AURA_APPLIED_DOSE 231998",
	"SPELL_AURA_REMOVED 233429 241600",
	"SPELL_AURA_REMOVED_DOSE 233429",
	"SPELL_PERIODIC_DAMAGE 231768",
	"SPELL_PERIODIC_MISSED 231768",
	"UNIT_DIED",
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
	"UNIT_POWER_FREQUENT boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Todo, figure out timing for swapping/tank stacks
--TODO, improve power handling for Unchecked Rage to improve warnings/timers
--TODO frigid blows persistant whole fight or a phase?
--TODO, can draw in be timer based or will there be inconsistency in landed melee swings?
--TODO, never done AI timers with optional args like GUID before, see if they explode!
--TODO, splashy cleave for Gladiator?
--TODO, escalate Frosty Spittle warning to special warning from taskmaster?
--TODO, Improve mythic stuff
--Harjatan
local warnJaggedAbrasion			= mod:NewStackAnnounce(231998, 2, nil, "Tank")
local warnDrawIn					= mod:NewSpellAnnounce(232061, 2)
local warnFrigidBlows				= mod:NewStackAnnounce(233429, 2)
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
--local specWarnJaggedAbrasion		= mod:NewSpecialWarningStack(231998, nil, 5)
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
local timerUncheckedrageCD			= mod:NewAITimer(31, 231998, nil, nil, nil, 2)
--Razorjaw Wavemender
local timerAqueousBurstCD			= mod:NewAITimer(15, 231729, nil, nil, nil, 3)
local timerTendWoundsCD				= mod:NewAITimer(15, 231904, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
--Razorjaw Gladiator
local timerDrivenAssaultCD			= mod:NewAITimer(31, 234016, nil, nil, nil, 3)
--Darkscale Taskmaster
local timerFrostySpittleCD			= mod:NewAITimer(31, 234194, nil, nil, nil, 3)

--local berserkTimer				= mod:NewBerserkTimer(300)

--Harjatan
--local countdownDrawPower			= mod:NewCountdown(33, 227629)

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

mod.vb.rageWarned = false
mod.vb.rageCount = 0
local seenMobs = {}

function mod:OnCombatStart(delay)
	self.vb.rageWarned = false
	self.vb.rageCount = 0
	table.wipe(seenMobs)
	timerUncheckedrageCD:Start(1-delay)
	if self.Options.NPAuraOnSicklyFixate and self:IsMythic() then
		DBM:FireEvent("BossMod_EnableFriendlyNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
	if self.Options.NPAuraOnSicklyFixate and self:IsMythic() then
		DBM.Nameplate:Hide(false, nil, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 231854 then
		timerUncheckedrageCD:Start()--Might need moving to unit power handler if boss ever pauses power gains (such as during draw in/232061)
	elseif spellId == 232174 then
		warnFrostyDischarge:Show()
	elseif spellId == 232192 then
		specWarnCommandingroar:Show()
		voiceCommandingroar:Play("killmob")
	elseif spellId == 231904 then
		timerTendWoundsCD:Start(nil, args.sourceGUID)
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnTendWounds:Show(args.sourceName)
			voiceTendWounds:Play("kickcast")
		end
	elseif spellId == 234194 then
		warnFrostySpittle:Show()
		timerFrostySpittleCD:Start(nil, args.sourceGUID)
	elseif spellId == 240319 then
		warnHatching:Show()
	elseif spellId == 241590 then
		specWarnTantrum:Show()
		voiceTantrum:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 231729 then
		timerAqueousBurstCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 231998 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 5 then--Fine Tune Ammount
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					--specWarnJaggedAbrasion:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitIsDeadOrGhost("player") and not UnitDebuff("player", args.spellName) then
						specWarnJaggedAbrasionOther:Show(args.destName)
						voiceJaggedAbrasion:Play("tauntboss")
					else
						warnJaggedAbrasion:Show(args.destName, amount)
					end
				end
			else
				warnJaggedAbrasion:Show(args.destName, amount)
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
		timerDrivenAssaultCD:Start(nil, args.sourceGUID)
		if args:IsPlayer() then
			specWarnDrivenAssault:Show()
			voiceDrivenAssault:Play("justrun")
			voiceDrivenAssault:Schedule(1, "keepmove")
		else
			warnDrivenAssault:Show(args.destName)
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
			DBM.Nameplate:Show(false, args.destName, spellId)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 233429 then
		local amount = args.amount or 0
		if amount < 3 or self:AntiSpam(5, 1) then
		--Every 5 seconds or every stack under 3
			warnFrigidBlows:Show(amount)
		end
	elseif spellId == 241600 then
		if self.Options.NPAuraOnSicklyFixate then
			DBM.Nameplate:Hide(false, args.destName)
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
		timerDrivenAssaultCD:Stop(args.destGUID)
	elseif cid == 117522 then--Darkscale Taskmaster
		timerFrostySpittleCD:Stop(args.destGUID)
	elseif cid == 120545 then--Incubated Egg
		
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local unitID = "boss"..i
		local GUID = UnitGUID(unitID)
		if GUID and not seenMobs[GUID] then
			seenMobs[GUID] = true
			local cid = self:GetCIDFromGUID(GUID)
			if cid == 116569 then--Razorjaw Wavemender
				timerAqueousBurstCD:Start(1, GUID)
				timerTendWoundsCD:Start(1, GUID)
			elseif cid == 117596 then--Razorjaw Gladiator
				timerDrivenAssaultCD:Start(1, GUID)
			elseif cid == 117522 then--Darkscale Taskmaster
				timerFrostySpittleCD:Start(1, GUID)
			end
		end
	end
end

function mod:UNIT_POWER_FREQUENT(uId, type)
	if type == "ALTERNATE" then
		--Just in Case
		--[[local altPower = UnitPower(uId, 10) --Get Boss Power
		if altPower >= 92 and not self.vb.rageWarned then--Fine tune numbers
			self.vb.rageWarned = true
			specWarnBlast:Show()
		elseif altPower < 5 and self.vb.rageWarned then--Should catch 0, if not, at least 1-4 will fire it but then timer may be a second or so off
			self.vb.rageWarned = false
		end--]]
	else
		local bossPower = UnitPower("boss1") --Get Boss Power
		if bossPower >= 92 and not self.vb.rageWarned then--Fine tune numbers
			self.vb.rageWarned = true
			self.vb.rageCount = self.vb.rageCount + 1
			specWarnUncheckedRage:Show(self.vb.rageCount)
			voiceUncheckedRage:Play("gathershare")
		elseif bossPower < 5 and self.vb.rageWarned then--Should catch 0, if not, at least 1-4 will fire it but then timer may be a second or so off
			self.vb.rageWarned = false
		end
	end
end

--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:228162") then

	end
end
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local spellId = tonumber(select(5, strsplit("-", spellGUID)), 10)
	if spellId == 232061 then--Draw In
		warnDrawIn:Show()
	end
end

