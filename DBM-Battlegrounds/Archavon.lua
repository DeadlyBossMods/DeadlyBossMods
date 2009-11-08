local mod	= DBM:NewMod("Archavon", "DBM-Battlegrounds")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(31125)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--11/19 19:20:12.949  SPELL_AURA_APPLIED,0xF150007995000007,"Archavon the Stone Watcher",0xa48,0xF140544DF3000002,"Teufelssaurier",0x1114,58678,"Rock Shards",0x1,DEBUFF
--11/19 19:20:16.527  SPELL_AURA_REMOVED,0xF150007995000007,"Archavon the Stone Watcher",0xa48,0xF140544DF3000002,"Teufelssaurier",0x1114,58678,"Rock Shards",0x1,DEBUFF

local warnShards		= mod:NewAnnounce("WarningShards", 2, 58678)
local warnGrab			= mod:NewAnnounce("WarningGrab", 2, 53041)
local timerShards		= mod:NewTimer(4, "TimerShards", 58678)

local enrageTimer	= mod:NewEnrageTimer(300)

function mod:OnCombatStart(delay)
	enrageTimer:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 58678 or args.spellId == 58941 then
		warnShards:Show(args.destName)
		timerShards:Start(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	local target = msg and msg:match(L.TankSwitch)
	if target then
		warnGrab:Show(target)
	end
end
