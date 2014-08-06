local mod	= DBM:NewMod(1162, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77692)
mod:SetEncounterID(1713)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 157060 157054 156704 157592 158215",
	"SPELL_CAST_SUCCESS 161839 158130 170469",
	"SPELL_AURA_APPLIED 156766",
	"SPELL_AURA_APPLIED_DOSE 156766"
)

--Figure out how Reverberations (http://beta.wowhead.com/spell=157247) work.
--Figure out why Slam is "tank" only in dungeon journal. Seems like it'd affect all melee. Also, can tanks avoid it?
--Figure out how Rune of Crushing Earth works (and verify spellid)
local warnGraspingEarth				= mod:NewSpellAnnounce(157060, 3)
local warnThunderingBlows			= mod:NewSpellAnnounce(157054, 4)
local warnRipplingSmash				= mod:NewSpellAnnounce(157592, 3)
local warnCrushingEarth				= mod:NewSpellAnnounce(161839, 3)
local warnStoneGeyser				= mod:NewSpellAnnounce(158130, 2)
local warnCalloftheMountain			= mod:NewSpellAnnounce(158217, 3)
local warnSlam						= mod:NewCastAnnounce(156704, 4, nil, nil, mod:IsTank())
local warnWarpedArmor				= mod:NewStackAnnounce(156766, 2, nil, mod:IsTank())

local specWarnGraspingEarth			= mod:NewSpecialWarningSpell(157060)
local specWarnThunderingBlows		= mod:NewSpecialWarningSpell(157054, nil, nil, nil, 3)
local specWarnRipplingSmash			= mod:NewSpecialWarningSpell(157592, nil, nil, nil, 2)
local specWarnCrushingEarth			= mod:NewSpecialWarningSpell(161839, nil, nil, nil, 2)
local specWarnSlam					= mod:NewSpecialWarningSpell(156704, mod:IsTank())
local specWarnWarpedArmor			= mod:NewSpecialWarningStack(156766, nil, 3)--stack bugged right now, requires tanks going to 5 stacks before they can clear. Blizz will likely fix this because 5 too much
local specWarnWarpedArmorOther		= mod:NewSpecialWarningTaunt(156766)

--local timerGraspingEarthCD		= mod:NewNextTimer(30, 157060)
--local timerThunderingBlowsD		= mod:NewNextTimer(30, 157054)
--local timerCrushingEarthCD		= mod:NewNextTimer(30, 161839)
--local timerStoneGeyserCD			= mod:NewNextTimer(30, 158130)
--local timerSlamCD					= mod:NewNextTimer(30, 156704, nil, mod:IsTank())
--local timerWarpedArmorD			= mod:NewNextTimer(30, 156704, nil, mod:IsTank())

local berserkTimer					= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 157060 then
		warnGraspingEarth:Show()
		specWarnGraspingEarth:Show()
	elseif spellId == 157054 then
		warnThunderingBlows:Show()
		specWarnThunderingBlows:Show()
	elseif spellId == 157592 then
		warnRipplingSmash:Show()
		specWarnRipplingSmash:Show()
	elseif spellId == 156704 then
		warnSlam:Show()
		specWarnSlam:Show()
	elseif spellId == 158215 then--Probably not in combat log, it's scripted. Probably needs a UNIT_SPELLCAST event
		warnCalloftheMountain:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 161839 then
		warnCrushingEarth:Show()
		specWarnCrushingEarth:Show()
	elseif spellId == 158130 or spellId == 170469 then--Are both used? eliminate one that isn't if not
		warnStoneGeyser:Show()
		--Does it need a special warning?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156766 then
		local amount = args.amount or 1
		warnWarpedArmor:Show(args.destName, amount)
		if amount >= 3 then
			if args:IsPlayer() then
				specWarnWarpedArmor:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(156766)) and not UnitIsDeadOrGhost("player") then
					specWarnWarpedArmorOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
