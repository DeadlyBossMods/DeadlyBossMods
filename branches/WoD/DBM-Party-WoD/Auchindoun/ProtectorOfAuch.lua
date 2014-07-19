local mod	= DBM:NewMod(1185, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(75839)--Soul Construct
mod:SetEncounterID(1686)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153002 153006",
	"SPELL_DAMAGE 161457",
	"SPELL_MISSED 161457"
)

local warnHolyShield			= mod:NewTargetAnnounce(153002, 3)--Verify target scanning, or switch to generic
local warnConsecratedLight		= mod:NewSpellAnnounce(153006, 4)

local specWarnConsecreatedLight	= mod:NewSpecialWarningSpell(153006, nil, nil, nil, 2)
local specWarnSanctifiedGround	= mod:NewSpecialWarningMove(161457)
local yellHolyShield			= mod:NewYell(153002)

local timerHolyShieldCD			= mod:NewNextTimer(47, 153002)

function mod:ShieldTarget(targetname, uId)
	if not targetname then return end
	warnHolyShield:Show(targetname)
	if targetname == UnitName("player") then
		yellHolyShield:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerHolyShieldCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153002 then
		self:BossTargetScanner(75839, "ShieldTarget", 0.02, 16)
		timerHolyShieldCD:Start()
	elseif spellId == 153006 then
		warnConsecratedLight:Show()
		specWarnConsecreatedLight:Show()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161457 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnSanctifiedGround:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
