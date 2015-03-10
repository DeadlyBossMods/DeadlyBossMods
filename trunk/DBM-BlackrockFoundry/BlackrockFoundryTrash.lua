local mod	= DBM:NewMod("BlackrockFoundryTrash", "DBM-BlackrockFoundry")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11326 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 156446 163194",
	"SPELL_AURA_APPLIED 175583 175594 175765 175993 177855",
	"SPELL_AURA_APPLIED_DOSE 175594",
	"RAID_BOSS_WHISPER"
)

local warnLivingBlaze				= mod:NewTargetAnnounce(159632, 3, nil, false)
local warnEmberInWind				= mod:NewTargetAnnounce(177855, 3, nil, false)

local specWarnOverheadSmash			= mod:NewSpecialWarningTaunt(175765)
local specWarnBlastWave				= mod:NewSpecialWarningMoveTo(156446, nil, DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(156446))
local specWarnInsatiableHunger		= mod:NewSpecialWarningRun(159632, nil, nil, nil, 4)
local specWarnLumberingStrength		= mod:NewSpecialWarningRun(175993, nil, nil, nil, 4)
local specWarnLivingBlaze			= mod:NewSpecialWarningMoveAway(175583)
local yellLivingBlaze				= mod:NewYell(175583)
local specWarnEmberInWind			= mod:NewSpecialWarningMoveAway(177855)
local specWarnFinalFlame			= mod:NewSpecialWarningDodge(163194, "MeleeDps")
local specWarnBurning				= mod:NewSpecialWarningStack(175594, nil, 8)
local specWarnBurningOther			= mod:NewSpecialWarningTaunt(175594, nil, nil, nil, nil, nil, 2)

local voiceBurning					= mod:NewVoice(155242) --changemt

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local volcanicBomb = GetSpellInfo(156413)

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 156446 then
		specWarnBlastWave:Show(volcanicBomb)
	elseif spellId == 163194 then
		specWarnFinalFlame:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175583 then
		warnLivingBlaze:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnLivingBlaze:Show()
			if not self:IsLFR() then
				yellLivingBlaze:Yell()
			end
		end
	elseif spellId == 177855 then
		warnEmberInWind:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnEmberInWind:Show()
		end
	elseif spellId == 175594 then
		local amount = args.amount or 1
		if (amount >= 8) and (amount % 3 == 0) then
			voiceBurning:Play("changemt")
			if args:IsPlayer() then
				specWarnBurning:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(175594)) and not UnitIsDeadOrGhost("player") then
					specWarnBurningOther:Show(args.destName)
				end
			end
		end
	elseif spellId == 175765 and not args:IsPlayer() then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			specWarnOverheadSmash:Show(args.destName)
		end
	elseif spellId == 175993 then
		local target = self:GetBossTarget(args.destGUID)
		if target and target == UnitName("player") then
			specWarnLumberingStrength:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:RAID_BOSS_WHISPER(msg)
	if not self.Options.Enabled then return end
	if msg:find("spell:159632") then
		specWarnInsatiableHunger:Show()
	end
end
