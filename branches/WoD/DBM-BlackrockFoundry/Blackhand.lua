local mod	= DBM:NewMod(959, "DBM-BlackrockFoundry", nil, 457)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(87420)--VERIFY, multiple IDs
mod:SetEncounterID(1704)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 155992 159142 156530 156728 156928 158054",
	"SPELL_CAST_SUCCESS 156425 156030 156999",
	"SPELL_AURA_APPLIED 156096 157000",
	"SPELL_AURA_REMOVED 156096 157000"
)

--General
--TODO, Get scripted triggers for phase transitions
--TODO, figure out how many of these don't show in combat log.
--Phase 2
--TODO, find spawn trigger for Siegemaker to give warning/timer
--TODO, get damage ID for fire on ground created by Mortar
--TODO, figure out how many stacks of Blackiron Plating vehicles spawn with and add stacks remaining warnings for tracking progress.
--TODO, figure out if the dang vehicles are kited or tanked. IF tanked, add warning for Battering Ram.
--TODO, figure out if range frame is needed for Explosive Round. Also figure out if target scanning works to find round target.
--Phase 3
--TODO, Verify everything works.
--TODO, figure out what you aim the impaling throw at
--Stage One: The Blackrock Forge
local warnDemolition				= mod:NewSpellAnnounce(156425, 3)--Probably doesn't show in combat log. Assume it has a UNIT_SPELLCAST_SUCCEEDED event.
local warnMarkedforDeath			= mod:NewTargetAnnounce(156096, 4)--If not in combat log, find a RAID_BOSS_WHISPER event.
local warnThrowSlagBombs			= mod:NewSpellAnnounce(156030, 3)--Probably doesn't show in combat log. Assume it has a UNIT_SPELLCAST_SUCCEEDED event.
local warnShatteringSmash			= mod:NewSpellAnnounce(155992, 3)
--Stage Two: Storage Warehouse
local warnMortar					= mod:NewSpellAnnounce(156530, 3)
local warnExplosiveRound			= mod:NewCastAnnounce(156728, 3)--Spammy?
--Stage Three: Iron Crucible
local warnSlagEruption				= mod:NewSpellAnnounce(156928, 3)
local warnAttachSlagBombs			= mod:NewTargetAnnounce(157000, 4)
local warnMassiveShatteringSmash	= mod:NewTargetAnnounce(158054, 3)

--Stage One: The Blackrock Forge
local specWarnDemolition			= mod:NewSpecialWarningSpell(156425, nil, nil, nil, 2)
local specWarnMarkedforDeath		= mod:NewSpecialWarningYou(156096, nil, nil, nil, 3)
local yellMarkedforDeath			= mod:NewYell(156096)
local specWarnThrowSlagBombs		= mod:NewSpecialWarningSpell(156030, nil, nil, nil, 2)
local specWarnShatteringSmash		= mod:NewSpecialWarningSpell(155992, mod:IsMelee())
--Stage Two: Storage Warehouse
--Stage Three: Iron Crucible
local specWarnSlagEruption			= mod:NewSpecialWarningSpell(156928, nil, nil, nil, 2)
local specWarnAttachSlagBombs		= mod:NewSpecialWarningYou(157000)--May change to sound 3, but I don't want it confused with the even more threatening marked for death, so for now will try 1
local yellAttachSlagBombs			= mod:NewYell(157000, nil, false)
local specWarnMassiveShatteringSmash= mod:NewSpecialWarningSpell(158054, nil, nil, nil, 2)

--Stage One: The Blackrock Forge
--local timerCrushersCallCD			= mod:NewNextTimer(30, 156425)
--local timerMarkedforDeathCD		= mod:NewNextTimer(30, 156096)
--local timerThrowSlagBombsCD		= mod:NewNextTimer(30, 156030)
--local timerShatteringSmashCD		= mod:NewNextTimer(30, 155992)
local timerImpalingThrow			= mod:NewCastTimer(5, 156111)--How long marked target has to aim throw at Debris Pile or Siegemaker
--Stage Two: Storage Warehouse
--Stage Three: Iron Crucible
--local timerSlagEruptionCD			= mod:NewNextTimer(30, 156928)
--local timerAttachSlagBombsCD		= mod:NewNextTimer(30, 157000)
local timerSlagBomb					= mod:NewCastTimer(5, 157015)
--local timerMassiveShatteringSmashCD	= mod:NewNextTimer(30, 158054)


function mod:OnCombatStart(delay)

end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 155992 or spellId == 159142 then--Phase 1 and then phase 2 version. They don't really need two diff warnings, complicated anyways since auto generated with same spellname is wonky
		warnShatteringSmash:Show()
		specWarnShatteringSmash:Show()
	elseif spellId == 156530 then
		warnMortar:Show()
	elseif spellId == 156728 then
		warnExplosiveRound:Show()
	elseif spellId == 156928 then
		warnSlagEruption:Show()
		specWarnSlagEruption:Show()
	elseif spellId == 158054 then
		warnMassiveShatteringSmash:Show()
		specWarnMassiveShatteringSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156425 then
		warnDemolition:Show()
		specWarnDemolition:Show()
	elseif spellId == 156030 or spellId == 156999 then--Phase 1 and then phase 2 version
		warnThrowSlagBombs:Show()
		specWarnThrowSlagBombs:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156096 then
		warnMarkedforDeath:Show(args.destName)
		timerImpalingThrow:Start()
		if args:IsPlayer() then
			specWarnMarkedforDeath:Show()
			yellMarkedforDeath:Yell()
		end
	elseif spellId == 157000 then
		warnAttachSlagBombs:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnAttachSlagBombs:Show()
			yellAttachSlagBombs:Yell()
			timerSlagBomb:Start()
		end
	end
end


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156096 and args:IsPlayer() then
		timerImpalingThrow:Cancel()
	elseif spellId == 157000 and args:IsPlayer() then
		timerSlagBomb:Cancel()
	end
end

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156425 then
		warnDemolition:Show()
		specWarnDemolition:Show()
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
