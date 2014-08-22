local mod	= DBM:NewMod(971, "DBM-Highmaul", nil, 477)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(77404)
mod:SetEncounterID(1706)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 156152 156151 156598",
	"SPELL_AURA_APPLIED_DOSE 156152 156151",
	"SPELL_AURA_REMOVED 156152",
	"SPELL_CAST_SUCCESS 156143",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, LFR probably not 5 min, probably like 20 min :)
--TODO, See frenzies effect on power generation (Timers)
local warnCleave					= mod:NewCountAnnounce(156157, 2, nil, false)
local warnBoundingCleave			= mod:NewSpellAnnounce(156160, 3)
local warnTenderizer				= mod:NewStackAnnounce(156151, 2, nil, mod:IsTank())
local warnCleaver					= mod:NewSpellAnnounce(156143, 3, nil, mod:IsTank())--Saberlash
local warnFrenzy					= mod:NewTargetAnnounce(156598, 4)

local specWarnTenderizer			= mod:NewSpecialWarningStack(156151, nil, 2)
local specWarnTenderizerOther		= mod:NewSpecialWarningTaunt(156151)
local specWarnGushingWounds			= mod:NewSpecialWarningStack(156152, nil, 2)
local specWarnBoundingCleave		= mod:NewSpecialWarningSpell(156160, nil, nil, nil, 2)
local specWarnPaleVitriol			= mod:NewSpecialWarningMove(163046)--Mythic

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
	if self:IsMythic() then
		berserkTimer:Start(240-delay)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 163046",
			"SPELL_PERIODIC_MISSED 163046"
		)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
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
		if amount > 1 then
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
	elseif spellId == 156598 then
		warnFrenzy:Show(args.destName)
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

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 163046 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnPaleVitriol:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 156197 then
		self.vb.cleaveCount = 0
		timerCleaveCD:Cancel()
		warnBoundingCleave:Show()
		specWarnBoundingCleave:Show()
		timerCleaverCD:Start(22)
		timerBoundingCleaveCD:Start()
		timerTenderizerCD:Start(16)
	end
end
