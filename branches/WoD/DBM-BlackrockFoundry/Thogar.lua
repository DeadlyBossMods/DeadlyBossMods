local mod	= DBM:NewMod(1147, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76906)--81315 Crack-Shot, 81197 Raider, 77487 Grom'kar Firemender, 80791 Grom'kar Man-at-Arms, 81318 Iron Gunnery Sergeant, 77560 Obliterator Cannon, 81612 Deforester
mod:SetEncounterID(1692)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155864 160140 163753",
	"SPELL_CAST_SUCCESS 156281",
	"SPELL_AURA_APPLIED 155921 159481",
	"SPELL_AURA_APPLIED_DOSE 155921",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_WHISPER"
)

--TODO, maybe range finder for when Man-at_arms is out (reckless Charge)
--TODO, train timers, as well as what mobs get off with each train. Probably require a lot of notepadding.
--TODO, see if http://beta.wowhead.com/spell=163750 has a target during cast and if there is enough time to avoid/react.
--Operator Thogar
local warnProtoGrenade				= mod:NewSpellAnnounce(155864, 3)
local warnEnkindle					= mod:NewStackAnnounce(155921, 2, nil, mod:IsTank())
local warnBerating					= mod:NewSpellAnnounce(156281, 3)
--Adds
local warnCauterizingBolt			= mod:NewSpellAnnounce(160140, 4)
local warnIronBellow				= mod:NewSpellAnnounce(163753, 3)
local warnDelayedSiegeBomb			= mod:NewTargetAnnounce(159481, 3)--Going with strong assumption debuff is not incombat log, so probably RAID_BOSS_WHISPER. Have debug to find out.

--Operator Thogar
--local specWarnProtoGrenade		= mod:NewSpecialWarningYou(155864)--If target scanning works
local specWarnEnkindle				= mod:NewSpecialWarningStack(155921, nil, 3)
local specWarnEnkindleOther			= mod:NewSpecialWarningTaunt(155921)
--Adds
local specWarnCauterizingBolt		= mod:NewSpecialWarningInterrupt(160140, not mod:IsHealer())
local specWarnIronbellow			= mod:NewSpecialWarningSpell(163753, nil, nil, nil, 2)
local specWarnDelayedSiegeBomb		= mod:NewSpecialWarningYou(159481, nil, nil, nil, 3)
local yellDelayedSiegeBomb			= mod:NewYell(159481)

--Operator Thogar
--local timerProtoGrenadeCD			= mod:NewNextTimer(30, 155864)
--local timerEnkindleCD				= mod:NewNextTimer(30, 155921, nil, mod:IsTank())
--local timerBeratingCD				= mod:NewNextTimer(30, 156281)
--Adds
--local timerCauterizingBoltCD		= mod:NewNextTimer(30, 160140)
--local timerIronbellowCD			= mod:NewNextTimer(30, 163753)


function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155864 then
		warnProtoGrenade:Show()
	elseif spellId == 160140 then
		warnCauterizingBolt:Show()
		specWarnCauterizingBolt:Show(args.sourceName)
	elseif spellId == 163753 then
		warnIronBellow:Show()
		specWarnIronbellow:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156281 then
		warnBerating:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155921 then
		local amount = args.amount or 1
		warnEnkindle:Show(args.destName, amount)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnEnkindle:Show()
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(155921)) and not UnitIsDeadOrGhost("player") then
					specWarnEnkindleOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 159481 then
		warnDelayedSiegeBomb:Show(args.destName)
		if args:IsPlayer() then
			specWarnDelayedSiegeBomb:Show()
			yellDelayedSiegeBomb:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 147068 then
	end
end

--Neither one of these show in combat log at all. What else is new
function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:159481") then
		specWarnDelayedSiegeBomb:Show()
		yellDelayedSiegeBomb:Yell()
		print("DBM Debug: if you see this message, tell DBM guys 159481 is RAID_BOSS_WHISPER")
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
