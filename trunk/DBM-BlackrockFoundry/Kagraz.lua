local mod	= DBM:NewMod(1123, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76814)--76794 Cinder Wolf, 80590 Aknor Steelbringer
mod:SetEncounterID(1689)
mod:SetZone()
mod:SetUsedIcons(6, 5, 4, 3)
mod:SetHotfixNoticeRev(13445)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156018 156040 155382 155064",
	"SPELL_CAST_SUCCESS 155776 155074",
	"SPELL_AURA_APPLIED 155277 154952 163284 155074 154932 154950",
	"SPELL_AURA_APPLIED_DOSE 163284 155074",
	"SPELL_AURA_REMOVED 155277 154932 154950 154952 155493",
	"SPELL_PERIODIC_DAMAGE 155314",
	"SPELL_ABSORBED 155314",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Pointless add fight starts with (need to keep alive for follower achievement
local warnDevastatingSlam				= mod:NewSpellAnnounce("OptionVersion2", 156018, 4, nil, false)
local warnDropHammer					= mod:NewSpellAnnounce("OptionVersion2", 156040, 3, nil, false)

local warnLavaSlash						= mod:NewSpellAnnounce(155318, 2, nil, false)--Likely cast often & doesn't show in combat log anyways except for damage and not THAT important
local warnSummonEnchantedArmaments		= mod:NewSpellAnnounce("OptionVersion2", 156724, 3, nil, "Ranged")
local warnMoltenTorrent					= mod:NewTargetAnnounce(154932, 3)
local warnRekindle						= mod:NewCastAnnounce(155064, 4)
local warnFixate						= mod:NewTargetAnnounce("OptionVersion2", 154952, 3, nil, false)--Even though it works better now, it's just too spammy and most tune it out. Dogs very often become desynced after player died, or bopped or Feigned, and it's not just 1 warning every 10 seconds, but a warning every 3-4sec
local warnBlazingRadiance				= mod:NewTargetAnnounce(155277, 3)
local warnRisingFlames					= mod:NewStackAnnounce(163284, 2, nil, "Tank")
local warnCharringBreath				= mod:NewStackAnnounce(155074, 2, nil, "Tank")

local specWarnLavaSlash					= mod:NewSpecialWarningMove(155318, nil, nil, nil, nil, nil, 2)
local specWarnMoltenTorrent				= mod:NewSpecialWarningYou(154932, nil, nil, nil, nil, nil, 2)
local yellMoltenTorrent					= mod:NewFadesYell(154932)
local specWarnCinderWolves				= mod:NewSpecialWarningSpell(155776, nil, nil, nil, nil, nil, 2)
local specWarnOverheated				= mod:NewSpecialWarningSwitch(154950, "Tank")
local specWarnFixate					= mod:NewSpecialWarningYou(154952, nil, nil, nil, 3, nil, 2)
local specWarnFixateEnded				= mod:NewSpecialWarningEnd(154952, false)
local specWarnBlazinRadiance			= mod:NewSpecialWarningMoveAway(155277, nil, nil, nil, nil, nil, 2)
local yellBlazinRadiance				= mod:NewYell(155277, nil, false)
local specWarnFireStorm					= mod:NewSpecialWarningCount(155493, nil, nil, nil, 2, nil, 2)
local specWarnFireStormEnded			= mod:NewSpecialWarningEnd(155493, nil, nil, nil, nil, nil, 2)
local specWarnRisingFlames				= mod:NewSpecialWarningStack(163284, nil, 6)--stack guessed
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(163284, nil, nil, nil, nil, nil, 2)
local specWarnCharringBreath			= mod:NewSpecialWarningStack(155074, nil, 2)--Assumed based on timing and casts, that you swap every breath.
local specWarnCharringBreathOther		= mod:NewSpecialWarningTaunt(155074)
--

local timerLavaSlashCD					= mod:NewCDTimer(14.5, 155318, nil, false)
local timerMoltenTorrentCD				= mod:NewCDTimer("OptionVersion2", 14, 154932, nil, "Ranged")
local timerSummonEnchantedArmamentsCD	= mod:NewCDTimer("OptionVersion2", 45, 156724, nil, "Ranged")--45-47sec variation
local timerSummonCinderWolvesCD			= mod:NewNextTimer(76, 155776)
local timerOverheated					= mod:NewTargetTimer(14, 154950, nil, "Tank")
local timerCharringBreathCD				= mod:NewNextTimer(5, 155074, nil, "Tank")
local timerFixate						= mod:NewBuffFadesTimer(9.6, 154952)
local timerBlazingRadianceCD			= mod:NewCDTimer(12, 155277, nil, false)--somewhat important but not important enough. there is just too much going on to be distracted by this timer
local timerFireStormCD					= mod:NewNextCountTimer(61, 155493)
local timerFireStorm					= mod:NewBuffActiveTimer(14, 155493)

local berserkTimer						= mod:NewBerserkTimer(420)

local countdownCinderWolves				= mod:NewCountdown(76, 155776)
local countdownFireStorm				= mod:NewCountdown(61, 155493)--Same voice as wolves cause never happen at same time, in fact they alternate.
local countdownEnchantedArmaments		= mod:NewCountdown("OptionVersion2", "Alt45", 156724, false)
local countdownOverheated				= mod:NewCountdownFades("Alt20", 154950, "Tank")

local voiceMoltenTorrent				= mod:NewVoice(154932) --runin
local voiceFixate						= mod:NewVoice(154952) --justrun
local voiceCinderWolves					= mod:NewVoice(155776, "-Healer") --killmob
local voiceBlazinRadiance				= mod:NewVoice(155277)  --runaway (scatter if we have power system)
local voiceRisingFlames					= mod:NewVoice(163284)  --changemt
local voiceFireStorm					= mod:NewVoice(155493) --aoe
local voiceLavaSlash					= mod:NewVoice(155318) --runaway

mod:AddRangeFrameOption("10/6")
mod:AddSetIconOption("SetIconOnAdds", 155776, true, true)
mod:AddHudMapOption("HudMapOnFixate", 154952, false)

mod.vb.firestorm = 0
local fixateTagets = {}
local activeBossGUIDS = {}
local wolfIcon = 2--Compatible with bigwigs and DXE

local function showFixate(self)
	local text = {}
	for name, time in pairs(fixateTagets) do
		text[#text + 1] = name
		if self.Options.HudMapOnFixate then
			DBMHudMap:RegisterRangeMarkerOnPartyMember(154952, "highlight", name, 3.5, 10, 1, 1, 0, 0.5, nil, true):Pulse(0.5, 0.5)
		end
	end
	warnFixate:Show(table.concat(text, "<, >"))
	table.wipe(fixateTagets)
end

function mod:OnCombatStart(delay)
	self.vb.firestorm = 0
	wolfIcon = 2
	table.wipe(fixateTagets)
	table.wipe(activeBossGUIDS)
	timerLavaSlashCD:Start(11-delay)
	timerMoltenTorrentCD:Start(30-delay)
	timerSummonCinderWolvesCD:Start(60-delay)
	countdownCinderWolves:Start(60-delay)
	if self:IsMythic() then
		berserkTimer:Start(-delay)
	end
	if self.Options.RangeFrame and self:IsRanged() then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMapOnFixate then
		DBMHudMap:Disable()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156018 then
		warnDevastatingSlam:Show()
	elseif spellId == 156040 then
		warnDropHammer:Show()
	elseif spellId == 155382 then
		timerBlazingRadianceCD:Start()
	elseif spellId == 155064 then
		warnRekindle:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155776 then
		specWarnCinderWolves:Show()
		timerBlazingRadianceCD:Start(34)
		timerFireStormCD:Start(nil, self.vb.firestorm+1)
		voiceFireStorm:Schedule(56.5, "aesoon")
		countdownFireStorm:Start()
		voiceCinderWolves:Play("killmob")
		wolfIcon = 2
		if self.Options.SetIconOnAdds and not self:IsLFR() then
			self:RegisterShortTermEvents(
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to make sure we wipe vb.on pull
			)
		end
	elseif spellId == 155074 then
		timerCharringBreathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155277 then
		warnBlazingRadiance:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnBlazinRadiance:Show()
			yellBlazinRadiance:Yell()
			voiceBlazinRadiance:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 154952 then
		--Schedule, do to dogs changing mind bug
		if not fixateTagets[args.destName] then
			fixateTagets[args.destName] = GetTime()
		end
		if args:IsPlayer() then
			--Schedule, do to dogs changing mind bug
			timerFixate:Schedule(0.4)
			specWarnFixate:Schedule(0.4)
			voiceFixate:Schedule(0.4, "justrun")
		end
		self:Unschedule(showFixate)
		self:Schedule(0.4, showFixate, self)
	elseif spellId == 163284 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRisingFlames:Show(args.destName, amount)
			if amount >= 6 then
				if args:IsPlayer() then--At this point the other tank SHOULD be clear.
					specWarnRisingFlames:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitDebuff("player", GetSpellInfo(163284)) and not UnitIsDeadOrGhost("player") then
						specWarnRisingFlamesOther:Show(args.destName)
						voiceRisingFlames:Play("changemt")
					end
				end
			end
		end
	elseif spellId == 155074 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") or self:IsTanking(uId, "boss3") or self:IsTanking(uId, "boss4") or self:IsTanking(uId, "boss5") then
			local amount = args.amount or 1
			warnCharringBreath:Show(args.destName, amount)
			if amount >= 2 then
				if args:IsPlayer() then
					specWarnCharringBreath:Show(amount)
				else--Taunt as soon as stacks are clear, regardless of stack count.
					if not UnitDebuff("player", GetSpellInfo(155074)) and not UnitIsDeadOrGhost("player") then
						specWarnCharringBreathOther:Show(args.destName)
					end
				end
			end
		end
	elseif spellId == 154932 then
		timerMoltenTorrentCD:Start()
		if args:IsPlayer() then
			specWarnMoltenTorrent:Show()
			voiceMoltenTorrent:Play("runin")
			yellMoltenTorrent:Schedule(5, 1)
			yellMoltenTorrent:Schedule(4, 2)
			yellMoltenTorrent:Schedule(3, 3)
			yellMoltenTorrent:Schedule(2, 4)
			yellMoltenTorrent:Schedule(1, 5)
		else
			warnMoltenTorrent:Show(args.destName)
		end
	elseif spellId == 154950 then
		specWarnOverheated:Show()
		timerOverheated:Start(args.destName)
		timerCharringBreathCD:Start()
		countdownOverheated:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155277 and args:IsPlayer() then
		if self.Options.RangeFrame then
			if self:IsRanged() then
				DBM.RangeCheck:Show(6)
			else
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 154932 then
		if args:IsPlayer() then
			yellMoltenTorrent:Cancel()--In case player dies
		end
	elseif spellId == 154950 then
		timerOverheated:Cancel(args.destName)
		countdownOverheated:Cancel()
	elseif spellId == 154952 then
		if args:IsPlayer() then
			timerFixate:Cancel()
			specWarnFixate:Cancel()
			voiceFixate:Cancel()
			if GetTime() - (fixateTagets[args.destName] or 0) > 1 then
				specWarnFixateEnded:Show()
			end
		end
		if self.Options.HudMapOnFixate then
			DBMHudMap:FreeEncounterMarkerByTarget(spellId, args.destName)
		end
		if fixateTagets[args.destName] then
			fixateTagets[args.destName] = nil
		end
	elseif spellId == 155493 then
		specWarnFireStormEnded:Show()
		if self:IsMelee() then
			voiceFireStorm:Play("safenow")
		else
			voiceFireStorm:Play("scatter")
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 155314 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnLavaSlash:Show()
		voiceLavaSlash:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local expectedTotal = self:IsMythic() and 6 or 4
	for i = 1, 5 do
		local unitID = "boss"..i
		local unitGUID = UnitGUID(unitID)
		if UnitExists(unitID) and not activeBossGUIDS[unitGUID] then
			local cid = self:GetCIDFromGUID(unitGUID)
			if cid == 76794 then--Cinder Wolf
				wolfIcon = wolfIcon + 1
				activeBossGUIDS[unitGUID] = true
				SetRaidTarget(unitID, wolfIcon)
				if wolfIcon == expectedTotal then--All wolves marked
					self:UnregisterShortTermEvents()
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 163644 then
		warnSummonEnchantedArmaments:Show()
		if self:IsMythic() then
			timerSummonEnchantedArmamentsCD:Start(20)
			countdownEnchantedArmaments:Start(20)
		else
			timerSummonEnchantedArmamentsCD:Start()
			countdownEnchantedArmaments:Start()
		end
	elseif spellId == 154914 then
		warnLavaSlash:Show()
		timerLavaSlashCD:Start()
	elseif spellId == 155564 then--Firestorm (2 seconds faster than spell cast start
		self.vb.firestorm = self.vb.firestorm + 1
		specWarnFireStorm:Show(self.vb.firestorm)
		timerBlazingRadianceCD:Cancel()
		timerFireStorm:Start()
		timerMoltenTorrentCD:Start(42.5)
		timerSummonCinderWolvesCD:Start()
		countdownCinderWolves:Start()
		voiceFireStorm:Play("gather")
	end
end
