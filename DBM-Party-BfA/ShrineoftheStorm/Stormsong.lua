local mod	= DBM:NewMod(2155, "DBM-Party-BfA", 4, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(134060)
mod:SetEncounterID(2132)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 268896 269131",
	"SPELL_CAST_START 268347 269097",
	"SPELL_CAST_SUCCESS 268896 269131"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

local specWarnVoidBolt				= mod:NewSpecialWarningInterruptCount(268347, "HasInterrupt", nil, nil, 1, 2)
local specWarnMindRend				= mod:NewSpecialWarningDispel(268896, "Healer", nil, nil, 1, 2)
local specWarnWakentheVoid			= mod:NewSpecialWarningDodge(269097, nil, nil, nil, 2, 2)
local specWarnAncientMindbender		= mod:NewSpecialWarningSwitch(269131, nil, nil, nil, 1, 2)
local specWarnAncientMindbenderYou	= mod:NewSpecialWarningMoveTo(269131, nil, nil, nil, 1, 2)
local yellAncientMindbender			= mod:NewYell(269131)

local timerRP						= mod:NewRPTimer(68)
local timerVoidBoltCD				= mod:NewCDTimer(7.3, 268347, nil, "HasInterrupt", nil, 4, nil, DBM_CORE_INTERRUPT_ICON)
local timerMindRendCD				= mod:NewCDTimer(10.5, 268896, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_MAGIC_ICON)
--local timerWakentheVoidCD			= mod:NewCDTimer(52.3, 269097, nil, nil, nil, 3)--IFFY, could be health based
local timerAncientMindbenderCD		= mod:NewCDTimer(42.5, 269131, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON)--Health based?

mod.vb.interruptCount = 0

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	timerMindRendCD:Start(16-delay)
	--timerWakentheVoidCD:Start(13.1-delay)
	timerAncientMindbenderCD:Start(19.6-delay)--SUCCESS
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 268896 and self:CheckDispelFilter() then
		specWarnMindRend:Show(args.destName)
		specWarnMindRend:Play("helpdispel")
	elseif spellId == 269131 then
		if args:IsPlayer() then
			specWarnAncientMindbenderYou:Show(DBM_CORE_ORB)
			specWarnAncientMindbenderYou:Play("takedamage")
			yellAncientMindbender:Yell()
		else
			specWarnAncientMindbender:Show()
			specWarnAncientMindbender:Play("findmc")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 269097 then
		specWarnWakentheVoid:Show()
		specWarnWakentheVoid:Play("watchorb")
		--timerWakentheVoidCD:Start()
	elseif spellId == 268347 then
		timerVoidBoltCD:Start()
		if self.vb.interruptCount == 2 then self.vb.interruptCount = 0 end
		self.vb.interruptCount = self.vb.interruptCount + 1
		local kickCount = self.vb.interruptCount
		specWarnVoidBolt:Show(args.sourceName, kickCount)
		if kickCount == 1 then
			specWarnVoidBolt:Play("kick1r")
		elseif kickCount == 2 then
			specWarnVoidBolt:Play("kick2r")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 268896 then
		timerMindRendCD:Start()
	elseif spellId == 269131 then
		timerAncientMindbenderCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg, npc, _, _, target)
	--"<5.12 02:26:06> [CHAT_MSG_MONSTER_SAY] It would seem you have guests, Lord Stormsong.#Queen Azshara###Omegal##0#0##0#979#nil#0#false#false#false#false", -- [11]
	--"<34.74 02:26:36> [ENCOUNTER_START] ENCOUNTER_START#2132#Lord Stormsong#1#5", -- [20]
	if (msg == L.openingRP or msg:find(L.openingRP)) and self:LatencyCheck() then
		self:SendSync("openingRP")
	end
end

function mod:OnSync(msg, targetname)
	if msg == "openingRP" and self:AntiSpam(10, 6) then
		timerRP:Start(24.6)
	end
end
