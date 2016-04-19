local mod	= DBM:NewMod(1663, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(96759)
mod:SetEncounterID(1824)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 196947 197262",
	"SPELL_AURA_REMOVED 196947",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnTaintofSea					= mod:NewTargetAnnounce(197262, 2, nil, false)
local warnSubmerged						= mod:NewTargetAnnounce(196947, 2)

local specWarnDestructorTentacle		= mod:NewSpecialWarningSwitch("ej12364", "Tank")
local specWarnSubmergedOver				= mod:NewSpecialWarningEnd(196947)

local timerTaintofSeaCD					= mod:NewNextTimer(13, 197262, nil, false, nil, 3)
local timerPiercingTentacleCD			= mod:NewNextTimer(9, 197596, nil, nil, nil, 3)
--local timerDestructorTentacleCD		= mod:NewCDTimer(26, "ej12364", nil, nil, nil, 1)--More data
local timerSubmerged					= mod:NewBuffFadesTimer(15, 196947, nil, nil, nil, 6)

--local voiceCurtainOfFlame				= mod:NewVoice(153392)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerPiercingTentacleCD:Start(8.5)
--	timerDestructorTentacleCD:Start()--Too variable
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196947 then
		timerPiercingTentacleCD:Cancel()
		timerTaintofSeaCD:Cancel()
		warnSubmerged:Show(args.destName)
		timerSubmerged:Start()
		if self.vb.phase == 1 then
			self.vb.phase = 2
		end
	elseif spellId == 197262 then
		warnTaintofSea:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196947 then
		specWarnSubmergedOver:Show()
	end
end

--"<50.03 00:13:36> [CHAT_MSG_RAID_BOSS_EMOTE] |TInterface\\Icons\\inv_misc_monsterhorn_03.blp:20|t A %s emerges!#Destructor Tentacle###Destructor Tentacle##0#0##0#257#nil#0#false#false#false#false"
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then
		specWarnDestructorTentacle:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, spellGUID)
	local _, _, _, _, spellId = strsplit("-", spellGUID)
	if spellId == 197596 then--Piercing Tentacle
		if self.vb.phase == 1 then
			timerPiercingTentacleCD:Start()
		else
			timerPiercingTentacleCD:Start(6)
		end
	end
end
