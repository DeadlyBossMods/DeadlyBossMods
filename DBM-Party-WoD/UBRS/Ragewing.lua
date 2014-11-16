local mod	= DBM:NewMod(1229, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(76585)
mod:SetEncounterID(1760)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 155620 167203",
	"SPELL_AURA_APPLIED_DOSE 155620",
	"SPELL_AURA_REMOVED 167203",
	"SPELL_DAMAGE 155051",
	"SPELL_MISSED 155051",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnBurningRage		= mod:NewStackAnnounce(155620, 3, nil, mod:CanRemoveEnrage() or mod:IsTank())
local warnEngulfingFire		= mod:NewSpellAnnounce(154996, 4)
local warnSwirlingWinds		= mod:NewSpellAnnounce(167203, 2)

local specWarnBurningRage	= mod:NewSpecialWarningDispel(155620, mod:CanRemoveEnrage())
local specWarnMagmaSpit		= mod:NewSpecialWarningMove(155051)
local specWarnEngulfingFire	= mod:NewSpecialWarningSpell(154996, nil, nil, nil, 3)

local timerEngulfingFireCD	= mod:NewCDTimer(22, 154996)
local timerSwirlingWinds	= mod:NewBuffActiveTimer(20, 167203)

mod.vb.firstBreath = false

function mod:OnCombatStart(delay)
	timerEngulfingFireCD:Start(13-delay)--Needs more data
	self.vb.firstBreath = false
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 155620 then
		warnBurningRage:Show(args.destName, args.amount or 1)
		specWarnBurningRage:Show(args.destName)
	elseif spellId == 167203 then
		warnSwirlingWinds:Show()
		timerSwirlingWinds:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 167203 then
		self.vb.firstBreath = false
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 155051 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then--Goriona's Void zones
		specWarnMagmaSpit:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--This boss actually does fire IEEU so boss1 works
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 154996 then
		warnEngulfingFire:Show()
		specWarnEngulfingFire:Show()
		if not self.vb.firstBreath then
			self.vb.firstBreath = true
			timerEngulfingFireCD:Start()
		end
	end
end
