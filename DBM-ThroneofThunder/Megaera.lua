if select(4, GetBuildInfo()) < 50200 then return end--Don't load on live
local mod	= DBM:NewMod(821, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(68065, 70212, 70235, 70247)--flaming 70212. Frozen 70235, Venomous 70247
mod:SetModelID(47414)--Hydra Fire Head, 47415 Frost Head, 47416 Poison Head


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnRampage				= mod:NewTargetAnnounce(139458, 3)
local warnArcticFreeze			= mod:NewStackAnnounce(139843, 3, nil, mod:IsTank() or mod:IsHealer())
local warnIgniteFlesh			= mod:NewStackAnnounce(137731, 3, nil, mod:IsTank() or mod:IsHealer())
local warnRotArmor				= mod:NewStackAnnounce(139840, 3, nil, mod:IsTank() or mod:IsHealer())
local warnCinders				= mod:NewTargetAnnounce(139822, 4)
local warnTorrentofIce			= mod:NewSpellAnnounce(139822, 4)--Cannot get target, no debuff. Maybe they get an emote? i was tank so I don't know. can't target scan because back heads aren't targetable

local specWarnRampage			= mod:NewSpecialWarningSpell(139458, nil, nil, nil, true)
local specWarnArcticFreeze		= mod:NewSpecialWarningStack(139843, mod:IsTank(), 2)
local specWarnIgniteFlesh		= mod:NewSpecialWarningStack(137731, mod:IsTank(), 2)
local specWarnRotArmor			= mod:NewSpecialWarningStack(139840, mod:IsTank(), 2)
local specWarnCinders			= mod:NewSpecialWarningYou(139822)
local yellCinders				= mod:NewYell(139822)
local specWarnTorrentofIceYou	= mod:NewSpecialWarningRun(139889)
local yellTorrentofIce			= mod:NewYell(139889)
local specWarnTorrentofIce		= mod:NewSpecialWarningMove(139889)

local timerRampage				= mod:NewBuffActiveTimer(20, 139458)
local timerArcticFreezeCD		= mod:NewCDTimer(17, 139843, mod:IsTank() or mod:IsHealer())--breath cds are very often syncronized, but not always, sometimes if mobs not engaged same time they go off sync.
local timerIgniteFleshCD		= mod:NewCDTimer(17, 137731, mod:IsTank() or mod:IsHealer())--So must start cd bars for both in case of engage delays
local timerRotArmorCD			= mod:NewCDTimer(17, 139840, mod:IsTank() or mod:IsHealer())--This may have been PTR bug, if they stay synce don live, i will combine these 3 timers into 1
local timerCinderCD				= mod:NewCDTimer(10, 139822)--10-20sec variation observed with 2 fire heads in back. mostly 10 though.
local timerTorrentofIceCD		= mod:NewCDTimer(16, 139866)
local timerAcidRainCD			= mod:NewCDTimer(13.5, 139850)--Can only give time for next impact, no cast trigger so cannot warn cast very effectively. Maybe use some scheduling to pre warn. Although might be VERY spammy if you have many venomous up

local soundTorrentofIce			= mod:NewSound(139889)

--count will go to hell fast on a DC though. Need to figure out some kind of head status recovery to get active/inactive head counts.
--Maybe add an info frame that shows head status too would be cool such as
---------------------------
--Flaming head: A: 0 I: 2 -
--Frozen head: A: 1 I: 1  -
--Venomous head: A: 1 I: 1-
---------------------------
local fireInFront = 0
local venomInFront = 0
local iceInFront = 0
local fireBehind = 0
local venomBehind = 0
local iceInBehind = 0
local activeHeadGUIDS = {}
local frozenHead = EJ_GetSectionInfo(7002)
local flamingHead = EJ_GetSectionInfo(6998)
local venomousHead = EJ_GetSectionInfo(7004)

function mod:OnCombatStart(delay)
	table.wipe(activeHeadGUIDS)
	fireInFront = 0
	venomInFront = 0
	iceInFront = 0
	fireBehind = 0
	venomBehind = 0
	iceInBehind = 0
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(139866) then
		warnTorrentofIce:Show()
		timerTorrentofIceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(139843) then
		warnArcticFreeze:Show(args.destName, args.amount or 1)
		timerArcticFreezeCD:Start(args.sourceGUID)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnArcticFreeze:Show(args.amount)
			end
		end
	elseif args:IsSpellID(137731) then
		warnIgniteFlesh:Show(args.destName, args.amount or 1)
		timerIgniteFleshCD:Start(args.sourceGUID)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnIgniteFlesh:Show(args.amount)
			end
		end
	elseif args:IsSpellID(139840) then
		warnRotArmor:Show(args.destName, args.amount or 1)
		timerRotArmorCD:Start(args.sourceGUID)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnRotArmor:Show(args.amount)
			end
		end
	elseif args:IsSpellID(139822) then
		warnCinders:Show(args.destName)
		timerCinderCD:Start()--TODO: See if Cd is affected by number of backrow heads.
		if args:IsPlayer() then
			specWarnCinders:Show()
			yellCinders:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 139850 and self:AntiSpam(2, 1) then
		timerAcidRainCD:Start(13.5)--TODO, it should be cast more often more heads there are. this is timing with two heads in back. Find out timing with 1 head, or 3 or 4
	elseif spellId == 139889 and self:AntiSpam(2, 2) then
		specWarnTorrentofIce:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:139458") then
		warnRampage:Show()
		if fireInFront + venomInFront + iceInFront < 2 then--This basically filters pull rampage., any other time boss rampages, it will be when 
			timerArcticFreezeCD:Cancel()
			timerIgniteFleshCD:Cancel()
			timerRotArmorCD:Cancel()
			--Not if back ones always cancel here, they seem too
			timerCinderCD:Cancel()
			timerTorrentofIceCD:Cancel()
			timerAcidRainCD:Cancel()
			specWarnRampage:Show()
			timerRampage:Start()
		end
	elseif msg == L.rampageEnds or msg:find(L.rampageEnds) then
		if iceInFront > 0 then
			timerArcticFreezeCD:Start(10)
		end
		if fireInFront > 0 then
			timerIgniteFleshCD:Start(10)
		end
		if venomInFront > 0 then
			timerRotArmorCD:Start(10)
		end
		if iceInBehind > 0 then
			timerTorrentofIceCD:Start(20)
		end
		if fireBehind > 0 then
			timerCinderCD:Start()
		end
		if venomBehind > 0 then
			timerAcidRainCD:Start(23)
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:139866") then
		specWarnTorrentofIceYou:Show()
		yellTorrentofIce:Yell()
		soundTorrentofIce:Play()
	end
end

--Only real way to detect heads moving from back to front.
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		if UnitExists("boss"..i) and not activeHeadGUIDS[UnitGUID("boss"..i)] then--Check if new units exist we haven't detected and added yet.
			activeHeadGUIDS[UnitGUID("boss"..i)] = true
			if UnitName("boss"..i) == frozenHead then
				iceInFront = iceInFront + 1
				if iceInBehind > 0 then
					iceInBehind = iceInBehind - 1
				end
			elseif UnitName("boss"..i) == flamingHead then
				fireInFront = fireInFront + 1
				if fireBehind > 0 then
					fireBehind = fireBehind - 1
				end
			elseif UnitName("boss"..i) == venomousHead then
				venomInFront = venomInFront + 1
				if venomBehind > 0 then
					venomBehind = venomBehind - 1
				end
			end
			print("DBM Boss Debug: ", "Active Heads: ".."Fire: "..fireInFront.." Ice: "..iceInFront.." Venom: "..venomInFront)
			print("DBM Boss Debug: ", "Inactive Heads: ".."Fire: "..fireBehind.." Ice: "..iceInBehind.." Venom: "..venomBehind)
		end
	end
end

--Unfortunately we need to update the counts sooner than UNIT_DIED fires because we need those counts BEFORE CHAT_MSG_RAID_BOSS_EMOTE fires.
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	--"<84.1 20:31:16> [UNIT_SPELLCAST_SUCCEEDED] Venomous Head [[boss4:Damage Body::0:134258]]", -- [7057]
	if spellId == 134258 and self:AntiSpam(2, 3) then--Damage Body (Head Dying)
		if UnitName(uId) == frozenHead then
			iceInFront = iceInFront - 1
			iceInBehind = iceInBehind + 2
		elseif UnitName(uId) == flamingHead then
			fireInFront = fireInFront - 1
			fireBehind = fireBehind + 2
		elseif UnitName(uId) == venomousHead then
			venomInFront = venomInFront - 1
			venomBehind = venomBehind + 2
		end
	end
end

--Nil out front boss GUIDs and cancel timers for correct died unit so those units can activate again later
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70235 then--Frozen
		activeHeadGUIDS[args.destGUID] = nil
	elseif cid == 70212 then--Flaming
		activeHeadGUIDS[args.destGUID] = nil
	elseif cid == 70247 then--Venomous
		activeHeadGUIDS[args.destGUID] = nil
	end
end
