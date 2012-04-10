local mod	= DBM:NewMod("LuiFlameheart", "DBM-Party-MoP", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(56732)
--mod:SetModelID(39487)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED"
)

--This fight has more abilities not implimented yet do to no combat log or emote/yell triggers at all
--Will likely need to transcribe this fight with transcriptor to complete this mod
--Probably only things worth adding would be Serpant wave and Jade Serpant wave
local warnDragonStrike			= mod:NewSpellAnnounce(120870, 2)
local warnJadeDragonStrike		= mod:NewSpellAnnounce(120873, 3)
local warnJadeFire				= mod:NewTargetAnnounce(107045, 4)

local specWarnJadeFire			= mod:NewSpecialWarningMove(107045)

local timerDragonStrikeCD		= mod:NewNextTimer(10.5, 120870)
local timerJadeDragonStrikeCD	= mod:NewNextTimer(10.5, 120873)
local timerJadeFireCD			= mod:NewNextTimer(3.5, 107045)

function mod:OnCombatStart(delay)
--	timerDragonStrikeCD:Start(-delay)--Unknown, tank pulled before i could start a log to get an accurate first timer.
end

function mod:JadeFireTarget()
	local targetname = self:GetBossTarget(56762)
	if not targetname then return end
	warnJadeFire:Show(targetname)
	if targetname == UnitName("player") and self:AntiSpam() then
		specWarnJadeFire:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(106823, 120870) then--Phase 1 dragonstrike
		warnDragonStrike:Show()
		timerDragonStrikeCD:Start()
	elseif args:IsSpellID(106841, 120873) then--phase 2 dragonstrike
		warnJadeDragonStrike:Show()
		timerJadeDragonStrikeCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(106797) then--Jade Essence removed, (Phase 3 trigger)
		warnPhase3:Show()
		timerJadeDragonStrikeCD:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106797) then--Jade Essence (Phase 2 trigger)
		warnJadeEssence:Show()
		timerDragonStrikeCD:Cancel()
	elseif args:IsSpellID(107045) then
		self:ScheduleMethod(0.1, "JadeFireTarget")--Assumed. Not entirely sure target scanning works with this. Hate default UI. WTB mods in beta.
		timerJadeFireCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 107110 or spellId == 120895) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnJadeFire:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 56762 then--Fight ends when Yu'lon dies.
		DBM:EndCombat(self)
	end
end
