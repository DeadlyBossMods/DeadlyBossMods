local mod	= DBM:NewMod("AtonementTrash", "DBM-Party-Shadowlands", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
--mod:SetModelID(47785)

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 326409 326450 325523 325700 325701 326607",
	"SPELL_AURA_APPLIED 326450",
	"SPELL_AURA_REMOVED 326409"
)

--All warnings/recommendations drycoded from https://www.wowhead.com/guides/halls-of-atonement-shadowlands-dungeon-strategy-guide
--Notable Halkias Trash
local warnThrash						= mod:NewSpellAnnounce(326409, 3)
local warnLoyalBeasts					= mod:NewCastAnnounce(326450, 4)--Announce the cast, in case someone can stun it

--General
--local specWarnGTFO						= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)
--Notable Halkias Trash
local specWarnSinQuake					= mod:NewSpecialWarningDodge(326441, nil, nil, nil, 2, 2)
local specWarnLoyalBeasts				= mod:NewSpecialWarningTarget(326450, "RemoveEnrage|Tank", nil, nil, 1, 2)--Target because it's hybrid warning
local specWarnDeadlyThrust				= mod:NewSpecialWarningDodge(325523, "Tank", nil, nil, 1, 2)
local specWarnCollectSins				= mod:NewSpecialWarningInterrupt(325700, "HasInterrupt", nil, nil, 1, 2)
local specWarnSiphonLife				= mod:NewSpecialWarningInterrupt(325701, "HasInterrupt", nil, nil, 1, 2)
--Notable Echelon Trash
local specWarnTurntoStone				= mod:NewSpecialWarningInterrupt(326607, "HasInterrupt", nil, nil, 1, 2)

--Antispam IDs for this mod: 1 run away, 2 dodge, 3 dispel, 4 incoming damage, 5 you/role, 6 generalized

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 326409 and self:AntiSpam(3, 4) then
		warnThrash:Show()
	elseif spellId == 326450 and self:AntiSpam(3, 6) then
		warnLoyalBeasts:Show()
	elseif spellId == 325523 and self:AntiSpam(3, 2) then
		specWarnDeadlyThrust:Show()
		specWarnDeadlyThrust:Play("shockwave")
	elseif spellId == 325700 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnCollectSins:Show(args.sourceName)
		specWarnCollectSins:Play("kickcast")
	elseif spellId == 325701 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSiphonLife:Show(args.sourceName)
		specWarnSiphonLife:Play("kickcast")
	elseif spellId == 326607 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTurntoStone:Show(args.sourceName)
		specWarnTurntoStone:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 326450 and self:AntiSpam(3, 5) then
		specWarnLoyalBeasts:Show(args.destName)
		specWarnLoyalBeasts:Play("enrage")
	end
end

--"<185.37 23:03:18> [CLEU] SPELL_AURA_REMOVED#Creature-0-2085-2287-9145-164557-000126FD07#Shard of Halkias#Creature-0-2085-2287-9145-164557-000126FD07#Shard of Halkias#326409#Thrash#BUFF#nil", -- [1273]
--"<186.29 23:03:19> [CLEU] SPELL_CAST_START#Creature-0-2085-2287-9145-164557-000126FD07#Shard of Halkias##nil#326441#Sin Quake#nil#nil", -- [1286]
function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 326409 then
		specWarnSinQuake:Show()
		specWarnSinQuake:Play("watchstep")
	end
end
