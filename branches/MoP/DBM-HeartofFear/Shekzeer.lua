local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(62837)--62847 Dissonance Field, 63591 Kor'thik Reaver, 63589 Set'thik Windblade
mod:SetModelID(42730)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_HEALTH"
)

local warnScreech				= mod:NewSpellAnnounce(123735, 3)
local warnCryOfTerror			= mod:NewTargetAnnounce(123788, 3, nil, mod:IsHealer())
local warnEyes					= mod:NewStackAnnounce(123707, 2, nil, mod:IsTank())
local warnSonicDischarge		= mod:NewSoonAnnounce(123504, 4)--Iffy reliability but better then nothing i suppose.
local warnRetreat				= mod:NewSpellAnnounce(125098, 4)
local warnAmberTrap				= mod:NewSpellAnnounce(125826, 3)--Trap ready
local warnTrapped				= mod:NewTargetAnnounce(125822, 1)--Trap used
local warnFixate				= mod:NewTargetAnnounce(125390, 3, nil, false)--Spammy
local warnAdvance				= mod:NewSpellAnnounce(125304, 4)

local specwarnSonicDischarge	= mod:NewSpecialWarningSpell(123504, nil, nil, nil, true)
local specWarnEyes				= mod:NewSpecialWarningStack(123707, mod:IsTank(), 4)
local specWarnEyesOther			= mod:NewSpecialWarningTarget(123707, mod:IsTank())
local specWarnRetreat			= mod:NewSpecialWarningSpell(125098)
local specwarnAmberTrap			= mod:NewSpecialWarningSpell(125826, false)
local specwarnFixate			= mod:NewSpecialWarningYou(125390, false)--Could be spammy, make optiona, will use info frame to display this more constructively
local specWarnAdvance			= mod:NewSpecialWarningSpell(125304)

local timerScreechCD			= mod:NewNextTimer(7, 123735)
local timerCryOfTerror			= mod:NewTargetTimer(20, 123788, nil, mod:IsHealer())
local timerCryOfTerrorCD		= mod:NewNextTimer(25, 123788, nil, mod:IsHealer())
local timerEyes					= mod:NewTargetTimer(30, 123707, nil, mod:IsTank())
local timerEyesCD				= mod:NewNextTimer(10, 123707, nil, mod:IsTank())
local timerPhase1				= mod:NewNextTimer(156.4, 125304)--156.4 til ENGAGE fires and boss is out, 157.4 until "advance" fires though. But 156.4 is more accurate timer
local timerPhase2				= mod:NewNextTimer(152, 125098)

mod:AddBoolOption("InfoFrame")--On by default because these do more then just melee, they interrupt spellcasting (bad for healers)

local sentLowHP = {}
local warnedLowHP = {}

function mod:OnCombatStart(delay)
	timerScreechCD:Start(-delay)
	timerEyesCD:Start(-delay)
	timerPhase2:Start(-delay)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123707) then
		warnEyes:Show(args.destName, args.amount or 1)
		timerEyes:Start(args.destName)
		timerEyesCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 4 then--MUSt get other tank to taunt at 4 stacks at latest
			specWarnEyes:Show(args.amount)
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(123735)) and not UnitIsDeadOrGhost("player") then--However, other tank can taunt at 3 stacks if their debuff clear
				specWarnEyesOther:Show(args.destName)
			end
		end
	elseif args:IsSpellID(123788) then
		warnCryOfTerror:Show(args.destName)
		timerCryOfTerror:Start(args.destName)
		timerCryOfTerrorCD:Start()
	elseif args:IsSpellID(125822) then
		warnTrapped:Show(args.destName)
	elseif args:IsSpellID(125390) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specwarnFixate:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123788) then
		timerCryOfTerror:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123735) then
		warnScreech:Show()
		timerScreechCD:Start()
	elseif args:IsSpellID(125826) then
		warnAmberTrap:Show()
		specwarnAmberTrap:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125098 and self:AntiSpam(2, 1) then
		timerScreech:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerEyesCD:Cancel()
		warnRetreat:Show()
		specWarnRetreat:Show()
		timerPhase1:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.PlayerDebuffs)
			DBM.InfoFrame:Show(10, "playerbaddebuff", 125390)
		end
	elseif spellId == 125304 and self:AntiSpam(2, 1) then
		timerPhase1:Cancel()--If you kill everything it should end early.
		warnAdvance:Show()
		specWarnAdvance:Show()
		timerPhase2:Start()--Assumed same as pull
		if self.Options.InfoFrame then--Will do this more accurately when i have an accurate count of mobs for all difficulties and then i can hide it when mobcount reaches 0
			DBM.InfoFrame:Hide()
		end
	end
end

--May not be that reliable, because they don't have a special unitID and there is little reason to target them.
--So it may miss some of them, not sure of any other way to PRE-warn though. Can warn on actual cast/damage but not too effective.
function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 62847 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.05 and not sentLowHP[guid] then
		sentLowHP[guid] = true
		self:SendSync("lowhealth", guid)
	end
end

function mod:OnSync(msg, guid)
	if msg == "lowhealth" and guid and not warnedLowHP[guid] then
		warnedLowHP[guid] = true
		warnSonicDischarge:Show()
		specwarnSonicDischarge:Show()
	end
end
