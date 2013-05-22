local mod	= DBM:NewMod("d646", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 9385 $"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 939)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_EMOTE"
)

--Farastu
local warnIceSpikes			= mod:NewSpellAnnounce(132980, 3)
local warnFrozenSolid		= mod:NewTargetAnnounce(141407, 3)
--Hekima the Wise
local warnHekimasWisdom		= mod:NewCastAnnounce(141423, 4, 4)
local warnZandalarBanner	= mod:NewSpellAnnounce(142669, 4, 4)

--Farastu
local specWarnIceSpikes		= mod:NewSpecialWarningMove(132980)
local specWarnFrozenSolid	= mod:NewSpecialWarningSwitch(141407)
--Hekima the Wise
local specWarnHekimasWisdom	= mod:NewSpecialWarningInterrupt(141423)--Not only cast by last boss but trash near him as well, interrupt important for both. Although only bosses counts for achievement.
local specWarnZandalarBanner= mod:NewSpecialWarningSwitch(142669)

--Farastu
local timerIceSpikesCD		= mod:NewCDTimer(10, 132980)
local timerFrozenSolidCD	= mod:NewCDTimer(25, 141407)

mod:RemoveOption("HealthFrame")

function mod:SPELL_CAST_START(args)
	if args.spellId == 141423 then
		warnHekimasWisdom:Show()
		specWarnHekimasWisdom:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 132980 then
		warnIceSpikes:Show()
		specWarnIceSpikes:Show()
		timerIceSpikesCD:Start()
	elseif args.spellId == 132980 then
		warnZandalarBanner:Show()
		specWarnZandalarBanner:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70474 then--Farastu
		timerIceSpikesCD:Cancel()
		timerFrozenSolidCD:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg:find("spell:141407") then--Does show in combat log, but emote gives targetname 2 seconds earlier.
		local target = DBM:GetFullNameByShortName(target)
		warnFrozenSolid:Show(target)
		specWarnFrozenSolid:Show()
		timerFrozenSolidCD:Start()
	end
end
