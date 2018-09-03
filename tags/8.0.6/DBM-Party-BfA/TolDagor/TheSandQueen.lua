local mod	= DBM:NewMod(2097, "DBM-Party-BfA", 9, 1001)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(127479)
mod:SetEncounterID(2101)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START 257092 257608 257495",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, figure out why cast time for upheavel isn't honoring 5 second pre coded
local warnUpheavel					= mod:NewTargetAnnounce(257617, 2)
local warnUpheavelCast				= mod:NewCastAnnounce(257617, 2, 5)--Cast time until we have a target

local specWarnSandTrap				= mod:NewSpecialWarningDodge(257092, nil, nil, nil, 2, 2)
local specWarnUpheavel				= mod:NewSpecialWarningYou(257617, nil, nil, nil, 2, 2)
local yellUpheavel					= mod:NewYell(257617)
local specWarnUpheavelNear			= mod:NewSpecialWarningClose(257617, nil, nil, nil, 2, 2)
local specWarnSandstorm				= mod:NewSpecialWarningSpell(257092, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--local timerReapSoulCD				= mod:NewNextTimer(13, 194956, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON)
local timerSandTrapCD				= mod:NewCDTimer(14.2, 257092, nil, nil, nil, 3)--14.2-18.6
local timerUpheavelCD				= mod:NewCDTimer(43.4, 257617, nil, nil, nil, 3)
local timerSandstormCD				= mod:NewCDTimer(34, 257495, nil, nil, nil, 2)--Health based?

--mod:AddRangeFrameOption(5, 194966)

function mod:OnCombatStart(delay)
	timerSandTrapCD:Start(8.5-delay)
	timerUpheavelCD:Start(20.5-delay)
	timerSandstormCD:Start(30.3-delay)
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 194966 then
	
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 257092 then
		specWarnSandTrap:Show()
		specWarnSandTrap:Play("watchstep")
		timerSandTrapCD:Start()
	elseif spellId == 257608 then
		warnUpheavelCast:Show()
		timerUpheavelCD:Start()
	elseif spellId == 257495 then
		specWarnSandstorm:Show()
		specWarnSandstorm:Play("aesoon")
		timerSandstormCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:257617") then
		if targetname then--Normal, only one person affected, name in emote
			if targetname == UnitName("player") then
				specWarnUpheavel:Show()
				specWarnUpheavel:Play("targetyou")
				yellUpheavel:Yell()
			elseif self:CheckNearby(10, targetname) then
				specWarnUpheavelNear:Show(targetname)
				specWarnUpheavelNear:Play("watchstep")
			else
				warnUpheavel:Show(targetname)
			end
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124396 then
		
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 257939 then
	end
end
--]]
