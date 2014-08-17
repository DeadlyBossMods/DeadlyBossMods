local mod	= DBM:NewMod("d511", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetZone()

mod:RegisterCombat("scenario", 1031)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
--	"SPELL_AURA_REMOVED"
)
mod.onlyNormal = true

local warnFlameWall				= mod:NewSpellAnnounce(123966, 4)

local specWarnFlameWall			= mod:NewSpecialWarningSpell(123966, nil, nil, nil, true)

mod:RemoveOption("HealthFrame")

--[[
--Needs more data, i'm not sure if it has a CD or is just health based atm so no CD timer just yet.
"<378.3> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#She's here to make new friends... and then set them on fire! It's Pandaria's prettiest little playful pyromaniac, Liuyang!
"<426.1> [CLEU] SPELL_CAST_START#false#0xF130F75100000965#Little Liuyang#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#123966#Flame Wall#4", -- [5522]
"<473.5> [CLEU] SPELL_AURA_REMOVED#false#0xF130F75100000965#Little Liuyang#68168#0#0xF130F75100000965#Little Liuyang#68168#0#123966#Flame Wall#4#BUFF", -- [6368]
"<509.4> [CLEU] SPELL_CAST_START#false#0xF130F75100000965#Little Liuyang#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#123966#Flame Wall#4", -- [6965]
"<544.3> [CLEU] SPELL_AURA_REMOVED#false#0xF130F75100000965#Little Liuyang#2632#0#0xF130F75100000965#Little Liuyang#2632#0#123966#Flame Wall#4#BUFF", -- [7546]
--]]

function mod:SPELL_CAST_START(args)
	if args.spellId == 123966 then
		warnFlameWall:Show()
		specWarnFlameWall:Show()
	end
end

--[[
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 123966 then

	end
end
--]]
