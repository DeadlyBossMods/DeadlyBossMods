local mod	= DBM:NewMod(2009, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 16369 $"):sub(12, -3))
mod:SetCreatureID(125055)--or 124158 or 125692
mod:SetEncounterID(2082)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 3, 4, 5, 6)
--mod:SetHotfixNoticeRev(16350)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247376 247923 248068 248070",
	"SPELL_CAST_SUCCESS 247367 247552 247687 250255",
	"SPELL_AURA_APPLIED 247367 247552 247565 247687 250255 253302 248321",
	"SPELL_AURA_APPLIED_DOSE 247367 247687 250255 248424",
	"SPELL_AURA_REMOVED 247552 253302 248321",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"UNIT_DIED",
--	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, fine tune shock lance stacks
--TODO, determine sleep canister counts and add icons as needed
--TODO, check pulse grenade for target scanning
--TODO, fine tune Sever stacks
--TODO, verify charged blasts, very safe bet though whisper is only way (if at all)
--TODO, empower distinction? for now it's left out as redundant
--TODO, verify phase change detection, right now it's dirty and assumed.
--TODO, Announe stacks of Gathering Power if relevant
--TODO, announce intermission traps if relevant/clean to detect
--Stage One: Attack Force
local warnShocklance					= mod:NewStackAnnounce(247367, 2, nil, "Tank")
local warnSleepCanister					= mod:NewTargetAnnounce(247552, 2)
local warnSlumberGas					= mod:NewTargetAnnounce(247565, 3)
--Stage Two: Contract to Kill
local warnSever							= mod:NewStackAnnounce(247687, 2, nil, "Tank")
local warnChargedBlasts					= mod:NewTargetAnnounce(247716, 3)
--Stage Three/Five: The Perfect Weapon
--Intermission: On Deadly Ground

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage One: Attack Force
local specWarnShocklance				= mod:NewSpecialWarningTaunt(247367, nil, nil, nil, 1, 2)
local specWarnSleepCanister				= mod:NewSpecialWarningYou(247552, nil, nil, nil, 1, 2)
local yellSleepCanister					= mod:NewYell(247552)
local specWarnSleepCanisterNear			= mod:NewSpecialWarningClose(247552, nil, nil, nil, 1, 2)
local specWarnPulseGrenade				= mod:NewSpecialWarningDodge(247376, nil, nil, nil, 1, 2)
--Stage Two: Contract to Kill
local specWarnSever						= mod:NewSpecialWarningTaunt(247687, nil, nil, nil, 1, 2)
local specWarnChargedBlasts				= mod:NewSpecialWarningYou(247716, nil, nil, nil, 1, 2)
local yellChargedBlasts					= mod:NewYell(247716)
local specWarnShrapnalBlast				= mod:NewSpecialWarningDodge(247923, nil, nil, nil, 1, 2)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--Stage Three/Five: The Perfect Weapon
--local specWarnEmpPulseGrenade			= mod:NewSpecialWarningDodge(248068, nil, nil, nil, 1, 2)--Redundant
--local specWarnEmpShrapnalBlast		= mod:NewSpecialWarningDodge(248070, nil, nil, nil, 1, 2)--Redundant
--Intermission: On Deadly Ground

--Stage One: Attack Force
local timerShocklanceCD					= mod:NewCDTimer(8.5, 247367, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerSleepCanisterCD				= mod:NewAITimer(61, 247552, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerPulseGrenadeCD				= mod:NewAITimer(61, 247376, nil, nil, nil, 3)
--Stage Two: Contract to Kill
local timerSeverCD						= mod:NewCDTimer(8.5, 247687, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerChargedBlastsCD				= mod:NewAITimer(61, 247716, nil, nil, nil, 3)
local timerShrapnalBlastCD				= mod:NewAITimer(61, 247923, nil, nil, nil, 3)
--Stage Three/Five: The Perfect Weapon

--Intermission: On Deadly Ground


--local berserkTimer					= mod:NewBerserkTimer(600)

--Stage One: Attack Force
--local countdownSingularity			= mod:NewCountdown(50, 235059)
--Stage Two: Contract to Kill

--General
--local voiceGTFO						= mod:NewVoice(238028, nil, DBM_CORE_AUTO_VOICE4_OPTION_TEXT)--runaway
--Stage One: Attack Force
local voiceShocklance					= mod:NewVoice(247367)--Tauntboss
local voiceSleepCanister				= mod:NewVoice(247552)--targetyou
local voicePulseGrenade					= mod:NewVoice(247376)--watchstep
--Stage Two: Contract to Kill
local voiceSever						= mod:NewVoice(247687)--Tauntboss
local voiceChargedBlasts				= mod:NewVoice(247716)--runout
local voiceShrapnalBlast				= mod:NewVoice(247923)--watchstep
--Stage Three/Five: The Perfect Weapon

--local voiceMalignantAnguish			= mod:NewVoice(236597, "HasInterrupt")--kickcast

--mod:AddSetIconOption("SetIconOnFocusedDread", 238502, true)
--mod:AddInfoFrameOption(239154, true)
--mod:AddRangeFrameOption("5/10")

mod.vb.phase = 1

--[[
local debuffFilter
local UnitDebuff = UnitDebuff
local playerDebuff = nil
do
	local spellName = GetSpellInfo(231311)
	debuffFilter = function(uId)
		if not playerDebuff then return true end
		if not select(11, UnitDebuff(uId, spellName)) == playerDebuff then
			return true
		end
	end
end

local expelLight, stormOfJustice = GetSpellInfo(228028), GetSpellInfo(227807)
local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if self.vb.brandActive then
		DBM.RangeCheck:Show(15, debuffFilter)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif UnitDebuff("player", expelLight) or UnitDebuff("player", stormOfJustice) then
		DBM.RangeCheck:Show(8)
	elseif self.vb.hornCasting then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5)
	else
		DBM.RangeCheck:Hide()
	end
end
--]]

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerShocklanceCD:Start(1-delay)
	timerSleepCanisterCD:Start(1-delay)
	timerPulseGrenadeCD:Start(1-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
--	if self.Options.InfoFrame then
--		DBM.InfoFrame:Hide()
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247376 or spellId == 248068 then
		specWarnPulseGrenade:Show()
		voicePulseGrenade:Play("watchstep")
		timerPulseGrenadeCD:Start()
	elseif spellId == 247923 or spellId == 248070 then
		specWarnShrapnalBlast:Show()
		voiceShrapnalBlast:Play("watchstep")
		timerShrapnalBlastCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247367 or spellId == 250255 then
		timerShocklanceCD:Start()
	elseif spellId == 247552 then
		timerSleepCanisterCD:Start()
	elseif spellId == 247687 then
		timerSeverCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247367 or spellId == 250255 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 then
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnShocklance:Show(args.destName)
					voiceShocklance:Play("tauntboss")
				else
					warnShocklance:Show(args.destName, amount)
				end
			else
				warnShocklance:Show(args.destName, amount)
			end
		end
	elseif spellId == 247687 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 6 then
				if not UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnSever:Show(args.destName)
					voiceSever:Play("tauntboss")
				else
					warnSever:Show(args.destName, amount)
				end
			else
				warnSever:Show(args.destName, amount)
			end
		end
	elseif spellId == 247552 then
		warnSleepCanister:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSleepCanister:Show()
			voiceSleepCanister:Play("targetyou")
			yellSleepCanister:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnSleepCanisterNear:CombinedShow(0.3, args.destName)
			voiceSleepCanister:Play("runaway")
		end
	elseif spellId == 247565 then
		warnSlumberGas:CombinedShow(0.3, args.destName)
	elseif (spellId == 253302 or spellId == 248321) and not args:IsDestTypePlayer() then--Conflagration
		--stop all timers (if this dirty method doesn't work, do em manually)
		for i, v in ipairs(self.timers) do
			v:Stop()
		end
	elseif spellId == 248424 then--Gathering Power
		
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 253302 or spellId == 248321) and not self:IsDestTypePlayer() then--Conflagration
		self.vb.phase = self.vb.phase + 1
		if self.vb.phase == 2 then
			timerSeverCD:Start(2)
			timerChargedBlastsCD:Start(2)
			timerShrapnalBlastCD:Start(2)
		elseif self.vb.phase == 3 then
			if self:IsMythic() then
				timerShocklanceCD:Start(3)--NOT empowered
				timerSleepCanisterCD:Start(3)
				timerShrapnalBlastCD:Start(3)--Empowered
			else
				timerShocklanceCD:Start(3)--Empowered
				timerPulseGrenadeCD:Start(3)--Empowered
				timerShrapnalBlastCD:Start(3)--Empowered
			end
		elseif self.vb.phase == 4 then--Mythic Only
			timerSeverCD:Start(4)
			timerChargedBlastsCD:Start(4)
			timerPulseGrenadeCD:Start(4)--Empowered
		elseif self.vb.phase == 5 then--Mythic Only (Identical to non mythic 3)
			timerShocklanceCD:Start(3)--Empowered
			timerPulseGrenadeCD:Start(3)--Empowered
			timerShrapnalBlastCD:Start(3)--Empowered
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		voiceGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:238502") then

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 121193 then

	end
end
--]]

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:247716") or msg:find("spell:248254") then--Charged Blasts
		specWarnChargedBlasts:Show()
		voiceChargedBlasts:Play("runout")
		yellChargedBlasts:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find("spell:247716") or msg:find("spell:248254") then--Charged Blasts
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(4, targetName) then
--			local icon = self.vb.bladesIcon
			warnChargedBlasts:CombinedShow(0.5, targetName)
--			if self.Options.SetIconOnShadowyBlades then
--				self:SetIcon(targetName, icon, 5)
--			end
--			if targetName == playerName then
--				yellShadowyBlades:Yell(icon, icon, icon)
--			end
--			self.vb.bladesIcon = self.vb.bladesIcon + 1
		end
	end
end

--http://ptr.wowhead.com/spell=253380/teleport-imonar-the-soulhunter
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 248254 then--Charged Blasts
		timerChargedBlastsCD:Start()
	end
end
