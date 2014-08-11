local mod	= DBM:NewMod(1154, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76809, 99999)--76809 foreman feldspar, 76809 Security Guard, 76810 Furnace Engineer, 76811 Bellows Operator, 76815 Primal Elementalist, 78463 Slag Elemental, 76821 Firecaller
mod:SetEncounterID(1690)
mod:SetZone()
--mod:SetUsedIcons(7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155186 156937 160379 155179",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED 155192 158702 158345 155242",
	"SPELL_AURA_APPLIED_DOSE 155242",
	"SPELL_AURA_REMOVED 155192",
	"SPELL_PERIODIC_DAMAGE 156932 155223",
	"SPELL_PERIODIC_MISSED 156932 155223"
)

--TODO, figure out if http://beta.wowhead.com/spell=155209 (blast) can be pre warned for, right now it seems like instant cast.
--TODO, Add range finder for when engineers are up for http://beta.wowhead.com/spell=155201
local warnBomb					= mod:NewTargetAnnounce(155192, 4)
local warnCauterizeWounds		= mod:NewCastAnnounce(155186, 4, nil, nil, not mod:IsHealer())
local warnFixate				= mod:NewTargetAnnounce(158702, 4)
local warnPryclasm				= mod:NewCastAnnounce(156937, 3, nil, nil, false)--Needed?
local warnRepair				= mod:NewCastAnnounce(155179, 4, nil, nil, not mod:IsHealer())
local warnDefense				= mod:NewSpellAnnounce(160379, 2, nil, mod:IsTank())
local warnShieldsDown			= mod:NewSpellAnnounce(158345, 1, nil, mod:IsDps())
local warnHeat					= mod:NewStackAnnounce(155242, 2, nil, mod:IsTank())

local specWarnBomb				= mod:NewSpecialWarningYou(155192)
local specWarnCauterizeWounds	= mod:NewSpecialWarningInterrupt(155186, not mod:IsHealer())--if spammy, will switch to target/focus type only
local specWarnFixate			= mod:NewSpecialWarningYou(158702)
local specWarnFixateOther		= mod:NewSpecialWarningTarget(158702, false)--Maybe on by default for healer? depends on threat level.
local specWarnRupture			= mod:NewSpecialWarningMove(156932)
local specWarnMelt				= mod:NewSpecialWarningMove(155223)
local specWarnPyroclasm			= mod:NewSpecialWarningInterrupt(156937, false)--Needed?
local specWarnRepair			= mod:NewSpecialWarningInterrupt(155179, not mod:IsHealer())
local specWarnShieldsDown		= mod:NewSpecialWarningSwitch(158345, mod:IsDps())
local specWarnHeat				= mod:NewSpecialWarningStack(155242, nil, 3)
local specWarnHeatOther			= mod:NewSpecialWarningTaunt(155242)

local timerBomb					= mod:NewBuffFadesTimer(15, 155192)
local timerShieldsDown			= mod:NewBuffActiveTimer(25, 158345, nil, mod:IsDps())--Anyone else need?

function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155186 then
		warnCauterizeWounds:Show()
		specWarnCauterizeWounds:Show(args.sourceName)
	elseif spellId == 156937 then
		warnPryclasm:Show()
		specWarnPyroclasm:Show(args.sourceName)
	elseif spellId == 160379 then
		warnDefense:Show()
	elseif spellId == 155179 then
		warnRepair:Show()
		specWarnRepair:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155192 then
		warnBomb:Show(args.destName)
		if args:IsPlayer() then
			specWarnBomb:Show()
			timerBomb:Start()
		end
	elseif spellId == 158702 then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
		else
			specWarnFixateOther:Show(args.destName)
		end
	elseif spellId == 158345 and self:AntiSpam(10, 3) then--Might be SPELL_CAST_SUCCESS instead.
		warnShieldsDown:Show()
		specWarnShieldsDown:Show()
		timerShieldsDown:Start()
	elseif spellId == 155242 then
		local amount = args.amount or 1
		warnHeat:Show(args.destName, amount)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnHeat:Show()
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155242)) and not UnitIsDeadOrGhost("player") then
					specWarnHeatOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 155192 and args:IsPlayer() then
		timerBomb:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 156932 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnRupture:Show()
	elseif spellId == 155223 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnMelt:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

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
