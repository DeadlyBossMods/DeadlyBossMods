local mod	= DBM:NewMod(1123, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76814)--76794 Cinder Wolf, 80590 Aknor Steelbringer
mod:SetEncounterID(1689)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154932 156018 156040 155382",
	"SPELL_CAST_SUCCESS 155318 155776 156724",
	"SPELL_AURA_APPLIED 155277 155493 154952 163284 154950 155074",
	"SPELL_AURA_APPLIED_DOSE 163284 154950 155074",
	"SPELL_AURA_REMOVED 155277"
)
--Who is this dude?
local warnDevastatingSlam				= mod:NewSpellAnnounce(156018, 4)
local warnDropHammer					= mod:NewSpellAnnounce(156040, 3)--Target scanning?

--local warnLavaSlash					= mod:NewSpellAnnounce(155318, 2, nil, false)--Likely cast often & doesn't show in combat log anyways except for damage and not THAT important
local warnSummonEnchantedArmaments		= mod:NewSpellAnnounce(156724, 3)
local warnMoltenTorrent					= mod:NewSpellAnnounce(154932, 3)
local warnSummonCinderWolves			= mod:NewSpellAnnounce(155776, 3)--Cast trigger could be anything, undefined on wowhead. just "Channeled" which I've seen use START, SUCCESS and even APPLIED. sigh
local warnFixate						= mod:NewTargetAnnounce(154952, 3)
local warnFireStorm						= mod:NewSpellAnnounce(155493, 4, nil, mod:IsTank())
local warnBlazingRadiance				= mod:NewTargetAnnounce(155277, 3)
local warnFireStorm						= mod:NewSpellAnnounce(155493, 4)
local warnRisingFlames					= mod:NewStackAnnounce(163284, 2, nil, mod:IsTank())
local warnCharringBreath				= mod:NewStackAnnounce(155074, 2, nil, mod:IsTank())

local specWarnMoltenTorrent				= mod:NewSpecialWarningSpell(154932, nil, nil, nil, 2)
local specWarnCinderWolves				= mod:NewSpecialWarningSwitch(155776, not mod:IsHealer())
local specWarnFixate					= mod:NewSpecialWarningYou(154952)--Need to be run warning instead?
local specWarnBlazinRadiance			= mod:NewSpecialWarningYou(155277)
local yellBlazinRadiance				= mod:NewYell(155277)
local specWarnFireStorm					= mod:NewSpecialWarningSpell(155493, nil, nil, nil, 2)
local specWarnRisingFlames				= mod:NewSpecialWarningStack(163284, nil, 12)--stack guessed
local specWarnRisingFlamesOther			= mod:NewSpecialWarningTaunt(163284)
local specWarnCharringBreath			= mod:NewSpecialWarningYou(155074)--Assumed based on timing and casts, that you swap every breath.
local specWarnCharringBreathOther		= mod:NewSpecialWarningTaunt(155074)

--local timerLavaSlashCD				= mod:NewCDTimer(10, 155318, nil, false)
local timerMoltenTorrentCD				= mod:NewCDTimer(14, 154932)
local timerSummonCinderWolvesCD			= mod:NewNextTimer(60, 155776)
local timerBlazingRadianceCD			= mod:NewCDTimer(12, 155277)
local timerFireStormCD					= mod:NewNextTimer(63, 155493)

mod:AddRangeFrameOption("10/6")

function mod:OnCombatStart(delay)
	timerMoltenTorrentCD:Start(30-delay)
	timerSummonCinderWolvesCD:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 154932 then
		warnMoltenTorrent:Show()
		specWarnMoltenTorrent:Show()
		timerMoltenTorrentCD:Start()
	elseif spellId == 156018 then
		warnDevastatingSlam:Show()
	elseif spellId == 156040 then
		warnDropHammer:Show()
	elseif spellId == 155382 then
		timerBlazingRadianceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 155776 then--Move to START or APPLIED if wrong
		warnSummonCinderWolves:Show()
		specWarnCinderWolves:Show()
		timerBlazingRadianceCD:Start(34)
		timerFireStormCD:Start()
	elseif spellId == 156724 then--Move to START or APPLIED if wrong
		warnSummonEnchantedArmaments:Show()
--[[elseif spellId == 155318 then
		warnLavaSlash:Show()
		--timerLavaSlashCD:Start()--]]
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155277 then
		warnBlazingRadiance:CombinedShow(0.5, args.destName)--Assume it can affect more than one target
		if args:IsPlayer() then
			specWarnBlazinRadiance:Show()
			yellBlazinRadiance:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 155493 then--Move to START or SUCCESS if wrong
		warnFireStorm:Show()
		specWarnFireStorm:Show()
		--timerMoltenTorrentCD:Start()
		timerBlazingRadianceCD:Cancel()
		timerMoltenTorrentCD:Start(30)
		timerSummonCinderWolvesCD:Start()
	elseif spellId == 154952 then
		warnFixate:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()--Are these kited? add a run away sound?
		end
	elseif spellId == 163284 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRisingFlames:Show(args.destName, amount)
		end
		if amount % 3 == 0 and amount >= 12 then--Stack count unknown
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnRisingFlames:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(163284)) and not UnitIsDeadOrGhost("player") then
					specWarnRisingFlamesOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 155074 then
		local amount = args.amount or 1
		warnCharringBreath:Show(args.destName, amount)
		if args:IsPlayer() then
			specWarnCharringBreath:Show()
		else--Taunt as soon as stacks are clear, regardless of stack count.
			if not UnitDebuff("player", GetSpellInfo(155074)) and not UnitIsDeadOrGhost("player") then
				specWarnCharringBreathOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155277 and args:IsPlayer() then
		specWarnBlazinRadiance:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 50630 and self:AntiSpam(2, 3) then--Eject All Passengers:
	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("cFFFF0404") then

	elseif msg:find(L.tower) then

	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(20, 4) and self:IsInCombat() then

	end
end--]]
