local mod	= DBM:NewMod(665, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(59153)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE"
)


local warnBoneSpike		= mod:NewTargetAnnounce(113999, 3)

local specWarnGetBoned	= mod:NewSpecialWarning("SpecWarnGetBoned")
local specWarnSoulFlame	= mod:NewSpecialWarningMove(114009)--Not really sure what the point of this is yet. It's stupid easy to avoid and seems to serve no fight purpose yet, besides maybe cover some of the bone's you need for buff.
local specWarnRusting	= mod:NewSpecialWarningStack(113765, mod:IsTank(), 5)

local timerBoneSpikeCD	= mod:NewNextTimer(8, 113999)
local timerRusting		= mod:NewBuffActiveTimer(15, 113765, nil, mod:IsTank())

mod:AddBoolOption("InfoFrame")

local boned = GetSpellInfo(113996)

function mod:BoneSpikeTarget()
	local targetname = self:GetBossTarget(59153)
	if not targetname then return end
	warnBoneSpike:Show(targetname)
end

function mod:OnCombatStart(delay)
	timerBoneSpikeCD:Start(6.5-delay)
	if not UnitDebuff("player", boned) then
		specWarnGetBoned:Show()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.PlayerDebuffs)
		DBM.InfoFrame:Show(5, "playergooddebuff", 113996)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 113765 then
		timerRusting:Start()
		if (args.amount or 0) >= 5 and self:AntiSpam(1, 3) then
			specWarnRusting:Show(args.amount)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 113996 and args:IsPlayer() then
		specWarnGetBoned:Show()
	elseif args.spellId == 113765 then
		timerRusting:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 113999 then
		self:ScheduleMethod(0.1, "BoneSpikeTarget")
		timerBoneSpikeCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if (spellId == 114009 or spellId == 115365) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnSoulFlame:Show()
	end
end
