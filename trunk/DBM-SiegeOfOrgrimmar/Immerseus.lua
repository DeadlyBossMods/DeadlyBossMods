local mod	= DBM:NewMod(852, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(71543, 72436)--Doesn't die, will need kill detection
mod:SetReCombatTime(45)--Lets just assume he has same bug as tsulong in advance and avoid problems
--mod:SetQuestID(32744)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
--	"SPELL_CAST_SUCCESS",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
--	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Whole
local warnBreath			= mod:NewSpellAnnounce(143436, 3, nil, mod:IsTank() or mod:IsHealer())
local warnShaBolt			= mod:NewSpellAnnounce(143295, 3)
local warnSwirl				= mod:NewSpellAnnounce(143309, 3)
--Split

--Whole
local specWarnBreath		= mod:NewSpecialWarningSpell(143436, mod:IsTank())
--local specWarnShaBolt		= mod:NewSpecialWarningSpell(143295)
local specWarnSwirl			= mod:NewSpecialWarningSpell(143309, nil, nil, nil, 2)
--Split

--Whole
--local timerBreathCD			= mod:NewCDTimer(41, 143436)
--local timerShaBoltCD			= mod:NewCDTimer(41, 143295)
--local timerSwirlCD			= mod:NewCDTimer(41, 143309)
--Split
local timerShaResidue			= mod:NewBuffActiveTimer(10, 143459)
local timerPurifiedResidue		= mod:NewBuffActiveTimer(15, 143524)

function mod:OnCombatStart(delay)
--	timerBreathCD:Start(-delay)
end

function mod:OnCombatEnd()

end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143436 then
		warnBreath:Show()
		specWarnBreath:Show()
--		timerBreathCD:Start()
	elseif args.spellId == 143295 then
		warnShaBolt:Show()
--		specWarnShaBolt:Show()
--		timerShaBoltCD:Start()
	elseif args.spellId == 143309 then
		warnSwirl:Show()
		specWarnSwirl:Show()
--		timerSwirlCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Start()
	elseif args.spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143459 and args:IsPlayer() then
		timerShaResidue:Cancel()
	elseif args.spellId == 143524 and args:IsPlayer() then
		timerPurifiedResidue:Cancel()
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 137162 then
		timerStaticBurstCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 138006 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnElectrifiedWaters:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137175") then
		local target = DBM:GetFullNameByShortName(target)
		warnThrow:Show(target)
		timerStormCD:Start()
		self:Schedule(55.5, checkWaterStorm)--check before 5 sec.
		if target == UnitName("player") then
			specWarnThrow:Show()
		else
			specWarnThrowOther:Show(target)
		end
	end
end
--]]
