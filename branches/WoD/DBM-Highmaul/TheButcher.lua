local mod	= DBM:NewMod(971, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(79538)
mod:SetEncounterID(1706)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 156152 156151",
	"SPELL_AURA_APPLIED_DOSE 156152 156151",
	"SPELL_AURA_REMOVED 156152",
	"SPELL_CAST_SUCCESS 156143",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnCleave					= mod:NewCountAnnounce(156157, 2, nil, false)
local warnBoundingCleave			= mod:NewSpellAnnounce(156160, 3)
local warnTenderizer				= mod:NewStackAnnounce(156151, 2, nil, mod:IsTank())
local warnCleaver					= mod:NewSpellAnnounce(156143, 3, nil, mod:IsTank())--Saberlash

local specWarnTenderizer			= mod:NewSpecialWarningStack(156151, nil, 2)
local specWarnTenderizerOther		= mod:NewSpecialWarningTaunt(156151)
local specWarnGushingWounds			= mod:NewSpecialWarningStack(156152, nil, 3)
local specWarnBoundingCleave		= mod:NewSpecialWarningSpell(156160, nil, nil, nil, 2)

local timerCleaveCD					= mod:NewCDTimer(6, 156157, nil, false)
local timerTenderizerCD				= mod:NewCDTimer(17, 156151, nil, mod:IsTank())
local timerCleaverCD				= mod:NewCDTimer(9, 156143, nil, mod:IsTank())
local timerGushingWounds			= mod:NewBuffFadesTimer(15, 156152)
local timerBoundingCleaveCD			= mod:NewNextTimer(60, 156160)

local berserkTimer					= mod:NewBerserkTimer(300)

mod.vb.cleaveCount = 0

function mod:OnCombatStart(delay)
	self.vb.cleaveCount = 0
	timerTenderizerCD:Start(6-delay)
	timerCleaveCD:Start(10-delay)--Verify this wasn't caused by cleave bug.
	timerCleaverCD:Start(12-delay)
	timerBoundingCleaveCD:Start(-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 156157 then
		self.vb.cleaveCount = self.vb.cleaveCount + 1
		warnCleave:Show(self.vb.cleaveCount)
		timerCleaveCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGushingWounds:Start()
		if amount > 2 then
			specWarnGushingWounds:Show(amount)
		end
	elseif spellId == 156151 then
		local amount = args.amount or 1
		warnTenderizer:Show(args.destName, amount)
		timerTenderizerCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnTenderizer:Show(amount)
			else
				if not UnitDebuff("player", GetSpellInfo(156151)) and not UnitIsDeadOrGhost("player") then
					specWarnTenderizerOther:Show(args.destName)
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 156152 and args:IsPlayer() then
		timerGushingWounds:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 156143 then
		warnCleaver:Show()
		timerCleaverCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156197 then
		self.vb.cleaveCount = 0
		timerCleaveCD:Cancel()
		warnBoundingCleave:Show()
		specWarnBoundingCleave:Show()
		timerCleaverCD:Start(22)
		timerBoundingCleaveCD:Start()
	end
end
