local mod	= DBM:NewMod(1123, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76814)--76794 Cinder Wolf, 80590 Aknor Steelbringer
mod:SetEncounterID(1689)
mod:SetZone()
mod:SetHotfixNoticeRev(12869)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 156018 156040 155382 155064",
	"SPELL_CAST_SUCCESS 155776 155074",
	"SPELL_AURA_APPLIED 155277 155493 154952 163284 155074 154932 154950",
	"SPELL_AURA_APPLIED_DOSE 163284 155074",
	"SPELL_AURA_REMOVED 155277 154932 154950 154952 155493",
	"SPELL_PERIODIC_DAMAGE 155314",
	"SPELL_ABSORBED 155314",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Pointless add fight starts with (need to keep alive for follower achievement
local warnDevastatingSlam				= mod:NewSpellAnnounce(156018, 4)
local warnDropHammer					= mod:NewSpellAnnounce(156040, 3)--Target scanning?

local warnLavaSlash						= mod:NewSpellAnnounce(155318, 2, nil, false)--Likely cast often & doesn't show in combat log anyways except for damage and not THAT important
local warnSummonEnchantedArmaments		= mod:NewSpellAnnounce(156724, 3)
local warnMoltenTorrent					= mod:NewTargetAnnounce(154932, 3)
local warnRekindle						= mod:NewCastAnnounce(155064, 4)
local warnFixate						= mod:NewTargetAnnounce(154952, 3)
local warnBlazingRadiance				= mod:NewTargetAnnounce(155277, 3)
local warnRisingFlames					= mod:NewStackAnnounce(163284, 2, nil, "Tank")
local warnCharringBreath				= mod:NewStackAnnounce(155074, 2, nil, "Tank")

local specWarnLavaSlash					= mod:NewSpecialWarningMove(155318, nil, nil, nil, nil, nil, 2)
local specWarnMoltenTorrent				= mod:NewSpecialWarningYou(154932, nil, nil, nil, nil, nil, 2)
local specWarnMoltenTorrentOther		= mod:NewSpecialWarningMoveTo(154932, false)--Strat dependant. most strats i saw ran these into meleee instead of running to the meteor target.
local yellMoltenTorrent					= mod:NewFadesYell(154932)
local specWarnCinderWolves				= mod:NewSpecialWarningSpell(155776, nil, nil, nil, nil, nil, 2)
local specWarnOverheated				= mod:NewSpecialWarningSwitch(154950, "Tank")
local specWarnFixate					= mod:NewSpecialWarningYou(154952, nil, nil, nil, 3, nil, 2)
local specWarnFixateEnded				= mod:NewSpecialWarningEnd(154952, false)
local specWarnBlazinRadiance			= mod:NewSpecialWarningMoveAway(155277, nil, nil, nil, nil, nil, 2)
local yellBlazinRadiance				= mod:NewYell(155277, nil, false)
local specWarnFireStorm					= mod:NewSpecialWarningSpell(155493, nil, nil, nil, 2, nil, 2)
local specWarnFireStormEnded			= mod:NewSpecialWarningEnd(155493)
local specWarnRisingFlames				= mod:NewSpecialWarningStack(163284, nil, 10)--stack guessed
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(163284, nil, nil, nil, nil, nil, 2)
local specWarnCharringBreath			= mod:NewSpecialWarningStack(155074, nil, 3)--Assumed based on timing and casts, that you swap every breath.
local specWarnCharringBreathOther		= mod:NewSpecialWarningTaunt(155074)
--

local timerLavaSlashCD					= mod:NewCDTimer(14.5, 155318, nil, false)
local timerMoltenTorrentCD				= mod:NewCDTimer(14, 154932)
local timerSummonEnchantedArmamentsCD	= mod:NewCDTimer(45, 156724)--45-47sec variation
local timerSummonCinderWolvesCD			= mod:NewNextTimer(74, 155776)
local timerOverheated					= mod:NewTargetTimer(14, 154950, nil, "Tank")
local timerCharringBreathCD				= mod:NewNextTimer(5, 155074, nil, "Tank")
local timerFixate						= mod:NewBuffFadesTimer(9.6, 154952)
local timerBlazingRadianceCD			= mod:NewCDTimer(12, 155277, nil, false)--somewhat important but not important enough. there is just too much going on to be distracted by this timer
local timerFireStormCD					= mod:NewNextTimer(63, 155493)
local timerFireStorm					= mod:NewBuffActiveTimer(12, 155493)

local countdownCinderWolves				= mod:NewCountdown(74, 155776)
local countdownFireStorm				= mod:NewCountdown(63, 155493)--Same voice as wolves cause never happen at same time, in fact they alternate.
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
mod:AddArrowOption("TorrentArrow", 154932, false, true)--Depend strat arrow useful if ranged run to torrent person strat. arrow useless if run torrent into melee strat.
mod:AddHudMapOption("HudMapOnFixate", 154952, false)

local fixateTagets = {}

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
	table.wipe(fixateTagets)
	timerLavaSlashCD:Start(11-delay)
	timerMoltenTorrentCD:Start(30-delay)
	timerSummonCinderWolvesCD:Start(60-delay)
	countdownCinderWolves:Start(60-delay)
	if self.Options.RangeFrame and self:IsRanged() then
		DBM.RangeCheck:Show(6)
	end
	if self.Options.HudMapOnFixate then
		DBMHudMap:Enable()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.TorrentArrow then
		DBM.Arrow:Hide()
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
		timerFireStormCD:Start()
		countdownFireStorm:Start()
		voiceCinderWolves:Play("killmob")
	elseif spellId == 155074 then
		timerCharringBreathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155277 then
		warnBlazingRadiance:CombinedShow(0.5, args.destName)--Assume it can affect more than one target
		if args:IsPlayer() then
			specWarnBlazinRadiance:Show()
			yellBlazinRadiance:Yell()
			voiceBlazinRadiance:Play("runout")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 155493 then
		specWarnFireStorm:Show()
		timerBlazingRadianceCD:Cancel()
		timerFireStorm:Start()
		timerMoltenTorrentCD:Start(44)
		timerSummonCinderWolvesCD:Start()
		countdownCinderWolves:Start()
		voiceFireStorm:Play("aesoon")--maybe gather?
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
		end
		if amount % 3 == 0 and amount >= 10 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRisingFlames:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163284)) and not UnitIsDeadOrGhost("player") then
					specWarnRisingFlamesOther:Show(args.destName)
					voiceRisingFlames:Play("changemt")
				end
			end
		end
	elseif spellId == 155074 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") or self:IsTanking(uId, "boss2") or self:IsTanking(uId, "boss3") or self:IsTanking(uId, "boss4") or self:IsTanking(uId, "boss5") then
			local amount = args.amount or 1
			warnCharringBreath:Show(args.destName, amount)
			if amount >= 3 then
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
		warnMoltenTorrent:Show(args.destName)
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
			specWarnMoltenTorrentOther:Show(args.destName)
			if self.Options.TorrentArrow then
				DBM.Arrow:ShowRunTo(args.destName, 3, 5)
			end
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
		if self.Options.TorrentArrow then
			DBM.Arrow:Hide()
		end
		if args:IsPlayer() then
			yellMoltenTorrent:Cancel()--In case player dieds
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
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 155314 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 1) then
		specWarnLavaSlash:Show()
		voiceLavaSlash:Play("runaway")
	end
end
mod.SPELL_ABSORBED = mod.SPELL_PERIODIC_DAMAGE

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
	end
end

--[[
Blizzard dog fixate bugs.
--Good Fixate
"<223.35 14:20:47> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-061B9D28#Tenebear#154952#Fixate#DEBUFF#nil", -- [8683]
"<223.35 14:20:47> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00015BAB80#Cinder Wolf#Player-84-061BBF60#Fedor#154952#Fixate#DEBUFF#nil", -- [8684]
"<223.35 14:20:47> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061BBF60#Fedor#154952#Fixate#DEBUFF#nil",
"<223.82 14:20:48> DBM_Announce#Fixate on >Tenebear<, >Fedor<", -- [20]
--Good Fixate
"<233.36 14:20:57> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-07146D45#Skrabble#154952#Fixate#DEBUFF#nil", -- [9682]
"<233.36 14:20:57> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00015BAB80#Cinder Wolf#Player-84-06170BC0#Hauntd#154952#Fixate#DEBUFF#nil", -- [9683]
"<233.36 14:20:57> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061C0456#Gligz#154952#Fixate#DEBUFF#nil", -- [
"<233.87 14:20:58> DBM_Announce#Fixate on >Skrabble<, >Hauntd<, >Gligz<", -- [23]
--Bad Fixate (dogs changed mind and switched targets 0.04 seconds after picking first targets
"<243.35 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-061C0456#Gligz#154952#Fixate#DEBUFF#nil", -- [10795]
"<243.35 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00015BAB80#Cinder Wolf#Player-84-061B9D28#Tenebear#154952#Fixate#DEBUFF#nil", -- [10796]
"<243.35 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061C0E66#Will#154952#Fixate#DEBUFF#nil", -- [1
"<243.39 14:21:07> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-00015BAB80#Cinder Wolf#Player-84-061B9D28#Tenebear#154952#Fixate#DEBUFF#nil", -- [10810]
"<243.39 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00005BAB80#Overheated Cinder Wolf#Player-84-0714763A#Hartlin#154952#Fixate#DEBUFF#nil", -- [10811]
"<243.39 14:21:07> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-061C0456#Gligz#154952#Fixate#DEBUFF#nil", -- [10812]
"<243.39 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-07146D45#Skrabble#154952#Fixate#DEBUFF#nil", -- [10813]
"<243.39 14:21:07> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061C0E66#Will#154952#Fixate#DEBUFF#nil", -- [10814]
"<243.39 14:21:07> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-0714763A#Hartlin#154952#Fixate#DEBUFF#nil", -- [10815]
"<243.88 14:21:08> DBM_Announce#Fixate on >Gligz<, >Tenebear<, >Will<, >Hartlin<, >Skrabble<", -- [29]
--Bad Fixate (dogs changed mind and switched targets 0.02 seconds after picking first targets
"<253.39 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-061C0456#Gligz#154952#Fixate#DEBUFF#nil", -- [11819]
"<253.39 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00005BAB80#Cinder Wolf#Player-84-061BDB6C#Zarastro#154952#Fixate#DEBUFF#nil", -- [11820]
"<253.39 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061C0E66#Will#154952#Fixate#DEBUFF#nil", -- [11821]
"<253.41 14:21:17> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-00005BAB80#Cinder Wolf#Player-84-061BDB6C#Zarastro#154952#Fixate#DEBUFF#nil", -- [11825]
"<253.41 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-00005BAB80#Cinder Wolf#Player-84-061C0E66#Will#154952#Fixate#DEBUFF#nil", -- [11826]
"<253.41 14:21:17> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-061C0456#Gligz#154952#Fixate#DEBUFF#nil", -- [11827]
"<253.41 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0000DBAB80#Cinder Wolf#Player-84-07148F4E#Zevoa#154952#Fixate#DEBUFF#nil", -- [11828]
"<253.41 14:21:17> [CLEU] SPELL_AURA_REMOVED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-061C0E66#Will#154952#Fixate#DEBUFF#nil", -- [11829]
"<253.41 14:21:17> [CLEU] SPELL_AURA_APPLIED#Creature-0-3017-1205-30555-76794-0001DBAB80#Cinder Wolf#Player-84-07148F4E#Zevoa#154952#Fixate#DEBUFF#nil", -- [11830]
"<253.93 14:21:18> DBM_Announce#Fixate on >Gligz<, >Zarastro<, >Will<, >Zevoa<", -- [34]
--]]
